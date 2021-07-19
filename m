Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857D1C07E9D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718AA61242
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352205AbhGSQ5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357800AbhGSQwT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 12:52:19 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C310CC0613B8
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 09:59:21 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id z1so16722424ils.0
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=47/VZZONHAS5hgtnH1RTJV3+FXftlMBkSrHPOGSjMR4=;
        b=uKdkZDN+ykONa9UtzbzjV+HPjVxtE1zdUnNY6mFXYyhsCezKyqWN9UWBqOOTei47p7
         i7V8arFg1S4UN/ZbedYUB2xwz/Za1FdUjEbWH9skkU+5UEmTafPotNQImHRKX2TfOwTW
         Du1skgIyYVW8TyKGAHsBKzLWhJzwF2KiSPjwiNQLAr5AXDuGP4L4UUDnDNn3zbVuQDmV
         g8PPDcSjZN1MmsSwEzHX027JD5nBqZwjScwiIFq7ST9roEFJdVNYq/FoQpmBdDNkcrF0
         Pkk/O5GRQykWhJr56c+J8CnpN8NCJ3bX7Dn0i5BqN+kSuP8IleZVCF3ae033oDuuvzPZ
         2EnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=47/VZZONHAS5hgtnH1RTJV3+FXftlMBkSrHPOGSjMR4=;
        b=Eb/ZcnOoZ59iZcYO2jjWv2E6C+akYIjxRkFkDp6wOlYimF6HWGhTgcZGGHf8w+SA3+
         Pmu2nR0GYi5FNGYG7JYBi5FiVQ8CogJcXaefALhv7p9zh71cOCVXidbCu8iEppy2RfZm
         hpR6Y4z3Idf98uYUM3PGqIlV6+PiGd/tDDQWD0YSsG8b+5209l8oLWeYYdFKYuJ11H5I
         eldvQrHR8kZIE5KVihWKcBXaJ5qU6GaIEI0c60qCeAK831ICI+UJU3RwgWkfIrwWKr93
         H0JCJkCv9lo63ttWfIpuMg44+Y5U6Ibu79825IEateR5DT5kZn7K25iMCcLM/r7zTJAx
         Gn8A==
X-Gm-Message-State: AOAM530ur5gxaMcgjabpRwWzPExJu9lXzrCBHMEQsw5ZXWEJanMkzAqb
        PNYrv0365QNwj/zUhTQoe4YtQzSPIC+IMemB
X-Google-Smtp-Source: ABdhPJwFy5ZP8sDmO743foB2OjniIea0SiU0zZzyVA03LwIkoJdZxDd9CNe1q0oBqPa8iACmxY7ueg==
X-Received: by 2002:a92:d210:: with SMTP id y16mr18414555ily.295.1626715131112;
        Mon, 19 Jul 2021 10:18:51 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:a0a0:3329:4f28:d1a3])
        by smtp.gmail.com with ESMTPSA id o13sm10012413ilq.58.2021.07.19.10.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 10:18:50 -0700 (PDT)
Date:   Mon, 19 Jul 2021 13:18:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com
Subject: [PATCH] multi-pack-index: fix potential segfault without sub-command
Message-ID: <8c0bb3e0dc121bd68f7014000fbb60b28750a0fe.1626715096.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since cd57bc41bb (builtin/multi-pack-index.c: display usage on
unrecognized command, 2021-03-30) we have used a "usage" label to avoid
having two separate callers of usage_with_options (one when no arguments
are given, and another for unrecognized sub-commands).

But the first caller has been broken since cd57bc41bb, since it will
happily jump to usage without arguments, and then pass argv[0] to the
"unrecognized subcommand" error.

Many compilers will save us from a segfault here, but the end result is
ugly, since it mentions an unrecognized subcommand when we didn't even
pass one, and (on GCC) includes "(null)" in its output.

Move the "usage" label down past the error about unrecognized
subcommands so that it is only triggered when it should be. While we're
at it, bulk up our test coverage in this area, too.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Noticed this while I was reading code in a similar area while reviewing
one of Ævar's series.

 builtin/multi-pack-index.c  | 2 +-
 t/t5319-multi-pack-index.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5d3ea445fd..8ff0dee2ec 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -176,8 +176,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	else if (!strcmp(argv[0], "expire"))
 		return cmd_multi_pack_index_expire(argc, argv);
 	else {
-usage:
 		error(_("unrecognized subcommand: %s"), argv[0]);
+usage:
 		usage_with_options(builtin_multi_pack_index_usage,
 				   builtin_multi_pack_index_options);
 	}
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 5641d158df..dab7123b3a 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -824,4 +824,9 @@ test_expect_success 'load reverse index when missing .idx, .pack' '
 	)
 '

+test_expect_success 'usage shown without sub-command' '
+	test_expect_code 129 git multi-pack-index 2>err &&
+	! test_i18ngrep "unrecognized subcommand" err
+'
+
 test_done
--
2.31.1.163.ga65ce7f831
