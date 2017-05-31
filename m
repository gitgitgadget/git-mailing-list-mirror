Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73C7D1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbdEaVpa (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:30 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36088 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbdEaVp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:28 -0400
Received: by mail-pf0-f170.google.com with SMTP id m17so18556147pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kot/Up9bPi++4dKIX6EUr1BoWzu37DqNxcsb/g2GCcU=;
        b=fLNaIFVaRkT/HODEhkEy8TCFxI7WhkSMuTrEGu0+4y3F4e7+7nYyjpuEmhnCk/vq7W
         VlGoh8vtU+8JnTXz2BElhCkQUK6Vnjp38GGpVBVjnJVCsXZSWZXpjZVw57vn7mlVZH7H
         MXKocYTfzPNj5gbTKSWAYFgcNHdCl7zEw/KS5Uq5dKL+NN21lctHqIZJsnOQXWiqFdQ5
         0qZLLSVFIdoZ/43+ua0jJG3g1wHUydLpi+uX/YRu/F/rz/8NE4ILGpWzdPmi/Is8OlNp
         ys0Z0ePwJ+m673dgpeaFeX2uMpyM2qbuwRrsRx8xIqLdNx3l6JIM8hppdttEUKG2mgnV
         Gxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kot/Up9bPi++4dKIX6EUr1BoWzu37DqNxcsb/g2GCcU=;
        b=kmLl+TPzYyfc7t+meqvEeLTgwR7iEGtctQgplFqGBR2xKJ7jIZpuMSdunZEOwsDD8c
         +yfhvCPWCyxEqEBikSFzc6dSCAkfajr8oRNHYYlXoWMZc2AuXxrZk5cyYFJoY3TpL6HH
         /Zs4Ucs9JWgSn7vTWmEZbCtNaLHFUaT2y3opzlt8dwxwgaolWrcUfIkkoHNjDacJKoqa
         Ou6A7YTHHU3665/bZotjt1kdW0j5NzLr5IC0kM2j9L/PcGrUfdYV7bpKtCBTz3/bzCbf
         qJGSMWKFjumLx5p3YE7gmXe/wrqjsxQGgXeuTTuW86mHtvMtaZUBUT1wgvNn4Uw4R6+A
         reew==
X-Gm-Message-State: AODbwcBmwxr4ypuBR/yMIEY/Gifn3lNo5tdTomUXND9ziuk9/v02Fjcv
        cyJRr1D2X8twdYzX
X-Received: by 10.84.218.14 with SMTP id q14mr5870147pli.80.1496267112756;
        Wed, 31 May 2017 14:45:12 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:45:11 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 25/31] ls-files: convert show_ru_info to take an index
Date:   Wed, 31 May 2017 14:44:11 -0700
Message-Id: <20170531214417.38857-26-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d00ca7810..2838e2f75 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -293,14 +293,14 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 	strbuf_release(&name);
 }
 
-static void show_ru_info(void)
+static void show_ru_info(const struct index_state *istate)
 {
 	struct string_list_item *item;
 
-	if (!the_index.resolve_undo)
+	if (!istate->resolve_undo)
 		return;
 
-	for_each_string_list_item(item, the_index.resolve_undo) {
+	for_each_string_list_item(item, istate->resolve_undo) {
 		const char *path = item->string;
 		struct resolve_undo_info *ui = item->util;
 		int i, len;
@@ -686,7 +686,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	}
 	show_files(&dir);
 	if (show_resolve_undo)
-		show_ru_info();
+		show_ru_info(&the_index);
 
 	if (ps_matched) {
 		int bad;
-- 
2.13.0.506.g27d5fe0cd-goog

