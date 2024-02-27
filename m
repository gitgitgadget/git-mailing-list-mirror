Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50F1482F1
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046602; cv=none; b=exiiS1bzhqoVqt6DcvNCs3JxIL1gh4Iq0d5pqvh1DeIiyq3evVa2XTL49E2XPevPfDQuvB37zgerNxzaCT8qhI7RTF4IugdiRvpKac2DoKrPm8ip/zdnwddJ/I9Wj4v+RJwWAyVLOpIXTtQfLUrKNYtcRirnKYXa8inXrsN5cNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046602; c=relaxed/simple;
	bh=2uWA2uXeWzHsh13/MOYuUXhLONktCkJhJ4yJvsCexhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSnlGCp5EyjGCl+DC2ISDOK/O9gM6206d4rjH3j+dbqjvQ8FE1/zrp5Zuvmy30SBoiraRX4FOngeVszx6MashiutNNv4qeZooMH8lfSaFXrsRjU8IBJiVRjmlL3qUEeXCjY5itT/Laobr8cxjyRtIBSbV06j0CU88S8+m6m9/Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eb/HUfO1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb/HUfO1"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-787cfbc55beso142129085a.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 07:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709046600; x=1709651400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JKroW3KWW2sMO4OM8NPrJeitdYl/x2+h8vyVpo3a4I=;
        b=eb/HUfO1ljt5ZGO8fhFNHqAWBuFGXV3/Sch5BXZfwmKT7bwEYAvQbLzE9Dqc2MNBEL
         kIqAad9boVlGUIkHiW4+B0LWpEvCU/x5dPQgUdl3LSxKerjnfltFAu/0HplZ2F9HmXWP
         GBuK5cYNdr40yTxyrX1CSE8IIoIsI80BStZgG8lP7Njixpj4lmKw63AJhAVHaj9ahek0
         7ZWTyS73Is3om8B6tTO4vZMPiuBZzpqHwndnj/qUqDtFfjtVYeKxn7yG94ZeHiMx4QSu
         08RajR9YqGy+aHqkcpVNbxbQsxCbu6v2NoQI+kqsB2YEAFSir7jYR5s0vaHrv2M89vYN
         sbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046600; x=1709651400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JKroW3KWW2sMO4OM8NPrJeitdYl/x2+h8vyVpo3a4I=;
        b=F1Eah8jREw77joM8QAkpRyJ7z8gYzJiuX5rPDcRKPaynFffj9DsFCs7CvFqyotX6FA
         rv9yHMF9sN8duwOwwsVJCktkOMJtvd2l10DkPwozYRdZDYuP7iAldCDU0B46F8v4dDjR
         nItXAz3dBnXtkhKvsJVpgifN4rRZIlHh/hn4mph+d2GAOMrM4cDvfPXalWZxcZSIsvL4
         /Ml6zWRO3E4hjpANy/YgVo1LwiAvhG+R/wXeMs74FNuSqB1RMAzsyojw6T+M/pviMNO8
         UAdIdF/EYsIjk4Ug9Yh/MV0K7l07h95cxdpO6LqekWFJlLc69PpH2n7jEWwYQqqRmu+Q
         PhbA==
X-Gm-Message-State: AOJu0YwtwqLtcotFxyzBsrH4GGlff3QLjDvE2yWjzWr2Ja2fcLPyJPoL
	42h/PiYkOYOIAuB6VLYIK6I7EWaMOFp1H+Mzc4Gwxi16wLuSzke1aA2UoVGF
X-Google-Smtp-Source: AGHT+IEnR5rBnuuWlD7bDf3aRIoD7L9mgQkETfg9WTJ8aaaVzcsWzqR7tI7JRISYRV2CW8rKkiZcGg==
X-Received: by 2002:ac8:5803:0:b0:42e:87ad:9237 with SMTP id g3-20020ac85803000000b0042e87ad9237mr6718449qtg.48.1709046599750;
        Tue, 27 Feb 2024 07:09:59 -0800 (PST)
Received: from localhost.localdomain ([2607:fea8:3fa9:4200:ad2d:24a1:4eaf:e903])
        by smtp.gmail.com with ESMTPSA id t19-20020a05622a181300b0042e56fb8e0bsm3618149qtc.93.2024.02.27.07.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:09:59 -0800 (PST)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 2/3] builtin/receive-pack.c: change xwrite to write_in_full.
Date: Tue, 27 Feb 2024 10:09:33 -0500
Message-ID: <20240227150934.7950-3-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240227150934.7950-1-randall.becker@nexbridge.ca>
References: <20240227150934.7950-1-randall.becker@nexbridge.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Randall S. Becker" <rsbecker@nexbridge.com>

This change is required because some platforms do not support file writes of    arbitrary sizes (e.g, NonStop). xwrite ends up truncating the output to the
maximum single I/O size possible for the destination device.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 builtin/receive-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index db65607485..4277c63d08 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -456,7 +456,7 @@ static void report_message(const char *prefix, const char *err, va_list params)
 	if (use_sideband)
 		send_sideband(1, 2, msg, sz, use_sideband);
 	else
-		xwrite(2, msg, sz);
+		write_in_full(2, msg, sz);
 }
 
 __attribute__((format (printf, 1, 2)))
-- 
2.42.1

