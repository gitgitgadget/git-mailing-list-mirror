Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD650CE7AB7
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 19:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjIVTvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjIVTvA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 15:51:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49C119B
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4054f790190so4682635e9.2
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695412250; x=1696017050; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRKoNjL6jWlrxhawWelEmzgUZflZ7tZTbZMWzcAmXJQ=;
        b=l2cUOdOu4lSH7FzjmfnjacGmyDSvRoWuYKsJAHCvBW7dk/F48gqTOL60mvOK+1CY8h
         due+7LmuM++jTAN70THJJv007QPEuJZ7x8uxGt9RqjCSpqCWM+bJNBMUjezfVEoEcHPU
         fojpAFXkh9i/VDEAT9xPpeSFlE+WLqYKk2T1QqTlkOnXOpi8PuDgLQY3Or4aqi/Qhvsi
         0W2Zf2raR3ZyCe1vyOY01rNbEuwpYwSIZXko6CxBqUrgJT/xoTl1Cn9n0iTG4QrDwf1V
         VtQpHdW3QHJLRaUQzm2hqrx7d5jwy6DLo0ie+UkEEKIjzZ0GLanp89cuEOukVz6Olkx5
         A1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695412250; x=1696017050;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRKoNjL6jWlrxhawWelEmzgUZflZ7tZTbZMWzcAmXJQ=;
        b=KFx5w77KleBmB2zlW5R1Vr99uTd6Vb80mcCsgFM2FWMZAGR9WRtIyvm1jLzuVzqwJZ
         Ks+XAVTvB8jch3mzcT3tcAfqmowkQgIdQHuZ7rGzAZpKh3y42YLbj5EDzzFvXwT4mYGK
         TKpbFTv68FGIOx+74VU3NdSwuuzDgskqB7ntm7nh+IQ3ASbd6Xow7Nij/x3ZndLs4uxS
         lPmAfg6uppooA2EjzbjCZysHT4i7ltlbsHeuNciie7dKfj/KLZyIyqrNMvfqWHCr/Iuq
         Z9zgQgJXgzevVoCmZzLOyygkG6CA4WXCBSgRX+/t5NGo7iRoKD/EZqENdQy6V1/QpRL2
         Hc4A==
X-Gm-Message-State: AOJu0Yx0DOxjnw6Pb494QJeEi5g4BeU7PekR6c91O97Pj/RnfGTZTDit
        wY6gXjTDQrNV0hIZGk9e9Pif3lTnLkw=
X-Google-Smtp-Source: AGHT+IGDKmmq2m1cEqm6ZAHRffpqlmbNhKqOHnyF+DWiNmEdmL//B/xFRzBKShl5QF/TSNHYUCHWIw==
X-Received: by 2002:a5d:49c1:0:b0:31f:fa1d:898 with SMTP id t1-20020a5d49c1000000b0031ffa1d0898mr499954wrs.47.1695412249971;
        Fri, 22 Sep 2023 12:50:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a056000100800b003197efd1e7bsm5141739wrx.114.2023.09.22.12.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:50:49 -0700 (PDT)
Message-ID: <da52cec42e1a64221a7daa958f841ab5e5bd304e.1695412245.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
References: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 19:50:41 +0000
Subject: [PATCH v3 5/9] commit: ignore_non_trailer computes number of bytes to
 ignore
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

ignore_non_trailer() returns the _number of bytes_ that should be
ignored from the end of the log message. It does not by itself "ignore"
anything.

Rename this function to remove the leading "ignore" verb, to sound more
like a quantity than an action.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/commit.c | 2 +-
 builtin/merge.c  | 2 +-
 commit.c         | 2 +-
 commit.h         | 4 ++--
 trailer.c        | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7da5f924484..d1785d32db1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -900,7 +900,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		strbuf_stripspace(&sb, '\0');
 
 	if (signoff)
-		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
+		append_signoff(&sb, ignored_log_message_bytes(sb.buf, sb.len), 0);
 
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
 		die_errno(_("could not write commit template"));
diff --git a/builtin/merge.c b/builtin/merge.c
index de68910177f..6cbbebca13d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -891,7 +891,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 				_(no_scissors_editor_comment), comment_line_char);
 	}
 	if (signoff)
-		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
+		append_signoff(&msg, ignored_log_message_bytes(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
 	if (run_commit_hook(0 < option_edit, get_index_file(), NULL,
diff --git a/commit.c b/commit.c
index b3223478bc2..4440fbabb83 100644
--- a/commit.c
+++ b/commit.c
@@ -1769,7 +1769,7 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
  * Returns the number of bytes from the tail to ignore, to be fed as
  * the second parameter to append_signoff().
  */
-size_t ignore_non_trailer(const char *buf, size_t len)
+size_t ignored_log_message_bytes(const char *buf, size_t len)
 {
 	size_t boc = 0;
 	size_t bol = 0;
diff --git a/commit.h b/commit.h
index 28928833c54..1cc872f225f 100644
--- a/commit.h
+++ b/commit.h
@@ -294,8 +294,8 @@ const char *find_header_mem(const char *msg, size_t len,
 const char *find_commit_header(const char *msg, const char *key,
 			       size_t *out_len);
 
-/* Find the end of the log message, the right place for a new trailer. */
-size_t ignore_non_trailer(const char *buf, size_t len);
+/* Find the number of bytes to ignore from the end of a log message. */
+size_t ignored_log_message_bytes(const char *buf, size_t len);
 
 typedef int (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
 				void *cb_data);
diff --git a/trailer.c b/trailer.c
index 0b66effceb5..185b3e2707f 100644
--- a/trailer.c
+++ b/trailer.c
@@ -931,7 +931,7 @@ continue_outer_loop:
 /* Return the position of the end of the trailers. */
 static size_t find_trailer_end(const char *buf, size_t len)
 {
-	return len - ignore_non_trailer(buf, len);
+	return len - ignored_log_message_bytes(buf, len);
 }
 
 static int ends_with_blank_line(const char *buf, size_t len)
-- 
gitgitgadget

