From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Subject: Re: can not clone via git:// anymore
Date: Wed, 04 Mar 2009 14:28:40 +0100
Message-ID: <49AE8208.7090204@cetrtapot.si>
References: <49AE64F2.1090405@cetrtapot.si> <49AE7B23.1070008@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 14:31:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LerCR-0000B3-Dv
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 14:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbZCDNaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 08:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbZCDNaS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 08:30:18 -0500
Received: from zimbra-mta.cetrtapot.si ([89.212.80.172]:52074 "EHLO
	zimbra-mta.cetrtapot.si" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbZCDNaR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 08:30:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id 6A9F019FA58;
	Wed,  4 Mar 2009 14:30:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra-mta.cetrtapot.si
Received: from zimbra-mta.cetrtapot.si ([127.0.0.1])
	by localhost (zimbra-mta.cetrtapot.si [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KO3nsXjdEkrL; Wed,  4 Mar 2009 14:30:14 +0100 (CET)
Received: from [172.31.65.135] (unknown [192.168.66.2])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id F253B19FA50;
	Wed,  4 Mar 2009 14:30:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <49AE7B23.1070008@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112211>

Michael J Gruber wrote:
> Hinko Kocevar venit, vidit, dixit 04.03.2009 12:24:
>> Hi,
>>
>> I've recently discovered that my GIT repository is not letting me cl=
one it via git clone git://.
>> It works using git clone git@.. (SSH) but with GIT protocol..
>>
>> Here is the case:
>> hinkok@alala /tmp $ git --version
>> git version 1.6.0.6
>> hinkok@alala /tmp $ git clone git://zidar/sdk.git
>> Initialized empty Git repository in /tmp/sdk/.git/
>> fatal: The remote end hung up unexpectedly
>>
>> My earlier clone (few months old) has this in .git/config:
>> hinkok@alala /work/git/sdk.git $ cat .git/config=20
>> [core]
>> 	repositoryformatversion =3D 0
>> 	filemode =3D true
>> 	bare =3D false
>> 	logallrefupdates =3D true
>> [remote "origin"]
>> 	url =3D git@zidar:repositories/sdk.git
>> 	fetch =3D +refs/heads/*:refs/remotes/origin/*
>> [branch "master"]
>> 	remote =3D origin
>> 	merge =3D refs/heads/master
>>
>>
>> But I remember cloning via SSH that time, because I needed git push =
to work,
>> but now other developer do not need the SSH access, but only GIT rea=
d-only -
>> they can only clone, not push.
>>
>> I do not administer the server git repos is located on, so I must ha=
ve some
>> information before I attack the admin..
>=20
> Sorry in case this is trivial, but has git: access ever worked? It

It did. I found this repos on the server that used git to checkout the =
repo:
CETRTAPOT\zidarhw@zidar:~$ cat sdk/.git/config=20
[core]
	repositoryformatversion =3D 0
	filemode =3D true
	bare =3D false
	logallrefupdates =3D true
[remote "origin"]
	url =3D git://zidar/sdk.git
	fetch =3D +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote =3D origin
	merge =3D refs/heads/master


> requires a git daemon running on the server, whereas ssh access does =
not
> require that. git@zidar:repositories/sdk.git uses ssh access.
>=20
> Michael

git-daemon was/is running:

CETRTAPOT\zidarhw@zidar:~$ ps -ef | grep git
root      3207     1  0 14:15 ?        00:00:00 runsvdir -P /etc/servic=
e log: d user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: in=
valid user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: inval=
id user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid =
user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid use=
r: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid user: =
`gitlog:adm'?chown: invalid user: `gitlog:adm'?
root      3208  3207  0 14:15 ?        00:00:00 runsv git-daemon
root      3373  3208  0 14:16 ?        00:00:00 git-daemon --verbose --=
base-path=3D/var/cache /var/cache/git
11418     3399  2762  0 14:16 pts/0    00:00:00 grep git

But after doing:
/etc/init.d/git-daemon stop
/etc/init.d/git-daemon start

Nothing much happened (this is on Ubuntu 8.04.1)!

After a while I managed to get git-daemon to die properly
- '/etc/init.d/git-daemon stop' didn't do that. After
'/etc/init.d/git-daemon start' the git clone git://.. works!


hinkok@alala /tmp $ git clone git://zidar/sdk.git
Initialized empty Git repository in /tmp/sdk/.git/
remote: Counting objects: 62636, done.
remote: Compressing objects: 100% (49201/49201), done.
Receiving objects:  40% (25055/62636), 59.97 MiB | 11069 KiB/s  =20

Thank your for the 'obvious' I haven't checked myself!

Best regards,
Hinko

--
Hinko Ko=E8evar, OSS developer
=C8ETRTA POT, d.o.o.
Planina 3, 4000 Kranj, SI EU
tel     ++386 (0) 4 280 66 03
e-mail  hinko.kocevar@cetrtapot.si
http    www.cetrtapot.si
