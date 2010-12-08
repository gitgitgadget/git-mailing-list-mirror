From: Kevin Ballard <kevin@sb.org>
Subject: [BUG] git-add doesn't apply filepatterns to tracked files
Date: Wed, 8 Dec 2010 15:01:57 -0800
Message-ID: <47FCD78C-5D8C-4FA5-88DC-26FDCC7361AD@sb.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 09 00:02:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQT1T-0007uH-He
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 00:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637Ab0LHXCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 18:02:01 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54121 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548Ab0LHXCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 18:02:00 -0500
Received: by pwj3 with SMTP id 3so391360pwj.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 15:02:00 -0800 (PST)
Received: by 10.142.60.13 with SMTP id i13mr3294528wfa.322.1291849319914;
        Wed, 08 Dec 2010 15:01:59 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w22sm1495170wfd.7.2010.12.08.15.01.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 15:01:59 -0800 (PST)
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163240>

Ran across a rather bizarre bug today while trying to help someone in #git.
It seems that git-add doesn't match filepatterns against tracked files,
only against untracked files. Other tested commands (such as git-rm and
git-ls-files) are happy to match tracked files, but not git-add.

% git --version
git version 1.7.3.3.576.gd872
% ls -a
./       ../      .git/    bar.txt  foo.txt
% git status --short
 M foo.txt
?? bar.txt
% git add '*.txt'
% git status --short
A  bar.txt
 M foo.txt

There are no .gitignores in play here.

I haven't had time to investigate the source yet, as I'm still at work.

-Kevin Ballard
