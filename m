Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D90C433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 15:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbiECPY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 11:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiECPYx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 11:24:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D121113F9F
        for <git@vger.kernel.org>; Tue,  3 May 2022 08:20:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so1469950wme.3
        for <git@vger.kernel.org>; Tue, 03 May 2022 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IKgk90B7hi08fbHeCMhoq2lxWm08SfzKpbgz/Kkr8WA=;
        b=ZlifGdARae1siRU9ZRc0JpVOBBRm2BfmUas700yEyZ/oKI8Hfqep8X7nCfQYaEoJse
         vecUxXPI66uiCy4N6JC2c5TGBMcCqh7AfXpGylu2vgVwtCNSsWbVf9h3hq13lQXZoBuf
         SdGu/ZfR2BdWYHT+kGg3xI3pF5q7nQMWg7XIdQaFX/fyyM/p/isJe9jBmHrgDckdqzSl
         rOQb8wjdQeaibeR6wSO6SoIROP2BS30IJmqcYS4pVEzKcBnLjnAfs2q9DlD24uh6AfBW
         5dyvflJHGjuK2apfyS2311KmG+aqx8TWDfKZlusZ7uCHvbgZpIoKCjlxv3GE3xhpX5ES
         1tBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IKgk90B7hi08fbHeCMhoq2lxWm08SfzKpbgz/Kkr8WA=;
        b=GfxMbBDszIJYNIzxhKPht3Lo21+rOQlZJD6Rhj4mGw96/zsAWpm5wzzrJV6nu0o1JF
         b0pzy6sORQWgW62cZ9qBYDC+22lxmGHxX/7NHQbIEb44hBxHydjW3KLNn1H88FgyqHvD
         jz//754dMLq8awyRDC60ifrVL4W8IBwLboE2KsSt4SsbWuPaJrlFtw4jUq3KfGQZHknT
         xRhi4Ywy3fA0xForNbpNwdWFcV07LHmxqV34EIKgRP3qmPCrjNRPqdmLdsHsvKS9NokG
         f37d3o1NxoBdr4PFbJoTV7yg802h18AI210t4JUVhF3B9S5E7WVpkJeby6HEnaT0rLQP
         g3lA==
X-Gm-Message-State: AOAM530XNq6u0o170k5ihDM5b1CiDbBn+761Zh5oSAH36WnANzKeDQpP
        G4iGQZIBfOYuLmsDi13Cfk1GTcsLPJA=
X-Google-Smtp-Source: ABdhPJx6FoM1nwSAdIg/yfckH/K9DjIwjtwPrPXdnKMalnHd7RWlNR/RFed32DDoeIm6ynWQc4BF3w==
X-Received: by 2002:a05:600c:1c23:b0:394:55df:f03f with SMTP id j35-20020a05600c1c2300b0039455dff03fmr269518wms.185.1651591254743;
        Tue, 03 May 2022 08:20:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b003942a244ed1sm2207482wms.22.2022.05.03.08.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:20:54 -0700 (PDT)
Message-Id: <pull.1227.v2.git.1651591253333.gitgitgadget@gmail.com>
In-Reply-To: <pull.1227.git.1651324796892.gitgitgadget@gmail.com>
References: <pull.1227.git.1651324796892.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 May 2022 15:20:53 +0000
Subject: [PATCH v2] builtin/remote.c: teach `-v` to list filters for promisor
 remotes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

`git remote -v` (`--verbose`) lists down the names of remotes along with
their urls. It would be beneficial for users to also specify the filter
types for promisor remotes. Something like this -

	origin	remote-url (fetch) [blob:none]
	origin	remote-url (push)

Teach `git remote -v` to also specify the filters for promisor remotes.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
    builtin/remote.c: teach -v to list filters for promisor remotes
    
    Fixes #1211 [1]
    
    In this version, documentation is updated (describing the proposed
    change) and url_buf is renamed into remote_info_buf.
    
    [1] https://github.com/gitgitgadget/git/issues/1211

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1227%2FAbhra303%2Fpromisor_remote-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1227/Abhra303/promisor_remote-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1227

Range-diff vs v1:

 1:  fe3bf755e63 ! 1:  e7ced852fd5 builtin/remote.c: teach `-v` to list filters for promisor remotes
     @@ Commit message
      
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
     + ## Documentation/git-remote.txt ##
     +@@ Documentation/git-remote.txt: OPTIONS
     + -v::
     + --verbose::
     + 	Be a little more verbose and show remote url after name.
     ++  For promisor remotes it will show an extra information
     ++  (wrapped in square brackets) describing which filter
     ++  (`blob:none` etc.) that promisor remote use.
     + 	NOTE: This must be placed between `remote` and subcommand.
     + 
     + 
     +
       ## builtin/remote.c ##
     -@@ builtin/remote.c: static int get_one_entry(struct remote *remote, void *priv)
     +@@ builtin/remote.c: static int show_push_info_item(struct string_list_item *item, void *cb_data)
     + static int get_one_entry(struct remote *remote, void *priv)
     + {
     + 	struct string_list *list = priv;
     +-	struct strbuf url_buf = STRBUF_INIT;
     ++	struct strbuf remote_info_buf = STRBUF_INIT;
     + 	const char **url;
       	int i, url_nr;
       
       	if (remote->url_nr > 0) {
     +-		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
      +		struct strbuf promisor_config = STRBUF_INIT;
      +		const char *partial_clone_filter = NULL;
      +
      +		strbuf_addf(&promisor_config, "remote.%s.partialclonefilter", remote->name);
     - 		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
     ++		strbuf_addf(&remote_info_buf, "%s (fetch)", remote->url[0]);
      +		if (!git_config_get_string_tmp(promisor_config.buf, &partial_clone_filter))
     -+			strbuf_addf(&url_buf, " [%s]", partial_clone_filter);
     ++			strbuf_addf(&remote_info_buf, " [%s]", partial_clone_filter);
      +
      +		strbuf_release(&promisor_config);
       		string_list_append(list, remote->name)->util =
     - 				strbuf_detach(&url_buf, NULL);
     +-				strbuf_detach(&url_buf, NULL);
     ++				strbuf_detach(&remote_info_buf, NULL);
       	} else
     + 		string_list_append(list, remote->name)->util = NULL;
     + 	if (remote->pushurl_nr) {
     +@@ builtin/remote.c: static int get_one_entry(struct remote *remote, void *priv)
     + 	}
     + 	for (i = 0; i < url_nr; i++)
     + 	{
     +-		strbuf_addf(&url_buf, "%s (push)", url[i]);
     ++		strbuf_addf(&remote_info_buf, "%s (push)", url[i]);
     + 		string_list_append(list, remote->name)->util =
     +-				strbuf_detach(&url_buf, NULL);
     ++				strbuf_detach(&remote_info_buf, NULL);
     + 	}
     + 
     + 	return 0;
      
       ## t/t5616-partial-clone.sh ##
      @@ t/t5616-partial-clone.sh: test_expect_success 'do partial clone 1' '


 Documentation/git-remote.txt |  3 +++
 builtin/remote.c             | 18 +++++++++++++-----
 t/t5616-partial-clone.sh     | 11 +++++++++++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index cde9614e362..71a0e85990d 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -35,6 +35,9 @@ OPTIONS
 -v::
 --verbose::
 	Be a little more verbose and show remote url after name.
+  For promisor remotes it will show an extra information
+  (wrapped in square brackets) describing which filter
+  (`blob:none` etc.) that promisor remote use.
 	NOTE: This must be placed between `remote` and subcommand.
 
 
diff --git a/builtin/remote.c b/builtin/remote.c
index 5f4cde9d784..d4b69fe7789 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1185,14 +1185,22 @@ static int show_push_info_item(struct string_list_item *item, void *cb_data)
 static int get_one_entry(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
-	struct strbuf url_buf = STRBUF_INIT;
+	struct strbuf remote_info_buf = STRBUF_INIT;
 	const char **url;
 	int i, url_nr;
 
 	if (remote->url_nr > 0) {
-		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
+		struct strbuf promisor_config = STRBUF_INIT;
+		const char *partial_clone_filter = NULL;
+
+		strbuf_addf(&promisor_config, "remote.%s.partialclonefilter", remote->name);
+		strbuf_addf(&remote_info_buf, "%s (fetch)", remote->url[0]);
+		if (!git_config_get_string_tmp(promisor_config.buf, &partial_clone_filter))
+			strbuf_addf(&remote_info_buf, " [%s]", partial_clone_filter);
+
+		strbuf_release(&promisor_config);
 		string_list_append(list, remote->name)->util =
-				strbuf_detach(&url_buf, NULL);
+				strbuf_detach(&remote_info_buf, NULL);
 	} else
 		string_list_append(list, remote->name)->util = NULL;
 	if (remote->pushurl_nr) {
@@ -1204,9 +1212,9 @@ static int get_one_entry(struct remote *remote, void *priv)
 	}
 	for (i = 0; i < url_nr; i++)
 	{
-		strbuf_addf(&url_buf, "%s (push)", url[i]);
+		strbuf_addf(&remote_info_buf, "%s (push)", url[i]);
 		string_list_append(list, remote->name)->util =
-				strbuf_detach(&url_buf, NULL);
+				strbuf_detach(&remote_info_buf, NULL);
 	}
 
 	return 0;
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 4a3778d04a8..bf8f3644d3c 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -49,6 +49,17 @@ test_expect_success 'do partial clone 1' '
 	test "$(git -C pc1 config --local remote.origin.partialclonefilter)" = "blob:none"
 '
 
+test_expect_success 'filters for promisor remotes is listed by git remote -v' '
+	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc2 &&
+	git -C pc2 remote -v >out &&
+	grep "[blob:none]" out &&
+
+	git -C pc2 config remote.origin.partialCloneFilter object:type=commit &&
+	git -C pc2 remote -v >out &&
+	grep "[object:type=commit]" out &&
+	rm -rf pc2
+'
+
 test_expect_success 'verify that .promisor file contains refs fetched' '
 	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
 	test_line_count = 1 promisorlist &&

base-commit: 0f828332d5ac36fc63b7d8202652efa152809856
-- 
gitgitgadget
