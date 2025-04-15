Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FD1E1E1C
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736357; cv=none; b=ocIo6K0QB8msrc/yhLO6AEoG/Pz3UPAHxuph1yZFbuxPxK6PYgbVqONWGkt5V3Hxy5tRoKOPA7pAizSxX+w8cmB40U6YPBljnyEslhSR1k8N1cEeXu14YK/HYRJQSLuethgVLmfWkF/POqEjzDsnFEFsXfEjXgtXgtqMCf2mdoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736357; c=relaxed/simple;
	bh=Mfk5vXdZiD6lWKB+nfaAQpPDW0NpK1cNyMK+YF7i/zE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f46bd10vU+ba+eX/OHO1Yp/AjxYO5G8R0h/3q4oxvC4KVlISLUOPfdPzOVKNUlAD+8fZ2ifzuBFAvTh2E1Praf/YgGcoRGN2X/33kFoKhI6161RvyunE19uhZQJwOibuNp0kqB9e6cKhUd7szxrIk+28OPudvUPULu6pTXcGEo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LImA2xoH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=atRK+xOq; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LImA2xoH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="atRK+xOq"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4B6D254015A;
	Tue, 15 Apr 2025 12:59:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 15 Apr 2025 12:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744736354; x=1744822754; bh=G6QcITvy5w
	RH3FmbOOSsATjc2xHCpNMbNFY3FQUSLxE=; b=LImA2xoHtL9HUNQkIZmMK0jX4Z
	WjS0wOnLPsewAd3AhUA6R00UxZMpF56HGAW8HaViZfQBpYNF/oF72D41b3TbVD5O
	J3tNCh8PVs1rikwCOBAuY9lB6acXJZq/ipeJ1bSXEsJA4Ln7y5ePsowQxYs/TKA9
	ArkyFbdaRrrnL/iSndUdBlH5BntTKyYJORN/DXW69uJrSKS9d3yu0XwLF5jGJwTo
	VxGOcEYnErQkyuNSiL3oqAcFKMjRodVvNWJpHuc8GxcrxW8IS7Tph5YqMiF4xJlh
	ZbAYHmHMCE8PNrk7Dh/VwKXxiO8IK3LIQmk/82PXn9UcbzjDCnbtGZK+FdDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744736354; x=1744822754; bh=G6QcITvy5wRH3FmbOOSsATjc2xHCpNMbNFY
	3FQUSLxE=; b=atRK+xOqdZNKY+10K5WEPAIfpojo+dmH1R2aqBCVW3hFE3IRsoS
	3ydgspiJo6h/W+0R2Hv2Fs/vSyvzn8ql7obU/n5nThGv7IXrp+PusQ3teeilqYaQ
	UCDs/DAO3Cl/4tAHnRyUP3eVDGTJGW14viomuOtm/JNPw16n7I9hX82CkoDkE083
	tg9aSCH/KKLUD8LwWPwWy+fKKFtqeQ1co1Ve0vfRxRo8KaeaINfY3Cd7Ycf1LkGX
	dWnAyLbcphRlUq9rPhqRpjZBn6X1F3GbFRwtBWjIlb3h4ruFb1OYGRqc/adOcgLs
	nikyv1o8ZtYynTUanVNEzc5lHI++YVTZ2AA==
X-ME-Sender: <xms:YpD-Z3FNaHtK9tM1zU1bmMoawFgRF3pZn88TtNSLcCc0M7V0ceimFQ>
    <xme:YpD-Z0WbHuvhySu0Zc7g8PJi5or4haURd2LcZ4YlaKADzcPM4prcXXMF78-fzz1fj
    Qy1S_NL14gFoOwPdw>
X-ME-Received: <xmr:YpD-Z5JyhIxl76tDQjpQQD4hI4aCj7f8a2h4ocgjkJhR5kKftX8XsGXJGnUClH3YQMg9IE7tZMijlrn8npW3uYp_fStL-Uo0Tm_m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpth
    htohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdgu
    vgdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtth
    hopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YpD-Z1Fgz1IUTBTsHMv8HuhzyYB1y_z9CsONPMKxXjogvjBNIvpqhA>
    <xmx:YpD-Z9WMxNfj9EnFge4QonaTbbFsKS-DxOtJt9z0eMpRet8DJHKhOg>
    <xmx:YpD-ZwPxeYDUhPQmWeHWYZBaBcFAAhSrZMme3GUIvYUxZwiZgwECow>
    <xmx:YpD-Z83h1X1vgh_WYVvwBSnFuQgVu0RJE1B325RO9LFbJipvhiA-2w>
    <xmx:YpD-Zy1pIslZVxaQbW3j-GP0WuYt8gHYhM8_JfrjyXwTgQ_S7RUJeBJL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 12:59:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Todd Zullinger <tmz@pobox.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Derrick
 Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/5] parse-options: introduce precision handling for
 `OPTION_INTEGER`
In-Reply-To: <20250415-b4-pks-parse-options-integers-v2-2-ce07441a1f01@pks.im>
	(Patrick Steinhardt's message of "Tue, 15 Apr 2025 14:14:06 +0200")
References: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
	<20250415-b4-pks-parse-options-integers-v2-2-ce07441a1f01@pks.im>
Date: Tue, 15 Apr 2025 09:59:12 -0700
Message-ID: <xmqqecxtmkdb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/parse-options.h b/parse-options.h
> index 997ffbee805..8d5f9c95f9c 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -92,6 +92,10 @@ typedef int parse_opt_subcommand_fn(int argc, const char **argv,
>   * `value`::
>   *   stores pointers to the values to be filled.
>   *
> + * `precision`::
> + *   precision of the integer pointed to by `value`. Should typically be its
> + *   `sizeof()`.

The fact of the integer allowing to store up to 16-bit vs 32-bit, is
that "precision"?  "My --size option runs up to 200,000, what value
should I set it to?" is a natural question the readers of this
sentence would have in their mind, if we call it "range" or
something (which might not be a bad thing to have, but that is
totally outside the theme of this topic).

In any case, include a phrase "number of bytes" somewhere in the
description to make it clear what unit we are counting.

Are their common use case where this number is *not* its sizeof()
already in the codebase?

