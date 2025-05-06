Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F54121579F
	for <git@vger.kernel.org>; Tue,  6 May 2025 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569933; cv=none; b=G9yZ3mS919S5GsOAyUF9ilWmsg0qd07Tq0kjAzpRNtK4Rde92VfPAE5V7Op4Ohe8Yebwg5h0crfuO9L9JdI9i0IumDmQOdrBWI0rfUhidb+i8Hs5MIUuyzCgAXFKz3y7Kg4IMeEug95FWhfClOv2aSMwNz2D9vDLanm4d6kPkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569933; c=relaxed/simple;
	bh=hp72h3C1Bwqs7bAvkep4j394yD7bdmYhuf9JV+YLV0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DmM0LP+kUDYbFT6oCITGhhQI2avmZjDyZyZYm7QMnCvqdnTN42JItKHCBRltsTCliQRAO4WvcnSlUrWfXP+kIqpE1otfLf1Rj28q77iBLrYeLvu/j5iGFZjwleXiovLcA7fZilB35ETRA9DNgWKsofEP2X/oJilsOno2/qPd9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mub+ocFX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bNmbt0iB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mub+ocFX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bNmbt0iB"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 37C66114029D;
	Tue,  6 May 2025 18:18:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 06 May 2025 18:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746569930; x=1746656330; bh=TU3TBet5o6
	3oneOyVNij2NLEpG08stuHX5Rkb+vt4DY=; b=mub+ocFXMdYYa/Sx1NStlwIyol
	jzO+EryWPg7pAcH0mIg7o+smGMUMIN8k3QZgs5gfiWRiLcex7c2tWK4fBj0gOlH0
	wmvE3cbnlMEGZZ8LR1AaM/ovulUOswkojBHxB2DgyX+euz49+EODwNe58tHnpUp+
	Z/CpjYz7gGWDZCNUiHIMN+2qKkitE9RSu+HpVz3Dobl6AkZgyrpczGnAvDCZGuHI
	MZwF/UTOi81rEU5MQAtkK1zuILJZt667Z5YGVRvf4KcDxf3if5vsJysLmW1dvORH
	pWylZoYhz/bczpuNK8WVGtPC3RoKI8VKGwuGRPXPOIyghTd/5zthdbnSkKRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746569930; x=1746656330; bh=TU3TBet5o63oneOyVNij2NLEpG08stuHX5R
	kb+vt4DY=; b=bNmbt0iBuo1F9OtqDQQYIFh7K/nv/B/2owDioqEd8EatUyfBgMP
	jdyesJn2wjDg+d0EFQFk+Zi0ZvbUuqB3kdPNzz0Lo4lb4tjQ3HbfcoFi0fYdDBdt
	Dz3gK9Zu3NWioxkLr2rnWHfNZyg7xDZnW1C8T3IfqLui9GSnsRDUN/qKsiOV26hJ
	MzW4YhfeyhvgghDSSFMtnC2ark3FEiSNWlZWCQdO30MF4eifXONhtjxAAdeQfsz1
	xRfFXCKkd5oRp3AR+xSBd6dbo6TSUPXdHOhmLCIKYw4/9yh2v4xXJkBAUJEMKZCy
	AaFDwPYBZlrmQQ2YlWJNrv50+r73+8GuEFw==
X-ME-Sender: <xms:yYoaaL5wmzQDs6lTZ2X_lELPsy4W2nzdRAc8BFshzsCqkC3BtJr8Kg>
    <xme:yYoaaA7RlwjZhzQpbJknKo6B3xU79nXeCuTjAuUGemr_bNwSqSM7EeEKpN0BtRBEx
    Wk9QFze4KmdCxGeEA>
X-ME-Received: <xmr:yYoaaCfvvuIPjK09Y-c0AAQK20ifVdVZj96xYoOpcAB9F_x-5JU4IIMK2ObKdsw1BnC5m7hW6Y5GIE-MJ5bcdQ0GGeY59iuRRG9z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yYoaaMJJAKUatenHRTp6WRI33WooQVwNbRlWFhywo28xBA3ACXojjA>
    <xmx:yYoaaPJ3f_oAOhM-Iz_zRGtjE4HzRwzOtLragDgxoHUXbhDX5o3OLg>
    <xmx:yYoaaFwaCB4vq4EyJ5-AC58gRZGxm3ZcFlPsyYPA1pdUnr5uQWndKg>
    <xmx:yYoaaLJyj5hZ0GsiYz7uxVJ3agr14S-JuA4_cLg8-jRRHGv5LmbwyA>
    <xmx:yooaaAFlpOyVfwf2VxfeAsY1KYKJzgUDvNqGckDRd23xQb-yGcsIHuDd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 18:18:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 4/4] packed-backend: use mmap when opening large
 "packed-refs" file
In-Reply-To: <xmqqecx1k1ig.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	06 May 2025 12:00:39 -0700")
References: <aBo7OiCKHTyT4DzH@ArchLinux> <aBo7tOkheM6zOJpe@ArchLinux>
	<xmqqecx1k1ig.fsf@gitster.g>
Date: Tue, 06 May 2025 15:18:48 -0700
Message-ID: <xmqqjz6tfkmv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> As to the title
>
> 	packed-backend: use mmap when opening large "packed-refs" file
> 	packed-backend: mmap large "packed-refs" file during fsck
>
> would be shorter and clearer.

Sorry to be cryptic.  I meant to suggest the second one.  The first
one is what you gave us, and was left to contrast its length with
the suggested altenative.

