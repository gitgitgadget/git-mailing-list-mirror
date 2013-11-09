From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 0/5] fix up 'jk/pack-bitmap' branch
Date: Sat, 09 Nov 2013 22:03:56 +0100
Message-ID: <87txflnv7n.fsf@linux-k42r.v.cablecom.net>
References: <527C0CEA.4020705@ramsay1.demon.co.uk>
	<20131107221944.GA19238@sigill.intra.peff.net>
	<527D1B06.3090807@web.de>
	<20131108222903.GB19912@sigill.intra.peff.net>
	<527E1DED.9030800@web.de> <527E7021.8060204@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Nov 09 22:04:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfFhU-0007AN-Lq
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 22:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758197Ab3KIVEG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Nov 2013 16:04:06 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:52957 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756751Ab3KIVED convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Nov 2013 16:04:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 271564D6576;
	Sat,  9 Nov 2013 22:03:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 58ruRBeQCJVR; Sat,  9 Nov 2013 22:03:57 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 03B474D6414;
	Sat,  9 Nov 2013 22:03:56 +0100 (CET)
In-Reply-To: <527E7021.8060204@kdbg.org> (Johannes Sixt's message of "Sat, 09
	Nov 2013 18:25:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237581>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 09.11.2013 12:35, schrieb Torsten B=C3=B6gershausen:
>>
>> If I do like this in compat/bswap.h
>>=20
>> # define ntohll(n) (n)
>> # define htonll(n) (n)
>> (on an Intel processor, little endian)
>>=20
>> then t5310 passes, even if the uint64_t words are written
>> in little endian to disc instead of big endian.
>
> Of course. You write little endian and also read back little endian;
> that should work just fine, no?
>
> OTOH, if you write with Intel and read with PPC, then you should obse=
rve
> misbehavior with the above patch.

Maybe you could check in a simple test that the bitmap for a very
predictable pack (e.g. only one commit) has a certain content, by
checking its hash.  That would guard against accidental format changes.

--=20
Thomas Rast
tr@thomasrast.ch
