Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A33FB9C
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 05:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732686309; cv=none; b=ZtKMu/2sqAqPhv2ZAHK3/aadDR8rNco9/P7NC8XYzGcilHJMup8xsdif+55aY3MZztIbrZWvEgSJWmmG7KFH4q8q5tPHu0xFW2RLYa+bYiKb9fw9+yQONqjhyaXNP8o3S/d2HG74qE3VVo/o3Y0LSzQ2R/ioRLlOpmQ1OQbW8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732686309; c=relaxed/simple;
	bh=nTenV+u1JCEts5ixZ618uc/xkW8e5BBIawFlnCWMZzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEwSQ97vvFZheVlMza385IKSsG1vEVC5K+l3k880BdheTTYr6M2jY2wn3O8ldeNkAZO8jL3MvH+5u9uL1Xu0l6lS4WxQC6Obb9Ze0xeUwQga/IIRChKDTi3//hGi98rFLkWT3PwhUHtVTkdoQexpD/6DtRbiagibgjfPMQSkQ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pGlQHmYH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x4BIFy4g; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pGlQHmYH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x4BIFy4g"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4458E11401D0;
	Wed, 27 Nov 2024 00:45:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 27 Nov 2024 00:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732686305; x=1732772705; bh=7T0HuJs1X7
	GWikaruRrJtkxbQ8NllgpOB9uK4B34mmY=; b=pGlQHmYHF2nGI2STgRaLGu4qOY
	JxYYf0XjRhDoqik1LMBPR3yLYxTmqI3hu8wlqg7k59QF8Xj3bswsFMNuErDYCj2f
	eUBxQNXVeKffGvj/DG24rGqk8VYOXh75TWEutt4/nEjsbwz6bAv8N5bfjGAq4IPc
	w8e7PTFlGn9oq6V2n7IJaVjMfVplFh+25Q05YHZpD3M2iHyGyq7iJkGcZYowBd1t
	nnFEvwVOn9zfjvCWrUO+cPduMPwhZK+ZcRRW+XUp3K8ep8tCVm9urOOOGKKINXfq
	udS8GiBi4gtR/elmMqFCIlbYjgD9URmDNJcvsmp5+Nrac2iu1xDMOO1fBpRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732686305; x=1732772705; bh=7T0HuJs1X7GWikaruRrJtkxbQ8NllgpOB9u
	K4B34mmY=; b=x4BIFy4gRtPCLR7gxrIRytFUhzO3EyQBwYGi6p+1imlDxtvrpJN
	VBSJXgJTPXClKkhXXiRUmIOxL5gSIIDzcLIhEVNQz4eHpaa7tcGDJz8qIHr9k2GO
	tbNLjOI1HCn6C+I09pxkJdxkNo3j9tpQ9KELaUcBVK57mKYOs0M3Ivq5ZFqM9AxS
	CUuF7Y4AWzDI7zPDEGdEAJ+3ONtg6sun+gemEJON3gPodUukvNNRoZLW/dO57G9A
	bpCwaE6o+pcOTZts6xeUXI3wXGmfAMLhiQe+vqT1pTzENrQqKoyCh0dMA2iPzFqm
	jqZro85rFhasz5N+R8n7d8/s4lXLoYG/+LA==
X-ME-Sender: <xms:4LFGZ0rJb_XNPW5LB1E6ADyX2GW287IOnE0WjyKePUJlN-942cX-Mg>
    <xme:4LFGZ6pMn_MRvsM-cT2ixXTqzwTcJS3va4P3PmmDi1-0ERkvnwpi4N-yd_CUjGs2o
    3tUM1VTTs3Xa_s8qQ>
X-ME-Received: <xmr:4LFGZ5O4zOmyorpXDAtBJuJz0O39PjncW9n7ThJKkPZqyPkDcUuTya3OyRXQwKi91U98k1L6clK1sFWini6QhLUVekYk4WwOE9ywxRxILEwoh8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeekgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4LFGZ74UZmCv_rR9Jly6ukXL-vvCYc0jtP63QTDYzQBnovoVX7bYCQ>
    <xmx:4LFGZz5NheHxrIWGlAPwFRzyNcL3oV5HHl-0NdCBc7qGmueMU3RiUA>
    <xmx:4LFGZ7gzNkMtc9GY-_MUocNV51I8WOWe4TnUv7BuCo42CkdBzL-6DA>
    <xmx:4LFGZ97myAC-fYZ2MFPn3uFacUxtdg0QWnMlv7AVSz7RqKAmucod7w>
    <xmx:4bFGZzGE6UVz242QnDZJEgMEkzD-lTN8e_lsOhW4jCVPAGwLHSQ8inZ0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 00:45:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e1ce56cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Nov 2024 05:43:59 +0000 (UTC)
Date: Wed, 27 Nov 2024 06:44:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] fetch-pack: split out fsck config parsing
Message-ID: <Z0ax0_SDtinH6zCY@pks.im>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241127005707.319881-1-jltobler@gmail.com>
 <20241127005707.319881-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127005707.319881-4-jltobler@gmail.com>

On Tue, Nov 26, 2024 at 06:57:06PM -0600, Justin Tobler wrote:
> diff --git a/fetch-pack.c b/fetch-pack.c
> index fe1fb3c1b7..e7d4f6e6e2 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1877,14 +1877,24 @@ static int fetch_pack_config_cb(const char *var, const char *value,
>  		if (!value)
>  			return config_error_nonbool(var);
>  		if (is_valid_msg_type(msg_id, value))
> -			strbuf_addf(&fsck_msg_types, "%c%s=%s",
> -				fsck_msg_types.len ? ',' : '=', msg_id, value);
> +			strbuf_addf(msg_types, "%c%s=%s",
> +				msg_types->len ? ',' : '=', msg_id, value);
>  		else
>  			warning("Skipping unknown msg id '%s'", msg_id);
>  		return 0;
>  	}
>  
> -	return git_default_config(var, value, ctx, cb);
> +	return -1;
> +}
> +
> +static int fetch_pack_config_cb(const char *var, const char *value,
> +				const struct config_context *ctx, void *cb)
> +{
> +	int ret = fetch_pack_fsck_config(var, value, &fsck_msg_types);
> +	if (ret < 0)
> +		return git_default_config(var, value, ctx, cb);
> +
> +	return ret;
>  }
>  
>  static void fetch_pack_config(void)

Okay, this now reads a lot nicer. But I'm sceptical whether we should
return -1 for the case where the value wasn't handled because we now
cannot discern the case where the function returns an error from the
case where it simply didn't handle the value.

In fact, we cannot even use positive values right now as far as I can
see:

  - We return 0 on success.

  - We return 1 in case `git_config_pathname()` indicates an error.

  - We return -1 when there is no value with "fetch.fsck.".

I'd propose to have a look at whether the positive return value from the
second case is actually used anywhere. If not, we can refactor this case
so that we always return negative on errors. And then we could further
adapt the function to return positive in case it didn't handle the
value.

> diff --git a/fetch-pack.h b/fetch-pack.h
> index b5c579cdae..c667b6fbf3 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -106,4 +106,7 @@ int report_unmatched_refs(struct ref **sought, int nr_sought);
>   */
>  int fetch_pack_fsck_objects(void);
>  
> +int fetch_pack_fsck_config(const char *var, const char *value,
> +			   struct strbuf *msg_types);

We should also add some docs here, at the least to document the error
codes.

Patrick
