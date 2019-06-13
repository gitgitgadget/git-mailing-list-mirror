Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3B621F462
	for <e@80x24.org>; Thu, 13 Jun 2019 21:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfFMVvw (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 17:51:52 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:46618 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfFMVvw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 17:51:52 -0400
Received: by mail-ot1-f73.google.com with SMTP id z52so206380otb.13
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nAw5/0IWm4dwK2tnwdzw5QImnqiDooKw1qyEzx28ZsE=;
        b=udhRuDjgcM11gF2VDfxZsTx3tjQk4pdOFvRAZO/Emt8+aLNERnmjbR0zt3c/rfXJOd
         XwKs6Zm0XqqG7NKvv3UwW5xdE7NFnz/SjTgUpQdfzmUK7JQbTZaDJmC52gFdrFCJAtE/
         thQv9vCr2L2SVNm+nqkTj9P16+lKHGJKFDFykoa/q5Ts/p3JxugHwcq5Zw3UgVrTbskf
         Qp/dD7AaCPqo59YQbKvYXLc3RHqYsl2ZcxiNXID14oHHOcTJPHXGiBrgVszdIdyyY5R9
         3nzFOkT0Kv+sxdSC91LiZSf344VQhACOMUgmt/WyM8pgqYA73ODFPkJn0hclda7mFxTf
         x7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nAw5/0IWm4dwK2tnwdzw5QImnqiDooKw1qyEzx28ZsE=;
        b=BaU36V4w/vlTxN8HFg3z7tLS1/uLFZJy+p2DJxmmriBEP3Nw6L6k/cFXr93sG7H8KS
         zeL2lw/FlrHnwSUTCSIo3VJAMUeDbjMbqW9V7XmkFEh/9ebxFZpL2N1RBIbI0icLP7oL
         ZnR/AHuKCHEl/IgN9PelBFdp+poyXW026DyzJFCyHXlEV1xbQfLgCAeuIj23NMIY6Qe2
         9xS5yzsr8YJRgnDGabBBu5kp8A1bLxBnTV8rcL9SUyTia9VQ6w21/5SqyrZoOdkbkYFk
         47FTFiPtbI+60Pvy1UvwynzND7vawPmeERwFyRv/7Xd+lB2I5BruEzFa+quFiay0SPnD
         tuXQ==
X-Gm-Message-State: APjAAAUsOPuzF7wRIBhTuntW42dLPvq7fiZWzV22vHY/s2Gd1yPF6OaK
        7/Kir8i8vuSaEQWxpR0wQBPJMZ9fMtT/vepfCI3mMl2s0uXL2h1gFvvbQs+fHQ70B8A9jyuNsxF
        +QXtwyG6s8YMl0pjbMnjnv4evOVO08hNXIARNvw6lrmJKO7g77hxCOpsZjjk=
X-Google-Smtp-Source: APXvYqwLosIwMnWKGnKsxe8s1gJF2uJcyBdwCB/qZ4yhyIzaaV09UKdyge1tZoVyoVpHRBJyd0D0hE4TMk5Y
X-Received: by 2002:a9d:661:: with SMTP id 88mr43319844otn.214.1560462711664;
 Thu, 13 Jun 2019 14:51:51 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:51:28 -0700
In-Reply-To: <cover.1560462201.git.matvore@google.com>
Message-Id: <737cd0dd5b8a60389f862180f8c1d5ee107fe172.1560462201.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1560462201.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v3 05/10] list-objects-filter-options: move error check up
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the check that filter_options->choice is set to higher in the call
stack. This can only be set when the gentle parse function is called
from one of the two call sites.

This is important because in an upcoming patch this may or may not be an
error, and whether it is an error is only known to the
parse_list_objects_filter function.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index ffbadf337b..5ff5135a91 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -28,25 +28,22 @@ static int parse_combine_filter(
  * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
  * convenience of the current command.
  */
 static int gently_parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf)
 {
 	const char *v0;
 
-	if (filter_options->choice) {
-		strbuf_addstr(
-			errbuf, _("multiple filter-specs cannot be combined"));
-		return 1;
-	}
+	if (filter_options->choice)
+		BUG("filter_options already populated");
 
 	if (!strcmp(arg, "blob:none")) {
 		filter_options->choice = LOFC_BLOB_NONE;
 		return 0;
 
 	} else if (skip_prefix(arg, "blob:limit=", &v0)) {
 		if (git_parse_ulong(v0, &filter_options->blob_limit_value)) {
 			filter_options->choice = LOFC_BLOB_LIMIT;
 			return 0;
 		}
@@ -175,20 +172,22 @@ static int parse_combine_filter(
 		list_objects_filter_release(filter_options);
 		memset(filter_options, 0, sizeof(*filter_options));
 	}
 	return result;
 }
 
 int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
 			      const char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
+	if (filter_options->choice)
+		die(_("multiple filter-specs cannot be combined"));
 	filter_options->filter_spec = strdup(arg);
 	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
 		die("%s", buf.buf);
 	return 0;
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options = opt->value;
-- 
2.21.0

