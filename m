Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1AF158213
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698379; cv=none; b=EIdbng/wFZkvKkWMvYS/kXfk9vi3ap9JmdAeUaQSvwLkZg7N/YMfeVRaQ4v/iI0Ng1JXzmqAGhQKNW2Beid/F46G1P0ZIwwNyZ6gSroEgFouMsaLlyTssQdPa1+0wJSQHP6YVnnox49CHA5rBBAFf3O9fjI4T3XbYTeHYZxdQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698379; c=relaxed/simple;
	bh=+oXuoY+G6dE1LHpkQcV6JPcCNAp8SCUsNz2ffQBXgg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6KY49l38U1aE1ndZg/SxLmpewiK1MXWUpZBBufMSaJgfRI1UAYiMsq82E3c4T0CQokFxA/5ufAqpz5Vsq8BMhBmqvzESpe8c27/jDgx9taEEL6HNOdLt8ddslzwx1l/8aGkLVefomqSagH6y6V84hyO/+t6sH5wXOJDQsxqsAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujGO2bbV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujGO2bbV"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ead4093f85so4982490b3a.3
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 14:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712698378; x=1713303178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8gP4aXbKqt2HQa9W26EhRaOu4kNpyoolhfZ+wJ/KBE=;
        b=ujGO2bbVI/y3ecCF6P9s5G4JuCN8HdAVV3djl1gZdVFxJzfuUkciAbWtr8BhWaOnQR
         rXAbiQ6WifqStiQcFJpoZF55h7OMwGfTQF0nLHWGJ4w3qaV0ZXgvryX3hlTooMOmidzI
         pf2no0K7f26yMvqF/vF81pv7aN70QFCmLzQ9YmHkFRno7dkzxKdvrZ7csIBeM3j1vABb
         H4lJYtgxKkkV4clVEZVwQNEveKS47bzEDO8vf8u0QvA/qOTCGfNcC+q5adqlkkbcIcWB
         1a9N6V0U4IH0Rm9/GZmXVo8kF7OjGBPKrY3r4+adj5OoA5ziGcsgUJqckteBDD6x24Jm
         IENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712698378; x=1713303178;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8gP4aXbKqt2HQa9W26EhRaOu4kNpyoolhfZ+wJ/KBE=;
        b=KStz9dopx66oqxFaCVWO04HYGv//YUN6s8fB/EODriwnLGuyJgsduiUFjrvc6bdhiY
         9BmH//iKdrO6urcVOGbaS25QXYc0083b9SqzQAQlphhXKt9okujf9PNUwQsqrzA/Xoqe
         HguFiXL7f3u86J4dedAsq/RLnL3NhEDC/jpFE9CKrEnNTMKbLHQpKgx0eTy9tzKd5b4D
         UhEcZr98CiHDxTXcF3EErMWXpXqJkhdJp4tAAMx3UYfMSpxOy897ggNk0YkhE2tY/RvI
         CQc6RUOGo2qNTEazMzA1SGLP4NR0TD/BDZhXIb2RntYonHrwm7Hye4eCd7N/4lQm70hX
         Cy+g==
X-Gm-Message-State: AOJu0YwRrdhNPaRu6VQ09gNlTKZga+JIsedG/ZfLexuXVtCbTCKfAdju
	DqLnzEstZOQu7ZgWceYr86gqhGyCgRT6WxduYnYeLz6W6/OjwX/Vcj4O9Cfd9qsYmAmdpsMVRF9
	y+g==
X-Google-Smtp-Source: AGHT+IGTuU/2iur1tU8mMqjqghmdZcvh5pSVkJlIQBRFE/yPYGGZ4fwqWfZNakAnglvqHKua+/wKvg==
X-Received: by 2002:a05:6a20:6a25:b0:1a7:5bdc:774d with SMTP id p37-20020a056a206a2500b001a75bdc774dmr1451239pzk.14.1712698377622;
        Tue, 09 Apr 2024 14:32:57 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:4457:b729:59d8:3a21])
        by smtp.gmail.com with ESMTPSA id j5-20020a056a00234500b006ed26aa0ae6sm4987376pfj.54.2024.04.09.14.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:32:57 -0700 (PDT)
Date: Tue, 9 Apr 2024 14:32:52 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] ci: also define CXX environment variable
Message-ID: <ZhW0BOYHyPkZbgbd@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1709673020.git.steadmon@google.com>
 <75f98cbf98005b0a069977096ec5501f2f7830fe.1709673020.git.steadmon@google.com>
 <xmqqv860z7fv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv860z7fv.fsf@gitster.g>

On 2024.03.05 13:37, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > In a future commit, we will build the fuzzer executables as part of the
> > default 'make all' target, which requires a C++ compiler. If we do not
> > explicitly set CXX, it defaults to g++ on GitHub CI. However, this can
> > lead to incorrect feature detection when CC=clang, since the
> > 'detect-compiler' script only looks at CC. Fix the issue by always
> > setting CXX to match CC in our CI config.
> >
> > We only plan on building fuzzers on Linux, so none of the other CI
> > configs need a similar adjustment.
> 
> Sounds fair.  It's not like we as the project decides to never build
> fuzzers on macOS and will forbid others from doing so.  Those who
> are not part of "we" are welcome to add support to build fuzzers on
> other platforms.  So perhaps
> 
>     We only plan on building fuzzers on Linux with the next patch,
>     so for now, only adjust configuration for the Linux CI jobs.
> 
> may convey our intention better to our future selves.
> 
> Thanks.

Reworded as suggested. Sorry for letting this series sit without
attention for so long. Will send V2 soon.
