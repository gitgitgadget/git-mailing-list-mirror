Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7AD3B0AE9
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901031; cv=none; b=ekWyKcdlItBtqio0Tl8LrQQLYVi71eD+I86afUlBtzylPdx12FlXtU0njXCIZdPPfCop9r4XYWKmU/gWYm3jGnjJsFuKYmA/rjZIwWEnG+hE3Lqw3rST9B/pJMy/RHkhmxBD1ffsjPAQ/QYYY5iXDmLPan91kV/bXUpxFcdfpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901031; c=relaxed/simple;
	bh=3rHXCQTcAcDeAypkyVW1c82bfK/ixsfxPj7P68TviPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gpsQGAMzJRdzb2g5S47relF0aNHxBhv6hipe8CjbZR3/qco1LxQgdXOYesMwboCszzbnrkB1bN6xj6o2tSX4Np6B7WzjK6FGcLJa4OC8MTCCKzlyQCbHN0J1er2T0nVebhVWZaljSlI2jz9duLtcw6vK4LrPuYTpvtHFOYAzyKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XUnF3WUb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gjXb8CSV; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XUnF3WUb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gjXb8CSV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A164EC01C5;
	Tue,  8 Sep 2026 16:57:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 08 Sep 2026 16:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788901028; x=1788987428; bh=4wer33HEnD
	Lkm7yQIUeL5NFYJw7djwSWv++o/odIOos=; b=XUnF3WUb9Fq6n2qs4uH5MnWc1J
	zCGluxPsbe/o7od6SdNRyGLtoC2atxi+QL3DyPGMZdCNHU9vYlmK5w41wE/DZOnd
	vBmOeS9cxqXceRMsZHtOgTbadsorfaGSBJ3ZC6FPywgg3zNj0I3RwZWdkgWAuZXh
	qc/OZgyX/X/zmHbA0APIGhhJlc4kh0cJ7TalP7R9bZGySVJPaGD87qV2aTQxeLI+
	tWWosOcYd95aS62LDOGEGeAvpdR6XO016BdKCUXsIZi6fXGBlZT9UtlGd+/tKTL2
	P8EkmOeAKoQ0EoJafwtDP3CLPQ5IiBDsqTSD3bCYSIm3ig7oKqeD3pdL7hPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788901028; x=1788987428; bh=4wer33HEnDLkm7yQIUeL5NFYJw7djwSWv++
	o/odIOos=; b=gjXb8CSVh82xII84gHjYhCIaKnavislXBMtrmD5nDll8pgwjxH3
	a08tcrW6oAr2lOn2We74yll+5UUgzEAIUI5jANCP17RMbwePEwscko+sB3EiesB0
	a7+WE+04U4i+PpyKsUBVIG5V21s1cSIgSuHmWVJIlagXvzYrVH4kKoD2zTTrbgKj
	kysXrRn5VD0pVaZUcfM5TmXxpuyHv8ZYrOtRzdFKQviEhW0PPWTnUG0EZSJAs4v0
	XrSv6i5gubjSxYDcBeEaWOWgJc13Q5gf5OyCjRwVFRpoFLB/qQzzpJ6UXy60zn1L
	QCvWW+DqaeVCwtfDrjR7E13qfCc8LKfC9/g==
X-ME-Sender: <xms:pHagagkJrY_uEptlldjK2ld5u6PCuqz4kAGsculMb5A-ENJPwv-peQ>
    <xme:pHagasbV4jyhdpp75mqAQmpEXoGdH9y05UCzBBv8RVTDyalS0dmTZMqH5cscG5rXe
    enYEEz59zt-hIx3mXhPnLk5KF9rg5povhtvn5zQCbHPOKOzC2pDfpc>
X-ME-Received: <xmr:pHagajEi0_KYWFX7yn5gQpiRoNsydCBc-2CHSRIEYzw2ElLcZQcHMhd3-RrECvLm7JS_90Kn4opz9iePuRszouKKBirwirKACjE7>
X-ME-Proxy-Cause: dmFkZTFLFA8vJBxaD0W0uqRnUHiyhoiL1p71G7T3YuVgS7N6I3KZNy2/p/5todQE0OvCFA
    9E9ONPfkU26hkPh8h/qUteGIGd330CSIwCK7TTHpS/K5Ovx2p+IeGCMIgN/DrkjH3NVmHk
    f+VMqybCUaSL6DIuNLwC/NiQKX8j4L1ZJeen1xGhpPeHJ28JtinmkruVc/R+PwO26810tc
    d84OK32BiWjaGL6g41JUG4kMWXdJXzJvegJJxoYePs1AV1sepp8mMp3BQUw7QxiRO++i98
    w+skHAYEA6AkAqQlQN/Wj85hs3jopxQuTR8B1VOdow1Tx89OwUjhd7dvZWPNOsqpENoZL3
    55nisMJIpI1Kx+NuMo4Aiy8ZWPunzVM2H8OS7/1y1DecfbSc3a2eQgc3UBjPDNRIfCZXe0
    tnLlSk2PdyyKX9b0OXrgUHFdSSTHI2xKPdI+S2skOBKeBxq5WQUbWK9yte+gkZfl6px6M7
    Nj+cpM2LZp6WOkZGCTplFSfCzM+166oboCxTXE2JYdXcv7sND6MmhPVNV9GHqG3sFPNaN+
    5LsTlFaB+Ub6+r0yN26OY2ICa/IxD173s52FlQPQ+W/gfZsOrNiXP0Dhu6jfx5DQtYAebK
    SqSfdSlSpIYJLKAzzX+tpIzu274dt5aR+ecn+5fsjYdmQYHwWWcTbW86mp1g
X-ME-Proxy: <xmx:pHagajaWPkhPeL2MK9nRpoBfRaUz1zuBJ6T7mbxcN1kFy6PaPIzl9g>
    <xmx:pHagavxQgKfGEWGUqV6KVzEzJSL-ERL2mzz9WMQTeJIrJ16_e6vLfg>
    <xmx:pHagatRat6MNiZm887acWS_xG-z0MmdBv3xxyJAT1IpTsV6cglBXWQ>
    <xmx:pHagakKN3JfSDTTRMHGmEv0RyGv4iSYbzovsPZM0lYTc9uPUytjxOQ>
    <xmx:pHagap3jnKw-KyjvCA9Nnbq36vHMkjWIu_tajcHi4QrCl5ay6_u2OGgn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 16:57:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Matt
 Hunter <m@lfurio.us>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Tuomas Ahola <taahol@utu.fi>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v15 4/8] history: add skeleton for squash subcommand
In-Reply-To: <8ad1faaa9a4ab71560b4e9321886706164518e9e.1788900120.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 08 Sep 2026
	20:41:55 +0000")
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
	<8ad1faaa9a4ab71560b4e9321886706164518e9e.1788900120.git.gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 13:57:06 -0700
Message-ID: <xmqqik4fv4v1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Add the entry point and option parsing for "git history squash". Pass
> the remaining arguments through setup_revisions() so the command accepts
> revision ranges and rev-list options, while restoring the ordering and
> simplification settings required by the fold if an option changes them.
>
> Require at least one BOTTOM revision. The squashed commit needs a commit
> outside the selected range to serve as its base, so a single positive
> revision is not a sufficient range.
>
> Keep this step limited to defining the revision input contract so graph
> validation and the rewrite can be added independently.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  Documentation/git-history.adoc |  1 +
>  builtin/history.c              | 94 ++++++++++++++++++++++++++++++++++
>  t/t9902-completion.sh          |  1 +
>  3 files changed, 96 insertions(+)

Nice.  As the "complete 'git history'" topic is now in, with this part

> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 38cf221718..978c42c629 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -3227,6 +3227,7 @@ test_expect_success 'git history subcommands' '
>  	fixup Z
>  	reword Z
>  	split Z
> +	squash Z
>  	EOF
>  	test_completion "git history --" ""
>  '

being a part of this series, I no longer need to worry about making
an evil merge for this ;-).

Thanks.
