Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC03C3FC7
	for <git@vger.kernel.org>; Tue, 27 May 2025 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748360560; cv=none; b=Uh/Mc6XzPEiseer3h97/9YlZq7ODT8yBZYustm+qZT/W/8rxq9nlcN5weVRu+sbz+Wr8OJRFQQ4wNPSTIUMzRUiR+MQ3zFUOilr8anTSarxAw+MqUXlpZ/hAgIWGPtZTHkI27FabHJ+HgN+3tZK+zTT0tI6n+NVzPmMFTJhdUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748360560; c=relaxed/simple;
	bh=TuCycl9DsdLe8NAqgjRBseEvK8A2wlBua8aVxwBbmWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JJxrAlTDjuT/S051puPJ5RHafFhSs3eid07KVdjVF/FcyKjHbrSqYx3y80nmz1O0BIKxqL/jUi4nAqGubcVm9skD+hzlAjqpfxeuptlUzwLNTa9yiN0ElTEh3F3oMIibDqk0It2XvKa5c8mWljN/VLEVeYI0uzPWZabO8svelAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JxLnF8a9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p7DTiP5D; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JxLnF8a9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p7DTiP5D"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 74A8A11400F5;
	Tue, 27 May 2025 11:42:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 27 May 2025 11:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748360557; x=1748446957; bh=PbozZsZbLS
	t7AM+/vCpZgeMEQkzilRWKnFUK/AaOOGE=; b=JxLnF8a9AehWS6Ms6ZiCgknjdN
	66A0l3aIIXlunyNwjCGMGWc9FVyrcNzsv/+QYUYRt2BUFjcIYmOSOwCRQH/eqpAX
	UkpbtgISzNsqlCsDvK9ObKiGgZLVw9OfwCozYxL4QqGXDiXCYQPyH33yTnQQf4K/
	ulzG/xLqUSl9xQL3+irSqLGNobP+F2vK244arnbNitqW8pPGDTbq7Zb9Z3D2WXsk
	7h/DWooheuWIUqmKnZY68GSw0KvgQUa0M+9NYJ40ydQ3ZxFJOrF8lvNnQKZqkOLW
	legEZdk00rQRbFD4V4bulEHAveklwlJJSz9NDHhCWkxtsYtjNyH/F8bQSW/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748360557; x=1748446957; bh=PbozZsZbLSt7AM+/vCpZgeMEQkzilRWKnFU
	K/AaOOGE=; b=p7DTiP5DInUNWKLg8P4eeK6jw8VS1/nf6jjuuCJ41S57lX8OHzG
	Vgv/jKWQp6qDYKLU/nAn6a1VR/BKgU5RIrVkuZjK5c78UClxSEv9WSu5mYyoU69y
	eo8WBkcOdOtXLu1VAza+9LaOJtq8z9Ufyee0OFil9Gfx3g3La3v40aqexqQe23A8
	khYZarJT1Av3YwzCcZeNMU/nOFt37n0Qv5BdRBZYnUhy6jHrhf6i7UN2u8dOd8M3
	Fh34rmajK2E4H8zp4o3mGUX2IMb2bgjrqVF+Q/sY/83htsXvbma09blNy/4oskwN
	n+49xDsIqilhwwDrn9RHXU2L96rsrT2CMAw==
X-ME-Sender: <xms:bN01aFs-NUURJHwJfZ4eZB2K10tYHZQ21Db9cdazbh7BQBGixMUtZQ>
    <xme:bN01aOdqi_ssFhK-AyPVaIvgvaQ9i3Qrv7QzOuRrpiSEjUbTEzBJAkm9_S_Vxeyzx
    hKs7i2gQJAjJhFW1g>
X-ME-Received: <xmr:bN01aIxmvDLNnI484AJY--IVlHGcEPSCxlLpQZ7OhEgqWhivJzBKfbWEYFmXslzhjbDIve9De5LtRGrXrX0czAaJ58hjjvNbJHat7jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdejjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefh
    tedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bN01aMPdTBS37kwG5WsIsMhfY3eRb-8AvPbhOgPOlWQXUl3b-MZsDA>
    <xmx:bN01aF9i_3nWdT4TDz7cN4LUs96ucvAIGEM3j89MjFcSjGyrIlkdnQ>
    <xmx:bN01aMXYmPadAJ4fOQGQ7xRSiv57X9R21EwaI3opG2gaKSFDXZnUww>
    <xmx:bN01aGfbDnBjaRy7CKAcnKfZeInhutIpE_PrDyVneVQzN2DMTTVLtA>
    <xmx:bd01aB00p4IB__FkNrPeodEEhILWVNCMqm7MAmplDgWxIMN-3avPSIYN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 11:42:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>,  "D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 0/4] midx repack: fix overflow on 32 bit systems
In-Reply-To: <7b6ebd22-78d9-486a-8be8-3da475015a8e@gmail.com> (Phillip Wood's
	message of "Tue, 27 May 2025 09:26:24 +0100")
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
	<cover.1747929225.git.phillip.wood@dunelm.org.uk>
	<aC/C9oQrcx/RiyP1@nand.local>
	<7b6ebd22-78d9-486a-8be8-3da475015a8e@gmail.com>
Date: Tue, 27 May 2025 08:42:34 -0700
Message-ID: <xmqqbjreqcut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 23/05/2025 01:36, Taylor Blau wrote:
>> On Thu, May 22, 2025 at 04:55:19PM +0100, Phillip Wood wrote:
>>> Phillip Wood (4):
>>>    midx repack: avoid integer overflow on 32 bit systems
>>>    midx repack: avoid potential integer overflow on 64 bit systems
>>>    midx: avoid negative array index
>>>    midx docs: clarify tie breaking
>>>
>>>   Documentation/git-multi-pack-index.adoc | 11 +++++++----
>>>   git-compat-util.h                       | 16 ++++++++++++++++
>>>   midx-write.c                            | 22 ++++++++++++++++------
>>>   3 files changed, 39 insertions(+), 10 deletions(-)
>>>
>>> Range-diff against v1:
>> Thanks, the range-diff and patches look great to me.
>
> That's great, thank you for you comments and suggestions especially
> with regard to large repositories.

Thanks, both.  Let's mark the topic for next.


