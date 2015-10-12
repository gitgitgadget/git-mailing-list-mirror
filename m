From: Aleksey Komarov <leeeeha@gmail.com>
Subject: submodule: allow submodule directory in gitignore
Date: Mon, 12 Oct 2015 13:30:10 +0700
Message-ID: <561B5372.7040508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 08:33:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlWg4-0002yd-0q
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 08:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbbJLGdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 02:33:11 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36441 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbJLGdK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 02:33:10 -0400
Received: by lbcao8 with SMTP id ao8so132896864lbc.3
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 23:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=O6bKoL3j6TcfG8/OdUeej0QEkTHnRQfvRNAiDh6Hm9Q=;
        b=T6JF2Lj1Hpas4WYAQ3FnKQvPG2hky3kvDGRE6NKDLXIxpyRuF2FqCKCrS1hIoSM/Fv
         pXpFGtLH3b4csO5ipJdFHd3xEyFTYFq/7tKU0FC5wIvYkHHGuioleRQ2G+3S52ePCu8v
         KCEkgvjypFh9RvKxcphUefRnewao+NZmp+r83c2MPOTIdmt1ZYWklPnfFI2+7brThY3R
         BNAKhtc2HEJ0FEujC061F/O7NjxTvjXhRmy/fHbFY7BY7iQOeiZukTYeqO1trIPNq+Vu
         sbp0K1pV2DPpLkLJ3B3dgsl2tkbV66iOITfjbuu4SYJ4p/A0C7YWxJY4eXSJMGyZKA8E
         Rytg==
X-Received: by 10.25.39.143 with SMTP id n137mr938340lfn.71.1444631588483;
        Sun, 11 Oct 2015 23:33:08 -0700 (PDT)
Received: from [127.0.0.1] ([62.213.32.124])
        by smtp.gmail.com with ESMTPSA id z204sm2641126lfd.1.2015.10.11.23.33.06
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2015 23:33:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279361>

Hi all!

I'm sorry if the letter came twice. I have troubles with my post client.

I want to organize my repository so its submodules would be located at the root
of repository. I'm trying to create .gitignore to ignore all files and don't
ignore directories at the same time:

$ cat .gitignore
*
!*/

Now, I'm trying to add a submodule to my repository, but fail to understand why
my .gitignore prevents it from being added. I use the following command to check
if my submodule will be ignored or not:

$ git add --dry-run --ignore-missing c/

I have noticed that result of this check is different when directory c/ already
exists and when it still doesn't by the time of the check.
The described behavior is illustrated by the following example:

$ mkdir git_test
$ cd git_test
$ git init
Initialized empty Git repository in D:/temp/git_test/.git/
$ echo \* >> .gitignore
$ echo \!\*\/ >> .gitignore
$ git add --dry-run --ignore-missing c/
The following paths are ignored by one of your .gitignore files:
c/
Use -f if you really want to add them.
$ mkdir c
$ git add --dry-run --ignore-missing c/
$

Is this behavior expected? If yes, where can I read about it? Which part of the
Git documentation should I consult?
How should I correct my .gitignore to pass this check in both cases, when
directory c/ exists and when it doesn't?
