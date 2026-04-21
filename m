Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9133446C7
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803875; cv=none; b=BZE2qvdVLkMuIFjtL+D0XZlUZkDEuCLbM/rgQYQEz0/eIm1VdM4kNKOww0vmBBbQScwCkXSGR8YYObGH4qNMbYQrmCoF6ooEbhn6Aqb/EPorG/zsKiHLHjjh3wW552jgjtfZHp70o4uP0D3yaGiCTyRerEf+RYGPsDq9+ZiHXO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803875; c=relaxed/simple;
	bh=9u7Rs2xGoiS+hdeWDd8Ed1g2QPf7fwQ0yBbayT9DPRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1zu3uugA0pfRZWZNa7aWkTZC1t7AMuhRm+17aJ9/mud3NTx0vXTSZAjOpIxFGimqvHp/R6Q/SgeVqGpkEiG4vVLE3xbbTWnxctJLQfLYhuFYFanPgv2+T/3rRdzBLjAKCCCtiWdWO8h2Y+3glfBwj92kbV2HJAHr0F7k2DQJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=MNw/Lb3x; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="MNw/Lb3x"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479d4df9035so1404851b6e.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776803873; x=1777408673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pPJaNzYxaa7pZOQNmYTUe70q4i/gZPKVyyJFAWKCbpo=;
        b=MNw/Lb3xFAU2NPEA21V1O7OomTGcCzBPebC2vjXyiiKXo10/2mNyB6rbgvV0bEGyVT
         4gTipXb0MInHj+qQl2Su5ultcJe4hYtsyBJIlW0SAPo+a+9FIhrRdQ9uz5yKGNjUXshm
         B17cL8vf1418QmctBv1cPCituweHrDX8pQkBE/ZtqbPy9aumgp3HNbdOWFnBTHJW9g6g
         4AQdihQhwt2jVuXhNvU7+uN31/vndqC4zYF7oisseQMcDh8pwUXVy04mwdt9UB5ezdoS
         Y28qhnMwQUbZQFiFLFAVW9+eIm17YD0c5w2fo4wSssPbXuzA7vxWcLLn1XWA9PcLn4IM
         GhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803873; x=1777408673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPJaNzYxaa7pZOQNmYTUe70q4i/gZPKVyyJFAWKCbpo=;
        b=dNq2577nFBNUn947M7wWkGwGqjEauBHoxrbxdrVN4y5gt/CL9GvkhbD5eCwjSg7RFF
         oG+7j6/JTmqhF7W83Ft3vJ0VYqg04T2nsD3iBE6pP+C7+Dg64+VFFf3HUP3YCZ5zfsgg
         tTmsh5MStNdAVP+C31pSadF7nSNIa4c9spIk+sNLLOeS60vtsVYriI1tp9wH7nbzA6Nk
         rWZTk9TkS3MOEEphhwffUtwAgS5XvdLaRETEkWTMjOYMrTcuOtsNddtVoRloiiQBqXcK
         odWv3NgkSkKCzp6kKrIcUaa0NoaPqhVfVKyJ2rQIoQnEKj/gRWCigNWUYR6WzXaEyh+I
         vMHA==
X-Gm-Message-State: AOJu0Yz13jAG/T2fRKowhLCFalCaOtz2+q3i7m158DRX1dHHhpDJhYVH
	579cDqU1wXeVQz80aQSO0YVoVyKKojB/TUcImZ5dRJavUCoW2xsBWcM4oQg0LijSYlPKUABvK41
	NlDJ54xQ=
X-Gm-Gg: AeBDieszd7vGGByHlJJsUOaGVKQdPVIgWiQd1ORwHSjPsQdgqbh385d6V1ZsOOSRAsB
	y+BeEg3Xy2N2YWVcfvNt1Orh3P0AsHmpDGVe7meArd/l5mgFcwyC3rK7CHYItPb6gGojUlHya23
	svCq9Aa+3p5JyfEl+qeA6lJ1+2q8IysxWG7iq/rIJnBRvz+jblHEjIo3dVPAM410F1izzu0yv3y
	+n+rk/W5QY6sxb8CJSTEQRK45nl/XGC25huXfOXmj/+Xgrgjq9WpH7Mcd6piqHALv3utMWPJXYZ
	BlbmHy9S/QwGROlxUrymZdmeW/cdcEU+JzGsX3A2RHl3RsguHrc3RIQGO3WbEm8H1LDfoKx9gg2
	qJcLLSSUgmgi9PD2u1cDwT02niOMtwv6hw2ez2ISHljHi+jNhg6CSLoBzDaiGz8YiofwNj/RFZo
	OdkokL84A6j3dCZ5MucX988VHiUx47R+qrG8KYix7glRon2ZATBTjeG6+LemgzNI7Fwtt+a70Rx
	6AhwZsQpgUuOFDunYlmyomeYCFYHleKLDPbHIcyR5LP4ayJxOZN4xcfFV/92fDf0nzgfDeYpcea
	HR0OyYugWZIlyeZ/X8SpIQl8NOg=
X-Received: by 2002:a05:6808:6787:b0:45f:13fe:4a2e with SMTP id 5614622812f47-4799bfdf0damr8759992b6e.17.1776803872733;
        Tue, 21 Apr 2026 13:37:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799fc19273sm9617160b6e.0.2026.04.21.13.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:37:52 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:37:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 13/16] packfile: ensure `close_pack_revindex()` frees
 in-memory revindex
Message-ID: <1e1b957bf1266cee1608981d1a2960d4577aec79.1776803827.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776803827.git.me@ttaylorr.com>

The following commit will introduce a case where we write a MIDX bitmap
over packs that do not themselves have on-disk *.rev files.

This case is supported within Git, and we will simply fall back to
generating the revindex in memory. But we don't ever release that
memory, causing a leak that is exposed by a test introduced in the
following commit.

(As far as I could find, we never free()'d memory allocated as a
byproduct of creating an in-memory revindex, likely because that code
predates the leak-checking niceties we have in the test suite now.)

Rectify this by calling `FREE_AND_NULL()` on the `p->revindex` field
when calling `close_pack_revindex()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/packfile.c b/packfile.c
index b012d648ada..a1e88fdb223 100644
--- a/packfile.c
+++ b/packfile.c
@@ -420,6 +420,8 @@ void close_pack_index(struct packed_git *p)
 
 static void close_pack_revindex(struct packed_git *p)
 {
+	FREE_AND_NULL(p->revindex);
+
 	if (!p->revindex_map)
 		return;
 
-- 
2.54.0.9.gb905fd5d0ae

