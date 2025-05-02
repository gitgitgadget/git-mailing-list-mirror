Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C19223DCF
	for <git@vger.kernel.org>; Fri,  2 May 2025 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229475; cv=none; b=j3/7ytZZZiATYYxYbZfc8GMHgZnbpLVwkwH+PAU7D+2Q3Oen6gdTL3N6S6LFmMu7Q+IovB1UfTPlTGjr3H34FpsbrTqKYDmUEo71gLMnRsXEZiM6Wxfl42KbX2c5a++TvE6qhcOTwZrszaPiPnLw//peYQa7U1wCRX2rt4OYUNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229475; c=relaxed/simple;
	bh=niwC+HWBjmsU3YqRoKDd+RpiSY6wEe2RN3Mqp4KEtSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmXxdqUB0KdOTqT692KOJCnkmRdT7mLlbs7iW8UifR5DpoxE0oH412enMz49hku2KBCZkFaOlLLypaQ1l/wRplAl0npX8vnrt1YuwFyxRVUT/8K891PbwU9fUrB1H9kLxEWqlJwFU7woY+cm4PsYhhGMsmnw3Ek0dH4c3IkR0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qZY3/DfT; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qZY3/DfT"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ecfbf1c7cbso49442806d6.2
        for <git@vger.kernel.org>; Fri, 02 May 2025 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746229472; x=1746834272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqXQ0+cVRPhjWT8NAwXjQ/D5SBNnAIIBZR7nkRrEdTI=;
        b=qZY3/DfTd5d5GzZd/1VPszHhs/urh3OtINbeXkDmINSz2w3QNA9vdt9OfjzHir5Ern
         3S6xGMKo2rS3oQfa8V8Y23aIvSLtM8oxyLEVpZaQAQClNG0x8ykYT4WAbGUv43CAH+CK
         HUS8H6UcjtUAti4nUbG2pKC8ca+JznqNj/0+gLNiIdEHWtxO3zgt9WUImjVY+dMhzckt
         ZK5KSZbBZJ+Rt9bIys/GY6goAlsEhOWpwa1WJIM74elphnzMKW0/RI+3TdR+zZ+qkT0V
         Upo42HPKBpz58RXaGbvQ1SjMSVl8fRhiTyQltCxEgzMu4fJyszAtlUUQzXtqApJjAVe+
         qKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746229472; x=1746834272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqXQ0+cVRPhjWT8NAwXjQ/D5SBNnAIIBZR7nkRrEdTI=;
        b=VR3GLFgZqvDC1a1vT5mne6Lzk0vpNktsTY+rPRhv9ZAdVHclzyAg3AQV/Erm7I4A1G
         i2esL3BLTfHoWpoR5LQ+dyjoXWjftJYnN7+N3O+ZePMG1GAX1MudQnMiSHSKgd7/IAgp
         pMfnuZTNhibjLgde9fz3tjxPPB9L7Xz+azsrgdRY5VU/hX9VUoWG7lVjlPnogHJMiC3J
         EyuXE5xMckNPR+nKME22EePff5M6w+NMK5Vnp3YLHuKkamEf+HXjCapBeSxz0DjmHoPB
         /afjtFtMvdSFKrtfVfEUdccFlv7iQHMtZw93iO3zqBJf/pgHFuGW82/MyIrQ8FgQKsKj
         hOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXHv8LWq7oOyJ3j7mLriEC7/U08Tquvpy6qlUhpFLLddTMvpQS4AnrMhEt0RzXteaXu7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8NssDvrhAB8454ybh8X4PIwBECdtzswIopDNA5FUBd9aNVYAw
	jspxGiU8JS5yojCDTXTgzrp+nAPWTUHYk05qugUuIJDy8BRtJ31zpZweC8qc8XA=
X-Gm-Gg: ASbGncsM5kC3WPC1dWHqBBlcrwYxz7Cm3c/iyXHsHlIGDNMa2eRMNPcQdobbKCHsqb7
	+1Bn+Psg4GI/YkL9rmI9zFUdINg99D3ne8KI0AEa51p21HySTaFsjGlYNhQerynQUAlbtvkyF41
	O1bpQoo7JyDXlO1ytehPdGZ8MVyheu1sgZUaSp/HXEyztu8JyXIhSScKMWWDmG6+aBUCw44bRPi
	qrd//BY7o3gDDjnUA3SA3n02NbkdwtrX5tRk8Ca1bqbqsoKK088X9wU+Zt9c1LesPuTUxAhmKPV
	+yd0a9wJZNHMpZbSEQUchFyvbvRMmdJkdYvE2RSXcNV026N0bFpNh+daDiv6PB+XayJyZwBst+s
	FhHkZu4Z6AUiV
X-Google-Smtp-Source: AGHT+IGAYsZmTM8Ns8A2POIB4BFjSgyPhSQlgjFG/7enFGhQYfRFd0bCOSAAAKuCTDU/pY0izIEl2g==
X-Received: by 2002:a05:6214:d01:b0:6e8:ff2a:a658 with SMTP id 6a1803df08f44-6f5152589c7mr77526496d6.5.1746229472245;
        Fri, 02 May 2025 16:44:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f50f47e8e5sm25006086d6.99.2025.05.02.16.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:44:31 -0700 (PDT)
Date: Fri, 2 May 2025 19:44:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 00/13] PATH WALK II: Add --path-walk option to 'git
 pack-objects'
Message-ID: <aBVY3u58R23bI/Uo@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <xmqqbjsau2nl.fsf@gitster.g>
 <aBVLC57bMJKjygyi@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBVLC57bMJKjygyi@nand.local>

On Fri, May 02, 2025 at 06:45:31PM -0400, Taylor Blau wrote:
> On Fri, May 02, 2025 at 02:24:30PM -0700, Junio C Hamano wrote:
> > > Updates in v2
> > > =============
> > >
> > >  * Re-added a dropped comment when moving code in patch 1.
> > >  * Updated documentation to include interaction with --use-bitmap-index.
> > >  * An UNUSED parameter is now used, reducing the use of global variables
> > >    slightly.
> >
> > The iteration saw no comments from anybody, so I (naturally) forgot
> > about it for quite a long time.  Let me mark it for 'next'.
>
> Sorry, this fell off of my to-do list. I don't want to hold things up
> further, but would appreciate a chance to review this before it hits
> 'next'.
>
> I can take a look now.

OK, I was able to get through the first 8 or so patches in the series,
and left a handful of comments throughout. I'm running out of time ATM
to finish reviewing, but I should be able to pick it up next Tuesday (I
am out of office on Monday).

Again, I am sorry for the delay here. I know that I am holding things up
here, but this genuinely fell off of my radar, and Junio's nudge above
reminded me. I'll finish reviewing this promptly next week.

Thanks,
Taylor
