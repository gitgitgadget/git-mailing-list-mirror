From: Emmanuel Puerto <emmanuel.puerto@maxim-ic.com>
Subject: [BUG] malloc error when using large file.
Date: Mon, 22 Jun 2009 02:54:18 -0700
Message-ID: <B03A893ADFE80748942D13AFAF2845190C2D5D388A@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 12:10:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIgU3-0006jP-DO
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 12:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbZFVKK3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2009 06:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbZFVKK2
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 06:10:28 -0400
Received: from antispam01.maxim-ic.com ([205.153.101.182]:53933 "EHLO
	antispam01.maxim-ic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbZFVKK1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2009 06:10:27 -0400
X-Greylist: delayed 899 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jun 2009 06:10:27 EDT
X-ASG-Debug-ID: 1245664014-59d503e50000-QuoKaX
X-Barracuda-URL: http://AntiSpam01:8000/cgi-bin/mark.cgi
Received: from terlingua.dalsemi.com (localhost [127.0.0.1])
	by antispam01.maxim-ic.com (Spam Firewall) with ESMTP id 2D86F22E95E
	for <git@vger.kernel.org>; Mon, 22 Jun 2009 04:46:54 -0500 (CDT)
Received: from terlingua.dalsemi.com (terlingua.dalsemi.com [180.0.34.46]) by antispam01.maxim-ic.com with ESMTP id vvORIbiwVb8q1QIJ for <git@vger.kernel.org>; Mon, 22 Jun 2009 04:46:54 -0500 (CDT)
Received: from itdalex01.it.maxim-ic.internal (itdalex01.it.maxim-ic.internal [10.16.15.6])
	by terlingua.dalsemi.com (8.10.2/8.10.2) with ESMTP id n5M9tU804252
	for <git@vger.kernel.org>; Mon, 22 Jun 2009 04:55:30 -0500 (CDT)
Received: from itdalias01.it.maxim-ic.internal ([10.16.15.60]) by itdalex01.it.maxim-ic.internal with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 22 Jun 2009 04:55:43 -0500
Received: from maxdalex01.maxim-ic.internal (10.16.15.103) by
 itdalias01.it.maxim-ic.internal (10.16.15.60) with Microsoft SMTP Server
 (TLS) id 8.1.358.0; Mon, 22 Jun 2009 04:55:43 -0500
Received: from maxsvlex02.maxim-ic.internal (172.18.47.215) by
 maxdalex01.maxim-ic.internal (10.16.15.101) with Microsoft SMTP Server (TLS)
 id 8.1.358.0; Mon, 22 Jun 2009 04:55:43 -0500
Received: from ITSVLEX06.it.maxim-ic.internal ([172.18.41.168]) by
 maxsvlex02.maxim-ic.internal ([::1]) with mapi; Mon, 22 Jun 2009 02:55:42
 -0700
X-ASG-Orig-Subj: [BUG] malloc error when using large file.
Thread-Topic: [BUG] malloc error when using large file.
Thread-Index: AcnzH2jzKwcLFuFrQu+do0Kntl0KAA==
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: fr-FR, en-US
X-OriginalArrivalTime: 22 Jun 2009 09:55:43.0726 (UTC) FILETIME=[9BA000E0:01C9F31F]
X-Barracuda-Connect: terlingua.dalsemi.com[180.0.34.46]
X-Barracuda-Start-Time: 1245664014
X-Barracuda-Virus-Scanned: by Barracuda Spam Firewall at maxim-ic.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122025>

Hi All,

I use Git with some Virtual Machine and I have an issue with 2 of them.
When I use some VM I have created with a "pre-allocated" disk split int=
o a 2Go file. For example a "ls" give:

-rwx------ 1 epuerto epuerto 2147221504 juin 18 17:05 All-f001.vmdk
-rwx------ 1 epuerto epuerto 2147221504 juin 18 17:05 All-f002.vmdk
-rwx------ 1 epuerto epuerto 2147221504 juin 18 12:07 All-f003.vmdk
-rwx------ 1 epuerto epuerto 2147221504 juin 18 17:05 All-f004.vmdk
-rwx------ 1 epuerto epuerto 2147221504 juin 18 17:05 All-f005.vmdk
-rwx------ 1 epuerto epuerto 2147221504 juin 18 12:07 All-f006.vmdk
-rwx------ 1 epuerto epuerto 2147221504 juin 18 12:07 All-f007.vmdk
-rwx------ 1 epuerto epuerto    1835008 mars 10 21:44 All-f008.vmdk
-rwx------ 1 epuerto epuerto       1007 juin 18 09:30 All.vmdk
-rw------- 1 epuerto epuerto        548 juin 18 09:40 devel
-rw------- 1 epuerto epuerto 1538850816 juin 18 17:05 devel-s001
-rw------- 1 epuerto epuerto 1125384192 juin 18 17:05 devel-s002
-rw------- 1 epuerto epuerto 1384382464 juin 18 17:05 devel-s003
-rw------- 1 epuerto epuerto 1632763904 juin 18 17:05 devel-s004
-rw------- 1 epuerto epuerto    1572864 juin 18 17:05 devel-s005
-rwx------ 1 epuerto epuerto       8684 juin 18 17:07 Ubuntu.nvram
-rw------- 1 epuerto epuerto  536870912 juin 18 17:06 Ubuntu.vmem
-rwx------ 1 epuerto epuerto          0 mars 10 21:31 Ubuntu.vmsd
-rw------- 1 epuerto epuerto  135732052 juin 18 17:07 Ubuntu.vmss
-rwx------ 1 epuerto epuerto       2908 juin 18 17:07 Ubuntu.vmx
-rwx------ 1 epuerto epuerto        261 mars 10 21:31 Ubuntu.vmxf

So if I just do a "git init" and after do a "git add -A" I have the fol=
lowing error:
fatal: Out of memory, malloc failed

no more information is given if I use the verbose option of git (git ad=
d -v -A).

In fact the error appear when I try to add file name "all-f00?.vmdk"

It appears that this size of file is not accepted by git.
If I do the same with other VM that they have a biggest size or a small=
est size, all it is ok

=46or example:
-rw------- 1 epuerto epuerto       8684 avril  6 15:56 CentOs 5.2 Dev.n=
vram
-rw------- 1 epuerto epuerto       8684 juin 18 11:36 CentOs 5.3 Dev.nv=
ram
-rw------- 1 epuerto epuerto  536870912 juin 18 11:36 CentOs 5.3 Dev.vm=
em
-rw------- 1 epuerto epuerto          0 avril  3 12:26 CentOs 5.3 Dev.v=
msd
-rw------- 1 epuerto epuerto   18408288 juin 18 11:36 CentOs 5.3 Dev.vm=
ss
-rwxr-xr-x 1 epuerto epuerto       2239 juin 18 11:36 CentOs 5.3 Dev.vm=
x
-rw------- 1 epuerto epuerto        269 avril  6 10:43 CentOs 5.3 Dev.v=
mxf
-rw------- 1 epuerto epuerto 1766981632 juin 18 11:36 sda-s001.vmdk
-rw------- 1 epuerto epuerto 2094596096 juin 18 11:36 sda-s002.vmdk
-rw------- 1 epuerto epuerto 1808138240 juin 18 11:36 sda-s003.vmdk
-rw------- 1 epuerto epuerto 1429667840 juin 18 11:36 sda-s004.vmdk
-rw------- 1 epuerto epuerto      65536 juin 18 11:36 sda-s005.vmdk
-rw------- 1 epuerto epuerto        907 juin 18 10:57 sda.vmdk

OR

-rwxrwxrwx 1 epuerto epuerto       8684 juin 17 21:08 FreeBSD 64-bit.nv=
ram
-rwxrwxrwx 1 epuerto epuerto    1114112 mars 27  2008 FreeBSD 64-bit.vm=
dk
-rwxrwxrwx 1 epuerto epuerto          0 mars 27  2008 FreeBSD 64-bit.vm=
sd
-rwxrwxrwx 1 epuerto epuerto       1652 juin 17 19:48 FreeBSD 64-bit.vm=
x
-rwxrwxrwx 1 epuerto epuerto        269 mars 27  2008 FreeBSD 64-bit.vm=
xf
-rwxrwxrwx 1 epuerto epuerto 9118810112 juin 17 21:08 hdd.vmdk


My primary OS (where I use Git) is=20
$uname -a
Linux epuerto-FC10.innova-card.internal 2.6.27.24-170.2.68.fc10.x86_64 =
#1 SMP Wed May 20 22:47:23 EDT 2009 x86_64 x86_64 x86_64 GNU/Linux

And my git version is:
$ git --version
git version 1.6.0.6

my config is:
ThinkPad T400 with a Intel(R) Core(TM)2 Duo CPU T9400 and 4Go

Thanks by advance for your help.

Best regards,
Emmanuel.

Before you print Think about=20
ENVIRONMENTAL responsibility and commitment

Emmanuel PUERTO
Senior MTS, Field Applications (Microcontroller)
Linux Embedded Architect

MAXIM Integrated Products, Inc.
ZI Athelia IV - Le Forum, Bat A
Quartier Roumagoua
13600 La Ciotat - France
Phone : +33 44 298 1338
=46ax=A0=A0 : +33 44 208 3319
Email : emmanuel.puerto@maxim-ic.com
Web=A0=A0 : www.maxim-ic.com
