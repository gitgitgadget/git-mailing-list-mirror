Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC43B13E041
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715086; cv=none; b=ZCgFI9seQstCTQM3rqEzheCFnoBbXBFYkZo52wGKFKCwjov+JMZzZS4zd9yIBbjsrcsRzBTz+4h1a/nVEWqKtUVqrNUrpAt37iJUPA78YElAGZOjLgI2RLSyeSclg0d9ws7IRuWCIHeoqTrRxBUN5mFXdKpcs2YkeyTNUtURbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715086; c=relaxed/simple;
	bh=X4FhyZ4CxJjAmal+fkdOsRJjyhIrgvlpgMZPkEFASBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0Hhiaw4srlJdd3SVV/bQY6im7RVpFZg8ZYs7NiSIbQQg8DfZqdQhrNCRARGIWwJm6MSWr8eJNMnYFp7QDVwk06oslthRdICTfnfJSFb5NPvEnc56Ikk5jKixVBuG98hQSBJfklBwUV9SaEl1g4eqmuhazL5KLiAoB1Hx6Rq9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mO/cogAV; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mO/cogAV"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7eb35c5dd37so65153939f.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715083; x=1718319883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rR9Fx9Hvg//c4k8/nWiH1uMBTJxu4YfQn1Pw+o+UU2k=;
        b=mO/cogAVrujo8WLQI9Pcg1rCD1bkx0muEPl8MbAA8HZLCaVgR+z8v4Sz5GPh8aA/TX
         wf8axjA9jrI7wuE2qX9HYpx6eZ7rO9yPm0XvQlOODi5MMbzCH4L7zh6C06wuXoj9ejQz
         XQRT/OXpcFlJ12p2s4Z+0K2qXtr3BQ+MMmRi5gpUAOb5Jfe5Lw5Y4LE413OsswA2pbYj
         rFDzZqu5R5dOo6tIXPSC0mwJ2pCm3oFJ+vfPJ0GlPGB7bPp5FOgOCGZSn4R4O+UIEyDD
         0qde2ZQJMIxoOJxJfxEO5aiQGLAkx3uK4+nj+cCDuIfXwPdWvLWZNvB8Xd2eHMccxqpS
         ZVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715083; x=1718319883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rR9Fx9Hvg//c4k8/nWiH1uMBTJxu4YfQn1Pw+o+UU2k=;
        b=GG3P8XwObZnGbwUzE7OV6V5fqAoU8Sz/1UGhzhB2jjmAsEUygi5j8AK0kdvEOlvn5W
         aiIXG4TG6uZY+LAbyqodMsOefOEtJUlmymHIw3VcayFnqOp0tJnW4MzOGzMc+iE6S1F4
         dVxx7b986n/4JX/is7m2HXZqnpj7fYuHVjeZ6bA9WQnN1PFZCWevTu/EhlMfceERyioG
         406AI6zf5LCcCzL3Kvf3kJOmu4C6krHWCS6JeuEOZl3YVvUTi+I364su/WQKDU92hAnD
         SuckYYO6UWwTXoSI6Q8ZNgLaYv3OkcEtgcALvbuWicHTvaQWubTdJw9kEMISi4o6Ld64
         /Beg==
X-Gm-Message-State: AOJu0YxnVuBBpjt/KREYrxKHlelEm1zHbmaES68bBbCv5V+QlBa+xUw/
	sOgzI+ocTUh8rxPefRzPBrqXGmBqvolQfzoeFOiYwxUzlVhg7SIx7dXRF7waFJ3dyzBj3mYgcw3
	PObw=
X-Google-Smtp-Source: AGHT+IEN0t6n5NsyEBRiTY03nwszjj3nxrR8CO1dtY/njnpwa+a6XJ2WJUYOBVA9kyGIfWruP1vmQQ==
X-Received: by 2002:a05:6602:2dcd:b0:7e1:7dcb:7806 with SMTP id ca18e2360f4ac-7eb5725b6cdmr108686839f.18.1717715083418;
        Thu, 06 Jun 2024 16:04:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038b5e617sm7541601cf.93.2024.06.06.16.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:04:43 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:04:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/19] midx: teach `nth_bitmapped_pack()` about incremental
 MIDXs
Message-ID: <4e960edf8a1018b8425d4d6ae5bb3553bfd38023.1717715060.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

In a similar fashion as in previous commits, teach the function
`nth_bitmapped_pack()` about incremental MIDXs by translating the given
`pack_int_id` from the concatenated lexical order to a MIDX-local
lexical position.

When accessing the containing MIDX's array of packs, use the local pack
ID. Likewise, when reading the 'BTMP' chunk, use the MIDX-local offset
when accessing the data within that chunk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index cfab7f8113..cdc754af97 100644
--- a/midx.c
+++ b/midx.c
@@ -308,17 +308,19 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
 		       struct bitmapped_pack *bp, uint32_t pack_int_id)
 {
+	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
+
 	if (!m->chunk_bitmapped_packs)
 		return error(_("MIDX does not contain the BTMP chunk"));
 
 	if (prepare_midx_pack(r, m, pack_int_id))
 		return error(_("could not load bitmapped pack %"PRIu32), pack_int_id);
 
-	bp->p = m->packs[pack_int_id];
+	bp->p = m->packs[local_pack_int_id];
 	bp->bitmap_pos = get_be32((char *)m->chunk_bitmapped_packs +
-				  MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * pack_int_id);
+				  MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * local_pack_int_id);
 	bp->bitmap_nr = get_be32((char *)m->chunk_bitmapped_packs +
-				 MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * pack_int_id +
+				 MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * local_pack_int_id +
 				 sizeof(uint32_t));
 	bp->pack_int_id = pack_int_id;
 
-- 
2.45.2.437.gecb9450a0e

