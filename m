Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF8433A8
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723139440; cv=none; b=QqjtgpKVvpXwtt26XLilSrtQ5+x5CuartJHS257KTMCxrKT8luU4YOffyTUntWEvGKDL0mb1Mk3Tg3tUVUpLsJYUy3jTMYQ3u9hXpH/zRTgDUUrBk1RRoJjrHL6GbpqhtW9cNTY97oZtfc4yCQwivxyb1NFdNF/6Ymy6EPBcWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723139440; c=relaxed/simple;
	bh=6aGRtUufmZ5r3VhPbsU6jo/7if5+5IGQZRFXhAx+Z3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7wuj0JX6Fo2pc6S0r79uz0/O/ZfsiTZTC9VNgdq33y3edCoSUkTRBJoZQejAV33gMwMTgE1PSNIHDucqVCn7BJypxQTfyQVxCzIC3j0twSHd3bdT6phCXYnuImXO2zPA+lDwmc+tIzteR2N3EMDqQCUOQwd+QOVKoxweuRSugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Ig9DoGM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Ig9DoGM"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd69e44596so9149235ad.1
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723139438; x=1723744238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQTU0QchptSjkWA5+W4/YivvzYiWGvEn4mW4YSJa5gg=;
        b=4Ig9DoGMAsouyMmiPjUZDSPu8m5A1MNJPRiLAGKwEBjps20Fbkeg4wXs27JcZiQTjK
         9ktqIck9o2/JJJ3PEqqk8ZRYiylQzZARJBH01VhkI7OpQhmR1K0mmEgsYjA1MXGZkzjt
         8dKziPck6qwWVcI63RKDwGbpkNvJnVZXdk/sGnZ/vdclIFeQ0CjNup81cSTBkN9u6Cdb
         0f+787c+T1U97ig+9yYdG09MZBV2yvze6+/bkoKkl/XRco+AH7UHGfIBZznbWOJ2sror
         twc6TP/nX1uMKd5tWyLOVgcBimW+uHAF3MfkF84FvUw0VMKoBcpCxmXY+qij3cSKcgM3
         MXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723139438; x=1723744238;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQTU0QchptSjkWA5+W4/YivvzYiWGvEn4mW4YSJa5gg=;
        b=STzKyHQmPQo9OlRdizQyVnebgDI80rbFRAb6wnIjuAWDTSc7HMmdpGHJ2Vtxtu78mS
         NiZ8h2iV571NarImZdy4ZmJz6a5GmiNVkH+Bq9Ukmz7PER0c8tDa6//d5s+L4zCG+sUk
         7pPjxLN82MU3otHds47cmuCyP3BYXDEO2bSOxvGu6ZgFL2a4/e5tCNB3B2qvrM0qHFQ7
         OYGcSZDUS6vfYU93yVXLLfZBV6hxNIfusSpweIJdyMoFL22ZkCmu2FrI8fhPXE8HYljz
         vqxeV+WXcyJXLm/6kRIKsuCIAxUT2UzCcEy1GFM/6Ski4As1vNVyoUkrsO/eXrcqgoRd
         7skw==
X-Gm-Message-State: AOJu0YymHdje2j01yfo9+zo5QsqvR3oGJo3cdMm2V/m2f2ZW4MNm7Gwm
	ND86eusiD+BHPd79IVuNw4kiRYC1jeLdR1+gvrZ3jjh7cCqztjWvWAzdmeN6EQ==
X-Google-Smtp-Source: AGHT+IE3ryM/EIR6hKDSbJFM0IjjSsW6bzcHPLaWzM0upqOezdaStfBDrHF2js78GHuRiElyzhdR6w==
X-Received: by 2002:a17:903:2342:b0:1fc:4acb:3670 with SMTP id d9443c01a7336-20096cf426emr41688805ad.12.1723139437947;
        Thu, 08 Aug 2024 10:50:37 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:fa12:a76d:ac7c:e104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905b43csm127373745ad.146.2024.08.08.10.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:50:37 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:50:32 -0700
From: Josh Steadmon <steadmon@google.com>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 2/6] repository: add initialize_repo wrapper without
 pointer
Message-ID: <om763zxrkc63svsxp2dzyzwgcglbq743xcsgijf7trzb2i5e6z@3vtm6dzws7i5>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <5f2e816cf6359725f2a86ce1d08e5e272fba4dac.1723054623.git.steadmon@google.com>
 <20240807225246.7jhqioyqh4e2ibza@glandium.org>
 <5miqrfkepbzi4qzu65invte3tk7weshq2fcnkyufnoih3ou6rp@siodpag6csmy>
 <20240807232916.as2jaivlbvk6pa3r@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807232916.as2jaivlbvk6pa3r@glandium.org>

On 2024.08.08 08:29, Mike Hommey wrote:
> On Wed, Aug 07, 2024 at 04:23:05PM -0700, Josh Steadmon wrote:
> > On 2024.08.08 07:52, Mike Hommey wrote:
> > > On Wed, Aug 07, 2024 at 11:21:27AM -0700, Josh Steadmon wrote:
> > > > Non-C external consumers of libgit.a have to redefine the `repository`
> > > > object in their own language if they want to call
> > > > initialize_repository() to ensure memory for the object is allocated
> > > > correctly. This is not ideal for external consumers that have no need
> > > > for the entire `the_repository` object but need to call other functions
> > > > from an initialized repository. Therefore, add a friendly
> > > > initialize_repository() wrapper without a `the_repository` pointer.
> > > 
> > > Technically speaking, you don't really need this.
> > > 
> > > You can define `repository` as an opaque type in Rust:
> > > ```
> > > #[allow(non_camel_case_types)]
> > > #[repr(C)]
> > > pub struct repository([u8; 0]);
> > > ```
> > > 
> > > And define `the_repository` as an extern symbol:
> > > ```
> > > extern "C" {
> > >     pub static mut the_repository: *mut repository;
> > > }
> > > ```
> > > 
> > > Mike
> > 
> > I've actually already done a refactor for V2 that will avoid using this
> > patch entirely, but thank you for the pointer. We do something similar
> > to opaquely wrap configset pointers in a later patch (we use an empty
> > enum there, I'm not sure whether that approach or a zero-size array is
> > preferred).
> 
> An empty enum is a never type, I wouldn't recommend using it as an opaque
> wrapper. It will likely lead to the compiler doing bad things.
> https://rust-lang.github.io/never-type-initiative/RFC.html
> 
> `#[repr(C)]` and `[u8; 0]` are recommended by the nomicon.
> https://doc.rust-lang.org/nomicon/ffi.html#representing-opaque-structs
> 
> (the PhantomPinned wasn't there last time I saw that page)
> 
> Mike

Fixed in V2 (for ConfigSet). Thanks!
