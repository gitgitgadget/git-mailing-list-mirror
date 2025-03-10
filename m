Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F9D22E3F1
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622287; cv=none; b=TM0QhgHRtrHy1Kck6GFEszHOBDjLJlK0AbInP4LcmF0z8TtqEWvAhuCMHCepceVpOO/a0uKFJ0p8V3ZBw7y2jYF48UYFq0Vp+M0K+3Cb1K5n1WJrBdFGtsoQHrQwS8+Bvv26jt3gXwukXcS7RnDJNJ5fZ66E/WUX+pnTAlhxYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622287; c=relaxed/simple;
	bh=o5NRMLPLHeOZD8FhddB6YE4KFOYf+cJ+1gRKK5AqryY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+gUInSiVaqMdJJZTCvvPhYI1h2vZ3dXdL9obzY9Plh0laWHwGbje8tZ8RoZyWdHT3cJvYmJy3DQgHYfVDLTKecdwuVBaI7A8fNRpHm45sgBz+Hgp47/oCFme892oL7JEtQQSsOEDLKEql9zBHVg42MpBBdNSbgQ9d4jeYvLJ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZInpBn9d; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZInpBn9d"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f2f391864so2360884f8f.3
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741622283; x=1742227083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgQxvMb9zHozk9PF4kDNdY9N0ZzWx/UlmwDfizoPze0=;
        b=ZInpBn9dom6EOjdaUrdgGEn0RRWMOkppIUo3a1ao1KVubm/fK1xNc6GhNhJJeb7CRi
         zJrzYh6EcCSshtSggVi3rGWgkt2Kg6R4mMetuuPuJagh2tdt9jPrmJgWtPwENoxqvMnA
         wm5FxGf8c7OxgXbJ40RWFtJ3wX0ooalR6JIKEX1FGlowhvBf+UUUGti4Jg+cqRD01OLZ
         6zTDZB2XyPewUOso/Co/xd+QOGTyevfSlN83D2q9We7i8Ol9PRC1Sg900f37J36hyJcZ
         Hp1zzyMmweIMOaOPGC3Mv4DS0iVgI9mxLy72G0SI0K5FgkNY0Un24gUjc+xXXBPvs1eZ
         qkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622283; x=1742227083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgQxvMb9zHozk9PF4kDNdY9N0ZzWx/UlmwDfizoPze0=;
        b=FXlLKclzvktX/AdvXlIpSzUynOsV3VwvMRYYCJNBr8p8nWD1vvRNng1jPTvtE/ldiA
         ocvK6N1Ujp9kJxvlcolouZNod3rwz7PHO8GL2XjE6jQLyEJOD2hpSpRVx4Pvwy3qN3Ny
         N5QHjxqgc1eHquVHaYnxvlx5G86cVZEugRUDoAKUlMS7bBigwutR1Zrn5U//bgnoJspI
         YcTKZ9/5tutQQVbnPO3U2Jp38+sYYTjAxACR6RJuE4RXK7u75Qpa2CTCSYovDTN23Tlh
         frV+Qcg62s0xox0yO7a4iStEqOYc/E3XauNn7z45NtU3mWut6xH1eX1TtjfLynjgfBai
         zV2Q==
X-Gm-Message-State: AOJu0YyM58g3KsHBL43m7QFHlsYMBrE0as2QEhvgbWw+NoRDkNAR+pMx
	A9Q8PJ8M/C5l2S2ZnEJJ5Gu/m6iRwvbUMf1XZRnZOcEYX4YwyBM48JL3eg==
X-Gm-Gg: ASbGnctp6sCLQnVoIUV+hEL91Psg4DCztbNaNt9aMlF0KEzOLTrmO5Oy8QA9kylwDL7
	2qVLQ9Wqi/jRZhxAl+vNkrOzVtJ0M+PRTsOSwW2F1R44ZGpt4eUNcSlH8nbUeinviCr0OIrWJjm
	bUMhILE6fGB6zNDSyn2D2FyXPh+lG4GTu8qxgF9N3S1NvBMK3LVnYqe9ywcGdjqBKKX9XOWOy6w
	TqfLk305ApjySz6BlY284HGWt5TrKOtGjVjo+/t+DyXnApcY+2kt8KRMxzjf0916z/B5oKww5bi
	SPaL2keUqu60TuGkOPMv53T95CDYniWHBQfdc7nkhpoIe4Q7AwftTcKF11y27fqDseyZ8IOkyg5
	PMSWcPWUQRyaC1LS3t5bdzu2zD3efUFdVv21OyQ==
X-Google-Smtp-Source: AGHT+IEGzhRLEnhb1ukmZ6lX/RZDthW9S9erraYUcunDIqYTMIPwHfG+vXFw3/pgXqRS67UOOVD0Sw==
X-Received: by 2002:a5d:6d8f:0:b0:391:6fd:bb64 with SMTP id ffacd0b85a97d-39132d1d1d6mr9375815f8f.13.1741622283077;
        Mon, 10 Mar 2025 08:58:03 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e4065sm15551831f8f.62.2025.03.10.08.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:58:02 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Luke Shumaker <lukeshu@lukeshu.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Luke Shumaker <lukeshu@datawire.io>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 1/6] git-fast-import.adoc: add missing LF in the BNF
Date: Mon, 10 Mar 2025 16:57:41 +0100
Message-ID: <20250310155746.879481-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.89.g148d1db992
In-Reply-To: <20250310155746.879481-1-christian.couder@gmail.com>
References: <20250224142744.279643-1-christian.couder@gmail.com>
 <20250310155746.879481-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luke Shumaker <lukeshu@datawire.io>

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-fast-import.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 58a2eaa51a..8e0de618c0 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -437,7 +437,7 @@ change to the project.
 	original-oid?
 	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
-	('encoding' SP <encoding>)?
+	('encoding' SP <encoding> LF)?
 	data
 	('from' SP <commit-ish> LF)?
 	('merge' SP <commit-ish> LF)*
-- 
2.49.0.rc1.89.g148d1db992

