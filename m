Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4036285CA4
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776934342; cv=none; b=S8EV5Vxby2RnanGtX+vdmEuTDbqzRZ3ptsgpQCZgimSXNvVcB64H4qqkIn5MlbBPO4QIwGKFVdYEq7dFr6tFlByeqOGqiBmO2dNHb8cjQnHbXWfjAHjA6JT6WCsPEQOf4jvBshEQKq3YbFXydy4Tqr+qRJg631LyuhBTwSLueUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776934342; c=relaxed/simple;
	bh=9sd+6oWpNTYgeBHMJ32ZnU4psmNcthRF9mJEE4PU3ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWluS7DM3O9cTFg/ycGyUBZcYqAheUMjp/sThWdBEc9CvTTvJ80rJLZAmXgNUgYr19HjLy+bdPA3yeBrMR4Qf9vNqChFHMHGscgvDN78OeSZEiE9H0iOr+2AUlzSM2emc/kBli/m/kOOhREe+AAN+5L7eVqgQ9Srd6AuPLdS3tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BpAWumTj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pXziivFh; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BpAWumTj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pXziivFh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 29D5EEC00AC;
	Thu, 23 Apr 2026 04:52:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 23 Apr 2026 04:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776934340; x=1777020740; bh=JuK/Ln84bH
	XMq26jwqwYOzQVM8Hr/laIirvOgHm9ql4=; b=BpAWumTjv4D5U2JNTVpCJ/666L
	nK8Zq6HNgKpau/6qRP0tzL32sgrI6qm9cwYgvwPyc30HvCpNzZ1rfvWsVLm9Tktm
	Ye61HCnSg/4jLoL+biYxAECMKe9Rb8xz7gHmLpuMuSBODL0U2c8SR9mYdFGUDTd1
	FfjeYZD+vRNj6xNv10Vl49D2LuOe4JeC/tdO/stxxclsew6H0GJrNR9CPewL0nwj
	MP5MjmlVy4CjUXg0j8nJBbKt4gjpk7CrE6c7FExszE496eGEXTSZB/YNxA4+sbnx
	gTFB/KFKhhvJTtSPl5CtHLt4eGWuIriJfEmr8AADBXnfyngD17XtzHgvWnMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776934340; x=1777020740; bh=JuK/Ln84bHXMq26jwqwYOzQVM8Hr/laIirv
	OgHm9ql4=; b=pXziivFhX8HvctSnIonaIhbWUqDHJgwgehqEIWKHf9uWOTdxiUB
	1w0d8/vDpMAJbEIHwzegesRQcbJqfZ3nazcQIouXt9hsmCrQ+Vt5ppJBw1M2n9k/
	35Lj/p6c92/57G+yzVW+1if9LSJlBGne0+HWyJbEFc4jz43Rh6xK+jIObWtnaP/6
	oM3zoB8eUFSrqTU58eYwvceffci5G9ARBiXuvO/CeAIpWANykRC8WGgTHjgdM3pl
	sZ7N4bQOjYa7n0vB0YpDGhqtcXEmJHL0IGoegorNV8yidIMTM3AHHm4kJiwHverf
	MgKXXjGwIztrkzQVrs7lnXOXolkdMP0WoRg==
X-ME-Sender: <xms:w93paSi5fz8rzxst2RvKnekwH8cSqbYSrYy2YnyoFXG5FOMX5ZkfMg>
    <xme:w93paae9bdzPDdHT_ZwRt4dLgY_nRuEZkJcBBsAup8c_jU1aWpPCSlvq5UMK-8YPQ
    ggYKHC90iwsRK57xsOsz5AF78edX_ux9kf_QqVDbYl_jL3I-Jo>
X-ME-Received: <xmr:w93paXfSj0_EJnAEeflth2d5pVZjET13dd69Nkb-2tXZkhKQPUwbQZI5-tkWnDQfqH1FwFngVHRC7YqivQ32pF4iBO4jl6gB3MSfjseq4gpo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiieejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:xN3paU8K0jfw6cTD3bgj-3jLjkL-pSpd35zi6ClZmk_d8msMpvD_gA>
    <xmx:xN3paTnZ5ua7SUxT5fJ_wYlx2_Njs52KLR4gEchkPIESHBkW0lkbmg>
    <xmx:xN3paW80kXAA601uQtoJ22FZbgckQh9CK1F0A-NRMGD3uCZi1EqblA>
    <xmx:xN3paRkXFmkDs4NRifrTjeN0OgBvqC0fho8N2vtUyINDNXJFi5HQeQ>
    <xmx:xN3pacFhgJh1z3AM-mthQarCcm-aZKH8mKRdMuCxeUsEKvOOcjbSn2v0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 04:52:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d39ef49e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 Apr 2026 08:52:17 +0000 (UTC)
Date: Thu, 23 Apr 2026 10:52:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 2/9] refs: introduce `ref_store_init_options`
Message-ID: <aendvlxDYMHNn4Sq@pks.im>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
 <20260423-refs-move-to-generic-layer-v2-2-ae5a4f146d7d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-2-ae5a4f146d7d@gmail.com>

On Thu, Apr 23, 2026 at 10:40:31AM +0200, Karthik Nayak wrote:
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index b3b0c25f84..78150ad209 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -120,11 +120,13 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
>  					 &ref_common_dir);
>  
>  	base_ref_store_init(ref_store, repo, refdir.buf, &refs_be_files);
> -	refs->store_flags = flags;
> +
>  	refs->gitcommondir = strbuf_detach(&ref_common_dir, NULL);
>  	refs->packed_ref_store =
> -		packed_ref_store_init(repo, NULL, refs->gitcommondir, flags);
> +		packed_ref_store_init(repo, payload, refs->gitcommondir, opts);

Is this change here intentional? Doesn't seem to be related to any of
the other changes here.

> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 2d963cc4f4..f49b3807bf 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -385,6 +385,15 @@ struct ref_store;
>  				 REF_STORE_ODB | \
>  				 REF_STORE_MAIN)
>  
> +/*
> + * Options for initializing the ref backend. All backend-agnostic information
> + * which backends required will be held here.
> + */
> +struct ref_store_init_options {
> +	/* The kind of operations that the ref_store is allowed to perform. */
> +	unsigned int access_flags;

Smells like something that should be converted into an enum eventually,
but that definitely is out of scope for this patch series.

Patrick
