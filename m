From: =?utf-8?Q?Peter_H=C3=BCfner?= <p.huefner@e-confirm.de>
Subject: Re: git on vagrant shared folder
Date: Thu, 16 Jul 2015 09:09:33 +0200
Message-ID: <ABFD6E6C-A59B-49FB-8B39-D86F00EA2A8D@e-confirm.de>
References: <7C05ACF4-6536-4E60-BC92-FF7F0E266C0D@e-confirm.de> <20150714183215.GG7613@paksenarrion.iveqy.com> <CAGZ79kbBKzbjbg5u7A7BgnV1JF=5A+-gb0OdYs11g6kx_UQu_A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 09:09:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFdIg-00083j-9V
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 09:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965AbbGPHJh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2015 03:09:37 -0400
Received: from mailrelay4.qsc.de ([195.158.160.129]:45330 "EHLO
	mailrelay4.qsc.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbbGPHJh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2015 03:09:37 -0400
Received: from s029.bre.qsc.de ([195.90.7.69]) by mailgate4.qsc.de;
 Thu, 16 Jul 2015 09:09:33 +0200
Received: from [192.168.53.205] (unknown [212.84.220.117])
	by s029.bre.qsc.de (Postfix) with ESMTPSA id 43CDB36C0049;
	Thu, 16 Jul 2015 09:09:33 +0200 (CEST)
In-Reply-To: <CAGZ79kbBKzbjbg5u7A7BgnV1JF=5A+-gb0OdYs11g6kx_UQu_A@mail.gmail.com>
X-Mailer: Apple Mail (2.2102)
X-cloud-security-sender: p.huefner@e-confirm.de
X-cloud-security-recipient: git@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mailgate4 with 70FFD1490001
X-cloud-security-connect: s029.bre.qsc.de[195.90.7.69], TLS=, IP=195.90.7.69
X-cloud-security: scantime:.2610
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274008>

Hi Stefan, Hi Frederik,

maybe I stated the case not clearly enough.

The repo is just inside an shared/mounted folder from the VM to the Hos=
t, so that we can access the sourcecode via an IDE running on the host.=
 The git commands are executed inside the VM on an ubuntu system. So th=
ere is no mix of operating systems in the repos directly. The shared/mo=
unted folder is underlying some restrictions, such as no filemode and c=
ase insensitive filenames. But with git we can handle this.

We do not commit any file inside the .git folder. The error (could not =
commit .git/config file) comes up while the git-clone command executed =
inside the shared folder.

I tried to clone the repo outside the shared folder and copied it insid=
e afterwards. As I was doing the configuration for filemode and case wi=
th the git-config command, I got the same error (could not commit .git/=
config file). But I was able to update the .git/config manually. So it =
is not only an access problem, because I can access the file.

The security risk is stated with version 2.2.1, but we were able clone =
in the shared folder with git 2.3. So the change must be in an higher v=
ersion.

Maybe I am able to install a few versions of git and try the scenario f=
or them, then i should be able to determine the version explicit.

Thanks again for your help. I hope I could state the problem a bit more=
 detailed for you.


Mit freundlichen Gr=C3=BC=C3=9Fen
=20
Peter H=C3=BCfner
=2E........................................................
e=C2=B7confirm GmbH ..
Travel.Software.Training.Consulting
=20
Gesch=C3=A4ftsf=C3=BChrer: Roman Borch und Michael Posthoff
HRB 35653B   Steuernummer 37/211/10880
10119 Berlin Linienstr. 214
=20
Tel.  +49 (0) 30 28 00 28 24=20
=46ax. +49 (0) 30 28 00 28 28
=20
www.e-confirm.de
=2E....................................................................=
=2E...........................

> Am 14.07.2015 um 20:53 schrieb Stefan Beller <sbeller@google.com>:
>=20
>>=20
>>> A few weeks ago we weren=E2=80=99t able to clone and get an error: =
could not commit /vagrant/.git/config file. Manually we were able to ch=
ange that file and also the clone command works outside the shared fold=
er.
>>=20
>> Why are you trying to commit a file inside the .git dir? Files in th=
at
>> dir should not be commited (and I'm pretty sure there was a patch ab=
out
>> this a while ago). The .git/config file for example is local to each=
 git
>> repo and should not be commited.
>=20
> Actually it is considered a security risk, see
> http://article.gmane.org/gmane.linux.kernel/1853266
