Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6018B481
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106530; cv=none; b=Nu1JrJBCsD2aKtqiKvR/BYGj0kvwbnmdXdZbRRwWQ7Fmgwb8QiHKoSpwECkv6WBI8/9iF5j9wbrm33642BogEWCNXKuk9iyZbbjK29UBpgFwKpEVnpFIgo3Vg5By/txELKUDZ0bYLQcX7RzcmqZhxlSP3rpRJ4X2Y14RIB3tKrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106530; c=relaxed/simple;
	bh=OO6a61UIflprAcBMkoU0vXbu3jhClHUSSmc+/Q5f1w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z68VVX/K+oIwU0n5MHEf5cRMOS8OKVDNQ4A/ouaIOM0O6Sj1Pn7pwS1SnZT9c/WyyQrMCNF3NAiZN5h5RcnResjc8oLjGE1/0tPXnHsqt0gK1c8oJua2LlsQOE8woV6utHUo1gt8tQ3xpaCetb/+CsI4vnnYq+IXZ4Sa9xlUTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ErWU2l4T; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ErWU2l4T"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e34fa656a2so2525807b3.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 12:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729106527; x=1729711327; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mGqnUrlRaUeNrQlDZExUATJcyKfi6+7wjbwaQSY193o=;
        b=ErWU2l4TQtQ1jRdhOuRZcCbW6NpkVKtxknGDXz6En2SCspDGZlUB6wvokuTpJxuKww
         4tcc0OkooYYgCv6EOAyWAqYSVr9yGKHBft9s6FXcPqwZ7fIloP5cdW6+h2JxbM/ajLT5
         gnLeEYL6BIeukzyEUtkVB9FNRmSWswwZ5U0ekwVZXMU0iA3dPGkeoaAVdUV1774O9wj7
         /PGfz1YkMt9UqGRfbqJTvpdxEowIx1o/bavOcyK2rNssLJwD3eMXCxN2pbCQd2AFfE56
         UuFAzv4iOil1gr+vE4neZCq5kG/dFu3fBk8vJi5ntgjXlKSgR4a6dOwCFrggcO5OdPPI
         jr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106527; x=1729711327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGqnUrlRaUeNrQlDZExUATJcyKfi6+7wjbwaQSY193o=;
        b=XCbTyXYhGp4t/uzpSd3lEqSb+s/FX3RExFLo9gNs/C8+5J/D0w7CtonhOfulObbBBG
         KdGIN6V35yZPgx9isYWs/VDc8ua/D68BA2zPKzsjVc+uksCExnhfCGbzqjTDVTuELOEG
         nJbm47IWT1k/BMNmE7cxTziestP9VZPD36PBbrYhd39pMQs3wTMeYwSnsCtAU/BixoTo
         cSIAy87YS/HvqCNpwTc6FZd4gH9p23pE32Yue9ZCk441xA60HLjQmpGIY6NM8jmoVL4J
         AumhTZKvfgzDfcBlE1fvKkZqSsFQJvjVuvp12k9HWNnEi3rrXqcBYZ9xz8vNJot2CV7w
         FP3Q==
X-Gm-Message-State: AOJu0Yw3Sij7aBJewtkfwDsTKMVgW9yDk+sshH8DsKXikO0c0S5usBzn
	cn1t8ZiURKH6153x1MyfvCWp2KEM3ciCDMkUkURynuJaxKCj7TxlRD+x0vZCvJ6FzCxGWtgVynu
	8
X-Google-Smtp-Source: AGHT+IFZQmtZjtZ1gctWdYT+H311vg2bRu8TYAFvj+PMz6kBbrXYa58WjC57tGNmgc6dMF4XrPn+sA==
X-Received: by 2002:a05:690c:1e:b0:6d5:7b2f:60a0 with SMTP id 00721157ae682-6e3644be758mr142040697b3.34.1729106527545;
        Wed, 16 Oct 2024 12:22:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d26570sm8211027b3.127.2024.10.16.12.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:22:06 -0700 (PDT)
Date: Wed, 16 Oct 2024 15:22:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <ZxASXLz4lA+E9MuQ@nand.local>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241016182124.48148-1-wolf@oriole.systems>
 <20241016182124.48148-2-wolf@oriole.systems>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016182124.48148-2-wolf@oriole.systems>

On Wed, Oct 16, 2024 at 08:21:23PM +0200, Wolfgang Müller wrote:
> Whilst git-shortlog(1) does not explicitly need any repository
> information when run without reference to one, it still parses some of
> its arguments with parse_revision_opt() which assumes that the hash
> algorithm is set. However, in c8aed5e8da (repository: stop setting SHA1
> as the default object hash, 2024-05-07) we stopped setting up a default
> hash algorithm and instead require commands to set it up explicitly.
>
> This was done for most other commands like in ab274909d4 (builtin/diff:
> explicitly set hash algo when there is no repo, 2024-05-07) but was
> missed for builtin/shortlog, making git-shortlog(1) segfault outside of
> a repository when given arguments like --author that trigger a call to
> parse_revision_opt().

Good analysis.

> Fix this for now by explicitly setting the hash algorithm to SHA1. Also
> add a regression test for the segfault.

Makes sense.

> Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
> Thanks-to: Eric Sunshine <sunshine@sunshineco.com>

In the future, please ensure that your Signed-off-by is the last trailer
in the section to indicate that you have certified everything above it
(which in that case would include your Thanks-to here).

> @@ -143,6 +143,10 @@ fuzz()
>  	test_grep "too many arguments" out
>  '
>
> +test_expect_success 'shortlog --author from non-git directory does not segfault' '
> +	echo | nongit git shortlog --author=author
> +'
> +

Instead of 'echo |', I wonder if it would be just as good to write this
test as:

    nongit git shortlog --author=author </dev/null

Thanks,
Taylor
