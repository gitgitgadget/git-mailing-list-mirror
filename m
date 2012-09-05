From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [RFC] i18n.pathencoding
Date: Wed, 05 Sep 2012 21:52:42 +0200
Message-ID: <5047AD8A.3020203@web.de>
References: <201209010811.33994.tboegi@web.de> <CACsJy8A1GnhTeMzwXwA1C96pp0ERskxZC=SO+QE2__pfwmChow@mail.gmail.com> <7vvcftbt8o.fsf@alter.siamese.dyndns.org> <50465BBC.30203@web.de> <7vy5kp8s3h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 21:52:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Lef-0001NO-86
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 21:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759255Ab2IETwq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Sep 2012 15:52:46 -0400
Received: from mout.web.de ([212.227.17.11]:65462 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754515Ab2IETwq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 15:52:46 -0400
X-Greylist: delayed 1919 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2012 15:52:45 EDT
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0ML8F7-1T94XK0ctN-000Yr7; Wed, 05 Sep 2012 21:52:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <7vy5kp8s3h.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:XZpJanCgOimhAvHuz+I82K2fYCMm8Lfv2DFaO0UzIeI
 ZeWZWgjirvm0HI8OxlfMFNBciZOAMI/PIGGb4FVfw7fPjWzK1H
 u56tYdlagMYCvA8RtZUD7o7wEjqDZMiyxvbGEmEqMJN/ArZuDr
 xtg0e1f9EAUFSJKOigCchtPzLaPxYvIv6qzcGT2SRUJ1PHA1uq
 0k9nWaPh/au8PkW3sTv7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204844>

On 04.09.12 22:12, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> This leads to 2 questions:
>> a) Do we want the reencode feature in git, so that I continue to wor=
k on it?
>>    From a performance point of view that would probably OK:
>>    The "git status" on a linux tree was slightly slower on my PC whe=
n measured with time.
>>    From the user experience there was not a difference.
>=20
> I am not fundamentally opposed to such a change, as long as the
> change does not affect performance at all when the feature is not
> used, and the resulting code does not become too ugly.
>=20
> Use of the "reencode" feature may have to make things slow, but you
> have to spend some cycle to do what the feature has to do anyway,
> so...
>=20
>> b) If yes,
>>    I have to admit that I don't use paths from --stdin or file so mu=
ch,
>>    except "git am" or "git format-patch"
>>    Which commands are affected?
>=20
> $ git grep -l -e '--stdin' Documentation/git*
>=20
> may be a good starting point.


------------------------------
I'll have a look into the --stdin stuff later, thanks Junio
-------------------------------

And here some benchmarks on my PC,
first run is using git v1.7.12,
second run with i18n.pathencoding applied=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 for f in 1 2 3 4 5; do time git status  ; done 2>&1 | egrep "^user|^re=
al|^sys"
real    0m0.492s
user    0m0.300s
sys     0m0.200s
real    0m0.448s
user    0m0.260s
sys     0m0.190s
real    0m0.443s
user    0m0.250s
sys     0m0.200s
real    0m0.451s
user    0m0.260s
sys     0m0.190s
real    0m0.429s
user    0m0.230s
sys     0m0.200s
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
for f in 1 2 3 4 5; do time ~/projects/git/tb.localfname/git status  ; =
done 2>&1 | egrep "^user|^real|^sys"
real    0m0.580s
user    0m0.320s
sys     0m0.230s
real    0m0.461s
user    0m0.260s
sys     0m0.200s
real    0m0.463s
user    0m0.250s
sys     0m0.220s
real    0m0.445s
user    0m0.290s
sys     0m0.160s
real    0m0.443s
user    0m0.240s
sys     0m0.210s
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

It seems that we have a little penalty on performance.
I'll have a look at the readdir() function.
