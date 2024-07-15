Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6532433B3
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054649; cv=none; b=gS/l71alxrcJ43JIB0iAg9plIGa2uIVkbdVLUiKf5ZzVh6F8PrqGW5Nt7+O8gqOttHIg22NPKuvxajkzy0R+zy75lzNsdRAV5FVlaE2drY0ZrnTuNigAZNxvUtnI04fothoqO0aVrz+nYwhpB0mRSci9yGPRWtCKLLyitsOMn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054649; c=relaxed/simple;
	bh=VNvEDTkb/MQVV8UIoJoBKr/KTxTMIXAcwEI/YimRVnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kjGBNyaG0h/GZj2roNs7Kh+hD5c0D5txUDuKpJdUdIKz1xOZ9GVoPYdjTEbOma4EfDlrNmxJ3okUHqj1jAsdIQrN9Q32K71octhPw6ZEIkSIOm21oLglNt0eTBdbhq7P2J4/nRwPRpFDFO+S2htBdqMgpJOwFcOl1giZrpqd6S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wzaX1Qrp; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wzaX1Qrp"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D25531B0B;
	Mon, 15 Jul 2024 10:44:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VNvEDTkb/MQV
	V8UIoJoBKr/KTxTMIXAcwEI/YimRVnI=; b=wzaX1Qrp61c2j8NG+lpVwtlx6y34
	NCnJjFtuxZBXqownkZC5o/3fK5J90sq6zVzY0WOWS0fSAuaUXyzyYfHLJi78TTAi
	cN4s7dP8q/BrWyW/9o4rPqvdoEzkm8NgN4R3ii5gfMSi1+ODKOj51xBOK+8+APjP
	ycSAXsa6EF5R2LI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3774031B0A;
	Mon, 15 Jul 2024 10:44:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5CB531B09;
	Mon, 15 Jul 2024 10:44:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/1] t-strvec: improve check_strvec() output
In-Reply-To: <f2bcee2b-88fa-4dcd-8247-f68d842c6a4c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 14 Jul 2024 19:06:50 +0200")
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
	<983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
	<f2bcee2b-88fa-4dcd-8247-f68d842c6a4c@web.de>
Date: Mon, 15 Jul 2024 07:44:03 -0700
Message-ID: <xmqqcyne90lo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 AF06ED8E-42B8-11EF-952D-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The macro check_strvec calls the function check_strvec_loc(), which
> performs the actual checks.  They report the line number inside that
> function on error, which is not very helpful.  Before the previous
> patch half of them triggered an assertion that reported the caller's
> line number using a custom message, which was more useful, but a bit
> awkward.
> ...
> We can let check_strvec add the terminating NULL for us and remove it
> from callers, making it impossible to forget.  Leave that conversion fo=
r
> a future patch, though, since this reimplementation is already intrusiv=
e
> enough.
>
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> For next, on top of c6f35e529e t-strvec: use test_msg().

Thanks.
