Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF3210E4
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770898; cv=none; b=Zlm37VKt0FVx45uhXoXegejcpoHFZdqFNI7nygv5uY0IesDBmGKPI/OubgumLELiHFx+wCUihN7OkhZJP06KgVUupErbQSYA/U0WOtTk8mmsv0l5UY+l6zn7Eek9SDI6ZAJpigXa/S6v81NWsHp5OoHAcQN1MOWIxDCP7PZeNno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770898; c=relaxed/simple;
	bh=Ep8u4uAsIkbSVc4zeAZziOsmGnwEWPUlgRyJXOcYPLg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Gbl4w8LRYT+VIfDreOEb6kg7SYPBhtLC65InyL8wfpcTS/dp+X7jUHcpJSMVg/DhgU3lB8AtBoPiCLq2AqZOL9IH9ab71suHcCiIL17thag/AZtyAaA74m4A4SeIDKROQBVePGTnDax7hFDNerureyIVJdxUflaRw3rchg/rxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhKr112R; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhKr112R"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5365cc68efaso1292325e87.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770894; x=1727375694; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzz0fQu2Pji62vgAE6CBoo8OgKQrKXtAnN0kwspedaQ=;
        b=HhKr112RrpvWD9ex9DvBbMpLqHYBuES0LWHthyptUZEJWO+U1+MGrRN0hkQJ13YP4l
         Bl/s95kpFqRIgyqEI5aJRpAcOUBMjuyAMXHbxjHoonKGokZk/SJ5mrvBGcZ0wmIQdnG0
         gukIuQV3/80VJdBY2q4F4bCoKsDq1rraD/8iZ+ETcPq3C1Dpi6r9EG1gz6sdLGw5XzRa
         N/w6Mf0mNdj03Qh+a4MZ64LotYwKZQWe5wnDyDjXxxBcLw0WtPwWfWZcRv3a2Lul8RXh
         1BGO1hcNDhZaJUZt15z3blIY4QDGykACTlf30sigb8hj594BITJ2W9uiLh693AHa1l+g
         PY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770894; x=1727375694;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzz0fQu2Pji62vgAE6CBoo8OgKQrKXtAnN0kwspedaQ=;
        b=V5Wgrq/1k59aEp6S20kPvyTqXW5l5oR2mJh5NzTp3Jg1mHu4Ks+4AZ/9bEe42a1aUH
         lB8ujNa+wlhzQdZNxHtvzQ0vug3OoJDBHdPLmrdt0NBeEccTlI1eE1/mPX5WlJl/xeO4
         pH168Qz7xsfI1UgxIlPUECbjMnbbXVNbFTLPGu3HE4GbFqUcTjRatze+Qt4Ttsz/kYJ+
         romM8qKmjyhqZcEwrnv8hG+Mw1nimoQnVGRDUXyjjZXPsX3leh6H8V9JOQ1Gi4PgsuJy
         xlL1t7bFiHiCuFNlH9yuh3t1xHkzS41atFGeQXfrQFt1tQD/dvT6nUD2kphlU/im+a/c
         XpwA==
X-Gm-Message-State: AOJu0YwPo/oqdPAoz7oAD+EXrVnVPmeHMv6viLC0brLxfLdS/jmnVuIZ
	8S+q38Hg0Rd611ulHomv2eAW14TlClXnCLNgr+HzsJwh4wVF9tC86Cejdg==
X-Google-Smtp-Source: AGHT+IFfXqOGJbLH/Ebec+zDzCDLH+UGKNRkCnbeipWinus4SA19iWyvlkeqq2xTf0B1zicYYZ4lgA==
X-Received: by 2002:a05:6512:3b89:b0:530:aea3:4659 with SMTP id 2adb3069b0e04-536ac2cba88mr165323e87.9.1726770893923;
        Thu, 19 Sep 2024 11:34:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb492a1sm6312204a12.8.2024.09.19.11.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:53 -0700 (PDT)
Message-Id: <0fb72f40748f9c236a9d3bfbf7f4e807aa3bf59a.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:31 +0000
Subject: [PATCH 11/20] pretty: fix a typo
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
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 pretty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 5e5ae452530..6403e268900 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2205,7 +2205,7 @@ static void strbuf_add_tabexpand(struct strbuf *sb, struct grep_opt *opt,
 }
 
 /*
- * pp_handle_indent() prints out the intendation, and
+ * pp_handle_indent() prints out the indentation, and
  * the whole line (without the final newline), after
  * de-tabifying.
  */
-- 
gitgitgadget

