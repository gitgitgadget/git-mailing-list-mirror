Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302032DAFBB
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562743; cv=none; b=YNCYUUMR+gaz5GG5zGrP3mVnG0bNrao1kb+cWJ5bu8TE2wN4a/OLj5dPb8d+gYYAUcPRT8SOsDtlMLNORxU2z1obWLWs6VglbZmYX/Xs3ukPZQV2pg7MdqBIPjpbLWi+bqeIdMpuyhK0j3szFxkvUsX9u2NWUeeVnh3eZ8o04Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562743; c=relaxed/simple;
	bh=/1SnD3WYBHp1TwPoq1VIuriILgy4qstGvpGLP8cKBOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Evm+Ja+AbZ6z8olZEEVrW5bhE+iGRWHtnSVcBPWJa6sxy6IVKue0p2/cKyC1uz/Dnm4B7mFasBae8WLTrOzeHAiqaRe5766RXQf49zzkUw3M44GC0CQyZknx8/iy7RN3zEz6hGAPRoDc6b1HEWL4hJNrwBMx3uqvj5eeHD+JUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cG7NLqA0; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cG7NLqA0"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-64fdca63b41so3380404eaf.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760562741; x=1761167541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY2YdpRXIoSdDtOeSL1Fzj0grP/ivSC2SYohVHa3Vss=;
        b=cG7NLqA0GqgUaQCRUPtkPyziwrHVs7kC1e+s7ChzWzcbbJl91QH8bMOIyxB8FmeYbc
         Nx5CB13UPLvkgRKMG/Iq72K2fiIYNEcGhm2FjxO2YCXmR+9CQPSd6mv+sdCX4sCeMxo5
         2zoBfgx7k+7p+EsMf+0mJKT4DN4pqWRVYO+xifWU01hHd1saBcvrY4Z7Wtou5TgRqiH8
         1C+DmKUejvUJkruFEL1eRh42SQQTKfjEMFD7e+lKQiZwsac+dr4bOUbeqYWmzL7qOc2X
         x/HW2aFY1wKC45+sjGZxInJ1xeP2cOmDewDLy0Bs0+kcYN3joCSkZia/LX1JWIdpSF65
         lJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562741; x=1761167541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY2YdpRXIoSdDtOeSL1Fzj0grP/ivSC2SYohVHa3Vss=;
        b=G7LqamjFlLn4I//vxwe0mVhPWY+0Pxnm4pjAFScrTP3FJiv46rmlxnTK69DeC7Z4j1
         GEVN8vUy0p/7hs1MB+8LI5Wduk03sAydj52NP+Ho09QfgQpzoDbDqvwG+Omjz1a76f5P
         NxEvb7qRvASad/MhQ1/dKC6+rIOt7tVvu/Z5GRlcUVSv13cUcX6rKCe+OU/0cO4Wi4AX
         QLpe1swR7MJuZrariS0MEtYG5p4r+5ns7UhG11/TsB0XbPhurXcBniDF+5gGQlwNRo1f
         A6sncd1WoiClZprKZRsaHD6kljpw47/CyJxz9jsRYWPQXjyQ9BWH7W5sH/i54Qp7X04T
         ugrA==
X-Gm-Message-State: AOJu0YwDLzNybf9akDVcgjKk/QKOVKgbdMh+kShlktqcvXxIAqiPjTSS
	EgSSIdcy8xj7iNTx5MkMe9qxsb1i9shKYw2CF/EJVExPUq7bEIJOlDzymAhehg==
X-Gm-Gg: ASbGnct1AI5BYDZ+X+6xl/dYN8uqwN1D02NNhP1JFeZqa19FyMWJOMg+fX/6YK92tpR
	I9WmPDAdUXdYYtjpdyME6lwJ13v3FCULpUY9asMlSbKh6AhzgBAp8MIRqttA58fF6VFr2zgWGea
	/cKEMzmnfP00DxujV9OA4Ay7fIaezQrqK4KvqUGlPisnD+d63q593f+HCYyo/Qserf99DPxu5fz
	eD1WwATg/m4K2etFOfMn/ac03UZaB7c5+Rwb+6yJxeQyyYnkLYjjJbTCIQhWGkQRn0wX9M8eSo+
	Vfq0fccrvJ7I+okfbBzBGiDA7Gj7WlY8tmOQoiKeyB3ix85lzUhKHHSrCtfCQIBJqrVvuPx3vHv
	xEQczTUUQBb9UC7YKViIhg30mq1D3hJ/+he+wkZ/D89JQmGVIq+47sYk8MYIAN0f/QrFL6dlU7E
	nfat/i5zCuryAsRm17BsQ=
X-Google-Smtp-Source: AGHT+IEODVmJy9k+EtqYo7u5m1M8AJwY9ooewCg9D90bd6rbcOGWZejb2nOaSsd1g+LYvg/a3IjsLA==
X-Received: by 2002:a05:6870:348b:b0:3ae:f15:5de1 with SMTP id 586e51a60fabf-3c0fa754b53mr14703210fac.41.1760562740835;
        Wed, 15 Oct 2025 14:12:20 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8eecb2bsm5806932fac.20.2025.10.15.14.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:12:20 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 2/6] ref-filter: allow NULL filter pattern
Date: Wed, 15 Oct 2025 16:12:09 -0500
Message-ID: <20251015211213.361797-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20251015211213.361797-1-jltobler@gmail.com>
References: <20250927145049.723341-1-jltobler@gmail.com>
 <20251015211213.361797-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting up `struct ref_filter` for filter_refs(), the
`name_patterns` field must point to an array of pattern strings even if
no patterns are required. To improve this interface, treat a NULL
`name_patterns` field the same as when it points to an empty array.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 ref-filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 520d2539c9..2cb5a166d6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2664,7 +2664,7 @@ static int match_name_as_path(const char **pattern, const char *refname,
 /* Return 1 if the refname matches one of the patterns, otherwise 0. */
 static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 {
-	if (!*filter->name_patterns)
+	if (!filter->name_patterns || !*filter->name_patterns)
 		return 1; /* No pattern always matches */
 	if (filter->match_as_path)
 		return match_name_as_path(filter->name_patterns, refname,
@@ -2751,7 +2751,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
 	}
 
-	if (!filter->name_patterns[0]) {
+	if (!filter->name_patterns || !filter->name_patterns[0]) {
 		/* no patterns; we have to look at everything */
 		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
 	}
-- 
2.51.0.193.g4975ec3473b

