Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE6E31F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeFEUsE (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:48:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40398 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbeFEUsB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:48:01 -0400
Received: by mail-wr0-f195.google.com with SMTP id l41-v6so3849035wre.7
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BfrrDtpptUTBtyotj+SQGhhD4e7XiSTukVqyXDXwVx0=;
        b=tuXyLNGELCdBH4I7SQozMvemCN3YQB8wRkImnGEqmMx2QlKva18e7G3q4OZZH1H0L1
         +Fo0dKb71ykwrzP/CUzU0H3lRhE0YfKOgNnAkfKIkKE+XCmw6oqRxBUAtLBGvB0dgS2f
         umAgP/uYYyqHc/IZJ++zfZhH1UuC9cl4crNh1+vCusSoJNNArYz9ckEDn1tBvRQFKMRW
         R0/rHY32/bFGWeFFz63+rGrC/U5WzEuq+0A8FwWSrKaxbWDCIalytdNAAwYvYJdHMWJj
         992U8liZeSQrmqAUw6VJDJoM0yu/l3heHpxckBPM5lzsBJV2xZQFI8rtz11Doq8EKDVk
         HWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BfrrDtpptUTBtyotj+SQGhhD4e7XiSTukVqyXDXwVx0=;
        b=rJXe0hWM12BJQtFunj8CxMZepioCauSrh3+zovllG8lCbCfJExr45nfqFDnOatfdOB
         9IDdBayjFBil3OSBi+pyQtV2c6GVz1EjRmksM5cGNKoRIQs5c7uvUCKCfZ2tQd7q1W0g
         eEqEJXDp8T3+SF76ln1F+SZ4CPPAquGR8gGOSekpCZ44I/SoGSwnvZsYYgvn06xCR9+4
         W6cmuUvFeWvSgstrp8imJEzkdkEquf7NPS1sQcv0vkPQOBabKKzeP4J7EDKamGMbyJ/U
         B+X8zTiD8kxqCPkRZXjil5qrF1OOwXlvno1AqsJWNG7q92Ns9tCqs/uDtCvlr1m/8NJi
         9xqQ==
X-Gm-Message-State: APt69E3eFPdvtYaMmRkBcHubPlGrNTOmfUsuw4uVDIQY/o/s/h/qO9e1
        VUxXIh58oSVKIOIfLi9l8ccfBvoh
X-Google-Smtp-Source: ADUXVKKaceRP5DpXHJxWQo8wIznVFVRXdN0ZptMi/jCIq8jzseYea6zI/Xaj1VHzUE1dw2rJc44KGw==
X-Received: by 2002:a5d:4407:: with SMTP id z7-v6mr117445wrq.227.1528231679600;
        Tue, 05 Jun 2018 13:47:59 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id r5-v6sm31410632wrp.59.2018.06.05.13.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:47:58 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 03/10] rerere: wrap paths in output in sq
Date:   Tue,  5 Jun 2018 22:52:12 +0100
Message-Id: <20180605215219.28783-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180605215219.28783-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
 <20180605215219.28783-1-t.gummerer@gmail.com>
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
index eca182023f..0e5956a51c 100644
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
@@ -879,7 +879,7 @@ static int is_rerere_enabled(void)
 		return rr_cache_exists;
 
 	if (!rr_cache_exists && mkdir_in_gitdir(git_path_rr_cache()))
-		die("could not create directory %s", git_path_rr_cache());
+		die("could not create directory '%s'", git_path_rr_cache());
 	return 1;
 }
 
@@ -1068,9 +1068,9 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
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
 
@@ -1089,7 +1089,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	item = string_list_insert(rr, path);
 	free_rerere_id(item);
 	item->util = id;
-	fprintf(stderr, "Forgot resolution for %s\n", path);
+	fprintf(stderr, "Forgot resolution for '%s'\n", path);
 	return 0;
 
 fail_exit:
-- 
2.17.0.410.g65aef3a6c4

