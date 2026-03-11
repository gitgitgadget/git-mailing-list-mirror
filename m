Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0135F60A
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237325; cv=none; b=RLgIAIN23yyJg/OoMVXTBszgvKSnrdhJgPIo494/NdQ2bzHuYE7Uykpg7Napjj3Syiif9jyKI4eZHKn321mJjVzu3LQ1N2HMUkUlF7Tyf8rPoEBC+0zV7mMEyavjPLemkHamSFDGFty8z8NSvSW/kDVPKY5D8u+QND9M8cMbY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237325; c=relaxed/simple;
	bh=lzCT3j/vP4IyU/iBSeB5RUUmC8NFeQoHCcS0NT4G5HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO0Y+hk7FhokriVTixVVq7c+cithFmH4zdKBmCEPmXjLc6XFpb1fWIFMFBDAlILoHmZyfTZ6Pautw6Xb6eJEq6p5eT60/HUw6nW6+LmBTDf5lYPU0DUTIkyQMX3+ZHLiRekJ17BPL8XomEaJGJrE7FFp7t7Tjv3QJZxRo+FjHJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HNARLgoB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KfROsbrM; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HNARLgoB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KfROsbrM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1DAD11D00111;
	Wed, 11 Mar 2026 09:55:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 09:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773237320; x=1773323720; bh=iHcuHuW7XF
	MtDRVfeCSLw1mb06CZMihYn3MELFv1BpE=; b=HNARLgoBcEii/JO9mV5YJUgYl2
	BbxiDxCbjv9A/3Hx0YLOLSBIljzf5bNBBADaAPnJNd4OaY2hGjVQ5j0CeBVyCXHc
	HIAWxbimk+YaKqWNB8XImYUSH3wcjTa6GO6CIu6xBlNqaEdR4YZoMnvVQvfCydIV
	ClHOv200+SKQH5mS1pkpPcWhX0kKvZwM/Z5fcMgBXqCHWKtHhUUx2zac/PhJX2Sr
	6d9Vgcx7ZsiD7LVuxRw5z46tr+gll94GwcDpMGzcduHJJrvJ/j6dXqtpkWUEOPup
	eYj5GOnmyA0KChQjUwQG1dOdDN0FlbWuVpIsJgeFGCr6J4R4ocGOisF/tbtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773237320; x=1773323720; bh=iHcuHuW7XFMtDRVfeCSLw1mb06CZMihYn3M
	ELFv1BpE=; b=KfROsbrM/0amTFwgB2JeQEAOanamKYsajU3ZTCbKIDFJH1VkAME
	u2rtP7ib4XWH3bkBaEhd5fvV8mty69DBKQ/diNXJCmJeB4GObReD7XAsMLH929r6
	19YSN8diwarpyx/m6RUOrD7gKksCqmYcpf2iLK4R8Ha9GdFOmoOqS4t9WenYOJ+3
	2e+x863jIK/WRMk07gV/xDFS8LszJjaUodLszq4rXxaCiaiHbm/Al4sUbaQnorBU
	NDmKn9NPc+RBX/7xk8udZwwrt/qF3rLWiLfvKSPU9X6vNn24hDl5CBtBDpp0wp23
	ZX2EjWf9SE5Q4M31fJI6/8WgHS+nct2X5zg==
X-ME-Sender: <xms:SHSxaTwd_E6DuZ527esnmxKKXPT6uWDdFOuz1bKwWQ1086ftGrT1CA>
    <xme:SHSxaRT6f_eHX5JC7oXhdF12433eMT7U_XvcULqvv-SM5_PQ8iF88zV7xFJN9Aqda
    sHOCDLwptEe8USImQMA5tCQfoysC1bETXOsRvqvG_VgHyqED5xGFl8>
X-ME-Received: <xmr:SHSxaa9o5HLRUAU0lYq3tuj78oWY0W-nZ5vLncwi6yw5gmuAm9adIh8VTyhNb2tJxy9GjWaniUB8C7eMrv0mdo35WejjUL01CSFssaVMzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SHSxaYoVfIy7FTIlPTjXxMp9G4XGLQz6MAx9fXJjULwu6JhdN_g33g>
    <xmx:SHSxaXmlLb2uHGuOXUzwkoErCXSViKjB6OMGIYzT3niuV9H9SCxfYA>
    <xmx:SHSxafIVPqZ2w8Gv1MdSmYw0PIRy0TDtYM8upRzRFiRmZ8E3zgQzhQ>
    <xmx:SHSxacx204J0ULRWyjtKh3M1E7GwU4pPfZ70jdx6uGvvv7YkPSrFzA>
    <xmx:SHSxaXJ5NI5YjHjvf9DUnlvzOXPiKhybPmqlHc60lX9lmaKz5qpIBp1Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 09:55:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d46e5ef5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 13:55:18 +0000 (UTC)
Date: Wed, 11 Mar 2026 14:55:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] packfile: extract logic to count number of objects
Message-ID: <abF0ROcaUpYxdAQq@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
 <20260310-b4-pks-odb-source-count-objects-v1-2-109e07d425f4@pks.im>
 <871phqmtcu.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871phqmtcu.fsf@iotcl.com>

On Wed, Mar 11, 2026 at 01:41:05PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In a subsequent commit we're about to introduce a new
> > `odb_source_count_objects()` function so that we can make the logic
> > pluggable. Prepare for this change by extracting the logic that we have
> > to count packed objects into a standalone function.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  packfile.c | 45 +++++++++++++++++++++++++++++++++++----------
> >  packfile.h |  9 +++++++++
> >  2 files changed, 44 insertions(+), 10 deletions(-)
> >
> > diff --git a/packfile.c b/packfile.c
> > index 215a23e42b..1ee5dd3da3 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -1101,6 +1101,36 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
> >  	return store->packs.head;
> >  }
> >  
> > +int packfile_store_count_objects(struct packfile_store *store,
> > +				 unsigned long *out)
> > +{
> > +	struct packfile_list_entry *e;
> > +	struct multi_pack_index *m;
> > +	unsigned long count = 0;
> > +	int ret;
> > +
> > +	m = get_multi_pack_index(store->source);
> > +	if (m)
> > +		count += m->num_objects + m->num_objects_in_base;
> 
> To make sure I understand correctly:
> 
> `m->num_objects` indicates how many objects are in the current pack, and
> `m->num_objects_in_base` how many are in it's base (and that accumulates
> what's in the bases of the base?).

Yup, that's exactly right, `num_objects_in_base` is basically recursive
across the bitmap layers.

> > +	for (e = packfile_store_get_packs(store); e; e = e->next) {
> > +		if (e->pack->multi_pack_index)
> > +			continue;
> 
> Because we added the count through the midx already, we skip any
> packfile that's included in the midx.
> 
> But some packfiles are not in the midx so we fall through for those.
> 
> Makes sense.

Correct.

Patrick
