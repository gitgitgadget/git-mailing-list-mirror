Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT8Ux/LA"
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB93299
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 09:17:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-333536432e0so5491043f8f.3
        for <git@vger.kernel.org>; Tue, 12 Dec 2023 09:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702401469; x=1703006269; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cwj6H6SdgVphOX9gaXmHYAhAtsnq1720msbOnRHnb+U=;
        b=iT8Ux/LAOC6F+L3WB0Zn7wch3wlJCMBliZQgZq8f4dqVP3f7bFLnqUCOXZnLAUtPVB
         /MJjpdeDXiMr6kmREf/6JPT9+xvJ9DCjn1JCh3YWdJ9wPnx804R6wyFM4Utuu5O8Fqc/
         zLEJUOnzZ1JLBYt4WG0accrhS/T8jcRUQhI50Mr1tRBFhiwiPf4wsu1knl4EuGkjJExL
         Gffqfoh8aOwAV1xxDaT/sGxyHJCoz136on4Xo6VQLzgPKZLbkbGQ93uVd6FrQ6j+aqBX
         jX1TMlsHgJL8vJg5xsBEdi1tPzY/i+dFOcjOXee2Or+AUDHT0wsIETkvG2MiWCziK1qQ
         SqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702401469; x=1703006269;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwj6H6SdgVphOX9gaXmHYAhAtsnq1720msbOnRHnb+U=;
        b=qYcwQHu1p+cGm5/m1oZPVKrklRAbDSNR+Pr8nABN3BKN2qc9HHuFWkwOOB+vtxdX/0
         Y80XvXSaO5QdkLJ8QaTmHQ2OnCpIsEH48c/hvmawCYJh6Qf8pbrtl1WZ87wwGt2D5yJG
         iHg8wU3H17r/Pv/qoEeS0zx2QDJIWgLJsNFAmBaW4k5ZkuvYvgnO92YWjXyPDvfy1FgO
         qE7HPik8AG5GRIRdmK06WuVT+6g/q13R7Xeo+dh9yYtQksrHnTDA45PjiHHAi63zWXUa
         V8ZUQBzY6BKWyRFz5/1iPM1iQrZh7Ikntgtfvt25erPZja2+3vUcaZOOKafFR9RTW12V
         J5sQ==
X-Gm-Message-State: AOJu0YwkszOupvCCN9a6rmPwuKSVe42mAEFZlFgCONW9v5pj0Flg5gnl
	/KwRq9Gd9bowP4ZzFNOnF25hS5Jgl/g=
X-Google-Smtp-Source: AGHT+IFcgeVYot7YXtrUI78VMiXmvb7xBsEvQ7PlqA564Xx0LYrhQdCAgnCwnKvEV+c4MCNzNgm4hw==
X-Received: by 2002:a05:600c:511a:b0:405:37bb:d942 with SMTP id o26-20020a05600c511a00b0040537bbd942mr3070434wms.4.1702401468975;
        Tue, 12 Dec 2023 09:17:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0040b45356b72sm19439405wms.33.2023.12.12.09.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:17:48 -0800 (PST)
Message-ID: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
From: "AtariDreams via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Dec 2023 17:17:47 +0000
Subject: [PATCH] Use ^=1 to toggle between 0 and 1
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: AtariDreams <83477269+AtariDreams@users.noreply.github.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

If it is known that an int is either 1 or 0,
doing an exclusive or to switch instead of a
modulus makes more sense and is more efficient.

Signed-off-by: Seija Kijin doremylover123@gmail.com
---
    Use ^=1 to toggle between 0 and 1
    
    If it is known that an int is either 1 or 0, doing an exclusive or to
    switch instead of a modulus makes more sense and is more efficient.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1620%2FAtariDreams%2Fbuffer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1620/AtariDreams/buffer-v1
Pull-Request: https://github.com/git/git/pull/1620

 builtin/fast-export.c      | 4 ++--
 diff.c                     | 2 +-
 ident.c                    | 2 +-
 t/helper/test-path-utils.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 70aff515acb..f9f2c9dd850 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -593,8 +593,8 @@ static void anonymize_ident_line(const char **beg, const char **end)
 	struct ident_split split;
 	const char *end_of_header;
 
-	out = &buffers[which_buffer++];
-	which_buffer %= ARRAY_SIZE(buffers);
+	out = &buffers[which_buffer];
+	which_buffer ^= 1;
 	strbuf_reset(out);
 
 	/* skip "committer", "author", "tagger", etc */
diff --git a/diff.c b/diff.c
index 2c602df10a3..91842b54753 100644
--- a/diff.c
+++ b/diff.c
@@ -1191,7 +1191,7 @@ static void mark_color_as_moved(struct diff_options *o,
 							    &pmb_nr);
 
 			if (contiguous && pmb_nr && moved_symbol == l->s)
-				flipped_block = (flipped_block + 1) % 2;
+				flipped_block ^= 1;
 			else
 				flipped_block = 0;
 
diff --git a/ident.c b/ident.c
index cc7afdbf819..188826eed63 100644
--- a/ident.c
+++ b/ident.c
@@ -459,7 +459,7 @@ const char *fmt_ident(const char *name, const char *email,
 	int want_name = !(flag & IDENT_NO_NAME);
 
 	struct strbuf *ident = &ident_pool[index];
-	index = (index + 1) % ARRAY_SIZE(ident_pool);
+	index ^= 1;
 
 	if (!email) {
 		if (whose_ident == WANT_AUTHOR_IDENT && git_author_email.len)
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 70396fa3845..241136148a5 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -185,7 +185,7 @@ static int check_dotfile(const char *x, const char **argv,
 	int res = 0, expect = 1;
 	for (; *argv; argv++) {
 		if (!strcmp("--not", *argv))
-			expect = !expect;
+			expect ^= 1;
 		else if (expect != (is_hfs(*argv) || is_ntfs(*argv)))
 			res = error("'%s' is %s.git%s", *argv,
 				    expect ? "not " : "", x);

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
-- 
gitgitgadget
