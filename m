Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A944A4C81
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768435875; cv=none; b=S2Ewu/4y8dP1EDhS93Mbc/rK6R/9EaKrLkXpYDyTDJmQzNlVukMql/gBj0HJMMtSfYo9OlNfm6/WdZLcFTBTKHHMBfh59K0KD3vj2C5pnQtbVKl5SOQFsA+R+yF9baTtabsM5ol3+VHGPyLDgU6kEOY6+FpDDx5PfpCgJMtRP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768435875; c=relaxed/simple;
	bh=tsK3CZ2EVpE5gpqJnidnieCh0yUGCqCqgsoY9NsSULU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQ3ed8bjeQO3LZ30hepkAp5tIvQQ85Qm+WirL4Y2dOtmmhRIWPknToDIetQnpuEdmoVPtRE7lzc0s9+sw3zQvou3160jYgHtACy63/K13dYsB8vQNIT546w7GZfKDjNpZxbBOYKuXPcyYVf2192wimlGj8b57VUAmiwPGYVVXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=l+aj+MGM; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="l+aj+MGM"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6446704997cso289696d50.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 16:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768435872; x=1769040672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zd6vSlWsIv+JEmjSC18BvxBNpw0VXfaPBs/umAA7+Zo=;
        b=l+aj+MGMon7FoV2i0x6+J29ZkkOBeznevDnhcMQkd2bmaCjiLQY8bsJrhIyqfugBQJ
         V5K10YsBjxvvBKoUY9n8k2d+iOy7NCjlnL3At6e9wRZagn5BkHaFIVGMDQl3/yYXtV7p
         nWOWxloNOmkSyh3+T2j6OmiHgmZdalgg268nnDEbHvJ4IfHCbO0QYP0nECNdtXWo8DdB
         7/tCPETDqJo+W6O1p/BKkAdPtU9q+jhq6fLgWNDvwoLT15uc2aYqZOdKukSnXB2/khxb
         a8hMHkik5cRBZpyj6NHSf2jAtkogS1JDpbMbHQr24AJmcbcsFdf5MxBaqPRV+Zc5UsX0
         rSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768435873; x=1769040673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zd6vSlWsIv+JEmjSC18BvxBNpw0VXfaPBs/umAA7+Zo=;
        b=qSaUvf4fC+u2LPpSTy+XhrP4g0W1CFaDg4VnMnjW2PUFxXjpwdsf6a2PH2/MmVefoj
         FO4VNEXX1zqVqRvGhPn29w9eQVnweS+V0HSnIxZ4eUGfQDE8btXv04YHFn6B/frHvX1G
         wa9CK3AgMzGbVu7yj1UJRvSFevgExjosMoQbCs7thZseV/s4QuHjOyf/aHLTPEaq0nDV
         Q5bOC3Hc5Lreu9C81ZK5pxytbbL1+VllbBqQQpqpYuVWPQCUjwyxhdqFvQY9Mkh9cEmM
         OKEk5ZAdXSyp9Iwbz8bCfXp1nwqor0CqtWdnRhIXSRD8xtuzJptqNj2irjnPUhRWdqba
         sEZg==
X-Gm-Message-State: AOJu0Yy4I+D9IHF7HUcRf2tc9WMCLksneizJGUTKqEmuVk4MqS61xDg0
	V+Ln7dJOOaN6UbMUm0N6WETnSjO2f6E9pF45sD3tL9dFdJSKDsjIeJRUW4FPxODXS0U=
X-Gm-Gg: AY/fxX6g6eGCGyHrqI/RunrtV/GKalLJCbuXvvWVDJEqFHI3cKujon6igS4In/mR+Gy
	/uiSZD05iW0bJfT/ht06eJF3ehLHi2BQYjq+CGbwYecmYDsvJdXfRFgVw5bZrrCONjN9cP37v0a
	1/STJRMNCo0x+epyMO7tRMcOClKk/C7EOxzdpEIRp+GqZgYIpqr1DRTHScQTDnObuIVARWOf+jO
	lRA7I2exw+F/TaAJELjVHvJEbgSv5B1Pu8sZizOltrN0iJ1hKbFgR4noWdvwliRGl4zEoDNhPES
	40SDrIHadQtgZXZ9W87XzKPbD9xKm5YHYmpIuWU7CMvhuIzY/+1Bjis+CIAVHQnV4otxOB9VWH/
	pifO+no850P674W0Lmk9XALRsVZkXnegwYyZoY/EIeMT4c1Q9euE+cBIkCo2a42KbORLMVT2Khd
	TnEIyBsn7gRRxHMr6JBVLOq+OKFFP9Hb+pgXxAHmwm410d235kitdNsLk0AqZegrapkwsZvaFVe
	teE4zfQe8MIKDGzUw==
X-Received: by 2002:a05:690e:d0a:b0:641:f5bc:69a2 with SMTP id 956f58d0204a3-64901b2478dmr3657553d50.80.1768435872628;
        Wed, 14 Jan 2026 16:11:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d80dab9sm11148109d50.7.2026.01.14.16.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 16:11:12 -0800 (PST)
Date: Wed, 14 Jan 2026 19:11:11 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 11/18] git-compat-util.h: introduce `u32_add()`
Message-ID: <aWgwn2rk/qw+fRoA@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
 <c0c1769464b1c8065c2cea59dfd85a1d37de9dd1.1768420450.git.me@ttaylorr.com>
 <xmqqpl7beugj.fsf@gitster.g>
 <aWgSzI30k0BZfZ4Q@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWgSzI30k0BZfZ4Q@nand.local>

On Wed, Jan 14, 2026 at 05:03:56PM -0500, Taylor Blau wrote:
> As for removing u64_add(), that should be straightforward as well since
> there is also a single caller. Let me know if you think that makes sense
> to take up as part of this series, or if you would prefer it done
> separately. I tend to prefer the latter, since the state after applying
> the above is that we avoid adding any new callers.

This appears to be easy enough. The following applies on top of 'master'
if you want to pick it up separately:

--- 8< ---

Subject: [PATCH] git-compat-util.h: drop u64_add(), u64_mult() helpers

The u64_add() and u64_mult() helper functions were introduced in
b103881d4f4 (midx repack: avoid integer overflow on 32 bit systems,
2025-05-22) to implement overflow checks during a fixed-point
calculation when estimating pack sizes in the MIDX writing code.

However, those functions call die() when either the addition or
multiplication of their operands (depending on which function is being
called) would cause an overflow. This does not allow the caller to
provide a more detailed message, presenting the user with an opaque
message like:

    fatal: uint64_t overflow: M * N

Let's discourage these opaque error messages by dropping these functions
entirely and instead having the caller use unsigned_mult_overflows() or
unsigned_add_overflows() themselves, providing the caller the
opportunity to come up with their own die() message.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 git-compat-util.h | 16 ----------------
 midx-write.c      | 15 +++++++++++++--
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b0673d1a450..24edd68c671 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -641,22 +641,6 @@ static inline int cast_size_t_to_int(size_t a)
 	return (int)a;
 }

-static inline uint64_t u64_mult(uint64_t a, uint64_t b)
-{
-	if (unsigned_mult_overflows(a, b))
-		die("uint64_t overflow: %"PRIuMAX" * %"PRIuMAX,
-		    (uintmax_t)a, (uintmax_t)b);
-	return a * b;
-}
-
-static inline uint64_t u64_add(uint64_t a, uint64_t b)
-{
-	if (unsigned_add_overflows(a, b))
-		die("uint64_t overflow: %"PRIuMAX" + %"PRIuMAX,
-		    (uintmax_t)a, (uintmax_t)b);
-	return a + b;
-}
-
 /*
  * Limit size of IO chunks, because huge chunks only cause pain.  OS X
  * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
diff --git a/midx-write.c b/midx-write.c
index 87b97c70872..6006b6569c8 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1738,8 +1738,19 @@ static void fill_included_packs_batch(struct repository *r,
 		 */
 		expected_size = (uint64_t)pack_info[i].referenced_objects << 14;
 		expected_size /= p->num_objects;
-		expected_size = u64_mult(expected_size, p->pack_size);
-		expected_size = u64_add(expected_size, 1u << 13) >> 14;
+
+		if (unsigned_mult_overflows(expected_size,
+					    (uint64_t)p->pack_size))
+			die(_("overflow during fixed-point multiply (%"PRIu64" "
+			      "* %"PRIu64")"),
+			    expected_size, (uint64_t)p->pack_size);
+		expected_size = expected_size * p->pack_size;
+
+		if (unsigned_add_overflows(expected_size, 1u << 13))
+			die(_("overflow during fixed-point rounding (%"PRIu64" "
+			      " + %"PRIu64")"),
+			    expected_size, (uint64_t)(1ul << 13));
+		expected_size = (expected_size + (1u << 13)) >> 14;

 		if (expected_size >= batch_size)
 			continue;

base-commit: 8745eae506f700657882b9e32b2aa00f234a6fb6
--
2.52.0.436.g7dc2c5478ff
