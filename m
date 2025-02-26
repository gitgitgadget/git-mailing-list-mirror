Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9C258CD1
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574571; cv=none; b=U2AyWurwOu6Wk98U/AO2Pp+w43e8xC9LowvElvotRiPTb58QGz4SlORxYaRPfiIT9G6cqX+x6A3St1QilKbd2t78WrjsaOTaTbHOUJxAWt/vgjbwZBHk/UciV7PqX4u/thU/GedQCjpwbltMgICd5ptmGid5V604inC6h+/Dn3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574571; c=relaxed/simple;
	bh=FIzIbm0qvMeHuZfzTHWsG97OLlDLSi9GWvV2UsnJnHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=obZTpqNICcaHyFYHyKuiBvqYxS/f+v5efsw9ccCmyL7WSGekHSLVGAbzj+ccy5zd0UPuU88y6IqCNhwTYxTeKY6MndBNbfbexg4iSkSYdO3Nhu0No8ODV5V2K0pqvFNlV/SNbDQZZ33X/7dZ2RPAqh/IX4vjHJ6VB0TEUiFu/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pMpMr3yA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hm7LOfjz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pMpMr3yA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hm7LOfjz"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1833C11401A4;
	Wed, 26 Feb 2025 07:56:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 26 Feb 2025 07:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740574567; x=1740660967; bh=m+1/resmOf
	UZgdF/afxn5vlh2OKqWMcEipSt2iVaqz4=; b=pMpMr3yAXonlsDQkzMvv/th2FU
	7TS2AcULHrLy6E7Fw2IW61V00EJQT4x6PxThv2HTwKJZMWATDSeyG29FGX1QbYD9
	FXuvKSPkUSetw88JJx2edrUOoShyCyetPTTQhM3QF1N1YZwWLJ/EB0u2UnP1R6Ew
	xPd8OdDl0FBqbdmT2ZA9nUQHOUzWjfzAlKFm8jdKXV6hDCFCLDCM6iby/HedAY7v
	6n1hdxNpzosyWedz9Fz0afpeeUtTJm0fylK2B6Mmn/WROtpN8Q01MW/Y7ZKRsH2o
	ipl5HYMPTZh9sBpoxnqshYeV95oi9ArezirJL49NFiwWgcIx8ZKBdnNqn/mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740574567; x=1740660967; bh=m+1/resmOfUZgdF/afxn5vlh2OKqWMcEipS
	t2iVaqz4=; b=Hm7LOfjzQ7blMCd0JPpXyS8DMn5YVCcjHSw0N5gn9kjUTCdwyiC
	j9sX0l5cOKyuOx2VyG3cLgZgzVly0RGgjJPDRVtqz2qqvz3vmr/LYgnJ7AXOTEfp
	BLKZCLU5trAjwgVacyy6aba022beBy/zXGMl3liAZvsOKlpFtoRD/J5l0oRPX1YT
	eaq04BdEQlBQr3Mftd5l4jMaQQNj1dIAybsGiqEtoh+fniExtxQmKFXgtwxwR6DV
	Ux6+7TptNx9oa66jyZ9FcjZNTbMQMNFf/9iRMF2a84vD5Q9+nsxyGlb3CE71Xn7J
	1kaaHG+99rd5HCjc80vQC/RHlV2ZRbKMb/A==
X-ME-Sender: <xms:Zg-_Zxll58hA89LwjMSzvhke7p7G0vGfNJgtsNuPj2pXL2_Bsesvxg>
    <xme:Zg-_Z82dXJiAXLXQ77abLX_W_hqWF1-T_O-8Z01Lg3K6PEofx6Lcm1wtJkqs-9mfT
    x3vlJB8308zEW8Ppw>
X-ME-Received: <xmr:Zg-_Z3q2kUtZOD7vuz4FRphO4G92iU6-Xx_n5WG2EYZV46bMoNizMn7_QTLouJvPf5zvo4PygJ5BEMjI2DNQsMcTTD04NhJqCbrn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Zg-_Zxm6V2B59wsNzPog8LWMk1lWX4d-c4NtKKn6z4nqkC9YmXaVrg>
    <xmx:Zg-_Z_123E_wph8bWrvdbKXnEsJQpUz2ZxVgIuj97eg6Dqcmg6pG0A>
    <xmx:Zg-_ZwuU6Ku3I_x0Ien28_aswCU3Ql3hVNCrOZ8YeF07aFlTx396sA>
    <xmx:Zg-_ZzV8yp0gHCKhIpHzRT55dw5ybJAdoZmUpGUI9VrqpBg3Vc8tWQ>
    <xmx:Zw-_Z6R82U2TaDMBfBguC1kmQrwcNyXxIgGCxzkRfr29mXVsamdG_bUq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 07:56:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 04/10] unpack_loose_header(): fix infinite loop on
 broken zlib input
In-Reply-To: <20250225062958.GD1293961@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 25 Feb 2025 01:29:58 -0500")
References: <20250225062518.GA1293854@coredump.intra.peff.net>
	<20250225062958.GD1293961@coredump.intra.peff.net>
Date: Wed, 26 Feb 2025 04:56:04 -0800
Message-ID: <xmqq34g0hnkr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> diff --git a/object-file.c b/object-file.c
> index 8c9295413b..5b2446bfc1 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1396,7 +1396,7 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
>  		strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
>  		if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
>  			return 0;
> -	} while (status != Z_STREAM_END);
> +	} while (status == Z_OK);
>  	return ULHR_BAD;
>  }

Ah, fond memories.  I do recall we had very similar bugs whose
correct solution was "instead of stopping with Z_something, just
write your loop to keep ging while you get Z_OK" every time we
encountered them.

