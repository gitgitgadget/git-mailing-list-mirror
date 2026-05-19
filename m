Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A83403E9F
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207168; cv=none; b=YObb/xNr8oLQjFYNoQ/96NF5MouvaFWKgCcQ+5llEeq3Zlfd7ATeTLSOtX0Vs70w/8agCJDEhnPlPucReiZgN4BxIocTce2HhzYqpHqqpbxtCNpBQYVutnizDJ7Bd8hxV3xjILcXcYztmDIaFzhCJAcirrjkYsHuPwDO8m79TL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207168; c=relaxed/simple;
	bh=acT59jyRJi5EosDaPfza7QicPDTUJkldWLZeMpDziP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBeVnVPRQScG9ap6DZD7EpyvHdV0bQWOrRWymWQfsc6nW06oK3CJTFtwhjpOkENz+ev0xvD1VIEVbaXQ4sQvVJkw5jn9NTrNzOk91MMC1zfjVmdrjt8ZeMxglVU02IpVyb9uj4yzjUsruTuVLz9M4SLtbBSsQ/crHYtLr9Pqis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ZOxnr41n; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ZOxnr41n"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65c37eafcbeso4152280d50.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779207166; x=1779811966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5J8XlejFgthetu2ZWx9ZSTcCatZT1ZdSwtZ70K84Jt0=;
        b=ZOxnr41nZW+y/WUquQHcha+lOSmVCzojlFijdtyzeHcRYtIgOfzGMPLOnp6dJl7diZ
         pN4jKirMiiOkILIU0wglP73K7rI56aoGYp/FTfcscgp8GhBF6FOI5TDMKIusL4h381Tk
         qI6rYCDs3EdF9Vx6g1eXoktzMhvQJFvmEblW7joz6oHptGy+AGdsIlMojTnhTDHJ75cQ
         mAv/Z6wuxLvVE8o/FwDVf5gOLy0zwNvAck5YAMKvIXndqGtbZ9G9gKBfY+XS1RtGzWKX
         e+m337nKrfdlo7uwDO39dK9L6EsmCg7MHhFxJlicbqyaa3VHiriVgTxQgLCPwa3CqrTi
         X2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207166; x=1779811966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5J8XlejFgthetu2ZWx9ZSTcCatZT1ZdSwtZ70K84Jt0=;
        b=NkDpgjkSE4EteeFYG8A1IsJ2/8IBU/0Zfg8af9YvHwyHtW3qvliGJysvFRTqwtBwe2
         rTKmILwzx/fBUGo3fElh57T+la4XelX1P9AtgC932/j0WhN6QMdsWDDiv2YD89q1irkZ
         EbxYdgb46OjtijXNptUmq6UxAL+A3UEZWDJ9iy7x5w9Cb+zpR+peNuXFbtao8cdsREpi
         oWSCTPlKOi0YsDrOQQUKzY++WutJ20+ixmGVzucsaVVzHzeVab4g7bDZ17SCiun6A196
         RCq0BPejUMNa+bvo5Qy0eQPR5XVrERSsRilxr5/uEyBSSPp2sxbZDwXgWI+/Az9OfYpM
         2yHQ==
X-Gm-Message-State: AOJu0YyfM4DntgqomuQeAj1Riufh3D6SgrLGr+b6oSJzFrr+OURiBWui
	/oRedinoV95Y+fuQVEE641AoVLrnn202TNV/kYhVeTeNh0ul16P9Hk50zfwV7oDpQ2b2iRSIPAr
	DPZenQM4LIw==
X-Gm-Gg: Acq92OF9F+tNbEOwFEsYe1jDrbbiC27C+3tL8mMIKt+Qy3Q+KI/m3aJh2EgYMawKEI7
	RgOZEB++ZypXrHSzZI7fXIFylewzHl3yVwOkS0OOX24wDOxvMscxyCsMzhSYMdLNYXuCQTWGUwY
	WNxs9w5+OFrtwJQzDfxIbIHe2ddo4FppXv7UHuOkq7VtPNcz5KfmxkliOsdqavM2Cb7nHPV5YWM
	oGpWqdWbEk1OsyO79VxG/QZRL5WdbEpjKS+3iu8cYL/E+jb6EcosMNCJasTggfOF0h6N2NX0+/q
	a1hoItSL1NxwE/s0WsaFwy3L4Q+akBX2cXF5hNRUeixoCynBsSTXiQO5mGhdMCN5eRScGdKwhdL
	lgqeoyhXvmTvaH/5GbIh9yF83x3Ogu3h9I40zFtsd7qdpofwizpqMi3xbCEZOVJkjqKlCCUFQO5
	zyP04PukRngOw9YIj2W+tRKut69ARaJic1m3FoVcywR/gJ3qWP78ZMjXry4WNQoJUD+zByoLCUz
	KHXo0ouCsKbTbM1SECTwjag7WRAgUD9gmbGfu1JKttFn/kvoQipq7EyJAt7mGWGoJsepOOZ/LaD
	lZ7IVE+eNBsHhuC/
X-Received: by 2002:a05:690e:1595:10b0:65e:1b4d:a7aa with SMTP id 956f58d0204a3-65e226fb9a7mr16873270d50.22.1779207165997;
        Tue, 19 May 2026 09:12:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d89b130sm8083999d50.5.2026.05.19.09.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:12:45 -0700 (PDT)
Date: Tue, 19 May 2026 12:12:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 4/8] pack-bitmap: consolidate `find_object_pos()` success path
Message-ID: <c9a560660949c53575a9b1e81160d25212a1f484.1779207127.git.me@ttaylorr.com>
References: <cover.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779207127.git.me@ttaylorr.com>

Both sides of `find_object_pos()` report success in the same way by
setting the optional `found` out-parameter and return the resolved
bitmap position.

Prepare for adding more bookkeeping around object-position lookups by
storing the result in a local `pos` variable and sharing the success
return path between the packlist and MIDX cases.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 651ad467469..6483fdc7daf 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -224,23 +224,22 @@ static uint32_t find_object_pos(struct bitmap_writer *writer,
 		if (writer->midx)
 			base_objects = writer->midx->num_objects +
 				writer->midx->num_objects_in_base;
-
-		if (found)
-			*found = 1;
-		return oe_in_pack_pos(writer->to_pack, entry) + base_objects;
+		pos = oe_in_pack_pos(writer->to_pack, entry) + base_objects;
 	} else if (writer->midx) {
-		uint32_t at, pos;
+		uint32_t at;
 
 		if (!bsearch_midx(oid, writer->midx, &at))
 			goto missing;
 		if (midx_to_pack_pos(writer->midx, at, &pos) < 0)
 			goto missing;
-
-		if (found)
-			*found = 1;
-		return pos;
+	} else {
+		goto missing;
 	}
 
+	if (found)
+		*found = 1;
+	return pos;
+
 missing:
 	if (found)
 		*found = 0;
-- 
2.54.0.rc1.84.g30ce254312c

