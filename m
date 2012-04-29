From: Jem <jem.mawson@gmail.com>
Subject: Pulling without any local commits deletes stages files without warning.
Date: Sun, 29 Apr 2012 10:29:09 +1000
Message-ID: <CAHzj05Uy-zofirgnhqK_t+jdD41J8yG5OJk-QCHmQ+OZLWfMqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 29 02:29:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOI1K-0000ss-PA
	for gcvg-git-2@plane.gmane.org; Sun, 29 Apr 2012 02:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882Ab2D2A3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Apr 2012 20:29:11 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57589 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab2D2A3K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Apr 2012 20:29:10 -0400
Received: by ghrr11 with SMTP id r11so1021092ghr.19
        for <git@vger.kernel.org>; Sat, 28 Apr 2012 17:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=f4T1rRTnQ1EPMJxfIuoLf+NjmlFtX1ipatuvK9H6Zyg=;
        b=lQXWA6uxuKLAEJCa+h6QO2M59RoKDdS2AQ0D6djb+alPViqLkZCZcGIxv1tkFzq7bJ
         5glNyLECZnMwmMWlKroZsmhJhEpAJlw3M9fE9WHOhs0/0HV2J9jaSrlE8Q1bL5zsY2ZD
         rdfUcsHkQQelykUo2n3Gt6Dgg/psAtFrnYf6JVdm8JmzJRY5hMdkUVEGOzkuhZ1+nb+P
         BoZMubr8txYmPF1LJOmroY6xlaZfmg5pjYcOEAbWbG8rQtr6lQ4pVLX6c+4h+pRts1tY
         NpMz4v1Iy8JupctAokySPaAiT/QyY0RMwjlAl8rs0yOyIw+ry8FWm7fMU/joKh4zgZYI
         cJfA==
Received: by 10.236.161.42 with SMTP id v30mr10843698yhk.127.1335659349951;
 Sat, 28 Apr 2012 17:29:09 -0700 (PDT)
Received: by 10.236.70.104 with HTTP; Sat, 28 Apr 2012 17:29:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196502>

Hi

Pulling without any local commits deletes staged files without
warning. Is this intended behaviour? Log:

jem@jem-usb:~/projects$ git --version
git version 1.7.9.5
jem@jem-usb:~/projects$ uname -a
Linux jem-usb 3.2.0-23-generic-pae #36-Ubuntu SMP Tue Apr 10 22:19:09
UTC 2012 i686 i686 i386 GNU/Linux
jem@jem-usb:~/projects$ mkdir x
jem@jem-usb:~/projects$ cd x
jem@jem-usb:~/projects/x$ git init
Initialized empty Git repository in /home/jem/projects/x/.git/
jem@jem-usb:~/projects/x$ echo "hi" > hello.world
jem@jem-usb:~/projects/x$ git add hello.world
jem@jem-usb:~/projects/x$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
# =A0 (use "git rm --cached <file>..." to unstage)
#
# =A0 =A0 =A0 new file: =A0 hello.world
#
jem@jem-usb:~/projects/x$ ls -asl
total 24
4 drwxrwxr-x 3 jem jem 4096 Apr 28 20:56 .
4 drwxr-xr-x 8 jem jem 4096 Apr 28 20:56 ..
4 drwxrwxr-x 7 jem jem 4096 Apr 28 20:56 .git
12 -rw-rw-r-- 1 jem jem =A0 =A03 Apr 28 20:56 hello.world
jem@jem-usb:~/projects/x$ git remote add origin git@github.com:Synesso/=
memx.git
jem@jem-usb:~/projects/x$ git reflog
fatal: bad default revision 'HEAD'
jem@jem-usb:~/projects/x$ git pull origin master
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 7 (delta 0), reused 3 (delta 0)
Unpacking objects: 100% (7/7), done.
=46rom github.com:Synesso/memx
* branch =A0 =A0 =A0 =A0 =A0 =A0master =A0 =A0 -> FETCH_HEAD
jem@jem-usb:~/projects/x$ ls -asl
total 36
4 drwxrwxr-x 3 jem jem 4096 Apr 28 20:53 .
4 drwxr-xr-x 8 jem jem 4096 Apr 28 20:52 ..
4 drwxrwxr-x 8 jem jem 4096 Apr 28 20:53 .git
12 -rw-rw-r-- 1 jem jem =A0 59 Apr 28 20:53 .gitignore
12 -rw-rw-r-- 1 jem jem =A0 =A09 Apr 28 20:53 README.md
jem@jem-usb:~/projects/x$ git reflog
c80135d HEAD@{0}: initial pull
