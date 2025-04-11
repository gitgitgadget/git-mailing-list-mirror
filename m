Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E992356CA
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393488; cv=none; b=fchXrE11IAKMYXei7EwmwPRSV1kqPfFUXb80grkQuQSdH5FfIN+dXPXr7f7MVkIUS26GIZ8IC5aIi3cWTMCGNMoVbuwk0LJ2QrqCmu/Z5UGGVBVJ1s34h4bw1ceXlKHsidTQf95Ud2eo9VNi00fcQx78gCb8z8/FhhjC9r2LcfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393488; c=relaxed/simple;
	bh=J5iiPGBT+6tYIuHwvBgzEus+ffKNsus/mg8Fmlc+vKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RPBpKE2HIs6ord0hkVzevBJXnKu0FOp0Fu/ByOXc/87s8tdSvUGVc+Grsw3UW9isoEluzoaJPZL667cLpfhQGcNSzJ3J13td/bTA9HR07DJZfpRah1wmSqRgQMckst+FkjnjoK/RKirF2xP857+72+EKHU2Us7RTuC16Cw2r2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q7cKgyRF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rNRpmDqe; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q7cKgyRF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rNRpmDqe"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 82B7C11401A0;
	Fri, 11 Apr 2025 13:44:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 11 Apr 2025 13:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744393485; x=1744479885; bh=LvEM066gUl
	GrWH62uLGl7rNXXZ7UOi20rORo/3y0Zrg=; b=q7cKgyRFV16Yzu0/6Z3ZQ3CocF
	HIcSXiqKTGjf5dh1DzH3Oh+QHf4J3t5K9k4ckWUntOt2PgUOqlwJWtx/ug90PoXn
	fH7yZSvnR99ifP8VZOfoB+zRKwHnr2g98icmITRzqE4iBTz9b7aI+zd3NN7nYvQg
	Zqw6szvTUt0Q3IcHUssP39CeKvLBfwV+jrghrUtQdlBU0hyJ30XtElq46iyJHvQa
	T32q1MGcP1Y16oi3Q02DJPW2HLynVxeLjZtW3Lpr3IMTqfiXIXRYIeSoBYXXCY25
	yhebJVFzKrYQa/opO8uTgBG/ksUOZU1Yq37LbTVGo5epvLinYgfbxNg0RzQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744393485; x=1744479885; bh=LvEM066gUlGrWH62uLGl7rNXXZ7UOi20rOR
	o/3y0Zrg=; b=rNRpmDqe/kbbFAkjzCfjQ7T7xFYPotLgeOxhsTrdwYfiiMrz+IK
	0EC8aGNBZs5xbHUmb2WdMX+vPr+EVA9J+cDhxjlMhUDyAGMfW7Fekj/yLLgpYCRk
	E273Dqk9hb/UfXxbg6vbql/1Z8GYGNuQGE0Is6iTjCgq8KlxI3NjZPJawOO9QNrK
	9GXUPpwYJoD5oYIj1aXUDY9ukCVOZldsFQvVaQ09iNMRCqcy0kJIJo0M1DTBtiqJ
	CmSjGIhHZrSy4MvVhwRQFRVOl8JFuAY+NJ8/qqtB3awJ1Nq4Uz+jD3MXYINFCIVb
	OJzD9EPfJD2DxHEAL0eKE386bBnezY2zOjg==
X-ME-Sender: <xms:DVX5ZwoQOHplJgYBuOvSIpKaWleXNpttdF1UrVUlrDQEwqry60ii4Q>
    <xme:DVX5Z2rsdSUW47X3tVA9OOHi8-2vmWmid6QRKBZIHvd35BYmLs6eaDBVscKP3Vs-R
    Oc93kt_jNgP9c9LXg>
X-ME-Received: <xmr:DVX5Z1M9tbrfylkge0qFmbGcUMjCcPIxcEsd4u5L1r0UAqh5gswmnNXsARv_nbooPOnlAwvTSI80TLCgTPWAY_92RK7OqM3Cu9dY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehthihtshhosehmihhtrdgvughupdhrtghpthhtohepnhhi
    tghosegtrhihphhtohhnvggtthhorhdrtghomhdprhgtphhtthhopehmrghrthhinhhvoh
    hniiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehstghothhtsehgihhtsghuthhlvghrrdgtohhmpdhrtghpthhtoheprhgvmhho
    segsuhgvnhiilhhirdguvghvpdhrtghpthhtohepphhhihhlihhpmhgvthiighgvrhessg
    hluhgvfihinhdrtghhpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DVX5Z34aqxtNTD-PE8r5gocL0CIVVuIMfKGEWaVkMc9LZF8ScGZK1w>
    <xmx:DVX5Z_4_E267rhP8uQRXQlCEmGk69kkOl_690gZFcqVZZpJuziSPag>
    <xmx:DVX5Z3gPv-wLrObSRm3gFoaJclWqj3kWin9469Wui7_4k8NGNpia0g>
    <xmx:DVX5Z573fDodCWUH3mHog2kM5vWd9dp1YaEt0K3Q_zaKi1ZHKQnWJw>
    <xmx:DVX5Z0j27VaF8xogOJ_mfwZTfofoN03MSgY7PKatYBNDMRuDblMkschq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 13:44:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Nico Williams <nico@cryptonector.com>,  Martin von Zweigbergk
 <martinvonz@google.com>,  Git Mailing List <git@vger.kernel.org>,  Edwin
 Kempin <ekempin@google.com>,  Scott Chacon <scott@gitbutler.com>,
  remo@buenzli.dev,  "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
In-Reply-To: <20250411154839.GC648081@mit.edu> (Theodore Ts'o's message of
	"Fri, 11 Apr 2025 11:48:39 -0400")
References: <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby>
	<20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
	<20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
	<xmqqv7rdqkla.fsf@gitster.g> <Z/a+AVopz+HLa1eL@ubby>
	<20250410134426.GB13132@mit.edu> <xmqqy0w8ng5r.fsf@gitster.g>
	<20250411154839.GC648081@mit.edu>
Date: Fri, 11 Apr 2025 10:44:43 -0700
Message-ID: <xmqqfriemw38.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Thu, Apr 10, 2025 at 09:18:56AM -0700, Junio C Hamano wrote:
>> Thanks to the "cover for iteration N is a direct response for
>> iteration N-1" and "cover is marked as [PATCH 0/$n]" conventions,
>
> Even if the cover for iteration N isn't a reply-to the cover for
> interation N-1, b4 will search based on the subject line for a cover
> letter with higher version number, and this mostly works.

That is nice.

> My one (admittedly minor) pain point is where someone replies to a
> patch series with something like "you should really also fix FOO", and
> then someone replies with a single patch (without a cover letter,
> possibly created with git; possibly not) that addresses issue FOO.
>
> This can confuse "b4 am -c" into thinking that the patch to address
> FOO was in fact a newer version of the patch being reviewed.  It's not
> a big deal; I can deal with this manually.  But having a patch set ID
> would help with this.

Excellent.  I've seen this happen often; even though I usually pick
these small things up directly from within my newsreader, it would
be unpleasant when it happens when you are trying to grab a large
series with "b4 am".

The submitting contributor must make a conscious arrangement to give
a "patch set ID" shared among the messages in a single iteration,
and everybody who are responding must make sure they do not add the
same ID to the messages they throw at the thread in response.  Those
who use format-patch and send-email can do that with convention and
automation and there is no reason to rely on In-Reply-To: header
(which may confuse the automated recipient of manually created
follow-up messages).

> The other things that would help with having an official patch set ID
> would be to allow patchwork to automatically supercede an older
> version of the patch series (possibly with a link to the older version
> of the patch series in the Web UI).

Lovely.

> I'd also love if lore.kernel.org and maybe b4 also had an automatic
> way to get at the older versions of the patch series, and the patch
> set ID would help with the automation.  Admittedly it's not strictly
> speaking necessary, since b4 is already using the cover letter subject
> line to search newer versions of the patch series.  The number of
> messages it would need to search to find older versions would be
> greater, though.

True.

Thanks.
