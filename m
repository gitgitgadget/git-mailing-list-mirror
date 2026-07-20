Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582C3C2798
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590864; cv=none; b=T7QySFemNCsmbwMnfiT4jig0108HKgrR0iA553Fl5TgpbQEn5kTrZP1UB4Dj/KfTSzNqiL0WwZNyL0ythBWqWxCq2zF962XESI9PSveAsvCIUXNqaMmKVrPC9ZBVW0k9tLq2P23QWgojfaPHTzRmxtpIS67VT9jdKLw4SQ5SajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590864; c=relaxed/simple;
	bh=njoQ8mxrPETKL6iL0Lp7wOT7pcRjWFWq4scMi0IyF/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXGZpo9egvVfTOsbXNqskGXxoJHs8IYGzgyj/q8dHOP47bM17/7/YWAU9GdQxr21LwHm9yHGC/3MlUaJnNn1hJ5RgR/WYRoNOMf/fgRjipB0Ck/+5YOcxYlos8tkAy9WiBcmefMNbtn6hf4YCVozA0ux8Nf1g9XQ+Aa8UIGD63w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=KUUIdLjX; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="KUUIdLjX"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66810946e63so4825685d50.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 16:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784590862; x=1785195662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U71Bk1zzixl6uPFfR63kOY5ejhs6FsRSV7XIt9Ymug8=;
        b=KUUIdLjXfNSm+rzaVdc4p14K+2Jlb+JKdjcTYhjGdG/8CImmt2TkL3CLDHS5bcnLTr
         1kTsIY1Gre7V6iU7uPZEK+O/WipbEaEUEE5X5sGTqQmU1Avx/IjUtuJu9/V8yHeaHSoj
         +EFGfmjkcEICO/8eTcQJpJvlZochyUnTLkMmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784590862; x=1785195662;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U71Bk1zzixl6uPFfR63kOY5ejhs6FsRSV7XIt9Ymug8=;
        b=dJzWGSZ6k2VAXPihTQIRfwmrcn+HJeJGvY+BUAef7SGa19d5Xya+YCulBPh3i8vx1F
         K6LilHwdMaMdBtG4iiigaXmXbGoNNKyy7N9Buf5XIYB3hsLgG/K3cmiWAzlnj6mYxYst
         oDlMeuAnx/7u5dY6lox2JgUv8c3BvNLohU2e2KIXS3WJcPU8ciFS0CBbs25+ezOWPJ17
         3QKLgKZ75ZjmpU/M857wd6WGGyeLUZtO9qcNs2ZWqe+HYGe1kchmmEU2wofe1iOC+V00
         7rtwtIygPUOB1IH0cM4pvgAZj3X5Pi/nIUOSyJ2C2CXZx0irY+qK5BF99K5dwQbiL6cp
         DMDQ==
X-Forwarded-Encrypted: i=1; AHgh+RolABQGD59LmP7pIZqIbvXHUBC9W6cEeIt93Mw22zHktChcaLIV95dXId7PAxuT+S475eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj5CQci22+jAHouQFBAGrvUxEDpCSWfYFzt74bkLVusYE0jPGt
	NGp0qnGs480Vg2gDx8qoatN6+5uX8DhBb82qpGufXxE0wa7aa74YDMAzM2TcO/8BzTM=
X-Gm-Gg: AR+sD10DGfkatqUxvhumgTASfkenPgjcb0OXHGZCW2yLNfrChYgiLkgBiQ7J19U1eTk
	n5C2CSaZSXSdjL3m3Wmnd5Z5Op3l6UbMa0jQJJQUesZ8t3ynoYuIVe1OOisRVTxBbSKeQ2Z7WHC
	3t1nCiIlMbYzwKNJRZTK6LnLPerADal9c9uhcMTutpBBu304rdT/dwJLf8bvOhQCe45GcFvPMEZ
	Z+1VNQRHcj3HvDnJLy+x1bPiFQCFXTjRskzpVqBtddJutmEImI/qm6+DQRu3yqVnpyOadtkWU5f
	v77ZQ9hCtFQbTQtOn/JRBdW0JZTdGngJJB3yrULjGUZhExkHH3eKK89nbSugOpYwH0Vx00eaGLb
	DuU9nJ56L+TDbbpDxrpWhsSNGGkzwHNmB+DFfeToklXNFYMfs+hHmnWm0jM1xbw+vJP59hPFUwE
	ubz2CGouIFQgIMXOZ48nuk/R9sJM0Ad8v0G/LrwsXFB+ePrpQTDW20foOpU5ZjLb/Esf7bjA==
X-Received: by 2002:a05:690e:24d1:b0:667:ba34:51a2 with SMTP id 956f58d0204a3-6683bde9073mr3122927d50.101.1784590862415;
        Mon, 20 Jul 2026 16:41:02 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42bf11csm56278597b3.37.2026.07.20.16.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 16:41:01 -0700 (PDT)
Date: Mon, 20 Jul 2026 18:40:57 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <al6yCTDjBRn2HGq0@com-79390>
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
 <20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im>
 <al6Yz_QMlyU1GETv@fruit.crustytoothpaste.net>
 <xmqqqzkx9t95.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqqzkx9t95.fsf@gitster.g>

On Mon, Jul 20, 2026 at 03:43:50PM -0700, Junio C Hamano wrote:
> I do not think we want to do this in a single large change.  If we
> were to move everything to 'lib/' only to then need to further group
> them into subdirectories of 'lib/', it would subject us to multiple
> rounds of disruption.  I suspect it would be far less disruptive if
> we migrated one subsystem at a time, directly to a new directory
> immediately below the root level.

I agree.

Though it may seem *more* disruptive to do it piecemeal instead of all
at once, I think it would be preferable to avoid having a single
subsystem have to move multiple times.

That said, I am not sure that I completely understand the motivation
behind such a change to begin with. The second patch in this series
claims that:

 - "The Git project is not exactly the easiest project to get started in
   [...]", because in part:

 - "[..] finding your way around in our project's tree is not easy.
   Doing a directory listing in the top-level directory will present you
   with more than 550 files, which makes it extremely hard for a
   newcomer to figure out what files they are even supposed to look at."

I am not sure I understand how moving ~700 some odd files into "lib" makes
the project easier to navigate. I understand the patch's latter point
that:

 - "It is not obvious at all which files are part of "libgit.a" and
   which files are only linked into our final executables."

But don't see how this distinction will help newcomers who are likely
not yet thinking about which files are part of libgit.a and which are
not.

My other thought is that I worry that "lib" might itself be somewhat
misleading, given that many of the files being moved are not especially
amenable in the current form to being linked against as external
libraries.

So, I guess my feeling is that I am not closed off to the idea that the
benefits outweigh the risks/drawbacks here, but I currently do not see
that they do.

Thanks,
Taylor
