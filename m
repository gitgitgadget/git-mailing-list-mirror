Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54331487DC
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 03:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491178; cv=none; b=OvbSTQtBPrO5Wi0KNcWVk3uYWg3iygl9eIwJAEEyg+HNe6Vd2zHLr4ReDOhYMebp5Jnkm16AQZbOkEMSjG8hK6Fogt5ZxVodo6fYRLE0GUNm3Kj8/7x07LJBx40gXO/NI3QJ1/Q1T0cen0dq0fKx5ycfpxu71zw2gEA7HKSdJ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491178; c=relaxed/simple;
	bh=FkOOzXxoLuSU6FxsGrXuvfCZZV1oPJltrVYJ+qLQWsc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=K7ClCZW6zZ8dlXSBQco3exKuOPt22bTBCGPZqzFhrgXhkA/IpXWoFd2vznQ6yVpVI1gAYcWaym63zDmvHguM7vwfSyLkZZVQ8YVaMLN9xm+HojvP2t9IqLsUZVHSTEtqaV5hYffMDYuy2DXgKFc91lPEzU5NcAa+Hk9+oxYmSx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8MDf7/X; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8MDf7/X"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361a50e337so41767775e9.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 19:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734491175; x=1735095975; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPu7oYCsQn34Yi3Ka5yB6c5fY7wRf2V5cXJweCqm8UM=;
        b=k8MDf7/XM2SWLnMvuSCA77KTiNEHAUPeNPWrObIra2cVRuPOulnO0lq2i1BL3qksuK
         FtMG/+nn/F1BRhGduS+G2TfqWnDuUsnDY2mv0VwMMmRhsp95Hgko4OOIV/p4TvSIQPyz
         4xGQxy8/5VAd1GSRbQ32f0Lt/vEZlgpY7X3xAPiue3/UnEgO2CeE3aqCgapdVOE4ak0r
         oC/LEC296UIrAsGeCCt0OlJzTq7BwWvzUFkjLjwVAZagtpuMqWeNvnUA8KddQjiXOHM1
         EIf1nbV2/KPXcD8OA01vLmdpLdnULQu1dm9htf4QOVXlC8tvV17/t2hDBSP+17vCQM5p
         Bnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734491175; x=1735095975;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPu7oYCsQn34Yi3Ka5yB6c5fY7wRf2V5cXJweCqm8UM=;
        b=lCAy4YGAZ4PeU8IeawVZsmm45N1+KNgTgaV3VPGAcBnGs290CrTlgymVezHzChkD5/
         6ohxmI1/DUf8qJia1ZKDexepha0qqyonnXpuDYL5mvsEBwnhJ7mf4CYPuuqvoRSSxZbD
         tewFX09aqfk6trOYhtbqMkOsPFByAiKG0a+kyfJSV8Ec17niPjR9uHts+DEF95Bo4LfJ
         JQCh+X3Par7s0lnGT0MPOd69rsUO+M89R+nB17aFmyt4eeQSxMO4SM6fdJ3XjQvMhsmA
         BVpFNwWKZvy2LbXH3CyGjzAXEInpB0ca8ymXspIbPKq8T92pcPQQIFaUjI2CREot5boI
         HPtA==
X-Gm-Message-State: AOJu0Yyv1+CSNFVcMh4TeBEHFvJFkvUJHCwaCEXgDHzyWHzw3ovuYe3I
	hHk5RhC89wzYzlLaWSZWso87jjX7tlcCDPGS6zxtSn7l956gtc/YPujqNw==
X-Gm-Gg: ASbGnctr6hqASA40zoQfZ3X2vXbAOB7xaTgQKHVzNH4C+SZfCrvLZK/Twwo4FylyAGh
	gZSj6KQ9jVRMBxzaGQS/1J0f/t0qxkjoEP+u8zZ/+0H69ML5mpChJGxFG5c+VczMh5FwNWZX3wl
	qAvGlQBkwrR1d+1/7vNbJUEuS1L5GTuImuS/BXK5u4Xz5nx3+G3KXMpFUlqOESGRhn7M8lKV1vs
	45WT9gRD1CmMeNujbiX1L7mhqIUs7YIWY+Ky1XbHcE0CBePQH4MKDMBww==
X-Google-Smtp-Source: AGHT+IGw582CReNe/XrgqhMx8a7KMd9+OePtp3AXs8VXwLF+cE+o6UbabCJphgps9mIkoYUBIf2biA==
X-Received: by 2002:a05:600c:35cb:b0:434:f1d5:1453 with SMTP id 5b1f17b1804b1-436550af29bmr8604095e9.0.1734491174631;
        Tue, 17 Dec 2024 19:06:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656afc254sm5404095e9.2.2024.12.17.19.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:06:14 -0800 (PST)
Message-Id: <pull.1436.v4.git.git.1734491173098.gitgitgadget@gmail.com>
In-Reply-To: <pull.1436.v3.git.git.1734490498710.gitgitgadget@gmail.com>
References: <pull.1436.v3.git.git.1734490498710.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 03:06:12 +0000
Subject: [PATCH v4] git: replace strbuf_addstr with strbuf_addch for all
 strings of length 2
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

Adding the char directly instead of a string of length 2
is clearer and more efficient.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: replace strbuf_addstr with strbuf_addch for all strings of length 2

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1436%2FAreaZR%2Fstrbuf-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1436/AreaZR/strbuf-v4
Pull-Request: https://github.com/git/git/pull/1436

Range-diff vs v3:

 1:  96a093dec36 ! 1:  413c5ab1f1b git: replace strbuf_addstr with strbuf_addch for all strings of length 2
     @@ bisect.c: static int register_ref(const char *refname, const char *referent UNUS
       	if (!strcmp(refname, term_bad)) {
       		free(current_bad_oid);
      
     - ## builtin/am.c ##
     -@@ builtin/am.c: static void write_author_script(const struct am_state *state)
     - 
     - 	strbuf_addstr(&sb, "GIT_AUTHOR_NAME=");
     - 	sq_quote_buf(&sb, state->author_name);
     --	strbuf_addch(&sb, '\n');
     - 
     --	strbuf_addstr(&sb, "GIT_AUTHOR_EMAIL=");
     -+	strbuf_addstr(&sb, "\nGIT_AUTHOR_EMAIL=");
     - 	sq_quote_buf(&sb, state->author_email);
     --	strbuf_addch(&sb, '\n');
     - 
     --	strbuf_addstr(&sb, "GIT_AUTHOR_DATE=");
     -+	strbuf_addstr(&sb, "\nGIT_AUTHOR_DATE=");
     - 	sq_quote_buf(&sb, state->author_date);
     - 	strbuf_addch(&sb, '\n');
     - 
     -
     - ## builtin/blame.c ##
     -@@ builtin/blame.c: static void get_ac_line(const char *inbuf, const char *what,
     - 
     - 	if (split_ident_line(&ident, tmp, len)) {
     - 	error_out:
     --		/* Ugh */
     --		tmp = "(unknown)";
     --		strbuf_addstr(name, tmp);
     --		strbuf_addstr(mail, tmp);
     --		strbuf_addstr(tz, tmp);
     -+		strbuf_addstr(name, "(unknown)");
     -+		strbuf_addstr(mail, "(unknown)");
     -+		strbuf_addstr(tz, "(unknown)");
     - 		*time = 0;
     - 		return;
     - 	}
     -
       ## builtin/ls-tree.c ##
      @@ builtin/ls-tree.c: static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
       	} else if (padded) {
     @@ builtin/ls-tree.c: static void expand_objectsize(struct strbuf *line, const stru
       }
       
      
     + ## convert.c ##
     +@@ convert.c: static void trace_encoding(const char *context, const char *path,
     + 			((i+1) % 8 && (i+1) < len ? ' ' : '\n')
     + 		);
     + 	}
     +-	strbuf_addchars(&trace, '\n', 1);
     ++	strbuf_addch(&trace, '\n');
     + 
     + 	trace_strbuf(&coe, &trace);
     + 	strbuf_release(&trace);
     +
       ## diff.c ##
      @@ diff.c: static void add_line_count(struct strbuf *out, int count)
       		strbuf_addstr(out, "0,0");
     @@ log-tree.c: void fmt_output_subject(struct strbuf *filename,
       	}
       	strbuf_addf(filename, "%04d-%s", nr, subject);
      
     + ## merge-ort.c ##
     +@@ merge-ort.c: static void path_msg(struct merge_options *opt,
     + 
     + 	va_start(ap, fmt);
     + 	if (opt->priv->call_depth) {
     +-		strbuf_addchars(dest, ' ', 2);
     ++		strbuf_addstr(dest, "  ");
     + 		strbuf_addstr(dest, "From inner merge:");
     + 		strbuf_addchars(dest, ' ', opt->priv->call_depth * 2);
     + 	}
     +
       ## path.c ##
      @@ path.c: const char *remove_leading_path(const char *in, const char *prefix)
       
     @@ path.c: const char *remove_leading_path(const char *in, const char *prefix)
       		strbuf_addstr(&buf, in + j);
       	return buf.buf;
      
     + ## pretty.c ##
     +@@ pretty.c: void pp_user_info(struct pretty_print_context *pp,
     + 
     + 		strbuf_addf(sb, "%s: ", what);
     + 		if (pp->fmt == CMIT_FMT_FULLER)
     +-			strbuf_addchars(sb, ' ', 4);
     ++			strbuf_addstr(sb, "    ");
     + 
     + 		strbuf_addf(&id, "%.*s <%.*s>", (int)namelen, namebuf,
     + 			    (int)maillen, mailbuf);
     +
       ## protocol-caps.c ##
      @@ protocol-caps.c: static void send_info(struct repository *r, struct packet_writer *writer,
       
     @@ protocol-caps.c: static void send_info(struct repository *r, struct packet_write
       				strbuf_addf(&send_buffer, " %lu", object_size);
       			}
      
     + ## send-pack.c ##
     +@@ send-pack.c: static int generate_push_cert(struct strbuf *req_buf,
     + 	if (args->push_options)
     + 		for_each_string_list_item(item, args->push_options)
     + 			strbuf_addf(&cert, "push-option %s\n", item->string);
     +-	strbuf_addstr(&cert, "\n");
     ++	strbuf_addch(&cert, '\n');
     + 
     + 	for (ref = remote_refs; ref; ref = ref->next) {
     + 		if (check_to_send_update(ref, args) < 0)
     +
       ## setup.c ##
      @@ setup.c: static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
       				return GIT_DIR_DISALLOWED_BARE;


 bisect.c                | 2 +-
 builtin/ls-tree.c       | 2 +-
 convert.c               | 2 +-
 diff.c                  | 2 +-
 log-tree.c              | 2 +-
 merge-ort.c             | 2 +-
 path.c                  | 2 +-
 pretty.c                | 2 +-
 protocol-caps.c         | 2 +-
 send-pack.c             | 2 +-
 setup.c                 | 2 +-
 trace2/tr2_tgt_normal.c | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/bisect.c b/bisect.c
index d71c4e4b44b..94bb53c9bf6 100644
--- a/bisect.c
+++ b/bisect.c
@@ -454,7 +454,7 @@ static int register_ref(const char *refname, const char *referent UNUSED, const
 {
 	struct strbuf good_prefix = STRBUF_INIT;
 	strbuf_addstr(&good_prefix, term_good);
-	strbuf_addstr(&good_prefix, "-");
+	strbuf_addch(&good_prefix, '-');
 
 	if (!strcmp(refname, term_bad)) {
 		free(current_bad_oid);
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 8542b5d53e4..605ddb5a719 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -37,7 +37,7 @@ static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
 	} else if (padded) {
 		strbuf_addf(line, "%7s", "-");
 	} else {
-		strbuf_addstr(line, "-");
+		strbuf_addch(line, '-');
 	}
 }
 
diff --git a/convert.c b/convert.c
index c9a31eb4f03..3ee5a22b2a8 100644
--- a/convert.c
+++ b/convert.c
@@ -337,7 +337,7 @@ static void trace_encoding(const char *context, const char *path,
 			((i+1) % 8 && (i+1) < len ? ' ' : '\n')
 		);
 	}
-	strbuf_addchars(&trace, '\n', 1);
+	strbuf_addch(&trace, '\n');
 
 	trace_strbuf(&coe, &trace);
 	strbuf_release(&trace);
diff --git a/diff.c b/diff.c
index 266ddf18e73..61434c6cb45 100644
--- a/diff.c
+++ b/diff.c
@@ -1763,7 +1763,7 @@ static void add_line_count(struct strbuf *out, int count)
 		strbuf_addstr(out, "0,0");
 		break;
 	case 1:
-		strbuf_addstr(out, "1");
+		strbuf_addch(out, '1');
 		break;
 	default:
 		strbuf_addf(out, "1,%d", count);
diff --git a/log-tree.c b/log-tree.c
index 83cc4b1cfb7..d0dc065e4f3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -452,7 +452,7 @@ void fmt_output_subject(struct strbuf *filename,
 
 		strbuf_addf(&temp, "v%s", info->reroll_count);
 		format_sanitized_subject(filename, temp.buf, temp.len);
-		strbuf_addstr(filename, "-");
+		strbuf_addch(filename, '-');
 		strbuf_release(&temp);
 	}
 	strbuf_addf(filename, "%04d-%s", nr, subject);
diff --git a/merge-ort.c b/merge-ort.c
index 11029c10be3..a36c2c936fe 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -827,7 +827,7 @@ static void path_msg(struct merge_options *opt,
 
 	va_start(ap, fmt);
 	if (opt->priv->call_depth) {
-		strbuf_addchars(dest, ' ', 2);
+		strbuf_addstr(dest, "  ");
 		strbuf_addstr(dest, "From inner merge:");
 		strbuf_addchars(dest, ' ', opt->priv->call_depth * 2);
 	}
diff --git a/path.c b/path.c
index 4dcf3c8d40d..04085c164d0 100644
--- a/path.c
+++ b/path.c
@@ -982,7 +982,7 @@ const char *remove_leading_path(const char *in, const char *prefix)
 
 	strbuf_reset(&buf);
 	if (!in[j])
-		strbuf_addstr(&buf, ".");
+		strbuf_addch(&buf, '.');
 	else
 		strbuf_addstr(&buf, in + j);
 	return buf.buf;
diff --git a/pretty.c b/pretty.c
index 098378720a4..84c96fc5a80 100644
--- a/pretty.c
+++ b/pretty.c
@@ -590,7 +590,7 @@ void pp_user_info(struct pretty_print_context *pp,
 
 		strbuf_addf(sb, "%s: ", what);
 		if (pp->fmt == CMIT_FMT_FULLER)
-			strbuf_addchars(sb, ' ', 4);
+			strbuf_addstr(sb, "    ");
 
 		strbuf_addf(&id, "%.*s <%.*s>", (int)namelen, namebuf,
 			    (int)maillen, mailbuf);
diff --git a/protocol-caps.c b/protocol-caps.c
index 855f279c2f7..a841a457bbd 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -65,7 +65,7 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 
 		if (info->size) {
 			if (oid_object_info(r, &oid, &object_size) < 0) {
-				strbuf_addstr(&send_buffer, " ");
+				strbuf_addch(&send_buffer, ' ');
 			} else {
 				strbuf_addf(&send_buffer, " %lu", object_size);
 			}
diff --git a/send-pack.c b/send-pack.c
index 6677c44e8ac..9eb7cdc6ee7 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -373,7 +373,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 	if (args->push_options)
 		for_each_string_list_item(item, args->push_options)
 			strbuf_addf(&cert, "push-option %s\n", item->string);
-	strbuf_addstr(&cert, "\n");
+	strbuf_addch(&cert, '\n');
 
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (check_to_send_update(ref, args) < 0)
diff --git a/setup.c b/setup.c
index 39ff48d9dc5..27535f9f9a2 100644
--- a/setup.c
+++ b/setup.c
@@ -1550,7 +1550,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))
 				return GIT_DIR_INVALID_OWNERSHIP;
-			strbuf_addstr(gitdir, ".");
+			strbuf_addch(gitdir, '.');
 			return GIT_DIR_BARE;
 		}
 
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index baef48aa698..8a05cf2109a 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -226,7 +226,7 @@ static void fn_child_start_fl(const char *file, int line,
 	if (cmd->dir) {
 		strbuf_addstr(&buf_payload, " cd ");
 		sq_quote_buf_pretty(&buf_payload, cmd->dir);
-		strbuf_addstr(&buf_payload, ";");
+		strbuf_addch(&buf_payload, ';');
 	}
 
 	/*

base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
-- 
gitgitgadget
