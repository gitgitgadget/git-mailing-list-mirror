Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40712299944
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856538; cv=none; b=lVTGhu+2PffJG1BQbn/rYOTwS8ryzENvmhWEtMAKa3zprytlb2B5W5mEPImNRjVOLQhdfoP/pAPIO6pL6/Mm3J50io24oTEI05HKJXXxzYsxNbIhuubkI9SQWkrNTZndKWxA08rye3vl9VBrRzZkARhugYo1KVGpHJ4tP+4SE04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856538; c=relaxed/simple;
	bh=+AyehnPwCpVlWh3/DAeWxuK2ixqTmWeJfzjKoz+IB5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt7QZu05pEBL+ENqqnlkSQJo0qfFo4R1VO5io0QHcs4PKieKax9rF2nVB5CSR9H40fybMNwQvDVJwNAd0OfBi1Dn9tdJdoB+lgpJ5WrNMYPeoOsQKy5Jorg0U4uFoTh4oiOyLFFkR0XpfD/JXbkCqvDrb5E+taRoBaYEWTRs+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZNKEKCZg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R6nQUa6V; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZNKEKCZg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R6nQUa6V"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C97497A0130;
	Wed, 22 Apr 2026 07:15:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 22 Apr 2026 07:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776856534; x=1776942934; bh=HwCi0qiLkt
	deSwabziDK5Vw7czelt3i+QH9U4bm1h+A=; b=ZNKEKCZgiqgp3YBBJ+OxgT658R
	6DYetiA7us8gChhAQ3qB6y/LNHJ3OHKL1LTUedsLvrucd+sXXYNVARfDBHNVj2+s
	SQdrhtgKTPkN7ezs1MRy2qj4LBTgnTglKaBoKbIYrgYM4Dje02IY+c98vnKXdb9w
	edYvrrBYN3q0OwttzSecbpw8cLvTpq45+fv3RCQ9nuWQjBlAlupouXgmKJC0eNc2
	tEQCjKrRDdDRaDdqUrBAYY6bdrSePBAM/T3WCG90AwAJKzPGzbjtcdZyt4dA329P
	3M+VmSwunLSWsbh0qgJVXoo4vpC9Xlgx1AHT4Q0WmZJqWnFLNMSbit/+uJsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776856534; x=1776942934; bh=HwCi0qiLktdeSwabziDK5Vw7czelt3i+QH9
	U4bm1h+A=; b=R6nQUa6VqjFbAbTYd4+0CC3qvlvgM80bjL/EaI8CsJPmJzuOGc0
	wKLcuRPXI5pTTooVOBdWpOd8ThIcZ8RwGuS0Y+N+6B/43/BJAd4kMCUbQ0L/Y0ji
	DzPGy8CtNLwp/5O5ls5TppQ0w2ZzUjoH4bOp6+y46AuZM1rYdPXGlsL5wuMiYLUz
	fHCM6f6oj7K781wzYAwN3gnaaJygZDxgL58WYxxehyr+9+Qt86h0x6Z/Z1/WGkl8
	oNmy1+BORJgiyoyC+1CLOcRFee0N9yDo/DV3jPwf/rE8hUsjihKy6FhbzP0iahOq
	lPAWi+XVfFpOvgIHsQyLZWtqtP7mbBsIkaA==
X-ME-Sender: <xms:1q3oaX5nxhn8YPkP9UJfn1Efj0OWmxomqf-DUPaVFAy-6sffo_4Nag>
    <xme:1q3oaS7kML-p4REQgkGZEv5H_vwHot6KbDFvkqslr4GIZHrD4CzWvjNTvrg5drkld
    S0SK0z3mko4xet97cWyh25CZffzezaip7k5yY0emf7Vkmev4gyugA>
X-ME-Received: <xmr:1q3oacFxg8drh_DUo_Ww5tlNYonxNf9bx_0eIJlQX8p8-AMFOHYRyrFkGoRkpJ7Wwa8YsLcdoYqHbLUlgeH2kY11rV7cA8N4y71v-D_a5sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1q3oaTQe8W7-r_yEi9IkJjtRQ9PVfk4rzZOy8ZaqybAj0iyHaNhdOg>
    <xmx:1q3oadsRg7dkrw_6_HwdkBZzqoeCRKatThQV9kB68fLEBHYXsjoeRg>
    <xmx:1q3oaaxHVeKbYYAkfGOppBtxq7gGVv966_OIdTQKLoUDQCYK0rEvtg>
    <xmx:1q3oaf6-2BJQklcwZW_V550hkC-CkYb8HtnSB-aRuRgbvqeYNOHvow>
    <xmx:1q3oaVoqx28IjgTPpRohtmcMNHgUln23wdiI6-P2vVXkx5VhxoiRWPOO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 07:15:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49426590 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 11:15:33 +0000 (UTC)
Date: Wed, 22 Apr 2026 13:15:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] refs: extract out reflog config to generic layer
Message-ID: <aeit0pw44IxBfc2J@pks.im>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
 <20260420-refs-move-to-generic-layer-v1-2-513e354f376b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-2-513e354f376b@gmail.com>

On Mon, Apr 20, 2026 at 12:12:00PM +0200, Karthik Nayak wrote:
> The reference backends need to know when to create reflog entries, this

s/this/which/

> is dictated by the 'core.logallrefupdates' config. Instead of relying on

s/dictated/controlled/

> the backends to call `repo_settings_get_log_all_ref_updates()` to obtain
> this config value, let's do this in the generic layer and pass down the
> value to the backends.
> 
> Instead of passing this in as a new argument, let's create a new
> `ref_init_options` structure which will house information required to
> initialize a reference backend. Move the access flags here as well.

I agree with this direction. It's also something that I'm doing for many
callbacks in the ODB layer, and I'm moving more and more into that
direction.

> diff --git a/refs.c b/refs.c
> index bfcb9c7ac3..aa66c6b28e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2295,6 +2295,10 @@ static struct ref_store *ref_store_init(struct repository *repo,
>  {
>  	const struct ref_storage_be *be;
>  	struct ref_store *refs;
> +	struct ref_store_init_options options = {
> +		.access_flags = flags,
> +		.log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo),
> +	};
>  
>  	be = find_ref_storage_backend(format);
>  	if (!be)

Tiniest nit, please feel free to ignore: we often call the structure
itself `_options`, but the variables just `opts`. May just be my own
preference though.

> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 2d963cc4f4..eed13af4eb 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -385,6 +385,21 @@ struct ref_store;
>  				 REF_STORE_ODB | \
>  				 REF_STORE_MAIN)
>  
> +/*
> + * Options for initializing the ref backend. All backend-agnostic information
> + * which backends required will be held here.
> + */
> +struct ref_store_init_options {
> +	/* The kind of operations that the ref_store is allowed to perform. */
> +	unsigned int access_flags;
> +
> +	/*
> +	 * Denotes under what conditions reflogs should be created when updating
> +	 * references.
> +	 */
> +	enum log_refs_config log_all_ref_updates;
> +};

Nit: it might've made sense to split this up into two steps: the
introduction of the struct, and then moving the config in there.

Patrick
