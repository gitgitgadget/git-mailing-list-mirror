Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3534137776
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137365; cv=none; b=IrRFMAicSIatv8BcS8SFx/W/k0Kc53qIgG1Spw0Ko0hkxHUAVBY0glpTC2IUhx143NHEwVUNBaEAAK7EO6Vq0j321KZnLot4ugra6/HuuUcjHYCM0d0ogKh3ouZsEXfmEb07RqeG3CpeXM5nzGrwoOSZJ3/ucWiZaUcJWKjxV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137365; c=relaxed/simple;
	bh=6GN2WhdzHLN/crYvgaEmFtclEQLEqtmyHBuAlM7CIXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnmEj8m4C9a6Vdp9Q+r7kmuqsYvj3cKCA+a96n2Ejsr1FVTg+5nDq0Sbz89Mn/0wSY/mEyH1sR2TvglB9gpyr/FlmGKpIjF8O/GAdZOC+RPY2TOk8SJamoLLMGsm/9bC4O6gKO1Si7qCns3YtrIuBMbKXIOrPZS0ERY2YsKRQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQu6X0XB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQu6X0XB"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc47abc040so10032555ad.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723137363; x=1723742163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNtlY1Cgv/UmaCv1neSykJ2ZvjcwoxiyxLhZXHna4+s=;
        b=cQu6X0XBMN1Zl5X98rQ5Hn0+PkEuWYLOFr81Qu3BB2qhkeR0Fu/YrDDes60vMFuq/V
         yX9+YELDrhJBRMCzidQzCHZIgHzYd/19NzIHRvamVPwFJ2QMuOVfDAo1aF4I7TipJZ65
         55diUboInlxsxq+x5p9Iy1rWqC2pBz3J+QI+pL7ZmHi0uc59HcsBGXfQxxcN3j4188w5
         /DJT/5v46vMRI9RWhArkLhMmHV1MR+hOVk3WRsRRm9hG5D1j57Hmsus+0RIuyi5K3Dae
         lidCcK56FFNV8/N4kV+DIXPRZ9W7DnONGE1aRbVivImEaw+Mp6JXmNc60Z8feubreWd8
         LWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137363; x=1723742163;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNtlY1Cgv/UmaCv1neSykJ2ZvjcwoxiyxLhZXHna4+s=;
        b=Js6SQx0JfGTd02TBicu8kp0yqEwMO2iJFWhx0FmF0XJZjN0EPq8nktGy2iVWRuFXIs
         4ito3/nr/UY2mXDZPXP/fWrcpyHdeLHlAyxs5nSBixztVZ8N5rFAOTCVaRR3JqO+4jTd
         zbl1xbFlkaYRpzcGR2ve5iRsjDMWuEMVzSiqRDbriR4rVd7Tm0Q79auHp9t5IPCrPojS
         dLVUs4q3EckYX/tLxIMI4qT3OdeGxyzYbcovNkp6//71SYHDpmTtEH1w6DxUpkf7np0x
         2eyRJ1RoP5SzD90B9KE3jPgx9ygL9rlcTQpe68AUuFsBdQ3NtVKejdM851qwjpKaiCwj
         +oWA==
X-Forwarded-Encrypted: i=1; AJvYcCUj2qNaRRloilJrCfr4C6V1Ou2sKwaBwnZiXcwIeR+yBpfA6yDj1u/6Me2R5vwqW0+IA9ZGNaYQEgrBd1rtohqnz6uT
X-Gm-Message-State: AOJu0YxL3+YibzowMlyi8B+BBoQbwka13RxfhrRhDaMihDVl9imQPfi8
	oj1onKEc0RBC7Df6/feKO7zyPBHIwEwnngfZ+ZTtVutL9dUiofqhf6ZCu8mzIQ==
X-Google-Smtp-Source: AGHT+IFotwY9T0dmYTw0HqLbJcHbVYHPRU+giFPt4Yy3immlzx5hJdmE7fAxjY+LCQ2MKY6yxjAgFQ==
X-Received: by 2002:a17:902:db09:b0:1ff:4a1e:865c with SMTP id d9443c01a7336-200952d1bfdmr32568155ad.29.1723137362642;
        Thu, 08 Aug 2024 10:16:02 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:fa12:a76d:ac7c:e104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905f9b9sm126337875ad.130.2024.08.08.10.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:16:02 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:15:57 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for
 libgit.a
Message-ID: <em2spwpn4c3uzi2v2bnwn5y34vnmjkkajlmhkqmyjf547q7xgy@m2d4y2z4yypl>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
 <ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net>
 <b5epjlsptw3punygmx2abmfnrkki6n6ta4fk3yse7iodlabr63@zss4z3575r7v>
 <ZrQJe32sYNOTSJGf@tapette.crustytoothpaste.net>
 <xmqqo763lppr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo763lppr.fsf@gitster.g>

On 2024.08.07 19:21, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > I think if we're going to be writing a general purpose API for
> > libification, we probably should provide free functions.  Normally, that
> > will be a call to free(3), but in some cases we may need more complex
> > logic, and by providing those, we're making the API more consistent and
> > easy to use.
> 
> Do you mean that we should have variants of free() that are specific
> to each data structure?  E.g., Patrick taught fetch_task_release()
> to release the task structure itself, in addition to the resources
> it holds, while renaming fetch_task_release() to fetch_task_free(),
> with ff25992c (submodule: fix leaking fetch tasks, 2024-08-07), so
> if cgit-sys wants to expose fetch_task object to the outside world,
> the consumers would call fetch_task_free() on it?

Yes, although hopefully the higher-level API we build on top of cgit-sys
will be able to hide this from the Rust consumers.
