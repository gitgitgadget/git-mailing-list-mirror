Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A082F22
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907185; cv=none; b=g2iXn3zEOOVo71YJtNgq4cKsHSzZojS0NRHAJvjHqAaWdaXViQX9KbZbUV6PlPGUCAoWNYYl5NP0KODt7hq8/hCSfvSXSCIg+HUOzpjhEcmhmKcTfjC4+E4QRkFMQXQzAyliwlH2xHlMo4IssVbvPacnwWITX2SCJChxay1nhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907185; c=relaxed/simple;
	bh=DluAVCyjJ47UfmueERdB4JWAUpJ9M8Jj7V8YEMJiRRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQQhtrgJ6oMILYzvsoQ0suuV4yIq27cYO0ORo6B0MgD4lkXk9QWH22YJvkaSwQhoOt/SCOoSgvyaD3VWhSK1sNwynxA/fEIKMIMFtluv63A5rm08oZ2N32X1QC7Q//W0p5fYQXPYXomBo/Ab31DucO4hjJlUuGW1otNywiGOErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nvyodlu/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvyodlu/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b3d1a77bbso66225ad.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727907183; x=1728511983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YN+S/8cGZW0tTZEKAB4fa+Ni1OqceFMyN4OAFW9oENs=;
        b=nvyodlu/6LugdFr7IpBqtVDCU/vSm2cPOG2wZn7Qr3RYPHxWrBo9B9S9731YCo+in8
         rJ6NMREzyIOg5NYAzy9AiB+kCrukR0e77O1QMvRIFwUTQRF3MX/6cGckIaDixsveG3nd
         ANTU4J5DfwqsAHM1d1BTqpOhbPI1/EPE5vS2X64Ms8V1SL4ZP1n1OyY1yc45Q6/vzW6T
         bVl3oEAScETvjv95iodYTC7Ujj81m4+Hllt5uDoiWhtDoz3xYOf+HxTYeaXjsWRcQeyN
         Vy0K4ECfZ7l14hLMIJFeDCCgkVJ/LuAJznVyuI7U8KBizPIkjJunP352qX093I7+fUzv
         mw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727907183; x=1728511983;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YN+S/8cGZW0tTZEKAB4fa+Ni1OqceFMyN4OAFW9oENs=;
        b=mQLaZx9piyKB3c1WtRLUyOIUC4tYoXDEkSRIf8KMKPStw8Y8UQTUqSQIFTnvj+LuHP
         jsSOFKP59+qFJkCmMQ/LjG1TUvNplBHyZH1MQDsGrfU+uw0437JBhyd86cjUZWX4t7+p
         V29jO8g4JUVB7arXPcBKb40iFawzpeiwCiYnvtUtl9nkZG0aD+KvscgoRxxDpglzzNTM
         7bBx4u5QyInZv8aiTlyB1SePmeTTJKcXgsX3OYYCPujQvPP6eHDC0OvZf9/IGJbDYdYv
         IYUlWL1k/hbVFbx+XiuXK8RKfOlP+vw/okbK3xEx0sFvXVw2SFxRiICtJ1WWBEz2dz8b
         Q6eg==
X-Gm-Message-State: AOJu0YynVZCvNMHmkwLsoFMIC8K+P2f7W8BXVuo0XcxFdme9u2RI0B3Y
	NkRIKydMCzEC+By1/fCKui+KcN1FCFz3Cbum+x+rzYByz5iMUPOb96MAdoz0EQ==
X-Google-Smtp-Source: AGHT+IHskvyqDR4S9YpEENLJ0Zz9ADeMxC6FBIpTXZMGLWS7V3exwQF/1tlop6HmTe9a6Ypx9yDOkQ==
X-Received: by 2002:a17:902:daca:b0:20b:4509:69b8 with SMTP id d9443c01a7336-20be4cbeba6mr1006905ad.4.1727907183067;
        Wed, 02 Oct 2024 15:13:03 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:2dd:9410:f675:e07f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652b4d6sm10699334b3a.177.2024.10.02.15.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:13:00 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:12:54 -0700
From: Josh Steadmon <steadmon@google.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, 
	mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com, 
	dsimic@manjaro.org
Subject: Re: [PATCH v2 4/5] config: add git_configset_alloc() and
 git_configset_clear_and_free()
Message-ID: <lx73jl2jxnkvr3ldx577374bhyagowet6zpcart46mxyd2ovlr@utwdnyzcsxv3>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	phillip.wood@dunelm.org.uk, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, 
	mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com, 
	dsimic@manjaro.org
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com>
 <908ad0b82fa084fc4e56d7f6dff49e4f255af6ec.1723242556.git.steadmon@google.com>
 <47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com>
 <bifcs4ijz4gsnrfjs3naqclo7nj7ajhek6eppgaj6a27ixp372@6oariraac4rz>
 <5720d5b9-a850-4024-a1fd-54acc6b15a74@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5720d5b9-a850-4024-a1fd-54acc6b15a74@gmail.com>

On 2024.08.13 10:48, phillip.wood123@gmail.com wrote:
> Hi Josh
> 
> On 12/08/2024 22:39, Josh Steadmon wrote:
> > On 2024.08.12 10:10, Phillip Wood wrote:
> > > Hi Josh
> > > 
> > > Do we really need to add this code to config.c rather than handling it in
> > > the wrapper layer in the next patch?
> > > 
> > > Looking ahead I wonder how useful it is to users of the library to separate
> > > out allocation from initialization. A function that allocates and
> > > initializes a configset would be more convenient and harder to misuse.
> > > Calling release functions *_free() rather than *_clear_and_free() would be
> > > more convenient as well. I also noticed that the data types are not
> > > namespaced when they are exported. So perhaps we could drop this patch and
> > > add the following to the next patch.
> > > 
> > > /*
> > >   * Namespace data types as well as functions and ensure consistent
> > >   * naming of data types and the functions that operate on them.
> > >   */
> > > struct libgit_configset {
> > > 	struct config_set set;
> > > };
> > > 
> > > struct libgit_configset *libgit_configset_new() {
> > > 	struct libgit_configset *set = xmalloc(sizeof(*set));
> > > 
> > > 	git_configset_init(&set->set);
> > > 	return set;
> > > }
> > > 
> > > void libgit_configset_free(struct libgit_configset *set) {
> > > 	git_configset_clear(&set->set);
> > > 	free(set);
> > > }
> > 
> > Hmmm I see your point, but I am also hoping to keep the symbol export
> > shim as small as possible, so that we can try to autogenerate it rather
> > than add entries by hand.
> 
> That's a nice aim - how do you plan to address namespacing data types with
> that approach? The autogenerator would need to know "struct config_set"
> wants to be wrapped as "struct libgit_configset" to ensure we end up with
> consistent naming for the data type and its functions. We'd also still want
> to make sure we end up with an ergonomic api which means one function to
> allocate and initialize each data type, not separate functions for
> allocation and initialization.
> 
> > However, if people feel strongly that we don't
> > want to add helper functions like *_alloc() or *_free() for types that don't
> > already have them upstream, perhaps we can just put them in a separate
> > rust-helpers.c file or something.
> 
> If we're not using them upstream they're just clutter as far as git is
> concerned. Having said that if you get the autogeneration working well so
> the output is usable without a lot of manual tweaking I can see an argument
> for having these functions upstream.
> 
> Best Wishes
> 
> Phillip

For V4 I'm going to drop the ambition to autogenerate the shim library,
and as such there's no longer a reason to keep helper functions out of
the shim library. So I've moved the _alloc and _free functions into the
shim.

For namespacing data types: for now I'm just letting the compiler infer
an opaque "struct libgit_config_set" and manually cast back to "struct
config_set" when we cross the boundary from the shim library back to
libgit.a. I'm not sure this is the right approach, but it avoids having
to wrap a single pointer in a separate struct.
