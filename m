Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85112E413
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876168; cv=none; b=SBptj5hUALnQ/VseWujrsLgKhQBHOpUqwhbYksK31Xj7SSf3LJwC/fCVKPx+VcHfNDWvb8ty0U4qZ0caXOZ4jaRlnG4HsNFkuEZqV0MMQDeu5ye3mEOdhZCrlVX7bcc5VtHTT8ENmdxoupoYBTRXnL8RnONLRYBwHtfh/eK7ALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876168; c=relaxed/simple;
	bh=Co6nzye0TQky7swkzgftn/6kMx1JuUfCS58+Oaxi+Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjAyFBp5ijWnWSvOPW7myIXzP0u5wrN34/U/ZtogJ7IcM1GzXv9UVaQUOsIS/tC8IAmoGT59yarsGQzrkV9Zg4RBQvd/ZPQLoB4EpGsFTc7eKjTC5EL2cyoXriwUJ9fc9/aJ5stsdf3uWfn0Iu3RqkvLE7SkoNG464vtL4qEp5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W0xVjJ/5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VisXtrk1; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W0xVjJ/5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VisXtrk1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E67867A017D;
	Tue, 16 Dec 2025 04:09:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 16 Dec 2025 04:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765876164; x=1765962564; bh=j1Py5QTrtq
	RIFVzQh+ChNbR1gNZwHR+rJovmrSnAtog=; b=W0xVjJ/5yW8/OaMslJ4lRQb3fD
	AEW8aWaqtW8n/fF3A0aMEJMhRygwDnOa9R3X/U4dEn8qTvFgydlGOl0eekx2jfYo
	BqAGDjn76cWqlbFtHKUEmFQm0t9k0wxoj88rU0zHavx26QcGJ4EBzw8/MwJU38P6
	K8zxNArtP4DQKnNWIyxYofKT1a5auBNZYhRA3iX5bicCxzl8lcQq9TY5mG9nrzJh
	ljETOsbJ0XoM3pp3I4QapTNjXnTOVcjXvX0/CuvNn2yyZrbgVUquIdCVXkLSfeHp
	CLEBE7vUGHSFvwG20SVixN0ihzc5FgCZkvEzxw5Rlditax7LmckjGeo6LJvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765876164; x=1765962564; bh=j1Py5QTrtqRIFVzQh+ChNbR1gNZwHR+rJov
	mrSnAtog=; b=VisXtrk1J5Q5P54Th99XZY35lEL58yR9bmF+/ZM6Gbfkz/VcF09
	eIVUQmObef1spTKi00knRVSR7n2KeLvH5gsy5MPabCTcMSmgVz6vBfrq+3aM03tS
	Z7elWkRpCsQecWdbOc2ZAq9pKj+y3F7Q53UGjKkdoKgOEnBazWBsUaywq1aHzpz6
	BxEAXuzaX90UEdNFYbRLKIOwBoppxxX8qYc8hlx8IS9kNlCNkNr4hTiPxuxlPKw0
	oh+2grX9E99ez27DjsjAj52L5d6CaiGtD2lCYMWjCVCJ5vX1CNZrdME34Yvh+x3x
	9Nf7/78C0+IRszGCITxWIyRghi1ZgEvy16w==
X-ME-Sender: <xms:xCFBaYxJJIn0z3D0w7n2bTHPMutPzYfDU71QDmeYc24ll7J_ENTzww>
    <xme:xCFBaSS4KgxbFad6bPIG8BBhjFBLPi3m758eQh4nsLt5IPN9Or4G7FXjn_USjU4op
    YMXYYvq19H8O5djywaT_kHMgZnYSfSQDVj768M0McGnL5kVWt2v>
X-ME-Received: <xmr:xCFBaX-1Gb0A_e1-euq0TxUb9OA3N2pjTTUt6eHkenzfc-3Iez6rzU_TN2kmqqdm7MWY-idS4XVsTJgH3Goqi3KMArHjPv8nIeceZmbVeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefledvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xCFBaRqq8Dcu4_27RowokL7Nf1Y7jh1pUqnDEbluBXLPAuiMfcEvEA>
    <xmx:xCFBaclGClAEjML950BphAY3Ivl3_xrOFjDrYAzEt4lbNqkeXpqitQ>
    <xmx:xCFBaQKl3HzuW-l5PIIjmKmrzM0YGWei20l7LRC4HDCU00JtiJYp2A>
    <xmx:xCFBaZzAnhu2HngIKSg2sqrGMO-Ya76qqnnbgenSZbXPO8-ZrZOBgA>
    <xmx:xCFBaUj9J7IckfIEjQ6qthxedkvXukG9dDpif4Nc2GlvvjQZ9aOX50KY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 04:09:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 35b0adf4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 09:09:22 +0000 (UTC)
Date: Tue, 16 Dec 2025 10:09:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/10] packfile: refactor kept-pack cache to work with
 packfile stores
Message-ID: <aUEhusU3iu6TjF16@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
 <20251215-b4-pks-pack-store-via-source-v1-3-433aac465295@pks.im>
 <6sverdiyw6y4k5yiocp2v7yhogfvfpmajyiujbmfhzd3n3gb72@wni25ru2m236>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6sverdiyw6y4k5yiocp2v7yhogfvfpmajyiujbmfhzd3n3gb72@wni25ru2m236>

On Mon, Dec 15, 2025 at 03:56:25PM -0600, Justin Tobler wrote:
> On 25/12/15 08:36AM, Patrick Steinhardt wrote:
> > diff --git a/packfile.h b/packfile.h
> > index 33cc1c1654..701a3b4946 100644
> > --- a/packfile.h
> > +++ b/packfile.h
> > @@ -210,6 +210,19 @@ struct packed_git *packfile_store_load_pack(struct packfile_store *store,
> >  int packfile_store_freshen_object(struct packfile_store *store,
> >  				  const struct object_id *oid);
> >  
> > +enum kept_pack_type {
> > +	KEPT_PACK_ON_DISK = (1 << 0),
> > +	KEPT_PACK_IN_CORE = (1 << 1),
> > +};
> 
> Looks like while we are here we are renaming some existing flags and
> storing them in an enum instead. Makes sense, but maybe we should also
> explicitly mention this in the commit message since much of the fallout
> in the diff relates to this change.

Fair, will add to the message.

> > +
> > +/*
> > + * Retrieve the cache of kept packs from the given packfile store. Accepts a
> > + * combination of `kept_pack_type` flags. The cache is computed on demand and
> > + * will be recomputed whenever the flags change.
> > + */
> > +struct packed_git **packfile_store_get_kept_pack_cache(struct packfile_store *store,
> > +						       unsigned flags);
> 
> Now the kept cache is accessed through the packfile store instead of the
> repository. Make sense.
> 
> Since we are also changing the name from `kept_pack_cache()`, there are
> some comments in "packfile.h" that are now outdated. We may want to
> update them here.

Ah, indeed, thanks for catching! I've made the changes locally, but will
hold off sending them until I've got more feedback.

Patrick
