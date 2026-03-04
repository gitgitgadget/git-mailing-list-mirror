Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D94537F012
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772607477; cv=none; b=F44twEWKZxWAQVvuLh4d6cMw17l38D2v1dpJLqBg05SvGufGZeo0hj4MGCBmd5KNGGtzgmbCD5MLMeVcxepv69/6shdXzgKQ2N9V4sfvK5k9PBLm+im8XdLhEiThyKW9fyt62rK3ZLsHSAKuXHgPQCy1ZzYW+ZBRrD0vRW3WqBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772607477; c=relaxed/simple;
	bh=PNzPDdaJsTyIv9ih7nWepxU7rA2luH0daHD53CUW8JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXQPYp5YDTzAHZiZAm2kJVIuYCHYsl//WDIE40O3DRD63Z3nYB2QD1GVlnXSc4zQ2UsC53mL8k9OurjGzK+5hyV5/LwXAsye5/bKVG3FV4z85Y4T95G8X59CAEAiz3/0SjMl9uzL3UsZU3+9QF5dqp5lh0RInFgh1m0ZXfK1gXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NPXHEtp5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EeDHdmZr; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NPXHEtp5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EeDHdmZr"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E58D1400169;
	Wed,  4 Mar 2026 01:57:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 04 Mar 2026 01:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772607476; x=1772693876; bh=D5KOWMZZ5s
	8UJRgxWvsPpU4Maxrv7K0o0NEHoDCQHng=; b=NPXHEtp5e3MHNXr0UGoy/p1v+s
	ZadVrHGMdB5DmnhSZYmuyaCGCF+RKgos3EEeX5hR9u0ocv3ZFqUIqtjcmjpmpams
	A5hYZhxTLuQ8mg1hb2YYPptThd0zr/UiEG9bX8WyMEat3lwFJbrMBghUSqoEQ3RK
	h5z951fS/z3FVDg1LKSO2D3Q1JUQikltKLQsAqf3gSg8MheWiEkr5FBbdYOWymEd
	zETs9IsUYbFORGbIXmg4z5J4DU+GFdgTKOBnmdg+6hYVrz8tIeEHuFlYbFrTMxsP
	awsSxdsAWLYZwIWRUf/quO7mmPGkNN2rlqUBI84Qr4ToR3sVw7xDGeMprq3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772607476; x=1772693876; bh=D5KOWMZZ5s8UJRgxWvsPpU4Maxrv7K0o0NE
	HoDCQHng=; b=EeDHdmZrBYfH3gzCoa8WPkGqFluhdoKlZpadJOUI6u5ZwoCzWew
	iaJI3OpzHfIAGkNTb/ol0ZyZ4eGKdwPvfM1n1wHOIIwVOPYBI9ukImEnz9htDOAM
	t3vfe3HJsnI6IWqQtORKb4rYxJu7Z2em41F30znVS5JjuYa9LjRMZho7VLLdsozV
	CfFSpOIL8+NLLUO/sgbNr52nHJG/xPOrLtoPOuJSa/ld36jIKYwb71+DkzPhJSUY
	ReW8/WvnFO28uyMo3xwA+JE4bpY3GW/mbun2jHzlh9EaMvh10faVGHkFflSokyg9
	9j/Uh5zm+/mwdDIaAzcFXKbQDSolHFkll4w==
X-ME-Sender: <xms:89enaTrgG-LzPx-JnOg7_NPNqZAosVZsqgcMdudeLzkiZrXacIPk3w>
    <xme:89enaVGMnASonA4hL_DBigtCMBEJA6z6JdFvd4b8N9yOE_pLBZVqyHmgloSPQT-ZH
    3a47lc-dhwiVvsxBNUMaS9AmXPe6jelE4eGNf4-As06eK9cINUyx5k>
X-ME-Received: <xmr:89enadmM4mlGLe8JBKh8tNJem-q4FME1QnlERYQDb6LIEWv8KqAw-sT1ZbT0re7q5XyxlT_SaN24LCop_Wl7-g5pCgrYLA_nReCtUwQDZvcW5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:89enaQly146CvpwPNFkif4BXezVsd1vVeC7Jgw481MuZNI7M-nhUbQ>
    <xmx:89enaWsf3brsxeBcEz_yB968PwuT8b3h9I9bjciRe9gSK6cc93husQ>
    <xmx:89enabkDlgXWynlS53SsXVbXOTSEWCGr4hvyRJU8AFmFUyrcTlOCEA>
    <xmx:89enaZvVlnJ4TDyONjqaz78S7vp4tzb1r7ACaTgrWcSFoaadTxJXWA>
    <xmx:9NenadFlZcJFwJFlA9EuwtB6IIERIO7fQE5BJs_VbTe0fYW9z_cDN5GP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 01:57:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c10891b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 06:57:54 +0000 (UTC)
Date: Wed, 4 Mar 2026 07:57:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] sequencer: use oidmap_clear_with_free() for
 string_entry cleanup
Message-ID: <aafX7_BqIYDfXQtN@pks.im>
References: <20260227234213.17633-1-kuforiji98@gmail.com>
 <20260302200018.75731-1-kuforiji98@gmail.com>
 <20260302200018.75731-6-kuforiji98@gmail.com>
 <xmqqwlztx3f7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwlztx3f7.fsf@gitster.g>

On Mon, Mar 02, 2026 at 02:38:36PM -0800, Junio C Hamano wrote:
> Seyi Kuforiji <kuforiji98@gmail.com> writes:
> 
> > From: Seyi Kufoiji <kuforiji98@gmail.com>
> >
> > Switch cleanup of the string_entry oidmap to
> > oidmap_clear_with_free() and introduce a free_string_entry()
> > helper to properly free each allocated struct string_entry.
> >
> > This aligns with the ongoing migration to use the callback-based
> > oidmap cleanup API.
> >
> > Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> > ---
> >  sequencer.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index a3eb39bb25..75ef2ace4f 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -5654,6 +5654,12 @@ struct string_entry {
> >  	char string[FLEX_ARRAY];
> >  };
> >  
> > +static void free_string_entry(void *e)
> > +{
> > +	struct string_entry *entry = container_of(e, struct string_entry, entry);
> > +	free(entry);
> > +}
> 
> Exactly the same comment applies to this step as [PATCH v2 3/5].
> 
> In other words, with the current codebase, these three steps in the
> context of the current code are uninteresting with little value, but
> if we ever add a member to these entries that hold their own
> resources, it would become easier to manage the lifetime rules of
> them.

Personally I'd lean towards keeping the first two patches and drop the
remaining ones though. I think it makes the code harder to understand to
convert all callsites of `oidmap_clear()`, even if it doesn't actually
provide a benefit.

We can still convert callsites to use `oidmap_clear_with_free()` in case
they grow additional allocations per entry that we'll have to care
about.

Thanks!

Patrick
