From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [ITCH] Mixed-case aliases
Date: Mon, 22 Apr 2013 14:51:29 +0530
Message-ID: <CALkWK0m889R_3yHw=mbptw-vHc6jf49Az+zd+3rEoW_iouH1HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 11:22:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUCwy-0001Vj-85
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 11:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400Ab3DVJWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 05:22:12 -0400
Received: from mail-bk0-f53.google.com ([209.85.214.53]:37048 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab3DVJWL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 05:22:11 -0400
Received: by mail-bk0-f53.google.com with SMTP id jg9so129181bkc.40
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=EWVVx7wf4yGbUqJjWUU1wy2Wm/3hydn3dUNnDPejs40=;
        b=afmTPOCudpVUR0oXnbMZ6z8XQOWpTgQLXnPuULHK5vRL7aw1hEh9uIGPLFBWhNBjZF
         GPdL9vX0pRf7q6Ythy846KMYtc/7URna0RfV4wT2TqOwYAR7masBMJERRVnzo9Jwacyc
         YkTzp1mGMGPuIC8gGA9AX0MslAxxvjd95z2qfu17MtbooT6q/9TGWuOi7tI/Ixry0Erq
         NgXEMaZsi7KeccLjxlcvGQDlsmXR2jrfr5KTIPHVD9YOr4ADs5O+oik56+DuYdPQRUZx
         eZxgkoGufU0UOUlOR9AsDWuErx+JEt6PefBmIMz/+9JP+Dqpv1+pur1XTOXxWJc11O1M
         GMWA==
X-Received: by 10.205.41.72 with SMTP id tt8mr10499859bkb.9.1366622529859;
 Mon, 22 Apr 2013 02:22:09 -0700 (PDT)
Received: by 10.204.130.83 with HTTP; Mon, 22 Apr 2013 02:21:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221999>

Hi,

My .gitconfig has aliases like the following:

[alias]
	bD = branch -D
	bM = branch -M

Unfortunately, since the current config-parsing code unconditionally
runs tolower() on all keys, these aliases don't work.  My proposal is
to modify alias.c::alias_lookup() to call a
git_config_DONTMANGLECASE() variant, and modify the various functions
in config.c appropriately.

On a related note, it might be useful to warn the user that we are an
ignoring alias.<builtin-name> key when executing the corresponding
builtin.  It's not really my itch, but I suspect a lot of beginners
get tripped up by this.

What do you think?

Ram
