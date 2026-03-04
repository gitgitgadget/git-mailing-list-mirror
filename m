Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54127A133
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629577; cv=none; b=IzSRSbb1C6choypO0utMtnrIRCJRrusiitMrSxNMcSgAwnpmVUmh1jc3wMR7Lz39L/NiZsQwh68/b+pzAQCLzrKK4ba0KLkXHJGnQulC02QRucvG3VEldub69gB2ZA5Ng9wq8Uc+TDM6iM/p7zGvQaRA7zOmLNbFMXoEhJ9b1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629577; c=relaxed/simple;
	bh=tnUwt57+t07TzjXX2EiyZ/WmjFgyEVVDKWyOXqXe5bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIBb0my7+fJiT01aff9Y9pzGkSW06laLlVGB9i2qiOm/ubExAeKCUD2ep0hrIku2DLhusUIBgie0M8s7M7tivpzZb0vNwIcJB/8avZDE5DWFZiEifZdqMrRD/tmY3DbF24pj0zHcd8p61jNZcFM3UAnzRIfA1t1/jNG7jA6BYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9Rx/wT6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9Rx/wT6"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8273e0fb87aso3808829b3a.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 05:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772629574; x=1773234374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzJnlgdPCXzHRkBzHFluJrX2uo8AIhSoz8jt2+gQMkE=;
        b=R9Rx/wT6eaL3BJh20Kr/bItOQZflU6Uk28o4xyanEaRxfUeeE5gRoTr7bj8x0YIjiR
         q3PQyqspkEZChlIU+FyYNSd1zHU9PiH8nD6lbhkYX0JLJ8ko07L75kLVgk/iS5D05kzY
         WTjJTdivLm07zavEF6r9GPQrwQb1a17iWTr4lqCAR74ZhfGoBA+3ixsC9Zu+/EriBdOn
         neg+wRC4BBwHHhrYFp0LaQgi7xuQ+o/t3AdJjdVR5kGaZ/oGoWjwXohLZTn/EUjiG6xe
         3ctDTMcTKmNwqd154vXgcXFeD4kKAdFLsdHH5xkLJUy70qiSKx6aUbMW8NNJeHH2E1qk
         e34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772629574; x=1773234374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LzJnlgdPCXzHRkBzHFluJrX2uo8AIhSoz8jt2+gQMkE=;
        b=ECaEAhYz9AjH+y2ROI3D/Nelaz3Bo6CFOu1r3EWVEuurhN+sp8Ho35GH97ihunEsvb
         86uHMVnf8StnwgKFmImENiA/sNiScZLyRHoobuvs4T1wxIwkiIBlYc8KabXysCrZgn/4
         psZj00ZDRRy2xki6QPrr1TEHvjTaNWp1BzdLyQTwsFM08aRVegd5J3mk3up0wfCCf4g1
         Vz9XH/PdgC0vHcNs7hwLOzaks7SC1lV5Dp/F0sC3ZGydysuOZFn2OrLqqdlwxBSgNJWw
         74nrQJwjeL+VhVKmOwjMN0cf0Llb7t2F3hSuE0nQGRBnahiNpXP44QWrLI4N3FM/Zrh2
         MaZg==
X-Gm-Message-State: AOJu0YzZSBCRqZF/vuNN2CXAwqlRMh/VWkrKRuUCnb/7xEz+4+yfSH1p
	shRAXdc6kAnzouPnF7WiKlYbBybc2ivUcY4k1DXAsXtKjIYTybbeB0tTieCi7bmC
X-Gm-Gg: ATEYQzwhYRgWx/GVl9bl7SuCk6RnOY62oY1rHyXXkPVrdUot6A+41ie76VbXG0Vpi96
	pTvNmvzIdg/fpmikn5+NUP/+rcpe6JjlZYlzQDlCTfUGl99arTuGsFI0OXqGp/4fmSw5KvbVgst
	DFXR7WEhB+/cpBzWPanXPX8FpQCJKI5Frca5oPVxUqOaVEcUg9ljrDUeGW3H6HWe1vwa71uXyCy
	cBg5Y57TW+DJVmsDjjnhlkqm1fqZnn/gaXXT8hVg5tVvLahu4VsTX3gKQW2FuJUff0uGMy9Mtel
	MYw3KYAW0osUXVaA94Q/H2KZmU1V7ElNWvtl9vsTNggiqUM2UK+RQoxD3Jvy4hehb9CSxbj/qK7
	urSaA9nOOyRKzUjK4kAlKL6CKqnoUC9DNro/i9v9z2UNuEsquG5sTqNYlKqCNd/xPVBGPCzGiY9
	yIjNPZcQiT//qKPsZmUGRxVuLbryGqXc1W6zdPtyll8RVRbyQfglzAodsjMvwMxvVGgVoN6GlbI
	kYrpx7twznWniF+fnypxetQELK7aYQ9
X-Received: by 2002:a05:6a21:1f88:b0:37e:7b59:6475 with SMTP id adf61e73a8af0-3982e2614e7mr2046108637.61.1772629574020;
        Wed, 04 Mar 2026 05:06:14 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa3756dbsm16473717a12.0.2026.03.04.05.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 05:06:13 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH v2 2/3] path: use size_t for dir_prefix length
Date: Wed,  4 Mar 2026 18:35:01 +0530
Message-ID: <20260304130502.8475-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
References: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
 <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strlen() function returns a size_t. Storing this in a standard
signed int is a bad practice that invites overflow vulnerabilities if
paths get absurdly long.

Switch the variable to size_t. This is safe to do because 'len' is
strictly used as an argument to strncmp() (which expects size_t) and
as a positive array index, involving no signed arithmetic that could
rely on negative values.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index f613d8bbd1..56be5e1726 100644
--- a/path.c
+++ b/path.c
@@ -58,7 +58,7 @@ static void strbuf_cleanup_path(struct strbuf *sb)
 
 static int dir_prefix(const char *buf, const char *dir)
 {
-	int len = strlen(dir);
+	size_t len = strlen(dir);
 	return !strncmp(buf, dir, len) &&
 		(is_dir_sep(buf[len]) || buf[len] == '\0');
 }
-- 
2.53.0

