Received: from mail-dl2-f39.google.com (mail-dl2-f39.google.com [74.125.229.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A969A50AC35
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677529; cv=none; b=OrwW88ocoyLvm15f5tvqAjpU/yVtfv4S9cMNPhGvw26XHJ6aNiMX1zWJc7D1Xd7QpLfyWNJ8VShuVJRyCIb6+YYxfhC4Qx01fvXWpoUDnVlK+veKdKNuunD7Y5/GqYR4mx4aXQlCqv2Ghs49LksgHr9X4scmbVR0ibWKC3urWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677529; c=relaxed/simple;
	bh=UxrMnN8kxd33GH0iUakqZ4trpq9dm0hpsLrbTg6s7co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gABGZOi+tqhP1o23jlQ3JBP6CDeAniGsAzy5feu5rM9ZduDxipUhR/UjXlfrpnup4ZxYT2AWeykizW/9iRZw7V/SytrtEWVA11Pp3zhl2tRi+Vwqxa/hob/N8c3GoSf6do9cJsA7PBF5S+rqGosYAlPuVEIfkkMBoxT2yAnmxh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZ/6jNQz; arc=none smtp.client-ip=74.125.229.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ/6jNQz"
Received: by mail-dl2-f39.google.com with SMTP id a92af1059eb24-1438cb9b3a3so2720880c88.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790677521; x=1791282321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJU0IkQkK5SjvctgrcOqu1HunXMDdCBmOeyaQbUSRL8=;
        b=MZ/6jNQzutvaA5PYmLKCtJdm4kol2vGfSMznV/Y7EaimamWT8+zb32LiaTslPDomNl
         9mPtAMQkfknRAQYabOZhQ834qHyddMlGThCzrFKiK7Yuu/pd7a3n7yioIHYM0GWg2R47
         /n2h5W2+J8QDK6Q6GpEDgn2uVVOkDLQkM82vymr3UdEBXsQzCDQAVqqXxAb4lL7iIA1y
         cJ/Sl8xVI9+NJSfF8VbemjifA2wJ0NxYhjDFuPHce2dBg1Fvr8l6HsvDjkdP1p5StbWP
         bdz9t5MfVgfR/51fS1s92QwZs8Qw9/Zq7NYL41SUJp8JhyNXXy8xOPsqGWGxK/Cak8/7
         wMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677521; x=1791282321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HJU0IkQkK5SjvctgrcOqu1HunXMDdCBmOeyaQbUSRL8=;
        b=Gh/GimtGwLkd7yJFm00bCk6MnIo0dQ1MtpJu3s8PDR8YTvTkvQBdIIQv5/8qzp0Hdm
         Tkp5YhylieW+PwQfxsH57Qf2zhbB0Vj34D6K55XYhLNlzkBLAsQPrgejLOcE9EAeGcgB
         JjXkRS1gF/pEqaK4Y3ivgSoCReR+1Iz7tj4KUCz1B181Pq434NDHNp+pDbuNPmgvTNWQ
         ha4UcI8L+FVNS4Ol9RolXiINM+2iibdJGXjMZnDj88aPBtazNHAwmgno7VVlOQqF/i0l
         tBV4TrEILHhw/eg4MJ7clUPNbfJct4od65J55iMPwAOTxOK3vGL1pyIHrqM87hJes8Ir
         5R2g==
X-Gm-Message-State: AFuF++n/ByiMMAmsSU+a8ndz3OJ/s8NCEzzUMnv8IaYIgwXc9mF8XwL6
	+lkQaKjqaGFL5Dy9m7RX5n16vmEWGTt+Z0JhDz3zZqE0/2CekSGcft0JpUDp7g==
X-Gm-Gg: AYBFou2w9uTBQ+z9j1Y1fQyvxmgS2AMC6YsAGkJ5hrGcmrmQLsB+h7hWHBdSIHJbrVL
	5jQuVyAinu59AH8PiZuzqzteJi5Lww3AdaByk9c1kHGkUoNUqLjqQ8XgMvukv8PHRNQVMmrLusc
	a246S6h0pkndF3mpCb69uj8L5AicLqJyvGzWfpbjQ1/58XyB36SCtfrSMuQzBp/k308Kb3hq7jB
	xRIkMhUyaPNl+iD3eiXAgbzSsKYTRBW0L9zHw+9+J5E+ceOAkldOlInLwch+k/RduwP9FDzheMc
	ePUViOY1OPvO8EjvkomVwtMS/jUSTD3mVWthex0qxe003HstEYYhTTrq6yyRncEZdayMH3IWaRn
	V7d/hIg6tKuOGaq2o5jzcsmuErt51mbDWczuOrW3IG9+vjiKKASX/mlek7draNESMqB2YZvXGo+
	ch8tnXE861ZP1W3+AHj8UhIgUwrpPtgE34eIc44ZVr2HoIPqsBXagTTgkc9RDg0Q3Jw15Wr1EsG
	Q/CN9pN1qyiaP64j2KjfyDh8F7ySw==
X-Received: by 2002:a05:701b:451b:10b0:14c:1f57:3e86 with SMTP id a92af1059eb24-14c1f5742e2mr122919c88.47.1790677521137;
        Tue, 29 Sep 2026 03:25:21 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([2401:4900:884c:d167:a737:cb55:b3cc:523e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc45f03sm30417589c88.7.2026.09.29.03.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:25:20 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 1/4] setup: normalize an if-else to follow our convention
Date: Tue, 29 Sep 2026 15:55:07 +0530
Message-ID: <20260929102513.712181-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.12.g2c9c8d64bb
In-Reply-To: <20260929102513.712181-1-kaartic.sivaraam@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20260929102513.712181-1-kaartic.sivaraam@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The else case was not stuck with the corresponding if's
closing brace which is not in-line with our convention.
Fix the same.

This is a style-only change; no behaviour change intended.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 0d157ac254..e9a9ecda19 100644
--- a/setup.c
+++ b/setup.c
@@ -1879,8 +1879,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 		if (chdir(used_path.buf))
 			return NULL;
 		path = validated_path.buf;
-	}
-	else {
+	} else {
 		const char *gitfile = read_gitfile(path);
 		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
 			die_upon_dubious_ownership(gitfile, NULL, path);
-- 
2.56.0.rc1.12.g2c9c8d64bb

