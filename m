Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C6344E04A
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921172; cv=none; b=ZGtkJ19sserCmnG5QkjZa5r++5s+eCh+XvQXA54XJspe7+L3V33ic8Iw2YBCrjXgdGHRYiHZu9X2Yo8nMi8Y4A4ewdJdPzKyKh3KSpf466xzK49hEqjjMtaKI8528SGaBQbqYmID5Fl1bzfalpdmpe2P/inQ9GDBwqwlzHw9m8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921172; c=relaxed/simple;
	bh=yA/5sjcojoqfZwmbNyP2MUXecqTOfVzy6+F5FJKB8As=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kco1jyqkkvS3iu7FALVIFJQdwX7xByCm3O4YhSAjDFb4kidA/WCNeErc2N6to/8BxT0MkWlvDgROKD72r5ADtpGx8apFVbUZY4Xt6FCeVlcdgN8Q+mbaQMfYMxlRRaAuaiDS4+LGWMNAaHYd6ZxByp52fqM6GG/yHjdFt93Rd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gn1nZ6HG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PqUrzV8j; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gn1nZ6HG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PqUrzV8j"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 975FA1400134;
	Wed,  1 Jul 2026 11:52:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 11:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782921170; x=1783007570; bh=N8F0dul9jM
	LvqYbupCq7U4J+/zvCmLEUFK7ol5gFovk=; b=Gn1nZ6HGs5u/xfT6u4wmVwMjtT
	XfW9AS2p4MmaC2EOp7N334vhhSeBwmshMif1Z0qRzsHNVfXivMMQifo99VrSvnGf
	JEZ2UqEnVd3/KZHY+5dWzFDJTVYGPbezRFNpfRcypxbYkTwvrAaSk47IOp2J+vsU
	gBzbIQrpvQgVbiUhHPJhnqHLLgJNdr93KMiZPicrxFB8hw7hIOQs8skDfvyUR5xj
	PhdnObnUjm5RncMK3tRxCMDhjl2ObVjd6hvVNd6Dybz/MUS5+6BhNQA/uPhneWCW
	v7ZEWwRzaWHIFcYsesvH2a23E0azpWg9yZ25JDUJc4/XwbNuNGffkttj4BMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782921170; x=1783007570; bh=N8F0dul9jMLvqYbupCq7U4J+/zvCmLEUFK7
	ol5gFovk=; b=PqUrzV8jscGot7B2nZRFXPNRYRJcHMkRs3ObM7sBtuHzgmFAMZ4
	WqasYbeiCldazoUFsk3HRGxAwB9ip8ux4Fy5Xr2MC2sBjSN4o6SQ1ZnDD7b+YNe9
	Ji66mgObZK2m1AH9CWEtUHDokqeKQYkvhBHVcAHcIAc+XnYq06C49dIXqOW8HU4y
	XOIL1GmQNtD57TpJ0IbS9Oo8gsrJbH3mSkGSj3T3W/XOJJB1oVjWnT0VsJYa5WSe
	vGgV8kzmNBs/lsaelmUhoUVosyajlm0I2rfhXS2J62FHurzW6MitR4TMMpy4mRh4
	xt7wnnLX0t4zX4bhV8SMvnZucSTQRSJae8Q==
X-ME-Sender: <xms:0jdFamGHuTcqFMWhkc5eSjAe55THFT_-H2V-QEk5KTg83KDc4e_vjQ>
    <xme:0jdFauWKOrhA9rJ6SdITDz0YjjkRjeaIOH7XBLjlOLOUuyh5DZtDq1p3S4cHYiMgc
    UyvCT3pDDFdPoJqQGgbp-tJTXJOdgz7VKccMJILX-ZYFAn0S7_b66c>
X-ME-Received: <xmr:0jdFalLvvBhPC_Rh8cmhK38ANax0Q9_sFXoY6brSA-khSEE5nCAmF8iWAQspgK4JNhjWIyi0RIK9kX2hR010wUqPlvRDzTY2VNkYolM>
X-ME-Proxy-Cause: dmFkZTEpUxCguJPj0+iM2Oizm8DBr6B7zC/AFTgJdWusCUSsk4BcGJAjRk40J2YF4+pwYk
    NNwmNy4lShnQQmHlFHYH/g1WmRv7JBujwyVgt5V99gQSkmhUg77XrDCsgJ0JPBkNzCTDvH
    HAJfzwSmDnrRRvywvSwa60wVzd/ZwyGmB/BKrd+BLOd/bdHEAzce3PlUvqDfzNT5iuNe6o
    ZfH76pXdeL7SoG5J4jJjafM6I9SOU5+X1LnRHue6AB5swgBdKuyRQgh2NVjkUwggKDItFK
    dbKffmOSXxBgHSB/22IS5lWM7cowkjtzwmuu1BCExtsn2M94WYrURDGQL2vNGkkyRHITGG
    2fwTVH65lHT+NAsEiFvEr1C9rLdDmn++1RYchyDvMQRi5Tpl57562yIxk7DuCjLCtV6kOf
    s63WTDH0Gk5qQs+swRk4oxWZ4L/9eDqisXdO/URaNHMRiqySbh2CdRjdVHJkNMa8t+P1Xg
    uRSBZJC3Nz1CVhnRL5ASg9EEFOO3/PtOezK+HRoEhQTm9k6eDiZEQZQR4ouh01fQyeqX3y
    /rHFPvudKwO8LkgoZ4Haw9cz9QPKpXoOXCb5lbRp21r0XKgPE7agH7j1ZVMOgs0v4UflrA
    pflD36O+gVydxodY0mq5gnuOhNqWTe1o9/60pBeDQFeQe/Pc8QowojTayn5w
X-ME-Proxy: <xmx:0jdFau-fLdy8tzDL1kPDBkbnQQd-7jfU1pDjhb-QadlfW8d24vXOlA>
    <xmx:0jdFaoIIsxzAVr1OPFZWUbEERLfYavYWNe1anIJdotyEBb9UEJUnGQ>
    <xmx:0jdFajm5TfTYCMnxm6lavl2Raq9ebRJlRNHmw2LnhGFvR7Z1Lg-YHw>
    <xmx:0jdFasMm-I8v1EDVmvfKmB83hb2gqcKEHvvbGnVyw9TVS4kNsNKVjQ>
    <xmx:0jdFauHa2BCqBv4_g9jsJzLzQJg9H4uAUObRZj1UDaHSfaxprf87NRU5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 11:52:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/3] revision: avoid leaking bloom keyvecs with multiple
 traversals
In-Reply-To: <20260701064052.GB2580331@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 1 Jul 2026 02:40:52 -0400")
References: <20260701063538.GA2579765@coredump.intra.peff.net>
	<20260701064052.GB2580331@coredump.intra.peff.net>
Date: Wed, 01 Jul 2026 08:52:48 -0700
Message-ID: <xmqqmrwapuzz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think it would _probably_ work in practice, since any caller using a
> rev_info for multiple traversals is probably doing so with the same
> pathspec. But it would also create a very subtle bug if that assumption
> is violated. So we'll do the safer thing here, and generate fresh keyvec
> entries for each traversal. The efficiency difference is probably not
> noticeable, and this is what was happening already (we just weren't
> bothering to free the old ones!).

Good to see the thinking behind the design recorded so clearly in the log
message.  That thinking being on the more conservative side is a big plus.



> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  revision.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index e91d7e1f11..0ef9d895f0 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -707,6 +707,8 @@ static int convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
>  
>  static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  {
> +	release_revisions_bloom_keyvecs(revs);
> +
>  	if (!revs->commits)
>  		return;
