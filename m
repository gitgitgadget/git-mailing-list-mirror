Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0D1E5707
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330846; cv=none; b=r+yAMwRfMQ/G39M7/FDGS98BLkLYO00/1iSxnYFAZXwxRkVikLyJ7Sw5H/3gXWe0HwMRCGb5v4IS+gV9UqCuudUcQGvwz/CI8rOFxNgdxUrZnDEfaV2/75zPcieg1fGG00KabT5p7H7PGBDOBZIhaEnJr4Mb9Yvh7ewYJZZGXa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330846; c=relaxed/simple;
	bh=at0aJg0TAgmlpPYtiUNOgwEq/y1ZzMivTl9xaEzT55k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbMNm6Px2q46SeG4x+H1LVBkUc4CoHlxI2xGS7ilfbryrcwuxI2rDw8pJvXs1cCQ8UUgDEC6R2cWjKyKr8zsHuTKab4274jTz3ENOI+x3ySMX4QcCbVhotfpmTC7sJtydj64spVAOKTdJzVs0+zyk4BKpSuRrQfJASBxRq5oPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tsi2+Dtt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tsi2+Dtt"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f7f1e1194so87917335ad.2
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330844; x=1739935644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWUP9PAoX6nXGAi7BUu9ADVDebYFDrcl3z3wLBs5/5U=;
        b=Tsi2+Dtt4PW2rsdiiXWKyfv4MwAMQGLeOxebtuhT68TV9pTUZA5iSK1AqQPvw7Rr7D
         AYVXLU1lV8hfCH0SlpX7uKhZ4AUcDQ2VcmDH8VMDmyuEn73Vo3dSlce22o0Tvm9YbY3g
         MCT6dryYwQ2kdufwBUoQcIJYbnCIa7ddlzykNj5P1qEOwBLz/FSm1njtP/cYpyjwojVa
         6elbjPr6R8DlnRPThyy5tyripLPTeXnBe54O26SSOSOHXJDhdDG3pbbFuu139fHArbsh
         BcOuJpaQiOcoxxjcsDDsoOCPL8Dan5NVv8JWG21O9HKyIkIRfFpPkSqr7FeJHjWGGIvE
         VZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330844; x=1739935644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWUP9PAoX6nXGAi7BUu9ADVDebYFDrcl3z3wLBs5/5U=;
        b=ZJz0btuAzxfExDEcKgXKdJMC1jy9KupGokdRMqRAXsQeMrxLgrj03w9WBntRxybuuk
         dNaAqi6gP0C1INL/XZRAFhdYniD61oOpffAzF2vQ+C2T9O7qbyCUVERWWLnahUyI5yHu
         6cvfFzBST2dRA7WnEMUfzgnAmnljs6voLVijRJ2QWtFSA02JczrEfe4EPIvJ+bEMWAwj
         hZCCWm5Y9izcNR2i8CwAI8wSd4KsWO9j5iFo7HknA34tesMhxwYF9Iyc1FjXM5ZnXD4l
         K+81ZKcueCrZLyDZ6y0kpCSaDQX1NSDOvdF6IOh9dx3f8xvMiCZdx8gEROamqxSDAuOE
         Lhuw==
X-Forwarded-Encrypted: i=1; AJvYcCV7WqRyI8V+p8TfjbdYS+MfFCZV66tq9ixPID5LogNwNatuMuOd1uAuiNAfC8IdPpiL7yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytnY5WqcvrF2Gswb+g86sJmUnQFCYb7Da+ZvGadn2oPukt+CPO
	T8bbXy3UJ+gkzs3aGDmvEaray1P2u+wBGRKIuecx8WfWt5MjIO+B
X-Gm-Gg: ASbGncv8Qr5Qd0xclL5UYYLuzohSHGN3Nb/Tl8cFUvM5NIVI5MrP43gBEr++7MIc8co
	B6/lkjBh6axxzA4rSKUu8QIJAVz0EaxYxvv3nweA6jmxI46seDWAszZrjbH2x3NsLEYUQQcvpS9
	84HZzNmzdNZF/HaDMEpLjAthXOMSbKdMhZXGpS5L1WXCr1xI3RvD1XDiW/hKg7jsSuGoqyoc12u
	mW2TUXQSDGFcdiqF+USdwIkMp4gLA97fFj7CJfBP+kZE5DnzqH0oGKGqu8dmWEnbJIVqvum3oxh
	soM3PHXDZK+u2I3XTHSQgEhCGuhhJfcRydK4VNs=
X-Google-Smtp-Source: AGHT+IGd0T3D63TZzJwDEFcivsCQcNsHbb11zqIRMxqjiXNJxyllfh51kJNC/iv264SGO2XTjSmz4Q==
X-Received: by 2002:a05:6300:8a06:b0:1ee:5e64:b17c with SMTP id adf61e73a8af0-1ee5e6509b0mr1668618637.21.1739330843844;
        Tue, 11 Feb 2025 19:27:23 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:508a:741e:539b:1c5c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f6esm10129577b3a.74.2025.02.11.19.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:27:23 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v5 09/10] diff: --pickaxe-{all,regex} help: Add --patch-{grep,modifies}
Date: Tue, 11 Feb 2025 19:26:53 -0800
Message-ID: <20250212032657.1807939-10-illia.bobyr@gmail.com>
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

For less experienced users --patch-{grep,modifies} should be easier to
understand than just -S or -G.  By mentioning the long argument names in
the help messages we save those users from having to search the list of
options for an explanation of what -S or -G stand for.
---
 diff.c | 4 ++--
 diff.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index ac2cd..a9e78 100644
--- a/diff.c
+++ b/diff.c
@@ -5871,10 +5871,10 @@ struct option *add_diff_options(const struct option *opts,
 			       N_("look for differences where a patch contains the specified regex"),
 			       0, diff_opt_pickaxe_regex),
 		OPT_BIT_F(0, "pickaxe-all", &options->pickaxe_opts,
-			  N_("show all changes in the changeset with -S or -G"),
+			  N_("show all changes in the changeset with -S/--patch-modifies or -G/--patch-grep"),
 			  DIFF_PICKAXE_ALL, PARSE_OPT_NONEG),
 		OPT_BIT_F(0, "pickaxe-regex", &options->pickaxe_opts,
-			  N_("treat <string> in -S as extended POSIX regular expression"),
+			  N_("treat <string> in -S/--patch-modifies as extended POSIX regular expression"),
 			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
 		OPT_FILENAME('O', NULL, &options->orderfile,
 			     N_("control the order in which files appear in the output")),
diff --git a/diff.h b/diff.h
index ed48a..9ad37 100644
--- a/diff.h
+++ b/diff.h
@@ -613,9 +613,9 @@ void diffcore_fix_diff_index(void);
 "  --patch-modifies=<string>\n" \
 "                find filepair who differ in the number of occurrences of string.\n" \
 "  --pickaxe-grep\n" \
-"                treat <string> as a regex in the -S argument.\n" \
+"                treat <string> as a regex in the -S/--patch-modifies argument.\n" \
 "  --pickaxe-all\n" \
-"                show all files diff when -G or -S is used and hit is found.\n" \
+"                show all files diff for -G/--patch-grep and -S/--patch-modifies.\n" \
 "  -a  --text    treat all files as text.\n"
 
 int diff_queue_is_empty(struct diff_options *o);
-- 
2.45.2

