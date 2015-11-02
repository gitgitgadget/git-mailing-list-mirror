From: "Stenberg Jim (2)" <jim.stenberg.2@volvo.com>
Subject: Git potential bug with fork-point
Date: Mon, 2 Nov 2015 06:27:52 +0000
Message-ID: <a3db24afbc3247c3a8466c8d7ce0c785@SEGOTNC5113-N2.vcn.ds.volvo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 02 07:28:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zt8b2-00081z-B0
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 07:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbbKBG14 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 01:27:56 -0500
Received: from mail-gw3.it.volvo.com ([192.138.110.232]:27274 "EHLO
	mail-gw3.it.volvo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbbKBG1z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2015 01:27:55 -0500
X-IronPort-AV: E=Sophos;i="5.20,233,1444687200"; 
   d="scan'208";a="580299325"
Thread-Topic: Git potential bug with fork-point
Thread-Index: AdETDvrAjLx3fch+RLa5Kf6ewAz+RACI+YBwAAD+NqA=
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [131.97.199.97]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280683>

Hello,
my name is Jim Stenberg and I'm a developer, albeit not that experience=
d with Git.
Please note that I'm not a native English speaker.
If there is anything unclear or lacking, feel free to ask me on this em=
ail address.

My problem:
"Git merge-base --fork-point" acts unexpected when I refer to remote br=
anches (typically "origin/".)
With unexpected I mean that if I swap the position of the two reference=
s that the function takes as argument I get different results.
I highly suspect that this isn't a feature but a bug, or maybe I'm usin=
g the function in a way it wasn't intended to be used.
I don't need you to fix it (swapping the arguments solves it), I just w=
ant you to be aware of it.

History & procedure:
When=A0 I was working on my automatic build script I came across the od=
dity that "Git merge-base --fork-point" behaved
differently depending on the order in which the two references are pass=
ed.
I tried to strip the problem down to the smallest example I could. Such=
 example uses:
=2E A local folder as repository, initialized by "git init --bare"
=2E A local clone, acquired by "git clone ../my/path/to/repo repoName"
=2E Populated with a few files and commits.
I first detected the problem on git version 1.9.5.msysgit.0 but could c=
onfirm the same behavior on git version 2.6.2.windows.1.
I've pasted a log in text form below, the message did not allow for app=
ended images. The log should be sufficient to reproduce the problem.
Please observer the additional new-lines in the log and that no errors =
or fault messages are presented.

System configuration:
OS Name:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0Microsoft Windows 7 Enterprise
OS Version:=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 6.1.7601 Service Pack 1 Build 7601
OS Manufacturer:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
Microsoft Corporation
OS Configuration:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0Me=
mber Workstation
OS Build Type:=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0Multiprocessor Free
System Type:=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0x64-based PC
Total Physical Memory:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A03=A0977 MB
Available Physical Memory:=A0=A0=A0=A0=A0=A0=A0=A0 841 MB

Log:
C:\Test\Local\Main>git version
git version 2.6.2.windows.1

C:\Test\Local\Main>git plot
* a17df67 (HEAD -> release/15.F, origin/release/15.F) try try again
* 2af2f42 Other solution to fork-point problem, change position of argu=
ments
* 8bb3a5e more bugfixing, in release branch is now also checked against=
 server
* 9db0a3c bugfix, fork-point do not work with origin/* =3D> use only me=
rge-base
* 6489785 Check on origin/release/* instead of release/*
* 12cd1af X -> T
* 2dde79c P -> X && 15.D -> 15.F
* ffefe54 15.F -> 15.D
* 634e81d T->P
* f4003e5 Overhauled the ECU split solution
* 0e1bc85 reverting even more
* c0e1391 incorrectly changed to X release
* faaa7e8 changed to P release
* 51d5588 Finishing touch, + fault codes
* c03f0b4 canges, ready for release?
* 09a7ed6 (origin/master, master) minor bug fixing
* 4bdb033 (tag: 15.D) Added required files

C:\Test\Local\Main>git merge-base --fork-point release/15.F master
09a7ed6294ae18fb6087ca1ee020d544f4efe28d

C:\Test\Local\Main>git merge-base --fork-point master release/15.F
09a7ed6294ae18fb6087ca1ee020d544f4efe28d

C:\Test\Local\Main>git merge-base --fork-point master origin/release/15=
=2EF
09a7ed6294ae18fb6087ca1ee020d544f4efe28d

C:\Test\Local\Main>git merge-base --fork-point origin/master origin/rel=
ease/15.F

09a7ed6294ae18fb6087ca1ee020d544f4efe28d

C:\Test\Local\Main>git merge-base --fork-point origin/release/15.F orig=
in/master


C:\Test\Local\Main>git merge-base --fork-point origin/release/15.F mast=
er

C:\Test\Local\Main>

Literature index:
When reading https://git-scm.com/docs/git-merge-base I didn't found any=
 information about this particular case.
I didn't find any list of known bugs, hence I can't confirm if it's rep=
orted or not.

_________________________________________________
Med V=E4nliga H=E4lsningar / Best Regards
Jim Stenberg M.Sc.
ECU node owner

Volvo Bus Corporation
Dept CD74230, ARAK3
SE-405 08 G=F6teborg, Sweden
Phone: +46 31 32 25173
Email:=A0jim.stenberg.2@volvo.com
