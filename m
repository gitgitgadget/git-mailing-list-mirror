Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2739A8C1E
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 00:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741825278; cv=none; b=RZSHdwrzNlfuZDiqMXN/X83/hOS25VUeinaAmj/3Lqu5zdrNqre9CER23i5qyKaOPTA9kBzOuheTbFVgTSOaXu4Qs3Pvzd5sUIMqV7vfkldYJcPj9WrOHzIUsN0MmI0VcqKfPtVTVHtbmK1qber0VjboH6MqrklokgC0fCQOREI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741825278; c=relaxed/simple;
	bh=XW5L3G90FzM5AEckAAFfWU3a2fE6OjPX2Pq2jhr5/c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkSZ4wzS05rJyd8l0vzORflLUAmotasquLMDGcDq4C5cm0lWY5p2BC2BLdG4IFqSSfF2ogRSTotREp2XbWiUOtLOU+oM+2Y8nGLHsIaC2ylst5SMdnXhntpUrAcGdKzDRfXggrg4cydqW4tY2qGzM7sTAI9FaG6+pWlHm+TU7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKSN7eOI; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKSN7eOI"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-728a433ec30so462426a34.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 17:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741825276; x=1742430076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doN1OqOqzF/i94F7+VO7WMeXNO5T3b3R+IP2A8tbVIw=;
        b=lKSN7eOIJo1rhFhULNcBBtVRLROGIElrJudKhSmuenkb8e6rEQV42TdcbZ6HzTuher
         dozJIyZXl6LYcxZZghoxXzwi7z10bi+G8s8IgeTpOXUjrrfTqDzkc9SYIwwF9lYyRnak
         vfpUTidZVHQ7Oap0/YDbsiQJVcdhV5hqi9UWGF8VjQ++Swau8sdI03EPoEHlCHoX3zm4
         G2zmDpx62vvbual7DrYp8vYhYMQFS4uPxX+2JtyfEzQUkM01ZcZLULdUSRiuD5Uaoa9w
         RvxgDzVngJmz/W9oUPGlYdxHLgkxvXg20WoBzyA9vqJIOEIxtyskyUrbOmh3vcwAYLP6
         YeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741825276; x=1742430076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doN1OqOqzF/i94F7+VO7WMeXNO5T3b3R+IP2A8tbVIw=;
        b=OqhqIHtARdYfWHG5Qy23QHFJz7IB0TDEqpoQosG0NuyNyiegy50E6cZwfdD4b6DySp
         MQlgllUzTX960a8kwUKu+Dw/qW2R5Zig1X++PvOt7nFK+mdbzd/HT8zfxmaw1ve9iiiT
         kMb/BYwcZdM7EvpoZTncW8XrhzIgxFZK6qrdsfIbsE7RHtjgkZ4XCaYFQEYa7XAmkG1D
         mbyYTPsCWAhsRJBkhuY7sTOUm+SRgVxva9ImT/dUmPUD9p9BeudpC5flWrSVDYHx6UrZ
         YMQje9ovIW4EoAnEGFI+b8BjeE4nfbLOgquuTU7jE6dni3sxG5quA6ofLJFi84j/lhM4
         7/pA==
X-Gm-Message-State: AOJu0YzrSxmvJvICEyBv6swilcq1EwsQ5R5OlhBe3S2krgNvdlMC08vN
	CuChTLhcS6OZ5ah41p5TEyvlC4BZe7CIx+2b7Oljv250RCnTk4sB1ivf5c1O
X-Gm-Gg: ASbGncvXGfd6it1IcqsmlZHx2zF6NyVPPiImljxp8z/n2MYBDsW47FJViA1KjfJLQ4/
	PONPAJy69Mhmlz3s35UEaDujCZyB4aHy0j376LXKuhol5RYX321SUP+1gBIth0hZyDF7iVX1y4c
	f70L09sXpKXc77mqke/Y7aVuadJfpQIe7NJKYgGr7caT9HbxQ55u9+/ebox29LJAj20XMxq+DgD
	cXxPWbh55qgG4mMFeoa+QWv/pr9ZkFr3Wb5o+h3IGr4CVrwFcTAB3wiCqoMgRRJuyjN64Uw6pEt
	dAlKcb3+V6AlYLtp267VCDuDqQ5UINYqCQZ0LA3MjTjRof433IVN
X-Google-Smtp-Source: AGHT+IFb2bOvWwGFSE3lN6pr/Z2aXqOdTK6mm8LtX/NdlEOiT8kBiy7tyde/EJP49ehdOgYFYGvK9g==
X-Received: by 2002:a05:6830:718b:b0:72a:1821:aa9c with SMTP id 46e09a7af769-72a37b6ffaamr15040540a34.8.1741825275920;
        Wed, 12 Mar 2025 17:21:15 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb267a8b4sm24028a34.9.2025.03.12.17.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 17:21:15 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	peff@peff.net,
	ben.knoble@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/6] revision: support NUL-delimited --stdin mode
Date: Wed, 12 Mar 2025 19:17:03 -0500
Message-ID: <20250313001706.3390502-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250313001706.3390502-1-jltobler@gmail.com>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250313001706.3390502-1-jltobler@gmail.com>
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

