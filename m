Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E27E572
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708241621; cv=none; b=snVWSBgEOJsp5OgXezC7Z3Csz3VvjvSQFx5cO1SZenDuZTxRBSdkn9rfBsWSQEbZ/264LeCJTud2p5yTGMNFvyjEEP2cyPyeTmdOJBIYKu5ixNXDkhcBMM8oiz+Rp3iSXv/kwP+Db6l1Zk7qzxf0IrzaS07iwesxgcoi2lfIw18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708241621; c=relaxed/simple;
	bh=nGX6vLPfqqm0vBIu2q8/Js0XqrRFaQ/OGBKm9bc2DOE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Yszou2DqPBpcjmXdAsRbtoqtXatNtX8EENLZ8w4xHowf9jhjA6uF8VrgBWYfpdRbP479GuPkYg8DNRPrLGMMh3xw18DZ9dVXBTo8fim/sO8P7pnSeryqDyEQrVkb41e6QTWq5pLj2i5lxo6TJbhF54H488AFhL67j/ZDFltBpXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJR00Zr3; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJR00Zr3"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso39164091fa.3
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 23:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708241617; x=1708846417; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEEz+vKVRLG46q9uHuS4oE7thy/XFbz/wG1i3jVoL6s=;
        b=lJR00Zr3Xs3Vhm6NEPiMiZIHtrIsyTGMrLU1MAngdnScCpEVODDq/pognRk+vktT3U
         XJEOZ0Rlu/7lMKxCCNpN3zsVBfl1/OoPD3OiNi9YV8bYMl6sygaoQQLH47WUEJlol/Q2
         f29RdHj2UNidiWUYBMW7BecWoineKooSEOOZ0L1hgOsPJHKci4kujopvenEv1GiUTRnd
         RoYU4dzVVttNSE4ADlWJTIdUJ+ynDPqRRR4XS9CQtvy6AzXLS0gjCBrbZ77vx7fgiW0r
         dcHqQjjnXd5Z6EpaQoxIqXeNXPwlR/hsAzCq6hVJk/9vIX6gr1JdkLJkTq3yqc0SJrze
         yW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708241617; x=1708846417;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEEz+vKVRLG46q9uHuS4oE7thy/XFbz/wG1i3jVoL6s=;
        b=gtAbW2GSUvQLehniRuoXFsN0AzEySRdFeqSjXWE2yMdUZkwV89XEsnfcPjMpPZJBUs
         curtgEcn4jgApgWcgGBDgM2tRxQGClynCd3qwBelkHyMmOpOInN7+sLRJ7NsZa/1m/gS
         ynmz4RxokhwakEozJeSwt8MIgirlf9o9ogM7OIq3i58T4IoxPGJbyY2RhpUJIhHXK91Z
         4sJ0g6ELqd3wWabLOiW2pUoDSs0h9i+yPKiu/CJWmWiXBcajiCzLEzki/b+KsTea6MyZ
         0hwyGm+1JLkiiG7MFw16Dk2CkxmT/8Dz08v2l4zU59Q/ndISbKWQ5rGrzb8Ii9RiebIs
         riXg==
X-Gm-Message-State: AOJu0YwVgPF694fv27hLOf5s4Y6WdZpcKBO3wPb3l+rmxPcD6Rt6ph4a
	XYzOIIw1R/kbu7YbbW9WW6wpgzk6sLYjnOGZ9ffKlALUgdgnHnDklfgRvncr
X-Google-Smtp-Source: AGHT+IEDtYlwQzaSxdVN0hd5iHL7/jhSpI/c109/bKbr6Cun+KCIMmPDv/7mVekn4lCF3J7arNGKVg==
X-Received: by 2002:a2e:9b51:0:b0:2d0:ab90:adbc with SMTP id o17-20020a2e9b51000000b002d0ab90adbcmr5887657ljj.28.1708241616483;
        Sat, 17 Feb 2024 23:33:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jj9-20020a05600c6a0900b0040fb44a9288sm7220834wmb.48.2024.02.17.23.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:33:34 -0800 (PST)
Message-ID: <677da78652c58f6d0e147638b7b2313dffb0d858.1708241613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
References: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
From: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Feb 2024 07:33:29 +0000
Subject: [PATCH 2/5] apply: use new promise structures in git-apply logic as a
 proving ground
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Emily Shaffer <nasamuffin@google.com>,
    Philip Peterson <philip.c.peterson@gmail.com>,
    Philip Peterson <philip.c.peterson@gmail.com>

From: Philip Peterson <philip.c.peterson@gmail.com>

Uses the new promise paradigm in a simple example with git apply and git
am. Several operations that may produce errors are encapsulated in a
promise, so that any errors may be captured and handled according to how
the caller wants to do so.

As an added bonus, we can see more context in error messages now, for
example:

% git apply -3 garbage.patch
error:
	could not find header
caused by:
	no lines to read

Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>
---
 apply.c      | 133 +++++++++++++++++++++++++++++++++------------------
 apply.h      |   9 +++-
 range-diff.c |  14 ++++--
 3 files changed, 103 insertions(+), 53 deletions(-)

diff --git a/apply.c b/apply.c
index 7608e3301ca..fb6b7074c19 100644
--- a/apply.c
+++ b/apply.c
@@ -26,6 +26,7 @@
 #include "object-file.h"
 #include "parse-options.h"
 #include "path.h"
+#include "promise.h"
 #include "quote.h"
 #include "read-cache.h"
 #include "rerere.h"
@@ -1316,13 +1317,14 @@ static int check_header_line(int linenr, struct patch *patch)
 	return 0;
 }
 
-int parse_git_diff_header(struct strbuf *root,
+void parse_git_diff_header(struct strbuf *root,
 			  int *linenr,
 			  int p_value,
 			  const char *line,
 			  int len,
 			  unsigned int size,
-			  struct patch *patch)
+			  struct patch *patch,
+			  struct promise_t* return_promise)
 {
 	unsigned long offset;
 	struct gitdiff_data parse_hdr_state;
@@ -1386,10 +1388,12 @@ int parse_git_diff_header(struct strbuf *root,
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
 			res = p->fn(&parse_hdr_state, line + oplen, patch);
-			if (res < 0)
-				return -1;
-			if (check_header_line(*linenr, patch))
-				return -1;
+			if (res < 0) {
+				PROMISE_THROW(return_promise, APPLY_ERR_GENERIC, "operation for \"%s\" failed with code: %d", p->str, res);
+			}
+			if (check_header_line(*linenr, patch)) {
+				PROMISE_THROW(return_promise, APPLY_ERR_GENERIC, "invalid header lines");
+			}
 			if (res > 0)
 				goto done;
 			break;
@@ -1399,25 +1403,25 @@ int parse_git_diff_header(struct strbuf *root,
 done:
 	if (!patch->old_name && !patch->new_name) {
 		if (!patch->def_name) {
-			error(Q_("git diff header lacks filename information when removing "
-				 "%d leading pathname component (line %d)",
-				 "git diff header lacks filename information when removing "
-				 "%d leading pathname components (line %d)",
-				 parse_hdr_state.p_value),
-			      parse_hdr_state.p_value, *linenr);
-			return -128;
+			PROMISE_THROW(return_promise, -128,
+				Q_("git diff header lacks filename information when removing "
+					"%d leading pathname component (line %d)",
+					"git diff header lacks filename information when removing "
+					"%d leading pathname components (line %d)",
+					parse_hdr_state.p_value),
+					parse_hdr_state.p_value, *linenr
+			);
 		}
 		patch->old_name = xstrdup(patch->def_name);
 		patch->new_name = xstrdup(patch->def_name);
 	}
 	if ((!patch->new_name && !patch->is_delete) ||
 	    (!patch->old_name && !patch->is_new)) {
-		error(_("git diff header lacks filename information "
+		PROMISE_THROW(return_promise, -128, _("git diff header lacks filename information "
 			"(line %d)"), *linenr);
-		return -128;
 	}
 	patch->is_toplevel_relative = 1;
-	return offset;
+	PROMISE_SUCCEED(return_promise, offset);
 }
 
 static int parse_num(const char *line, unsigned long *p)
@@ -1539,16 +1543,17 @@ static int parse_fragment_header(const char *line, int len, struct fragment *fra
 /*
  * Find file diff header
  *
- * Returns:
+ * Resolves promise with:
  *  -1 if no header was found
  *  -128 in case of error
  *   the size of the header in bytes (called "offset") otherwise
  */
-static int find_header(struct apply_state *state,
+static void find_header(struct apply_state *state,
 		       const char *line,
 		       unsigned long size,
 		       int *hdrsize,
-		       struct patch *patch)
+		       struct patch *patch,
+			   struct promise_t* return_promise)
 {
 	unsigned long offset, len;
 
@@ -1577,9 +1582,8 @@ static int find_header(struct apply_state *state,
 			struct fragment dummy;
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
-			error(_("patch fragment without header at line %d: %.*s"),
+			PROMISE_THROW(return_promise, -128, _("patch fragment without header at line %d: %.*s"),
 				     state->linenr, (int)len-1, line);
-			return -128;
 		}
 
 		if (size < len + 6)
@@ -1590,15 +1594,25 @@ static int find_header(struct apply_state *state,
 		 * or mode change, so we handle that specially
 		 */
 		if (!memcmp("diff --git ", line, 11)) {
-			int git_hdr_len = parse_git_diff_header(&state->root, &state->linenr,
+			int git_hdr_len;
+			struct promise_t *parse_git_diff_header_promise = promise_init();
+			parse_git_diff_header(&state->root, &state->linenr,
 								state->p_value, line, len,
-								size, patch);
-			if (git_hdr_len < 0)
-				return -128;
+								size, patch, parse_git_diff_header_promise);
+			promise_assert_finished(parse_git_diff_header_promise);
+
+			if (parse_git_diff_header_promise->state == PROMISE_FAILURE) {
+				PROMISE_BUBBLE_UP(return_promise, parse_git_diff_header_promise,
+						 _("could not find file diff header"));
+			}
+
+			git_hdr_len = parse_git_diff_header_promise->result.success_result;
+			promise_release(parse_git_diff_header_promise);
 			if (git_hdr_len <= len)
 				continue;
 			*hdrsize = git_hdr_len;
-			return offset;
+			PROMISE_SUCCEED(return_promise, offset);
+			return;
 		}
 
 		/* --- followed by +++ ? */
@@ -1615,13 +1629,14 @@ static int find_header(struct apply_state *state,
 			continue;
 
 		/* Ok, we'll consider it a patch */
-		if (parse_traditional_patch(state, line, line+len, patch))
-			return -128;
+		if (parse_traditional_patch(state, line, line+len, patch)) {
+			PROMISE_THROW(return_promise, -128, "could not parse traditional patch");
+		}
 		*hdrsize = len + nextlen;
 		state->linenr += 2;
-		return offset;
+		PROMISE_SUCCEED(return_promise, offset);
 	}
-	return -1;
+	PROMISE_THROW(return_promise, APPLY_ERR_GENERIC, "no lines to read");
 }
 
 static void record_ws_error(struct apply_state *state,
@@ -2129,19 +2144,29 @@ static int use_patch(struct apply_state *state, struct patch *p)
  * reading after seeing a single patch (i.e. changes to a single file).
  * Create fragments (i.e. patch hunks) and hang them to the given patch.
  *
- * Returns:
+ * Resolves promise with:
  *   -1 if no header was found or parse_binary() failed,
  *   -128 on another error,
  *   the number of bytes consumed otherwise,
  *     so that the caller can call us again for the next patch.
  */
-static int parse_chunk(struct apply_state *state, char *buffer, unsigned long size, struct patch *patch)
+static void parse_chunk(struct apply_state *state, char *buffer, unsigned long size, struct patch *patch, struct promise_t* return_promise)
 {
-	int hdrsize, patchsize;
-	int offset = find_header(state, buffer, size, &hdrsize, patch);
+	int hdrsize = -1, patchsize, offset;
+	struct promise_t *find_header_promise = promise_init();
+	find_header(state, buffer, size, &hdrsize, patch, find_header_promise);
+	promise_assert_finished(find_header_promise);
 
-	if (offset < 0)
-		return offset;
+	if (find_header_promise->state == PROMISE_FAILURE) {
+		PROMISE_BUBBLE_UP(return_promise, find_header_promise, _("could not find header"));
+	}
+
+	offset = find_header_promise->result.success_result;
+	promise_release(find_header_promise);
+
+	if (offset < 0) {
+		PROMISE_SUCCEED(return_promise, offset);
+	}
 
 	prefix_patch(state, patch);
 
@@ -2159,8 +2184,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 				       size - offset - hdrsize,
 				       patch);
 
-	if (patchsize < 0)
-		return -128;
+	if (patchsize < 0) {
+		PROMISE_THROW(return_promise, -128, _("could not parse patch"));
+	}
 
 	if (!patchsize) {
 		static const char git_binary[] = "GIT binary patch\n";
@@ -2173,8 +2199,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 			state->linenr++;
 			used = parse_binary(state, buffer + hd + llen,
 					    size - hd - llen, patch);
-			if (used < 0)
-				return -1;
+			if (used < 0) {
+				PROMISE_THROW(return_promise, -1, _("could not parse binary patch"));
+			}
 			if (used)
 				patchsize = used + llen;
 			else
@@ -2205,12 +2232,11 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 */
 		if ((state->apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch))) {
-			error(_("patch with only garbage at line %d"), state->linenr);
-			return -128;
+			PROMISE_THROW(return_promise, -128, _("patch with only garbage at line %d"), state->linenr);
 		}
 	}
 
-	return offset + hdrsize + patchsize;
+	PROMISE_SUCCEED(return_promise, offset + hdrsize + patchsize);
 }
 
 static void reverse_patches(struct patch *p)
@@ -4755,21 +4781,36 @@ static int apply_patch(struct apply_state *state,
 		return -128;
 	offset = 0;
 	while (offset < buf.len) {
-		struct patch *patch;
 		int nr;
+		struct patch *patch;
+		struct promise_t *parse_chunk_promise;
 
 		CALLOC_ARRAY(patch, 1);
 		patch->inaccurate_eof = !!(options & APPLY_OPT_INACCURATE_EOF);
 		patch->recount =  !!(options & APPLY_OPT_RECOUNT);
-		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
-		if (nr < 0) {
+
+		parse_chunk_promise = promise_init();
+		parse_chunk(state, buf.buf + offset, buf.len - offset, patch, parse_chunk_promise);
+
+		promise_assert_finished(parse_chunk_promise);
+
+		if (parse_chunk_promise->state == PROMISE_FAILURE) {
+			int nr;
+			nr = parse_chunk_promise->result.failure_result.status;
 			free_patch(patch);
 			if (nr == -128) {
+				error("\n\t%s", parse_chunk_promise->result.failure_result.message.buf);
+				promise_release(parse_chunk_promise);
 				res = -128;
 				goto end;
 			}
+			promise_release(parse_chunk_promise);
 			break;
 		}
+
+		nr = parse_chunk_promise->result.success_result;
+		promise_release(parse_chunk_promise);
+
 		if (state->apply_in_reverse)
 			reverse_patches(patch);
 		if (use_patch(state, patch)) {
diff --git a/apply.h b/apply.h
index 7cd38b1443c..44af75883c5 100644
--- a/apply.h
+++ b/apply.h
@@ -5,6 +5,10 @@
 #include "lockfile.h"
 #include "string-list.h"
 #include "strmap.h"
+#include "promise.h"
+
+/* Error codes (must be less than 0) */
+#define APPLY_ERR_GENERIC -1
 
 struct repository;
 
@@ -165,13 +169,14 @@ int check_apply_state(struct apply_state *state, int force_apply);
  *
  * Returns -1 on failure, the length of the parsed header otherwise.
  */
-int parse_git_diff_header(struct strbuf *root,
+void parse_git_diff_header(struct strbuf *root,
 			  int *linenr,
 			  int p_value,
 			  const char *line,
 			  int len,
 			  unsigned int size,
-			  struct patch *patch);
+			  struct patch *patch,
+			  struct promise_t *promise);
 
 void release_patch(struct patch *patch);
 
diff --git a/range-diff.c b/range-diff.c
index c45b6d849cb..3ef8b976a0c 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -121,8 +121,8 @@ static int read_patches(const char *range, struct string_list *list,
 		if (starts_with(line, "diff --git")) {
 			struct patch patch = { 0 };
 			struct strbuf root = STRBUF_INIT;
+			struct promise_t *parse_git_diff_header_promise = promise_init();
 			int linenr = 0;
-			int orig_len;
 
 			in_header = 0;
 			strbuf_addch(&buf, '\n');
@@ -130,16 +130,20 @@ static int read_patches(const char *range, struct string_list *list,
 				util->diff_offset = buf.len;
 			if (eol)
 				*eol = '\n';
-			orig_len = len;
-			len = parse_git_diff_header(&root, &linenr, 0, line,
-						    len, size, &patch);
-			if (len < 0) {
+			parse_git_diff_header(&root, &linenr, 0, line,
+						    len, size, &patch, parse_git_diff_header_promise);
+			promise_assert_finished(parse_git_diff_header_promise);
+			if (parse_git_diff_header_promise->state == PROMISE_FAILURE) {
+				int orig_len = len;
 				error(_("could not parse git header '%.*s'"),
 				      orig_len, line);
 				FREE_AND_NULL(util);
 				string_list_clear(list, 1);
+				promise_release(parse_git_diff_header_promise);
 				goto cleanup;
 			}
+			len = parse_git_diff_header_promise->result.success_result;
+			promise_release(parse_git_diff_header_promise);
 			strbuf_addstr(&buf, " ## ");
 			if (patch.is_new > 0)
 				strbuf_addf(&buf, "%s (new)", patch.new_name);
-- 
gitgitgadget

