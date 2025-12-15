Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9400825A2DE
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 05:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765776807; cv=none; b=nrXiWLVFtoymgqViI4Uoc/FvGjkZ416yAfjTHMmqO5p3JxLiaapL2tZMyiRy8oFbQg3/tWSXekqJq/OSuRRFrhbwy2Fh6MF1abVD+y3EccbWNf4SzGnPFelx5qlY8hj1o1n1o0/LOHcvke7SCg93BtvwE8uFW6NNoCWdAa9Faxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765776807; c=relaxed/simple;
	bh=bgHVZ8l8bHwyh24Ki74ErNZHqIObBhklDVO90LhBmYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSiytE6G7Om1k+FdXs9JIzaVwDJ0dafRm4d+NgYy6IikfyiWghQRpJ/xXvePeq6VhSHr4Y2mF04lvS1ag/O26+85V7fv0jVAT5yafbMge0vWhKWPJHrPzStPZirwMreBO1JEV2zvQJyty+UscheOmgpuu3DzBcijPk4JCUHn5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nMCW+LN9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IWc10uNQ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nMCW+LN9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IWc10uNQ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CDCB5EC00C1;
	Mon, 15 Dec 2025 00:33:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 15 Dec 2025 00:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765776804; x=1765863204; bh=m6/P5RZnoX
	ZGEtiON/udeK4SmH7TpXluv/nllbD5VAE=; b=nMCW+LN9xBGuio7rfI0AMSNA1C
	aUkufftFI9WQIHw588OCAjrrAt0QrKz+QpWZ+YfI6QLt7EE6dzJCJ5kNshdyDcVO
	fN28sQlDCeOX54YrqePH2A/A9APeERm7TvfTeogjfdoyxcZ69LQ4ttF9HIYDIpsy
	RG6X5oxcGCbC3KhnrgCX8Ynjxkrf6pMtmFq3VrVBElx15WhVadswZslDdeO3PqAx
	HetBbLPgdhpkcMkKq1Ov4gHLBI54aor92cJcCzcjMASLWsv2uLRCLzLdCQJXlt36
	704CkSvYxRI3dNLMg0sRINSbnHV3cLXjE/VnG7Y4o7nvboryyEBQyq9JRLCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765776804; x=1765863204; bh=m6/P5RZnoXZGEtiON/udeK4SmH7TpXluv/n
	llbD5VAE=; b=IWc10uNQHLKGW+QYYjoVXfZSSAWR/5OVd4Do4SRlDioOi3cjgid
	7fwbFpjE6nYg3JM+tSlo0y5zdJM3B2VcyhxZsmRT3G+VHraMgBRzOrgHo1S87Wz8
	J4Xy+4HlCYO0HdXjs5gxgoJpkqpR0dMs6TPghy2243NDgj8Q/9Wb2QiAV0myAC5c
	wFScqiGPqv4IXoyLneOnP36KJtxvJe1f2x8iazMnMceIG9Xp2FPdBBOVYpaV9+fA
	ooB8w15CE/K59jWnRVXbba/68fgCn150sL0SgwTEGfTK8IsVhbzTe4n9McpBZGlx
	YHpXWS9zVgYtcnQN4DKiMiP7fD/RMQ+10gg==
X-ME-Sender: <xms:pJ0_aYPnmJ6H_aGH9xL85eCu_KRXgiDzhPUZ7ebKLI-okoeK_TQ9Lw>
    <xme:pJ0_aWY8sJ8eYMp9lOS4aa2pxk6-tP7hPwUsvXl4_ZZmRJVrsm3wCT435WT_QmrR9
    YYBPLrXXx0_cqYfcL7WOwvo8Onq5rVhoTHDwpKLMf0ekbT6o7dh>
X-ME-Received: <xmr:pJ0_acpj06pUoxZUfsIk5O5QbsSEgzS6k6k0dD-711mauA203b-T48oAp2fHaGD_tok4g8PERPq858HZ1LfoHYEDPSu89gNPqlDGMiF3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefheelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:pJ0_aaZ8q7qawLfAWaBnmzi9h-b6YZvJMTfMiGqKTtx4s4sOmJ6jaA>
    <xmx:pJ0_aUSyatS-U4Q098odAXlt47JTsnQ9rWbTQX7XWiHnBKUV1BrEJw>
    <xmx:pJ0_aR6A2KZVsAaK6rJNeFtQaMlf8rTJDNXOXyGKjjzOXfBlUp2yKA>
    <xmx:pJ0_aZyKxBqzizbSjnZMALwDwQOZyoNeM80p92UbZk9w_nS8r6BAkg>
    <xmx:pJ0_aSYiudFrWYX5WdIRcghij-JEOxHsj-hVFP-C5Lo8q1_sCavNpiqs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 00:33:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33622509 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Dec 2025 05:33:23 +0000 (UTC)
Date: Mon, 15 Dec 2025 06:33:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 4/7] builtin/repo: add inflated object info to
 keyvalue structure output
Message-ID: <aT-doNe94GYmodQl@pks.im>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
 <20251212223644.3090879-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212223644.3090879-5-jltobler@gmail.com>

On Fri, Dec 12, 2025 at 04:36:41PM -0600, Justin Tobler wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index d3dfe416d0..3a2d15cec4 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -500,20 +513,38 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
>  {
>  	struct count_objects_data *data = cb_data;
>  	struct object_stats *stats = data->stats;
> +	size_t inflated_total = 0;
>  	size_t object_count;
>  
> +	for (size_t i = 0; i < oids->nr; i++) {
> +		struct object_info oi = OBJECT_INFO_INIT;
> +		unsigned long inflated;
> +
> +		oi.sizep = &inflated;
> +
> +		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
> +						  OBJECT_INFO_FOR_PREFETCH) < 0)

Using `OBJECT_INFO_FOR_PREFETCH` feels a bit weird to me, as we're not
in a context where we want to do a prefetch. And if we ever were to
extend that flag to have more semantics that are relevant to prefetches,
only, then this code here might become broken.

Using `SKIP_FETCH_OBJECT | INFO_QUICK` does make sense though, so I'd
suggest to expand the flag here.

Patrick
