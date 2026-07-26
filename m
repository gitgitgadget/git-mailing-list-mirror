Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B872BE65F
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785083138; cv=none; b=bYBOpgs/DbrN72xJE+pxkB8pYl8/MVq3/TbIO8km9yxc0Kl+BeKIdEweligXAl4wLvJDvYRyJkHMDLYh1X0oI/refzNTCW78YYT156ISVdbVrhDeGON80L8Bhy4p7ciM9c7ywLTisSVxnAuJ5PatCPyGjN7ALCCJjAbLVOUUX2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785083138; c=relaxed/simple;
	bh=Fiq2AStmRCbhZtvCgO6fcXKIH7+qrrpsW5SBBDKbLgQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fIh1QHJ7hPt719o5ntKCNYjzH5QyNluORnb1MNnDakzLw81lTlMRXHfKBFecPWaEsB7aq1FR9+3JtVFTaws1jGgUiyKdJ/CofrQ+8CSTf0IVGGB9UAujmCnlOe/Pv4qH7nYNA3xwtzY142++AWYUBkTWXIRRGSc/Xv89hoObyYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JulyS//j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qbDquocZ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JulyS//j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qbDquocZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E2F98140041B;
	Sun, 26 Jul 2026 12:25:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 26 Jul 2026 12:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785083135; x=1785169535; bh=AEIgL64CtK
	vrg5NSHbliZwGGSUUMO8qHY/+aQr2L2+4=; b=JulyS//jloHFbZQcgGR3tr6t/7
	6ApJN+g+8giM9V/v2bZQrEur98eBPjBDlFOSpy5EvvZFzVaXHLVrvP4WYVKyVytw
	SS/jXdo3Cpcpvo3WgQUWaJFa6chmmLhwHUZS3uz+4+tHO8Qhm/8c6U140/Ni19Ou
	/yYIB8i3LAlUUPjZf8iKdb7X2f6tbipb2d0p16YcKJXpesE0JKz5q9MXdTI8TCJL
	J2KcJy0dCpdOOFCCwNbztWhhlk3Wv3G9cuJVN4G+Je75nUW1bBPOAEZMsqmqQbrI
	QPb8g5xUc5hqwprCkd6hFTZlJN2SwGqlCdlD7JHpxoDx1UI0ilUrE10ca6OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785083135; x=1785169535; bh=AEIgL64CtKvrg5NSHbliZwGGSUUMO8qHY/+
	aQr2L2+4=; b=qbDquocZjrTqcD8+irqCvoWW3qJVh2Jnf3SJHgid/5zRXTYnFfT
	DUfCz6U9Oq9HtkALH0y2p37cKrP3c8rvOgJNTXlmGRKqY19VSRetGwoSaj5FoExz
	902QcqdH0JfwrxZfttt+UGlNfOvRb/WpeYfMVl29mhzAQV4JC7JdObQYmz0rRqF+
	15hDRU7vTdGQ9Nrqzgm3m//LGlj74WAeSMvjFNOlvQHH9Q9R9K9n9PUI3ArT1iRk
	ufn9ydu354rzi9RWIGnvJvlh+wjhurXu+dEkkRV7YDKL4ONKrc8rmOn2olgf/X9e
	9R9IHHugO4DqSwXA1ES6hio4jNIhBnpOx4g==
X-ME-Sender: <xms:_zRmap0RltNhnOD3C-KffBhm4QpakjqNH4lvtUUEAnevNipgrVkDuA>
    <xme:_zRmaniFRv-bjxKz1Qz9_y423pZckFarzS7frSRzON5UhWmrWBFAGzAi8vVOrhMJp
    O2IMIjue8zRwckA_Qofn4esqrQESXhNQmCT7a4t0hJ_cdw38Vd_ag>
X-ME-Received: <xmr:_zRmanSsDlzqfXeoc04OYlgle8DXhvMFnIvA1ztw56f_qbwpXES9yDj1QhUQHIYQKg-8GWi3gIK9X97dZzkqXLFOLmpLUpNeiQ>
X-ME-Proxy-Cause: dmFkZTESH29L5zW52kMl5+3t72XjO//JXEVukJrqzy7OS9/WPrV+w4EmGAW7ouFw0wX465
    XQgI7+WbLOreJAZbNkDyngeYSaqiaW7OPRDA8mLHpOBln8hQ3owsN8GgscevYvn7FosebD
    UmAQvmJ/b6W22rB92M6maN6amRNIqzVHmC9eHx7Vv3FPYpjoju8s3x7iBglHtn78jGXx5i
    vDymR8aNP1bzhGznsPXPBaGDze3slHjq3z/gESktx2D68WG+mogQ2bYqHHBmvMiTD08EUx
    GmzQhAiQVm1MEjOyr2G+u7CXES9JVhDLoPVghg5EMHEuNETiVZ++lzTuFqEzmxmc/Sgqss
    EqXKdrSh0qEOzpdtGBzIcYIF4oe678P11Vee0LffRJhGFIOiq0A0MUTs2kAOy9cGemcKS/
    dJRGv+J7CLqLPXEbCsIsLZ495qNH1DLKlYcxMTHEaWBuujD+5v1NYkOv5JZv+uNTpxXqec
    vV4YGrxq4crWzRvSSe+tNWfaOtNMIzmW/nlqKDxaXHueRuEw2iZt1PDIpqolC6/LtbH0wH
    /8mkSuAv0Wm1DUyFfoIyJ0g7TadRHRy7ZWzhPvJKQZAxOrlwj6NZ1CoxvmYW7QoqNFCTHG
    tLthsJtQJuJ0uujKV2O3LA6Xt/RsVXnyiyR+DQCSV9TNgh3/ZonOCU++lpTQ
X-ME-Proxy: <xmx:_zRmaggp6txCS9R-V9LsSh4PWAqASaU-mcsxEkC4h6TGjrUuLkM6zA>
    <xmx:_zRmav4jUp7hjE3lR1AU6R0pmeIV4H8o3kBOfHt-rxdUA8k7kA9sgA>
    <xmx:_zRmalAICbLpNcVI2JcQI7sd6GCvxu5_vgMEZ1GQ03k7bDTUkg6Z8g>
    <xmx:_zRmauZz42KATP8XMy8mSsz6amn5fEd-51d-JMVcKji6kY6Z5TQ5Xw>
    <xmx:_zRmanoPSglI_VErttuSdFUUuyPInatX2yeiHpMewELZVWHkoLLPG2px>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 12:25:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 11/12] builtin/gc: fix signedness issues in
 ODB-related functionality
In-Reply-To: <amCmwKjbq2aNt8mZ@pks.im> (Patrick Steinhardt's message of "Wed,
	22 Jul 2026 13:17:20 +0200")
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
	<20260713-b4-pks-odb-optimize-v2-11-9c2c3ee94b38@pks.im>
	<xmqqwluyyhv1.fsf@gitster.g> <amCmwKjbq2aNt8mZ@pks.im>
Date: Sun, 26 Jul 2026 09:25:33 -0700
Message-ID: <xmqqwluhvhtu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jul 13, 2026 at 09:28:02AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/builtin/gc.c b/builtin/gc.c
>> > index 3207182488..8cf3781313 100644
>> > --- a/builtin/gc.c
>> > @@ -456,7 +458,7 @@ static struct packed_git *find_base_packs(struct odb_source_files *files,
>> >  		if (e->pack->is_cruft)
>> >  			continue;
>> >  		if (limit) {
>> > -			if (e->pack->pack_size >= limit)
>> > +			if ((uintmax_t) e->pack->pack_size >= limit)
>> 
>> Here, just like in too_many_loose_objects(), 'limit' is of type
>> 'unsigned long'.  While it makes sense to convert both sides of
>> the comparison to an unsigned type, casting only the left side
>> to a type that differs from the right side puzzles me.
>> 
>> Presumably, the other side is of type 'off_t', which is signed,
>> explaining the desire to cast it to an unsigned type.  But I am
>> not sure what happens if 'off_t' is wider than 'unsigned long'.
>
> Yeah, `pack_size` is an `off_t`, which is signed. But we never populate
> it with a negative value, so casting it to `uintmax_t` in unnecessary.
> The right-hand side is already unsigned, so due to the usual arithmetic
> conversion rules it would be automatically promoted to `uintmax_t`, as
> well.

So we are in agreement that this hunk, unlike others, have little to
do with "fix signedness issues"?

I personally feel that the true fix in signedness issues is not to
use -Wsign-compare or teach compilers to be intelligent about when
to issue the warning when given that flag, but that is a separate
topic.

Thanks.
