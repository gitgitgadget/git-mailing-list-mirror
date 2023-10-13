Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F0208DE
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="U8mYL3VB"
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34FAA9
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:17 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7757f2d3956so302436785a.0
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697225116; x=1697829916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YlQZP0ZJ5jVbGz4zh/CszAIwNNz2t+1XPzEPsao9660=;
        b=U8mYL3VBcrWxBlGBbttrfHZBLCd4l4LTP9ESphyr5rJOkJhgUEefmHiGnuzVpgemcj
         n/TGR0sojn4nkgDYXLV3Cy5L9exPVzd3jwqAORUsrNIhpplOIHOb5dVm1YBjbJa6mgsk
         X0ERIahJKTM6xo3LaSWM9S9sk9bZsb1eLwfYSXfQAl9oZ0nUqoxWEcsDOKKyT1kqIUMu
         f9zT3kWvqwKQPlE4Ef7fJriLCV5ImiybGSag43i/A7f362QJMUudNv2cb//gueTTXBV0
         YY78wRm50/nnLwJi8vu+1dXv7mzeenKEK+93rlkWZ75Q+y+HGUpaQLEIeqCbHKpUKdlb
         wpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697225116; x=1697829916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlQZP0ZJ5jVbGz4zh/CszAIwNNz2t+1XPzEPsao9660=;
        b=iMRljX+xAAkjWeqBlTdrE+PkSCfJt15W115c1JiZino6gtIQJeylLnIE4YgadMNNlZ
         /dSsYaVSs7uQM74g/Yv6Q7qtQJetk5gEZtSlVO4zAiASI4ssw7DQZD9td1DygK7xWkKz
         ejUJ379FhruP6PnaISmgAFxlFmqTpSkWhzUToMDY1Y+cwmJmYALdppegjVqHkReuT6J1
         qYYg0gL5HOyFQKgI/CaTbfPiuM7QPe7daD32naW8XdVaTqgnOJ6qGvGTQ6fShXo0J0nk
         txpeKPTPs8MldD8Ry2+8+8iW6BYcjGqwMGxfIYz+gZGUmAonyFWBdwe1pKneFK4HL/7I
         PHrA==
X-Gm-Message-State: AOJu0YwryLAjIuGWBI1mWbUCkezLk/BwlDX5H4rUEaNnnKMCeTPCmreX
	eqOPyOUwVbX3Jm3zmY5gAupRPPHQnHOQog5JO1p7eQ==
X-Google-Smtp-Source: AGHT+IEPnvY6SmcJVQl29Dreq6UZ3Z/VakyeodNre+hmgPc2bb+sDCBmNbNGBDphUrRBxHTBCVI2Mw==
X-Received: by 2002:a05:6214:234b:b0:66c:edf4:b955 with SMTP id hu11-20020a056214234b00b0066cedf4b955mr1977819qvb.21.1697225116683;
        Fri, 13 Oct 2023 12:25:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id da19-20020a05621408d300b00646e0411e8csm902435qvb.30.2023.10.13.12.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:25:16 -0700 (PDT)
Date: Fri, 13 Oct 2023 15:25:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 0/8] chunk-format: introduce `pair_chunk_expect()`
 convenience API
Message-ID: <cover.1697225110.git.me@ttaylorr.com>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While reviewing this series, I noticed a couple of spots that would be
helped by having a convenience function that stores the start of a
chunk in a designated location *after* checking that the chunk has the
expected size.

I called this function `pair_chunk_expect()` and touched up seven spots
that I think could benefit from having a convenience function like this.

This applies directly on top of 'jk/chunk-bounds'. Thanks in advance for
your review!

Taylor Blau (8):
  chunk-format: introduce `pair_chunk_expect()` helper
  commit-graph: read `OIDF` chunk with `pair_chunk_expect()`
  commit-graph: read `CDAT` chunk with `pair_chunk_expect()`
  commit-graph: read `GDAT` chunk with `pair_chunk_expect()`
  commit-graph: read `BIDX` chunk with `pair_chunk_expect()`
  midx: read `OIDF` chunk with `pair_chunk_expect()`
  midx: read `OIDL` chunk with `pair_chunk_expect()`
  midx: read `OOFF` chunk with `pair_chunk_expect()`

 chunk-format.c | 22 +++++++++++++++++
 chunk-format.h | 12 +++++++++-
 commit-graph.c | 65 +++++++++++++-------------------------------------
 midx.c         | 58 ++++++++++++--------------------------------
 4 files changed, 65 insertions(+), 92 deletions(-)

-- 
2.42.0.352.gd9c5062ff7.dirty
