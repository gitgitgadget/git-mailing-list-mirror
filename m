Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDC0185E50
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881175; cv=none; b=lxmDlS16Jhr2PZ6GsmSpguLD+gxAovzm7U1pt+xzai/U+OQaztn530z6PeAy9P3QJQUcZMfOgbm7M/zuCfHMg0YEb55KyYdOaSDN3JlOeZwh9746VLimbRjh5W6pW/SPnXfk6tzpp+7Bf4xGOw82lzf82O214a+55Si8vSiBdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881175; c=relaxed/simple;
	bh=JOXS31Tlmi32deU1TuHC/J3ioZWoEU9CTvYVmxcU7ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7q4D0fgHj0Ce8Da/LIKEfEEx9O6B0U69353H/KidFfxbhgrpcsNfUhXtqbZDVGa5vwTzdl4Ehnkgb1n1NJmXn3T0eBkhKHi1SGbdubNpb7+jElw2uxz9jk0zFi/cm8rRPuoqK5dRYPLVFLK2E+UDAj9FO6pj13H3RhLS4mZ7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PnRLV+GT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnRLV+GT"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ca4877690so19055ad.1
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729881173; x=1730485973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMEiw56xH/jgPQ0KpY9SnjePTXeMorS47diSjkuMvE4=;
        b=PnRLV+GTmmQr1Tj/BiuuNFXGqFJ+K9Tz+U3TwEk301/YaHYhKHXsLZv9Gt8jx56NL4
         q0x+SLMOke917CUpAHweElhFFyhFMk1XmVaCaQ9YFsAS5PQzYsBUbiltuZybdnPPF851
         /sYhwUJFof+3oM36MOTKTtOQ7lQwgZQ+Tm8R9IWXIsPA03d+znKBgDxMSsXWLJMzcn6o
         DitnpC4b7ZpvkE19JuVjzdD+wWP9fOirgfDUxq1NfuAoLwfNIDu3sLFN2mC8/2ueMQDe
         usm0BEcOXdSXg69jjuVPLgoTzj4REWGi8o3W8eFFxiQFHMXNmiLDgbtHW4Ph6JxyfIWG
         Aaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881173; x=1730485973;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMEiw56xH/jgPQ0KpY9SnjePTXeMorS47diSjkuMvE4=;
        b=t+2S53TSoDqoqYxCMCtU9m4aAUlRsjyRqJjBk3gr1Ur2nYEpb+kVYhLj4vfAR3uX4r
         qnRr19I76JPS+XaSJf//2bXVCaMA/z/eJiqL1BCfCwsA1E62sJ/VoePDD5LOHkBGdIOZ
         v3hIanA7vTkT8KEkGjR5HcmjlH0Z7W7tJsir3cyp8VsoNAb5Yr2NRJgQoxNT4MjWJM0E
         qE6fkDq2lWCy6zsZSxcvgX2WWxuNLAs2SiZpkyBjy/6iaCwHVjCt28tlHH6LclsYa/rV
         vy/EtxzD4/sk7KZ63togU1Zcgcg5cfxJvVnm9t7f4wIa8ptFXI3GyZOIZqUhcd2MDLyi
         iRkA==
X-Gm-Message-State: AOJu0YwcZHvxwSP7AdEre3PyhvZY7dH9sjIXpZ/gSlZUpUyE+/WxwnLJ
	t/7PGo301k7hL4IdYtecgBEnvVIqwYv6B3cL83SGQZnUHFUcUsETekPeT8dz0w==
X-Google-Smtp-Source: AGHT+IGyGvHvYtLgDExL2X1d3vxWfxZs76MySwMDmgZRjGwDe2UMUM0hAj6RL3qM54+1DRvgi6U9xQ==
X-Received: by 2002:a17:903:1c5:b0:20c:5fbe:4e66 with SMTP id d9443c01a7336-210c685f0b8mr142075ad.27.1729881172798;
        Fri, 25 Oct 2024 11:32:52 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:ea:d6da:f8c:46aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc0864ccsm12263325ad.302.2024.10.25.11.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 11:32:51 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:32:47 -0700
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 02/10] t/test-lib: wire up NO_ICONV prerequisite
Message-ID: <zod73s7j77gjj2f62clg3utxlxnclbyhjjz3yc74x7zyh35fzy@blwhzqefxyrs>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1729060405.git.ps@pks.im>
 <c046e5f03bf9e3eeda803133b88c3ae414fd0c69.1729060405.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c046e5f03bf9e3eeda803133b88c3ae414fd0c69.1729060405.git.ps@pks.im>

On 2024.10.16 10:12, Patrick Steinhardt wrote:
> The iconv library is used by Git to reencode files, commit messages and
> other things. As such it is a rather integral part, but given that many
> platforms nowadays use UTF-8 everywhere you can live without support for
> reencoding in many situations. It is thus optional to build Git with
> iconv, and some of our platforms wired up in "config.mak.uname" disable
> it. But while we support building without it, running our test suite
> with "NO_ICONV=Yes" causes many test failures.
> 
> Wire up a new test prerequisite ICONV that gets populated via our
> GIT-BUILD-OPTIONS. Annotate failing tests accordingly.
> 
> Note that this commit does not do a deep dive into every single test to
> assess whether the failure is expected or not. Most of the tests do
> smell like the expected kind of failure though.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---


> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index f1623b1c06d..2a01a62a2f3 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
[snip]
> @@ -198,7 +218,7 @@ Thu, 7 Apr 2005 15:13:13 -0700
>  1112911993
>  EOF
>  
> -test_format encoding %e <<EOF
> +test_format ICONV encoding %e <<EOF
>  commit $head2
>  $test_encoding
>  commit $head1
> @@ -374,7 +394,7 @@ test_expect_success 'setup complex body' '
>  	head3_short=$(git rev-parse --short $head3)
>  '
>  
> -test_format complex-encoding %e <<EOF
> +test_format ICONV complex-encoding %e <<EOF
>  commit $head3
>  $test_encoding
>  commit $head2
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 2add26d7684..e9a6cc72658 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh

These two changes subtly break t6006 (in such a way that it still
passes, but is clearly not testing what we want):

./t6006-rev-list-format.sh: line 92: test_expect_%e: command not found
