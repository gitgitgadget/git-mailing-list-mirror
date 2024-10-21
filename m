Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529C197531
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527899; cv=none; b=TrEz7cfNMZdDYwZjobd2ig8tgyzTZK81bYoZs9a5zbt6Zq7c+zykarecguXqFu/rGgKNYrlRngP8htxL4EdHH1LJbF33brJZqgf7nNnxrLhX/Lb6T6WPm5FRXFrxtEfqVsLka9jb7Pcoqb0qXjzaMSD4X36sqNMmXm7ou3rLJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527899; c=relaxed/simple;
	bh=bjNLCuQJAPBLKuwEV82r+wJMMJQ0xsAZ5TPn7K0MHaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGgjahuj6KAYpmGRJkR/Lg1fhqJ7NETEU2g+osh1n7+lWRHJ5bOqfphsytnERtrra03AdzmAIP/KyypU//xBfgEmhfiClgl2eZQB/c1VTkU3b85mo54QSRZaHzrSyEhfQIKi00IsylKxkewK5f8Vskt6M8pp7CYwkq6i4iz4620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1KP/SJc6; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1KP/SJc6"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e290d6d286eso3659163276.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729527896; x=1730132696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kCwdOo1FYbozbxbWDdKGRFuSfRH74lTjTxsCCZlJFho=;
        b=1KP/SJc6CuhgltYq/R17XAaleqsOBRajFZ54lbjGrl/HcsZXa2oi0Ck9nn6Rx7H7p/
         Ju4kFSGctDHtFshC2TSG704xbTzy1hHCsMONaFJsFi9cdQaxrRALa+SbG0N/SEZZiMQf
         kOgoAn9s8a2havT4Ja2BdxBFVGiXs28crFoc/sASXXmpZA/z7uHTF3Cw+LSzjJ27h4S7
         3ptWbN3yGd/0u6U+4XJ5+BWWjsKzH7XP94YKP5K3hUXjOMIJeiJu8c5nyhJa75c5Soj0
         SwH4QvjF51hWe5SHM5zdZP8ITtJLQ9unPoYybASTpVke83RVaxWoW+7spWN/tgEWHC7l
         L9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729527896; x=1730132696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCwdOo1FYbozbxbWDdKGRFuSfRH74lTjTxsCCZlJFho=;
        b=ceCVgetNCGGxwj2CKRam9ugeiL43X1pvGKEc+ZVhcvqBbrcXR8QBYw3mS59AGOHHHF
         auhJyHYAWJo8y6E8Mmf5lW5MCEqtupTmgP+/EM+0S7APkdG7NrerZKvs2hRr+d3OgmnH
         vM8TqP3HXE8I/veNgiHownDslCOIqtbeBAMy2CXJqiFgZXvEvFHzVVUd4vmhh3+3c+sa
         pw4V1zlogndSc4GxQfUSmkfxgtmCqqMF45nzboNJ51lnXHfJ+jhzWKfIe4TBK9ZG8QVM
         khkzGpewglcvbk043ctEDmBftoJRtEAKeNX9qoaFQITpOG8LQlDLhQQ5UXwKFZ4ciuz/
         M9dA==
X-Forwarded-Encrypted: i=1; AJvYcCVkNrCDGGQ2ypxN0jOhw77TH8NdkZ8cTwAyDUvRdFuHxZcNoLOwiLE3R1G6op1a3mUrjuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6VwtUgydkdyovxpYoaIQDppPWcaFwUFMwTHF/AGY/hnP1QcB
	sNR9bUoKZY9Py1kzOOJpa9FKfhEWr7jlZiO/wZbF00xtGlcDhsD4PaHSY8oYT9H04yg+42fbhym
	F
X-Google-Smtp-Source: AGHT+IFw5T1/4zCy0ZHr+hf7ZAnsXsthrHK2XjR8AibBLwj0U2UPp+uWodtyj2JWH7pLQ3kV1SfKoA==
X-Received: by 2002:a05:690c:6610:b0:6e2:1527:4447 with SMTP id 00721157ae682-6e7d3a93386mr4563527b3.1.1729527895944;
        Mon, 21 Oct 2024 09:24:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5acfbe6sm7131407b3.64.2024.10.21.09.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:24:55 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:24:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] daemon: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <ZxaAVgJa1VCj/9Ge@nand.local>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
 <a333d8a40134f4a06812fdbf85c2b011e9d3e472.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHFY4cXQ1lA4QU@pks.im>
 <CAPSxiM_+4ZaaiyvWDVwXf3tnt08otsx=1dcJJtQsL7h59dO8kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPSxiM_+4ZaaiyvWDVwXf3tnt08otsx=1dcJJtQsL7h59dO8kQ@mail.gmail.com>

On Mon, Oct 21, 2024 at 01:43:53PM +0000, Usman Akinyemi wrote:
> > Hum. I think the test description can stay as-is, as we don't typically
> > mention all the exact details of what we test in a test suite. But I
> > also don't mind this too much.
>
> Ohh, noted. I just thought the test description does not have anything
> about merge.

Let's leave it as-is, unless you can come up with a new description that
is a little shorter. Absent of that, I think the current description is
fine as-is.

> > > @@ -8,6 +8,31 @@ TEST_PASSES_SANITIZE_LEAK=true
> > >  . ./test-lib.sh
> > >
> > >  . "$TEST_DIRECTORY"/lib-git-daemon.sh
> > > +
> > > +test_expect_success 'daemon rejects invalid --init-timeout values' '
> > > +     for arg in "3a" "-3"
> > > +     do
> > > +             test_must_fail git daemon --init-timeout="$arg" 2>actual_error &&
> > > +             test_write_lines "fatal: invalid init-timeout '\''$arg'\'', expecting a non-negative integer" >expected &&
> >
> > You can use ${SQ} instead of '\'', also for the other two tests.
>
> Will make a change now.

Thanks. ${SQ} is much preferred here, and makes the resulting test much
easier to read.

Thanks,
Taylor
