Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FEC13635D
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588393; cv=none; b=VbjOXrthcaLC9laCHDYWuTRx78NsjjB8rmIFoi/QQsESezODqHPd40+VxT3MhvxnEsplqvWJnjeauPVb+zgoejBk22xqvvwhK+K7eIpnOOx1s5U6iD+v7UN9QKpH//VVgLbWo8mcEhnewXVBhrBb/Rb5wdZSptsY+2SfRXHmGdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588393; c=relaxed/simple;
	bh=GQg9f6tKW6K+V9xpztO7Nr5VIvcJpCA3hsS8PDZTew8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDTEJ+pKx95ufj1vAqU0uMvtzniiH9paCxhkpv0beFURYYMwh2kKydlJ//auvVTZ0lgQp/venre9ifIZnUlpLQw56q0QfjFun9wAWVdtD3SnLxUkOuU5gDXNkf0gwNgG8cR19aukEkERNxAe0cumiB7McXsF0tWQ9useyxaoo/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9rhekMl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9rhekMl"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc66fc35f2so2544335ad.0
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723588391; x=1724193191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZJmNM9yXqj9ni/ykLBHgS2d/OqBGbQeQwlZl3Jv+G8=;
        b=q9rhekMltAxJTZBrsbC2dMxDp/BR+fttyIYbPtoP930DQCjno0y2wfUFosF+IFZ/7w
         GbgIRUBYpN5fu/FzA2w8MLJIaJewTXFAdYU9HS5zKL6O58frJ6RuX04N3Z/na4b3y9Qv
         Ci5EREyT3ulEst8ha7WXUV16Y1GsxsaRaCHde3jR21pTaCTTQuaQlHZMfjkXZEiNKsJE
         9CzK6dHXdTgzvidN0jxpnRtOylgM9SlDvkpGOSm+hoFL8SiM1oIcPqEHqwjYPwUZBBEF
         IG4ZWkLyaJoeGPn6KuQeGHxMs+4ZKNu0sDIOd0N+XSuX2pR14RPKIuAaaM7xsEsd3S7+
         xvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723588391; x=1724193191;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZJmNM9yXqj9ni/ykLBHgS2d/OqBGbQeQwlZl3Jv+G8=;
        b=pixyb7LQf9UchWi7dIjaIxzzHv3IWWntGE3Z1E3UHjeNbsxh48FQWTUJ2L2AUinjt7
         7VHJBzMT8wDCj+0+5LBkefisSKP48RYGREh4brxpWHH8qNDwaQBrmKh7m5rgkDFHRFSx
         mAyCzVat4dIM29mKAK9Pdat1daWWOneRTr7RxJ+lkbqyAmGOXylXgQa8qSThJoq3v3pJ
         OemUBJ89R2CnNePEtEzjp7BHqUGOD9Vr5cHaVa4Bgct/sFcdxoOGLxupEIkEUIpQPdEl
         GPVxUrUTgOdaBcfUSGhRffn9eJGoXZSf9Zao8HWVzTnx7pSJ7bvm8WlT4gPSPSqsNrlD
         2yeA==
X-Gm-Message-State: AOJu0Yz3Yvwz9pH7rv/syI/GcrC6o8Ui+/eA3r+L1RrULKivJRdXtL8p
	bKq5EczwOBgNzKK4gWPdbZFBMZaf0iyx+BvEuRkyALaECBq12AeEKJIuHQCAAg==
X-Google-Smtp-Source: AGHT+IFhwPm2ooUQjOsDQJPRJhuPqCV83hl5IOt6zKclg6153KOQG46MIQIcWQ0ApITAk86IYEyqog==
X-Received: by 2002:a17:902:ce8c:b0:1fc:54c4:61a7 with SMTP id d9443c01a7336-201cbc615c7mr68349195ad.23.1723588390561;
        Tue, 13 Aug 2024 15:33:10 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:3e87:d579:d973:3685])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd12f6d1sm18457405ad.13.2024.08.13.15.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 15:33:09 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:33:04 -0700
From: Josh Steadmon <steadmon@google.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 1/4] t: move reftable/readwrite_test.c to the unit
 testing framework
Message-ID: <2rxxfpzijfmvo65xournnmx4oawzqlhgipje4cxzxvo5aqzt6u@xppoikj262cp>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
References: <20240809111312.4401-1-chandrapratap3519@gmail.com>
 <20240813144440.4602-1-chandrapratap3519@gmail.com>
 <20240813144440.4602-2-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813144440.4602-2-chandrapratap3519@gmail.com>

On 2024.08.13 20:04, Chandra Pratap wrote:
> reftable/readwrite_test.c exercises the functions defined in
> reftable/reader.{c,h} and reftable/writer.{c,h}. Migrate
> reftable/readwrite_test.c to the unit testing framework. Migration
> involves refactoring the tests to use the unit testing framework
> instead of reftable's test framework and renaming the tests to
> align with unit-tests' naming conventions.
> 
> Since some tests in reftable/readwrite_test.c use the functions
> set_test_hash(), noop_flush() and strbuf_add_void() defined in
> reftable/test_framework.{c,h} but these files are not #included
> in the ported unit test, copy these functions in the new test file.

I'm assuming that eventually, reftable/test_framework (and all the rest
of reftable/libreftable_test.a) will be removed after all the tests are
converted to the unit test framework, is that correct? Will other tests
need these test_framework functions? If so, I'd rather not end up with
duplicates in each test file, even if these are small functions. Is
there a reason why we can't link the reftable/test_framework object (or
the whole reftable/libreftable_test.a library)?
