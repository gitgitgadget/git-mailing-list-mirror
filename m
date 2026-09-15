Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F991FB1
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452618; cv=none; b=D1qoundS096zB8yDE3k0rJyEXaKAfJ8pn3Vdaxq7Ip7LeVGQl9g6MkMyfsXbPsuugpEIIbDpFeU2corvOEO7g/89cQF3MQaXPOH6BvS4SJ8CXJAymSOmDcsCDKk/R19IfYSQRe3sOyBKFmKQ8M4nK+5Ag9IA2DzQ4lRNPQl8XrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452618; c=relaxed/simple;
	bh=yX/sC3kB/tMT3q6qt0OBsLZ9tqZ+OUq/CuVrVUDgEe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxtovoupQQHHQYehrBu2tzpoDSKVq29EQOK45hd24SAM2toIu4nwV1xnIA5Bl90+vhqm7ns+fnaT1hNdTVOMbp2kuTn1zUJ7gNNdK7pt/8dDtn193txfNxsfjPjuKkzFhtDk4i7Oa7pibvBhMa08n7hkRvFkEaG8ck72nrfRk70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImdAslx6; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImdAslx6"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ff2313so210483566b.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 23:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789452615; x=1790057415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pjQ1jw+Pcry5yOyKdQcVCVtQw/hIvnPEcF+7tCe4ycU=;
        b=ImdAslx6K8QmjvzJV5CjWDwhjgMznlYEfcJSg+04NdlDQfmYO7wWu30NqZdIpzsf+8
         YcLOD2hK/h+VUg/0yUVv9S2sn7GaoOFLlm3KC2lOzSYx1ladp42LyE+h9EJQzqVvlyFw
         1fAd87WZiDzjo8EBI3LN6gYUwDnwJEWvy9kuLnnpdV7fnluO04i0K3FV0bWf5rgtGOg1
         SaH6YGNUCz6Y89WEzbI0aALZIXP2CLaThScdW2CadhVwLm1KGobptHOAccrk1p/iumi1
         LMv/lElOBaDDiegCsTqCVsnT/NI9841vwBwiiTg8e1FLRk/uNshTa87k6bobv0pa6Rm/
         E56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789452615; x=1790057415;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pjQ1jw+Pcry5yOyKdQcVCVtQw/hIvnPEcF+7tCe4ycU=;
        b=PwI+1KKLGJIj09qbFG2RDpxjGtfcipi8+PFMO7fq3ZSmGcxdn5epVEP5HGkOqLnb1t
         uYJLo+RtqAlKKTmtr1NFx8F3EbgheaqHNstjZ9/55RDsDISFZKEqdefxtuXEgI//BVJe
         zvCOF73Tapf10+Rud+HQeMnxOwIoVASPgbswbGBQg6qp+6HKpraqOEWxoxejn+8mvMFN
         RD0IiOXi4KAvBid/jvaKqMrXAp+L+9ODFAzEmHzSe3LCBhAtRadfk2JANuIE9zxFrvBV
         DSrD+ZmzecJiVqj/ZrUv2t+WRU0yoxTJ+ujPTgJyF+5JnziBMw02Mw+H/URY1nUm7gVW
         whbQ==
X-Gm-Message-State: AFuF++lcwWqe6L4VqZ3XLgxzYZdmyBqsAQYCH5zZTnWWbaK2gayu2wmq
	yuiHfjI9cQD8ufhp475FnGYb8N7WGCvvuH0uST6mdLOPq4vdy8dQ2THfysdm9Q==
X-Gm-Gg: AYBFou2q0xmKk5I8NAyRdMGDx+rczmeYViTKo2KPkIL74ShB4lHrwTDi4BXvC6yXDa8
	wln+RXqlX5+UZokOnEFZxX2xB9OX0pDBIEc2hbTnhqK8o5jNiNt+M1OXvIK108hYve/UiJ5FCeb
	Kijf/UkTOu6z5SVJzWrFnZe9wP2SkOmLmTnowSMHBUAGZnLEj5gPIqEyACA0CD0JYKCld8zPeav
	lnfatMpw4NCUhGLqNmYhxYpnEVTYgH94nkv67rR9Wc1EVNVo5xLUf+7MV+fuJ89eyuKcl47S85U
	pPiml+G6zHI0j2uFRwi9Ss/DIIMrNmqB/9NJG5B1v0pp17pKVWvA1Hr+sasop9bgrFXYnEZNQZ7
	Y1OZEOUU0nt7/owRhdpQFDMa9dfRjrbPsTo2nzAnkrwtGpo+YTqrk3HsWONOu98hNYR/S4PoVCs
	GzJ6YGhzyI4HkLuf3fj9N79Aq0fRoDrM7/Wzf6S4r8HcY2RFdCsM0lPxJAq6VJUsr0tnP2Al6na
	wsVaGv9R63oU4wTSxG6d1+OBHd2
X-Received: by 2002:a17:907:3e02:b0:c24:d6f0:aa0 with SMTP id a640c23a62f3a-c29c89d1344mr186846766b.11.1789452614975;
        Mon, 14 Sep 2026 23:10:14 -0700 (PDT)
Received: from localhost (78-131-17-112.pool.digikabel.hu. [78.131.17.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296605c2bbsm510430866b.24.2026.09.14.23.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 23:10:14 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/4] Makefile: remove XDIFF_OBJS initialization
Date: Tue, 15 Sep 2026 08:09:49 +0200
Message-ID: <20260915060952.569535-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.56.0.rc0.467.ge054dd0dd6
In-Reply-To: <20260915060952.569535-1-szeder.dev@gmail.com>
References: <20260909195006.2179119-1-szeder.dev@gmail.com>
 <20260915060952.569535-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Object files under 'xlib/' used to be listed in the XDIFF_OBJS
Makefile variable so we could build a static library from them.  This
static library was removed in cf680cdb95 (make: delete XDIFF_LIB, add
xdiff to LIB_OBJS, 2025-10-02), along with filling XDIFF_OBJS with
object files.

But the initial empty initalization of XDIFF_OBJS remained, so remove
it now.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index d4b775953d..7d9ac15c74 100644
--- a/Makefile
+++ b/Makefile
@@ -695,7 +695,6 @@ BUILTIN_OBJS =
 BUILT_INS =
 COMPAT_CFLAGS =
 COMPAT_OBJS =
-XDIFF_OBJS =
 GENERATED_H =
 EXTRA_CPPFLAGS =
 FUZZ_OBJS =
-- 
2.56.0.rc0.467.ge054dd0dd6

