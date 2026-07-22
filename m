Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3C33D6F0
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719052; cv=none; b=ALno6YBg81FUZXEIQdYbWLF7LEtYSFy+vOBA3aVoBXiMsD4XeYz+E+BM6CkKXafFyLqUoU1CtlatfWouMIEyehOM8BQtLs0oDDuCp+j2VTI0Zx6DSnSqlglQSXG+K8hh6vwdpMC244dwTkIb3g3vKEpw61pyDkfwhx8lv6Dr/Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719052; c=relaxed/simple;
	bh=Q1PpCWPpruAzfOkJSgkBFwdDslRdyR8xlztflKgzZos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAUwViwSy5g4pAwx0uIFHrXEzzE9m2Jeo6YkdfmdJSMINU8N840vXsb7ocP0yjPfriyWvx0V8rSlOD/h+il0ihISvhED43lBalWxbt3+UvKpqseZETukkbVH4cBRPGH02hao/K7nQyjN0RY0mA6KDQPAo5HuYRWI56SFRpdRpf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DjNUkFjV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eZbL/BvX; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DjNUkFjV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eZbL/BvX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 39B561D000C4;
	Wed, 22 Jul 2026 07:17:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jul 2026 07:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784719049; x=1784805449; bh=KHwAx3e0LK
	Xc6rgO/c/wp3wT2ZXM3eOV0Vj3JSn51Kk=; b=DjNUkFjV5JMmcQCNIkh8rzhnoo
	8LtvE6jq/2vDmmkELC4DrFhjdhQr4i2CU1Hq51igWkQA/fiq6+mnwC0Qq61gM/Ba
	n8kFRHXh0kYlNNRP72VBDXQowjwi06bL3glJrIKwKhtxv0fQ3sG1HZ2fsqU1QmMD
	4b6mEkxMNQ6pkLQBqik9IO03UWL0JdlB5mrRNlujv/DiXmM0bmx7MY3jlzA5Hj1f
	/Rbz/Hmnnz8SEjfSrEePWjT1n6QoK/Q6ej6wInrLgTXgpGOysMrwVv+w68y5Rihz
	VXC//kJU80dXJW9TtGKDAnE08kaV0eTcB5d8XzwWFrbtZ6RF7wZcDN3y6ClA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784719049; x=1784805449; bh=KHwAx3e0LKXc6rgO/c/wp3wT2ZXM3eOV0Vj
	3JSn51Kk=; b=eZbL/BvXTYpMa9vdrcmGDkLV5jzzboY+DeMjaE+0/5+4tybM5oJ
	whsKSrCF9OtUnyqMB9Da/EXmF5U3ra+pS6OxOjl5alU3ZOiRz3P1slOwE4AQ7t9T
	d+5IMZDWu0IxcG1qUoBJ3TmnYzX+tVrMf/TSdJ7pBLqmIJPxaHmLshaAGgfKStUg
	mgRwkaIqrpT5iQ1q5hFgM4TygLHYnpM6UDqssKzGip+V/PU5KE9j6OqhzSOpOu4S
	vjBIQruTdL7HXgG0VkQM6LZJmQwc1Limls8xJjvRBBBNIcmyRYDrF/IBD9XLNmv2
	T0Qu5vgWB+zGn8OJvajm3vW2DqiLAeCTqtg==
X-ME-Sender: <xms:yKZgasPfp5JvQ9X7kG8FVmxJMUWt601EUcPwSsHmNkNU-NLoTi8nUA>
    <xme:yKZgao8X237opEnhyBk3NV9wJ-q06eXgGjn5YeBG5OnJ6MwgH5Mgl3FlHK91VcIFp
    2lJuladDZf2pdplj7Lb02Cv-sywq2YzOlybEujkhA798zZIh7MPRA>
X-ME-Received: <xmr:yKZgag54kMhFWAoltm1u4zT4pE1aco9fNW0nUpb8blYlc5j3cYR5HCAJR_KOGxYwUuWXlGXeoO7_0PwEiBNzr-hERlo1Lh8D0K8ZhiPenw>
X-ME-Proxy-Cause: dmFkZTEJcnz2o/sUha5cEGDHVwbowT1S/X5LbPsuDoW3U6Ewr3LQ0cWVncnVN+U1jgzbMk
    sj5ilPx+Vrej6ifM3IBtFOLSKaH76J+uPNYVgp7fvXEF7zzoWx26MbWrXNspSfr1edHoJ5
    VFPC1Ol29cTqPxopr1+cUyBjjqnuhtt8gXFIgKRGqlW5nVpgVRdnoc2T8PMxz5p6d17qoB
    ovV1Hz25UqX8XtE8werDcEqWh3XovHtvWSqdOLhYIFsCvKsCYGLqrMZHDTC9Gh+IGSb4qZ
    J94XiFtTaJEMmJCu1We4HIuTOChF9dmM/g47vZDt6MmRfb8voZj51tqUFVNN6+b/E99jdp
    Z3+cxmNHek2b7LjR8QaLdeYgLjDH0uAMyYqwiMYp0qh2W9HOAl+z302x9X6FNLqAJim8mh
    eLR45IYoIy0YVtwQDeJOQiS1NQ1n8uUM0w0GTVGeLKDdk9TC4Tz9AysUokQloqwu6VZFxG
    1qTpP1kPdOHSYY4pRr5EyAw+B7NAfSWaW0+VBJIqY9zWmyuce6FJXKd1qQ4UPq74aZh9Nc
    PLlNCBsZZyyYjTDRRi600wyHaFZdLX7h8YNFmughkPmvCrnq4kzaB0ZtRBdUZ6SWxLOz82
    eqO4FcK9q0P0dIf70XJkJj/6lpevVkHUPArPi7/di+clzwUsCfSPDsDF3WiQ
X-ME-Proxy: <xmx:yKZgav36ISpx9x_QlXKjOgjEq_j7yAwyf1r6haF0w9wNLRJ73D8hoQ>
    <xmx:yKZganCp-Shl54uOjbsTqqiK3bHbVG4BzCPJL19LsHXile03Vledrg>
    <xmx:yKZgah2wX7GmcwU8D0O_N_mTVpvlQ03-rL4sGaFZFV5p6UXlWVg7PA>
    <xmx:yKZgahu9SNrHWoa3PcphhMl4BDHL_EE14AuYCLY1-ayPgGHfcm0Bpw>
    <xmx:yaZgankL76_7QrtCyLjLMxSmUKVFZMFBW5OUiX1yrOYIGcpzWXqiZPXU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 07:17:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dee29c33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jul 2026 11:17:25 +0000 (UTC)
Date: Wed, 22 Jul 2026 13:17:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 11/12] builtin/gc: fix signedness issues in
 ODB-related functionality
Message-ID: <amCmwKjbq2aNt8mZ@pks.im>
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
 <20260713-b4-pks-odb-optimize-v2-11-9c2c3ee94b38@pks.im>
 <xmqqwluyyhv1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwluyyhv1.fsf@gitster.g>

On Mon, Jul 13, 2026 at 09:28:02AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index 3207182488..8cf3781313 100644
> > --- a/builtin/gc.c
> > @@ -456,7 +458,7 @@ static struct packed_git *find_base_packs(struct odb_source_files *files,
> >  		if (e->pack->is_cruft)
> >  			continue;
> >  		if (limit) {
> > -			if (e->pack->pack_size >= limit)
> > +			if ((uintmax_t) e->pack->pack_size >= limit)
> 
> Here, just like in too_many_loose_objects(), 'limit' is of type
> 'unsigned long'.  While it makes sense to convert both sides of
> the comparison to an unsigned type, casting only the left side
> to a type that differs from the right side puzzles me.
> 
> Presumably, the other side is of type 'off_t', which is signed,
> explaining the desire to cast it to an unsigned type.  But I am
> not sure what happens if 'off_t' is wider than 'unsigned long'.

Yeah, `pack_size` is an `off_t`, which is signed. But we never populate
it with a negative value, so casting it to `uintmax_t` in unnecessary.
The right-hand side is already unsigned, so due to the usual arithmetic
conversion rules it would be automatically promoted to `uintmax_t`, as
well.

Patrick
