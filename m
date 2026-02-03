Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4916430170F
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142031; cv=none; b=a7yHWOBmyP9Hte+QRyrLgkFr00Il4biUOQrqlnXyQ5LSnS9pm/8iy14werG8H6aayJYnn8r9cMFbZDYa1WI9NSj7Tz5wz+dq1ifhwHSaP4rOO0F1KKUvzYWqyKTiUM+C1g3U7mn/5ubjCyek/MFD66Gw8ZyudMg1hP/cyRgAgQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142031; c=relaxed/simple;
	bh=WeN2AOkASIrExgRMiYOuzuADwjLWUnP5X8YuOLlo/9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ara7rn2qYDsCq/igGmCwCQCWA+r91T/Ji2MxkjOlYLVbR/bwm3QY8H4gIbfo3aN7LCK0TCFxw3CxLGtal4ZCfdxCvOtpid39Y1e0YJ/zTTKRJR/UM0OIEVTicd5tLV69Vie/8Un9Re3NdhxYeEkH3tih0ydnjHgk2/Grz5zvMPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hse23ZRd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hse23ZRd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a933b9b591so500315ad.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 10:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770142029; x=1770746829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZnPvpF19O76ID5vXhqXOlRBh8MdnsHaTZc2tJGdeTk=;
        b=hse23ZRdvtYi3vH9lNgAHpDbqNE3CUMEct4awcpOJjiyx/s1AZrcfNz0VtWz1g1jQH
         VGxvx3xZPpw6gFenlo/r5VUKej3MKsJ5xzpdrK8XImQ+WMojOT1J6nLqgzTxnKGHK5Hj
         Aj7eEOAXB5PrbhoO2EAJp7rVfGIFnk77RMmzqKBXTt651yGB9yQeRDY/B4MARfGInVfR
         YL8HzJJzhlicCwivKcPIMxUflrZfk9+VrEj2NOsjKN9HboSKHLOMy2DJm8gGu1MlttXU
         Ip3a5xOs5w6YlCFmP9Fjz27pZOayKqVSYuHAOTWKkDZ4fJqBn4D6c9QJS5O/87rO4zGw
         uQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142029; x=1770746829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HZnPvpF19O76ID5vXhqXOlRBh8MdnsHaTZc2tJGdeTk=;
        b=FRF6C/KSWsOIyDqytF3T8hNn2XpVEyp8qAPi710mJv11co6dV7BzJhad21iiWCFpe9
         jNR/MQGNscA4r6jzvFiQ4LKV5zyCCDToqomBNMHaXRqz+733MntivQwFMV2Bn5G3sYwF
         4NCNf4eUqSWRYrKkbq7ll1j/xyEDCeJ2z3nZhE+W2MgsQ+z3qxe9BWXgt06MOWyZOB1G
         /xq2khnoa/i6mO6nV6GAaUL3AIIW0LaQWRth8WBz/reKadEMQmsGkot5fJOT5FX6PKQU
         sjq8IUa5cOKXIxZMB8T6vw/SOKZSvNJtmE2F55fGr/LEyemJiXHMzp7/LiNICcM5fZSo
         8mlA==
X-Gm-Message-State: AOJu0Yw9gZKoIcp6lyKPLN1uvDuuehKPErwKBMPKIHO8ZPuxtIx6j8fG
	SEmezgUNSRaiK281vpKE5W8HChRZVgF+acWUqbRYcfKW07weh78oqbB1mEHFi/fL
X-Gm-Gg: AZuq6aKcVb7oBIa1b3oyKmA9Q9c/hkQnqF5VhrGf5HJtcAYSM9hLVoOes3znnX4y11a
	m1sUlFimJbZFmwTN0uqPCbfKfE6JtDRPmvASglHDZABpXNnBGLCrvI9uoNoJDDVb05pzUkvyOFj
	mV8XuD0HFa0BNhir6vsliCUMls5f3MzOE6rpAWAdCv3Ukk8HdLU1tVKFmsCqjVLJ3pM+CgEjsvi
	zmAViV+tRoquwfI5WhQTjmIlBpapyePJufAEfhBBW7m6bVj0pKZYBDSVr32USX9Ys40HcZvg0ow
	HILa2vxlqzBtsQZJp3Hp5m7sCyVQ/zsuy5NR2V+vVH3GSOgBd+Ulai8aGOBm1XAAQkmMCQXRoNn
	tdRdfj60EfW1LPuIlTwdY1l87m03zy3xEzE73qo3N7VP9xinjd2nK30EzbMZ2ehf+BOzByIYwpD
	E1zXBuUf9P+gNMoZDCxU1iisrRJAbI0KFZ
X-Received: by 2002:a17:902:c947:b0:2a5:8c1c:7451 with SMTP id d9443c01a7336-2a9341085b5mr1132475ad.58.1770142029372;
        Tue, 03 Feb 2026 10:07:09 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933898388sm1824125ad.34.2026.02.03.10.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:07:08 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthiknayak@gmail.com,
	kh@pks.im,
	peff@peff.net,
	ps@pks.im,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH v3] stash: honor --no-overwrite-ignore with --all
Date: Tue,  3 Feb 2026 18:04:00 +0000
Message-ID: <20260203180359.602905-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202162225.35206-3-pushkarkumarsingh1970@gmail.com>
References: <20260202162225.35206-3-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach stash push/save to avoid -a cleanup when --no-overwrite-ignore
is given by downgrading INCLUDE_ALL_FILES to include-untracked.

This fixes ignored files being incorrectly removed despite
--no-overwrite-ignore.

Add regression tests covering both overwrite and no-overwrite cases.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
Changes since v2:
- Use test_grep instead of grep
- Use test_path_is_missing for overwrite-ignore test
- Rebase onto current master so patch applies cleanly

 builtin/stash.c                    | 14 ++++++++------
 t/t3905-stash-include-untracked.sh | 18 +++++++++++++++---
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 82d10520fe..c3ee33cce1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1858,9 +1858,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		OPT_SET_INT('a', "all", &include_untracked,
 			    N_("include ignore files"), 2),
 		OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore,
-			N_("update ignored files (default)")),
-		OPT_BOOL(0, "no-overwrite-ignore", &overwrite_ignore,
-			N_("do not update ignored files")),
+			 N_("update ignored files")),
 		OPT_STRING('m', "message", &stash_msg, N_("message"),
 			   N_("stash message")),
 		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
@@ -1894,6 +1892,9 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
 		       prefix, argv);
 
+	if (!overwrite_ignore && include_untracked == INCLUDE_ALL_FILES)
+		include_untracked = 1;
+
 	if (pathspec_from_file) {
 		if (patch_mode)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
@@ -1965,9 +1966,7 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 		OPT_SET_INT('a', "all", &include_untracked,
 			    N_("include ignore files"), 2),
 		OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore,
-				N_("update ignored files (default)")),
-		OPT_BOOL(0, "no-overwrite-ignore", &overwrite_ignore,
-				N_("do not update ignored files")),
+			 N_("update ignored files")),
 		OPT_STRING('m', "message", &stash_msg, "message",
 			   N_("stash message")),
 		OPT_END()
@@ -1994,6 +1993,9 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
 	}
 
+	if (!overwrite_ignore && include_untracked == INCLUDE_ALL_FILES)
+		include_untracked = 1;
+
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
 			    patch_mode, &add_p_opt, include_untracked,
 			    only_staged);
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 9c5421cd76..63b59de47b 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -427,17 +427,29 @@ test_expect_success 'stash -u ignores sub-repository' '
 	git stash -u
 '
 
-test_expect_success 'stash push --no-overwrite-ignore preserves ignored files' '
+test_expect_success 'stash push -a --no-overwrite-ignore preserves ignored files' '
 	echo ignored.txt >>.gitignore &&
 	echo before >ignored.txt &&
 	git add .gitignore &&
 	git commit -m "add ignore" &&
 
 	echo after >ignored.txt &&
-	git stash push --no-overwrite-ignore &&
+	git stash push -a --no-overwrite-ignore &&
 
 	test_path_is_file ignored.txt &&
-	grep after ignored.txt
+	test_grep after ignored.txt
+'
+
+test_expect_success 'stash push -a --overwrite-ignore overwrites ignored files' '
+	echo ignored.txt >>.gitignore &&
+	echo before >ignored.txt &&
+	git add .gitignore &&
+	git commit -m "add ignore" &&
+
+	echo after >ignored.txt &&
+	git stash push -a --overwrite-ignore &&
+
+	test_path_is_missing ignored.txt
 '
 
 test_done
-- 
2.43.0

