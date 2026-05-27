Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEA536EA98
	for <git@vger.kernel.org>; Wed, 27 May 2026 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911768; cv=none; b=nLlzLD/q3nbkOwaENaSR7sxcgRT+Gtru2Cm9Fa9dLCpKlrL8OgQmEKK/bRt5hbi0me/ZPz9d8rKFES4yt0cgGnEeIC1XAzlDac6s39lzqtbX6x5jUaxnQuns7Aaamacrm2o/5jfONEuGXee8pUqkFCedeHZKDtmnxX8dBOVtzkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911768; c=relaxed/simple;
	bh=sOlaqZnVzdO0NwwTb/k/iajKXqRr+ItwgcT8t3kbrBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iecmIrCeD48CWmXdFPfhE1NlIM0Ps/EZ/otG4fp7s9xRfcCdGkj+vMgkl9bzpzD4v8a9b7su1t8/OZlurMrSMCSdRe4/9ZmyxJOmfdUwNLX7wiPT7SmW03nEdXCLvK8g5tJmzO4Ex9QUeONie42ygrXnvv8C8Ox2w400fjtnKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nWNjPtMK; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nWNjPtMK"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bf0b1a47b1so126669297b3.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779911766; x=1780516566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCj160L2k5ZCdJpDKzNyYE8Pttxbn7cuxenarvLdR3U=;
        b=nWNjPtMKNYvgn6B4c52xFX2t8N6ynUzfvwpcLBwQnuoo8MyPAu9VzYQIzs5TDKMzgr
         PJwANGwlH3JFyBYZmrM3YullX7reAgQFdTPUkZkOfN/4oyn38Ikjcaag3W77FhBT9bJ3
         7kOdkp+yx3hCoveqNYLVGB+dUVVIZaq40Mp8Ve6SnyHkMHt8LN6ccnKz6kbJwyUxu2h5
         xdbg6l1XKTFZ/i2eRfhW+UqeAHK4z/rsncgStxrzFTH8HBhpAvqe8d05OvxB+UMwCu8H
         LTN5IYbDVdxv/WIKk0viiMrRyAHy7LVxR+RaLll1baaVcPxgHJgoOPTn7JoPEeaOPV9H
         N4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911766; x=1780516566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCj160L2k5ZCdJpDKzNyYE8Pttxbn7cuxenarvLdR3U=;
        b=PRafbXFewqpDqgsOOWAaihdx68NJ2qxmx/Go7p8w1j7WnWOqJTWEb/pnysHLnLDcyW
         ieA5U7aGqn7QvvFv/cMP1dR+NKjUlqm2woOfzv8RpQhEQOYiaBXZZuFcqOOMMARkkuGS
         KwtgO/aAJ7IIPJHvvrsNkxfHVZOnKZ3rzPL3j5nSJBUytuLE27u18aVSVpvXN5J0enDa
         LGsqChdjoJw7yeOZAOxW6IS1hefPloIDhnjtfQOkO/Gw7/KGOlpBby78d9qlIbKUxazS
         Qjs6EeNdm+vuuNGj6Xo23dhnHYpyiBJSf8RjbjwX5UOgMcjb2PpyAN1TGB3y0PEjwJsG
         QA5g==
X-Gm-Message-State: AOJu0Yxt7RvGaQrh17rshD+Q2aPGr6v8YBOlEiT2vIBcYRWm8/2bvf4P
	yqFezEvn+ytQhHDIJyan7tYcJiC2yhY7PSFLzl9zIKjJpbyhTZB59oT8ADfzQENpoa++zZuPhOd
	DE2yevT0=
X-Gm-Gg: Acq92OFRZ4d5rwX/MRNpgAbEpDKe+R5apnpJfPM9RcQ9wjJLu+ac06qJhh0iOg/JGBO
	kT2N/TIv/y5cTUR1oRwZQCj2TOeX5N5D+6U3NDZRbSaTvQDOhk9lOs6x2tACaxkgtZeExKILfuf
	IJ5ZQDkz0fWag/Bw/HeaRmVgWKkJrgCCP6AtV29V15UNy4KZsjlTCBsA+HSc+zJQweIUcjy4CUC
	TgLLT8iaCPA0RIeGHGmrptfLTbP3qM8t6iw2n4BrVYXI5bAkZeTKDN2maY1Z6PR0d/HSeB6PZUY
	TkVluH+LfbOiBDg30/Mc8p2saXdpa7n/9SgxSmdasDrsgUMKD2trIcfJYGwC7nl3k1PfbtzV0Pw
	D3DHMLtRRWmS6WNMLp6OSERQdIU0pUMBXRZOX+CKfkzGg8mSwR0SY+gJrwFd5hcVuoXXctsSJ08
	HiCX3Pe8e85KhoCF7nFFY+R9rwdkElxUcuiCvxD2HulyyznpGT7uoBX01IHJ7W78iK0mxH9r1WP
	LyiiTXVN3NBW4Ck8nIT5+KPVVW8O2nFc03mBmXxknjZk3gqSP6nCWQaTTVAoz8OSlSHNy83bljK
	8OukFG4P82fSmvGuZU8NwapFCz0=
X-Received: by 2002:a05:690c:9a93:b0:7b5:88ec:91b0 with SMTP id 00721157ae682-7d336cb453emr241313517b3.48.1779911766534;
        Wed, 27 May 2026 12:56:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38be36898sm78921727b3.27.2026.05.27.12.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:56:05 -0700 (PDT)
Date: Wed, 27 May 2026 15:56:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 6/8] pack-bitmap: sort bitmaps before XORing
Message-ID: <b1184792d23b2d24309d09f476cb0d93f8e81536.1779911733.git.me@ttaylorr.com>
References: <cover.1779207127.git.me@ttaylorr.com>
 <cover.1779911733.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779911733.git.me@ttaylorr.com>

Reachability bitmaps may be stored as XORs against nearby bitmaps, up to
10 away. However, when callers provide selected commits in an arbitrary
order, the writer may miss good ancestor/descendant pairs and produce
much larger bitmap files without changing query coverage.

Sort the selected bitmaps in date order (from oldest to newest) before
computing XOR offsets, leaving pseudo-merge bitmaps alone (which we will
deal with separately in following commits).

On our same testing repository from previous commits, this change shrunk
our selection of 1,261 bitmaps from ~635.46 MiB to 176.4 MiB for a
~72.24% reduction in the on-disk size of our *.bitmap file. The time to
generate the smaller bitmap file decreased by ~3.69 seconds, though this
is likely mostly noise.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 4b6fb07edd7..66282ea14b5 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -327,11 +327,40 @@ static uint32_t find_object_pos(struct bitmap_writer *writer,
 	return 0;
 }
 
+static int bitmapped_commit_date_cmp(const void *_a, const void *_b)
+{
+	const struct bitmapped_commit *a = _a;
+	const struct bitmapped_commit *b = _b;
+
+	if (a->commit->date < b->commit->date)
+		return -1;
+	if (a->commit->date > b->commit->date)
+		return 1;
+	return 0;
+}
+
 static void compute_xor_offsets(struct bitmap_writer *writer)
 {
 	static const int MAX_XOR_OFFSET_SEARCH = 10;
 
 	int i, next = 0;
+	int nr = bitmap_writer_nr_selected_commits(writer);
+
+	if (nr > 1) {
+		QSORT(writer->selected, nr, bitmapped_commit_date_cmp);
+
+		for (i = 0; i < nr; i++) {
+			struct bitmapped_commit *stored = &writer->selected[i];
+			khiter_t hash_pos = kh_get_oid_map(writer->bitmaps,
+							   stored->commit->object.oid);
+
+			if (hash_pos == kh_end(writer->bitmaps))
+				BUG("selected commit missing from bitmap map: %s",
+				    oid_to_hex(&stored->commit->object.oid));
+
+			kh_value(writer->bitmaps, hash_pos) = stored;
+		}
+	}
 
 	while (next < writer->selected_nr) {
 		struct bitmapped_commit *stored = &writer->selected[next];
-- 
2.54.0.rc1.84.g1cf18622df7

