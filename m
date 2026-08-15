Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26703230BE9
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786823572; cv=none; b=TPbv47CXch0tws1pwOYaOmrX+HvIB5Kx3HnmhI3MYK3hKGUL4lr6zqNjJ85Lm9db/hkHpOMDgyahqc8Kr7foZRUR8k5nuzejcIB4DZADuoAxTIFFVIG3UaZVBW7PjSwXvBn3+3QdBMfiFU+qNMu4sgMJr2julaT9KS1d+TAAKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786823572; c=relaxed/simple;
	bh=PQm2J2U3tSlX0v6sQioV9VbDj6OAdW9kRnOXytwQw3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV22jRP3vCEE33/6MrSFgM2YM55rbQl8n2D8RMS+K5Dg5OISSg2Sqy6x0LRz9WT3ux3ryTBcpI+n6nLjqXOUIfC7jlwdx000EUA//5qN8hzXLr5Xw3DTsDJxbF8yVFm/jI7WJNLcFBbcEUSwWQBGXLxaf68tseR7KXTYeRHQiLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgCbF9+M; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgCbF9+M"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954a2dba6cso1956365e9.1
        for <git@vger.kernel.org>; Sat, 15 Aug 2026 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786823569; x=1787428369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PQm2J2U3tSlX0v6sQioV9VbDj6OAdW9kRnOXytwQw3Y=;
        b=DgCbF9+M70oHGd5JtWc/Rp33SF3etrs83V2Lpz2w3szfrfmzXrxLRdO14Ko0G5D/dG
         a47oiJCZxuphYw1U+E7COtnjj0ThloTz5zv86w3FonBS1BbRzeroRNQ/gPB/PpjK0b6C
         pHKx2wGLBF1OULRA/vDEg1fQzZQuo2H6k42f2cyyKWmnhRt+PCROtRnxxql7kgal0Cli
         IrVLLRLEp8WMXw0wnuasE7c3z3E687QF1QZ5pjnGEsvAhTF2jWPrxhHL6gToWFvv8PLR
         VgRW/hewuovdoAM0MjJdYlP7AxBmXWNVojBvaZwTRQbcCG8eGAaMp0mXZHXhQRHFKYaK
         wDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786823569; x=1787428369;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PQm2J2U3tSlX0v6sQioV9VbDj6OAdW9kRnOXytwQw3Y=;
        b=mlmUeEuntkklfo+l1M2Z87nwHnhteh278nfCjsP8/BrCHqPwGAXMbngKkWRM1AdUS8
         RkkvVYlkZQXuieK31D0HrYlN66VQwBF/xrQlK8way1sg+1kb/YGn1NGsozzc7lpnKO5t
         NaIkzGGRLtEq7CUhm2qHnmOqg96vIcxqnRfdZie+geoOx+P748dbOfX+9ww/9wprkmBV
         rfB57a7W4GZJ3fCsRwfPYZ8ynUjBJ/VtIJlEjBr4FfcUzUSGgTrNEJmSUxOMmdULj0vw
         b+cKHy2TwgRDfDAUGyQvSDCK1BsqiA0YWxK/HOXS7FxLQN7umH/BYRTlPbfjUeZHWLBZ
         nEAA==
X-Gm-Message-State: AOJu0Yw9C63FG65vtCn6tZPXvNb1xFTatwic4x7YiVbmCrwqkp+9JhRq
	epLRHVAOMaZRDtMGdXMMZBKVHwXEPk0Q+wKVvCQeFaQPERr24jJuJXk4
X-Gm-Gg: AR+sD11mM76N0W96wjOs5Kuvy6xJ23bIC/8vsA3Pqz0e7hQOu1Ml3xltZBgNyO7ZLPH
	5daCPDU4XuOpQp4WZ1uuQYwWJCeUMiCCmVpmzvKQlFspLaL9L/Xb4nyA8nao1tTv4afEmSKEg7j
	AW9jsaNmD4vRdY+vFDN4qbHiQ41QoZ6BNnv51Hky0QBGA2+GM5YGmyj+PXd2lG7hn3bu5XpplDb
	4DVnaWbtuNGxJbEwdHtjnW2BMv/adgPZcrBRI47z6dgedTsOpMyR2nG4a9QKBU552vyk6/zecvo
	O4upzupeh+GMP6awaq7e53Gvs9kfgbWIb/HmwTGSYeKgqZrXQdBX5TbooAFofQA1Np3hS9QJlC8
	Eh3743xofLCcGqaQST5im4wxdC96sN6koUEK8VN7casHG70oTjfaTcP+DYvtLvCUY2MQOcE1X1p
	w6eE3GzQ8FkuMFxoGE/E5hOcf9uSfWqqLG+g92PxdCXk+0rov0rweOYTTN9ZQ/P6zn8w==
X-Received: by 2002:a05:6000:2585:b0:46f:7d90:8124 with SMTP id ffacd0b85a97d-481607738d1mr10501689f8f.2.1786823569092;
        Sat, 15 Aug 2026 12:52:49 -0700 (PDT)
Received: from desktop ([194.127.199.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c46besm18747527f8f.31.2026.08.15.12.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 12:52:47 -0700 (PDT)
Date: Sat, 15 Aug 2026 20:52:46 +0100
From: Matthew Hughes <matthewhughes934@gmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bash completion very slow in large repo
Message-ID: <aoDB9roVjgoTeG5l@desktop>
References: <an9iXOqOOvFfyN4A@desktop>
 <CALnO6CAWA4szRqq_=1kAjB_y6WqA5zSyyMZzPmgnV7KGb+AS7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALnO6CAWA4szRqq_=1kAjB_y6WqA5zSyyMZzPmgnV7KGb+AS7Q@mail.gmail.com>

On Sat, Aug 15, 2026 at 10:17:19AM -0400, D. Ben Knoble wrote:
> Hi Matt, have you tried turning on "feature.manyFiles"? That enables a
> few things (like the fsmonitor) that might help in large repositories.

Ah, thanks for calling that out: I should've mentioned this is in a repo that's
already configured via `git-scalar(1)`, so it sets that specific option off,
but justifies:

> feature.manyFiles=false
> This disables the "many files" optimizations grouped under this feature config.
> The expectation is that all valuable optimizations are also set explicitly by
> Scalar config, and any differences are intentional.

Though also testing in a fresh repo with no scalar but that option on I didn't
see any significant performance change.

I'm also not sure e.g. `git ls-files --exclude-standard --others --directory`
knows about things like `fsmonitor`/the untracked cache, like e.g. `git status`
does (disclaimer: I'm not at all familiar enough with the code to justify that
claim, it's based purely on my qualitative experience, I'm also not sure if it
_could_ benefit from such things)

Cheers,
Matt
