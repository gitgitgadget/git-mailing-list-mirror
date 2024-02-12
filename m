Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBD54F5ED
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778245; cv=none; b=FYrVlZrXZecxa32NICSdzzl9b4/rZHYoW2lIyZq0kuZgyrMruObBW48z/fg8WrAuVPBSkoQrKQj/TVP0M98QJB/6yiBPTBr6H1j2p6hisiyguxPyj6n5N6T2xBIhmZ46091fqDPvgOssZuKqgOCAV8gFvLX1LNF0KA9rg6NLYwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778245; c=relaxed/simple;
	bh=EVIyYbdFSEifal8YiexIgbSOqCSfvjVawBFrBrTINrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqsqAsF7ln+E6dIzU0c8p+5CK0oE19Nr7yGeYh57C8E+wRwjJEE5pe4lHUhNOPiYg124oEA6TYi/3cxmBaEmpWRM/xNXBCHNVy/hzM4uWa/tJGlrcFA2K6Er7dKMwRT714NkoLB7r0jTJT/b94h5Zk529Kz885OQRd/wXAyL08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgYs36RD; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgYs36RD"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bd72353d9fso2794236b6e.3
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 14:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707778243; x=1708383043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5XOctrhh6DEAOBPSbWcMobfnFWjkOMcUPL0eEmX5yQ=;
        b=AgYs36RDXgloolMTUHGbs82XhJ6Syc0ELFOVYsHqMf3MDELOfocK9tyWPQ326gg1+d
         eYZ9qliZErpRpiAdg8zRAO3cdZAMa4tIiPGsDKZB1G1Y41EQanz+lgf8H7JjbB0+E0UM
         0fjKFNzpkVI6M6nLIMY1pRavT3506LCCTAgobCKyVc+brYnbaEFMLQ4jzoULvlo9sd+1
         mOtajBLKpv0swq79zfWozxvRw9hbdlopF7QLHkt94hnpBbS90RL4jOHTEkU1uQwfp2yg
         WZ3v/beLsfSjFSVBSVGtEH5O5ADVFHYx0t2E7yMGjVxpy9XJ4ZuHaFoKo6gj80TabZTW
         DZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707778243; x=1708383043;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5XOctrhh6DEAOBPSbWcMobfnFWjkOMcUPL0eEmX5yQ=;
        b=LXtiRvFpOu3ge/rSb/UaoLzriH0EPybS20n0QwbIqMBb7lst0Y7dwtYBx4q5KUge6H
         UpX4AGaJcayZ5+Il0Ux/j/W8zKR1zpDNh/RaC/YvCiVc5dczQ/KHlL1V0jZMPDToefkz
         kbPHBbxuwOkYqgEVTumA7zaHPkSuw853hH4pc2MEWkBOXKFrLszfgExpJ9e56UnHvui2
         il/F2FzPGwuPRk7jvD7HtEDKNzGohl7GU3q8L7ZK1OK5UZd+a90ELkmOqIphkmwFQEWU
         YD9QpsG8hVcYylZ3qMRboSiLFv/6bCujLwBSum60mQlTkcm61HY0DDcQrz3BqUzn+H/E
         +clw==
X-Gm-Message-State: AOJu0YyRYKC7A4++WEjekBEJk2t/F2ZQUv5eF91YK9t5EwyhDNJWY4nB
	SB80hSe+jQoBAwhAl4X6izjOsYZXqLntf5jNFfMe5wFKDRRtROgqDpT+DUalGg==
X-Google-Smtp-Source: AGHT+IHC3//iWxl8cz1FFYkJwTc8rY1s/3/7jHzHenMxyqwvTp8nSy8bzCh8oG7qxGZ2uJpJa201Mg==
X-Received: by 2002:a05:6808:3c98:b0:3c0:4057:1282 with SMTP id gs24-20020a0568083c9800b003c040571282mr2377603oib.34.1707778242885;
        Mon, 12 Feb 2024 14:50:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZ+aL4XWX5/os5GTUDkXoQUp2x06AC+TqCXAzS+oDzJlDU3v24ivxcm/pGqFZvdJATKfqx4v/ZgW6zWes0NzZgoF430Lg4RIl4cqaOs25st+YDdcGlyXlG3Zqfy2rVicJMH6e/DBiWSoNkR5aXW7fZud4x0s4=
Received: from google.com ([2620:15c:2d3:204:a710:9f21:f1bd:da22])
        by smtp.gmail.com with ESMTPSA id z16-20020aa78890000000b006dff3ca9e26sm6082545pfe.102.2024.02.12.14.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:50:42 -0800 (PST)
Date: Mon, 12 Feb 2024 14:50:37 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 0/6] test-tool: add unit test suite runner
Message-ID: <ZcqgvRXG_rgl0lpP@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1706921262.git.steadmon@google.com>
 <xmqqjznlqt1k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjznlqt1k.fsf@gitster.g>

On 2024.02.03 10:52, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> > * We should determine whether it is confusing or otherwise harmful to
> >   people's workflow to have the unit tests run in parallel with shell
> >   tests when using prove as the default test target.
> 
> I do not know much about "confusing" thing, but if the user
> allocates, say, 16 jobs to run tests in parallel, and one of them
> drives the "unit test suite runner" that wants to do its own
> parallelism, we'd easily end up busting the resource limit the
> end-user desires.  It does not necessarily mean that we should limit
> the parallelism of "unit test suite runner" to 1 under prove, though.

The current `prove` helper script does not do any separate parallelism,
so we are fine in that case, and the new test-tool runner does not
currently support running both unit tests and shell tests in the same
process, so we should be OK in either case.
