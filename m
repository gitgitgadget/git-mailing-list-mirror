Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402BC2DCF7A
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475863; cv=none; b=NcP8ao478v2HJOj0cY9h/DIBwX24oSGTYgXHQMJ9AJDpvVrqAUqBkfr5heSrVzJRSXzmlqDgp7gMVUxDW3Y+VQTvLCUlf4OdqXwVrQBL/GT91r264BQcDgPd6MpA7Bu584zJfyGuMRfOgZ7Hobs6Wp/gZhVWcBkhIb1PTsIpCIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475863; c=relaxed/simple;
	bh=kgfHULAbjInd54buTYwFPOtY5yqvcSXpSUSV4EslZb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIljwHskFtxIHKz2mPPrhNHezrplkcVEbR6Q98H1jlvVt1Wo0bJmZy//S+uDi3O63SgtRNVefAAVSRV9kyg0/dzO+h6tXzR0lMIfn/whCwfGxfb8NeqmaHQqnUBwBGkRys2whKqJy6kmiJQvWlS81nSWwqqp1Zq0YIP6OnmgRzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWzPkTfK; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWzPkTfK"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7490acf57b9so3595735b3a.2
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751475861; x=1752080661; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7yY5rmUlxEbxoCSaHCj/cPgqVPuEsXGyYBAv3cjHJbI=;
        b=jWzPkTfKYg3I5c4UqNHMKt+P/hWUzuwPSSqebY3k2aQbc2y6ZRWkK6RUxSpNTsgejq
         OwU1EMPqHVCUfrFmFOikYQx4mPTfHZb547LgmPBqrtTUiCYYZniDpPB+Oq6bGt36zQe8
         QgUuD5cHc5nLqjcjBQfREfTY7b1aQ4lZZjVyZY8xAdT7ubY3M3gkKEFWLsXQGqkWCRt1
         C+cGVTgv4Ej/TvJPOkqCrvFG02SRjEy4VHLEQCmxn5duZi2ZD/NBokpTlKqpXpeN1fCQ
         6eEs+HfXun4idy0zpTEjghN9u8o5hoXHSONCgmmadkv19NK943FlaHDyAXp4Mcn3fjDh
         XgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751475861; x=1752080661;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7yY5rmUlxEbxoCSaHCj/cPgqVPuEsXGyYBAv3cjHJbI=;
        b=IHm2ru9W2dOV6xmRD8oEoQUv4po2xmS1jweIkxPTl1qod801huRt4Au1kNdXCj7ztA
         TYaUWj6VvWzmQkUIAnDo90Y8kYUI47qBCURtr8J6TR5YrH2fT2/ASv7+ySsLus1WDozr
         nGRR8PzONznlSTJpqm0mIAaYN6YvVabAQhkLuv6qF92ADPBL05IZsZFVR8l+RWeUlWKF
         QuRB58yyq2ypdfBpL17GglmbPAxsh9P4V2U/EERWyaroRKAzatCuYz9Hh2v5kdnYNEXZ
         EvrUFXqqRqUeUiwGViRZtJefEEf1WMN1JquSgPZqxfTS9MKdra/j7W1oKHpwY8HBYzAG
         CtPQ==
X-Gm-Message-State: AOJu0YzW9zoQk7WGurqWboS43sjv4TdUCx66vnPi9BGstlJamP0cn1aj
	wb0ApqVd+527NQ+WuaauhAGJnj+DDQTXVtqr7J+egd76ttF9Mz0zlHTQ
X-Gm-Gg: ASbGnct/Q7wb7YksL072XKm7MWAxD17KuTMXEnlo47X9XpRfpQ/mam1oYkQqBVA27Qy
	rGJAdyzH8nNskfMHfS6J3b67IA4OnX7Wy7JZYHuP5qYAxaG6g1YW8vtkl2KxMIz5aHqk18btm2D
	SXn+RkC0wLYsQZrkyw5IvVx2xE0J7lyQOkC8Nl3SYq+qAFCsPw2dy012JK+DuQWfwZIHPshhBc4
	EeqFtYW0sjYzMhHYkPZ306P7RsT6CxHob6T/VzkHhRayLumHi9tIuYj5dIl2sXzkH6UyUbT059K
	Lilb2Km02qeY70bQiZdKKKUAadKfCQDntDko2rUaDWDVjRnnRy4yb04OnDkuBsDQkRK2FE3R/NH
	7cUaE7O1RJMjP2uJu0N1e98c=
X-Google-Smtp-Source: AGHT+IHkNfFA5JNBFqSo8fuAbpNdtNiz5Ool4PgsyP7DytHQcay7psnhY+OU7jB+5SgJqMpTw6S8Yw==
X-Received: by 2002:a05:6a00:198d:b0:72d:3b2e:fef9 with SMTP id d2e1a72fcca58-74cb69cffcemr230470b3a.20.1751475861290;
        Wed, 02 Jul 2025 10:04:21 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:8123:5123:76e8:a897])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af520db66sm14107772b3a.0.2025.07.02.10.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:04:20 -0700 (PDT)
Date: Wed, 2 Jul 2025 10:04:19 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, pclouds@gmail.com, brad@comstyle.com, 
	collin.funk1@gmail.com
Subject: Re: [PATCH] builtin/gc: improve total_ram calculation for
 HAVE_BSD_SYSCTL
Message-ID: <372xg2ktahmd2whngeqitkotdez4zy7irvabns6bgkr3mdqiab@aeuofua6j7ya>
References: <20250702144244.43858-1-carenas@gmail.com>
 <aGVO3ej7bEo5swih@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGVO3ej7bEo5swih@pks.im>

On Wed, Jul 02, 2025 at 05:23:09PM -0800, Patrick Steinhardt wrote:
> On Wed, Jul 02, 2025 at 07:42:44AM -0700, Carlo Marcelo Arenas Belón wrote:
> > In BSD systems other than macOS, since 9806f5a7bf (gc --auto:
> > exclude base pack if not enough mem to "repack -ad", 2018-04-15),
> > sysctl() use HW_PHYSMEM with the wrong size for the target.
> > 
> > Use the correct type for physical_memory on each option and make
> > sure it is initialized, so it is safe to use even if sysctl() fails.
> 
> We don't use it though when sysctl(3) fails, do we? We only return
> `physical_memory` in case sysctl(3) returned zero, which indicates
> success. Which raises the question whether that function ever returns a
> zero value without writing the value to the pointer.
> 
> Not that it would really hurt to initialize the value, but I found this
> explanation to be puzzling.

Correct; the issue I was trying to address with the initialization was that
the function would return 0, but if there is a size mismatch between the
variable used and the size of HW_PHYSMEM then the other half of the variable
was used uninitialized.

Initializing it, "solves" the problem by making sure that (at least in little
endian) boxes the result was still valid.

Carlo
