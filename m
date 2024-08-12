Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77E214EC59
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723498775; cv=none; b=YKZgbwN1GhPHUKYCFcsklBi11Qj5cDqYdMU5sxiPLsTVbLX8t8NxfQq55siucmvrodxYPI6pliCQ/vGVKPGQKggtiOCtsguSteUoa685G4bwjrybLA/C/flfUpAGrMc4NAISXrpiv0H+zBY5Is1SNA4U0En12AE5WLueBa9449c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723498775; c=relaxed/simple;
	bh=iK3NUe1eYr+HVPs/lufDnL3rHSSVsTMU5yf0grQPbu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/sKGpFeuRjCzxSdU6vrXIeCESVxzZ51bDn2lX0mDKQk0VQGWE5+Wa5MOkLLCRXf6MBPgKkzClk3craeyUBUkPK36/CqVEhjtQXTGIlrh3aFzWDMsTy66XHknfaYYXBzLWgXaLW0kLrHoMfvvG++jnTDu0nZsfSZY7xOXQhH7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+xeVTtV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+xeVTtV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd69e44596so32911555ad.1
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 14:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723498773; x=1724103573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vi+mJTvP5HMsEsR0hcQ+qo4JkDcEDLMo7xUoi/+ZoWY=;
        b=s+xeVTtVvBDG39dolpzpsUdhTJQKwK9IvQGXYIFDMFpGmal2/7Az4/G5toPegGg6Kr
         6fgwZIXr6mz3Yhyn9bo/EBylI8RZbgGy9p+35HmA0kAugmd61TZynM0WMoc/yV2qItgM
         ngx2222hXrzxCwy42Ff7SndLBoyWd9o9EWfCzLXLiZ3FG3SwJBiFmi0sm/nuSbswJF7n
         e6jtIjruLQN7kzBxpdXCfyVsbFd5al0KSSurckOnjYEWzpAnuNbLZIMgj1/2tBsBbCK/
         nkDoM6pe2hJS4Q2+mxQQiC6MFkm2YyLOD+sj75Ah6TepISYqBv5kFTmophRu7Z1JAtfS
         5IMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723498773; x=1724103573;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi+mJTvP5HMsEsR0hcQ+qo4JkDcEDLMo7xUoi/+ZoWY=;
        b=uAKRRh9BoNFtPDq2zB5gV2xxvdWiNDYbyg69/pJJKaqpX3sOPo6SjlFLaH9NF3y40V
         sAQnTTZqlIb+URcwt7zUrl4SlQ5+A4+FisE+HroLEN0LGnIkkSUcLoj/vbrNJuQCBIXy
         PvSKLg3544WsQDNpZGOrynz3rfXFc+psbmBCYONNkYWplb0Ro5vxKquCeUpGYmTybuju
         DJJALHPO2GsZiJdBid0LBO6U106MMAsC98mCnmVniobsGRYKkyXJIK9dna7rZoD7ngS7
         KeFGriKvGW8MFHHPuiFb4ALlF2KaC+4ZSnx89qdMlIJWcOXhW1FkcGjG+rwHVbuJv5eR
         zX0g==
X-Gm-Message-State: AOJu0Yz67kFTXnzDk72pVfoN0UZQp0Us1Dn6oHb92UBHE+rejCYLLmCu
	H98hTBegFsaM7D2fFYWZZP6W3hkmVTmq4vV2xGzLMTcbgrLHZgKIO0v47Hd1vg==
X-Google-Smtp-Source: AGHT+IGUG5j2f3Vta4rHdcXg67Wsn8UHA3H9LCKUAUpWKyfVCJr2oLb3OzWBRJyQN8JQR4c1gkeeGg==
X-Received: by 2002:a17:902:dac9:b0:1fb:2ebc:d16b with SMTP id d9443c01a7336-201cbba0316mr12607555ad.7.1723498772442;
        Mon, 12 Aug 2024 14:39:32 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:4c2b:85dd:6293:a02c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1aa00csm1348895ad.173.2024.08.12.14.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 14:39:31 -0700 (PDT)
Date: Mon, 12 Aug 2024 14:39:27 -0700
From: Josh Steadmon <steadmon@google.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, 
	mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com, 
	dsimic@manjaro.org
Subject: Re: [PATCH v2 4/5] config: add git_configset_alloc() and
 git_configset_clear_and_free()
Message-ID: <bifcs4ijz4gsnrfjs3naqclo7nj7ajhek6eppgaj6a27ixp372@6oariraac4rz>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	phillip.wood@dunelm.org.uk, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, 
	mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com, 
	dsimic@manjaro.org
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com>
 <908ad0b82fa084fc4e56d7f6dff49e4f255af6ec.1723242556.git.steadmon@google.com>
 <47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com>

On 2024.08.12 10:10, Phillip Wood wrote:
> Hi Josh
> 
> On 09/08/2024 23:41, Josh Steadmon wrote:
> > Add git_configset_alloc() and git_configset_clear_and_free() functions
> > so that callers can manage config_set structs on the heap. This also
> > allows non-C external consumers to treat config_sets as opaque structs.
> 
> Do we really need to add this code to config.c rather than handling it in
> the wrapper layer in the next patch?
> 
> Looking ahead I wonder how useful it is to users of the library to separate
> out allocation from initialization. A function that allocates and
> initializes a configset would be more convenient and harder to misuse.
> Calling release functions *_free() rather than *_clear_and_free() would be
> more convenient as well. I also noticed that the data types are not
> namespaced when they are exported. So perhaps we could drop this patch and
> add the following to the next patch.
> 
> /*
>  * Namespace data types as well as functions and ensure consistent
>  * naming of data types and the functions that operate on them.
>  */
> struct libgit_configset {
> 	struct config_set set;
> };
> 
> struct libgit_configset *libgit_configset_new() {
> 	struct libgit_configset *set = xmalloc(sizeof(*set));
> 
> 	git_configset_init(&set->set);
> 	return set;
> }
> 
> void libgit_configset_free(struct libgit_configset *set) {
> 	git_configset_clear(&set->set);
> 	free(set);
> }
> 
> Best Wishes
> 
> Phillip

Hmmm I see your point, but I am also hoping to keep the symbol export
shim as small as possible, so that we can try to autogenerate it rather
than add entries by hand. However, if people feel strongly that we don't
want to add helper functions like *_alloc() or *_free() for types that don't
already have them upstream, perhaps we can just put them in a separate
rust-helpers.c file or something.
