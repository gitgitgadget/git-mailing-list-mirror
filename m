Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9163603EF
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930313; cv=none; b=Sl++V3OX/r58OtfZj4TbtxyjU6XQ6uGNxG9TM1XmwYLXrdhJz/uEvpBUSZSZwytTni2a4uIp1LosI9JzCL7nX6JZ9S/UFV6a5kY+oImgDAXTLYo15+Vn9OXrCykmIEdyvaAkFh8SvP2wKzyCOBzEmguFrDrNVSu3rk2/fPUPkoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930313; c=relaxed/simple;
	bh=njPzeowBgyq5DxSVX6+5uqhGoJYWAVKQhHKg+uefzBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AdcpZxVy4sAOJoL7B7c5dgtEj/ibFxXcBiI9P7sWNzKcYw2n8rRHLHUZwOdl5LPodCDGQpI8qTenZh4d61cGDONS+GV9dvlXRMmqPaup6cjpx6Eg08XR1I7PORXWCE8BzsvCg5aetRzl8U3X/EKIKfpMk+n/2D6X3uZzoV2CgFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QbWdcg9R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s1OBVXil; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QbWdcg9R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s1OBVXil"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8DB8B1D00165;
	Thu, 19 Mar 2026 10:25:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 19 Mar 2026 10:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773930311; x=1774016711; bh=njPzeowBgy
	q5DxSVX6+5uqhGoJYWAVKQhHKg+uefzBo=; b=QbWdcg9R6W5MR/r0xtdfye16jJ
	pcGimBKnY/xN4064Iz/8W4g724DcFX1fDPbkrSMbIK3VVNCsFNDzmnY30Zh/AXLy
	lAecm3DY8sJGe4spV9gcNPYsJwfXCVMP4lidD1HTrhSMqw0YYhFLV6t0e8MbBBn8
	jJPl2UIT7Oz5lMHbqkyj/g4p+V7/TanX4shdD9TY9LpHQ53acmybfZuAn/kmQwr/
	7dI+gfbPP5JLhmS800EkX8YJmEaCbkAqJsgpWO81tUXY4UtJG0kDF0RDO12X31B6
	u8vxSl+tFOubgnMUilnoer+7poQCcRRnC/2odC04vsh9WNJgk5iZLJ+hqE4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773930311; x=1774016711; bh=njPzeowBgyq5DxSVX6+5uqhGoJYWAVKQhHK
	g+uefzBo=; b=s1OBVXilPdrYszkOQLDRD8pKvxHTD08Thq0abHehpRjNG0wFOEK
	QHf39EtwJpTkip8vbzn1SD5LmV5xGDp2qEobidRrDn/d2bX+fkXgcQbLKO77V0wK
	vG9+CYikWruSNKVh3GAZ3BdYcwR+RvZF9y051tGVFAuwXX2KOZnr515Ku70L6iTI
	xVZbQUsTiL8N+Aga2bKanogA0EO8KbZRjaBhdwogmwVOQ75MA6h/DFIfDdugfry/
	Rtx81bFFfR3FfNHVdQExhBUYjeBk0JTp7HJ7OvYLnFXWlEH1WwfFYD0b+GBxI5k8
	9RVtXSuf9uwkaFZzD3D4L9UKl/YYmoNgFsg==
X-ME-Sender: <xms:Rge8aU4CwrQIGTd-Y4hXvfixKkSKq0JylxPmwZqpmF3zYWL27VghCQ>
    <xme:Rge8adUGZ7ojjzpJxPo-aSF9gKZk_Um2gcbs0aWxnowyWPUPfxd8ONQQS6JHTpP-j
    BIQ9Y7BVSZBLChh4KrXflx0PCGK0kfYCwneZf9nRsYSGpRDCVBbQA>
X-ME-Received: <xmr:Rge8aQ1P2ySBmmbQ4oSeMOOoEcsrX-w5NYszoqaEmi83LOYnoGQWXacdOIn5hKgLFoOf5dAtyTI95wE-9w3yBMAUzpl2grJRGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:Rge8aS3aLMm51ZMlvCENuJRsluL9V4Q2xDPk_SJWWe2D4uQe0FpNvw>
    <xmx:Rge8ab_O-oWy8DjKn6Up95gThy93Jogz28RFcmDktIMvUuG3BuqkgQ>
    <xmx:Rge8aX0iL6YrpylTCGEWxgsN-HbKbyreDDPC9qSZWJ4Dkv4AXbYa3A>
    <xmx:Rge8aQ8HHboD4w-Yut-If9FjPNKjDBPOV50_sZLLoPe-o7qllfD_xg>
    <xmx:Rwe8aVeD3wNIvrs_8rPZkJ_bZVYXRizlEAw_ueqZEDetoVhuMxqPPQJu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 10:25:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/14] odb: introduce `struct odb_for_each_object_options`
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-3-5ddebad292b0@pks.im>
	(Patrick Steinhardt's message of "Thu, 19 Mar 2026 07:53:01 +0100")
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
	<20260319-b4-pks-odb-source-abbrev-v1-3-5ddebad292b0@pks.im>
Date: Thu, 19 Mar 2026 07:25:08 -0700
Message-ID: <xmqqse9vnbgb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> While we could of course add the prefix to the function signature, or
> alternative introduce a new function, both of these options don't really
> seem to be that sensible.

"alternative" -> "alternatigvely"?

> Instead, introduce a new `struct odb_for_each_object_options` that can
> be passed to a new `odb_for_each_object_ext()` function. Splice through
> the options structure into the respective object database sources.

A lot of churn, but we only need to suffer once and reap a lot of
benefit later, I guess ;-).
