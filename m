Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6483128B8
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234663; cv=none; b=RQkDF/IVvjueX1OWvwzDfgzmd/LXTSOWBf3x1ML4/8TZ9acG0vxlKDyramVh48jCYsQqWQeE2GmHJSQk/tU+fMm3Fa/r+dRVtke0Sh1BkCM/oe6IFiQfNZ+93l9GIO+DrSeaFz35EjKPsRt2GRBmfWF1TzGc6wVYuEnfAmMoKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234663; c=relaxed/simple;
	bh=xznT3ShfJ3YAtTglTHDZk0FWhAD8XgdOYrpqP93TqlQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikB8CKd+7sIfH6rT33WWfX84zbPI/Ami+tH4A7Ofn5uc21jw1irIelBtYcCnwNvO6DETDoQIXgV81/hBYCdyB/M0MCS6wQFVu1+sZX/QpTvphSz+0x5GjTawow2TSi6if3bt+TbscIDAu9PUR3M7m8Iy4zpXfZdltO/2F0IDf14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MSb1KjS4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ci0fR+mZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MSb1KjS4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ci0fR+mZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E7951EC009F;
	Thu, 16 Jul 2026 16:44:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jul 2026 16:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784234660; x=1784321060; bh=kOo89yzhXG
	Cb43f0K/gDXhEfydurct/vw74a9y/hK10=; b=MSb1KjS44pIripOK+pndRph4bL
	G/0/mu8LnuOuEt6b4Z4nZYT4WK0BL4FVPUP6hedGaWtl8Sn3GbPu5OAqYyQG2PJn
	l5ByTW7UWJ8wzlI7BrkgR+LMAoCmV+R0kiOCSSTZQYptIpP0gXw6Q371Ozi2v5Ns
	eQvGjJAl0yX5h5Ow4D7+iAa+ltqK8EMokAm30gq45w7MPslPb8ywIPrZIObGty4u
	SvzY9eOg1b0F4AFIuvKZmBIcMR763+Z54bnK5BvU31F4ifBtDLQnIiPNbU9hwMik
	mhfy+LFUPehjY+u2JLD1ChostVEMwssKSMnF77rZ5G2U6J5iVoUD69Xys4/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784234660; x=1784321060; bh=kOo89yzhXGCb43f0K/gDXhEfydurct/vw74
	a9y/hK10=; b=ci0fR+mZzbtp8Bzi2J9GQlkhpR4tzg4VlNEqt+WlnVQO4xaxxCR
	f+9zLIwDgZyAPLNtmQqLATJEGSogOxiyOJ1ctHYIwQ2+3zQymzfri8WZ5ji36LK1
	HxYsozcrqZ63gd7FZzUi/NNo6doe7zR6S/OaLCUHk4of/Ey7PgagSFBCuA4k/v/P
	LlSbTpUlRlcpTFn1p4h2NMOB0KXEZNsE6J3smPlWu9xWZQbZP+BrXBIYCeC2Geha
	9uS4XbiLXIFI9aWQPEGQGAQrm3evtkUzsOJdjTvAOiT+Q4b168hkxmEFhdRGhN3o
	5AYMaXLIYI/6pu2k0YwEtpEUyXsxr8sVANA==
X-ME-Sender: <xms:o0JZapassBs3PFTjYv5XTWNq31ne8pvVRDUVnJWxYT8_bU6NSB0QKA>
    <xme:o0JZajdBBeT5sXWoAACXocRE0mO8RCnQX9m4ve6jXWvvIO_8O8YfcQyw0MGMUHr94
    WByCyJ7Tl_Gnk9LJvc--SAsw83zrMVjHnXJmQOaiYvFfZ13sCl0>
X-ME-Received: <xmr:o0JZamkGpvs8mliIKy2TMUmpnzrQgHSbQQyNKYT9mSWb9BWWXkrtSvVOD9YZRzn7XUuXFzq4xuwpmEpx0go_-aXRxoOlpnOj5k7fRsI>
X-ME-Proxy-Cause: dmFkZTFg9t/+sauawYJ4BdnOcN1jIdl4RgVwFbTdHMsKnBK/7Mo64O9uureL6OaQ11tXPU
    5TmVUrwItlB+Hrx0YYltXbDIfgU8t1UUrnQdGbA+6YIdkqffgXDKwX7h0nrSfx7Cv4YZ7I
    layJYJdyx/4zk6qDZHknC2pfCjkm+xwuCi/beNd6EqULn1zXXJJDqqVpb2Un+hI7eNxLoM
    tGuHbLFTynPNZV8IOL6+YeD++i7RdjqNWKtC+cnJEbdVOd8i9pSMp7RRMBKyeP4xBvtd2Z
    tKnbcb1ar1/2iZsX/F4NOu7w0GEI3AaEcSJJ4C3NNZ74+BSfuDmrk2+hOtOJbvVOitZ+e4
    ikBNGz5qx22roupezBcPWVZDH44wIq308CBoQDWUGY62MG1YlgXmlttgHdxNNVUU5tq19Z
    MTFirdBYSMdY8xCyWejfhRa/jLbNH1Tn6SxXHHd3WaFgb/wC17KtiUssoqKG8C362w1zuw
    emLajV59xn9Df/F28Hqg+vEoQGTiCYn83TtYxxNMAr76D3cNt0KbcQhR7cT+dhgssO3p+g
    Adv+ICHUN5Dq0CA0Hkpy3o6uwE9R4RRdvkRKJ/UbpLAdC8duUBU3+NX1cXhXNnDonuk/Zl
    VdHxFP2x6gOwBPnaEAnUDcjacZdGFT0qvjMBp5I7arauPBr7u/q314xd7PPA
X-ME-Proxy: <xmx:o0JZaj2IQR8r9AH3hZhJgOm7lBq121EhfBDIj4GEjUIGOeUCAESRbg>
    <xmx:o0JZavc4SkHn2UvoUw2QsZIn22nY8kUJchdEqUAkhIDhg9o14G8Nuw>
    <xmx:o0JZatY77vONnTGC4rILWSpLqPyYqoUVhGCHAWGJbBNN6QHOPyM45A>
    <xmx:o0JZakGA9CxuVmm4BfZvaLc1hxuLQpXmF6AZWkZFNtwXgYqMyW1sgQ>
    <xmx:pEJZaqlx4eYzZfXJw0EOioh4031YyCxa3JawJdgk0havmey5uzl9-8nr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 16:44:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Ben Knoble
 <ben.knoble@gmail.com>,  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] compat/posix: introduce writev(3p) wrapper
In-Reply-To: <xmqqfr1ig0hv.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	16 Jul 2026 13:09:32 -0700")
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
	<20260716-pks-reintroduce-writev-v1-1-ea9038c884bc@pks.im>
	<a2676ec6-39d5-4220-8549-10a17daec668@hogyros.de>
	<xmqqfr1ig0hv.fsf@gitster.g>
Date: Thu, 16 Jul 2026 13:44:18 -0700
Message-ID: <xmqqwluuekbh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Simon Richter <Simon.Richter@hogyros.de> writes:
>
>> Hi,
>>
>>> +		if (iov[i].iov_len > maximum_signed_value_of_type(ssize_t) ||
>>> +		    iov[i].iov_len + sum > maximum_signed_value_of_type(ssize_t)) {
>>
>> That feels like it could overflow.
>
> Isn't it checking if it would overflow (and dying if so)?
>
> Ah, wait.  The addition "(iov[i].iov_len + sum)" can indeed wrap
> around, and comparing it with the maximum value of ssize_t wouldn't
> catch that.  Is that what you mean?
>
> Would something like this:
>
>     if (maximum_signed_value_of_type(ssize_t) < iov[i].iov_len ||
> 	iov[i].iov_len + sum < iov[i].iov_len ||
> 	maximum_signed_value_of_type(ssize_t) < iov[i].iov_len + sum)
>
> work better to catch the three cases independently?
>
>  (1) The value is already too large on its own.
>  (2) Adding them together would cause an unsigned wrap-around.
>  (3) The sum does not wrap around, but it exceeds the maximum
>      representable value of ssize_t anyway.

Actually, looking at it again, I think the original code is safe
after all, because:

 * "sum", even though it is a size_t, is checked inside the loop to
   ensure it stays below the maximum value of ssize_t each time it
   gets a new value.
 * iov[i].iov_len is checked to ensure it does not exceed the
   maximum value of ssize_t by the first part of the condition.

If both values are less than or equal to the maximum value of
ssize_t, their sum is at most twice that limit.  For an N-bit
size_t, this sum is at most (2^N - 2), which can be computed safely
without any unsigned wrap-around.

So...?
