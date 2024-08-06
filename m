Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BA21799B
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958652; cv=none; b=kU9f0nzh/iMNrnWvi/VDHiJPYDFtEGusmAANnceEyKIz6Te5NQr6o4Mexnj+CC7OEM8TkIXLmjXMxf5vCufpnmSy0mC5TY8BtGcAZLKh5K/TIPzh+AZd0qIM70CFkTPCWKbImoLDB3OszyzA4nE8CfIMAkQ7ZZO8cYBDzXJNvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958652; c=relaxed/simple;
	bh=mc8zUPuWI14y/tvtqfFhMpcqObJ/bAciaX50ecgUFPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3dYd8/VcBnadpgQ22M8ESLyaTSAU7zZZ9+FplnPR2GQtRN3oh2KH7aqh6jMidGYyFkm1yVfVTrWgP01owqv7behmaa2cpPszqAmz5pw/RlZ+YoVtdaD/aUiVuAmX3RXwF1esga3OzS9PTt7vrabgxyeCX32b6zRsEg16GhtnWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=N7aQegov; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="N7aQegov"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-68d30057ae9so6677467b3.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958649; x=1723563449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M4YvSew0Q8gKBZ+mOfZdVawRl7Abz3wViJddgQGB2Ks=;
        b=N7aQegovUp77iUCZNvuGKyJyLv6wUPpKV4qb3fRTiWHOv6YknvJmJjZY47MMv2iyyQ
         RKXiT3HqBexU5NpxvyBv12Cev+x1DMkQDoeWBmIZ2Xqp5tC0/dfKhtYqyfeB5r2mg/NT
         KXAi+mhhvV1LYkzDhCSQIB+nRKFYUHM/gynPpyg5V103P9PXYJpI1dojoau4+srLBDzY
         oJQnBLEmrwWufmlf8WsW6MHmZEmaFSimvnGNKpjDH7KuPusEYpINaZP7T3KOI3791sOV
         pzpf8atYAaR4i7wa8ATIIzLiEgC7YKqc9wkrmhbuBTpEll0Di1ApHLIW78TYSPfkI1sN
         9JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958649; x=1723563449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4YvSew0Q8gKBZ+mOfZdVawRl7Abz3wViJddgQGB2Ks=;
        b=Z8QR8W99V1S0FMVLLMnEbu0LeeqjUD7cKGOOsei4La1LGkhzaMPgdwzTqa6nd2Ue9a
         lssetXpn45/6S1WMm5LsO63F1fysLi5EVWosNSqbhZn6YiYYQb2jcUA9kyluGebZ/qLc
         ahYOFJarBr+NJvoD/8y7W/+nIPdvr3wP2KPD6LN4ZfqgCdi58rf02dGx3ImPhulZR/oN
         Iz7FBDs3EZsSKkaPUd5jN678xItViDF2vvvsQrYfRkvQ+5Cs5dMCyFcTVGpNd3OkefDX
         YE/IZRWwWBLtCoSRENh9yHjJDiW9Fx+tKeuN4/xBN3FHVKDsMkK6s/yKR4Q0X68zThIW
         zbUg==
X-Gm-Message-State: AOJu0YxAttqT4NbxFIOUqp30OpRBrT+55UywRNJ1uRnfVRZ/WaiD81Kx
	AP8CsgcCpax8FK3LmS4mc00KvtKPemJnNus5957XKbTEk4PnDImb47OkAMBLEKMAoNkJ+a8RlPb
	D
X-Google-Smtp-Source: AGHT+IGC5nPE557Mj6UIRsBmoOXH3p20xBRU0FRvU1lVP7sTFZ7IUqSUA/LKq6gBZvaEhsxKNjXJBw==
X-Received: by 2002:a0d:efc3:0:b0:65f:93c1:fee9 with SMTP id 00721157ae682-6895f60d519mr163826717b3.9.1722958649243;
        Tue, 06 Aug 2024 08:37:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0fcbe907sm15813377b3.30.2024.08.06.08.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:37:28 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:37:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/19] midx: teach `nth_bitmapped_pack()` about
 incremental MIDXs
Message-ID: <ff2d7bc5ca079dcf9b571822227a578ac0072952.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

In a similar fashion as in previous commits, teach the function
`nth_bitmapped_pack()` about incremental MIDXs by translating the given
`pack_int_id` from the concatenated lexical order to a MIDX-local
lexical position.

When accessing the containing MIDX's array of packs, use the local pack
ID. Likewise, when reading the 'BTMP' chunk, use the MIDX-local offset
when accessing the data within that chunk.

(Note that the both the call to prepare_midx_pack() and the assignment
of bp->pack_int_id both care about the global pack_int_id, so avoid
shadowing the given 'pack_int_id' parameter).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 64a051cca1..25350152f1 100644
--- a/midx.c
+++ b/midx.c
@@ -311,17 +311,19 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
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
2.46.0.46.g406f326d27.dirty

