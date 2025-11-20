Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167C25B1DA
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665532; cv=none; b=TXlnAJy++9uoMH97cf/KMvLonRhFXvuvwprZ/xzSlskJD2BbaDM3vazKOEI2DYt1CpwQ9j8mm1jLKEEW0P7so6NgC9rFFErakWv6Y8szZhVznMffd5NnxkcKcRuxio67dWnCntA9qnfSZ7X6nkRkGTLW+RHoaO8NbmtEf7XOQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665532; c=relaxed/simple;
	bh=Xl3EoqySXh7XJKZ8Lr/iLEpj//mEKSD+zLDogPvmGpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmDdZF1dqu4HhYWJT46f6mF0Nfp27/JRjYcngB0UTlNj6FbbMkfyhxDhg6ERz8f96GA4LXc2IxvvywYa3CH5Tlo8zd+M46bvrj8KEwOGUL7rngA//ZIRwcIcscMOEhCxOjYFYf8BQ5pa1K3mUkeqm368h51d/PFOOkqy8F0jUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inPXEIFU; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inPXEIFU"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3ec3cdcda4eso741995fac.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 11:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763665530; x=1764270330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xl3EoqySXh7XJKZ8Lr/iLEpj//mEKSD+zLDogPvmGpE=;
        b=inPXEIFUOlniwHtfGoLMriW6AZygPpTPtXAqic4cB7JVliCXU9nwsd6krzdeZDgpRT
         lZVmVd/gU2wviMU+YO5E8D7lKQdmd8YlK7yECDRegDseSA/6gF/LRgMg1VqDLCZzSj5Y
         GJwQBGLObQD3T8qECsBa3Fo99ub4NKiKnE8/ex7C9v4d3C+soTAoUUfqHqJOhxPcsLdB
         oMepDxUyYCzRLIuMaChJ8Q2kw9/JNBf22Csr8SQHSaA2o1RoEEX1oepbY1+a7MVAZhEm
         NY1pOQHO4knPRbTFmsJAKOu8XEZcTUPPAXKfRmWXiw1gtdaZBmZx1aMt2B9UJHOQ/HC6
         asyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763665530; x=1764270330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xl3EoqySXh7XJKZ8Lr/iLEpj//mEKSD+zLDogPvmGpE=;
        b=miEiiUg/WagsxTTyAdIt80puWfsTyzOEPJJSRpMnG+YnW/NGcDY0y2u/D+mAx7yXKF
         ZN8GktUZ0UtkOiXjkNSier8mjTNfqWAcDK1VqJ8B7uO78pauZLw9IQqLfssaP5M9RieH
         bERujUPP2sPeCsPSg48IRQp455ekf+WIEVrDz9hOpnraTqhCtTvm+AEO3HGzPY86D2PM
         DeJuUK4J0EAwCzHZxAjoRGkjZQFmGbzr43w0OQkcS15SVJ/CJ3D+PmFfbbHbw/5WSBxh
         Yb2gXwQPLRiU10JieVZqUZahiyN8XcqVgBI/vysey06nLvLz8zucMOnFj5KSubme36TC
         sllg==
X-Gm-Message-State: AOJu0Yzho/uNgrJrO621+2coKi0Wa2WTdnM1aaMsEXndtaIwGjEIGrLz
	7o9Mc0NRAmgqpkznR9t4OTlRyVtGEvPpjL3/S/73FycAmyvxDRbT2du4
X-Gm-Gg: ASbGncvpE5mzX/g+k6RaP24Pi+wKWT+eYUHnDegCTpiaCEaw6kVK+TXjeJ/gxqAzU0B
	q2TLH2jr7fRmgS8ZbS7yvB1cMCHLmQ1J2gHzfIBBO5iRx20CzX2JgZLVWIUAJeneg55GX2U/s2I
	VbKaKoVKbe2ggAradBZ1RoiiM/1s9O5dvPUx+YHui1RT82MTxv7RppuuJfcr1Yvvs318flGEfTt
	HQptd84Wp98PBIHL/qXxAmIGzyO5KGG7x43OVNa38x1P3ZswvD8pki8pJjm6h6jsVNIWfba4/WR
	W/SjwvIhTOxCs5k+z4Q5ewq6yK0p1sq7nJWFldCfqugaLhAjVovELPbHqhRXKFs03kqBQa84Zw0
	T/Myu1KNTERmYTvU0JwJaMPbU4l4FanAOlZXEOUx2oFA7FVaCMFerW9svl5cHDK9A8tYREvU/7i
	yf8VCR
X-Google-Smtp-Source: AGHT+IHRBiRUDc/J1uhEwUqmhglk3sLbhpK4ccmKgH7zSRsnATW8sNNF3Ivhd37swS4sN3qo8pqf5A==
X-Received: by 2002:a05:6871:2b99:b0:3e7:e20a:39fb with SMTP id 586e51a60fabf-3ec9a459857mr1954404fac.11.1763665530002;
        Thu, 20 Nov 2025 11:05:30 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec9dce7853sm1538753fac.20.2025.11.20.11.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:05:29 -0800 (PST)
Date: Thu, 20 Nov 2025 13:05:26 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] refs: support obtaining ref_store for given dir
Message-ID: <pyt5nc2v25oarqmuxld4nrknmsomjnyooj25ffjetcue5zq7xi@vglcil42as5a>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251119-kn-alternate-ref-dir-v1-1-4cf4a94c8bed@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-1-4cf4a94c8bed@gmail.com>

On 25/11/19 10:48PM, Karthik Nayak wrote:
> The refs subsystem uses the `get_main_ref_store()` to obtain the main
> ref_store for a given repository. In the upcoming patches we also want
> to create a ref_store for any given reference directory, which may exist
> in arbitrary paths. To support such behavior, extract out the core logic
> for creating out the ref_store from `get_main_ref_store()` into a new
> function `get_ref_store_for_dir()` which can provide the ref_store for a
> given (repository, directory, reference format) combination.

So when we refer to the "reference directory" in this case, we are not
refering to the "refs/" or "reftable/" directories directly, but one
level above that which is typically just the gitdir itself. This seems a
bit awkward at first, but makes sense since, for the files backend,
there may be symbolic references such as HEAD that exist outside of
"refs/" which must be considered. It might be helpful to clarify this in
the commit message.

Otherwise this patch looks good.

-Justin
