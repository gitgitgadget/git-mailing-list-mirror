Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029C01E866
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973927; cv=none; b=pWV31UFEsvQbUIictgr7C4+iRwASUxgwrRt8oc4kFQvpgWccBnNDANRwaRPVZsFaFzRVUG0kZQoes53i5tSVhum1j/ePE67tK0yZQ7Xc5k7dBnEzaA8bwrVsgpLFGbjB6KpGXhAwNCFbKFjMynPphJpoHLRzj9bGCl3yAtm0LQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973927; c=relaxed/simple;
	bh=/eSvgnNb5Sf1yaleHQC3vOvH6aUrVAwY4afJ4NwNbDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZhSf1o3WWY6Q3FsmypwhCPZCmwGMt8zRINPXzJ7Je7+UvQKgciKUmGEOAUzWrcU9pdx8SA3r11oHdc3dvLMybRiwT9uH53k+sHM3Z3Z6qLsY4uEfEWfr9jpTAAFruA7majGzYChY0ZHZy2/8DqrPWo1Z+8pW/1QZked2Oj48l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kF4oes1s; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kF4oes1s"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d3907ff128so2985642a12.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 10:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708973925; x=1709578725; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ErHLFgVQKmb5fZDO6eL2oYOAWoxzWyYjdXCXLWzXB9k=;
        b=kF4oes1sw/plYq6LexdFJ8eiVRoj/34Bjn6Ans7tLUdGYRw2tGQA4fjj0dbC0zcQkP
         lhhZS2cpvOZmr60VjUS87LMSty65a+3dxtOdl46FTMMb621Y+MJl792Tl+04//AV1jyv
         QLsfotwxBLT19Pf9DWPwL0efztn8u5pKX9Y9TZOWf2g7as2EgAKiE6zu6cN02vGqUIvY
         VVqA71v2zVKZaMUiLnL0AM0f5nNX0XCOcUMipT2PF1Qy7CxUSioPm3xCKIpOzxW/s+1w
         f8wYxkHNfTuLmMqlsGYpCPcApn6ht8/05Izy77Gb1NbA3taHJ6hBg9dpm3JS+RlDLapZ
         RG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708973925; x=1709578725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErHLFgVQKmb5fZDO6eL2oYOAWoxzWyYjdXCXLWzXB9k=;
        b=N72t9zgR3hI2JfXtxxVaVGPNFgFpBuDPJYVszs97NN+AsWV8PtB14dko+cw/Tb2yMN
         CPqCb8CwHaSTWJbllHJ9oOYWCOLYfovuDHw9+GkahFxfOfUVwqBG9gDeHiPZmAhSUY3O
         yPlAoGaaMtUdsjd54zcsPBj8IwQCPikiKj7H4ZZSIR6Z+NHj2KeV1osBYQ89Z/7YgtVi
         fp18A3vM/izFrXIfEKjw6kY5vDjDSoxmFalbulBkqEBCwRmGB/2aJwNVyWzd8EXbJKnh
         hvEPIAItIHyD1pzCBVe05Zrt27cDyHSaxQN81QWbHrv1g/42BRn2TXNeRJXu0hTtbre5
         yzNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaIWyJZZBJqMNIwkDFkBNfvbgkr4CUWFWqjEb4AjHkQ6vqrANn5ed9mpBwK5gVcLL1sTxOMBpcAF6RjihL/2ssC1e4
X-Gm-Message-State: AOJu0Ywly2V3yAcZeI4jTEdSctEyEFuwG6tFXuf8vhH8Iz0Bmz0ZPxu0
	12HC3QAlarTZ2z/hAG4nYk1jjZvFKm4B3P62tbGW20mze0pkV7eIWkgwNFdewV/ZSdbCtxZzC3c
	wMA==
X-Google-Smtp-Source: AGHT+IEk5vl7/+NWW62xcC8fnGI6A94GHMxqXRL76DXEOJRLHUDf+Bug/Z+NBI86Sa1JHhjCoT/mRw==
X-Received: by 2002:a05:6a20:c78e:b0:1a0:debc:e9d9 with SMTP id hk14-20020a056a20c78e00b001a0debce9d9mr10068pzb.47.1708973925167;
        Mon, 26 Feb 2024 10:58:45 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:40a4:8533:509a:9375])
        by smtp.gmail.com with ESMTPSA id e2-20020a63e002000000b005dc87643cc3sm4348927pgh.27.2024.02.26.10.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 10:58:44 -0800 (PST)
Date: Mon, 26 Feb 2024 10:58:40 -0800
From: Josh Steadmon <steadmon@google.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>,
	Achu Luma <ach.lumap@gmail.com>
Subject: Re: [PATCH 3/3] t-ctype: do one test per class and char
Message-ID: <ZdzfYPim2SP22eeS@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>,
	Achu Luma <ach.lumap@gmail.com>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240225112722.89221-4-l.s.r@web.de>
 <CAP8UFD0Wi3ot-t0Q7ruMauwj4zkMfd89Xr9SmxYa4eQ3=2VKOw@mail.gmail.com>
 <d96aaf45-f073-42d0-b69c-703393634848@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d96aaf45-f073-42d0-b69c-703393634848@web.de>

On 2024.02.26 18:26, René Scharfe wrote:
> Am 26.02.24 um 10:28 schrieb Christian Couder:
> > On Sun, Feb 25, 2024 at 12:27 PM René Scharfe <l.s.r@web.de> wrote:
> >>
> >> Simplify TEST_CHAR_CLASS by using TEST for each character separately.
> >> This increases the number of tests to 3598,
> >
> > Does this mean that when all the tests pass there will be 3598 lines
> > of output on the terminal instead of 14 before this patch?
> 
> Yes.
> 
> > If that's the case, I don't like this.
> >
> >> but avoids the need for
> >> using internal functions and test_msg() for custom messages.  The
> >> resulting macro has minimal test setup overhead.
> >
> > Yeah, the code looks definitely cleaner, but a clean output is important too.
> 
> The output is clean as well, but there's a lot of it.  Perhaps too much.
> The success messages are boring, though, and if all checks pass then the
> only useful information is the status code.  A TAP harness like prove
> summarizes that nicely:
> 
>    $ prove t/unit-tests/bin/t-ctype
>    t/unit-tests/bin/t-ctype .. ok
>    All tests successful.
>    Files=1, Tests=3598,  0 wallclock secs ( 0.08 usr +  0.00 sys =  0.08 CPU)
>    Result: PASS
> 
> Filtering out passing checks e.g. with "| grep -v ^ok" would help when
> debugging a test failure. I vaguely miss the --immediate switch from the
> regular test library, however.

Yeah, I agree here. It's a lot of output but it's almost always going to
be consumed by a test harness rather than a human, and it's easy to
filter out the noise if someone does need to do some manual debugging.
