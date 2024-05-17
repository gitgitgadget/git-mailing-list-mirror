Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9F266A7
	for <git@vger.kernel.org>; Fri, 17 May 2024 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715987763; cv=none; b=HZBnfNCMZZ67eFLKnUtwQJq5842lL2m5py0AUKvBWQbu9QtErbY8lrndyP8ZlanbIInlN5lnLNxhwzw/R+7YfW3xTmuvcNEmGCcLdScXdGC2R2fHbl5y/KC350n+uTIah83AG6qEswJWz0xwwM5GthRW6mSg0VAI/j6iocuBe+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715987763; c=relaxed/simple;
	bh=eomBttJUDugeAh4/E/RHJ5Kl046QR71tdtyo18mV/ck=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=or2JDC1aWz/LgFVpbyw90KK53zCMP9JPL5L+/GWDb8Eme9EEG2KUPzwsqNa1rSCUWybBdFHb98AGbRsoFEz/RQEKaLPbznYbepWKel6pr0mKudm++O+R+RBY/P1nxf/hwkgj6uCzpYJq2oO33GAqiufIYCOzmHJRSa/ZaQ1fZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvGpuLXe; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvGpuLXe"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34da04e44a2so551605f8f.1
        for <git@vger.kernel.org>; Fri, 17 May 2024 16:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715987760; x=1716592560; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa4ywTRMbTP0sOgRCz5rqk9gwHUD4hcDu9QhBPTQQ6M=;
        b=FvGpuLXeRLmYLbjbwTWl1thmCAuEPKk3XEGNwwkXJoloz3CcTyyNE7b1mXyltF0pmn
         GYn7tmYyP5tkKRCf0QMpXovulDD458iOWAQ4qGN9ET+/HBxCI6/zWgMPM4jdFC7RLgX8
         QwLn69VNG9K/SrCGtZnFPaGdurvA0xHBrHfvY9g7ZQFnyQ3v9BMdZvn2TAtYtL4tLozH
         CMHaG7H4Gz3roV+g6HPtOem+VxPC823c4wEHY5ukj3kK3MEu8oHrOPIsIPyyx3IPGoHW
         Iyxx8KAvTwAaBFRsCSicuUQd+Jd5XSs5JEKw9S5QkI14otnIAtCjNvPiC4aaCpMk/2+g
         PCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715987760; x=1716592560;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa4ywTRMbTP0sOgRCz5rqk9gwHUD4hcDu9QhBPTQQ6M=;
        b=EkaVYKSnj/wIAnSjblfB/5yWIdYsjyT/Sv2FvT+E5A7Ohz6eTv8P3GuAtKmELwSAKV
         lf3S7fDZfXG0xhFcYmHhXuWYm5FI8PityT/NYFdaKhD4lxJlj8fj9nsT91bjE/vFUm0V
         jks/ckmvv/RBET6o6cfJL1tXpE3jJImTJS7UtDruWWXDr+xPYU7apnBCwul6TPZedCI7
         IPBDlu23X+V1aBxeFJwYR0LqOJuuwdSVrXrKR80BecFt06lg70WBSpeXi9UeWmRVLOtA
         Ccbu73zqJoC2696ZXlcZOqXHZ6VdEdZHq9tAJk026dnXWa4l6gqzzoBmud1/JTd1gvy9
         KaeQ==
X-Gm-Message-State: AOJu0YwFC0bk6CFt7Dvpis26WwZynLCjmArUOCjxFVCQQxWYqk162qGT
	W+jnLMe3e6wkEtjIsVJlv60tZF8ztBabcZw6/pUde1C74g58whzaWPq1VA==
X-Google-Smtp-Source: AGHT+IEFxIDjmH59e/Q62RqP42Em7ovvYCTbH+WcBN2MPslnYBowYiKVuZQlkkdbLqoI/WRzcivn/w==
X-Received: by 2002:adf:e68e:0:b0:34d:b40e:79cd with SMTP id ffacd0b85a97d-3504a739593mr15999650f8f.42.1715987759658;
        Fri, 17 May 2024 16:15:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc8esm22521637f8f.15.2024.05.17.16.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 16:15:58 -0700 (PDT)
Message-Id: <d4a003bf2ceafcc6d47d01d21b7faff48c9e85aa.1715987756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 23:15:49 +0000
Subject: [PATCH 1/8] hook: plug a new memory leak
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 8db1e8743c0 (clone: prevent hooks from running during a clone,
2024-03-28), I introduced an inadvertent memory leak that was
unfortunately not caught before v2.45.1 was released. Here is a fix.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 hook.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 632b537b993..fc974cee1d8 100644
--- a/hook.c
+++ b/hook.c
@@ -18,8 +18,10 @@ static int identical_to_template_hook(const char *name, const char *path)
 		found_template_hook = access(template_path.buf, X_OK) >= 0;
 	}
 #endif
-	if (!found_template_hook)
+	if (!found_template_hook) {
+		strbuf_release(&template_path);
 		return 0;
+	}
 
 	ret = do_files_match(template_path.buf, path);
 
-- 
gitgitgadget

