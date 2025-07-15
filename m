Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD672BE65E
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605859; cv=none; b=uszJMlbJmRXpoj+c3ToAmk7SeFbt+kPClkfHZfFzhoY6DOy2VsoUT37yTVqKDfiodjVpSwSoloWU78xHIhP9Sxa6QaAUiosm3jud+yDTe6RZt1T8uusfv/WrJ8iz2VDENnlPGDyXMI2LLk0ucwBDtxa4bLbDeDB5KucNC7l3xIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605859; c=relaxed/simple;
	bh=laf16dHzij7YCZp2chVsDHBvhNl7TqGcO1i6FVRg77g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFpkTHMQUcc7rnKeLYYPr4t+5/Fn5RAwy6xT16dxEXFIYHjFD9/mwbCdGaFQt1xbp0ceAMHP76JSGU9Zh2x+v/VXxsUTXzUjtit0ndLTIeDd/JsVTdedyVOLYk91KV3vT2f4jgX9LW0y+Dw0y0MRXfht816KZrxd2O9uwL29mNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU+b9ClC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU+b9ClC"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74264d1832eso7532554b3a.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752605857; x=1753210657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqNbRtF5Yhb2hQAHA2bjjjALiMHHYd4Ew9MfhRG7N3Y=;
        b=kU+b9ClCVYtpQYa9Jn1tQjX32kFE2RUgOHi/KaH+VW8gt5SNli8Wiq0wdE0E9BhDSD
         HbKBPZCCzfHY1a8Kw6coTAjZP8AgKbhKdYePXF58wwSEoD9tT/e7zQlE9xxukkBaXJsE
         zvnNODsrVBtujWDV9AL7xZhKXtlTe2hWWrAkdlLDmj1lE6F2+1uQC7qrPKKSXYZMFPtd
         Ebe7taezxfdkqMqCM2O9OnUUQl5+GBujjzLgsNaI1nekk/wE1VqxbJCQXmHSg9ko8SZY
         lh+SvNcILh2HAZxz/0+V3XudJ09jfPka+qZEtVA0kYlUU+OA82JmV3QZvSuvPMlN5unM
         4Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752605857; x=1753210657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqNbRtF5Yhb2hQAHA2bjjjALiMHHYd4Ew9MfhRG7N3Y=;
        b=cxJVRisVQpNqzns7Hq0CNjTcCxkBIxWPRIx4pt/VX4mMAy0I34qST/LjClfr/34dsy
         LY2HTtis0/C5JS1mRY3IdHDMzp5rV2dMiNGxrFEl0/Z81zyjIzJQsQs/slJmPn9sN2Go
         T4go/fXt4QdToZIt+WZiRbdhcvidWwufJJThZYj/9i1Z4hEkGLPfu2be9iYeBNCyRb2o
         XAxqqmZUfWnUPAF2aown0nOfSRG3CpFhS73IXIivQzRTlsdPBR1+IEuoQJ3C+dk7D4IX
         3reIxyYb4RJaqkYymt8eY96enzITb2iPvBa+J9pPvDZTFwuSMEG8iAaLNSJ+fJ/VKD/P
         epRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPKNsXqdgbm7BnoWFbDin7nAzvxQwdeUPtUaBiOaq9Cqr9ZnDirAtx53zUvKMKfNVkSuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbk+c6yZOehutyhljiZcMRrsOh3+mHgBVSGlULpvR7682f7af
	V+UbwcaTyrJdHXZjuwsaAibZWJY6EAYWqrfmpZOlXspF0pTV9qevEOx7
X-Gm-Gg: ASbGncvGzn9SE1ebwpj3J5eEgHSdKxPxWrrbGIm2SEgi/2101XPGRGX22a3j/JD7pyC
	a+tgkLt796ObzdHwTpYnXuNJaA5KwVXcTsV8JpVc+4cDGv5kS8H5oMW8+keyALFZAIysof6JcuX
	H2+LBdlq4Ve5eokmH3fLiaT7n2YG7Rx2ev9+Db70Ikt380qn5LGQESFOi7cx5rL93O1yU/+dc/n
	tP7f1OvyqiC9kKPbkDVaZblQBzk6iAmcb/T5Cj9Vwf6g6wIhtmf/rcKYzjv37Hb/4dxJz6zsecE
	UeBOOqaKX1g7F5soKe6NMPfJCpVIafTemqen2wxLZRcZ94suWrLSDPL4I5hbYt7kFAneG8GtMJl
	HESMdyeZ91pIq6KH57AQxVXO+nNFfSdfw6Ak=
X-Google-Smtp-Source: AGHT+IGJ5bD16hI1zW0BKoyUjYDV8cBafPFhtILOe3oGSOn8vxOgKXiIKd4e4oZi3dasJeROgrb9RA==
X-Received: by 2002:a05:6a00:3d0d:b0:74c:f1d8:c42a with SMTP id d2e1a72fcca58-756e99ff9d5mr649781b3a.13.1752605856922;
        Tue, 15 Jul 2025 11:57:36 -0700 (PDT)
Received: from thinku.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4aabdsm12317126b3a.124.2025.07.15.11.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:57:36 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	phillip.wood123@gmail.com,
	shyamthakkar001@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH v4 1/2] commit: avoid scanning trailing comments when 'core.commentChar' is "auto"
Date: Wed, 16 Jul 2025 00:27:00 +0530
Message-ID: <fbee656fb80ef673ea0ee4fafdf4baa9f18b5619.1752602474.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752602474.git.ayu.chandekar@gmail.com>
References: <cover.1752602474.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20250715185700.DxaMIne29A9N3CvyKxTmBjukn2YAiOPCbsGfevxJX2c@z>

When core.commentChar is set to "auto", Git selects a comment character
by scanning the commit message contents and avoiding any character
already present in the message.

If the message still contains old conflict comments (starting with a
comment character), Git assumes that character is in use and chooses a
different one. As a result, those existing comment lines are no longer
recognized as comments and end up being included in the final commit
message.

To avoid this, skip scanning the trailing comment block when selecting
the comment character. This allows Git to safely reuse the original
character when appropriate, keeping the commit message clean and free of
leftover conflict information.

Background:

The "auto" value for core.commentchar was introduced in the commit
84c9dc2c5a (commit: allow core.commentChar=auto for character auto
selection, 2014-05-17) but did not exhibit this issue at that time.

The bug was introduced in commit a6c2654f83 (rebase -m: fix --signoff
with conflicts, 2024-04-18) where Git started writing conflict comments
to the file at 'rebase_path_message()'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 builtin/commit.c           |  6 +++++-
 t/t3418-rebase-continue.sh | 13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index fba0dded64..63e7158e98 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -688,6 +688,10 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	char candidates[] = "#;@!$%^&|:";
 	char *candidate;
 	const char *p;
+	size_t cutoff;
+
+	/* Ignore comment chars in trailing comments (e.g., Conflicts:) */
+	cutoff = sb->len - ignored_log_message_bytes(sb->buf, sb->len);
 
 	if (!memchr(sb->buf, candidates[0], sb->len)) {
 		free(comment_line_str_to_free);
@@ -700,7 +704,7 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	candidate = strchr(candidates, *p);
 	if (candidate)
 		*candidate = ' ';
-	for (p = sb->buf; *p; p++) {
+	for (p = sb->buf; p + 1 < sb->buf + cutoff; p++) {
 		if ((p[0] == '\n' || p[0] == '\r') && p[1]) {
 			candidate = strchr(candidates, p[1]);
 			if (candidate)
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 127216f722..b8a8dd77e7 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -328,6 +328,19 @@ test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebas
 	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
 '
 
+test_expect_success 'no change in comment character due to conflicts markers with core.commentChar=auto' '
+	git checkout -b branch-a &&
+	test_commit A F1 &&
+	git checkout -b branch-b HEAD^ &&
+	test_commit B F1 &&
+	test_must_fail git rebase branch-a &&
+	printf "B\nA\n" >F1 &&
+	git add F1 &&
+	GIT_EDITOR="cat >actual" git -c core.commentChar=auto rebase --continue &&
+	# Check that "#" is still the comment character.
+	test_grep "^# Changes to be committed" actual
+'
+
 test_orig_head_helper () {
 	test_when_finished 'git rebase --abort &&
 		git checkout topic &&
-- 
2.49.0

