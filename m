Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693893932E9
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591013; cv=none; b=ntRNfxu3wh8W6ibNOkV/v+pyr6nF1BD9c3OaqG4FHxazsonkzKUa98d4G2ey9HBeaDGFcYVxO+/eRfiYiGoONWCE47tZhR4IPDxkg4yy0AcUtd0hMuiUFbuGjk02PfZRj2mFc2UsQqo9aZvZSP4dHmNwudBUOgSkSIoou23VxkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591013; c=relaxed/simple;
	bh=wj2OT8D2MbdZYUTda5l3HE9yB0yi4LQGkOXJrNxc4NU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhGmTPQdRzVpso++iZRWd/BptE+3Viro08I6nN55yS6tppS/GLgnaS7BjgW2p91WywrbrE7SdDqkKfrXdGNm4DmU1VJkRss3nCTbu5Fogk3Y2ERw1KWc3CGPviegZJwyzUDWFT0hgnW+nDWS5lA/6U0VXzc+pmEElcBYrIGj5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/sqeRsn; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/sqeRsn"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-59ebcbfb2b0so309739e0c.2
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780591011; x=1781195811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yfH5SMop/FYDwQrBY5N0zEOPyZ6DF4e02tcMNSYtPP4=;
        b=M/sqeRsn/aNxkFLBQRk6oQ1O2Tu6toKb14hHfxIqTzvmB+qWMBo3x+Fdv7RCUeP5vv
         d1CyXYKe2CDoJPO7/BZJu58vEN25G2irc22drq3y1mzzLlvz9PeGgzQYhBJo3TYcga4N
         i3yzrOBn06QSfrs3vZCm78Hae0k4FFuZf2b8TuzM/eT+fKlEI/EUXQguInfeO0t1J4ra
         1fZtszuwrZVYe+b4XeaEc2ls/Dxc47cWV10c9rBMVBROhNAv+8d8LKeMKqlAy6HMVRfE
         qyhrGNKoSBaWXcsCjv6ZDpxwPwl3EjCbZiADhvTaLFG28AVUuhZfOEyhII7K3IvMaDG0
         ua1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780591011; x=1781195811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfH5SMop/FYDwQrBY5N0zEOPyZ6DF4e02tcMNSYtPP4=;
        b=Rt74o7+D0yZAIH4+xJfL/99AtKWEjbqlaRACUMQA9eLAa5noo+B0ZPSRPbSI75nGgx
         2nLDtRACfqf2LJTHOK6CjqEct/VyNIraSiYprB5w9O2Ww/k6sc7CiB0NhkB1qwBjV+Ji
         v8ia2eS5frMoJR0olR+hQBT8L/51jkl3hKF/AaTfLoywNQgSBuMBnrHBJlZCYOwKiwpu
         JXrv208GN1ceGcVYxHNdJvXvEXk7UDRWN9eRMWHNTdyILB8FXUunuSmY+nVyDJHwT+L3
         E84e9TGD1mquSjfoUG6V+yQHZi1/TNJ8u5QHikW0GQW8M+I008iNwNKgvSTDucKDDGF1
         yg/A==
X-Gm-Message-State: AOJu0Yzy4053fO3fYsvsj4WZFZCPdTyIqsOz9HxkmBJkOvdMfLEwWW8c
	pwzf22gEhKLoDPeRgeI6D6rgALb+fUBSsM+me1G12xZ8fCtpCs2o5EwzESMSFg==
X-Gm-Gg: Acq92OFAK4Uq++Dyiq6xFgIF76zbD9QGiQscpG2Sgat9f6REJQ7siNeo49+NhM3HhIy
	OjLOxN8YcsmtePnDnWz3D2M8sIbgRhKoFPaEvPEcMHX1ua3mmPOHct9fr3gD03qs6lDCzHJ0tD5
	NDVTbWAjbi9iPjF2B0ORDdw+svHyz25J/NGkRxWGIDbMQvBPL/8qIygLOhu86RKDwyBJ68PHBlu
	dr2L9HMI6ypLIdvUlGEZOVXGLDvEPfhrjGpUymAl1H9vsBzu1UmWGfj/osfBVhKm7PPhiicUEg8
	HFxaxrJO/HfdNAFCtuU3ReEkcpg3tgEJT8Hn+LPPM8GqGANHwJTtW9SYsXVYq7AvC9Hs5SSYC6t
	c3NlOhwHQ36up6VZPYZbku6eD2K0mfmGOOMFMyLnoTcOGeDtcQFDGMT+DTj9zcWagby5zCv+FUl
	8D4Q4oiF/MY6GqECP1jXqSVqzVid66zu8nkoO6IhoUzOWJgEd1LQphv6Ebo6Jau/VIcBbgJg==
X-Received: by 2002:a05:6122:608a:b0:575:29ef:7e13 with SMTP id 71dfb90a1353d-5a6e4470317mr5037589e0c.3.1780591011330;
        Thu, 04 Jun 2026 09:36:51 -0700 (PDT)
Received: from localhost.localdomain ([189.62.148.96])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96413f91f2esm4801469241.4.2026.06.04.09.36.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Jun 2026 09:36:51 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH] Documentation: remove redundant 'instead' in --subject-prefix
Date: Thu,  4 Jun 2026 13:34:42 -0300
Message-ID: <20260604163510.36687-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for --subject-prefix has two words "instead" in
the same sentence, making it a little bit confusing to read.

Change the order of the phrase to a more natural "Use [...]
instead of [...]" structure.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-format-patch.adoc | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 5662382450..f7905c0f7c 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -221,10 +221,9 @@ populated with placeholder text.
 	for generating the cover letter.
 
 --subject-prefix=<subject-prefix>::
-	Instead of the standard '[PATCH]' prefix in the subject
-	line, instead use '[<subject-prefix>]'. This can be used
-	to name a patch series, and can be combined with the
-	`--numbered` option.
+	Use '[<subject-prefix>]' instead of the standard '[PATCH]'
+	prefix in the subject line. This can be used to name a patch
+	series, and can be combined with the `--numbered` option.
 +
 The configuration variable `format.subjectPrefix` may also be used
 to configure a subject prefix to apply to a given repository for
-- 
2.50.1 (Apple Git-155)

