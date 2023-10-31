Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8746C208C1
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24536FC
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 13:00:42 -0700 (PDT)
Received: (qmail 20639 invoked by uid 109); 31 Oct 2023 20:00:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Oct 2023 20:00:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25374 invoked by uid 111); 31 Oct 2023 20:00:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Oct 2023 16:00:44 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Oct 2023 16:00:41 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Documentation/gitformat-pack.txt: fix incorrect
 MIDX documentation
Message-ID: <20231031200041.GA877408@coredump.intra.peff.net>
References: <cover.1697144959.git.me@ttaylorr.com>
 <cover.1698780244.git.me@ttaylorr.com>
 <c149be35a1da66c5e1bbc1dd82839e32a52ace36.1698780244.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c149be35a1da66c5e1bbc1dd82839e32a52ace36.1698780244.git.me@ttaylorr.com>

On Tue, Oct 31, 2023 at 03:24:11PM -0400, Taylor Blau wrote:

> Back in 32f3c541e3 (multi-pack-index: write pack names in chunk,
> 2018-07-12) the MIDX's "Packfile Names" (or "PNAM", for short) chunk was
> described as containing an array of string entries. e0d1bcf825 notes
> that this is the only chunk in the MIDX format's specification that is
> not guaranteed to be 4-byte aligned, and so should be placed last.
> 
> This isn't quite accurate: the entries within the PNAM chunk are not
> guaranteed to be 4-byte aligned since they are arbitrary strings, but
> the chunk itself is 4-byte aligned since the ending is padded with NUL
> bytes.

We also don't place it last! :) So the alignment is very important, as I
found out in the recent chunk-corruption series.

> So these have always been externally aligned. Correct the corresponding
> part of our documentation to reflect that.

Both this and the previous patch look good to me.

-Peff
