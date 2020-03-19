Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B84C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D91920836
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij+KlQTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgCSR2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:28:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42617 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgCSR2L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 13:28:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id b21so3713421edy.9
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tx9Ni1mNjuNBCfXrmJSv/+Bgn529ShiwQ+zCvTNE/FQ=;
        b=ij+KlQTqpthuGPAPvIolc8HFg5eUydfZW4B3z5fZsOYP0CYOutBR3YeUNrGAY+CE2B
         /2/XnejmK6yLMUSbz7R3G/sgSEVmL/YbZRksF4NE0hQTx3IA4jQO5PwaHDRxeNVI0G73
         IGZIDcPBREt0L7CbsRjm3UwsLWmaxNKUkBRjn0xnda867c24x46WNc/5aDyz2S1BwIiq
         XCuYsKWFU5uL/OXytJ8q36VcrV1tGiNG08d4VCHgGcO8bViOsw2n1m+iwPXt6050dzYc
         yG7anHMZgaZY4Rc5FffHo9oR0XC8zMdlfWu0iweWD9wGytrpvASwDm9ob7gJ7ubxx846
         eILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tx9Ni1mNjuNBCfXrmJSv/+Bgn529ShiwQ+zCvTNE/FQ=;
        b=l721jgasBQCYALWfxWMm9kGpaYAB1oZbVOpODWAp8jmpVu7475jBPVdWgBgKkvFBBs
         u4XfZdkIFfiAVncW3pZ3U22VXJqKMIvqG4G+3ncy0O5MzdF1ZgFmD/dHHCkfwB3wpLIV
         BgdfFVOkSnBW6/0DnjpZmrpicEvGUrMfaUpC7MgDy2WGJ2ik7y3TdJwXC/o/efDQUDtf
         0jQCHr+sa+a5JlUP/uKSJSWEhxt/sZOWzlSa815jxPzKVeANHMBheVwJX1RxAqft+iKJ
         7Xqk4FUAtBOwoFR9fJVU3sOgHuYlIF+PSkVkMDAZUHQ4ONMZpP9YhlPm0H5mvl89x3jf
         dkKQ==
X-Gm-Message-State: ANhLgQ1E0S15qupZ5WEbMLHRAbHwWf5p7fbN1Mf3xv0GZPPtlvF+SjfP
        5WddFmtb4/KUR4VePJRGXIWOrDGC
X-Google-Smtp-Source: ADFU+vuQkugabURWgXz5IA/5cjGJsOjSXuEg2DqzkKGkZoWduBSfFbDE0AvCWt908IbKj6PwRcixwQ==
X-Received: by 2002:a17:906:4f8f:: with SMTP id o15mr4158318eju.175.1584638889115;
        Thu, 19 Mar 2020 10:28:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1sm184089eju.10.2020.03.19.10.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:28:08 -0700 (PDT)
Message-Id: <6f340d9aadf71d394ad320ad162f1d140b632f2c.1584638887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.586.git.1584638887.gitgitgadget@gmail.com>
References: <pull.586.git.1584638887.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Mar 2020 17:28:06 +0000
Subject: [PATCH 1/2] partial-clone: set default filter with --partial
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jonathantanmy@google.com,
        christian.couder@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Partial clone means a lot of different things, including filtering
out all blobs, large blobs, or objects along a certain pathspec.
The pathspec option has limited uses, in particular due to the
performance challenges in serving with such filters. The blob size
option can be helpful for repositories with a small number of large
binaries, but otherwise it is difficult to find a meaningful split
between "small" and "large" blobs.

When I think of or recommend partial clone, I specifically mention
the case of filtering out all blobs, and downloading those blobs
only as needed.

This case is extremely useful, since it takes the best part of
shallow clone (a very small initial download) without any of the
downsides of restricted history.

However, the command-line interface can be confusing:

	git clone --filter=blob:none <url>

Add a simpler "--partial" option that defaults to this case:

	git clone --partial <url>

This should make the feature more discoverable. However, there is
a significant interest in the size-limited filters as that behaves
very similarly to Git LFS. For those cases, the following is
available:

	git clone --partial=<size> <url>

There are quite a few commands using OPT_PARSE_LIST_OBJECTS_FILTER,
includeing clone, fetch, and pack-objects. Augment this macro to
include the "--partial[=<size>]" mode for free.

Modify the first partial clone test that checks --filter=blob:none
to also check --partial with the same expected conditions after
clone. The diff is much simpler to see when ignoring whitespace,
since several lines added a leading tab. This test is essentially
copied to include the two ways to specify a blob size limit of
one byte.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 list-objects-filter-options.c | 18 +++++++++++++++
 list-objects-filter-options.h |  8 ++++++-
 t/t5616-partial-clone.sh      | 42 ++++++++++++++++++++++++++---------
 3 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 256bcfbdfe6..a71716ef75e 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -270,6 +270,24 @@ int opt_parse_list_objects_filter(const struct option *opt,
 	return 0;
 }
 
+int opt_set_blob_none_filter(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct strbuf filter_arg = STRBUF_INIT;
+	struct list_objects_filter_options *filter_options = opt->value;
+	
+	if (unset || !arg || !strcmp(arg, "0")) {
+		parse_list_objects_filter(filter_options, "blob:none");
+		return 0;
+	}
+	
+	strbuf_addf(&filter_arg, "blob:limit=%s", arg);
+	parse_list_objects_filter(filter_options, filter_arg.buf);
+	strbuf_release(&filter_arg);
+
+	return 0;
+}
+
 const char *list_objects_filter_spec(struct list_objects_filter_options *filter)
 {
 	if (!filter->filter_spec.nr)
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 2ffb39222c4..ac38ffcbe86 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -62,6 +62,7 @@ struct list_objects_filter_options {
 
 /* Normalized command line arguments */
 #define CL_ARG__FILTER "filter"
+#define CL_ARG__PARTIAL "partial"
 
 void list_objects_filter_die_if_populated(
 	struct list_objects_filter_options *filter_options);
@@ -80,11 +81,16 @@ void parse_list_objects_filter(
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset);
+int opt_set_blob_none_filter(const struct option *opt,
+			     const char *arg, int unset);
 
 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
 	{ OPTION_CALLBACK, 0, CL_ARG__FILTER, fo, N_("args"), \
 	  N_("object filtering"), 0, \
-	  opt_parse_list_objects_filter }
+	  opt_parse_list_objects_filter }, \
+	{ OPTION_CALLBACK, 0, CL_ARG__PARTIAL, fo, N_("size"), \
+	  N_("partial clone with blob filter"), \
+	  PARSE_OPT_OPTARG | PARSE_OPT_NONEG , opt_set_blob_none_filter }
 
 /*
  * Translates abbreviated numbers in the filter's filter_spec into their
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 77bb91e9769..c42cef61296 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -33,17 +33,39 @@ test_expect_success 'setup bare clone for server' '
 # confirm we are missing all of the known blobs.
 # confirm partial clone was registered in the local config.
 test_expect_success 'do partial clone 1' '
-	git clone --no-checkout --filter=blob:none "file://$(pwd)/srv.bare" pc1 &&
-
-	git -C pc1 rev-list --quiet --objects --missing=print HEAD >revs &&
-	awk -f print_1.awk revs |
-	sed "s/?//" |
-	sort >observed.oids &&
+	for option in "--filter=blob:none" "--partial"
+	do
+		rm -rf pc1 &&
+		git clone --no-checkout "$option" "file://$(pwd)/srv.bare" pc1 &&
+
+		git -C pc1 rev-list --quiet --objects --missing=print HEAD >revs &&
+		awk -f print_1.awk revs |
+		sed "s/?//" |
+		sort >observed.oids &&
+
+		test_cmp expect_1.oids observed.oids &&
+		test "$(git -C pc1 config --local core.repositoryformatversion)" = "1" &&
+		test "$(git -C pc1 config --local remote.origin.promisor)" = "true" &&
+		test "$(git -C pc1 config --local remote.origin.partialclonefilter)" = "blob:none"
+	done
+'
 
-	test_cmp expect_1.oids observed.oids &&
-	test "$(git -C pc1 config --local core.repositoryformatversion)" = "1" &&
-	test "$(git -C pc1 config --local remote.origin.promisor)" = "true" &&
-	test "$(git -C pc1 config --local remote.origin.partialclonefilter)" = "blob:none"
+test_expect_success 'do partial clone with size limit' '
+	for option in "--filter=blob:limit=1" "--partial=1"
+	do
+		rm -rf pc-limit &&
+		git clone --no-checkout "$option" "file://$(pwd)/srv.bare" pc-limit &&
+
+		git -C pc-limit rev-list --quiet --objects --missing=print HEAD >revs &&
+		awk -f print_1.awk revs |
+		sed "s/?//" |
+		sort >observed.oids &&
+
+		test_cmp expect_1.oids observed.oids &&
+		test "$(git -C pc-limit config --local core.repositoryformatversion)" = "1" &&
+		test "$(git -C pc-limit config --local remote.origin.promisor)" = "true" &&
+		test "$(git -C pc-limit config --local remote.origin.partialclonefilter)" = "blob:limit=1"
+	done
 '
 
 test_expect_success 'verify that .promisor file contains refs fetched' '
-- 
gitgitgadget

