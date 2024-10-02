Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8943A2F22
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907487; cv=none; b=dfkBiIMkX368oDcxdMmwRa7+LlNjjzo2S6kiafBf2pHKFS7Ir1Euey+Gn8+NCANnKBxSYDTMECU950L6lHoLEdRd786Lh4zbwRqaZw8xCsVmRYSIrkvhu8AIfVEK/YMEo2WxyPnYl1wAW3kEG8lKwF2hg6WEuE8/m8lDZVIrXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907487; c=relaxed/simple;
	bh=bmk6c6JBM9S9WQ5xk3ibK5h39cV8W7FiiR0L1l/2XaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=si2q9p1ytux8NJFwxL3r03u76tfeRfI2IHd0gIH9nDoyyHZh9bMSRqHpKAqDsy/zm36ONR90Mm1G7osMigpnWxY7TV3qyMQzdT0JsKXE+Han9WyWiUauw/4Tr7G2vpUfHzEfDK5wfSwIOPB7MK4bo4mWxA63blhB5Dxpis+CNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CGS0+6su; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CGS0+6su"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b40c7fd8eso77905ad.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727907486; x=1728512286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSWlC+CxPYFz8lDR796YvJxIGCQpF3I3i87s2DJ8VYA=;
        b=CGS0+6suplGZ3wkLFC8jzCARyg7K36uw3a/nYJbT/3djvKFlp4I7Pj6HNDqLoWOxZh
         gkYISyaHo7fQLIAyiE+fLjoSL840Wh/qBG8NTL9adQLW1G30edaObW1wuIOYXHTLQusC
         +nqqDjB26yHaMhct9aen2sTBJ9tyqirByEVmucYZrVk4zeB3uxeLXxMIhTendPGfVLD7
         wpdlyU1WdgcedKDQR5qP7Ehn+GGyfiW8xJjWwG8CoiQSrrOWhcAe/uyr1flNlhCT+MWF
         oDINzAK2JpRVdeu8Z7Fhq4FC85qCVEA7rXNPbONIp0lsHiHohZiiYbFQchi5fiYoafDx
         UR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727907486; x=1728512286;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSWlC+CxPYFz8lDR796YvJxIGCQpF3I3i87s2DJ8VYA=;
        b=D3eyH+EKPUUrYHyBjmSeamvRdIKfFr+mzVyfv/Ytn/y8SjfLdqkgRqAO9Ar30RNFLB
         LXwPJkKxTeQ3CtFl0wjF3D3Gh8XZL4ZTjGBEw0CMV959HZV4OiM42+WcXojIisKDtyOD
         2bGGigM6y/XUIpWkP7+LpdXSmAgDnTr81tdeTbFrx8PKvJvDduBhbmgO5bNuQEhLnkCI
         L/Fq7W0w9dv1w2azsFbjVM+o6xB1awK+t7+KMO1lva1xdsu5puPaoo3AsfBIDS366sCh
         RMX+8OJYYUcw03bT0JwgTw/CjSQOP5NZ+F11m/RtxdonsmQ9MFMWJr5QqLMOYGbQGpSp
         xSJA==
X-Forwarded-Encrypted: i=1; AJvYcCUSDKxyQKdd+SGFASqdgvvOXadZ6s1LWjEBwNNzxTuGwwpVvLvUYCpWSEg5ZPpAJR8+77g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQntRH8KTgMvz29tWN7se/oOGFmWPgfD/MwbXMXz+BAJlBs/40
	vg6F3AFlWzdpUCEGeHpOCtG3vjhV4MdqGfJfjpF0CDozWO7mXEOgmwRZuaDwynQRMFZWYQFFGLI
	0olIL
X-Google-Smtp-Source: AGHT+IHE6+rZwCx7y3EFGfov1Vk9wdHuYL7rS1S5HxZH+dzlAhLvHFM53UnIbN5E1jIs+JnzxDMbMw==
X-Received: by 2002:a17:902:d487:b0:20b:8109:2c8b with SMTP id d9443c01a7336-20be4e0875cmr1065745ad.16.1727907485574;
        Wed, 02 Oct 2024 15:18:05 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:2dd:9410:f675:e07f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649c775sm10384658b3a.29.2024.10.02.15.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:18:04 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:17:59 -0700
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, calvinwan@google.com, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Subject: Re: [PATCH v2 4/5] config: add git_configset_alloc() and
 git_configset_clear_and_free()
Message-ID: <ypu7w5bptyiporstbffps5xsdc4qusum3vlcmysqznegfr67gr@sqm2mi2xx572>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com>
 <908ad0b82fa084fc4e56d7f6dff49e4f255af6ec.1723242556.git.steadmon@google.com>
 <47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com>
 <Zr827Bd5jrQwhIEp@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr827Bd5jrQwhIEp@tanuki>

On 2024.08.16 13:24, Patrick Steinhardt wrote:
> On Mon, Aug 12, 2024 at 10:10:48AM +0100, Phillip Wood wrote:
> > Hi Josh
> > 
> > On 09/08/2024 23:41, Josh Steadmon wrote:
> > > Add git_configset_alloc() and git_configset_clear_and_free() functions
> > > so that callers can manage config_set structs on the heap. This also
> > > allows non-C external consumers to treat config_sets as opaque structs.
> > 
> > Do we really need to add this code to config.c rather than handling it in
> > the wrapper layer in the next patch?
> > 
> > Looking ahead I wonder how useful it is to users of the library to separate
> > out allocation from initialization. A function that allocates and
> > initializes a configset would be more convenient and harder to misuse.
> > Calling release functions *_free() rather than *_clear_and_free() would be
> > more convenient as well. I also noticed that the data types are not
> > namespaced when they are exported. So perhaps we could drop this patch and
> > add the following to the next patch.
> 
> Agreed. This is also part of our coding guidelines as of 10f0723c8d
> (Documentation: document idiomatic function names, 2024-07-30).
> 
> Patrick

Fixed in V4.
