Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A443546E3
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847019; cv=none; b=CFlbPXZEkr3pCEvjyzpTg6Iew3bZZU5T4PwqZV8GENhBYFZ8NyEQSDGRxvziW22T+fNSH5TxDs9a4xVTaaqtQv4gDi8Chq12O05IrtLn6UNug4MZVpuhwEiEBQsouRO+xUdB2eANlgXjUCG4UGFKLapujVHPBG0a3reo1zBP1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847019; c=relaxed/simple;
	bh=+/FhRbmVlwd31JNZmr5lkStFYb0BkNjEP+/Q0x+hEPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Il3Cy3QT/ZNH/r/RgHSiMfbuOrOyShNdznwDGQSTs9Q8YtoO2arRTTOlfPcerBcifS4x+UV4JSa108grPTg3JtnJIZ0h+1HCpNmh+73yoKrTO9QkAR3ZBc9brvYqLwH+ZxxGg8jN97kyzLPOlshVKasL2zfMbZPD38F5qXeGe54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iSWOWedl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uqcn4utm; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iSWOWedl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uqcn4utm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD4951400104;
	Tue, 30 Jun 2026 15:16:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 15:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782847016; x=1782933416; bh=iNaTSfTF5t
	/HlxMJ6Ty9pyQHh55RS8B1fSeR8dj6vwM=; b=iSWOWedlKZzWXMRb3xzMCKAAdr
	wt9yWKV1kOX/JWqltxS/SDaP4cJhdGXb/7ixc5zlJCyhQ6+9pHHK3vKrtkmUqAky
	yoqGELRRq6BHSVFRP/AhG9MEhRmQxqhEEYwy+p86+y5Q/yhhV8NLllyf9Gyrtoc+
	5F+tJeLaU2SMgJrAgBXy/j/8Kn5vIqLb0q5iaA1vJaSclwYerH/cOKH6hKaA+z08
	g9k04PKm1LU9is0ccEiBBtB7FGxRIloReybsaA66IplxYGPIiHFyu2w3uW1hqKFS
	CLjVLfwsrPiWW1J8bfFOBlaChC1bSAzYgtkeXN/uvfZJP/7Og9/YDas+x6Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782847016; x=1782933416; bh=iNaTSfTF5t/HlxMJ6Ty9pyQHh55RS8B1fSe
	R8dj6vwM=; b=Uqcn4utmnOEXHxCMp/PiUddFS+BbmdAu28tjSJ5okdRcvNR+ZrW
	+IsOKw4vrbWaeJTgEl6Frr3y2TgUNfoClHQJIlRf6A7MLf8Ms7/hiMPUR7sURFpw
	1sw3vmTrdqBd3Ura3ZrY4cfFCk76IX5Fc1tKeg0zRcKcEiL6RwFsCndjcq39UnxN
	saRi7N4vmtagg0OaB/4bEvR8TTp2/64ROOsqiQUj8EDgd8KmreCgjumGZ2tUQPT6
	SRIaVgIjoI0ICoh0T9KRkQrMBvkzy54EPgXZihl0Ze+gcbzbDWmZZ7tS17gJZuQs
	gOoozhrXNJzuETkZ01mqBFLnqreIrbM/WyQ==
X-ME-Sender: <xms:KBZEavxAdPi02TwHWfTbTbmp2zK8x49ggjIMbagt1gNQaNZfoNnwnA>
    <xme:KBZEausKBF69_8wz0OjnwcRqr6DidjeGoaok0GUyaLJvm2QKnOo5l3vUSiZkDC7F2
    A5BeeMQL9LS4KYAnyKPq-jIvCJ0Qyvxh4imIe5q-cHSO3wt8QLJ>
X-ME-Received: <xmr:KBZEamvQqbjFr4Qt-tK1jGmVnrlW9fTI4XlSi-dA3vOjue3XYUHWXclhwbCMAvBtYnqEWt5MVbr44JLlRP7JoYy7H3MroytXsF-I3Yg>
X-ME-Proxy-Cause: dmFkZTFCHJ0aFvRwmwe1a01zaw71k5b+2oiX5GAxKjXKlDjxyQjc4lOqN7fV2a33krJxVp
    1WPD1TTEEGZRuC5UYvdxhHIrhz/0QbRCWj8WawQwb7SNOXrYdr9QGAzTr/RP01it+e8JGg
    EM2KoKTzeYjlPzoxpIrK1/H77skdv1de0BiXpI+w3qqj7T/GFNHNVo0vX0MhVJ00Dlk4QK
    petPGfoOCWOiYaeUADn6tFIms52DO3FlOuSLf8/VGSRrb/AiOwtRnIibjiqXA9s68ZtFKM
    8Zh5RpquawsPWNdVFVNUm+SXo+ThCfGNSs1EiIITN1akx0ZC4I9Ax3BTEIdrp8EbPC2+Y4
    hBeri1gumUQ3saJuQ5Iyh/lP6dXOtp+NYZKPJdMlWUf3OhBkczzSOiPEs+CmE29A+na/gh
    6hQgbHGIxQbkCXV03u9+z3wHf3QFNoppxiSjmumRqAAmVqZ0OfimngB+IDgGLmoYBvkY81
    3Xhc8S4VLpLbAHj7g6tbSvrw6NFFbBqcpA2S/T3QthEpqDzBZb7eTpfZdbU7jvnEaKgj2g
    22XqVWX/TYG5wmDSnotNBBwQ8asc9vEoruof26IM/+KfPresxH8746vZu54toTHgkbLaIr
    44PT1B5u4o2+TMaim3BWfPaOz2MV47MHb7GiCE6954xHaapvU1EXYR3CCTAQ
X-ME-Proxy: <xmx:KBZEajNj_Aa7g3EctmaR5DU2kNNkP1gcBeSByEgnlKWhEmATcvHO3w>
    <xmx:KBZEak2K-9GrAqplWu9JfadSVl3JdF_XW0uCibDNec4CLoryQEo73Q>
    <xmx:KBZEavOR6LWQVdUFT7UtwTHlLKormcRIMgctr-o3Wl9-8ohHq9enHw>
    <xmx:KBZEak2A_RrFh6HK0yoZ6J_lSfPBOgvDSJhSKGECPaJEFak59n4UdQ>
    <xmx:KBZEam1Krt5kNso0O6OfVnBK_y0qLNiEbnV9PewQyS8BmXQQDZewM2Bn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 15:16:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/5] builtin/refs: add ability to write references
In-Reply-To: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
	(Patrick Steinhardt's message of "Tue, 30 Jun 2026 13:49:03 +0200")
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
	<20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
Date: Tue, 30 Jun 2026 12:16:45 -0700
Message-ID: <xmqqcxx7susi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>     @@ builtin/refs.c: static int cmd_refs_optimize(int argc, const char **argv, const
>      +	if (repo_get_oid_with_flags(repo, argv[1], &newoid, GET_OID_SKIP_AMBIGUITY_CHECK))
>      +		die(_("invalid object ID: '%s'"), argv[1]);
>      +	if (is_null_oid(&newoid))
>     -+		die(_("cannot create reference with null old object ID"));
>     ++		die(_("cannot create reference with null new object ID"));
>      +
>      +	ret = refs_update_ref(get_main_ref_store(repo), message, refname,
>      +			      &newoid, null_oid(repo->hash_algo), flags,
>     @@ t/t1466-refs-create.sh (new)
>      +	(
>      +		cd repo &&
>      +		test_must_fail git refs create refs/heads/foo $ZERO_OID 2>err &&
>     -+		test_grep "null old object ID" err &&
>     ++		test_grep "null new object ID" err &&
>      +		test_must_fail git refs exists refs/heads/foo
>      +	)
>      +'

Looks obviously correct.  Thanks.
