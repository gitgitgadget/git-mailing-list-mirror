From: =?UTF-8?Q?=E8=B0=AD=E4=BF=8A=E6=B5=A9?= <pickfire@riseup.net>
Subject: Re: [PATCH/RFC/GSoC 3/3] t0301: test credential-cache support of
 XDG_RUNTIME_DIR
Date: Thu, 17 Mar 2016 11:59:14 +0800
Message-ID: <729c6af810e3000e789f4afd537b77a8@riseup.net>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
 <1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
 <1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
 <xmqqr3fa5rdi.fsf@gitster.mtv.corp.google.com>
 <CAKqreuwRpS3uP6=afm-0pBkPW0-bqoJconnKO5q3qTgZwdU_xQ@mail.gmail.com>
 <xmqqbn6e5o9v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 04:59:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agP5l-0006DG-RG
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 04:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406AbcCQD7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2016 23:59:17 -0400
Received: from mx1.riseup.net ([198.252.153.129]:39616 "EHLO mx1.riseup.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858AbcCQD7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 23:59:16 -0400
Received: from piha.riseup.net (unknown [10.0.1.163])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
	by mx1.riseup.net (Postfix) with ESMTPS id 58E381A2F5D
	for <git@vger.kernel.org>; Thu, 17 Mar 2016 03:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1458187154; bh=I1lo0/DTN1AVshwJP9Q4tQWob1I+g/rGO2pNts8UQSw=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=Wmx4oDJd7iRkBU4hLIfH6i6fLuI7/d46mkL2AY4BoNnfoH3DdxJEhGTgU8hi6APOQ
	 LuBG6oroEPEr3v/8Dx32PEsA/OXehpuBhceCiS0nSG5mMfq7heDTTIMpppo7JDZLMH
	 KAu6SwEA99xJEh3ft933XCK+Xd8II14ljVpcaocE=
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: pickfire)
	with ESMTPSA id 2FFB11C022C
In-Reply-To: <xmqqbn6e5o9v.fsf@gitster.mtv.corp.google.com>
X-Virus-Scanned: clamav-milter 0.99 at mx1.riseup.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289072>

On 17/03/2016 01:24, Junio C Hamano wrote:
> =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:
>=20
>>> Is it because the wish is to always use /tmp/git-$uid/ as a fallbac=
k
>>> for $XDG_RUNTIME_DIR (as opposed to ~/.git-credential-cache/, which
>>> is specific to the credential-cache and would look strange if we
>>> used it for other "runtime" things)?
>>=20
>> Yes, I mean to use it as a general fallback for git.
>=20
> If that is the case the code probably needs to be a bit more careful
> before deciding to use /tmp/git-$uid/ directory (is it really $uid's?
> can anybody else write to it to race with the real user? etc.)
>=20
>> On the other hand, I think, falling back to=20
>> $HOME/.git-credential-cache/socket
>> doesn't make any sense for back-compability cannot be ensured.
>=20
> What do you mean by that?
>=20
> Using ~/.git-credential-cache/credential-cache.sock would not help
> at all for existing users, but ~/.git-credential-cache/socket would
> interoperate well with users with existing versions of Git, no?
>=20
>>> Just being curious, and wanting to see the reasoning behind the
>>> design decision the patch series makes in the log message of one of
>>> these patches.

I guess it is better to use /tmp or such instead of $HOME/.* so that
the users home directory won't be flooded by sockets.
