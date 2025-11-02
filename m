Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972CE25D209
	for <git@vger.kernel.org>; Sun,  2 Nov 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100303; cv=none; b=svwGaCMo+OccuyQJeShxK97OZ0+1jkG+5MVj8oYfKnX63BCfvrNt3l/gELcMp8HBkUkuNdsPwA32DxQDe4mK6rAFvgCpDbfHHaosczmZvWJecQ6W3Ixr005xD4W35M/cwHjGoU6Zg60SLwOWG7jpw6/DMj1IHAOgWG0QdR+iiIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100303; c=relaxed/simple;
	bh=1yXoKv8Co7nHs4pXTybowpMH/+DSExuBYWdvRfRuDEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/gjt1Di7UwbqpvymP3CSugzh3jPvsqdwlQFbw5cFeo4flX7c2ZEWqMKHso1uuRJEJkFZf90099jQSzL1kwvU1KGI3/Mv6P6romxuurr0UnOZV2z4r5YeiUyM0YYZs92JWEL/h/VvzdKa8XYE7goA2VvryBP2PXD0jmJA/D6u8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG0YGrjl; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG0YGrjl"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63f94733d6cso1854383d50.3
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 08:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762100300; x=1762705100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3VPrfFOfh89vUyb6Z/vF98t/MA/SWR0wy62zJvTr+E=;
        b=HG0YGrjlkpgISS0N8gWB3y6vSxt18RQgGofRntVmhXxv8bKZs5/4hpOw6ipB4uScD8
         BzO0t69BoMezzWtg18k1/kfIL1yAmBx9JPRQHN2MUjNseTUhBTnk2rBsuKdPuwVHAjWj
         Jo/1Xu30pEpVULfhHXFIqt9OL8GmFIuHVyGKzpw7NhyJLlRdXQbXiFR7721KfW+KufNv
         s23kqy/rE+MeVSIm4fqI6fk/RTMlfJ7+bQMYWZU/lh1EDFmH8umLaBx/aARCPezTPYqM
         rmdw0i35n0Rew41ZO18BK6OnQuGnseiAYKeUjvcJWv8hHxqEZDkhupKuCQcoj5IZ8I9S
         NZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762100300; x=1762705100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j3VPrfFOfh89vUyb6Z/vF98t/MA/SWR0wy62zJvTr+E=;
        b=MdXCa/zWoGYq54MILsc79uwxgzpaVTenxsLqwXZu7gBQck5X2k3Y1uGJgYWgOK8jQ1
         tv+lUmIBUcsAb3iU5LZVqWdSdTKuZJq1DOS3nVhWUIkYZpxjvLSyc/9acqW/zqxrOLsg
         yOKpTKW0p6VG0k9es2Rp54r/JnlyjOrbCxBwnvcCveZI4KkeiEIxe5RQWWpLPcESSXrr
         PyJVpTL9ly/g/prYlrDiqWU4hTvd0z2mIS+zhJRxiILcDzFC0f3yjKCGMJvmKTBYm18p
         Dfj3wK2faGiWbvhveNrZ6R6nyXrrK18XzyHlBLjDteZ8WxU/pmGZ1BLPlAlebwKpKBq7
         tO7g==
X-Gm-Message-State: AOJu0Yxygy73HSZ2VByaMJJ3xEjlWzPimtLDvFva8Xmr8SJ1RyLfA0Sd
	mhhNSFMwHhoWbwjzBbojKCD9E0idI/y1gzSRdNJvdpVz3rZHxfEhBlC2HoWO6zKQ92o=
X-Gm-Gg: ASbGncvi+U8l5Z5zaaFhE8bvhwzqiaUpOSKv+GKVtH019ANwq1R16ukXstWu708DYOW
	oXezNSFK8yKePWE5cX3Nzx2rn8uG2b7LzKbRmAo2AirR/yxhePay7ZsN2yTN9jad7D9bwpX/x2B
	53xdhsHtyTfdABdZJHp7pyL1Mr0d5a+R4j5QL5zcsWt5wV9dyOMClM09+eq0nGBFDq8V/c0tHbS
	Gxk5GCqU6IlnZ7QVAv7jMF8I348R71eUKB3KZ3RTmukvZ5BkX3KAggSkbblCEO5lDBuiw0MkHRf
	z1Fux7QklMgJ3hx9Op3NQssSsH80sES/ANIgzwzG68WEWuKIAdKlrpqDL34AvosO5eygSTtWBfI
	Dfjzxx0suvScM5efIUi2kZrVDFhe36LFziVHxC29h7PphAmgh10AFC1tn/Ej9dI3mS/64IyEcTa
	RcqqJEJGNizL7FohobRCmyyx+drm4SqM1Mr1X39Q==
X-Google-Smtp-Source: AGHT+IHkmh3AP5gHBfMFwnY4rbXiOEj1UIVWVdTUSpmmDJbojwZZWiNmafiayjzU46S3/qzEZo7A/Q==
X-Received: by 2002:a05:690c:399:b0:786:6a33:a75c with SMTP id 00721157ae682-7866a33ad75mr56519697b3.27.1762100300341;
        Sun, 02 Nov 2025 08:18:20 -0800 (PST)
Received: from macaroon.lan ([2605:a601:90a8:8b00:c038:e715:f394:297e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7864c6185c5sm22626967b3.32.2025.11.02.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 08:18:19 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Elijah Newren <newren@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] config: use boolean type for a simple flag
Date: Sun,  2 Nov 2025 11:17:47 -0500
Message-ID: <dc4e2b9c65bc4fe29b4bebf9b0305b501bbfb9b1.1762100242.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1762100242.git.ben.knoble+github@gmail.com>
References: <cover.1762100242.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 71b136bf7f..f1def0dcfb 100644
--- a/config.c
+++ b/config.c
@@ -1278,7 +1278,7 @@ int git_config_string(char **dest, const char *var, const char *value)
 
 int git_config_pathname(char **dest, const char *var, const char *value)
 {
-	int is_optional;
+	bool is_optional;
 	char *path;
 
 	if (!value)
-- 
2.48.1

