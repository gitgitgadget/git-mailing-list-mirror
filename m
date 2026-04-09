Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314592E6116
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 05:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775712170; cv=none; b=VqHQQbrd3TOAPlXiQ+vYEO4bhFJC0fV6QM3btcNh3AfXFZVnyrZiMiTIITy4dyAJFc46RGAMQ27YFAH3F0dh+LosLFMWLc1ORYIlmPZc543zPFdt0yN/ldV5gY6Ozq2bTdolR3PUKqNsCF1Vs4rsfZmrjUPFVGda2IBK/BCJsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775712170; c=relaxed/simple;
	bh=1ATi8zR1wFVTi4ARLimgSqr1DEcuhhz1wffr2ceBBBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIUa3DUElL6UhgHDc5S4W+K7hjGeCfmmL/ZB5El8iGazQda/+WqAjUpZvgNk65kUvHKMqmQnB+lyDF3jY4OzIT6lXM0jiuECnSixCQRCY0PU8n63PAO1rz5VKIso6uGYbHsxYyLFFaBiT7BNNvJ7d1Cu95CjA/AGccwHYYOrcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Va7fSDqK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IHAOddmv; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Va7fSDqK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IHAOddmv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6A0911D001C0;
	Thu,  9 Apr 2026 01:22:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 09 Apr 2026 01:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775712168; x=1775798568; bh=KOQ0PCwANj
	Ne6xQXBWSejjJ+6wnmqvlZqoTn4x1rf2o=; b=Va7fSDqKOu9BmGzT8uMLocoxJX
	ed25RM+mKo0N2nQurBAuyagtj6pdNrq+l3CAJuKfg1qJ1X43sTE+vBKV/weiH/BV
	8oGX09IUYPkxxadREgxuur1XbGnED7qIzlwppSEK6jZWs4meaWitaxpFq7fg2oTq
	LMKP8h5+8T7F0WuOXjryHftEyyGW7DK+Qj3J0m5iEFmM6LLpLMe7xlQ48YjYdIlm
	47pPxJXA2UXe9QWwDwVma0Hzvsmeq+j5fjEhGzwroAWVlELo/Kop0iMUU1+qawhM
	3opN8XI8qyEQYig06MLznzAwVFnvecFh2NoVHCmBa75iZeILy0IRNelQ1U6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775712168; x=1775798568; bh=KOQ0PCwANjNe6xQXBWSejjJ+6wnmqvlZqoT
	n4x1rf2o=; b=IHAOddmvcFJDDleepbC3opg0wPixYcf3b3Ol1k8SuL5DeGbfzHt
	mwqyd8F/nqo8XeFJZSyn16sUISSFPT5ASVJhtcjgHCvmsFPNy8C6wuvaECys5BxW
	wCbKlKz7qghHTdrdBxUPIxztgSp1DUdHv4SR1EkykuUuG+OdyZwlSSyA6QHcUV0C
	0hClAjbKecSYZyWxk3uIBeR3q0m+rYoX8ZfvIiqmqajZ3EPqTb8UPePtFXy1MBxh
	Z5zjraPlWy14dLR7IM3mAAGrtFlCizQCHM3sxdbwbsUQcK430I0V3skGattxt2Lg
	dmmwQFqmru7IwH9w1udjvLZwaLJIEUJ05ZQ==
X-ME-Sender: <xms:qDfXac_O7S11nVVyvLHnWiuvxYFbHRCk2-o2ccgRPc8OHOklm769_Q>
    <xme:qDfXaaundjfP6ubjGPmT5pIzEdVmyjwBmvonj2L-9OpDlQz8AF3Ycv8Wvonx4VWBW
    eqdUMAleQEYza8ERMJmmQ6tDXUlyPBOWBQN76zLE-VGNzhgc50LUQ>
X-ME-Received: <xmr:qDfXafr7FUjBBcCrupwcSZ89Fs4ZgiXW23Pka4LxRNVZbptoyVTeU-MXfm7xKVPP9U9UoIta756CsuYCHKZ_VB1b6zYwd3OYUw8vp8H74Eo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:qDfXaXkuEbCy8eE4u9bLrREEny26kZsWdlLjiLI8DNGL_wMG0s4DsQ>
    <xmx:qDfXaTz9YxaeqTeNvwCcE4hRBlCac4Nh-62JFRDXFzdNaQ9Yt8wtfg>
    <xmx:qDfXafml_nZXOh0RGR7ukgGUfhiJAlpiarbSFQQiu5fqaZGJrNyneQ>
    <xmx:qDfXaccTqz7DW422h74cfk-iBZcyuzGgKRK0SnSLnz33f6cZM94BJw>
    <xmx:qDfXabve8PT6p0M9GjLAGdrwWirC1hdhCNWyJf2Dvt6bcsQIYdZ0Fu-L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 01:22:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ad36c46 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 05:22:46 +0000 (UTC)
Date: Thu, 9 Apr 2026 07:22:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/16] odb: introduce "inmemory" source
Message-ID: <adc3pDxks6rCrZo6@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
 <20260403-b4-pks-odb-source-inmemory-v1-1-8b8d1abaa25e@pks.im>
 <ada_W-IWfNKUKnVK@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada_W-IWfNKUKnVK@denethor>

On Wed, Apr 08, 2026 at 04:00:48PM -0500, Justin Tobler wrote:
> On 26/04/03 08:01AM, Patrick Steinhardt wrote:
> > Next to our typical object database sources, each object database also
> > has an implicit source of "cached" objects. These cached objects only
> > exist in memory and some use cases:
> > 
> >   - They contain evergreen objects that we expect to always exist, like
> >     for example the empty tree.
> > 
> >   - They can be used to store temporary objects that we don't want to
> >     persist to disk.
> > 
> > Overall, their use is somewhat restricted though. For example, we don't
> > provide the ability to use it as a temporary object database source that
> > allows the user to write objects, but discard them after Git exists. So
> > while these cached objects behave almost like a source, they aren't used
> > as one.
> 
> I find the wording of the second bullet point and paragraph above a
> little confusing. Are there existing uses where new objects are written
> to only the cache?

Yes, there's a single user with git-blame(1). I'll mention that user
explcitly.

> > @@ -1123,9 +1126,11 @@ void odb_free(struct object_database *o)
> >  	odb_close(o);
> >  	odb_free_sources(o);
> >  
> > -	for (size_t i = 0; i < o->cached_object_nr; i++)
> > -		free((char *) o->cached_objects[i].value.buf);
> > -	free(o->cached_objects);
> > +	for (size_t i = 0; i < o->inmemory_objects->objects_nr; i++)
> > +		free((char *) o->inmemory_objects->objects[i].value.buf);
> > +	free(o->inmemory_objects->objects);
> > +	free(o->inmemory_objects->base.path);
> > +	free(o->inmemory_objects);
> 
> Should we have some sort of `odb_source_inmemory_release()`?

Yup, this is coming in subsequent commits.

> > diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> > new file mode 100644
> > index 0000000000..c7ac5c24f0
> > --- /dev/null
> > +++ b/odb/source-inmemory.c
> > @@ -0,0 +1,12 @@
> > +#include "git-compat-util.h"
> > +#include "odb/source-inmemory.h"
> > +
> > +struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
> > +{
> > +	struct odb_source_inmemory *source;
> > +
> > +	CALLOC_ARRAY(source, 1);
> > +	odb_source_init(&source->base, odb, ODB_SOURCE_INMEMORY, "source", false);
> 
> huh, so we set the path for the `struct odb_source` to "source". In the
> context of an inmemory source, a path doesn't make much sense. I suspect
> though that storing a path is likely only useful the context of the
> files ODB source. Is there reason for us to still keep this around in
> the generic ODB source?

There are two reasons for the "path" field to exist:

  - It is used to compare sources with one another to figure out whether
    two sources are actually the same. This is used when reloading
    sources. This usage makes sense in principle, but it's wrong that we
    consider this to be a "path" -- it should rather be considered an
    opaque "payload".

  - The path field is used in a bunch of sites to actually figure out
    paths. This is plain wrong, as we cannot guarantee that the field
    even is a path for backends that don't store data on the filesystem.

It's one of the topics that we've got on our plate, to disentangle this.
The goal is ultimately to move the path into the files backend, fix up
callers to do the right thing (TM) and then convert the current path
field that we have into a payload.

Patrick
