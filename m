Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A1B4CDEA
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZG4w36Ps"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbd1fab03cso3852995b6e.1
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 09:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704908050; x=1705512850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EI33rnOGqEQ4pOyVBTNv0VUJr2+kbzAR1Gu7rBYgTi8=;
        b=ZG4w36Ps+csOhMLXb5Uwq8uMJFbswNhIQPhpUS0PqQ4MeI2qj498XrfcRHctS20i/f
         h0UoB6uUHc0+2vI4Y77OVwVKCuG3k4y26g4g+j96Lk2w4OfujhMhEXZ+sv0Ek5pGom/d
         OiVZZcXi/EHJ3kZAmyV0k8r3oD+e7hYDBE/Uhky5HOVkcr8DQ8uwKDIUKwOqiuEGlno2
         cI8RoTDBjLYzLV6x0fqqxNvF144hwTCx9zqDMrfKI+2di2pBvI7unDhsl3rvrDpSFi8x
         5bkRnJjSFkLIih6Ei/ruwcBRMp4ZdB8C+BjyFfX8AlmnoUci8hwz07rih8Mr9yy6r/7t
         44uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704908050; x=1705512850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EI33rnOGqEQ4pOyVBTNv0VUJr2+kbzAR1Gu7rBYgTi8=;
        b=lh7PR3HYbtU4Q1IgqYlTK91LGL4vhMp7obbvAbHVwvBV/qzuQBYD48+57021XcH3MF
         HToQjFQPFAPht9c/+Mv62h98gKN+4RftRg3J37JYjcbVTGt9Qzs9h3YOSb/maNkZe/4f
         PyYzB46DN5Pd2NhjSNsKmWYKlr5dAIFKo6VGHRXPOR6OjAA0MoB1l0yv3HcsdjncQ24a
         i8Pb8f33N/TyTlVUUmo30n7tE9KVZU/xfdYmaHchP6iUk3DxayFraP2DD/O0zIFG53nV
         aUAUBuDTiJ46S1Xu6GtzdrWviyEpLK6suqgTlF0FEbLP2vljKN7yeCtFG4HeW49CltE1
         D9xQ==
X-Gm-Message-State: AOJu0YzA0YWAnPkcO1iJlorrVktkEl7BCzW+Csr5/zVPTpPqL3SEyeZz
	8gGjOqK4ldJ2EAuAbCNi1LhE5fPK4/xnvBuF8EO1ll5inkaCKw==
X-Google-Smtp-Source: AGHT+IEwxFpAjz34RqnnpXw2wCmfEFzpzE1Uy0OgcTUtyS5ohLhSkoBdnIBnt3+b5Yyr3sqF39Uglw==
X-Received: by 2002:a05:6808:2209:b0:3b8:b063:9b56 with SMTP id bd9-20020a056808220900b003b8b0639b56mr1602067oib.72.1704908050639;
        Wed, 10 Jan 2024 09:34:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h19-20020a0ceed3000000b0067f7b0904c3sm1851123qvs.83.2024.01.10.09.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 09:34:10 -0800 (PST)
Date: Wed, 10 Jan 2024 12:34:09 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] index-pack: spawn threads atomically
Message-ID: <ZZ7VEVXSg1T8ZkIK@nand.local>
References: <20240105085034.GA3078476@coredump.intra.peff.net>
 <ZZgvUyQK6X/MacDC@nand.local>
 <20240110114456.GF16674@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240110114456.GF16674@coredump.intra.peff.net>

On Wed, Jan 10, 2024 at 06:44:56AM -0500, Jeff King wrote:
> On Fri, Jan 05, 2024 at 11:33:23AM -0500, Taylor Blau wrote:
>
> > -	test_must_fail git index-pack --fix-thin --stdin <recoverable.pack
> > +	test_must_fail git index-pack --threads=1 --fix-thin --stdin <recoverable.pack
> > [...]
> > For what it's worth, I'm fine with either approach, mostly to avoid
> > tying up more of the list's time discussing the options. But I have a
> > vague preference towards `--threads=1` since it doesn't require us to
> > touch production code.
>
> That's quite tempting, actually. The flip side, though, is that the test
> no longer reflects the production code as well. That is, in the real
> world we'd still call exit() from a thread. That obviously works OK now
> (modulo LSan), but if we ever had a regression where that left us in an
> inconsistent state, we'd be less likely to notice it. Feels kind of
> unlikely in practice, though.
>
> I dunno. I guess the real least-bad thing is seeing if LSan can be
> fixed to handle this atomically. I haven't even reported it there.

In the meantime, I think that the `--threads=1` approach feels less
invasive. I tend to agree that neither option is ideal, but that
`--threads=1` is probably the least bad, and that failing to catch a
regression there feels rather unlikely.

> If do go with "--threads=1", I suspect several tests in that file need
> it.

Yeah, there are a couple of others. I think the ones that need modifying
are at the intersection of "expected to fail" and "in a test which is
expected to pass leak-free":

    $ grep -l 'TEST_PASSES_SANITIZE_LEAK=true' t????-*.sh |
      xargs grep -l 'test_must_fail git index-pack'
    t5302-pack-index.sh
    t5308-pack-detect-duplicates.sh
    t5309-pack-delta-cycles.sh
    t5313-pack-bounds-checks.sh
    t5325-reverse-index.sh

I'll send a series shortly to tweak those test scripts to avoid this
issue if you want to notify the LSan folks of this issue more generally.

> -Peff

Thanks,
Taylor
