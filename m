Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3289EAC7
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 04:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775796818; cv=none; b=QftvSPYZWfXWY1mOnMHNfd4l19QAsoa/TyW0LKDgYxR/VGeM91nseAfU/XoUSjh+dTo6unx/qJvQiJ0h6GT3fMDTxkr4LjYt7VffYgzqS6QXZARgPZ8nr+e9LmxHekIOG4XZFuA97GMI+ePRcbHGpUht4XLiD7hvcnRkMhbKg24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775796818; c=relaxed/simple;
	bh=4Vf2S4yWDNYXjrV7ymYPunHIsNz0QAihp5BoGebHyLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYCpAhOQcYWwECGPKLM1XfowaymVBa5NOjnogeHwsq/7HqM5nA7HORv9vzu2h6Jl2ETi9X301ILXGCGcXoMlgJzwL0qTg8iFhTM83jb/fJMpYSQwgXrGeJnwvQwE9SnNTfvV+Kfs/N0Bchhuj9thZPiwIltIM9oEKhzA7K1QvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fr8QcOIV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iatdWr4I; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fr8QcOIV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iatdWr4I"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3B45AEC0414;
	Fri, 10 Apr 2026 00:53:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 10 Apr 2026 00:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775796816; x=1775883216; bh=RqqzSZwjSO
	mP9SZJ2PUuI7ipVxQfcO3ivYP7T9QzmDE=; b=Fr8QcOIVOzCs7i+54dYlHqobwK
	Abh3eSF4vgASpsTb+Yhpeyw8ZCvsVNueCgwkMdUCvJwERNT/otEqzb2eqhXvmxxv
	wBKrr+LhXRcHQkBWg7iPB5eBA8CDxtV5UCxs4ZTFho8arynWIdBqrI41sI1jlCNd
	u3Ea+K0XGw7WtIozo/qoernDs/zeSJ0YWoeVeWKRkMeo1IGO3aTsC4Le+ULubs9I
	tFQjaiwJVN+nzfBtBcbVBCWdRYdp77F/mZuTf+CKcy0IboBwWRSbajZ1F0gJsPnW
	r0R3y1WxJ3ALz89wx3SDQPzDr+XwFA+1Zng7m0ttvydlmrz5LQ0paKCvaCsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775796816; x=1775883216; bh=RqqzSZwjSOmP9SZJ2PUuI7ipVxQfcO3ivYP
	7T9QzmDE=; b=iatdWr4IzSYhQrnMyCH5+B+OEwYHiyjlSuVL5nIW7DBi04iSPTO
	QjvH99tNlsYql+AX8bJ8qCx8NAb0wChi23yeDA33ONe/obebb/0syQTARLs9B1n9
	ITmGVV+l1znHDhDh+OfSUvo1Mavvd6sPoHu7gofXnsDTaeErWHwJ77zw9TWMTKqE
	SgKLNpL6/kfla+ZNgjbHz7qAWrwwaBnnsL+qFvTAr7VWTqCEe02slOkIsI36YMVm
	iigyGdgruq+PQvJN9C+6RTwf/V4fWZAD2MOX8J01fHrz2uk5s0AWMCtr/t7NEQdO
	fdmZAkcFCR2QK413CbDyKECrsjt/opFXDYQ==
X-ME-Sender: <xms:UILYaf9oZIuTUWnSaT1ipu4ey0nc44J2pHuSVFRr3q1ENgAfIZpwiw>
    <xme:UILYaTLG-y6ICoj9D5brLtGTe6O37-GmIXmrRcjV4PRkIA7P-CMPK7-D9_g7r8mZL
    t3ebGqDCX0mF7Dlk_CrwLRiGEOV2nSah6BXjAKH8Ih9C0PCh5jz9Q>
X-ME-Received: <xmr:UILYaaZX2nux0reV7qQTeSQW07ebnT8XdW-BlEH-bf5xGmaPxhP8XbMUsx_VFhI68ETHmm8Nc1rd7Eyq11FyqQ6A2IFFaVvRFcK5ihoyxoVWtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvkeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:UILYaVL5iJAJl6DkTZVeWZx5g8UH8F2FtGy4tkfH9gBrsPzjWP16-w>
    <xmx:UILYaYBPS_gY5N6tcch5OjlDHTUuFonEXq76iJ-zx_h8ig97JstGrg>
    <xmx:UILYaapaD7aWYLwgTArU5bTLu_-ocd_1R-mYqcV1e557cBUOYtygJQ>
    <xmx:UILYaThgib7Xspwf0J73To2GxugXD4N5KPCSuvrtuWJzuouly288ug>
    <xmx:UILYafJi2l3k2BH2g1IsBCUKK8g8qBlW75a-Dnn_LG-Fv3_t1L4-bs9_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 00:53:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eae80fa7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 04:53:34 +0000 (UTC)
Date: Fri, 10 Apr 2026 06:53:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 16/17] odb/source-inmemory: stub out remaining
 functions
Message-ID: <adiCTHTDzmnvMOIt@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
 <20260409-b4-pks-odb-source-inmemory-v2-16-f02b4f1c0f13@pks.im>
 <xmqqzf3bsz3f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzf3bsz3f.fsf@gitster.g>

On Thu, Apr 09, 2026 at 12:39:00PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Stub out remaining functions that we either don't need or that are
> > basically no-ops.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  odb/source-inmemory.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> > index 15a6a5ae64..1140b1b916 100644
> > --- a/odb/source-inmemory.c
> > +++ b/odb/source-inmemory.c
> > @@ -299,6 +299,32 @@ static int odb_source_inmemory_freshen_object(struct odb_source *source,
> >  	return 0;
> >  }
> >  
> > +static int odb_source_inmemory_begin_transaction(struct odb_source *source UNUSED,
> > +						 struct odb_transaction **out UNUSED)
> > +{
> > +	return error("inmemory source does not support transactions");
> > +}
> > +
> > +static int odb_source_inmemory_read_alternates(struct odb_source *source UNUSED,
> > +					       struct strvec *out UNUSED)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int odb_source_inmemory_write_alternate(struct odb_source *source UNUSED,
> > +					       const char *alternate UNUSED)
> > +{
> > +	return error("inmemory source does not support alternates");
> > +}
> 
> OK, 00/17 said it only fixed log message, but the messages or
> anything end-user facing should consistently say "in-memory".
> 
> Or, "in-core", if "incore" is chosen as part of identifiers to be
> consistent with the rest of the system.

Good catch, will fix. Thanks!

Patrick
