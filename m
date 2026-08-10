Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73897263F5D
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366236; cv=none; b=TB3wlCSe3ZVqvRGhIY4ufL41aWr/g0nkyF+CAFsQzTZT1Oo3el+kgm8iod0r2XWrR56+vs0JCGnSH5KJVGBjUiEphP2ytHtam+2YgQJ6S7oJQt1HSsXMi4gRS8+cyCFpgsvYPdl7sG1lmzryIEzMhGm/CRTd7f1x1EWU8QmqxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366236; c=relaxed/simple;
	bh=gR40G0qiVhUEOvPOrF4ie9MEw0AmxRqggVDVDxDWTFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJcz0jaz6aDqHIy4nNQwgU5Uewr9NRj1Y8FLR5MiW+EjI33IQ2iJN7jXGl80GIKbnwLipqsRnCD80KUG0hFGsL4PPmJioGc1S0tOrREeSrWj8Ksh7jtKfpN621InQkKRJPLgkt0kkWnMmHtENHQwwQAhtR+gcH9LlJ66/gvXtE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hHhR7XmH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SBfSCcKq; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hHhR7XmH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SBfSCcKq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E96E14000DB;
	Mon, 10 Aug 2026 08:50:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 10 Aug 2026 08:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786366232; x=1786452632; bh=1+roR7gwXB
	20rzczS02rgWw/ZbJf76VrARA9pDPLYdQ=; b=hHhR7XmHa3zJeQVlRP7nvGVd4y
	6oFyWC0k0pbjE4orgOTDW13oL9hWVhkTiBpFT4IlI6oA/XPe6yKFnskvLNkaCDQT
	MIH6ep2/IZ/gehvYpD/RFs/+RlSM/sBAMUYhb4/exgMd4mpqjjHl6B5l1tLD4VNO
	kibV+zD24nMtR/U7OX2xOR/f0FUn9jKeXphc6RKgYdmyVsd5g9m+S0UR+MzQ3tTG
	XjDDq+GDHyjmDAimhxScFokjHIJy6QdrYdbqlvmvoNapdfE6Zt+x8b9ckdh/pcZu
	6TsLcKT+UInNbfPUIxuIIFQcHcrb/eEY60qoFIJDbryXCdikF9zx5cfoXBpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786366232; x=1786452632; bh=1+roR7gwXB20rzczS02rgWw/ZbJf76VrARA
	9pDPLYdQ=; b=SBfSCcKqLH/52BUKf872pCPjfm2dQH1c8WprHc333D4uksCNJDh
	X20FeF8OOVIEMKSwTxERG1LiumPANSrplH4neouAnT7c69CpOi08Wb4jNPr429pO
	rtKsVeh3jdtFKYhRKjfp4P4WQ1vrPrGDrZvX9hDrH8Vd/xBDEZkCLkIjykHsfhrR
	B+5UC2oYPLJWOJ6JxIVkYVGXyHOMxb7uZd64Bahx2Aby0aObTPsjFPUSRikxEymI
	3z5+LFyUY86viEx847nPHqbMah1gdpb1m6eyeQDTFwLFh9rvxfjGbyAHe6agc8xa
	qk/kwR3DiPQ+n+fR/WpscO9Jwjt58iURzHw==
X-ME-Sender: <xms:GMl5arLlWoWvUBvm-2TysDO7sz1Jk6SUtpDd_J3obTfXAltETkWHlw>
    <xme:GMl5ai36moXwmzbpgU0yPYteJJtLeKjgSu-bhdPFtdy-T6H7kpD7ECD8VNJdZLZsY
    sHYYPwnb-lfJlGstSGkPtxAz9gNuEK1Ek-aL1zI8Ef6-2VeM_AA4Q>
X-ME-Received: <xmr:GMl5athNABCKyagF3mAzlt4xnE_b2igq6adH6STi9hmvVKZ45kPydmsBWgBaiOFs6l6__EezdhJ-X77BzdAPnQokpJSpOXn22pFbaWInLg>
X-ME-Proxy-Cause: dmFkZTENEe0ch5kRN8d8nL2KB3GL2LRg39V0YWGLpqIpOBxIO8auBFkVv64vqxxTfhJlCi
    VyLG9n45RAB2b+J1FJUbXCo9leiH8jkK7N5NR1WN05oHw89l9+b1LsjfqGp5BpbCGIYwpx
    YsgL49Nw0O7PrQllgxDvgiw/OGLnKUCiuFt6DyxhVzyaQl61zceOiS3uXNolemp3Dm73w8
    ICfFjDUreGh1VPYyh2X8KVscg4HVck2PNiQNGG34rkFdqg1o0bfj5n7L5ouczym+ginu6x
    zUJ4/YeXtw8SE/hIDW4hE04HM8taf1xBTbG1QafNplnmrwpRlmLw3JaXPvKgA8eQ1Rmnpw
    QDh/bwr+OC0z6xU4pkJ+z+ycAUFz5oy4mUppxydQYGr0LPJ02U1euKoN5f4wPD8lyEt0hg
    QRi/k0V/Bmo5SyIA6KvkVB2KJVcRkZugplrEZdcBvDEjO3Wdd0c3x0YrFLxnuvGtBdIa6Q
    2Jerzk2QLC++qtLyk9AYHS7UBGPpKk8S3xROftZ9qIgkwPsAi1JSYJI0XkwX9bSiz53wAk
    Kdos6iCOF0TqC8gZjzL/QdNtVDGi4525bh3oW+Wa6oTgRBxBsyo2vU8DzGfsUXCRoJS+ii
    PHy/2FKPs2gW6wmJhlO4KCK7TRaPm7QAYajdVRIyPmOhJ2aKXpqIjBcyv+Ug
X-ME-Proxy: <xmx:GMl5arWkHg002D8WPBMrrhzHxyDs6NvnY4LYjGY8dNYOx_dMbIhJ8w>
    <xmx:GMl5akWOWFEmTNb58e0wR0Wl7Za_VodQOKFzgn6u87W9nWczSjMBEQ>
    <xmx:GMl5ajiwUr937x4yRrRHlFl-EwbvS75xbYDKqXSv2vLJvjwzQPn4nA>
    <xmx:GMl5anbOL9JD9CVuNBJtYHqOtvnek8cGtz3AKAP8MCQtNk0sq6W2YQ>
    <xmx:GMl5ahXRZoJGBMBEBSrAli_N_gYtL_txKfw2YO3V4qoxiZlb5Sob2SWx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 08:50:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a3e296e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 12:50:29 +0000 (UTC)
Date: Mon, 10 Aug 2026 14:50:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Tian Yuchen <cat@malon.dev>,
	Todd Zullinger <tmz@pobox.com>,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
Message-ID: <annJEmkSoRIrhbpx@pks.im>
References: <cover.1786103607.git.ben.knoble@gmail.com>
 <dbbd96d50811e4c2decb6f754b56dc1f7ee0944a.1786103607.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbbd96d50811e4c2decb6f754b56dc1f7ee0944a.1786103607.git.ben.knoble@gmail.com>

On Fri, Aug 07, 2026 at 07:56:26AM -0400, D. Ben Knoble wrote:
> diff --git a/compat/posix.h b/compat/posix.h
> index e2e794cad7..51ee03233b 100644
> --- a/compat/posix.h
> +++ b/compat/posix.h
> @@ -487,7 +487,6 @@ int git_qsort_s(void *base, size_t nmemb, size_t size,
>  } while (0)
>  
>  #ifdef NO_NSEC
> -#undef USE_NSEC
>  #define ST_CTIME_NSEC(st) 0
>  #define ST_MTIME_NSEC(st) 0
>  #else

Ah, I was about to ask whether all platforms even support nanoseconds.
But I wasn't aware that we have both NO_NSEC and USE_NSEC, so we still
know to not use nanoseconds if unsupported by the platform.

Patrick
