Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CBAD52F
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VElaPQui"
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A8DCC
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 11:55:24 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59e88a28b98so42780857b3.1
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 11:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698692123; x=1699296923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3qDrX8nSrUYEZeHhx4OVLZsXsbD+50o87PAlJmpT7o=;
        b=VElaPQuix0uMKCPRRObab7o+rqYxHs3ikkgFmXy2AHnjQPlXThb+pVpBeygDANDLAJ
         xU9au5WqEbYBbbq7frh9cUNO14UqYqCQ2ImAAeE2ZqAi46hpNkylOTXMGdChySNNxxTo
         iolLFg8rCoRQoZnb5/u9Qy3869CNgWNSphaAQTZnhozklnYD3Gc/eJcCYCm9Ox9iML+U
         1wZFQq58Wh8k42M4zg0A9auEkgBCCwotsAc4CsrcwBL8TSYNftR1MZ8X5hT9dyoSMbkp
         n+X5W7sBRDNXzTa3axNb3IhTbrKgJtvCyzIM9SlMHs6/9TM2nFp5q271zDZ91g5XMjFg
         /IkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692123; x=1699296923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3qDrX8nSrUYEZeHhx4OVLZsXsbD+50o87PAlJmpT7o=;
        b=cNz2vu9wSZBIW+7ciK78ZexCbcNoYpSPJzwXDSiBSd3Uq2OoYpeRbsZaKlYUJuV0t/
         8P4SuTSEZGCmzo+b7/zGe2Pp51Mo/BuGQrHHeq22w7mzaDn20BFjDrIaP1Y6LLSKQpvs
         P7DMjuhx2IqTiYG+j4qtn3a7fHP1yfj3ozNBR6ktEITTPDHrqI9Lcp7hhdh4Sk/un/dE
         LUXuhI89yVS+JT5czhG2x2N4rJsYA/Es70JudGmxi4k4d6KIj5MIBuZnGAB+smbHqVns
         QGoKUdeggQ2vvWT5wqcLpYOMkElZhtcszP+Px6meitTaXysOomnP7nZKEh3OmxtJ7uTY
         OFSw==
X-Gm-Message-State: AOJu0YwqBjwO3K2i1HeqDoZEqsho4BIjWr70u6L6wvxcsUT4WyqXEhnE
	d4inY+snC6AtFkBKMauHbmRjPA==
X-Google-Smtp-Source: AGHT+IEHWDPfdzgJAyJxJk8FsfN/mcH+usdEyaj3/knYR69oXL5koCXmVphU8UQjur5NF/xXsGXOrg==
X-Received: by 2002:a81:a8ca:0:b0:5a7:bfc6:96aa with SMTP id f193-20020a81a8ca000000b005a7bfc696aamr428225ywh.7.1698692123398;
        Mon, 30 Oct 2023 11:55:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u133-20020a81608b000000b0059f766f9750sm1758ywb.124.2023.10.30.11.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:55:23 -0700 (PDT)
Date: Mon, 30 Oct 2023 14:55:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 05/12] builtin/show-ref: refactor `--exclude-existing`
 options
Message-ID: <ZT/8GbzAmBq0aRIK@nand.local>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
 <bed2a8a07696371e07c0b2d1282ed51c0b1b9fee.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bed2a8a07696371e07c0b2d1282ed51c0b1b9fee.1698314128.git.ps@pks.im>

On Thu, Oct 26, 2023 at 11:56:37AM +0200, Patrick Steinhardt wrote:
> @@ -95,6 +94,11 @@ static int add_existing(const char *refname,
>  	return 0;
>  }
>
> +struct exclude_existing_options {
> +	int enabled;
> +	const char *pattern;
> +};
> +

Thinking on my earlier suggestion more, I wondered if using the
OPT_SUBCOMMAND() function might make things easier to organize and
eliminate the need for things like .enabled or having to define structs
for each of the sub-commands.

But I don't think that this is (easily) possible to do, since
`--exclude-existing` is behind a command-line option, not a separate
mode (e.g. "commit-graph verify", not "commit-graph --verify"). So I
think you *could* make it work with some combination of OPT_SUBCOMMAND
and callbacks to set the function pointer yourself when given the
`--exclude-existing` option. But I think that's sufficiently gross as to
not be worth it.

Thanks,
Taylor
