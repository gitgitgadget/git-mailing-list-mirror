Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A8D137C2B
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211341; cv=none; b=lVZ004agN5azHb69TdwahklOB41YzgtRhAbxjWFSLoElkV6gYPIj64D8fN6Pq07JanF5Z2jVP3UGypkZFHs7ovD/PjRghRExKY/17lBYGKItoPJ63bc8YqMWr7WnvLv6RUvcmMotZQCOfhsai9ouXpOqCq7jGinSh/mYkNytIuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211341; c=relaxed/simple;
	bh=fw7yn3dyGAsgTfl9KN8iUBdleDp/1XPSzw/CnB34/r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okwK/Pv6u7RHDE1sZ4JUFVjFhOQgyceoqTP/zgXx27TVsLBOJ9WCxUAEMDx5Uzl0Pkq+PiQqy5IxLJHF0qbvxefPM7LqgsAZfLP0SRjAT9obCv/tiNvo8BTbrig4Gm1F7k2w0AibfCJ6YAud8cgJGv6nnbEz2UcBo7LYACUVfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3TdMSBQd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3TdMSBQd"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2906855ac5fso3341401a91.3
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 11:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706211339; x=1706816139; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dCuoeeo4+MA9z+5sy4BnFvdmy5yJdcwsj/HXsWNOjAU=;
        b=3TdMSBQdpzPblcUeQypSuMWhVjQOtdZbkZoMlaas11bSdHvHzTmny/8Y93eve50613
         sgmVEE1CiyXGzWfzyrzfGE97vgORp6onOAAEqF6o924FrS/BDGFXW1O7t9WIP/7Dnyja
         lIlDSLlgvnj7LD/IUNPH610nhAvllSHrCR7NGHkStdeDJuBU8fmCJNHoaVZS5PFveX2i
         qru0f1x6keJEoioAg8rkNNevSxdei1+0ne8XlUsdkeOJSpc8U/XCSoNLiUcMKGSxHYbR
         D/E+gTggggqe2pDK8EK7Ji2CqbJRd+2h8f/PJFX2QCmnZXX0Cj5y6x+9agbIzQR6eC5C
         3LWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211339; x=1706816139;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCuoeeo4+MA9z+5sy4BnFvdmy5yJdcwsj/HXsWNOjAU=;
        b=l4StyvpacMY141Qc/CrjyLbuU9Z0The99vEbJZ5nSMNR+z3u8m7+JQHwgmiIksyZC6
         TigdouyiPL+DkRGsbC5OtO2v42r/c4Yz/bETZur5gaxLlz4vspepkCItwA4nz4/gDolI
         0bW5w8t39F+M1KGGhtwKm5NJ29zZaisKH4tleYaXDuT69UHOOZM4gWJM+LjoJl04eeN4
         HPkQ1Y+U0jdzhaMpm5k7JLW9TkrBCJXSS5T0Gq7n2SkKMIozrdP79khfmWgGjt818irM
         NeB4PtIukW118+83eWZyF+19CWAPPQ+2JQMbfsMFWyyxoqKzs03jLbp6eNdT6QedQoVb
         ARNw==
X-Gm-Message-State: AOJu0YwEYzu7Kn3mBFh4EXXX/wHlarNTESanneS51F0FmIhFEt2JQxFi
	88YeW6SyrS0zUklb+zbldXvi0XvKQdxDm4XGL+R543vyh+Gzc/MGRcpo7YKCEQ==
X-Google-Smtp-Source: AGHT+IG/wIF9nc2NT6p7n3Os4VUxghDvFUfvorAVzCbjd6rARVwRWlDLQLT/tIgWnmJ8zCcjpkilmg==
X-Received: by 2002:a17:90a:1108:b0:290:329a:a666 with SMTP id d8-20020a17090a110800b00290329aa666mr93717pja.83.1706211338803;
        Thu, 25 Jan 2024 11:35:38 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:3af9:4e62:3075:ae82])
        by smtp.gmail.com with ESMTPSA id gn20-20020a17090ac79400b0028cef021d45sm1964068pjb.17.2024.01.25.11.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:35:38 -0800 (PST)
Date: Thu, 25 Jan 2024 11:35:33 -0800
From: Josh Steadmon <steadmon@google.com>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Linus Arver <linusa@google.com>
Subject: Re: [PATCH 06/10] trailer: make trailer_info struct private
Message-ID: <ZbK4BcESMfljw7Ym@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Linus Arver <linusa@google.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <0cbe96421c7bf573e8ddc97b2a0aecc894095399.1704869487.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cbe96421c7bf573e8ddc97b2a0aecc894095399.1704869487.git.gitgitgadget@gmail.com>

On 2024.01.10 06:51, Linus Arver via GitGitGadget wrote:
> From: Linus Arver <linusa@google.com>
> 
> In 13211ae23f (trailer: separate public from internal portion of
> trailer_iterator, 2023-09-09) we moved trailer_info behind an anonymous
> struct to discourage use by trailer.h API users. However it still left
> open the possibility of external use of trailer_info itself. Now that
> there are no external users of trailer_info, we can make this struct
> private.
> 
> Make this struct private by putting its definition inside trailer.c.
> This has two benefits:
> 
> (1) it makes the surface area of the public facing interface (trailer.h)
>     smaller, and
> 
> (2) external API users are unable to peer inside this struct (because it
>     is only ever exposed as an opaque pointer).
> 
> This change exposes some deficiencies in the API, mainly with regard to
> information about the location of the trailer block that was parsed.
> Expose new API functions to access this information (needed by
> builtin/interpret-trailers.c).
> 
> The idea in this patch to hide implementation details behind an "opaque
> pointer" is also known as the "pimpl" (pointer to implementation) idiom
> in C++ and is a common pattern in that language (where, for example,
> abstract classes only have pointers to concrete classes).
> 
> However, the original inspiration to use this idiom does not come from
> C++, but instead the book "C Interfaces and Implementations: Techniques
> for Creating Reusable Software" [1]. This book recommends opaque
> pointers as a good design principle for designing C libraries, using the
> term "interface" as the functions defined in *.h (header) files and
> "implementation" as the corresponding *.c file which define the
> interfaces.
> 
> The book says this about opaque pointers:
> 
>     ... clients can manipulate such pointers freely, but they can’t
>     dereference them; that is, they can’t look at the innards of the
>     structure pointed to by them. Only the implementation has that
>     privilege. Opaque pointers hide representation details and help
>     catch errors.
> 
> In our case, "struct trailer_info" is now hidden from clients, and the
> ways in which this opaque pointer can be used is limited to the richness
> of the trailer.h file. In other words, trailer.h exclusively controls
> exactly how "trailer_info" pointers are to be used.
> 
> [1] Hanson, David R. "C Interfaces and Implementations: Techniques for
>     Creating Reusable Software". Addison Wesley, 1997. p. 22
> 
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  builtin/interpret-trailers.c |  13 +--
>  trailer.c                    | 154 +++++++++++++++++++++++------------
>  trailer.h                    |  37 ++-------
>  3 files changed, 117 insertions(+), 87 deletions(-)

Looks like a pretty straightforward change. I think the only point worth
discussing is using the "pimpl" idiom. I think it's harder to see the
value because the trailer_info struct is fairly simple, but I can
definitely see this pattern being useful as we libify more complex parts
of Git where the struct internals have more complicated logic involved.
The pimpl pattern also seems like it will force us to think harder about
providing a useful interface, so I am in favor of using it here as
practice for future libification.
