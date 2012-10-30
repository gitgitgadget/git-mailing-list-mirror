From: shawn wilson <ag4ve.us@gmail.com>
Subject: change symlink
Date: Tue, 30 Oct 2012 21:07:07 +0000
Message-ID: <CAH_OBie-irmpBrJG6KB3W8bgYjQdyVYiUR-SvJPnx1FXUya0uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 22:07:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJ2E-0004xt-CF
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934566Ab2J3VHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 17:07:30 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:37746 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934561Ab2J3VH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:07:29 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so564949lag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 14:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=JNyQ3DtFKA8sEffVglgesjKjmV9nY69l9utqTFXGhNg=;
        b=TXKIcNhqKVXFi7q3kGmZNDDZSzsMJ0F6l2k25KAloVphpRffrS3IcYWgZwxADOi2ff
         GK1yx4ljUTwjQ+Gnjn+wmpujqu09FUyx8sGEH2ckt0dwfvIxJnXet2YBZYGloDVmKBoW
         FSvlXLn6ojZUyHmZghBADH4ay8URdYOFCgSqGmyVtNwwNXc56ACVVPvZ7+DPgmflRW1u
         Z+jlWF4V7GQiSe5s/iLF8IjDSrsGOLRaaLseis9uywBMNykXWprPqPpPATpBIjD+8Ogh
         Bq2LsfndDsNAs9zuDj3Or1OVn/jNWiy/1kvtmeU1BOwTZ4Gu0NjP01KkBllNjvPhnB69
         5sJQ==
Received: by 10.112.103.135 with SMTP id fw7mr13680532lbb.16.1351631247778;
 Tue, 30 Oct 2012 14:07:27 -0700 (PDT)
Received: by 10.114.63.42 with HTTP; Tue, 30 Oct 2012 14:07:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208736>

i'm curious why this is being reported as deleted in status and diff
and not modified? this was tested on a build of the master branch of
the current git repo (1.8.0).

mkdir t cd t; git --init

touch test
git add test
git commit test -m "test"

ln -s test t2
git add t2
git commit t2 -m "symlink"

rm t2
mkdir -p t2/one
ln -s test t2/one/test

this then shows up as:

 % git status
# On branch master
# Changes not staged for commit:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       deleted:    t2
#
no changes added to commit (use "git add" and/or "git commit -a")
 % git --no-pager diff
diff --git a/t2 b/t2
deleted file mode 120000
index 30d74d2..0000000
--- a/t2
+++ /dev/null
@@ -1 +0,0 @@
-test
\\ No newline at end of file
