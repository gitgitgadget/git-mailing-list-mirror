Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815D3AB26A
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638011; cv=none; b=AH7TRsNE0HhbAvYFS4IGd1vSk4JVDw1lploE8FbJexRmU0ln4mFQqDN2D6Sww+LjJyLDHEHhMVaVog+2yf5UAXan2LrBCKETiQv5Ml03U+b9whvP3aLJcOh8199Ffcevk9bvP1Pei4Cmsn/Ifkl1uUf8UPaAd5fmLx8+q/bN9KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638011; c=relaxed/simple;
	bh=BgDr+sRTX/byzZIma3kn+LQDaPXS+ZIyP8EPGywVnPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNkYqqCy5X+LQd8nfl/aFGicNSqW6vMOXe91aPmwah0JFGoWSRcDnZ8/SptrVlXb58F2oVIpE6i0OEvcDGbAFML04hplbIquOce58ZxoE+rxw/jxlmM2RnyDLQDmdT8QqhANpJnfpROv2MxQwuj2Dnff9/IwgXKnlf5Fb1CldOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tANmNUND; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NX5R+dKs; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tANmNUND";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NX5R+dKs"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 49A29140009A;
	Wed,  8 Apr 2026 04:46:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 08 Apr 2026 04:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775637998; x=1775724398; bh=9PCAewC/KK
	maYkKujPaTr3AycWyFHyVOg76QykpktWk=; b=tANmNUNDOsa+8tEZBCS68GkqbE
	mfkYvcpxnOAH7RYwsWli5+A4AKfbh11OjFkC9WEonvYH/a2CnsBt9o4kXnn0r0pB
	2O3OpnueAv8QT4hO4bdyUXWNk5Z7t9pgmSyJJxNqmN0vj4W6TbsUbrNSl/JaIGt9
	ZiRKQo8pP1/BBYDzbQ1hgqgNZW3utzZu1ttCxIHIY0jrEKWwpJHj/1bx/Cp2kz8v
	0CdSJBVUlnJ1+N7qi4MQGixqhu7IdfmKjY6Kj9XIT4buPhjO+YSUAvhE0AZ4qxCe
	PMYX8JLPQpNTu7Pyx0vMZm6nQKF1hDntiJqf+KNPsRrk+VzSETIPyGtcvcBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775637998; x=1775724398; bh=9PCAewC/KKmaYkKujPaTr3AycWyFHyVOg76
	QykpktWk=; b=NX5R+dKsori6ummn+ffzk5xCLvk6a5OZzCBm6cdCeh/pibvRnB5
	FWfaAbWzF2r0JsI6M70Kwtl4ac5sRUcIEnTy7fa3wcxVR3DGsbkPMJGH6/KQQ8Vx
	5PHEciU7IDjIUSJ9mQgkGSg/IjCgHEKplLyoSlq7PqXQp8EvOXwE2F9W5iPa7HAm
	3UR/IliS8JeGhsZKZHM4w5mIv/UAiwvxpEPe/wqHDR3fEIZIBow+Y7WweeMExWWa
	1nuIsTLmltMRRn7MAfgmVBUwKU4gbBiKhpp/zkw38T5puSRyMe0lf8yZVbRq7IDi
	o9nOP/iF8A+ghJq5PY10bdbkeyTWFUjiezA==
X-ME-Sender: <xms:7hXWaXIfjhr8OG31a2f00xKGmBcC_IyJTsqUO-5K8RbDdU1PT_1V7g>
    <xme:7hXWaSC2CPMu0pU0wAaUtgqZbLE4y7bo__3AdyTRBbJWKexrNknVZsDD9fDRCG4iR
    A-m8e5CoJCZj9b_belyMDNpvRB6RK87KV6HY3qVCJCmJr_ABAQC>
X-ME-Received: <xmr:7hXWaYDe6Jbik_4jBd_5lIa0uXOG3VoE0b4-GAwRbQTTCWF4Kn9cuvecdxAYIG0MA9FqTFqUXgev9e0tK-YKOevTjZYWSQkojQEYHOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepsghkkhgrrhgrtggrhiesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsh
    hhrhgvhigrnhhshhhprghlihifrghltghmshhmnhesghhmrghilhdrtghomhdprhgtphht
    thhopegrfedvtdehudehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7hXWacDmrhzOIrAJTaUTJ5w6UZHsLhIjG_ml7pQOWBWlzloxbSsxxQ>
    <xmx:7hXWabp83scSBu7rtreAm37RMbWHQBBKJe3sZe61r8EZ3bofuCR0TQ>
    <xmx:7hXWaemQPkn3lL6KYgGv84cPDVmQYCLEUJBGR9qaHZh7guzBJyNmMQ>
    <xmx:7hXWaTxR2mBYI3Y5OZPKj6vpLt3TZdq8CakkKZC_kZu6QqHbTQI9vg>
    <xmx:7hXWafQ4KVLzKylCxlP8bn_lIZqO_ZDzFAIRgmiyNjYpAYQB14rbI81B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 04:46:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99a11e34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Apr 2026 08:46:35 +0000 (UTC)
Date: Wed, 8 Apr 2026 10:46:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, a3205153416@gmail.com,
	bkkaracay@gmail.com
Subject: Re: [PATCH v5 0/3] refs: reduce reliance on global state
Message-ID: <adYV6NK93Kzg1EYG@pks.im>
References: <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260404135914.61195-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404135914.61195-1-shreyanshpaliwalcmsmn@gmail.com>

On Sat, Apr 04, 2026 at 07:28:37PM +0530, Shreyansh Paliwal wrote:
> Changes in v5:
>  - made the commit message of patch 1/3 more explicit.
> 
> Changes in v4:
>  - Dropped patches 1/5 and 5/5, as they require further refactoring and
>    discussion. I will send them separately as a follow-up.
> 
> Changes in v3:
>  - Fixed an import
>  - better readability in patch 3/5
> 
> Changes in v2:
>  - Made struct repository the first argument in function parameters.

This version looks good to me. We bail on some of the more intricate
pieces, but that's totally fine as we can still fix these in a
subsequent patch series.

Thanks!

Patrick
