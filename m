Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E1B15B106
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025497; cv=none; b=DjcSChnuYd2Mfvde6t0Q3FNwBMtO5QDRYzV7alGrin8w6poPuUzlRi0fhKQhEfcu9RzRSVwU3NNHyKel4sZD1O82M/3SlHoLcP1Q6zw1ayLrO4zlRH52s0AEIZmWwNLePAHRLRHWKY1acZ/oAD3Qvwid+NZUkqA9ycgKjAVA/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025497; c=relaxed/simple;
	bh=sCEYRMUg1E3r/uJti9Z4ilk10IVUDfZVyRasAPwIsdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNKIwbuLQ+yqsM0zwIjvIf+fj6M/+dECwlCzpuaG7BmIpw2d1GG7X83/rup6QQ9V7Z9xBcM17jRp8woaUsCFHtLpk4K9VDlOMzkAluotuwqR755bbJmrZrYwYxBlTV3lNjp2XEBqMd6ckdLKjlKnew874t+xzIvRWQgmAr9JtC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RyRSehtN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RyRSehtN"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f457853950so1476209b3a.0
        for <git@vger.kernel.org>; Mon, 06 May 2024 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715025495; x=1715630295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AV0Sd6yAIcZEMGBWFTXGGOrgmGYv+BoyEaX21IePpo=;
        b=RyRSehtNFgtdyBKAQG5aI4tuIdpMmeTKVlVYyx5N4J75QM3dDRSL7k/dRXTZUX6ugm
         obhAbWd3MFH0iFS/uqnY9KjnV11bNr6Bg8qpaMK+qRxwG8ijsU3kPWb4Zz2i9Tl7qitQ
         p9xQ+HlswVYZzU/HiS6GP+1Ld/jurVXNQcqp7sVYZfLU10GSL9dGBxAIPNw4trPEqEob
         Z+CN5aIAHIvTJrvZIJSo+tdMCaS3ZhtbVVy7laFy4MlCZaUYpaSsKF33pZdtZoV0La+N
         SuGEJfVByJKPow1HM5JzQO4GcqoRCQUy9RCj4G4/Gouu+kMy8ost6UHPBl6mcjiPVy/D
         4njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025495; x=1715630295;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AV0Sd6yAIcZEMGBWFTXGGOrgmGYv+BoyEaX21IePpo=;
        b=eA09lAErgOo9xv9hm04h+NsYXW2UtMiqu0kVkbeNLFhmI5PsrsLqHpY4wpJ0E5fSrr
         NxfdLsmIN2mVJSWpvJ3R8fvG/xtviaKQ7WvxW3lRCFOgCvvQ6OC3t6HfQErl8CDGyyDe
         bfmD815d7MoLrgQuuJ2VwqJHA0m0mbcCn8rQnwkocnsHhMluzPh9AMF5r5xx8atRM18F
         HUUr4rgPd7hLMLq6fXNSL/Wr2gCpI4hluGjnYZoE4IwhD4NfYObvH4tTEwLBbaLN0Y0f
         7NRW3m27ZkAxvE/JuSUJEEgJkurzyyjljWzaa9KgNBrzZ6nIvgtR6HkUqdOKDJ6wFmP5
         8ogA==
X-Gm-Message-State: AOJu0Yw5F09VvEEuKqHnV6bw7HeXmL4Hy5wDr3fkYOmguaXS/JG053hX
	ZeblacR4AWNqaJ5SwsCNh0At4FfEJqRpArTuj6rx3YqF0XqX//wn37+E+bYuDxpw8G80YgbXIu/
	nrg==
X-Google-Smtp-Source: AGHT+IGywl9pjhfcvpF2bOZHLLsWqPoFAgpEEP4XkByQw0KrcD1B7LfLKnWJbcz3FrtzA1xeEtcDVg==
X-Received: by 2002:a05:6a20:1014:b0:1a7:8828:bca0 with SMTP id gs20-20020a056a20101400b001a78828bca0mr975903pzc.3.1715025495003;
        Mon, 06 May 2024 12:58:15 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:cf3e:6b4e:994:dc81])
        by smtp.gmail.com with ESMTPSA id e2-20020a056a0000c200b006eb3c2bde43sm8069141pfj.205.2024.05.06.12.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:58:14 -0700 (PDT)
Date: Mon, 6 May 2024 12:58:09 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v5 6/7] t/Makefile: run unit tests alongside shell tests
Message-ID: <pqtplukr2sni4vhgxjfr5u3bsoinjukopggktzgfvdzpceibpm@judi4dfpaz3h>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, peff@peff.net
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1714506612.git.steadmon@google.com>
 <c6606446c47a7f49007e058e9ba84025919d86c4.1714506612.git.steadmon@google.com>
 <xmqqle4uy328.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqle4uy328.fsf@gitster.g>

On 2024.04.30 14:05, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > +# A simple wrapper to run shell tests via TEST_SHELL_PATH,
> > +# or exec unit tests directly.
> > +
> > +case "$1" in
> > +*.sh)
> > +	if test -z "${TEST_SHELL_PATH+set}"
> > +	then
> > +		echo >&2 "ERROR: TEST_SHELL_PATH is empty or not set"
> > +		exit 1
> > +	fi
> > +	exec ${TEST_SHELL_PATH} "$@"
> 
> You want to be prepared for a path like "//C/My Programs/bash".
> 
> 	exec "$TEST_SHELL_PATH" "$@"
> 
> > +	;;
> > +*)
> > +	exec "$@"
> > +	;;
> > +esac

Fixed in V6.
