Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A5A3A9635
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502446; cv=none; b=eiGekGaAhiy5sG5J+f+xN/BSt3yFPLXlPYF2WKh9qpeykJGFV4X2U0c5oXVOMqqobKOYwc6VfHB+5U4MCaQ/rr1r+UoqS6Iipr2cvK2VlEJT9IkEBGHVJS6RFgAGRqHcEA951ebmgXXt98xzYjLEGY89aknHuyjb3KdrxMKuuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502446; c=relaxed/simple;
	bh=gjycEvCx7CuJiSOuXjQNN5xX6pcV2hNgxh1zpoLxsiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRSJWQf8O3FLG+qMeXznUPZQpJXZsT93mrsVCIl2kQZxjEjb9JYROEhqVbAnVziAv1otSKgkufDOcFIWJcj5PHgGZb2rGXSqKbP0XHxrKcSYH9QeMSRRt2K2q2ZQpl/aEnFHl5j87Nq9HqVXpaX00jGwoa1uRbf0z0+pRl/xMGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Kxf6ol+m; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Kxf6ol+m"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651b4d09141so513137d50.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 15:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777502444; x=1778107244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjycEvCx7CuJiSOuXjQNN5xX6pcV2hNgxh1zpoLxsiU=;
        b=Kxf6ol+mxc4DLYR+89HoEpTvjsqTwzXsys7eGdUQtZJHb8PL9F39v3vQ/tODlp+8Hi
         Ru7EpxBwzAq5UIO246gllRdPgYVN1mSi49MiizM26uj6h6edsvzN8Y/0HDXJA+c6fcBN
         5mW4F1pqfnVQOZlcpGCcwxCOa+I7GqgdeeKQArsLMKgmGiDJGySCDDPHDKavIT/j4UDD
         Idy6ssGkvcDckXvVfNO8cuJ0jG5aDBRKxt80CW+3f4JxU8qeEmaKbon02iksLbjgKIfy
         gLTH3ylaN4rs9jDAtImBjeXBTigbeGNb5SUylEE8gI3HaX6/bxwrMuuFWPhdDy5oyJh8
         DfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777502444; x=1778107244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjycEvCx7CuJiSOuXjQNN5xX6pcV2hNgxh1zpoLxsiU=;
        b=damIoN9Og9uwwP5/kp4GoiSU/Nflxd13B8fHXYTtkRHyVk6144QNTsp0UD0ux/E6WZ
         YdvivQD24+CBsc6w3qfCQ9IRczvnyhEG/k2L3AuY9Ii+/9ykQuKcldw8R9pIlJIcuVzs
         /3qrVPqxqZSMy1AqZKSLpfLd/QLKUbb57tLlxzBSdrepiaw+yUE6hZHylTfecK3AteqF
         40QfFKT7efIFoaBz3z15be9cQasT6AGLpTYTMXGRr21wpcOx/vvZSZbTU0b0xRXLb3B/
         3DJcA0/l2PJjZbfE33PxqaGrryEQ+i/S+RHc+ohnhlGBVVVXXpV46ZM/RrGaxmJRO1tx
         3EbA==
X-Gm-Message-State: AOJu0YyP/ZSJAw55IHznYSEFbKdX8KHXp30RHTvN3VFHfhXKBuS7M1PC
	f4cFhdFO5G72MKBuHReCc7NSjZnISZqlML3FdWqJd6yGShqlhufha4d/3FyCF3NJE54=
X-Gm-Gg: AeBDievVBY9+uYKlNyIw1cU301SQfo5girLyA9b1WdF2mXGoILrkJ8Xst3E+oQQOdc+
	/86G4/NWsTzJk5dCPt+Pz50ArHEzVYcawE14wBlILicWlvK/y0F5tGHKcXCIO9LDSzLqBrkaWhR
	/yb13GkHXwlFsgwQI1GWDbXDiVQhdnpjx96115G58u/otTbhkeC0Q4t0Gmjz69Tn9cpts2glh2k
	D2cpvoldHdr+AhS6DhhYHkUN/9k0hSTdZsIOk9at4l9gH0m7MB9Sa03AOUrop8oK7j7M2ZFJpGc
	Zjii6U/hIJZ3ynRrqhfWkkb0qnPtGftP6rEE5t66eTwPR79E4RIwpOQMRaclpE2kcMM6DKbUlrt
	hy6l9W78j5xxhEJtVRDm2LMxSTkMNsW8xdQsuUJajRjS9Vb7dt55JQilP3tVO8gbDvltBkxn8vP
	qTauKybO0bBOsu6nKf+xX8R8DdOJYbV/xBpBILK/VOOZbsQLAJ1wFMCFoucXVMo/1Nr3b9kWF7D
	KVvjGRe5DoR+GRqygmgTxLMISY3aYipjXXFaSvMHdjq5EZ/88HA4E6pmRG3lrTYULogGul1itgi
	xhgt5fQ01aTNLRwCfdf1qFwFc5U=
X-Received: by 2002:a05:690e:14c4:b0:650:7893:a3c with SMTP id 956f58d0204a3-65c1b0e322emr11205d50.36.1777502444557;
        Wed, 29 Apr 2026 15:40:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff6c4113sm1879089d50.11.2026.04.29.15.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:40:43 -0700 (PDT)
Date: Wed, 29 Apr 2026 18:40:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 10/16] repack-midx: extract
 `repack_fill_midx_stdin_packs()`
Message-ID: <afKI6rWBr5A7QdLc@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
 <44f522ea04df5176ec332b60a38d1eab9b649c30.1776803827.git.me@ttaylorr.com>
 <20260429080821.GA1269182@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429080821.GA1269182@coredump.intra.peff.net>

On Wed, Apr 29, 2026 at 04:08:21AM -0400, Jeff King wrote:
> On Tue, Apr 21, 2026 at 04:37:42PM -0400, Taylor Blau wrote:
>
> > This simplifies `write_midx_included_packs()` and prepares for a
> > subsequent commit where the same helper is called with `cmd->out = -1`
> > to capture the MIDX's checksum from the command's standard output,
> > which is needed when writing MIDX layers with `--checksum-only`.
>
> This should be --no-write-chain-file now, right? It's not used in the
> code here, so it's just a commit message fixup.

Yup, good spotting. Fixed.

Thanks,
Taylor
