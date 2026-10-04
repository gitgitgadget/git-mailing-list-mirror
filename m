Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004C3F9270
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791108373; cv=none; b=SEuzzAdBhnTeVSzo4/JoGtOXbXs6V3lJfGRGE3kpBky3xoZ513BmeK7Oyhs1N4EF6+6bjg0j/ANMTXYGS4AZm/h+j/iYNzf4iVcj5H7RwzVXWyxfuWBEFwXGClBNT3T0Y+6/tYC3w0ExN23r2Fl5+f060XEipgh5OL79m2h7fM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791108373; c=relaxed/simple;
	bh=xysX9PZG5F/530OhDTl/dEAfKIYg0jzAELbEjLI7GRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbHgwM6kvDfCal/PypSOCtqg1b0Rp8iSSleB0Gtn5seOkCvqFiwqhb7a+TNbh7c4KgHSmS6PFxzH+DVKKGJOG1WayPgC3IikdcmVEGBuX/2IVJjVaovkqcMANA9MLmGAJDIjmSd4/IdstLg0z+8jjUBKPBfdJ+5GxlO2YK9P6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+GdU//s; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+GdU//s"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b042e00f7so375336f8f.0
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 03:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791108369; x=1791713169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/oKypZl2uE7NroenYvoTuXbAu0pnJZR2kfkSyQcrKc=;
        b=b+GdU//s/WMUb3jNIzSDR8TUL4u6eTVwWdVGai1h8M9nVltqiKsGyuBg4QrDY6bcvC
         8U9moW7kDSuttBboQKOfUOE4TPJEkmdxGYHopArH0aeu5VE1vv3J/rkkdZ9qFEhtjuGi
         V3fuiuiEWhDtEe6E7LMOJcnEhQlyEHSDYVSxAU49kiHaytXuct5yreyV0Oz5YBwbNpZg
         SonU3lWkpBYcGL/HU8t3vJN/YfHM30QcSrlW1LbNe5R4nBKoatmyJ+IJC6KMCtmpvuMP
         14qM1XK3mc5MAE4I6yBIPIhMju400jFZgRZRGZ0Mmpi4dSKdshaEtQqoOHhtenFcCN2C
         HSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791108369; x=1791713169;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P/oKypZl2uE7NroenYvoTuXbAu0pnJZR2kfkSyQcrKc=;
        b=qMO9MfgEJQnBdIDzSGnqkFQBUjsei/neLS4gvXkbTgM0rsWBJuCU2PXTtEiUXAZfcQ
         H+dlI3C/OcNStROVdY/kZ3mz0GTnoyRCF8duhp8DA1Fary+7KGPT/1+XjJH0Twqn5YSs
         VdsIbUQEzDl0tHraB42RK1IslcPBV+kJwooxImKPSMoNPiF1agTwaOZxAGQ6vywvqMCU
         stFdUIE9Dw/wOzOlCHBnvfxJwfGTwkO3sfRXcMOJg1FW5g+4qiWxjbE/ajur9u2TVPKM
         uqDpaaUKnRd85yfe7X7HTlnx+VQgAcvftW5+i4YVnQLHDw7GkBnJ87URplXtmbf0DPVr
         FqGg==
X-Gm-Message-State: AFq9FYLLGaYaRpdmHba/9YhWaD7I7OxFCEzUy3hzrj0fuYXHD/dw6SQ8
	9LzO2FJUxxp4j+wm8iZWis5TUK1+fr9GCMwng0kKf+OxytIEyq7kuXB2vWPAsL48
X-Gm-Gg: AYBFou3D1C4CESWiWsXK7dE7/JS3rcp0ekyV0sdztpsvstHYUJVybMPkOJo0VbP2m1l
	GMIcUkgmEha2lySsrOdq0UHWtDV4L/1ZwOMASGac8gixGO4ANyZPbeMJYh+f02UxNY8Iy7QsSds
	FSoZoD6hEUu4u/eFamc/5pvRx96WM7Dggo03w/R0P//pjuL79TUsJzNyiXKj8z9vs6ns8UOAdtr
	QN7FutOeYNoZEvYpICoxlVBvLqAq4wddwr7z6lnMZfbHiHAlLXGyU6d8Qhro/4wlCarRCS78O4u
	PfaLT3ksXSMpi1W0P9citXnoSj0viruBnn2IwtjbZKf2OxECT8Yd1jQtHx6hXZbHf3FLr4jhoY6
	vTZ24IZsmBhY1Mu/inDGEaz2nkxGB+gcpR9W2J2yc0Y2UBKHg6pshcEP+OnZ/KdEj3zNaaFP7qo
	w/PpmuGbrBHH3yBY87n1iz/3USvJMzvUvdZggfFhKDz+xIleea1RYVoK/I43Bd+MYfIyTxDgBl2
	iGj
X-Received: by 2002:a05:6000:1a8b:b0:48a:f929:e140 with SMTP id ffacd0b85a97d-48b1270ff59mr14602151f8f.10.1791108369071;
        Sun, 04 Oct 2026 03:06:09 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f8ab4sm16464323f8f.35.2026.10.04.03.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 03:06:08 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] stash: use named constant when parsing "--all"
Date: Sun,  4 Oct 2026 11:05:52 +0100
Message-ID: <06b58ae0a1d81f4d1518eadecc3385072a72155a.1791108351.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The code that stashes all untracked files compares the value of the
"include_untracked" variable to the constant "INCLUDE_ALL_FILES",
however the option parsing code for "--all" uses a hard coded integer
instead. Replace the integer with the named constant.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fstash-all-untracked-use-named-constant%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/a01895368...06b58ae0a
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/stash-all-untracked-use-named-constant/v1

 builtin/stash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 7a9843413b1..4bdd51cd49f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1932,7 +1932,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		OPT_BOOL('u', "include-untracked", &include_untracked,
 			 N_("include untracked files in stash")),
 		OPT_SET_INT('a', "all", &include_untracked,
-			    N_("include ignore files"), 2),
+			    N_("include ignore files"), INCLUDE_ALL_FILES),
 		OPT_STRING('m', "message", &stash_msg, N_("message"),
 			   N_("stash message")),
 		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
@@ -2039,7 +2039,7 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 		OPT_BOOL('u', "include-untracked", &include_untracked,
 			 N_("include untracked files in stash")),
 		OPT_SET_INT('a', "all", &include_untracked,
-			    N_("include ignore files"), 2),
+			    N_("include ignore files"), INCLUDE_ALL_FILES),
 		OPT_STRING('m', "message", &stash_msg, "message",
 			   N_("stash message")),
 		OPT_END()
-- 
2.56.0.134.g299a3c16181

