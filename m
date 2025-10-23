Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D2284B3B
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247754; cv=none; b=qrlcXqNNc6qu4vsEl1TCWjQRHmw+EqUcFRX4kkk8UcVYlN/aCC+VieiqPQw9lY50o7R5wFH+1nB/UBLGP5eSeWsbRcZP/ytlJiw0FWzKdozARMeb5ARIm039h5KDmlZNHF0L6XTU29u+FvGioycXjDwl9ltTCyhh9aNkWcnPCWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247754; c=relaxed/simple;
	bh=E8r+JF3OOveHtB+G9dqukJ5Eo25JOaLhuJxlrbU6Ciw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCyDzTA5TyejczqcGgBUtqrJyAg1762bkDUOxcGtWdV0ShNoxwXFfItvCJLLjHEwSiZBjYWNOsDBfI8xUBhMYjzyzq+fl4x2zhsQfjNNLiQTOSvKvxh1BP6LZ9KsQutrsstZCq3S8bWcY980JXLxoRj87bL/qnqlPsdmh91NOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nGYNiNK1; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nGYNiNK1"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-430c52703b3so11068395ab.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761247750; x=1761852550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z79eQHebVR9sOGiKl5RZocV61zPoOF2J3eaMQ+fNHTw=;
        b=nGYNiNK1B1dhAWJpjM5vgDv9NZsyv2a8/yGR4Iy86l1RjnEbQr06TPrQTZoq6rpXFE
         tQYGEZjKzjAnSsqXAW0abMnIXi42F3oxdQjPX8UXRYUkrfu3mUw5AdBAaDYc/CzNzC6a
         n2jAAFAxXDWdPUkeGVAU3nO1cjVFIZi8q5vaMmc7ago3LJ3DFQgZpxXGO0KFE6aL7Gf8
         rRjj9siGknO0blxGUiFHNZpWFFpwZBD5LZLwPexRO/cTk5SqG7soOJcvge0CFhAhCa07
         BQ7Mdh2PYQBsk0/uA4v6gaV6mRsnqfxJiEE5Zuadnme3o2ERjZ9R0RA95U2Si8cTF9D5
         VRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761247750; x=1761852550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z79eQHebVR9sOGiKl5RZocV61zPoOF2J3eaMQ+fNHTw=;
        b=cpg8dwzhUxaUv+dy/DVFUGQ1gTGEE9t26UAvqSwoKjeOqVSeuuAxc1Hw49CRRJEWXo
         8xEsfUrsiSStShh665RJbe73uYSoSWJNZ3UAlIsv6sYgbohVsU8Mau6LqwALdpEPIFyj
         j56kgIZwJP+SBKUWGP7PPaYGDutCYLSelto+E/N+XFnN3ngsxHultY9MpQF3SYFRsaoB
         ZGkPGE6efmM5lM/VV/0evVmTeQrZRq1jzWDSnqPs6r2ird+t1ZQynQn24E7+xbuattQq
         ls2/pLbguvaencCOqnpOGk0jMFVnnVOGBSgnEdrWIpQmUok7ML4MoTSRxgosjXVHNK0W
         WHHQ==
X-Gm-Message-State: AOJu0Yy8BF98y8cGzirCzlGgUoOEPaLrLQgZkj1FkbeKKkDbdy1J+qGB
	c7ln8lM1GW0SG3EUdlIysdP+GhvqJnPOxACxelZcUw2FAmFL/4Zgs5GUA19w7sC2hsc=
X-Gm-Gg: ASbGncvAHwavvBelt48uYfkRs54Cyzhr5I44HqhkQodmFvL0+3J/1fNe1zgUniNZxCd
	qIM7FrEQH7jbW1HeXnOgz9f9P/CmknuOHUtA3VvJP5jBo712DoS9s1e7FI5+tsprGnjFQMdt7o5
	wncmXH2kKG3NybqTkjVzw2KjWYRxnY4eGvrHRwEnFDLfKB9fHmoC4sAp6+Jr/nX3hx3zAvVr3It
	v9o8zcXbAAleIwCj75VeJhR338pncEUVcM4BjObb7SwLnorjj2je94Lbx+TpZlMGp21TH+rcogR
	rsV+yhXXSyqRunxsk6RTBBkrbXTKvGkJIMFp3cCikr3ap0OlZP8GXDUj9HcxsDizoR+J25IQ0iS
	JjO7J7qzYGPH4RdR+GNDYCgnL/M8L0JUmaEZU3J7x0Pmo3XdHWq5dO7ODONLNcNxUPOdOnvUmlR
	or2ocAUGIm6pa0VtWqNHS5PxuCOkHM0BLm9nJJ8hyOTFn7Yj85oUWEjtqKgLl/Vf3pnytzuG1M2
	UWYHQbgNoEy+BDcZQ==
X-Google-Smtp-Source: AGHT+IFpqz+3B+9LKsyeWzezSGpr6ewNyV6FghiQHNPe49ezbWo8pgpv/OfZHaZgSJ7KJvInBB5/lA==
X-Received: by 2002:a05:6e02:2704:b0:427:6e7f:89f8 with SMTP id e9e14a558f8ab-431dc1605f2mr50653355ab.10.1761247750396;
        Thu, 23 Oct 2025 12:29:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-431dbc21ff0sm12766275ab.1.2025.10.23.12.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 12:29:10 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:29:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/9] builtin/maintenance: introduce "geometric-repack"
 task
Message-ID: <aPqCBDLwVBKKaJU6@nand.local>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
 <20251021-pks-maintenance-geometric-strategy-v2-3-f0d727832b80@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021-pks-maintenance-geometric-strategy-v2-3-f0d727832b80@pks.im>

On Tue, Oct 21, 2025 at 04:13:25PM +0200, Patrick Steinhardt wrote:
> +test_expect_success 'geometric repacking task' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git config set maintenance.auto false &&
> +		test_commit initial &&
> +
> +		# The initial repack causes an all-into-one repack.
> +		GIT_TRACE2_EVENT="$(pwd)/initial-repack.txt" \
> +			git maintenance run --task=geometric-repack 2>/dev/null &&
> +		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago --quiet --write-midx <initial-repack.txt &&

Not a show-stopper of course, but I thought from the cover letter that
these lines would have gotten wrapped. Whether or not we have lines
longer than 80 characters is not a hill that I'd like to die on, of
course ;-). But I brought it up because I am wondering if there were
some changes that you meant to include as a part of this round that got
dropped in the shuffle.

Thanks,
Taylor
