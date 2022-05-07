Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DDCC433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 14:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiEGOYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 10:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiEGOYM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 10:24:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615C7BC35
        for <git@vger.kernel.org>; Sat,  7 May 2022 07:20:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b19so13598495wrh.11
        for <git@vger.kernel.org>; Sat, 07 May 2022 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zjw2XcSL8xw4HxbTXlmbniyQqUmgb7jn7MYoeWY2qoU=;
        b=nwWCQyDFy1tR8b03Gfm/LNdE42dhlDTTe/NKOvDOmtzwQPM9tTwkxvuOfyo3WS8zxv
         WqlD/fdd+KIuf7XjGpBzyjqinSsF70POaCWF3aHdi2K3TV6pQdFaosJ5zwB4knreysQL
         urjgU/c2y3+B+C9zTs/EuQb22BO//AHsKCy/ALkELcH7MZxezsHaWajHH+Herwmcr8/q
         5BfOVQIfZHsBMsBESeblt0MKhJTjDj4AjfqKSMU7OQxX5mTcdUEnuZzJZEFbiDsnUpvU
         sobFx+WXXLQueN/9dJ9BQ5zZOxbQ/C589tJn+dDdz1zH8ockWmwHtMzBnihAFNUaYvFi
         CGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zjw2XcSL8xw4HxbTXlmbniyQqUmgb7jn7MYoeWY2qoU=;
        b=eKLVrNmImthD8cbWeNTWNhtHIUSVQNHVNMf9mimAx6qvAoL2igra05owXJrfyXmguh
         yaH42N6A7Hm2c03xZaim6mI/flgUYzxub4OPHqlMDx7DU+3Rjqs50uy7DwQUSHV282PX
         JLGziGr4PyBshG/r2bJIOEERdhyCzAM8S/85kSsND5Cwg4LMP9HvkcZPXraJY9jNf2RA
         mvF45/B+k9qk7Cy4Hn0DQ0Q4VLqhMXbKy0KGsjgQI6Fes9LYJdFhQvMMnO57pKzNHGXD
         1BnUvDCsnUGyknnUCP6uah1A1YSHnN8h4uOWoNLFB6uCd9gk2tOfoFr2WA8YMizlI1JI
         TLww==
X-Gm-Message-State: AOAM531buzAYEwbUYNvM8OKXKKIEJmcV9nkj6BWgJbHBEJhDtmbT2lKP
        d4XNCMwuSedwcjDLvERTcDXe2SLsZ+s=
X-Google-Smtp-Source: ABdhPJworzHTdumDzvKeAytbmgVieFdUIdOwPHLQBs6Wv7T7YaAHBCi6if7mXuJQ9dKdP0f1GqC97w==
X-Received: by 2002:adf:ed86:0:b0:20a:db50:1b1b with SMTP id c6-20020adfed86000000b0020adb501b1bmr7132321wro.506.1651933222593;
        Sat, 07 May 2022 07:20:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d5942000000b0020c5253d8e1sm7593979wri.45.2022.05.07.07.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 07:20:22 -0700 (PDT)
Message-Id: <pull.1227.v3.git.1651933221216.gitgitgadget@gmail.com>
In-Reply-To: <pull.1227.v2.git.1651591253333.gitgitgadget@gmail.com>
References: <pull.1227.v2.git.1651591253333.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 May 2022 14:20:21 +0000
Subject: [PATCH v3] builtin/remote.c: teach `-v` to list filters for promisor
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
    
    In the previous version, documentation is updated (describing the
    proposed change) and url_buf is renamed into remote_info_buf. In this
    varsion, some more test cases are added and broken indentations are
    fixed.
    
    [1] https://github.com/gitgitgadget/git/issues/1211

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1227%2FAbhra303%2Fpromisor_remote-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1227/Abhra303/promisor_remote-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1227

Range-diff vs v2:

 1:  e7ced852fd5 ! 1:  9ac6ca9a08e builtin/remote.c: teach `-v` to list filters for promisor remotes
     @@ Documentation/git-remote.txt: OPTIONS
       -v::
       --verbose::
       	Be a little more verbose and show remote url after name.
     -+  For promisor remotes it will show an extra information
     -+  (wrapped in square brackets) describing which filter
     -+  (`blob:none` etc.) that promisor remote use.
     ++	For promisor remotes it will show an extra information
     ++	(wrapped in square brackets) describing which filter
     ++	(`blob:none` etc.) that promisor remote use.
       	NOTE: This must be placed between `remote` and subcommand.
       
       
     @@ t/t5616-partial-clone.sh: test_expect_success 'do partial clone 1' '
       	test "$(git -C pc1 config --local remote.origin.partialclonefilter)" = "blob:none"
       '
       
     -+test_expect_success 'filters for promisor remotes is listed by git remote -v' '
     ++test_expect_success 'filters for promisor remotes are listed by git remote -v' '
     ++	test_when_finished "rm -rf pc2" &&
      +	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc2 &&
      +	git -C pc2 remote -v >out &&
     -+	grep "[blob:none]" out &&
     ++	grep "srv.bare (fetch) \[blob:none\]" out &&
      +
      +	git -C pc2 config remote.origin.partialCloneFilter object:type=commit &&
      +	git -C pc2 remote -v >out &&
     -+	grep "[object:type=commit]" out &&
     -+	rm -rf pc2
     ++	grep "srv.bare (fetch) \[object:type=commit\]" out
     ++'
     ++
     ++test_expect_success 'filters should not be listed for non promisor remotes (remote -v)' '
     ++	test_when_finished "rm -rf pc2" &&
     ++	git clone "file://$(pwd)/srv.bare" pc2 &&
     ++	git -C pc2 remote -v >out &&
     ++	! grep "(fetch) \[.*\]" out
     ++'
     ++
     ++test_expect_success 'filters are listed by git remote -v only' '
     ++	test_when_finished "rm -rf pc2" &&
     ++	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc2 &&
     ++	git -C pc2 remote >out &&
     ++	! grep "\[blob:none\]" out &&
     ++
     ++	git -C pc2 remote show >out &&
     ++	! grep "\[blob:none\]" out
      +'
      +
       test_expect_success 'verify that .promisor file contains refs fetched' '


 Documentation/git-remote.txt |  3 +++
 builtin/remote.c             | 18 +++++++++++++-----
 t/t5616-partial-clone.sh     | 28 ++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index cde9614e362..a125bd839f7 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -35,6 +35,9 @@ OPTIONS
 -v::
 --verbose::
 	Be a little more verbose and show remote url after name.
+	For promisor remotes it will show an extra information
+	(wrapped in square brackets) describing which filter
+	(`blob:none` etc.) that promisor remote use.
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
index 4a3778d04a8..26756d616cd 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -49,6 +49,34 @@ test_expect_success 'do partial clone 1' '
 	test "$(git -C pc1 config --local remote.origin.partialclonefilter)" = "blob:none"
 '
 
+test_expect_success 'filters for promisor remotes are listed by git remote -v' '
+	test_when_finished "rm -rf pc2" &&
+	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc2 &&
+	git -C pc2 remote -v >out &&
+	grep "srv.bare (fetch) \[blob:none\]" out &&
+
+	git -C pc2 config remote.origin.partialCloneFilter object:type=commit &&
+	git -C pc2 remote -v >out &&
+	grep "srv.bare (fetch) \[object:type=commit\]" out
+'
+
+test_expect_success 'filters should not be listed for non promisor remotes (remote -v)' '
+	test_when_finished "rm -rf pc2" &&
+	git clone "file://$(pwd)/srv.bare" pc2 &&
+	git -C pc2 remote -v >out &&
+	! grep "(fetch) \[.*\]" out
+'
+
+test_expect_success 'filters are listed by git remote -v only' '
+	test_when_finished "rm -rf pc2" &&
+	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc2 &&
+	git -C pc2 remote >out &&
+	! grep "\[blob:none\]" out &&
+
+	git -C pc2 remote show >out &&
+	! grep "\[blob:none\]" out
+'
+
 test_expect_success 'verify that .promisor file contains refs fetched' '
 	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
 	test_line_count = 1 promisorlist &&

base-commit: 0f828332d5ac36fc63b7d8202652efa152809856
-- 
gitgitgadget
