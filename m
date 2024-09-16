Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C8F2233B
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469778; cv=none; b=DQQCOfyYMLofLNSjnira8W/iUPCbkWtupwiYgG593OcBbAKE+iHYTyqgBNZFgSeUrT02jJuyM+vps+h7FptURxRxY9nyqngfE3cYh6NWBAOegyQI+O639uJF+6WMmzzfN7jh68Gw/4T/jZfqeDgiudWg2r6uVnIfwugp8TZLhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469778; c=relaxed/simple;
	bh=o9bKuir2M2MzIHJ4qbcQ40dbYU3w4i2SEcTzvokV244=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ14gv8ocAfRYrNT53kNHHibUYXTYF0OlNOs/idPZVsDlXXsmBof1IF3qTXAc7dhPM0YU625lJkoNrBQO1YU5Yo9KnPGbHhHC3yW+PZXOCZNh7l0GQFewXP5CbVjK0Dit/dOoyOw013ctM5YTvmwptEbUEkxkX9eUF62KcW1YOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=golQ5KYZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TV7lgIvc; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="golQ5KYZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TV7lgIvc"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5AF891140204;
	Mon, 16 Sep 2024 02:56:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 16 Sep 2024 02:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726469774; x=1726556174; bh=jZ8fwy1O32
	eku81w5uv+y+MdWfPgWKTkSqCFZ5XtnwU=; b=golQ5KYZV6hpXAvtaaCHLFQqG7
	E6q0eTJOTx+hUq5RQn+aKzGG/iFeHpfd9T+GsTw/7TsWTLrCQxcLzL9+9cMqyVfT
	j6MVOp6Bhx0qUbl7cL4adRgJCmpIPwPm7xgO9co2fYFeCRoff66RnZbT9Igxz+LZ
	Vu5pySWzJEetnPfUVYfaUENmwgrpV3pAX/VomhnLeFme7+UqPo9AhpM3rP74LDaD
	7Df82x03DpXb7EiRaFiteIDm7lI5GsXmhDJY8kq1G29JgA64/RL/YePFHl+UgD+G
	3XvMsyXLFUNCN0j/OCnBwc2TMs/X9/g9VGbfFAsNOzwGspFNmFZQKIFaNBfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726469774; x=1726556174; bh=jZ8fwy1O32eku81w5uv+y+MdWfPg
	WKTkSqCFZ5XtnwU=; b=TV7lgIvcYo/QYo9OycTAq4Hpe/Mw3uh0L/FD0b8duZey
	78XNwKdM0OLp61p1iiLP7Gjy7L8qZ0ytR925xb7C7gCLENiacUOI8nJaktwFEnMd
	0la1JCjJD65cKKx5biVFJzQM3I31ShXh7+PhSyK7DQ/DrBQAvPYGGoKRv6xOITxv
	ZKrMVwkyF6jDXDVTArThgsmNCdr2DZLN45++WBvBwfXausWDNt2UH+YF9bpVf643
	14fE7LV7AScLNwgYpzNrViT5vL4flY54FVQol006a1Nly1qjcrghBNdpse/u4g4o
	lSq9oECIDV+HQTVY/ljH39bBR+wReQ9kY809dBpMOg==
X-ME-Sender: <xms:jtbnZuAcPK-ZP8e3QGfp8vGa-8vqtfNCElYdmGLiYqpSB6lSRn9XSQ>
    <xme:jtbnZoin_8RIrZBhNL0AWEjp7t6nhyx9Ddp9PmUki4fcof_lS2-kD_Wh_e6uhWU5_
    r9nLLEV1slCG2AJgw>
X-ME-Received: <xmr:jtbnZhndHupcgKMU-KlY-IayHAd288i8fuqvPoiP7ba8KGM94C8Jei1EZ682nk3VOLz6OXCR3Eb8WDfTU3eI1d_P19YGeXo8LVz99s7plr_wuagb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jtbnZswFuC8MK39eK84OpVgrt_oCRyK3lIsEh2St5hGKW1DGpF9Iiw>
    <xmx:jtbnZjSE4yJUp1YZPPdn8pVFT-7sbQwnAaChEynp4hp0gTN6J9iH0A>
    <xmx:jtbnZnaefLxYMMBrLx74zs9jQTfEdgPP2wfwQs1vqYH-_lAEQLk6KQ>
    <xmx:jtbnZsQN0xL9Dn8leg40oFu3UosXQl1YkNOWgTtiCngyAdGJzAZR4A>
    <xmx:jtbnZtccMsnmxv-Rzg6j_DpIGQCh3jmQ71anu7Cqv8PQyaGQ9eew6ZcF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 02:56:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d4b4d20d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 06:55:54 +0000 (UTC)
Date: Mon, 16 Sep 2024 08:56:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/6] refs: properly apply exclude patterns to namespaced
 refs
Message-ID: <ZufWilh3WupDnVWf@pks.im>
References: <cover.1725881266.git.ps@pks.im>
 <8d347bc5599e2a679d50fed073e0f09ffdad85c4.1725881266.git.ps@pks.im>
 <CAOLa=ZTM9N0i+8jDp24pp1DdU1mmwU02L4vOP6GOpGW-=SJUoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTM9N0i+8jDp24pp1DdU1mmwU02L4vOP6GOpGW-=SJUoQ@mail.gmail.com>

On Fri, Sep 13, 2024 at 04:35:35AM -0700, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > Handling such exclude patterns in `refs_for_each_namespaced_ref()` and
> > `refs_for_each_fullref_in_prefixes()` is broken though, as both support
> > that the user passes both namespaces and exclude patterns. In the case
> > where both are set we will exclude references with unstripped names,
> > even though we really wanted to exclude references based on their
> > stripped names.
> >
> > This only surfaces when:
> >
> >   - A repository uses reference namespaces.
> >
> >   - "transfer.hideRefs" is active.
> >
> >   - The namespaced references are packed into the "packed-refs" file.
> >
> 
> So this is because we don't even apply exclude patterns to the loose
> refs right?
> 
> To understand correctly, the transport layer passes on
> 'transfer.hideRefs' as `exclude_refs` to the generic refs layer. This is
> mostly to optimize the reference backend to skip such refs. This is used
> by the packed-refs currently but not used for loose refs.
> 
> The transfer layer also uses this list in `mark_our_ref()` to skip refs
> as needed.
> 
> So all in all `exclude_refs` here is mostly for optimization.

Yup.

> > diff --git a/refs.c b/refs.c
> > index ceb72d4bd74..b3a367ea12c 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1517,6 +1517,19 @@ const char **hidden_refs_to_excludes(const struct strvec *hide_refs)
> >  	return hide_refs->v;
> >  }
> >
> > +const char **get_namespaced_exclude_patterns(const char **exclude_patterns,
> > +					     const char *namespace,
> > +					     struct strvec *out)
> > +{
> > +	if (!namespace || !*namespace || !exclude_patterns || !*exclude_patterns)
> 
> What scenario would `!*namespace` be possible?

It's the default value of `get_git_namespace()`.

> > diff --git a/refs.h b/refs.h
> > index f8b919a1388..3f774e96d18 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -859,6 +859,15 @@ int ref_is_hidden(const char *, const char *, const struct strvec *);
> >   */
> >  const char **hidden_refs_to_excludes(const struct strvec *hide_refs);
> >
> > +/*
> > + * Prefix all exclude patterns with the namespace, if any. This is required
> > + * because exclude patterns apply to the stripped reference name, not the full
> > + * reference name with the namespace.
> > + */
> > +const char **get_namespaced_exclude_patterns(const char **exclude_patterns,
> > +					     const char *namespace,
> > +					     struct strvec *out);
> > +
> 
> Do we need to expose this? Can't it be made static?

It will be used by the next patch. I'll amen the commit message to point
this out.

Patrick
