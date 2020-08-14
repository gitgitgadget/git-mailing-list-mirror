Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A48C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 19:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BEEC20771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 19:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lCI1yj9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgHNTck (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgHNTcj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 15:32:39 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7976C061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 12:32:39 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id z16so6430192pgh.21
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 12:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Kfc/vWbpVXhGY6mUz9dU3fLxpi01XFofO35WRF8Q2dU=;
        b=lCI1yj9bdooG4tJ9mC+7qWBZM1dgancyydfnaKLzR+Q0bwWTSczyRnkVQvFGFS3dAZ
         wDcUbprKMUSEuB5uEbtM/kQ7YoC97lhIwwFGp7A0DxGntKdKzqpGMXJm6HVIt14GYiB4
         4edZBEohgajlakWe28mG0D9Myfc8J6s8plP5bxBWbVTUzA++c0LNvDi/0GhSHdMIFINF
         j5Y+RDfUseYwjKh01PlxpjxMPvk09wSYr+fkEIIt2jittSKPOcHv08Qg5qYsJevoWMTb
         4b7lBLSn5bhzOnrv3WVaTQJSVk6nDD7jknvxxSCP7wE0Bd6MFQ85PnDHvzu360wvPgnt
         Kepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Kfc/vWbpVXhGY6mUz9dU3fLxpi01XFofO35WRF8Q2dU=;
        b=BiKsZnuMkOTm7evSX9LydhTt74UnfNpzADpLCTt0O/jFTM6KNoad/K2bIZWDNRQ129
         P/1yU1CGgkXhxX1iWKBKPFSwIHWrghezrvdGUzHIgT4nWAQBSmHQRzUaO6x0qwHxpAx+
         zK+hHQkXfUraQJNfGn4GLbp6xa8p4pordxF97nOw1zx34DDLJ26YkjLuAobqkY6u+zn3
         pzyNndiFAiQQUiXAoqcvRKBM+F9iuayh57vLk+s/QEShKz3Sk+m/IcDa9bYHuYVDc6H3
         fYZds7PhmWoM8A3vbxKLw1lkC5jbXhz/MxQ5e2R3OEzsbePNtNtlcnZTY0bpdCN9YzOh
         lcJA==
X-Gm-Message-State: AOAM532fhDG7xU3Z2OObhOLMpYOFfUw1qjyJ4DeCptbi2JMgEf7fmRZ9
        brCky2KbogZ/yPu0EsNO/BBLZW6jQ6B/vigTM/jmo6CM5eZ33Ppo0RaWuH/bzn6uSKGiitCJ9SR
        uFncjVrcoe4dw9FcethTEZSVfdGOiF8etXLzCVn43aRIl7Yj4f4xYwfhnW8D67R7MsFBkIvzVT3
        Su
X-Google-Smtp-Source: ABdhPJzu3i1YLOYkc++iZuJd69hhEkWgZdOgPtgxJHsiX0oWYiT+4pSFyt03/L+Ion7Js2yeLHsxWmFRpnSKPJVINYeH
X-Received: by 2002:a17:90a:aa8e:: with SMTP id l14mr3680920pjq.67.1597433558919;
 Fri, 14 Aug 2020 12:32:38 -0700 (PDT)
Date:   Fri, 14 Aug 2020 12:32:34 -0700
Message-Id: <20200814193234.3072139-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH] fetch-pack: make packfile URIs work with transfer.fsckobjects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching with packfile URIs and transfer.fsckobjects=1, use the
--fsck-objects instead of the --strict flag when invoking index-pack so
that links are not checked, only objects. This is because incomplete
links are expected. (A subsequent connectivity check will be done when
all the packs have been downloaded regardless of whether
transfer.fsckobjects is set.)

This is similar to 98a2ea46c2 ("fetch-pack: do not check links for
partial fetch", 2018-03-15), but for packfile URIs instead of partial
clones.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
The subject is longer than 50 characters but I couldn't find a way to
shorten it, especially since I think it's important to mention packfile
URIs and transfer.fsckobjects. Any suggestions appreciated.
---
 fetch-pack.c           |  2 +-
 t/t5702-protocol-v2.sh | 53 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 7f20eca4f8..66631d0034 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -892,7 +892,7 @@ static int get_pack(struct fetch_pack_args *args,
 	    : transfer_fsck_objects >= 0
 	    ? transfer_fsck_objects
 	    : 0) {
-		if (args->from_promisor)
+		if (args->from_promisor || !only_packfile)
 			/*
 			 * We cannot use --strict in index-pack because it
 			 * checks both broken objects and links, but we only
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5a60fbe3ed..8c6c67b10d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -883,6 +883,59 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	test_i18ngrep "pack downloaded from.*does not match expected hash" err
 '
 
+test_expect_success 'packfile-uri with transfer.fsckobjects' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" my-blob >h &&
+
+	sane_unset GIT_TEST_SIDEBAND_ALL &&
+	git -c protocol.version=2 -c transfer.fsckobjects=1 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	# Ensure that there are exactly 4 files (2 .pack and 2 .idx).
+	ls http_child/.git/objects/pack/* >filelist &&
+	test_line_count = 4 filelist
+'
+
+test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	cat >bogus-commit <<EOF &&
+tree $EMPTY_TREE
+author Bugs Bunny 1234567890 +0000
+committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
+
+This commit object intentionally broken
+EOF
+	BOGUS=$(git -C "$P" hash-object -t commit -w --stdin <bogus-commit) &&
+	git -C "$P" branch bogus-branch "$BOGUS" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" my-blob >h &&
+
+	sane_unset GIT_TEST_SIDEBAND_ALL &&
+	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child 2>error &&
+	test_i18ngrep "invalid author/committer line - missing email" error
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-- 
2.28.0.220.ged08abb693-goog

