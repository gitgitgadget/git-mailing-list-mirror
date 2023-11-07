Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5F9447
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 04:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1829ED
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 20:02:36 -0800 (PST)
Received: (qmail 27525 invoked by uid 109); 7 Nov 2023 04:02:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Nov 2023 04:02:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11319 invoked by uid 111); 7 Nov 2023 04:02:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Nov 2023 23:02:39 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Nov 2023 23:02:35 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] revision: exclude all packed objects with
 `--unpacked`
Message-ID: <20231107040235.GD873619@coredump.intra.peff.net>
References: <cover.1699311386.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1699311386.git.me@ttaylorr.com>

On Mon, Nov 06, 2023 at 05:56:27PM -0500, Taylor Blau wrote:

> While working on my longer series to enable verbatim pack reuse across
> multiple packs[^1], I noticed a couple of oddities with the `--unpacked`
> rev-walk flag.
> 
> While it does exclude packed commits, it does not exclude (all) packed
> trees/blobs/annotated tags. This problem exists in the pack-bitmap
> machinery, too, which will over-count queries like:
> 
>     $ git rev-list --use-bitmap-index --all --unpacked --objects
> 
> , etc.
> 
> The fix is relatively straightforward, split across two patches that
> Peff and I worked on together earlier today.

I'm not sure my review is worth anything, but this looks good to me. ;)
I do think it might be worth tightening up the docs as Junio suggested,
but I would be fine to see that as a patch on top.

-Peff
