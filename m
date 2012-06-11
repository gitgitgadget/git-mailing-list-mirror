From: =?ISO-8859-1?Q?Cl=E1udio_Louren=E7o?= <pt.smooke@gmail.com>
Subject: Help understanding git checkout behavior
Date: Mon, 11 Jun 2012 17:52:26 +0100
Message-ID: <CAMUXYmUFbixgA1bVMA46Zzjed1Dwmjv54kWWXyjsuyu904GpTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Renato Neves <nevrenato@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 18:52:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se7qz-0007EP-VF
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 18:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182Ab2FKQw2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 12:52:28 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46617 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab2FKQw1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 12:52:27 -0400
Received: by wibhj8 with SMTP id hj8so3119843wib.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EYMd0P4K65OYeqx0PjulvEAwqf40aAjYVQA4v6zbjIo=;
        b=aZzaUmv6Gdx1yM2FPho3whega01HGJMOnhjxpdQ5N1mnBdVrr/nEpVN8vumCVS3WJ6
         7cYFx7dvtDeBHKSucc7VNeSWz8d1I8zIonEpPEUZSbMdS02BteNcIoVGf9f2o+cEeZ/U
         ATzwZ7VhfVIQh8hZNZbqCiqKscD5YFRsFa0/pgmgq1789VubKIwuxpkJ6m8Y3Y5MBc2s
         RWkDfGyridoGISxamxu7adc4VE4Jafz+Ap26YTLerzbt1KWqfQUBEg0RxxqfpEVw6D4z
         otLkWXYjBnNUJRxUQT5IsiVkedL6x5jkYt9BdquZjhYKxcG/y6FU4r5iBeB9Xa6yCTq8
         TF5A==
Received: by 10.180.102.228 with SMTP id fr4mr22367139wib.6.1339433546170;
 Mon, 11 Jun 2012 09:52:26 -0700 (PDT)
Received: by 10.194.28.231 with HTTP; Mon, 11 Jun 2012 09:52:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199675>

Hello,

We are master students at University of Minho in Portugal and we are
currently=A0working on a project suggested by CSAIL (MIT), called
"Understanding Git with Alloy". The project consists in modeling git
using alloy and then check for some properties that git does (not)
guarantee.

The project was going pretty fine, till we start modeling the=A0checkou=
t
operation. We are with some problems finding useful information about
the properties that have to be satisfied when the "git=A0checkout" is
performed. We have concluded that if everything that is on index is
commited then we have no problems making=A0checkout.
The problem is when we have something on index that is not updated
with the last commit. We cannot find a general property that says when
checkout can be performed. We have even found some files that are
lost, like in this case:

smooke =A0teste $ git init
Initialized empty Git repository in /home/smooke/Dropbox/teste/.git/
smooke =A0teste $ touch f
smooke =A0teste $ echo a > f
smooke =A0teste $ git add f
smooke =A0teste $ git commit -m 'first commit'
[master (root-commit) dab04b9] first commit
=A01 files changed, 1 insertions(+), 0 deletions(-)
=A0create mode 100644 f
smooke =A0teste $ git branch b
smooke =A0teste $ touch something
smooke =A0teste $ echo b > something
smooke =A0teste $ git add something
smooke =A0teste $ git commit -m 'something added'
[master 9f2b8ad] something added
=A01 files changed, 1 insertions(+), 0 deletions(-)
=A0create mode 100644 something
smooke =A0teste $ git rm something
rm 'something'
smooke =A0teste $ mkdir something
smooke =A0teste $ cd something/
smooke =A0something $ touch f1
smooke =A0something $ echo c > f1
smooke =A0something $ cd ..
smooke =A0teste $ git add something/f1
smooke =A0teste $ git checkout b
Switched to branch 'b'
smooke =A0teste $ ls
f
smooke =A0teste $ git checkout master
Switched to branch 'master'
smooke =A0teste $ ls
f =A0something
smooke =A0teste $ cat something
b

We are not sure if this behavior has an explanation of if it is just a =
bug.

We are hoping that you could clarify us about this operation or
recommend us some place where we can find some useful information
about this...

Thank you in advance,
Best regards,

Cl=E1udio and Renato
