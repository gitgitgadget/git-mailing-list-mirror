From: Adrian Cornish <git@bluedreamer.com>
Subject: git clean is not removing a submodule added to a branch when
 switching branches
Date: Sat, 18 Feb 2012 14:27:42 -0700
Message-ID: <CAGc=MuDrE_1CVzOsqcodhadcfajaa-BHjHVAp9mFDNbU=wVQqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 22:27:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ryros-0003uA-Gx
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 22:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab2BRV1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 16:27:44 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:61992 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab2BRV1n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 16:27:43 -0500
Received: by wics10 with SMTP id s10so2215048wic.19
        for <git@vger.kernel.org>; Sat, 18 Feb 2012 13:27:42 -0800 (PST)
Received-SPF: pass (google.com: domain of adriancornish73@gmail.com designates 10.180.14.73 as permitted sender) client-ip=10.180.14.73;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of adriancornish73@gmail.com designates 10.180.14.73 as permitted sender) smtp.mail=adriancornish73@gmail.com; dkim=pass header.i=adriancornish73@gmail.com
Received: from mr.google.com ([10.180.14.73])
        by 10.180.14.73 with SMTP id n9mr6064335wic.16.1329600462619 (num_hops = 1);
        Sat, 18 Feb 2012 13:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=S4SI1PZrHgrWgpBEmhRMhVL3u/NJiMkCNXmFr6rO5M4=;
        b=q2uiZGkTXM/gT12XmRE3i+PYzhlOhbsV2UHH57UYqIAxPSRYhCty9kISEwUVBVZt79
         kaz8o7qudmv/XpY9zfpOxC4Zx22ypow+G9qUNuMVGXwDz8tRBDCXEZyslS2oorxNCmaH
         bBgMt2wLnzbEgxwQTdWNf0FC5OeTPpDJ5clto=
Received: by 10.180.14.73 with SMTP id n9mr5096371wic.16.1329600462557; Sat,
 18 Feb 2012 13:27:42 -0800 (PST)
Received: by 10.216.229.165 with HTTP; Sat, 18 Feb 2012 13:27:42 -0800 (PST)
X-Google-Sender-Auth: m1a2a0o7LtExU8927Xn-g2DdZuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191013>

If I add a submodule to a branch and then switch branches, git
checkout warns it cannot
remove the submodule. If I then issue a git clean - it says it removes
the submodule but
in fact does nothing at all. Is this a bug or expected behaviour.

TIA

Adrian

Below are cut&paste steps to reproduce.

git --version
#git version 1.7.8.4

git init submod
cd submod
echo "This is a submodule" > README.txt
git add .
git commit -m "Initial commit"
cd ..
git init prog
cd prog
echo "This is a program" > README.txt
git add .
git commit -a -m "Initial commit"
git checkout -b topic1
git submodule add ../submod
git commit -m "Added submodule"

git checkout master
#warning: unable to rmdir submod: Directory not empty
#Switched to branch 'master'

git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       submod/
#nothing added to commit but untracked files present (use "git add" to track)

git clean -fd
#Removing submod/

git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       submod/
#nothing added to commit but untracked files present (use "git add" to track)
