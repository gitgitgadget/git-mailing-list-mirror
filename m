Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CBE25EFAE
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763671749; cv=none; b=Squ/JaU39/2wlGXj+PssOdMCFVgecMEstyIYNRTxXwEq2HOrQ4U1V7tPEONsIMl9LjRNmi0rCEvSwRMLRIgXwluwTv7B+/1Q1GLoejDGoCkjsF2Q863/AbC2Xpgy3yhs3NEnHKLm+z/FX1tMCD6E1yYZWwJYLiTCgT+5RBwMCT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763671749; c=relaxed/simple;
	bh=dwP7cd3r/Sl2CoDmGB4WG+zmUOPCVAf19+5/qVAzR6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=He30IxNHimsmbryoS0o2yhtzWdCRT9z5ffwxtBbxxS2tsSIn4lY74NYRs8zU46W5kncklao9IvNCLvksIgbvmzfe08vy7KEekC/B2fdGsp6ue8iOCxgEli6q3bSEZMbiiS3c2FV9Dr2C5CJ3BJATDp/Bh7TMvcuHEbTDvqY8AyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NaH/FEf/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PxrZbXol; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NaH/FEf/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PxrZbXol"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9FC781400287;
	Thu, 20 Nov 2025 15:49:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 20 Nov 2025 15:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763671746;
	 x=1763758146; bh=GXY26MgPrtNuWaAgTEnzQcIu5UYElUFscgqSqvxpoK4=; b=
	NaH/FEf/qXg5YD4K67+KzslXfJr+qjrmfh/fpgdaGjXnAr741EkyyQo2Gq1Mi3tl
	gOqJQIiNOucfLtnb/ZPK7Glrn7Yvpgn3iSVXnhHoi3Q8Z49c3Fgq1aNVZS4pyuZz
	C24vr1Mq6IVWppTauVLu3Ao4+UtXjo7GoG00AbnBMIHLuA75xPR/aOpC6WGdPYlG
	rUQJ0bHc+NY31mA3UnFQwFfPbXUIjGFid+VdJ0jypNH0i+Sj9KsS/iPB4KrAleoT
	fq86MSGxYlIx/283YaeUxus6Jeg/CAM5rDHBsUUUELw0ChktBRw8T2Bk5OyhTA5N
	aMiYzshFL6fjeF0HBpuTbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763671746; x=
	1763758146; bh=GXY26MgPrtNuWaAgTEnzQcIu5UYElUFscgqSqvxpoK4=; b=P
	xrZbXolHjnjuI6A7rMsFavtfdf7aMF0QXhsPoQ2vtI8Nykyc5llTjDASJhFmb228
	8kTHDP9PCU5O9cZR773ITVZDrLa/Rn5Nc1CHbc5/5KRbIa1sRxtjT18JIAf9FpxR
	Hr4qgXGduFWTVmSrITPj8u/WHpNJ0fCssCgUp9x/pTTgiWaP3mqe25O+t/CDGNND
	IDYCDRnQtWxhpwFBuzZLiJ3TQgDF9DZ7kNdjKdDRoJxo91Pe1UZLkS5/oYe09L5b
	uoVAaaXb7OkANI+DhCN3obE0NJuzCbvq+yguRrA8SotIZcvdKREMPsuFdLdlhp94
	OQVyAOr55qzLcWOhjigPw==
X-ME-Sender: <xms:wn4faZA7lL2DmVP6rarlOklNgufMXdDYqfx2KHgZ-Mncb_2hoGmhTg>
    <xme:wn4faUGjLCbB2cOoJx-26J7WpB-_QNt--bLsVuI4kR_X2sxCjNkEkhAtuP_1w-JMo
    TBeATzKpDrcXlXbrbusw6uu2oxdxKZ9HLJ4pmefRs8UqDt73Pkt>
X-ME-Received: <xmr:wn4faZAhQK1N4dDgJGFbxvcJW7NGooGpC29QuYolt2OL65Nc5CEO7_o3TARdOjJ3jXnKcaRg1DKd3bCWWizJIfKrFcd3zZIdul-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhn
    rdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:wn4faamrqmPn4WuGVlfJlYCAMSWyJ4Zy_ov5ilZGA7A7fqjrTMva3A>
    <xmx:wn4fafPEzu-ocR8-ClRPVs24meCXbzD2s5yXbE1oIWpz0RrOfknjqQ>
    <xmx:wn4faf-kAgPoYrPnylRVWuL9XNvz-Sg0xW5YrA1kNkaxbOpfhlPl5Q>
    <xmx:wn4faZHDMXkKLEveaT-SpXNlDTURTZYs__THAssKvjxlMMcV2ejd9g>
    <xmx:wn4faRRuVTZ41KLlKdC5HJJlD7FAn_YLEfodWPWdJfJahPCwIGJ59gI->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 15:49:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Sergey Organov <sorganov@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?=
 AVILA <jn.avila@free.fr>,  Martin von Zweigbergk <martinvonz@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
In-Reply-To: <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
	(Elijah Newren's message of "Thu, 20 Nov 2025 12:40:12 -0800")
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
	<20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
	<CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
	<xmqqbjkw78jj.fsf@gitster.g>
	<CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
Date: Thu, 20 Nov 2025 12:49:04 -0800
Message-ID: <xmqq7bvk77lr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Thu, Nov 20, 2025 at 12:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> >> This patch series is a starting point for such a command. I've
>> >> significantly slimmed it down from the first couple revisions now
>> >> following the discussions at the Contributor's Summit yesterday. This
>> >> was my intent anyway, as I already mentioned on the last iteration.
>> >
>> > Sorry for taking so long to review the series now that it's based on
>> > replay.  Thanks for working on this!
>>
>> With your comments and Phillip's, it seems that we are very close to
>> a good stopping point.  Let me mark the topic as expecting a
>> hopefully small and final reroll before getting ready for 'next'.
>>
>> Thanks, all.
>
> I'm a little unsure if it'll be small or just one reroll.  Some of the
> changes for patches 5 & 9 might be big (but straightforward), there's
> also a couple design related questions (single branch, HEAD-centric)
> that might bring up bigger usability issues to address (if a commit
> being edited is part of multiple branches, do we just rewrite all of
> them by default, or error out unless the user specifies how they want
> it handled)?, and a potential gotcha on patch 11 (how can you preserve
> the index and working tree if the user edits the patch while splitting
> a commit?) that may require rethinking or restricting that feature.

Perhaps.  But I thought the existing patches limited its initial
scope small and manageable that by operating only on a single strand
of pearls, with an intention to extend to cover more cases later.  I
was hoping that we can start small and simple, initially limiting it
to single branch, etc., in other areas that require design
decisions.
