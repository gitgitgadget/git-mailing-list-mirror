From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/2] send-email: squelch warning from Net::SMTP::SSL
Date: Mon, 15 Jul 2013 05:07:41 +0200
Message-ID: <51E3677D.6040903@web.de>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com> <1373025947-26495-2-git-send-email-artagnon@gmail.com> <51D82970.5070108@web.de> <20130706143256.GX862789@vauxhall.crustytoothpaste.net> <51D83C7E.8000902@web.de> <CALkWK0kAfZLqyCO+e+0PH0-MmjMYX1nJmit5Qb5L3Qf6nyhC9Q@mail.gmail.com> <20130714170316.GE11097@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7Zn?= =?UTF-8?B?ZXJzaGF1c2Vu?= 
	<tboegi@web.de>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Jul 15 05:07:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyZ8m-0006PY-26
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 05:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab3GODHw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 23:07:52 -0400
Received: from mout.web.de ([212.227.15.14]:58225 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295Ab3GODHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 23:07:51 -0400
Received: from [192.168.1.18] ([68.61.5.157]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0LpwMZ-1UUBrM3kGN-00ficp; Mon, 15 Jul 2013 05:07:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130714170316.GE11097@vauxhall.crustytoothpaste.net>
X-Provags-ID: V03:K0:HJPhZEJZEp7/eCX3jP1O9Eou6Q5G1XC3cLvA5IQNMyGCi2AtexD
 jMT1XcuGpsFSGuw+gslp4hI+19H8GniVX4YdWSzIKPvDO+V9cvio4eoh98+H52RwwntHRG2
 U57x4hlDErfpj91GCX3A9w1zQhjkGxdejbV68FouPdJ/oaRv3fYQFl3Ieyx6OpmGfU6/PGn
 hR14qgNkGsPwAxOK3tE9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230405>

On 2013-07-14 19.03, brian m. carlson wrote:
> On Sun, Jul 14, 2013 at 07:19:10PM +0530, Ramkumar Ramachandra wrote:
>> Torsten B=C3=B6gershausen wrote:
>>> /usr/bin/perl -MIO::Socket::SSL -e 'print "$IO::Socket::SSL::VERSIO=
N\n";'
>>> 1.22
>>
>> This is ancient!  (I have 1.84).  Is it not possible to do an
>> ssl-verify-peer in older versions (is it exported as something else)=
?
>> The older versions don't display the warning anyway, and this series
>> is about squelching the warning in newer versions.  Does
>>
>>   require IO::Socket::SSL qw(SSL_VERIFY_NONE SSL_VERIFY_PEER) or pri=
nt
>> "warning: not using SSL_VERIFY_PEER due to outdated IO::Socket::SSL"
>=20
> require doesn't take a list of symbols to import, and the import dies=
 if
> it fails.  You need:
>=20
> require IO::Socket::SSL;
> eval {
> 	IO::Socket::SSL->import(qw(SSL_VERIFY_NONE SSL_VERIFY_PEER));
> };
> if ($@) {
> 	warn "Not using SSL_VERIFY_PEER due to outdated IO::Socket::SSL\n";
> 	# Do something different here.
> }
>=20
> I didn't stick the require in the eval because git-send-email will fa=
il
> in this case anyway if you don't have it, since Net::SMTP::SSL requir=
es
> it.  Let me know if you want a patch for this on top of the existing =
two
> in this series and I'll provide one.
>=20
Please send a patch if possible.
I can volonteer to test it here, but it can take a couple of days to re=
spond.
