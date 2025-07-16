Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E30A2C3745
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666232; cv=none; b=fedynO+0aGNwP6xDWx0HTAe3V2i4CTuIWScHUwPSHs9TyWJ9DjPIp4xeWclmBh+XVPZ8e0fM4i9+oq7dZWEEJsBEPj8WtQwj21D4UWOfhM6rCHGB+c39JmQo3pvayK4dNIpgrM2cdi5lnGoT7HUMGcxlZdwpHfFfLlmDPR6vzNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666232; c=relaxed/simple;
	bh=laf16dHzij7YCZp2chVsDHBvhNl7TqGcO1i6FVRg77g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M10UDPmkLcoogmyIvhtnAw082WJqzwYhZbzAJGfFy2J4/cEg41GDS22WsDF7QsX5FzdFXM97nBf67V5DU/m28M86DSAN48s8AGiOt+d5I6rpMBwEyd8QWfPgAV6z8nYzuRQp5C37FWacCoSWIAsmG0WvXaW2CKHr23DZlw0iLO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ji+N2G3p; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji+N2G3p"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2352400344aso58758435ad.2
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 04:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752666230; x=1753271030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqNbRtF5Yhb2hQAHA2bjjjALiMHHYd4Ew9MfhRG7N3Y=;
        b=ji+N2G3paVSjOIOQXO8WIi+i1p1ZF5eq6ONWCbN93oBoZoEMmcXa8AXZ01OJ2t6R/8
         XOQqNxFcQs72krzR2r6IFdH5lCBAaXhKypGg/nMVw+039ssVMiLXa5LS37c/nzvBdXnH
         w31jrnybcXpxyDsgicx/Sp7S+d/xS0rgS8qYFwnSGPX98Rdtwywu8+d8eS+R2CJLmn9u
         Dh6dl9YKPqvrXkAzj3yrlpEnG+meLfm4ay0nA601lNRyEtFlCZUB0lDntXNJdMIG+rzI
         /Exe0cJlaQ5fsgI6CssGUWLpC9vzTjEJ4NQDbktEmJpCnQZD3oiEHeACrUrzBM7m0TQN
         nfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752666230; x=1753271030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqNbRtF5Yhb2hQAHA2bjjjALiMHHYd4Ew9MfhRG7N3Y=;
        b=ZNewpLx/uF9+J5vCsDKcyx9yNZZwGXDCQ2IGkPuwZmRMZib3QxmDp5guyc6CrHLDRp
         0r0HEga2PTC/SIa8trA3AM3hqUyW5/iHtJhBGofCXpl14FZR430WL8cCQhmVDhIl6Afz
         OEA3pp4utVcG2ZgXbRmfjyZN+1gtHYV5iGKF2yo3SUQPhMPSN6dofGqri7HnUL8ZVeCL
         AFKH1UWq5CMTpyA93gat9wLcCGZmcZYlYmzeYnfDpLG69eygjovTn63d6HX1guBmh9xi
         pumSAFMMJBvPJHacXsC3QztlDOzFensolkra0I0IhcYW39YqOVrE0foU0X18Dpg1T++4
         qy+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyXWmgGgUAsAfC7y5PdPYrjtbs9jQ5tUWZZt8GcDyw5SFO7j60uSglFtG+h7FaOThL414=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi9X8r9BMb9m0EyBjFqOJIQUNdd8Fni/ey214yriRc+6GLZ3P8
	qD/pgqwmFmXTTR38FFPtzE9fDBPolVp1H21M2kQxVyK06GOXUtoGh7JhegwsyFYM
X-Gm-Gg: ASbGncvoShY3H1nFPPxTIxFiXfVLH/ewOOrRGpdil7qFiG7cFN+w1KhapRTVqw9NCFp
	EEOZOVp/KExKwiKolTSvk1B0Rq28OvtIWvh+LqPhVNg5YERuN/jUEJLP58uFbypK6YgQdan+cnP
	k0x73mMMKeWRuWvLmllWujsCvhkFCqTdylxj43f6djP/OggrT40l31AmzswMGrKn9JaWCcBsBQ3
	JLBiQeRyGSwc0LRim/BHi442nSwQ0APnCvD5rottP7LnmPFPefdf7vyT90Z5hYMoi833A6s5t70
	6dvWJdhuwlSOC2tbCvu7J6wXN1sNXZzpq5ExwQtM8weoAypdWxByBMPiI/gHUYf7wSDZdqFEp2t
	0orRxLvoULQ7bkC/cAAP92AgxaGkwQF80Dpy95qNjM9IFtg==
X-Google-Smtp-Source: AGHT+IHkkp+s5RstTiO2vrYrynnhzCsKdrSjtxuyDDrDhVQ2plI3l7zDvxZ3BxezuIMXiYuxG8p5BQ==
X-Received: by 2002:a17:903:1a2f:b0:22e:72fe:5f9c with SMTP id d9443c01a7336-23e24fe9e9bmr38918465ad.42.1752666230522;
        Wed, 16 Jul 2025 04:43:50 -0700 (PDT)
Received: from thinku.iitr.ac.in ([103.37.201.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f21e970sm1267553a91.39.2025.07.16.04.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:43:50 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	phillip.wood123@gmail.com,
	shyamthakkar001@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH v5 1/2] commit: avoid scanning trailing comments when 'core.commentChar' is "auto"
Date: Wed, 16 Jul 2025 17:13:28 +0530
Message-ID: <fbee656fb80ef673ea0ee4fafdf4baa9f18b5619.1752665506.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752665506.git.ayu.chandekar@gmail.com>
References: <cover.1752665506.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

