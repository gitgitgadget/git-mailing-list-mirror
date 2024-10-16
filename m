Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D21B0F3E
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063342; cv=none; b=iU9b3M9negSttClo0tFSnlX+u6XpqHCWaeGB5CglcL0B6hPprMgMZgYaKYgak5B34JX4QtTDn2lOyGetdK0se1Z5tzi2nYUpGPtWaNVkOThk+u94M2fhwe3H0Ge+Ut4FBBDcm16L6zTvjQRY6p5FgRrGrIfsKKsGvBtzxtSNb70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063342; c=relaxed/simple;
	bh=W2bOxVsKiFrdv49zSssMKAR7iqDmJoBYRgayGp3SRYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHONQ6ZF05Mo7ImZdAATjVS/dzE3+Zqjlv6npTfDdQpxwrbAoHdhsDMVoO/F2ib8W/0IMoLleE6aV65DuyX6aTuWn//ShxruGUXAVEsqRA2L9fd2RTXR9a+n+ywu+2AoQ7TVQzdV2m6LQLwWWmmIZA+Empk7cYMW/ItI51Kd43Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SLQ144bz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sq8sAFv3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SLQ144bz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sq8sAFv3"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE5171140187;
	Wed, 16 Oct 2024 03:22:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 16 Oct 2024 03:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729063339; x=1729149739; bh=NzvgKCOpVM
	73LX2uRVWbk4UsYlzH8LVDghGZvIrlVyo=; b=SLQ144bz/KWaGCoT95/bLTX2CJ
	Boplpr1ij3gX3lUiht1Zsb50SUgMt5QuTNqYOKBpNt9gHEwhTF3hrce2NKwej+jd
	ddbwSkJ+BaNO6CPkY9iLDBTCBS/Wme3bFnhXKhf6PHhnry+w5SMdFGvl1KfRxT1h
	s/FK4y+Jtpf2ESePJI621wpBM8W3UPDGbHDubZtTf5Hsqoeh5+LjrRuESWsljgSc
	uwtJDWk4o3GGaPEPE52gO7pMD16DNJwrWDLdB18FXzHQshAo0uEEROanueM/QN77
	mcrWQfrcjfck45ihmaudvOtnaouvgjBtWfDIE3NdFcSWx/sO8jYdlE9LtSzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729063339; x=1729149739; bh=NzvgKCOpVM73LX2uRVWbk4UsYlzH
	8LVDghGZvIrlVyo=; b=Sq8sAFv30jrGzaNqrsom73VHLBNjuxKPGQZH8QQrX4gB
	8ZrrY5zFA1gp59oKWZ1kCGfAyT3vyZ3Tqm9iFahvOTg7N6h0DsvUR7BWzJNM3PHM
	pfJAhriqbKx4T3IPWeH3vApEYRkHkKcok6q59wtTzuCOgRtJ3/4beliv8zVLdXCn
	ufwxXDpR/f36MpPP0wJDbUoO097iXEu+mHiHkG4k2fw4oNi1ziJdrz45tHiVwYZ4
	t1rqGtyBNjyp1i1SNGDDfaHhwUAuqxR5x+79+/L9a44FBq7eYKM741fh9tRuLqEi
	5CsRmKzwzRPrrch5wW0b62tGiHqBOblfMCY9wuI5fQ==
X-ME-Sender: <xms:q2kPZ-zme2vilbzurtNjO7HwcHnUYI5ZrkS6irEREdZQUx0Dc77YOA>
    <xme:q2kPZ6R2v-YDu1TLqYpb6RFFbMLFj6HQNh0R2D7fBrnTDZBuYoRr6nFoqV1-_hFuJ
    BEd7QHvhlLHj1W6Uw>
X-ME-Received: <xmr:q2kPZwU0rdIq9EZgXCqenX37j0VX0C3JLRu_govPzRpMSbea_ClyfaNb_EvcfYFNte6LoIgU9GoDgozDwCBFttooH-5shF3jaolUIbEbck8e5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:q2kPZ0gQ-9-9DA0j1pDk_P9mrVf1iGjERcK-pj5gR6gvcG4w6Yilyw>
    <xmx:q2kPZwBjKp0sL3vbMtI1BTCqPZIGKgG0Q28qA_GpMcgwCXCGNESXoA>
    <xmx:q2kPZ1LD5MSopNhxVdRyibF5rntURcyQw0hDSa_XYp4u-T12A-baRg>
    <xmx:q2kPZ3BnGPt3JS_RL8KwEx12YzjfXR1sHYF-T5EieZ2IEbz3c1xPCw>
    <xmx:q2kPZzPQvqFjNt9eoVGOtn3K127-oC55yeYF4Rf9FPAESdbQuSbB-pwM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 03:22:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4cfced08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 07:20:59 +0000 (UTC)
Date: Wed, 16 Oct 2024 09:22:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] BreakingChanges: early adopter option
Message-ID: <Zw9ppbrFqVN5S50J@pks.im>
References: <xmqq7cb77810.fsf@gitster.g>
 <xmqq1q0mcnt8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1q0mcnt8.fsf@gitster.g>

On Fri, Oct 11, 2024 at 02:49:39PM -0700, Junio C Hamano wrote:
> diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
> index 2b64665694..eeb26c9155 100644
> --- a/Documentation/BreakingChanges.txt
> +++ b/Documentation/BreakingChanges.txt
> @@ -59,10 +59,29 @@ over time. If circumstances change, an earlier decision to deprecate or change
>  something may need to be revisited from time to time. So do not take items on
>  this list to mean "it is settled, do not waste our time bringing it up again".
>  
> +== Procedure
> +
> +Discussing the desire to make breaking changes, declaring that breaking
> +changes are made at a certain version boundary, and recording these
> +decisions in this document, are necessary but not sufficient.
> +Because such changes are expected to be numerous, and the design and
> +implementation of them are expected to span over time, they have to
> +be deployable trivially at such a version boundary.
> +
> +The breaking changes MUST be guarded with the a compile-time switch,
> +WITH_BREAKING_CHANGES, to help this process.  When built with it,
> +the resulting Git binary together with its documentation would
> +behave as if these breaking changes slated for the next big version
> +boundary are already in effect.  We may also want to have a CI job
> +or two to exercise the work-in-progress version of Git with these
> +breaking changes.
> +

Agreed. In fact, I'd even tighten the last part a bit: once we have any
breaking changes queued in the tree, we MUST have a CI job that
exercises things regularly.

Other than that this looks good to me, thanks!

Patrick
