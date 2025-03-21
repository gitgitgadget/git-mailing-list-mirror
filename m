Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562731F3BB8
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552909; cv=none; b=buxuggjuvkgTLw6A+I6DczCefxjWdJXQx59EsAJFQbUTnKaB8SVMhyJ1oNUzEX9xihyfvplZCkPHPTKoLux1IXVePJdkEOngMtohiyCiyWznJ84ROEf85J6/LVBWgYz55xf57IBYbW6eTU6/vMiJm4TRQ+sm4LqGJ6E/VNhiwb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552909; c=relaxed/simple;
	bh=ONi3lKvxp2glXLF52Gvbx0McDb7hjWh8GrEXpxI27XA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cIzfYzm4t+kSk6+Y4hhw6fpZ4zUmeanMgQc45SGO4L3wC7gXMjeKTE0ZsyihI6Lr5zwrsd6IaRqBS+eG3iSkD+OtHgGfJFZXVD/3S3/wTAHRn1uF5T9+QJk2sFQLqg2LRNIVCDCQy36NCvXC4R3fasADnfCrojFN2CWL9wZqV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oGRhJ/ie; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L/LFCr41; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oGRhJ/ie";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L/LFCr41"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C9DD2540172;
	Fri, 21 Mar 2025 06:28:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 21 Mar 2025 06:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742552905; x=1742639305; bh=i/wZ9+MyRL
	aOnE7rwhZvlOj/+VeRCzwSaexNkw34WQE=; b=oGRhJ/iehYrCGM/MItbKkCry9B
	epQwC/1moCMq3FrDTUs4dDOSmPm3MZPRhCESP+tk3lUL0mL3i9Y4ii7Ch32RVfZe
	RpawCD+JnnKIpTrwekX5eEpGCaGA5T5HE0CmEv7fr9N7VEjS2yefH/YXTWUKg1GF
	BdRzJYH5UD8A/BgiHhJZpib2cuRAXSPFMaG6UqC8IHKAdC9wdZlzpNmFeRtFvYXF
	yOTMP6i1h7WU7EDbBFwdhxFmf0YAVnNYK1AvF5eZREFvXSm/IMGlWabqSINMcZbA
	Kk80TbEfcUEDUnAFN2Ak6Wb10huj/Ei9V9zI13kDy8Q6Evs9eA8tOXWBCRig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742552905; x=1742639305; bh=i/wZ9+MyRLaOnE7rwhZvlOj/+VeRCzwSaex
	Nkw34WQE=; b=L/LFCr41rYAJ+N614+x0TF/VfkWTUVJonH+CQM3yRaMrvuG94XU
	yG7gJDK0UQsRvmCMwg3wYwnNgq/at/HntjkPDa3odYNoCwsLTvDU4HRI3/SOBx1O
	6RgRKZ7SwN8iNn+d8Xo47JC83FQQ3+p/aHzZeTctfv+IPggr7pvnEnh/w/803ymz
	Pua/EqP/OfQKUlG636VxCHavGKAf/3m5N9P4M6cnU88OcPc1eBJ+Ix9hRtkvufJ5
	ToUOn5T4hacRfy7hllIiWn+FQtLpKtRc4nSK+5xhRQfwqSJz1FJN8lSAJLyfcPV6
	9UtzSkvni3A4r39i6faxSOOHmsi6Wt7WzmQ==
X-ME-Sender: <xms:ST_dZ_6CpkkoGOvDXRkVZgT8sz8EUzDhhVMAWhOUrpOcjcfeu-3wpA>
    <xme:ST_dZ04WtEMMe4yK6AZw8EDoq0GZbaLEtttji2fH63GwnQwPlnNZxcuZTEVAqVEZR
    AmxpTt_dhjxSExtHg>
X-ME-Received: <xmr:ST_dZ2fr_8rtM5VwWnoi_Zxg71vzdxwAum2f9HJajqNym561rsMq5FJpbPC6Gl14O3KEtszWonSZF9ShkiruCyPoYMpszMeGBSrvcJk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehoshifrghlugdrsghu
    ugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ST_dZwIxTfYh8zo_aC6x8tOpDnJ4cr0NuyBkN5V1_bk9ZhTza4TU9w>
    <xmx:ST_dZzJuAV-B6yc1FjCHMmQtwHGVYl3j2QSS_HuzlqW-dNOZ5mDoZg>
    <xmx:ST_dZ5xzmy_uTd_OkgnxhRNL04BWvfTFstHEiBqoJ4FPqF6IL9e3cA>
    <xmx:ST_dZ_Lyez0zWvLSgLYTC1Fi74oFHiDjJVPpRIen7mOv-la8aWbGRA>
    <xmx:ST_dZ5hyn_7HgQxyIQCtvQAArrjxlfMcpnnB1C_N4t3jKS3zq8xGD4SG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 06:28:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,  Taylor Blau
 <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [PATCH] docs: clarify meaning of core.commentString=auto
In-Reply-To: <6a3154e0-e7bc-45ae-b554-67ccab18727a@gmail.com> (Phillip Wood's
	message of "Thu, 20 Mar 2025 10:21:10 +0000")
References: <Z9lcXR6sL3UWlL33@ugly> <xmqqa59i45wc.fsf@gitster.g>
	<Z9sLAEbE9lAInBXz@ugly>
	<6a3154e0-e7bc-45ae-b554-67ccab18727a@gmail.com>
Date: Fri, 21 Mar 2025 03:28:24 -0700
Message-ID: <xmqqfrj6vfsn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think we'd want to start printing some advice when
> core.commentStr=auto explaining why it has been deprecated and that it
> will be removed when Git 3.0 is released. We should allow that advice
> to be suppressed setting advice.autoCommentStr (other name suggestions
> welcome). We would also want to add an item to BreakingChanges.adoc
> explaining why it is being removed and add "#ifndef
> WITH_BREAKING_CHANGES" around the code that handles
> core.commentStr=auto in builtin/commit.c and guard the documentation
> with "ifdef::with_breaking_changes[]".

All of these are good action items in a good transition plan, I
would say.

> We may want to make
> core.commentStr=auto an error when breaking changes are enabled as
> well.

I am not so sure.  As commentStr is a random string that is used to
prefix any comment line, "auto" is just a (albeit weird) string, so
not doing anything special would be good enough.
