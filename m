Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD1A1F37B0
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035859; cv=none; b=UC4FcPJe7LIK5/mtYGhVDWbAHVJbB8gqkLDk1MkEi9fP/1ywLdIH8V6j77wtPcCr8v4Cc5mBFvhywnTTsgPrG83+uHWI6Y47sd5yDkhxaGi2+0cdjNXex5savuSUjt+7jCDYv7CvbErlC7Yl7xeHlj5ybkyDqmaQLO6RCnY7bWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035859; c=relaxed/simple;
	bh=/jPxeaudrIQXzx26jI/B+PO/o2PCuLDFOoUPYrGI0xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TelctwsGTEVuCwwTWMKTLxzSmlTK+GW9qhmbw/tY9nZVO5B4JjR+SfqPaRRUSeThKHV6yU6veun87uO5gStZfbUZjzESAxVozwnmp95p0LbQVFu8OhHPN5ucWhH6BNkSMzMbOAwNIZxZe+BcMWgdliRAd6/wG/nRfaTlcQdsNcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GRFTnxW9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YGj7g+Qt; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GRFTnxW9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YGj7g+Qt"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C08D525401B1;
	Thu, 16 Jan 2025 08:57:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 16 Jan 2025 08:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737035856; x=1737122256; bh=akPGdQkW+7
	lFq5l/8ZcUBnftj6lJSDX3qCz7Zur68aI=; b=GRFTnxW9beSNPMq2DOnIvOt7y6
	hIZ+EpuVLTD650N27uUN5adW0aevnplR/az3tRUz7xGWBki0hZMBA2gHVZpvHyXp
	Lfiw01LwXLl8ACN6zssSOMTyv1KZPz2AzAS6v5A6FYaT+AkW595l0axSJ4cLLNPx
	czjs12wZTbht610iI1L3RzVtwoGeXIcrCpFWJlGy75IlheOkmxFKmTzY+GaHFpYE
	zoZpWCB+qR4+oJZlhuF/ZwbgeEs9wS1Du0Q1b5LtuaFCFwOQZ2vROLChwnM8Xxt5
	A75iNVQQloX2g+/LkRAt/3i4RFBCbyhQT9QktNbIucDymrh56Ey+MA+nOhIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737035856; x=1737122256; bh=akPGdQkW+7lFq5l/8ZcUBnftj6lJSDX3qCz
	7Zur68aI=; b=YGj7g+QtBlSah7LczlZLDFGh1uUnqdNW8fa9mN9GSHGPB615E7D
	E45Kiv0eyDn83BOGpoAZtiff1fgVGEc8V5X2h/ypx8kvrS9az1Tw0SJEiZtJsKJP
	+df3Dp3vEKUc18fcKN1CLJIK4ZLA9+iGl6BfLQCVJwpp88P61uyl33FxKGIaZlGn
	cUyfSyksvUz2nddv1iBdGIxLMfCe2PbInbSZCSVEiTbn0VmO6bKolkmFGnitQmls
	g+K8CI9dF6HYsy+C3jabs9xD2zd+ARVmSTEslLi6KReKLKfo0XMRIJ2d5zB4JHD3
	TRuMV5lH2Y34dtGVq0hl8YnCtD+qNBoKRCQ==
X-ME-Sender: <xms:UBCJZ5X2C1t9JMGmtC_7s8imZIjVdFlOrVtEhYnbrMZ0RZMyqm2_EA>
    <xme:UBCJZ5n381LyiqHYXUZ0nQqjRGY_bNuXqDEbQt1JMs-AfEpYucQtmBdhL_iMz1hVQ
    3wn5pQNBDwZfzWJTA>
X-ME-Received: <xmr:UBCJZ1Y6wGheC4JKA94VteAR5V2lNN41iNrNvuJuPA9JixIIy7WB9yRDMEvrfBmw-ZoK4GINFCqLAVgh8xRh0DGiSJm7sAKsLWQefotx7hQBKIUTZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdrvgguuhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:UBCJZ8WGbe6E1A2uC30rUoBpfB6ON3SQ6pQn0JwdvoEVhAgceXMV7w>
    <xmx:UBCJZzkklztqgNybDpEIiCLZ7BNSgbL6NBo1VtG5MI-_XefFjFlIdg>
    <xmx:UBCJZ5c-WH3H5qUpOuUVs3CJIvz7407ayBshWOqyv6oa2CI01-Iy9g>
    <xmx:UBCJZ9Hhn74xhrJN0MiXHkdySTi-NGo9qkwgHqNyAy_vCp1u7cIjKA>
    <xmx:UBCJZ-tMJi1lMNFxLYJ7EWBQS-nrVhdnlAEdgVvEHv8qtcfU3ZM2HkGQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 08:57:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1ba0695f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 13:57:34 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:57:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 03/10] packed-backend: check whether the "packed-refs" is
 regular
Message-ID: <Z4kQTVLfScW0SgyG@pks.im>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN6C2IpQTdVn_S@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qN6C2IpQTdVn_S@ArchLinux>

On Sun, Jan 05, 2025 at 09:49:28PM +0800, shejialuo wrote:
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 3406f1e71d..d9eb2f8b71 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -4,6 +4,7 @@
>  #include "../config.h"
>  #include "../dir.h"
>  #include "../gettext.h"
> +#include "../fsck.h"

Let's keep the alphabetic ordering here.

Other than that I have nothing to add on top of what Karthik mentioned
already.

Patrick
