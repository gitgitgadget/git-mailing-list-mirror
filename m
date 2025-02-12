Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DF1D95A9
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330840; cv=none; b=s1ScwVE8+mlWSIhveg4DpFQVCWHrv3Ul/kjdQ5BHC6ifmcGpiSS6LZy5gTnFAteLNglwlXVnOWdLUhHAp1UQpZEgeLcJgixZsSloLmCev6CC8BsfGSrI0xYxXnUOGw8/W/jUZXUGN1awLh2LnKhmLRYu2lSzBSRfkcJrolGqY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330840; c=relaxed/simple;
	bh=mtsNSN5mfDYYaqZ3nmqEfQffc7xHoMJXB1mAp0k6f8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnmfsbBMguFQvFmtIrGBEz6au1uMsNG9x06FJtFzJIemTLJpuVhDadoa1bxYGzrpx8eVJ+a/ik1pOOySwyHyIm86zI/6Fdv758tsNbLhMmkdY7OHj4onCM8K7Igc0Yxp2bhDAq/QUCO4RHv8cFRj3muyxccLlLvk2bqPQKJFXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg7hGhbB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg7hGhbB"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa1fb3c445so8052547a91.2
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330838; x=1739935638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgGQrHozVkbJbzXm5nkKPVos1QrnOlRPsjseyUohAow=;
        b=dg7hGhbB4sKi8Uq7DNkLg59RrDz3xPqHul2yj7jgCu6exe5FvauM2TF+tm46T3wklN
         axmFPH2SGIivBNIm6e7SCeZz8pWrbENHBxWlg5HLZ6BA6LbgPu3Denmoj/JQSz0GY7bk
         K13H1z8s+tmBXSVJUTuNu0hmOdkRWaowoaxd5BCfk59lCyOTvcMkEM3xriuuQcjks8h2
         pLoBLnd2yDcwo5RMMydLiBHjfbL6eOQj7j0h4KpRYA5lTE5hFOPTeDhb6itENLco2BgX
         AmqlvGWqGdoEgz5sa/UT8aH5yu6aDDd0tBNCOFLXDXmJ77J2z/apS3QI4PHEdo/O50kI
         C9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330838; x=1739935638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgGQrHozVkbJbzXm5nkKPVos1QrnOlRPsjseyUohAow=;
        b=FJPAX8Gx8ZwtevYXjY3KtSJmh8jl0U2wiKm+hlXlvKEzbxnDJWsx6irQ6qSe0TwraE
         AbZX0H6w5XEPoE8+KBM7Ri0HrlAAw5381LyIiQI9MAOoHJ2oZPmI9qoiOvXH5Me3MNx1
         n0+FMtqqRoXwAjsL6/2Kob5gVmOGLNE/vhRRK5PunJqzb5SizudGbyltjsQOSNDJiEBg
         G2vJU3GFyMJLrQsywuquZS0GCRraj6V/32LmJUz7zaLWw29bQnJeAAcrg2qqstkgYsy4
         gbc9ErLYwLtAv43mGOBNlY2H1Od11fUaV1crQIe7+ukcR7p1PPufztQBCviy4WfO9qe1
         ISqA==
X-Forwarded-Encrypted: i=1; AJvYcCViOIhyzi65Ze0zdrFut5G3HRNhL+tNZLP2aGF5GQ7p1uihi/GbjeXOnT79qBO81MiuLX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqyEap6UjTLod8M9/b+h1esEf2sZfPbxA4O6u5Q/dfrBbmbkoS
	IQVEi64aGAn3vmlBccZhpbM0Upkyrmstz0EPgs2TB5F3hjjOAx3b
X-Gm-Gg: ASbGncug62t8KkaqVgLaurk/GCY16mAFG/bqVD0naYnv8BMpOHqb4I37V0xq/21UbXY
	yHJ9TG1odcxlszwa7zO8I7mvclDfGyafoS2oP/kr710OlbqHVE95CDCtcNpNVvH4p9ZnWHE9pNL
	SYhX3IgOZOsjTYYeLgtHFPjGI669y627YE0ddgVkbxOkNsTAYrzZ7d5Tno2Dd8TE7pggb1wuMwx
	cGvGIqY/Vvb7CVuJPEmHVbODV14Nwyg8pCw1ZS/jXAMhYr7ZhihifQR4YjmWMxe3N+714cOqYCB
	/jNKS/MIFbCPSFt1En8yhTiZG3XlpxQC3RvubOY=
X-Google-Smtp-Source: AGHT+IGFwFlocDN++utcKjT4V0RLClYS9XfKv3e06Q3xkLCwkMP8DRICyVXbME2La23mPt/KSGRArw==
X-Received: by 2002:a05:6a00:1c8e:b0:730:9659:ff4b with SMTP id d2e1a72fcca58-7322c5febedmr2663923b3a.19.1739330838411;
        Tue, 11 Feb 2025 19:27:18 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:508a:741e:539b:1c5c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f6esm10129577b3a.74.2025.02.11.19.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:27:17 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v5 05/10] docs: gitdiffcore: -G and -S: Use regex/string placeholders
Date: Tue, 11 Feb 2025 19:26:49 -0800
Message-ID: <20250212032657.1807939-6-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250212032657.1807939-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
 <20250212032657.1807939-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the rest of the documentation (and in the code) we use `regex` and
`string` as `-G` and `-S` argument placeholders.  While
`regular-expression` and `block-of-text` are a bit easier to read, it is
a bit consistent.

And we could assume that everyone who uses git should be able to
understand that a "string" and a "block-of-text", as well as a "regex"
and "regular-expression" are the same thing.  So, using a shorter
version is also more consistent.
---
 Documentation/gitdiffcore.txt | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 642c5..0d7d66 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -245,26 +245,25 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 
 This transformation limits the set of filepairs to those that change
 specified strings between the preimage and the postimage in a certain
-way.  -S<block-of-text> and -G<regular-expression> options are used to
-specify different ways these strings are sought.
+way.  `-S<string>` and `-G<regex>` options are used to specify
+different ways these strings are sought.
 
-"-S<block-of-text>" detects filepairs whose preimage and postimage
-have different number of occurrences of the specified block of text.
+`-S<string>` detects filepairs whose preimage and postimage
+have different number of occurrences of the specified _<string>_.
 By definition, it will not detect in-file moves.  Also, when a
 changeset moves a file wholesale without affecting the interesting
 string, diffcore-rename kicks in as usual, and `-S` omits the filepair
 (since the number of occurrences of that string didn't change in that
 rename-detected filepair).  When used with `--pickaxe-regex`, treat
-the <block-of-text> as an extended POSIX regular expression to match,
+the _<string>_ as an extended POSIX regular expression to match,
 instead of a literal string.
 
-"-G<regular-expression>" (mnemonic: grep) detects filepairs whose
-textual diff has an added or a deleted line that matches the given
-regular expression.  This means that it will detect in-file (or what
-rename-detection considers the same file) moves, which is noise.  The
-implementation runs diff twice and greps, and this can be quite
-expensive.  To speed things up, binary files without textconv filters
-will be ignored.
+`-G<regex>` (mnemonic: grep) detects filepairs whose textual diff has
+an added or a deleted line that matches the given _<regex>_.  This
+means that it will detect in-file (or what rename-detection considers
+the same file) moves, which is noise.  The implementation runs diff
+twice and greps, and this can be quite expensive.  To speed things up,
+binary files without textconv filters will be ignored.
 
 When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
 that match their respective criterion are kept in the output.  When
-- 
2.45.2

