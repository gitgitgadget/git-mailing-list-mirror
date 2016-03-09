From: Carl Fink <cafink@gmail.com>
Subject: Bug report: can't use git add with --patch option in "_" directory
Date: Wed, 9 Mar 2016 09:48:28 -0600
Message-ID: <CAHQDUVeqzKoxd=Us2KagXmcutpos737+Z6ZSiV4Z70LKrn4LcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 16:48:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adgLi-0005e5-3R
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 16:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbcCIPs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 10:48:29 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:34247 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbcCIPs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 10:48:29 -0500
Received: by mail-io0-f177.google.com with SMTP id m184so70668312iof.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 07:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=Nk2tW54ZZpjmbCrgSrX+yp34Veqee7EzCQ7PeBKzZ5s=;
        b=HhOzvQBuzlzOLYU1KbTNqGMsUNeNmbvdc65qut1auxFg8ns91ocDYoA1eiPD0e0XMX
         8yRmFVJRBzhq2XoGLjIR00yVgSa5H8yZPxcJ4qFBqcgrtNL+QEUFJ8zGtHToB+Z80SPs
         5cewsqT6RGUZziArBPVM+Usn7T0Kja4Qvm6aWI2Fi0jNahJ0dY2ypaz6toVGxvAzjYYY
         gStzyATJ715oBJpP/I5EaI3sFqx2n62Y21zHdrsjNPBhtisspXrUmLG9oxUPUkFlx/Z3
         J96QyZWK424yFL/xuiCq8oQOO3fpCsuDv2rmV8nR0gwgGuxFGUsPJrivDNvXUC+Fwpsd
         1FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Nk2tW54ZZpjmbCrgSrX+yp34Veqee7EzCQ7PeBKzZ5s=;
        b=bhvcUp0H9G95zKwRzMCiPW4gSwQ+vsW8sa39UcGUrWjCHvUDhfK5PQaaW9433TFrkv
         sNDx1HknbNYnpZ4eyTShf9XbA98XAevdkqGCnScYZ1ecKEPUtybf6R9cVw4yMF6lbQXp
         TIs8T5z4lvtg9c1TcmcRz1bmb+4pO02cVS1fACi10270s0WyLYDy+oqwb7J2nTc+ljP3
         I4kbQ9GPsEwhB1Plgb5KR9ChpnRjFbCwGuvjhk+xnxVRv6yoiyipPf/s1yzdSpESxPet
         PGNbAGLJGC5wQWVMgTvw0JJV+KCUIiDxov08jwCwWJEUUbecRIE+5BTpz2lIRQB0mFJf
         1ddg==
X-Gm-Message-State: AD7BkJJ4zEVQwbcwA6wR2XK6wHiUT1IU5PV3ADsZR9pksAW7VSBoc2kfzQngTOhhMv5/JeXHg4/bcmUthh1YQw==
X-Received: by 10.107.36.80 with SMTP id k77mr33763031iok.121.1457538508494;
 Wed, 09 Mar 2016 07:48:28 -0800 (PST)
Received: by 10.64.11.202 with HTTP; Wed, 9 Mar 2016 07:48:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288486>

I recently installed Git version 2.7.2.windows.1 (I am running Windows
7 64-bit).  Since the update, I have been unable to run `git add` with
the `-p` option on files within a certain directory (or its
subdirectories) whose name is `_` (an underscore).

`git status` correctly reports that my file has changes:

    PS C:\Users\Carl\www\dl> git status
    On branch develop
    Your branch is up-to-date with 'origin/develop'.
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working directory)

            modified:   _/php/class.Menu.php

And I can add the entire file with a simple `git add`, or by
specifying the file by name.  But if I try to include the `-p` or
`--patch` option (both variations produce the same results), Git
reports that there are no changes:

    PS C:\Users\Carl\www\dl> git add -p .\_\php\class.Menu.php
    No changes.

This only happens for files within the `_` directory, but it doesn't
matter whether I `cd` into that directory to run the `git add` command
without having to explicitly specify a path with an underscore in it;
it still doesn't work:

    PS C:\Users\Carl\www\dl\_\php> git add -p .\class.Menu.php
    No changes.

I also tried various directory names with underscores in them.  This
issue occurs consistently if the updated file is in directory whose
name contains only underscores (or in a subdirectory of such a
directory), but not if there are other characters in the directory
name.  I believe underscores are valid in file/directory names.
Additionally, I am not the owner of the project so I cannot rename the
directory or move the file.  My collaborators mostly use OSX and do
not have this issue with their versions of Git.

As I normally use Git Bash, I had initially thought this problem was
related to Posix path conversion in MinGW, but it occurs whether I use
Git Bash, Windows PowerShell, or cmd.exe.
