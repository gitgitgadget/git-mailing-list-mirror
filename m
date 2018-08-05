Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ACAA1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 17:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeHET0H (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:26:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44989 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeHET0H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:26:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so10108710wrt.11
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/q6NVgSXPa1LkbHeoZzj8mhqygvwkPh8MkweH2YM6ec=;
        b=HpEblrRB0q/Oh7OscODvO1eZi1Mwz/tGglRgADlVSgdaIvDdkknMWPe5+gefTcCcIj
         B2IBjbZyYT2V+SUbnnoN96YZOFHTIrn8o1RDs7zsf8RKbqazL9Jbg1AhbPTfBkLlphSK
         UzgfSWG50vBrZSWGSH6B/cGhIujWFQ2o/ROl1ttppdMRJoQNC25nRY7ou8I8xL7hHkMX
         3B91tfnSvmL+3kzxumweJxelxK+PubyO5Qju/xx/A8fXqznBWW6CUdw0Y3sWlIxktGlU
         DyWBnL2B9l6CVjnPCl9AQWTnQwa3DT+vVG9A4k0oSywgCkfeCx9niVTRHf3uQdISPFD/
         J10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/q6NVgSXPa1LkbHeoZzj8mhqygvwkPh8MkweH2YM6ec=;
        b=V49DmKTHHx+fgMKlS7d7NcUAo/F62Fs0xOB8W0DAk3uxC25mxqMSQXDC+Pn+mbND5C
         7a3B9OxLUcLofQHW2c8IVrWe49AYvtiZhkitp4cwDPRTB+/gfFV+LZNsj8caojoi8WXK
         fGoXBH/+CvorVuJgW4XBGmWiuWuMqsQZj0woEa5Ml5vz/R24AN7aCHfn+xM5aKzM6Zi1
         y9XXm2qdxqWVDSGt0RjIQBVyV7KeOpPzQucVuETqe13C/lNdWd6pgAAgWjk8m2FidHiv
         I0Y+t9MeR62tqQ+Z/CeZVm00Yt/9TZTRNzSPDA3ieOQ8wlHxhwdpa3zCw/eZMblZc082
         EPUQ==
X-Gm-Message-State: AOUpUlGuiXiTjW+twWG4uIMnhnljdxU1cVY2QKi5vlNGPNyYrF8lBwSw
        Eoxu4rdKctG8eX1lUZs7SunyzF8f
X-Google-Smtp-Source: AAOMgpeyPTwbPLJXSBpZG0bjFzg3/UNUgayxROtvlyyFw7UXYzOOufkont3ckfcuVE090i1B9pJxWA==
X-Received: by 2002:adf:9142:: with SMTP id j60-v6mr7173452wrj.180.1533489649692;
        Sun, 05 Aug 2018 10:20:49 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id z3-v6sm3713615wmf.12.2018.08.05.10.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 10:20:48 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 03/11] rerere: wrap paths in output in sq
Date:   Sun,  5 Aug 2018 18:20:29 +0100
Message-Id: <20180805172037.12530-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.18.0.720.gf7a957e2e7
In-Reply-To: <20180805172037.12530-1-t.gummerer@gmail.com>
References: <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180805172037.12530-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like most paths in the output in the git codebase are wrapped
in single quotes.  Standardize on that in rerere as well.

Apart from being more consistent, this also makes some of the strings
match strings that are already translated in other parts of the
codebase, thus reducing the work for translators, when the strings are
marked for translation in a subsequent commit.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/rerere.c |  2 +-
 rerere.c         | 26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 0bc40298c2..e0c67c98e9 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -107,7 +107,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 			const char *path = merge_rr.items[i].string;
 			const struct rerere_id *id = merge_rr.items[i].util;
 			if (diff_two(rerere_path(id, "preimage"), path, path, path))
-				die("unable to generate diff for %s", rerere_path(id, NULL));
+				die("unable to generate diff for '%s'", rerere_path(id, NULL));
 		}
 	} else
 		usage_with_options(rerere_usage, options);
diff --git a/rerere.c b/rerere.c
index c5d9ea171f..cde1f6e696 100644
--- a/rerere.c
+++ b/rerere.c
@@ -484,12 +484,12 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 	io.input = fopen(path, "r");
 	io.io.wrerror = 0;
 	if (!io.input)
-		return error_errno("could not open %s", path);
+		return error_errno("could not open '%s'", path);
 
 	if (output) {
 		io.io.output = fopen(output, "w");
 		if (!io.io.output) {
-			error_errno("could not write %s", output);
+			error_errno("could not write '%s'", output);
 			fclose(io.input);
 			return -1;
 		}
@@ -499,15 +499,15 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 
 	fclose(io.input);
 	if (io.io.wrerror)
-		error("there were errors while writing %s (%s)",
+		error("there were errors while writing '%s' (%s)",
 		      path, strerror(io.io.wrerror));
 	if (io.io.output && fclose(io.io.output))
-		io.io.wrerror = error_errno("failed to flush %s", path);
+		io.io.wrerror = error_errno("failed to flush '%s'", path);
 
 	if (hunk_no < 0) {
 		if (output)
 			unlink_or_warn(output);
-		return error("could not parse conflict hunks in %s", path);
+		return error("could not parse conflict hunks in '%s'", path);
 	}
 	if (io.io.wrerror)
 		return -1;
@@ -684,17 +684,17 @@ static int merge(const struct rerere_id *id, const char *path)
 	 * Mark that "postimage" was used to help gc.
 	 */
 	if (utime(rerere_path(id, "postimage"), NULL) < 0)
-		warning_errno("failed utime() on %s",
+		warning_errno("failed utime() on '%s'",
 			      rerere_path(id, "postimage"));
 
 	/* Update "path" with the resolution */
 	f = fopen(path, "w");
 	if (!f)
-		return error_errno("could not open %s", path);
+		return error_errno("could not open '%s'", path);
 	if (fwrite(result.ptr, result.size, 1, f) != 1)
-		error_errno("could not write %s", path);
+		error_errno("could not write '%s'", path);
 	if (fclose(f))
-		return error_errno("writing %s failed", path);
+		return error_errno("writing '%s' failed", path);
 
 out:
 	free(cur.ptr);
@@ -878,7 +878,7 @@ static int is_rerere_enabled(void)
 		return rr_cache_exists;
 
 	if (!rr_cache_exists && mkdir_in_gitdir(git_path_rr_cache()))
-		die("could not create directory %s", git_path_rr_cache());
+		die("could not create directory '%s'", git_path_rr_cache());
 	return 1;
 }
 
@@ -1067,9 +1067,9 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	filename = rerere_path(id, "postimage");
 	if (unlink(filename)) {
 		if (errno == ENOENT)
-			error("no remembered resolution for %s", path);
+			error("no remembered resolution for '%s'", path);
 		else
-			error_errno("cannot unlink %s", filename);
+			error_errno("cannot unlink '%s'", filename);
 		goto fail_exit;
 	}
 
@@ -1088,7 +1088,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	item = string_list_insert(rr, path);
 	free_rerere_id(item);
 	item->util = id;
-	fprintf(stderr, "Forgot resolution for %s\n", path);
+	fprintf(stderr, "Forgot resolution for '%s'\n", path);
 	return 0;
 
 fail_exit:
-- 
2.18.0.720.gf7a957e2e7

