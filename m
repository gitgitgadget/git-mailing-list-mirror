Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7F487A5
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 02:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734490504; cv=none; b=A/+lCUiysNS/bMlSpZBc5530XOHrgJrUQVooscQ8CwHe+4LSf9f2dnBmtXZldxNiq1nG20DceVa4twETStDkL+JOIcnb9yD7Fk/u6b2LkYd3TNsBdDw2x2D6ZXqAe+WVU6DNgMPOgkwqCRFohhJmzue8BvaFqMsRIpXVrifOuSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734490504; c=relaxed/simple;
	bh=FnN4q+2q44MAjTX7TIh1DiD+NvaNAVEKfD0bB/MTBXQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BzaXmIgw16XRC6eErG/RB6gVFcom3rU4uWAswWxl0tu9Or93QeD+admwrk7AKRWK1aHyfS6w/SN20j2MD+VD691/lXXsZb52XSAmVqk65lYfhuXuPYd/VWB9S8G9BdanRLTtz7xdk2U5VZZjZ3BTVibM9UC6GIIZCO5/mrDQ//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRnYNM1S; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRnYNM1S"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4362f61757fso46883375e9.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 18:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734490500; x=1735095300; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/4pNLKp3/FdqCa/dEc+hdWnooRX2BlHUvEVd8qFZyQ=;
        b=nRnYNM1SVkLPEz8/JU77nERzqhsiJ6dhmffuNoOB/9ja2AdgSvdc0vPaAxYTmj91wg
         N704HGOpseuZh/Mw+ltuyflg59EQ2r2eYPVhAEts571BrDS/3HGYuSLGRHJrXimgMSa2
         s2A8fUGdQBHzWCgwzrDvU1Jo7ir5DV6wMmo3TPKDP91ckIz4y8zcZn0Cu9rCu1QTgE3B
         xfy6Dgep0CAqfscG+cm88FSJ6TZkYaldtMi3xLd5x21VbH3GkPSF/cfOAg/fb5BZPXXH
         L7aYZXmhk23hETeJUbsXTqb/D3HFVqIO+mkMxob8BozUGm95IKhVjjD6v7C/LhiNxrgD
         I5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734490500; x=1735095300;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/4pNLKp3/FdqCa/dEc+hdWnooRX2BlHUvEVd8qFZyQ=;
        b=Nc+cZFYmFuqEjT9pg8ujFrKArgPQ02ihqzHxYkpgo0tx3o+yYZHI0w6a+M3ZYiUxZQ
         yWB3i+7su0aNSrCeEoT+OpyFImZXyaHMHjEhFrmeo87WjtlBRgPeerABr1uR1jC508V/
         gbHSCkGbHbfOOK57gT97Tz/5WWLuQfv+014s710uPdtbAyYjdJ54LPwCVgDgwMiHsMQy
         SJ5Tetg875zJFm/NANjCSjS9UkwrqRRMluPtykBdDeElte7EcnKu6lM31AkUfSWZ8MW+
         7XjXmeUllMBBBgvflWspmYTNxnp1FddNytjDctW61WCru88IKxtv7X9VfEGFUcKh+hF6
         E5Yw==
X-Gm-Message-State: AOJu0YwmrYp1PYrL4kYHIscsUqGWNwthsmrCKvKTsMcbXgDXxQunjQcJ
	+5SZqxcGH7ySjrnhkUFvaobA88mpefMdHXv06zNfIcBo1As2kaldf7UgAw==
X-Gm-Gg: ASbGncuU+JJAztloA+Z9/iZcfjBUn9On0mvPX8aNAKJIFjzdpMA+q8nBw6YtFtxhDWo
	nX8DWMhbg/PM0V+Kw8/ffKtcexPD/w7gHRYZSZVsixnpNAnbmoWItW+gS5SVM9K1ZcyKPiHJWT4
	0UROjQeThZ7+TkdM8jySjRQEyaAO/w6uerRuU8IKAyCf0Vk9QWgRo+EizN9rabD4mBVCoTtd5tS
	btw39KVGagl/AG4LnI/B2dM5Kg1uKKLkTxaoMLrxbwqwwXIfq5UPGFGAw==
X-Google-Smtp-Source: AGHT+IGFGkjz3HSh2SKcwt6DCP0C4y060utOcsfnpnFucEsptyVJmPNWi7PBvPuu8bJr5xZgaCa68A==
X-Received: by 2002:a5d:47c1:0:b0:385:f10a:335 with SMTP id ffacd0b85a97d-388e4d4477bmr816566f8f.21.1734490500228;
        Tue, 17 Dec 2024 18:55:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8047089sm12896566f8f.85.2024.12.17.18.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 18:54:59 -0800 (PST)
Message-Id: <pull.1436.v3.git.git.1734490498710.gitgitgadget@gmail.com>
In-Reply-To: <pull.1436.v2.git.git.1734481897905.gitgitgadget@gmail.com>
References: <pull.1436.v2.git.git.1734481897905.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 02:54:58 +0000
Subject: [PATCH v3] git: replace strbuf_addstr with strbuf_addch for all
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1436%2FAreaZR%2Fstrbuf-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1436/AreaZR/strbuf-v3
Pull-Request: https://github.com/git/git/pull/1436

Range-diff vs v2:

 1:  22c37ed6677 ! 1:  96a093dec36 git: replace strbuf_addstr with strbuf_addch for all strings of length 2
     @@ Metadata
       ## Commit message ##
          git: replace strbuf_addstr with strbuf_addch for all strings of length 2
      
     -    This helps reduce overhead of calculating the length
     +    Adding the char directly instead of a string of length 2
     +    is clearer and more efficient.
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
     @@ log-tree.c: void fmt_output_subject(struct strbuf *filename,
       	}
       	strbuf_addf(filename, "%04d-%s", nr, subject);
      
     - ## merge-ort.c ##
     -@@ merge-ort.c: static void path_msg(struct merge_options *opt,
     - 
     - 	va_start(ap, fmt);
     - 	if (opt->priv->call_depth) {
     --		strbuf_addchars(dest, ' ', 2);
     --		strbuf_addstr(dest, "From inner merge:");
     -+		strbuf_addstr(dest, "  From inner merge:");
     - 		strbuf_addchars(dest, ' ', opt->priv->call_depth * 2);
     - 	}
     - 	strbuf_vaddf(dest, fmt, ap);
     -
       ## path.c ##
      @@ path.c: const char *remove_leading_path(const char *in, const char *prefix)
       


 bisect.c                | 2 +-
 builtin/am.c            | 6 ++----
 builtin/blame.c         | 8 +++-----
 builtin/ls-tree.c       | 2 +-
 diff.c                  | 2 +-
 log-tree.c              | 2 +-
 path.c                  | 2 +-
 protocol-caps.c         | 2 +-
 setup.c                 | 2 +-
 trace2/tr2_tgt_normal.c | 2 +-
 10 files changed, 13 insertions(+), 17 deletions(-)

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
diff --git a/builtin/am.c b/builtin/am.c
index bfa95147cf4..6cb9fd4f45f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -341,13 +341,11 @@ static void write_author_script(const struct am_state *state)
 
 	strbuf_addstr(&sb, "GIT_AUTHOR_NAME=");
 	sq_quote_buf(&sb, state->author_name);
-	strbuf_addch(&sb, '\n');
 
-	strbuf_addstr(&sb, "GIT_AUTHOR_EMAIL=");
+	strbuf_addstr(&sb, "\nGIT_AUTHOR_EMAIL=");
 	sq_quote_buf(&sb, state->author_email);
-	strbuf_addch(&sb, '\n');
 
-	strbuf_addstr(&sb, "GIT_AUTHOR_DATE=");
+	strbuf_addstr(&sb, "\nGIT_AUTHOR_DATE=");
 	sq_quote_buf(&sb, state->author_date);
 	strbuf_addch(&sb, '\n');
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 6a7bb3b0724..c1ee2585ee8 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -148,11 +148,9 @@ static void get_ac_line(const char *inbuf, const char *what,
 
 	if (split_ident_line(&ident, tmp, len)) {
 	error_out:
-		/* Ugh */
-		tmp = "(unknown)";
-		strbuf_addstr(name, tmp);
-		strbuf_addstr(mail, tmp);
-		strbuf_addstr(tz, tmp);
+		strbuf_addstr(name, "(unknown)");
+		strbuf_addstr(mail, "(unknown)");
+		strbuf_addstr(tz, "(unknown)");
 		*time = 0;
 		return;
 	}
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
