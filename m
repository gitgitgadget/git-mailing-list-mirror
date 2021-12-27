Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851DAC433FE
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 18:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhL0S0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 13:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhL0S0n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 13:26:43 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A564AC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 10:26:42 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a9so33717465wrr.8
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 10:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ELLDxBX/lyG6RnmRtNNI8q8SuQwrat60hwrM2NNTSR8=;
        b=iyWAfphnhJ1edMXpzSgn/WOqKCW+sl7XI/Hp51HJ79FqtkB/srxiIHh0TZSF1LIpGX
         R4kWBkA6flM8InGwc9C++5EEehnTdWWIJQJJXZQv8NAlKSHjdQjAuTrAjRKubgE3A92v
         05/KhzasgXTdvYYiOLysR78i0FqNNO5cQeU3dx1l8Q3ep7L7sLd2z1UceUaAtmn9Ersh
         ovD0kzTvBR3Hrp3vnA2uVrQ8spzNANE33dMYiXHI3yW+qiHfwyXxrsKHBmOxsS2XnNwV
         SEZSwL1R+Y+TrkcxZxg2VIv5K9LN8rnRIhGrURgWwxuORWNXJqFgGRF0ih91t3FlcZ1l
         q5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ELLDxBX/lyG6RnmRtNNI8q8SuQwrat60hwrM2NNTSR8=;
        b=zF77fkagYXitH3JNOUnJjMUn5US+5H/Q5l8vECMfIIQGspG8nhY4M8iEyp/BNkSdh9
         FNs22Vm9yQu5tbN04CUOxMkytsnE6Wv5DUO1Y9UcezlIEZR+fkrlsqQv/OTrZPOcTJ/h
         wUk76TawTH/EUaf9q37xH9s7gzSmhopAScfEBVfKrFifK88pUgrIr63b3R35yT/EfrSe
         zS43WQKA3uqQMcem0ga2jBzFOfW7t9he6J15qJxlI1O932FcboU/Ig7Pwa6SViqBOORT
         ZELTSS7rcuNrVWjI460PjsyxAJ05lGAzXpUxBKqPFz9/5Yu6Gx24e06HnbsV6qUx4Tc6
         u+xw==
X-Gm-Message-State: AOAM531b6jrqwfziwPGA/qFq3gzo95CqijuA2g9JwtHY+rAMVW5hGqtr
        PbOu05EiO5PBcZ86e/926NIbYp9IeGQ=
X-Google-Smtp-Source: ABdhPJw7k/A+i4JP3SuNJIsPxNINqCs8cF+DpeIgiFNOMnwnUFJy9h3z/LIB0hKAUevZupFd/z/LGw==
X-Received: by 2002:adf:eb05:: with SMTP id s5mr13043795wrn.448.1640629600975;
        Mon, 27 Dec 2021 10:26:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d11sm17226606wri.101.2021.12.27.10.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 10:26:40 -0800 (PST)
Message-Id: <384a635daa21871311ffadc81c1e9a8c56f474b1.1640629598.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1125.git.git.1640629598.gitgitgadget@gmail.com>
References: <pull.1125.git.git.1640629598.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 18:26:38 +0000
Subject: [PATCH 2/2] commit.c: rename find_commit_header to find_header
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Since find_commit_header's logic is not just limited to commit objects,
we can rename this to a more general find_header function so it's
clearer that it can be used in a more general way.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/am.c                | 2 +-
 builtin/commit.c            | 2 +-
 builtin/receive-pack.c      | 8 ++++----
 commit.c                    | 4 ++--
 commit.h                    | 2 +-
 gpg-interface.c             | 2 +-
 pretty.c                    | 2 +-
 sequencer.c                 | 2 +-
 t/helper/test-fast-rebase.c | 2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348a..1ed5071ff49 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1312,7 +1312,7 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 
 	buffer = logmsg_reencode(commit, NULL, get_commit_output_encoding());
 
-	ident_line = find_commit_header(buffer, "author", &ident_len);
+	ident_line = find_header(buffer, "author", &ident_len);
 	if (!ident_line)
 		die(_("missing author line in commit %s"),
 		      oid_to_hex(&commit->object.oid));
diff --git a/builtin/commit.c b/builtin/commit.c
index 883c16256c8..6fbb154ee32 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -614,7 +614,7 @@ static void determine_author_info(struct strbuf *author_ident)
 		size_t len;
 		const char *a;
 
-		a = find_commit_header(author_message_buffer, "author", &len);
+		a = find_header(author_message_buffer, "author", &len);
 		if (!a)
 			die(_("commit '%s' lacks author header"), author_message);
 		if (split_ident_line(&ident, a, len) < 0)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 939d4b28b7c..f0fc826b665 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -581,13 +581,13 @@ static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
 	return strbuf_detach(&buf, NULL);
 }
 
-static char *find_header_value(const char *msg, const char *key, const char **next_line)
+static char *find_header_nextline(const char *msg, const char *key, const char **next_line)
 {
 	size_t out_len;
 	const char *eol;
 	char *ret;
 
-	const char *val = find_commit_header(msg, key, &out_len);
+	const char *val = find_header(msg, key, &out_len);
 	if (val == NULL)
 		return NULL;
 
@@ -619,7 +619,7 @@ static int constant_memequal(const char *a, const char *b, size_t n)
 
 static const char *check_nonce(const char *buf, size_t len)
 {
-	char *nonce = find_header_value(buf, "nonce", NULL);
+	char *nonce = find_header_nextline(buf, "nonce", NULL);
 
 	timestamp_t stamp, ostamp;
 	char *bohmac, *expect = NULL;
@@ -725,7 +725,7 @@ static int check_cert_push_options(const struct string_list *push_options)
 	if (!len)
 		return 1;
 
-	while ((option = find_header_value(buf, "push-option", &next_line))) {
+	while ((option = find_header_nextline(buf, "push-option", &next_line))) {
 		buf = next_line;
 		options_seen++;
 		if (options_seen > push_options->nr
diff --git a/commit.c b/commit.c
index 616a6780703..bdedbe295f5 100644
--- a/commit.c
+++ b/commit.c
@@ -734,7 +734,7 @@ void record_author_date(struct author_date_slab *author_date,
 	char *date_end;
 	timestamp_t date;
 
-	ident_line = find_commit_header(buffer, "author", &ident_len);
+	ident_line = find_header(buffer, "author", &ident_len);
 	if (!ident_line)
 		goto fail_exit; /* no author line */
 	if (split_ident_line(&ident, ident_line, ident_len) ||
@@ -1631,7 +1631,7 @@ struct commit_list **commit_list_append(struct commit *commit,
 	return &new_commit->next;
 }
 
-const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
+const char *find_header(const char *msg, const char *key, size_t *out_len)
 {
 	int key_len = strlen(key);
 	const char *line = msg;
diff --git a/commit.h b/commit.h
index 3ea32766bcb..18a1460c4b4 100644
--- a/commit.h
+++ b/commit.h
@@ -296,7 +296,7 @@ void free_commit_extra_headers(struct commit_extra_header *extra);
  * Note that some headers (like mergetag) may be multi-line. It is the caller's
  * responsibility to parse further in this case!
  */
-const char *find_commit_header(const char *msg, const char *key,
+const char *find_header(const char *msg, const char *key,
 			       size_t *out_len);
 
 /* Find the end of the log message, the right place for a new trailer. */
diff --git a/gpg-interface.c b/gpg-interface.c
index b52eb0e2e04..c1bc9fa0459 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -597,7 +597,7 @@ static int parse_payload_metadata(struct signature_check *sigc)
 		BUG("invalid value for sigc->payload_type");
 	}
 
-	ident_line = find_commit_header(sigc->payload, signer_header, &ident_len);
+	ident_line = find_header(sigc->payload, signer_header, &ident_len);
 	if (!ident_line || !ident_len)
 		return 1;
 
diff --git a/pretty.c b/pretty.c
index ee6114e3f0a..306c647d2d7 100644
--- a/pretty.c
+++ b/pretty.c
@@ -633,7 +633,7 @@ static void add_merge_info(const struct pretty_print_context *pp,
 static char *get_header(const char *msg, const char *key)
 {
 	size_t len;
-	const char *v = find_commit_header(msg, key, &len);
+	const char *v = find_header(msg, key, &len);
 	return v ? xmemdupz(v, len) : NULL;
 }
 
diff --git a/sequencer.c b/sequencer.c
index e314af4d60a..ac535868121 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -912,7 +912,7 @@ static char *get_author(const char *message)
 	size_t len;
 	const char *a;
 
-	a = find_commit_header(message, "author", &len);
+	a = find_header(message, "author", &len);
 	if (a)
 		return xmemdupz(a, len);
 
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index fc2d4609043..576c2366258 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -44,7 +44,7 @@ static char *get_author(const char *message)
 	size_t len;
 	const char *a;
 
-	a = find_commit_header(message, "author", &len);
+	a = find_header(message, "author", &len);
 	if (a)
 		return xmemdupz(a, len);
 
-- 
gitgitgadget
