Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BEF286415
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727719; cv=none; b=gkrI//k8gknNqPBdzzMGQtB/C+sJt7kpsvh9nDEgw71jUydRyBUTeOk989TXGtz2DyOYXGTpIen38cnF/26cg4T5B3P/XNA1P0NSYzsOTY35nGl8igcM43/hw2mzxW+8r0j+VYk27yJFNJ0YsNBvPi3UmrjYzdcujy6rEqjZkQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727719; c=relaxed/simple;
	bh=8blFp2rClU5hZ0BrjMhXzftuumD2W//gdWWTnnoFrDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gm+nTmy+K8Q0pkDMcfqbAoFoKJf714irV/BdGRybhWT/ORytzUWzP/Sd3nSLF/UhFcueKe4rqIbU6iDTBPVxYh4MlOZ0Aa2KZRxP3km6qyNCZKBTWnI1SuiCF26kGCFL8X2xylH/j36t96FM/1Ux++Q0QsPOHmC9zEB5rZqN+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBz935hd; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBz935hd"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so36998235e9.3
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 17:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790727716; x=1791332516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ovuPppVz9KUpRnsFT25WzK+I43HBBne6XCLbXY4an2U=;
        b=CBz935hd2FV200LuCuVc4C8U9Fk9uXBxjSn26zAKLiU9qJzFC/PmvWTQRXqdPVy14q
         S8x2JROKZvuvh1/oWkcVChhq8CLEHalQiZg+IrzrscxGF3XwIiu8m9o4QOG8Je9vFUAQ
         Jf8EBq5jsB5KGqSUFaMj/aVzdocpxcvJNsOvNU1DoAzF0borPDvjklzqYKcwxZTAExqE
         1RZ16sYmFgGMej8LXnn5xgiUcMIXE7pa2NM1DHmVY8avzXUPsOzAtA0nPDhH39BVVPVw
         /pp24ZHeNbl3yaURBGNFS4AWxNjiAip3jMCbfutZueHX/PtyUgCPhlmKTRfNI4uu6W3w
         +lOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790727716; x=1791332516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ovuPppVz9KUpRnsFT25WzK+I43HBBne6XCLbXY4an2U=;
        b=Oj8D09TROLHgMDh0rLOdBol7MB6Tg3ly9V65ykc2grUwlLa6fyOOm3vFyj9LkamCTF
         MNgib4mVUDkjKCxCBbcD9JaFfHCNKiO8QAdr2JzfqQQ8eMio5ZFzURI9A+jYknqoNMvX
         AgOtNz1mtNXOT/3RAYbgs8lDKP5jTQ1ExLgWIj7Wa2/I/M8TK6TTyKfE+Bjv0JYdD7Uy
         WS1HghoWrg1rfnJf9S1EUcCwpDDKuZMHGo4w2CuC1SbzP0hjAfJtAR8S1OdQYHsluK3D
         4nmFqHZNgOYuCh8+axLJDOxQ4zo30ZtLt7ddGawi2l6Vr8Hxj+R7KhGt3feYFTzbmBaH
         Di4g==
X-Gm-Message-State: AFuF++nJxxgQTNKLbZKX/2hPEZDta7+ulNyrxOs3hXdyMu88jOSmDITX
	baUXVENIRt9PTjJK/FCq+TqBl5Q8FNtPgrVVkyCGLHNDS7oKFPwZlo4o
X-Gm-Gg: AYBFou2m7dn+RZhbFGgAYp/MdT/m73I9eByEXJnrivgVQO7Li1XrHdhCS89rs/NBn+s
	F80R3zLwuhK9vIB5jG0hUXw84VDgJPiwrno4E+DmLfdPH8TPbIVBWow7ZPuIy6GWVtLmwt/ZfBT
	xSFTuoHGN9SnFMAFhWIFuh1HUXsD3H8q3YgUZsTcOncXs6ouRoO09vFbi4blIwDSz7rulNTjDAC
	RAG03EJKYA2RJTRpuGCEaqVGAGacn+qZM/mLbGujshHNmE3Ox2LjDqux2WNa7Rct2O0VXeRaXps
	ayS8SMgdgYcPpIDmWtKu3P0ivsGLVENrlF++F8VPz4boAMN17NIr1u0Fl85KyC/Z621kW/Te2I8
	A+e9eRrc7woK6318ksMcLr4NkkldauqNomNjlI5RdIKrci2w2xLcHdBIjzPBHlwrBrAOhnVWqhk
	Zj3zUBe8TA5a3lC6aYCDQb57v0AWylEQ9FTWIwKSOs7udd4dKHeiHRD2x2mxsxdwivJZd27BOhi
	Kdr9dITAMfG9hGTDGiWOteOaukXHgKxtokwuQL+1dvJrpsKV3VSSGjBcSbiRhKuJpOsSX4goV5R
	MLZyUbiWCEgBk69h1vQD+5VHj6SjJZJBwmNlGKg12f3kRDgeVuUqF1dbLWs2scVU1pEKa9ZhjrV
	25Io16/FBAhQNYp6bm3WSyA==
X-Received: by 2002:a05:600c:3b85:b0:4a0:1d2:1a88 with SMTP id 5b1f17b1804b1-4a015024df3mr13792995e9.17.1790727715626;
        Tue, 29 Sep 2026 17:21:55 -0700 (PDT)
Received: from mac.lan ([2001:818:c665:a700:4e1:afcc:bdec:a44d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a015cde27asm5135615e9.3.2026.09.29.17.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 17:21:55 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Wed, 30 Sep 2026 01:21:46 +0100
Subject: [PATCH RFC 1/5] transport-internal: update fetch_object_info
 comment
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-backfill-dryrun-v1-1-1128f247ee01@gmail.com>
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
In-Reply-To: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The comment describing the fetch_object_info() callback in struct
transport_vtable says that only the object size can be fetched. The
object-info capability can now also report the object type, or
neither, to only check whether an object exists on the remote.

Update the comment.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 transport-internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport-internal.h b/transport-internal.h
index a10b27cc81..626ceaae2b 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -48,8 +48,8 @@ struct transport_vtable {
 	int (*fetch_refs)(struct transport *transport, int refs_nr, struct ref **refs);
 
 	/*
-	 * Fetch object info (only size currently) from remote without
-	 * downloading the objects.
+	 * Fetch object info (size, type, or none of them to only check
+	 * for existence) from the remote without downloading the objects.
 	 *
 	 * Uses object-info capability of v2 protocol.
 	 */

-- 
2.54.0

