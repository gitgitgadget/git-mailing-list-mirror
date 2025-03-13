Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320812E3385
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 00:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910508; cv=none; b=c8FkqGFGIi+9BCJibkdJFm24I7qKI1NZXPXJzLAnkD/RR3RB6XYQoS25jZXio69ciGzbZY1CRE1k8mmCZbipqagWM4BwNMIhSxvdq/AJh9z2psHlE05szLJeCFU+WlelC0zI/+swX0/3VgliKqU1Mf+yMKjfSrJwSZaVCPh+nvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910508; c=relaxed/simple;
	bh=XW5L3G90FzM5AEckAAFfWU3a2fE6OjPX2Pq2jhr5/c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWoaWof/9dbASwtS508SGYkcF6Hv/G4ORvAZA/uU7IzITEHYynZTuwONOIQ0WIm8dmm68VjHH6jcp3cztmSqhwvSa58QMQr4kZ/gR+ZcJXJTNOA/n+o09474QjOv1hez4r6wnPQIVOfLlDFr+fczNE/UiAdr5Em68uNMyQDZwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKermL53; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKermL53"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72736498817so917488a34.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741910505; x=1742515305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doN1OqOqzF/i94F7+VO7WMeXNO5T3b3R+IP2A8tbVIw=;
        b=bKermL53YkHvse9XyqHPq1KHwxNNWsRCGbSMKD7C6Y5w0/pMBmTsgqQEUI/N5sYRAa
         cDQr9RlaCXb2Mu/EIQ2Y9tYIJQOJyvP8I6Rh9dsoanohYLFUZ8wdZBaUOhtVoTKUDzeL
         6iGoI67P+h+1VzcG5ukjLUav8yvAwwo1u/DfLOJYXVacztdGZwpDz6WZma8v9q6JJPkL
         gumCMPZtrtNgKZtCUDd2PSYoUY8MTq2KMvgr/KyTMdCHL2eJWGPLia/BPkdhnF6Iddt0
         M/2NxcdTsyavuSZAQDGvbSOtmZ3Uu8mDC39Dfnasz4kAd//ANckGNX6gYME7LXx5CCBt
         o7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741910505; x=1742515305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doN1OqOqzF/i94F7+VO7WMeXNO5T3b3R+IP2A8tbVIw=;
        b=XWisVVVSC1s/WvRBayiFlZ5aFvzN6BoDunUV3mLZpGLmYQSF7Jiq5RJq9kSZFmrTuU
         rzqGkfwBpi9binzTy5jRSG3iNMipHugnRZ7lxyEyBBfEaovi+C9XvI+aRdXTHphn7+3M
         tGils3dhIR8TF34bD3IkjZaE6GFtS3/l/CEi5gNzN9E7P0T+qgttymD1pLgQbPXnyYuu
         LkhXme4HnRl/TWpxirk3Dk7k9Zx6ud7xrbLDoVe3bJp3B6s+87F07NAp8kq+yJAlpA+J
         nGZN70JvEsuEfzhJGkCG1z+UKSAyMtL4/JR0w7WVuzmIUK5LVBtnvysOrQjzbhIh0Ncb
         cSLw==
X-Gm-Message-State: AOJu0YzlYmm48Af+hM3+cmJQyBKBfBt1JmV++y8x1x4DAfXzz3yoj3h9
	R/PvZcLNcVfXDiqFFrKqOjQodQ6q8Ae8EnDpk2l1HeJGMYrmWAwYENV3KQ==
X-Gm-Gg: ASbGnctpUb9/kh0qMESWDC8NEfjzrqeGU4vXz9HtI+iRBK33VtYDxVeA8yTkXOX6Kwj
	4mWFl8JsQQoTWPRM1N6nndFbc82ks42YfP31Zc2Xwz9jjoWWqK1zPomctWc81+qRRHD6EoIdUiC
	rygHo+enPwYzgoJKXv0SaaPU2y+p7YxKCjlnZJdxAIjnBn1W+DlZxZrDN4X9vGd4ziYmwwBc+KC
	RYvD+Y7vUealY38a+s2dAKvuoJn22lbULnhYZCroLEcJa+s/RarI46vcJfNoPUBEhTKJR6DFYJM
	NuuTIR9419J5mdOMY6RzpIK41tqJjFedEmEMEQajgDuYQyUnmv7m
X-Google-Smtp-Source: AGHT+IGIi32I6zqxU5C5pw82cFaBLTJr7KrxU/4iQibF6lQ7iwTUEKP0AuA3Gx0VevjQffcqn4FOVg==
X-Received: by 2002:a05:6830:4413:b0:72b:8f8b:33b with SMTP id 46e09a7af769-72bbc22c96cmr234825a34.10.1741910504946;
        Thu, 13 Mar 2025 17:01:44 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e973sm423485a34.43.2025.03.13.17.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 17:01:43 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	peff@peff.net,
	ben.knoble@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/6] revision: support NUL-delimited --stdin mode
Date: Thu, 13 Mar 2025 18:57:44 -0500
Message-ID: <20250313235747.9583-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250313235747.9583-1-jltobler@gmail.com>
References: <20250313001706.3390502-1-jltobler@gmail.com>
 <20250313235747.9583-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `setup_revisions()` parses the `--stdin` option, revision and
pathspec arguments are read from stdin. Each line of input is handled as
a separate argument.

Introduce the `nul_delim_stdin` field to `setup_revision_opt` that, when
enabled, uses a NUL byte to delimit between stdin arguments instead of
newline.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 revision.c | 19 +++++++++++--------
 revision.h |  3 ++-
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index 0eaebe4478..5de6309830 100644
--- a/revision.c
+++ b/revision.c
@@ -2275,10 +2275,10 @@ int handle_revision_arg(const char *arg, struct rev_info *revs, int flags, unsig
 	return ret;
 }
 
-static void read_pathspec_from_stdin(struct strbuf *sb,
-				     struct strvec *prune)
+static void read_pathspec_from_stdin(struct strbuf *sb, struct strvec *prune,
+				     int line_term)
 {
-	while (strbuf_getline(sb, stdin) != EOF)
+	while (strbuf_getdelim_strip_crlf(sb, stdin, line_term) != EOF)
 		strvec_push(prune, sb->buf);
 }
 
@@ -2905,8 +2905,8 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 	return 1;
 }
 
-static void read_revisions_from_stdin(struct rev_info *revs,
-				      struct strvec *prune)
+static void read_revisions_from_stdin(struct rev_info *revs, struct strvec *prune,
+				      int line_term)
 {
 	struct strbuf sb;
 	int seen_dashdash = 0;
@@ -2918,7 +2918,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 	warn_on_object_refname_ambiguity = 0;
 
 	strbuf_init(&sb, 1000);
-	while (strbuf_getline(&sb, stdin) != EOF) {
+	while (strbuf_getdelim_strip_crlf(&sb, stdin, line_term) != EOF) {
 		if (!sb.len)
 			break;
 
@@ -2946,7 +2946,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 			die("bad revision '%s'", sb.buf);
 	}
 	if (seen_dashdash)
-		read_pathspec_from_stdin(&sb, prune);
+		read_pathspec_from_stdin(&sb, prune, line_term);
 
 	strbuf_release(&sb);
 	warn_on_object_refname_ambiguity = save_warning;
@@ -3019,13 +3019,16 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			}
 
 			if (!strcmp(arg, "--stdin")) {
+				int term = opt && opt->nul_delim_stdin ? '\0' : '\n';
+
 				if (revs->disable_stdin) {
 					argv[left++] = arg;
 					continue;
 				}
 				if (revs->read_from_stdin++)
 					die("--stdin given twice?");
-				read_revisions_from_stdin(revs, &prune_data);
+				read_revisions_from_stdin(revs, &prune_data,
+							  term);
 				continue;
 			}
 
diff --git a/revision.h b/revision.h
index 21c6a69899..0e680c3667 100644
--- a/revision.h
+++ b/revision.h
@@ -439,7 +439,8 @@ struct setup_revision_opt {
 	void (*tweak)(struct rev_info *);
 	unsigned int	assume_dashdash:1,
 			allow_exclude_promisor_objects:1,
-			free_removed_argv_elements:1;
+			free_removed_argv_elements:1,
+			nul_delim_stdin:1;
 	unsigned revarg_opt;
 };
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
-- 
2.49.0.rc2

