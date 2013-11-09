From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/5] fix up 'jk/pack-bitmap' branch
Date: Sat, 09 Nov 2013 18:25:53 +0100
Message-ID: <527E7021.8060204@kdbg.org>
References: <527C0CEA.4020705@ramsay1.demon.co.uk> <20131107221944.GA19238@sigill.intra.peff.net> <527D1B06.3090807@web.de> <20131108222903.GB19912@sigill.intra.peff.net> <527E1DED.9030800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 09 18:26:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfCIM-0006fV-V4
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 18:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125Ab3KIRZ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Nov 2013 12:25:57 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:18687 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753195Ab3KIRZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 12:25:56 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 55593CDF85;
	Sat,  9 Nov 2013 18:25:54 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7825F19F5EC;
	Sat,  9 Nov 2013 18:25:53 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527E1DED.9030800@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237579>

Am 09.11.2013 12:35, schrieb Torsten B=C3=B6gershausen:
> On 2013-11-08 23.29, Jeff King wrote:
>> On Fri, Nov 08, 2013 at 06:10:30PM +0100, Torsten B=C3=B6gershausen =
wrote:
>>
>>> Side question:
>>> Do we have enough test coverage for htonll()/ntohll(),
>>> or do we want do the "module test" which I send a couple of days be=
fore ?
>>
>> The series adds tests for building and using the ewah bitmaps, which=
 in
>> turn rely on the htonll code. So they are being tested in the existi=
ng
>> series.
>>
>> -Peff
> You are thinking about t5310-pack-bitmaps.sh ?
> If I do like this in compat/bswap.h
>=20
> # define ntohll(n) (n)
> # define htonll(n) (n)
> (on an Intel processor, little endian)
>=20
> then t5310 passes, even if the uint64_t words are written
> in little endian to disc instead of big endian.

Of course. You write little endian and also read back little endian;
that should work just fine, no?

OTOH, if you write with Intel and read with PPC, then you should observ=
e
misbehavior with the above patch.

-- Hannes
