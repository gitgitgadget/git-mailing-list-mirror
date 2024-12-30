Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8CE8F4A
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735543525; cv=none; b=SNOmYNarox4vQBQL7+o/5oNnfHpGIIQkgQ2wlMHTXeA18b0A0bdyzHEO51SWbWAe7CBFNpKfVOBQ6laN5S4d5SR8YqI9i5YMDlAz9CDNn7EnNAbv7Dc7wW1TA80TU1KNIHbE/gzMIa9tb2a4UCn9KkuLg4y/s5hOAYIMXEuunxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735543525; c=relaxed/simple;
	bh=hD+gWwQkCyBIh6bINkHv7dAf7u2ONhYonK+vae6N68k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6HVK6XUxhRkJam3bTVGOJ88xikhMgspba4ZwLofIR4gOplGJPXZadG5FZ4DhQOmtYQjpOv929FhO2Sm91WCBKIdJ03W+tarL63bYopCH5G63zkoq4QMGjqID30me3WsvsQE6QJxqoMMpzZTGwx+p4QI3WNyvltZ56UmAxIAsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=u+QQ/pUg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=arHXtyCP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u+QQ/pUg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="arHXtyCP"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 266E4114016D;
	Mon, 30 Dec 2024 02:25:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 30 Dec 2024 02:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735543522;
	 x=1735629922; bh=QJxz+eguqI1ykfcxy1iznbwqpDfND/tTfAL7pv+j3pc=; b=
	u+QQ/pUgTT4ojPIXgl5IRzIrNPzNGUpVNF4IT/Yu1LLUBlI8E5+NpbMUHWeyk1VH
	o3LHr0aRzhOOaImIMGMnOtfRFP/t5FberAzNkDW41+C9C8fCTgcLiWwN8RxZz6AY
	szOswgMMnGiX/AvBMjcFtxZ3kb9G+Zgx/JjVHsLZssWQtCDYZHzk+kgFUouAFWJ1
	75St9ajS7q8cPYgyJ2l1jrqTIlgspfxsU84HYFrKDnFfxgha0piOXHlWWCZkiPVf
	Cx90Zk6T+hDALynOEGqGvlV5IXZHtkzE2RJWCepJU+oKnSRKl9qpArRe4a/7/Tb6
	0Hte/8cUANh8GnxGwsZwGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735543522; x=
	1735629922; bh=QJxz+eguqI1ykfcxy1iznbwqpDfND/tTfAL7pv+j3pc=; b=a
	rHXtyCPmPp+ogSRmEkpXGpd698/mgXvbQcK2+VilYCs0c1SYSGIRSfeiNL+l8U8i
	0KXCTMIuwUSdAwZ/iCf86DjiSLumdit8g8T4a5lmMtVz21EUulgwVYJOeBHOwbWu
	d0KXh5ApSRJQli+32zopX22lMqeoOBxhFSXxuPwjKnMy3ZQp4DFuKh+8mGkGuGmG
	oWrnW1fqCaRKb0ehvfN76d1u+QzgalpuoT9I681Atg/e4873SJ+dmFtQKOn45q1l
	VeUXsIJXvPBEHwn6csf9hKEP2KTkTdUqdeL6gP0yVXjVvmIvlOtCBqMhsMC+SZTc
	4bJScvBzbr04HDTiVqKVA==
X-ME-Sender: <xms:4UpyZ4NDAKbdGorfz4UNmF9FbziI1dpw-k8BHE6DcwE6W9gF0X4o3Q>
    <xme:4UpyZ--MfgkYvUi0j_ofIbhRsCkVAzUtknIY28QtsKxX9quvirTNN6H9sHJ1HRXMF
    u7f2mR_w6vooA6Cqw>
X-ME-Received: <xmr:4UpyZ_QTNeNUtAWhV2fDIxGr6QQBCpmB4CCxEKkVgiPVkaGLB_aT6ePJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvhedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvfeejie
    dtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdrug
    gvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4UpyZwsjWq-Z1VV6ctcrcrkZuTj8loEOE5zO8TjMRQ0Lm6k74E5eVA>
    <xmx:4UpyZweSRLls7d1fp_ft5X_yHeLIu04ucnjJQD3oka9t9sVr_IIW6A>
    <xmx:4UpyZ00Tv66GmssnsIScmDaMQOBi2H0kiOt-Z0fOBpBKszYStgnTWA>
    <xmx:4UpyZ0_3SxY2VagSLO3oA7PS7FWpFROVZ1ahYhDzzASG5GElZCcp7w>
    <xmx:4kpyZ461Z7Ytioai-9Jw6pJV9p3Ep2URderqpci9xwl3qQX1IdTJxK77>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 02:25:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0e8af130 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 07:25:06 +0000 (UTC)
Date: Mon, 30 Dec 2024 08:25:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] reftable: avoid leaks on realloc error
Message-ID: <Z3JK0sWU-vITVl1R@pks.im>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>
 <2f12efca-8b38-446a-a4a6-f80898275acc@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f12efca-8b38-446a-a4a6-f80898275acc@web.de>

On Sat, Dec 28, 2024 at 10:47:05AM +0100, René Scharfe wrote:
> @@ -141,5 +146,30 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
>  		check_int(in, ==, out);
>  	}
> 
> +	if_test ("REFTABLE_ALLOC_GROW_OR_NULL works") {
> +		int *arr = NULL;
> +		size_t alloc = 0, old_alloc;
> +
> +		REFTABLE_ALLOC_GROW_OR_NULL(arr, 1, alloc);
> +		check(arr != NULL);
> +		check_uint(alloc, >=, 1);
> +		arr[0] = 42;
> +
> +		old_alloc = alloc;
> +		REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
> +		check(arr != NULL);
> +		check_uint(alloc, >, old_alloc);
> +		arr[alloc - 1] = 42;
> +
> +		old_alloc = alloc;
> +		reftable_set_alloc(malloc, realloc_stub, free);
> +		REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
> +		check(arr == NULL);
> +		check_uint(alloc, ==, 0);
> +		reftable_set_alloc(malloc, realloc, free);
> +
> +		reftable_free(arr);
> +	}
> +

Thanks for adding this test!

Patrick
