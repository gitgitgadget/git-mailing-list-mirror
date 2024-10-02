Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8F8482E4
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 04:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727843383; cv=none; b=XTEoJvSJ7oSKypzgW+UT0W7kF6O8et1AVRAwWZyZgCKC1pVww4d0lxcvLH3UxrHHRPbSYiojWzyMFk0qyulibwly2ZsZcAL0wgMYnEFgMZAwToIi6lN3EW8Y7y1byyHaPd2gpgkQS52Wcr0XqGqsk1xbFXzfbJC7GwTyHcN+lbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727843383; c=relaxed/simple;
	bh=z1iZwrEUBTurBKGDmcCYfN4xj/GBdCA5+epf8WAJCRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSUKFe6g0i5XEZndJviKgmdUimC4PJhyWB6rVBxe/YB2ALsW7UPR01BFXLsnr3QabNg5QQdEtEhjDeKbNtnfZtZJu1G0TB78TqlDyt2qUj7MptLWDo8UZ8R5KxP7/43uRkSQ2iPcGLiZYOsFuVoUQ80LJ5JC0iHWudX+i2m4+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cg1kG++8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HD0vPEkJ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cg1kG++8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HD0vPEkJ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E8ABB13802D9;
	Wed,  2 Oct 2024 00:29:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 02 Oct 2024 00:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727843378;
	 x=1727929778; bh=1yMjGVJCCR4RPY+3L1aj5uNU9mwlcsrPpJEB06hVoIM=; b=
	Cg1kG++8RBbPSMdwDxisjTqTksEdfGb3mf/hS7eZwNyZRhMjJhi8xnyaH3oYKZOs
	W+TMqYQuQ+dwVrAQ7HdA5kFnfflK1VuexhtMsa5PbbInWC6idbPWr2LQGMafcOCt
	sdZAUfWNgyAi/je//O8mWKGJtvcX/8uqacFmJP2iwXmLpfOBlq/jChS7FyNEsjNS
	6tDO6xP3lyDrriElV3EV9OYveV1BcpoXIEyHV3NYoUXjYaX+NVBmUimACh8+fL0J
	jAQl7EiTG+M8z2nenELisYu6qCXtKw+LJ5TNaTs+5uXkBgNRvD3bgthgS9/K4Szu
	/GkCgBVZXVMKQHHekUmI5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727843378; x=
	1727929778; bh=1yMjGVJCCR4RPY+3L1aj5uNU9mwlcsrPpJEB06hVoIM=; b=H
	D0vPEkJULmJGMYWBp2bpJZCFMt1f8orpPdGmFniErOh2hPTIS92Gd4IRyra5jZAH
	g7mBp1+/YqPsY7T20swdn5Nc0p9BVKqIdtwok69+AgpuRFUUCeKnWxjxJda4s3mM
	K6wh8If29ReYsa7V4C2Rdh3/j6M7bNPU3eeVnU79D2AvYxELQpbzw8X+a24g1qkU
	83UCz2mmWMy3MVI0ZfGYVm0JG6pVpMlQO7Iqbie8RF+96hQGuQiRGfDjPBvfpQhT
	KUbtyPStr1sixadE3poZ0j/RM+ABDimjqNT58Hu4Fy6g9xqjYhC+hiOJYNjwmBs2
	VFl4I9S4H5aCsjxT6DYuA==
X-ME-Sender: <xms:Msz8ZsW5TGqZkcxQHDaJG8Ha9JqKhY6lkFXS-8JxAxqedL5EphETag>
    <xme:Msz8ZgkzJJFUCIvVFQiVn4W2QZlciljyx6f_4SqIQpCWjHCyOpNhn9OhB-Y8Nvxgv
    _pUMJ9PoTKaDuoyag>
X-ME-Received: <xmr:Msz8ZgYp8COLTeX4KsIRphK89zPQa0OexZHzXfaoU34alT01gXKaipUbGZSklAciqrQgB1IBcqpqCRH027M9EJU7sxOiXPzcSwqv2RmlYP9Rdtlo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddukedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrd
    hrseifvggsrdguvg
X-ME-Proxy: <xmx:Msz8ZrVHiFyR7VwxePmYGyyP0CamM4t6lWusV0dX6HJLod3NrzrXnQ>
    <xmx:Msz8ZmnqkiMaYHXXZbFryv9D-FN7fLQyzgJ5ogVqM6EvlnnBpRviog>
    <xmx:Msz8ZgfB2stdN0WMS_5MLUqul-BbgOjSjXQoCTATkW0K2dDGo3aX_w>
    <xmx:Msz8ZoELoszZK1pIkhqRFzf_uabuPlfNzerzrQsxHv-xK_ZNAqaeXQ>
    <xmx:Msz8ZnApnyPE-ZblN7fGqS5PQAOBPeOwCDTZbGnDqnoSbX87tuLV-PaC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 00:29:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 336421ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 04:28:46 +0000 (UTC)
Date: Wed, 2 Oct 2024 06:29:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v4 00/25] reftable: handle allocation errors
Message-ID: <ZvzMIWNfzmZL7eHS@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
 <xmqqzfnnyakq.fsf@gitster.g>
 <7740463b-84b4-4a69-961c-278ce2901f0d@web.de>
 <xmqqjzervd69.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqjzervd69.fsf@gitster.g>

On Tue, Oct 01, 2024 at 12:25:02PM -0700, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
> > Am 01.10.24 um 19:52 schrieb Junio C Hamano:
> >> Shouldn't we add FREE_AND_NULL() to the banned list as well in the
> >> last step?
> >
> > And perhaps the wrapper.h functions like xmalloc()?  At least as long as
> > git-compat-util.h is included by reftable/system.h.  Can be done later,
> > of course, no need to reroll just for that.
> 
> Yeah, and I agree FREE_AND_NULL() falls into the same bucket as xmalloc()
> and friends, so no need to reroll just for that, either.

`FREE_AND_NULL()` would already be detected because it expands to code
that contains `free()`. Same for `REALLOC_ARRAY()` and the likes.

I'm overall a bit more hesitant to also start banning all the Git
specific wrappers, mostly because there are so many of them. My goal is
to rather make them inaccessible in the "reftable/" code in the first
place so that we don't have to play whack-a-mole. My plan here is to
split out the POSIX-providing bits from "git-compat-util.h" into a new
header "compat/posix.h" that we can include in "reftable/system.h".

But it'll take a while to get there :)

Thanks for your inputs!

Patrick
