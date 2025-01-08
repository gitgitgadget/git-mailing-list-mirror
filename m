Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0E2E40E
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 06:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736316151; cv=none; b=RhWeL5qJKCsMXgYWgubz1P9vRivvRNPEtTd2F5drTKcJTmSyOA2qKTPlP8mgCdAghK3M/nTuM5W+oT0k61XrqX1dt0a6QmfsdtT+ry6hcizgdqZ8cdU7p5ULFXyotojLlg39k4GfhrUUafsVRl88y9wI+oKA0zFXTh7yyjI8VcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736316151; c=relaxed/simple;
	bh=iWUpTLT+qW+krwVGMeYKY4c2i6IVPLL6nJTCFLrHuvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjqwIjZ8BnsyCwS3Ee2kq2Gwai7XOmx8zNh2MDgJeYnGf0nSgfwXPLj30t1dXgjdKIVVoWqvWTRJAh88rghCgJYREfwxPD7eikFZStCru2Di+Qjuxh6hKnQ9QWRtHBYEBW+thA/i9YvDDWJl6hHXikmePhYG6u88oGR9aMdoSDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al6vBRvT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al6vBRvT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-216728b1836so221781015ad.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 22:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736316149; x=1736920949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15WoHtD+bPHDeBnNHPoYceTo+g/blJMA2gi1kwQKq5U=;
        b=Al6vBRvTYq/Yru6KzeTuUHISPhQ10R9RdhlcULVkAKKauW8KJGEvIe/FEuoIxJ45Em
         EOv5SCo60Wmgj/WnlLmoPwSWe43tN8G169u5z0i1CRJvQBt/83YVJoRDm861IuUzbyod
         RjnPjccI4xisaWqu+DQYdLqZtfCtSxS/4XP1v2MdvfqvQa4ts30QlEbLzFXdqU7kmDRi
         fLezFxfUQ+m8nNmalEeoGS2OCxOh2v1OX4qJAva4VuTy8hm4dyd0g3lduvqKdfi75wt+
         440q67shU/fVmuSBGBIWkZNBZfR/Zbo3qijVQSoI2oux2ocGv9Mx0TTW7rSwHkT5yIBB
         khMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736316149; x=1736920949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15WoHtD+bPHDeBnNHPoYceTo+g/blJMA2gi1kwQKq5U=;
        b=qDcaML5pqWeCoeuYAL+FzT7RRX+BTS+93Dgiwud4Qyl28g+JLuNWsxlWCvsJv9AXE1
         IGcXU9h4Vez8+dcQMmbuJtSgecaKxHrB9b9aENC9XniqllDTCy0Hh2P2hb5ckEoMcl0i
         GoREewJGkbVbRA7f0pkTUAztq9EvPHH7C4tYLuOwGBU5onbuUzecGojjQ/rqYvr8owj7
         /Zf1lKBjT4GiGbyejSqtuR4T5VUEyIOPjf8QXhInhxy5fzmSa9ZgWg2URBG1ci5dBbjw
         dIzttYdEYMj4Tt8yRzk0ahyAAYWXJQINH2KrPI+s0UMH/t5IYqD+15W5naGq5EH5/cGK
         MPAg==
X-Gm-Message-State: AOJu0YzW5mgRi2g/spvkF2sXqb54VLcj//mvjze9Sfr+cp3OuqJTxS8B
	X1yU0qw8jO4JavDeY4Nrg7A0tdM64Rxx5bQ9xNrtbV//csHCDfzPU0R2zDEw
X-Gm-Gg: ASbGncsdgk/fy1AsjcxZzaDmt51/mPb4iIJs02MY0GNsHivGnJNlUaOJMzdOvh6EXjm
	E3DHkidBDEw50WT+oe4fwI7yAozc4R4xoEP5Nqs13T66ssmQH6kXsJuhOK3x4d1G/SPb8hauvO1
	wS3o9vwR1D1fLmxFpyxi/1YwzF2O7jwXcc3wC9dhh976N4m3MtIdOZH8Kod3b0xDYUwM3F65vNt
	+tuawe1np7GGnp8GChnDHtpZw0+tONtmucLt+KOtssXtE5KiIBX5xTiCBZl0qLDAbMoOBQJOdxx
	OcLbLdzqZ2X26UJ9zwO8bdY=
X-Google-Smtp-Source: AGHT+IGo4hFcSQ+lZRMEzbGiLCPXTurhhclqvX7/iH9glg40XtBLqCt+xhlgdu4aB6OZhUl2GahzrQ==
X-Received: by 2002:a05:6a21:100c:b0:1e0:c50c:9838 with SMTP id adf61e73a8af0-1e88cf7f7b0mr3239304637.6.1736316148843;
        Tue, 07 Jan 2025 22:02:28 -0800 (PST)
Received: from occam.ucdavis.edu (campus-069-172.ucdavis.edu. [168.150.69.172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842de3a0c49sm31910704a12.62.2025.01.07.22.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 22:02:28 -0800 (PST)
From: Jake Roggenbuck <jakeroggenbuck2@gmail.com>
To: roggenbuckjake@gmail.com
Cc: git@vger.kernel.org,
	Jake Roggenbuck <jakeroggenbuck2@gmail.com>
Subject: [PATCH 1/1] Exit on invalid diff status of diff_filepair
Date: Tue,  7 Jan 2025 22:01:51 -0800
Message-ID: <20250108060151.7218-2-jakeroggenbuck2@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108060151.7218-1-jakeroggenbuck2@gmail.com>
References: <CAEUC8gmgq_yViedLGHOeSyvR9rQK+O-8Fh9wzds=2+326ngUjw@mail.gmail.com>
 <20250108060151.7218-1-jakeroggenbuck2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check for the invalid status of `0` for `diff_filepair` when certain
object files are missing. When these object files are missing, 'git log'
returns 'fatal: bad object HEAD' but 'git diff' segfaults.

Normally, the `diff_filepair` status should be a character, but when object
files are removed, status becomes a zero character which isn't listed as one
of the possible status letters in `Documentation/diff-format.txt`.

This patch checks for that invalid status character and gracefully exits with
an error message.

Signed-off-by: Jake Roggenbuck <jakeroggenbuck2@gmail.com>
---
 diff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/diff.c b/diff.c
index 6c96154fed..aeab1ac445 100644
--- a/diff.c
+++ b/diff.c
@@ -7018,6 +7018,10 @@ void diff_queued_diff_prefetch(void *repository)
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
+
+		if (!p->status)
+			die("invalid diff status");
+
 		diff_add_if_missing(repo, &to_fetch, p->one);
 		diff_add_if_missing(repo, &to_fetch, p->two);
 	}
-- 
2.47.0

