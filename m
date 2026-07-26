Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3751724A06D
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101564; cv=none; b=eXSt0ND/0n9wkTF+3pX/aN+m3JZhVM0xB/73hBmEQlZxmlb66jG2VUdvVIJ8k4odAmxvOZuDV3wkWQwwUcHuThOu4Wm/hPdlXF+ecS47jgv9HMJM806c1muhvdczyTibDdySWtmWc2VzFtCklk51kl68VBC3ogNqsbktCHmMbG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101564; c=relaxed/simple;
	bh=zOCqlOELtsfMHtm5Mlr1306k5oUifu6H7RIUZudupds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H2dqFRkkDGyQXpXfpokhXThL0jC4cf+8gES2EDi+08EAE0Hdekiug58kWvgPD2HPobOjwTUqrUp2NdciupR2T4ntb8+KyQ8uIOSDui17nfNkJUL9aTeuXrkotQkmpSmP7D8lDip6G8c0jxZ3GN+or2FqZdTjVVenSQR+CrtuUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J3mPTEdy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KndikkKW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J3mPTEdy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KndikkKW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 605CDEC02E8;
	Sun, 26 Jul 2026 17:32:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 26 Jul 2026 17:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785101561; x=1785187961; bh=QNQQgNShbb
	Xk2HUywuD12w27LJ2uFVLDyjo5a4sqxds=; b=J3mPTEdy/ABSTwX3hZnGtZVsI8
	OtvvMN5trpbOIFvnHTm11egQu0tLdrLHvT7WJuvrBVEdGZWS+q1tYF5dVb+pFBX/
	VbadrR7svyO+8Zudw+GQwxe6sF4oWfgiFxIwlX9gjWq3VYHlX7YqugTM53zH01gO
	8YmeAvwLDzye9CypL8Sxy8VM88U8SuGFn58Nl9ECRJEkn1nt4GZwhljt96/Ko6g+
	+C330szaMfBnViT68jrJg8SBt8QNAUcgmxhXpxaURfvP8wg8y1ckimW3mxFSK4gt
	fjS5LIaiHPjZZXD1hJMNJOFGy75tcty3rzCnQ8jldUcQ4YD11N+KkvBcs4OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785101561; x=1785187961; bh=QNQQgNShbbXk2HUywuD12w27LJ2uFVLDyjo
	5a4sqxds=; b=KndikkKWVYCbOAslyrB6SIgeM+p6HQXKXeGciU6ghg0XdHgGIu/
	bf69/MDUBB5dNVLaOty6mQiCJvug7Dvo1LpTA+62DIz+WTT3Gu/gWspZJth7zG2J
	+DNGYHaB722Uu/diW20OWnvrcOtyOTIzNmMa14ob/iHrgeQnbuikN6RzJKwRFI+W
	w++IAM03VHqShL5j645qFWG63qPTSFiOUmIE4xsKwWRdHpLn/9jgW7W8Vn5Cvvzf
	T268cnuFQk8tLgeZgY0meLKCQ4Ed1R1kof7dGG3qWjNQZ2+K/DzR8IFAGCfKWLbf
	S1J5FcklCqeP86pDU37wim9z23bVMhqWWzw==
X-ME-Sender: <xms:-XxmatzPsJqBJlWzJyRREKv61zszuhdIYREMvPywBSo6_VsvTf-CXw>
    <xme:-XxmaksgqtABMIc3-wsZw3kBFsM0x9GOZeBZYol-Gc7EZCtGsM4kmbg8DAD98PrV6
    A1d2gQAoFCGbL5vj_JFegTtgi6RKvCIfahD9GVNR55j3YgC7h0>
X-ME-Received: <xmr:-XxmaksqFbXW7nGS5cWUjiYwTQQTQUWHz2GMZ68_jQemI92Vk_I-NNeQHMhCIW6yktLeswAyBDpOgW4mjrCjVKD9l1OSAqkJkA>
X-ME-Proxy-Cause: dmFkZTFkXsBCQCXjUxhnVp4WvMePAncpS+ZA2PvbsZ4ruFbzMcvn/twhhBouLaAL/RwLue
    35c/90keCr+DH+gKZaIBkjA8+qfP7Bj6p+tGmW6RqlCoqWgb7s9FWwlAnD1Uni3tSj+bpw
    FAHBJI3Y9MyT+Us6a+20V7w7Bdb7jAV21HTJ/yhbwbXmeMAGTsYBrAegvmoGGgTE3qlSgg
    9pqkkH8Ru3+HB0Tv2hZ2rZeUtQ4NS9j8zCAqWayaIyXI+RON0NSx/9ehUq404Bw+T5fE1s
    Q3Nq6gJXKaAt3HVzmw2JisQLdNhEMZ5pbYJBDe1USPA/XUAqO5Xwe+MMgkmgSb3lqZ29Le
    JuMiuil14pCG59cCEZr2UFhQQLWqgr7qbUyR8XpkyRgRUv1bA3y8xc0E4f2BgRTfJ72gU0
    KR74gnbqwWfj1SRo8W/25f4cSy9v1TO5M/pVoe8Fq7Yu4f0Bck2sg/J35YOgCH9OVWMgaa
    Fh+0/fbECF6F57us4fv7fT8ltTRTqRTUu4Pof9CPxnW9n0e5+4Qa/HjOCL+2GBi8wQQaKV
    /DodLFv9MlCbA18IiuiCcT9oV4wfGD0zOiw2p6/znKsMG3wmEqE+82BVmAGVb6OQBAcZlY
    KWrrFclrycbOXVuQndIjrO7L/oTnken+kE1hqXEUexbrmPRM2S0t2Bu1/J9A
X-ME-Proxy: <xmx:-XxmapPn8A0Nt7fdbtq-KLGPm0n2TjttIUVXjXJv8XtxsaGNrqRhWQ>
    <xmx:-Xxmai0nhr_C4RcgkDpDQIbXEJ4i7kzgQSyM5L-ls_HZdp3728MMsA>
    <xmx:-XxmalOdXkHFgwSYJfbhaRpEt66jsEpRH8-4qkgryNQDurD-EmZI1A>
    <xmx:-Xxmai2Y-EZxdMuecxtL7GeCyYFjFfyXrKXM0Eud-2LKf3B4mACYKQ>
    <xmx:-XxmapVK3rSr9idLjwBvqRI_5KocHmx1g67xmfh4s95GBpYNwvcMZrv6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 17:32:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] rebase: remember fixup -c after skipping fixup/squash
In-Reply-To: <c9631a42-ea7b-45bb-a153-0372784b8f24@gmail.com> (Phillip Wood's
	message of "Sun, 26 Jul 2026 16:41:37 +0100")
References: <cover.1784304378.git.phillip.wood@dunelm.org.uk>
	<7c8075ff2675976821a1ee979f86c7c46a35bd15.1784304378.git.phillip.wood@dunelm.org.uk>
	<xmqqtspo3x31.fsf@gitster.g>
	<c9631a42-ea7b-45bb-a153-0372784b8f24@gmail.com>
Date: Sun, 26 Jul 2026 14:32:39 -0700
Message-ID: <xmqqse55tp1k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'm not sure the space thing makes much difference as this isn't the 
> todo file that the user edits. We're reading a file that we've written 
> and the lines can only start with "fixup" or "squash"

As long as we are internally consistent, I would be happy either way.
All code paths that read what we ourselves wrote consistently parse
without a space because of the update in this hunk, so the omission
of the space check is perfectly OK.

> Oswald mentioned in another thread that he'd read these and they
> seemed to make sense. In general I find it hard to attract
> reviewers for rebase/sequencer patches - it is one of those
> features that everyone uses but not many people on the list seem
> to be familiar with the code.

I wonder why that is, though.  I would not say it is the most
cleanly designed and implemented piece of code, but I do not think
it is so bad as to be impossible to read.

>> I will wait for a few more days and then mark the topic for 'next'.
>
> Thanks for your review, I've sent a re-roll fixing the newline detection 
> in the previous patch.

Thanks.
