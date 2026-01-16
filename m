Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4382517AA
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547024; cv=none; b=qsIRk0ae7vHf37XJLBVshLHrZn8B7zO+FgEE+HIR6g9wlBZX3zt7SrfH1xBAxW0y68nfCs8fFMQ+U1Sj+fiu/sfo8Dnto2IMiPl6Xgw6zZlVQZbuk4Ir4VUIlKcl56nMM7rNxWB5qDOHCXIw38NgP3ybmsXO1mcB3HEbkL4U7V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547024; c=relaxed/simple;
	bh=2BdlhlylNrQFH/y3OH/dY3A8KXlTHFLqxjxuJvnLfh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfDRfXk0hts0otKG1DEV1FWEVUPx+ypfL2z/B29eIfSlSEJX4j5CQEjJm0aM6euE4yCD2ShrlUVtSTdRhyblVIswst1aj8xE7ebTR+8IjhZRlppDrcw4qXCPerNVNDiUNxmCIjhQxcGXOhl5uo6hUlpAs3S0P/7IbyP+XDxdXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=goDynh57; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ksqfUBMu; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="goDynh57";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ksqfUBMu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C002C7A00E9;
	Fri, 16 Jan 2026 02:03:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 16 Jan 2026 02:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768547022; x=1768633422; bh=jyEQ/UhGMk
	SefGUtjzsHPmZXJXMb8NJScRNGZL+FBXY=; b=goDynh57GAm5RHUaw9Ob10GRbp
	09OtD6jMETpqs0GOIG4hTXUh+URUBAlLsW2xKIZ5Nb5T9J5JpJQZVohq8Quto2CY
	w7KfyvtaWc/k8eLxKfGD6FFwqYNIuFPcXVg3CjX8poBsr0+gAbGefUyUxH5TbNtD
	VrQYDZsdNn3EGXIkaOFCCD9SLcwF3TgUmX0H2J8RjV0prxHKCUXxBcRDXF6G4xOz
	/GznNyS57kYkM9PpAZpL+bZb5V5UqStnJLmm8vcvbSnwYBF4bnvSZsi9bVCTzlzN
	0GwchpWYU+agYin9IV5qcuM3PYYvpdhNoZPdlxpOe4SlesAmbAg42+z0GDKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768547022; x=1768633422; bh=jyEQ/UhGMkSefGUtjzsHPmZXJXMb8NJScRN
	GZL+FBXY=; b=ksqfUBMueDdyfbshF5i0S5eG8XZz1TaxQ6cdUakEjq7bAw+bbZK
	hSE1EmGJRtBlKJ+JOw+429e7UGbALKkFoRqX7XDoKW/pIYQgTW7TgUrowSFiufPe
	6lHw2p5N6DLVNVh5qMvZZO5qckAppGnWJALyfe4Dgt5WRmHzJ7PvNQ9035GdhVzx
	SYeK3eC6tbSBoUJSG8MzpXAH0lQHRW6hz6aV1uZn5qMDpR03a8AIjBaJqdorcbnC
	WLroONjg5eOqfDs/7cA8tkKBbHfYNU5ao27I0FASAxJys9n/lWiYXZu5j4MjbAUm
	1EjDABfZO6J2o8E/XSEXtKpSqSpPrG5JuYw==
X-ME-Sender: <xms:zuJpaX_K3sEIb7QsDn-aJPLqcDFqjEkIAgGM94IO4SHGxvtmws6Iaw>
    <xme:zuJpaZvxcV2zf6mZtWmPCBdJILs2_kp5ZzCHceQIxuHXY2HqE1lsQuYe2BxpcExjK
    mDh_ZzUprEsbJEX6pNZarxJe2Nv9qhUb1ZdMOUJM03yvcvJmGyhCsY>
X-ME-Received: <xmr:zuJpaSoXwoGiMEqYx_cxhIS_m0iKmTVd6lFQ6gGJutYV-4isHtiMr2Txvdu7dJ5sFYSQiHWHWymlHvqfZLxyyGfwr-buW5G0jRQvFTMs6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zuJpaenhBY_8an4lsTYeyfyFc3yyil6IKba-fZ6PrRRxmFd6uJSV-A>
    <xmx:zuJpaewDC2nPoRQFErz2Di0ejhyHemlq0YHlXqd1llGyk3WWXrV_Yw>
    <xmx:zuJpaemeXoJ_r8ZUx9oaPpPPEPU1l-0q8m2H-poUb_yPLj_SyP3O4Q>
    <xmx:zuJpafexb-2a7O5RzS5-q6JqNU5Wg-_MIEz5hYKFnkQ47zQN_yFxDA>
    <xmx:zuJpaWsV9lMvj65F6qp0kZ7aoD1rIMSuFV96eJxN5OHqT9-jbAxlgwxq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 02:03:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4ff0b1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Jan 2026 07:03:41 +0000 (UTC)
Date: Fri, 16 Jan 2026 08:03:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/14] odb: introduce `odb_for_each_object()`
Message-ID: <aWniyrg-a7FTnkvE@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-7-5418a91d5d99@pks.im>
 <aWlXu9ogFnv0GGBo@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWlXu9ogFnv0GGBo@denethor>

On Thu, Jan 15, 2026 at 03:17:07PM -0600, Justin Tobler wrote:
> On 26/01/15 12:04PM, Patrick Steinhardt wrote:
> > diff --git a/odb.c b/odb.c
> > index ac70b6a099..65f0447aa5 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -995,6 +995,33 @@ int odb_freshen_object(struct object_database *odb,
> >  	return 0;
> >  }
> >  
> > +int odb_for_each_object(struct object_database *odb,
> > +			struct object_info *oi,
> > +			odb_for_each_object_cb cb,
> > +			void *cb_data,
> > +			unsigned flags)
> > +{
> > +	int ret;
> > +
> > +	odb_prepare_alternates(odb);
> > +	for (struct odb_source *source = odb->sources; source; source = source->next) {
> > +		if (flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local)
> > +			continue;
> > +
> > +		if (!(flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
> > +			ret = odb_source_loose_for_each_object(source, oi, cb, cb_data, flags);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +		ret = packfile_store_for_each_object(source->packfiles, oi, cb, cb_data, flags);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Ok, I think I understand a bit more clearly now. As implemented here,
> odb_for_each_object() iterates across each the objects (loose and
> packed) in each source. Object iteration is not handled transparently
> for each source yet though and we still explicitly iterate both loose
> and packed objects. If I understand correctly, this current
> implementation will become specific to the "files" backend/source in the
> future.

Yup, that's correct :)

Patrick
