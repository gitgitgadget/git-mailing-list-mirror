Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F23DBD78
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343287; cv=none; b=lqLD5/KZpLUlkbwIRSK7TNCWvkEP/VzR+TT/jU37OMJfgkIEo/D2qOuNWZgv9O1LEkglcZNjlbSbxItv0HEeMfi9A8E/YRT8jKBZ+p9l0ynGiGzrfknf6su3SQmYpArghZaUk9UILj358qIlioRhk48RjyuBJcQsR2lFg7kVRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343287; c=relaxed/simple;
	bh=ovCYxUwi5WgaKaI81My1JgcTJgq4y0RErhPNob+cykY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFzn37xuc40x3yS9XuLZ9tc7XegMVQoyenL1XT9S5jWOvvLUFOCvm3WTX544m3VdLfUFVCW3nDOXvr9raAoa0NuHSvcRVZZLfv7tVcIvGtWoCE+as6nwTtfeg3kSd3k2twr/jb0NCgd4wrzn80SJte5XVafl7oTYkx0bYKEEoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ihVHMioM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JDBsPU12; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ihVHMioM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JDBsPU12"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D23ECEC0185;
	Tue, 24 Mar 2026 05:08:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 24 Mar 2026 05:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774343285; x=1774429685; bh=e2zAT8RtH8
	0aAYwog6tCn28DYLHoplLerlVxZutIpK4=; b=ihVHMioM3Pch9xVV17ygEyHxXu
	kU+Sr4Yn1PgKXrDc4TMQHMavabAdzOsBKIn/o2hWYKVHSiWOgMtqJ2RGygxHl7vI
	WqcfY0QXFMdJnBG8Sd1qNk6S619SNSvBYw+SnVCEi7BhKWb1qdyVuGrIkZBzkxHR
	kq3A6IdKuGWYYsByc5Gcvq0HMcjZQ11JQT+0JSavrmJtnQUXcQ58fFXhLV/4BqTh
	QlTJyiTtXV5UjpmqjyMH3DhjwHAgGjasnxEZ67sWcV7yxABgx5H18hZIbOjLeCuK
	SeYjVwER4vHE7qvK0jjcp9i3SiR/aborW6a9UGD8SDzJQ8DnflZYNvts+2cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774343285; x=1774429685; bh=e2zAT8RtH80aAYwog6tCn28DYLHoplLerlV
	xZutIpK4=; b=JDBsPU122eBOduAqa59wEnBmR4mxmP+OwijRpEOXdvYfBi2JYPW
	5iSe9CDH33oIPQOB2s1OXxxemYkuNNX+k6C7RCTkxGCwo9uVP8f4uye2mogtda7t
	VZFpn6GfWEeQuBijOQoYFD5whINHcjbpxfTQI/0uV7kU1VENp9ghD9GgbZh88geM
	BukI9buE/s88GS68zCWHUU7C0pUzvh5M6iVVdI6C1PIP6jdNY9gILCD8C5TnctsU
	W2olOqKvMC4lDSFOHAaaREIvk64V7Yl00+dJcgo+0DRlqkeksQkRaZM+Q563xemk
	PypHp/HfhEB35klwPUknTCmCpPoKse8YJbw==
X-ME-Sender: <xms:dVTCaQf_KOg-NWZAuxZKJaspHre3cWTP0B0wTJrBbUtCkL5-0EbaKQ>
    <xme:dVTCaRTbcWk3Zf1wRaaxFZbxW85nBIbxQfZdVoWs9Mkl_RrIigsy3DTWZbUHWn_ad
    PI1OY0AUh4H62BbzgFK8b_FUFUb1z1K8DbutqV_De6rr9snNwWlRQ>
X-ME-Received: <xmr:dVTCaXv9ShKG33ggMfPTUXO8eW3240B_kaO08Tu-ZyUA-7GG9jlMdsgUNP-VAsQ468lC2qLdVZDqKd3EvWCPpMmVnIitQhPDhOVSYyAp3XYVPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdeffefgteffgeffvdeuueeghfevkeelieffkeevkeefgeeluedvgeeuvdeukefgnecu
    ffhomhgrihhnpehpohhsthdqrhgvtggvihhvvgdrjhhosghspdhmhidqhhhoohhkrdhjoh
    gsshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdr
    tghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghp
    thhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:dVTCaSeN9_U9m23yGmNuyefhP-_CH_aH3T7zrQwHh-CT310vYhXWdg>
    <xmx:dVTCaRayaj3cNwM3f1MkI-BW9Y_UTEqaJU13DgIgqdwjc4G02E3rKw>
    <xmx:dVTCaUaVbSMXy7441FRbaVIltTTKm5bLw1DAp_xpkbw3GpfyqRoC6g>
    <xmx:dVTCaWLDEF2FxsasWmxUiRaBmf4xeSeCQy7HHP3fvSBjIKyHUHOQ5Q>
    <xmx:dVTCaexSvF75IGAwur7k8YiznMiupDPW6uZvuJ1eKRYUuKzwkxF4aXML>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 05:08:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 20647fa6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 09:08:03 +0000 (UTC)
Date: Tue, 24 Mar 2026 10:08:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 7/9] hook: add per-event jobs config
Message-ID: <acJUcIa9JerWgxI2@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-8-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320135311.331463-8-adrian.ratiu@collabora.com>

On Fri, Mar 20, 2026 at 03:53:09PM +0200, Adrian Ratiu wrote:
> diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
> index 6f60775c28..d4fa29d936 100644
> --- a/Documentation/config/hook.adoc
> +++ b/Documentation/config/hook.adoc
> @@ -33,9 +33,28 @@ hook.<friendly-name>.parallel::
>  	found in the hooks directory do not need to, and run in parallel when
>  	the effective job count is greater than 1. See linkgit:git-hook[1].
>  
> +hook.<event>.jobs::
> +	Specifies how many hooks can be run simultaneously for the `<event>`
> +	hook event (e.g. `hook.post-receive.jobs = 4`). Overrides `hook.jobs`
> +	for this specific event. The same parallelism restrictions apply: this
> +	setting has no effect unless all configured hooks for the event have
> +	`hook.<friendly-name>.parallel` set to `true`. Must be a positive int,
> +	zero is rejected with a warning. See linkgit:git-hook[1].
> ++
> +Note on naming: although this key resembles `hook.<friendly-name>.*`
> +(a per-hook setting), `<event>` must be the event name, not a hook
> +friendly name. The key component is stored literally and looked up by
> +event name at runtime with no translation between the two namespaces.
> +A key like `hook.my-hook.jobs` is stored under `"my-hook"` but the
> +lookup at runtime uses the event name (e.g. `"post-receive"`), so
> +`hook.my-hook.jobs` is silently ignored even when `my-hook` is
> +registered for that event. Use `hook.post-receive.jobs` or any other
> +valid event name when setting `hook.<event>.jobs`.

This makes sense of course, but it feels like something that might be a
bit confusing for end users. It would be great to have an explicit check
for whether or not "hook.<friendly-name>.jobs" exists so that we can
print a warning if so.

Patrick
