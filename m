Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97D7C04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiIWS4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiIWSzh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:55:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2622138A3C
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c11so1263066wrp.11
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=/njCdhavfcrp42ymreIZjcxJJ3Z9oPEGZCpV/ZrwlDc=;
        b=UGsrzjVn6ZRFW/HLzdeKkHskpmsClEG1TqDMb8Zo58GkiLOKN6uriGVt6jUXpUDYkF
         o6SustrlZK1hheZwb9SNXyzlm+ALQN+KvvE4Xnn1ugcFIxXAhNHmsEeWWKFFnbSqy8bv
         u7IfFimDi8gRmep51rceMzduG7G6dndfU5PpbJtCD4ki5Kbem46cxV1IwEOvI4oqMwEG
         qM0aHE7BQHz8c6HkI5tpJo3iwNyWefav1CnQ0kOHKAPIFMNNgvS297//57h+kDprB/ue
         nztJrw2WFJVMY6h/OwaLkFRG1TC4xgWVitC3P+xv44qwb2H3M++XR97cIBfznR9VpT1Y
         Y34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/njCdhavfcrp42ymreIZjcxJJ3Z9oPEGZCpV/ZrwlDc=;
        b=7MRBIewVq0OdxDCoIqLyqKT217TjNipmJPYyvn1BPnh80379u4SJnw8KK06byH8Zn6
         n8A780M7CgTJ9i3A/TxYQWr7oAwzvx663ytlZcWQ5qKAN4x0us57qOk1cnfGVbMwqsdA
         sx0rMfZDtwDVgYD9jPb9tmTDFrZtYj7ykOOJ3EMPwsz0qEjozSpB43TD2wzcqwBPMdb+
         v16BSoS/y9wzad2ofh4uMof+Xt/FjWsXdK5VfB298zpqP+2EZiGAgZA0IFzH8v1W0E2e
         4EJD1FBin/9z0aTArXA5IpmcjXw6Iy+ENENSx7kzJIE55ZQcqKV1b4bIeXww85CywmGf
         6FLw==
X-Gm-Message-State: ACrzQf3HpYt+y9ajeJfo+ij4HH2kmK4Vcob5VNavKh1F8QGv0etks7zh
        xm7vRv0DqbAEnFFacoZ79pbJNOYITnQ=
X-Google-Smtp-Source: AMsMyM7Rl4hvgS8CZ/DD7NFFchhhqBNhSJLFxrCNEqoYNTQlFAPmthr5aMpoA1vRUt/1LEyI3QjDIw==
X-Received: by 2002:adf:f18d:0:b0:228:9f0a:f291 with SMTP id h13-20020adff18d000000b002289f0af291mr6477662wro.252.1663959332472;
        Fri, 23 Sep 2022 11:55:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b003a2e92edeccsm3481411wms.46.2022.09.23.11.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:55:32 -0700 (PDT)
Message-Id: <b83a79beeb456fa4c55aee5cfd204752a7b992c2.1663959325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
From:   "Stefan Xenos via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Sep 2022 18:55:22 +0000
Subject: [PATCH 08/10] evolve: add the git change list command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@google.com>

This command lists the ongoing changes from the refs/metas
namespace.

Signed-off-by: Stefan Xenos <sxenos@google.com>
Signed-off-by: Chris Poucet <poucet@google.com>
---
 builtin/change.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/builtin/change.c b/builtin/change.c
index b0e29e87ec9..67d708dc8de 100644
--- a/builtin/change.c
+++ b/builtin/change.c
@@ -6,15 +6,78 @@
 #include "config.h"
 
 static const char * const builtin_change_usage[] = {
+	N_("git change list [<pattern>...]"),
 	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
 	NULL
 };
 
+static const char * const builtin_list_usage[] = {
+	N_("git change list [<pattern>...]"),
+	NULL
+};
+
 static const char * const builtin_update_usage[] = {
 	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
 	NULL
 };
 
+static int change_list(int argc, const char **argv, const char* prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	struct ref_filter filter;
+	/* TODO: See below
+	struct ref_sorting *sorting;
+	struct string_list sorting_options = STRING_LIST_INIT_DUP; */
+	struct ref_format format = REF_FORMAT_INIT;
+	struct ref_array array;
+	int i;
+
+	argc = parse_options(argc, argv, prefix, options, builtin_list_usage, 0);
+
+	setup_ref_filter_porcelain_msg();
+
+	memset(&filter, 0, sizeof(filter));
+	memset(&array, 0, sizeof(array));
+
+	filter.kind = FILTER_REFS_CHANGES;
+	filter.name_patterns = argv;
+
+	filter_refs(&array, &filter, FILTER_REFS_CHANGES);
+
+	/* TODO: This causes a crash. It sets one of the atom_value handlers to
+	 * something invalid, which causes a crash later when we call
+	 * show_ref_array_item. Figure out why this happens and put back the sorting.
+	 *
+	 * sorting = ref_sorting_options(&sorting_options);
+	 * ref_array_sort(sorting, &array); */
+
+	if (!format.format)
+		format.format = "%(refname:lstrip=1)";
+
+	if (verify_ref_format(&format))
+		die(_("unable to parse format string"));
+
+	for (i = 0; i < array.nr; i++) {
+		struct strbuf output = STRBUF_INIT;
+		struct strbuf err = STRBUF_INIT;
+		if (format_ref_array_item(array.items[i], &format, &output, &err))
+			die("%s", err.buf);
+		fwrite(output.buf, 1, output.len, stdout);
+		putchar('\n');
+
+		strbuf_release(&err);
+		strbuf_release(&output);
+	}
+
+	ref_array_clear(&array);
+	/* TODO: see above
+	ref_sorting_release(sorting); */
+
+	return 0;
+}
+
 struct update_state {
 	int options;
 	const char* change;
@@ -188,6 +251,8 @@ int cmd_change(int argc, const char **argv, const char *prefix)
 
 	if (argc < 1)
 		usage_with_options(builtin_change_usage, options);
+	else if (!strcmp(argv[0], "list"))
+		result = change_list(argc, argv, prefix);
 	else if (!strcmp(argv[0], "update"))
 		result = change_update(argc, argv, prefix);
 	else {
-- 
gitgitgadget

