From: Raymond Piller <ray@vertigion.com>
Subject: Windows Git pre-commit check file signature
Date: Tue, 25 Mar 2014 14:37:36 -0500
Message-ID: <CAJymQJz=Tu5cAJYUw3fxOyMkn4v-m_91NhcZ9BjjHz2CX9xnyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jacob Rhoads <rhoadsjacob@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 20:43:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSXFi-0006wd-12
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 20:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204AbaCYTnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 15:43:08 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:60121 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbaCYTnH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 15:43:07 -0400
Received: by mail-qg0-f46.google.com with SMTP id e89so2445276qgf.5
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 12:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=0q4LG/UO+q2okU24AujUm2fqd4a6w9lcHVIKceNzIO0=;
        b=EU7LyINpyxhHOW5mo6KDUcnjcY+4+dga5ANiEC1E6L5CPSGFjOsntCpGWQN7O3QZ2o
         lcU56yCKIPtg8H8yNmw3UAIOVrE7MOuC2VByKVktJJiS8GFfk2Jbh3ip2X5acUIL/qvg
         aQXxIWJtCAFeBlahz7PefL8MD8cOl7r00Moi/Omv1apjqAvOaJTalRsrxLrriTkOgmuN
         6JYEXRdiuOd/5VKq2RVdcRK9cZeLmmABNw/darXA73sgTyFhjFfS7cdVMBUy45d9xgwc
         zlU9KBA/f7uwyqnO+4SMl9DnY0Obh/hF9sGz8qnoQC8JapyVnDJif+PKPbif5d6qcIeH
         SXCg==
X-Gm-Message-State: ALoCoQlhFSpnfQ2JcdYY1o1gCFsnARZueE+NhhtcczzEzUcmghWSQDhD930h2ScrimFZAyQVjNyl
X-Received: by 10.229.58.68 with SMTP id f4mr12875890qch.18.1395776276430;
 Tue, 25 Mar 2014 12:37:56 -0700 (PDT)
Received: by 10.140.50.45 with HTTP; Tue, 25 Mar 2014 12:37:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245145>

I'm trying to ensure that a specific file is signed properly before
allowing the file to be commited.  I'm using powershell to do this,
but this isn't a powershell issue.  Here's the command I'm using to do
the check:

    /c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command
"If ((Get-AuthenticodeSignature .\test.ps1).Status -ne 'Valid') { Exit
1 }"

Note: I've tried with variation of the following powershell switches:

    -NoLogo -NonInteractive -NoProfile

At first, the appeared to be that the exit code is lost and is always
0.  After further investigation, it appears that this command doesn't
even run.  For example, here's a test command:

    /c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command
"Get-Location | Out-File C:\Temp\test.txt"

This *test* command runs fine when executed from the GitBash shell;
the test.txt file is created.  When in the pre-commit hook file, it
fails to create the test.txt file; this is technically TortoiseGit
running this part.

**Question:**  On windows, how do I ensure that a specific file is
signed properly before allowing the file to be commited?  Is there a
way to have the `gpg` command use the windows cert store for
validation of a signature?

I feel like this is a TortoiseGit issue, but wanted to bounce this on
you all.  I've submitted an issue:
https://code.google.com/p/tortoisegit/issues/detail?id=2143

--
~Ray
` ` ` ` ` ` ` ` ' ` ` ` ` ` ' ` ` ` ` ` ` `
Raymond A. S. Piller
http://Vertigion.com
682-651-5653
