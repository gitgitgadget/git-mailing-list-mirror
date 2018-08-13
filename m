Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37E821F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbeHMS6b (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39369 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbeHMS6a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id a134-v6so11653139lfe.6
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QO9iOCSQClfrxUHLze8svK2Lf2j4qWbFDLZ3ZSXGQEk=;
        b=tYAnmPMxi1+J/m3irWhoS+WyjKkTyHJWi2XsC6zxYKXwzUl4JBAcxNVrSjhexNvhCo
         Rj25R+4Pa68YHjkvzdVP+Lu82eDnas3EAYIcaAMQ1gxB5+/8CFQ4rWdxjSeJUmtkqCbI
         LrzjYh6K4YjUteHRkYOFHuZwEthI3e4hL3xhQUfsExl0BteYMSO/BPP5YbCSIR9sI2gx
         Ddd4LznBgcL/PydaviS24axpSDDVnKuaGoKsR5Uy59BsLqHcsbyWUG0QaAgeIx+anzJj
         8fdg0r9kfukGEPy3sDfmPUXGOCsYa5Zz7jSWC/d6TTVFu1Dw+owTPWe10u7lFhgPBr9I
         Q1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QO9iOCSQClfrxUHLze8svK2Lf2j4qWbFDLZ3ZSXGQEk=;
        b=KmC6D7WfwyrTidE+hW9oVawCkkyvW3YKaQ7T4zccOSOLAxz/8a6iT0XGIvVXfYMeoV
         9NeakKYTRWhY0s8Nf2eTP5w+6e1r12mE14tMyYHF48HSQBKPUJYXBNKdCsxqPS9vnQan
         P8svAoP/0fx6KlNRPEnONmhqtYQ6jwcNlUAHKQpbPqegrL9WiVnj4x20MMH3pEd1YRs3
         XEIK6rffqnGMyC7w/xC91gVjg++5wIr2VXFZzKKTB0rdDc9MtdtdogKNdqXCdbD79kUY
         qbx7ulCMT1N/f70mZJeriKIpCZBe3hf4wEbuKlAQpqBy8tIk9Mmc95cuC192XacorMzA
         bEtg==
X-Gm-Message-State: AOUpUlG/WyAT46w2RyNw7yMPXvpqS8gWeGGObNtwv2U2wEHdd/HZPZg2
        pdV5DRGjxsvngsKn5g+yImFlc6pw
X-Google-Smtp-Source: AA+uWPwO8UGU89V4bJNiiBr0zuQAlJrZHPF78/d0J/ZVBxrR7F56lcV2LBlvh5HK5nj2n9ZX4SnGSQ==
X-Received: by 2002:a19:6b03:: with SMTP id d3-v6mr1081996lfa.81.1534176935790;
        Mon, 13 Aug 2018 09:15:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/24] entry.c: use the right index instead of the_index
Date:   Mon, 13 Aug 2018 18:14:32 +0200
Message-Id: <20180813161441.16824-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

checkout-index.c needs update because if checkout->istate is NULL,
ie_match_stat() will crash. Previously this is ie_match_stat(&the_index, ..)
so it will not crash, but it is not technically correct either.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout-index.c | 1 +
 entry.c                  | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index a730f6a1aa..d92db62fbd 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -190,6 +190,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, builtin_checkout_index_options,
 			builtin_checkout_index_usage, 0);
+	state.istate = &the_index;
 	state.force = force;
 	state.quiet = quiet;
 	state.not_new = not_new;
diff --git a/entry.c b/entry.c
index b2381fd9f6..2a2ab6c839 100644
--- a/entry.c
+++ b/entry.c
@@ -266,7 +266,7 @@ static int write_entry(struct cache_entry *ce,
 	const struct submodule *sub;
 
 	if (ce_mode_s_ifmt == S_IFREG) {
-		struct stream_filter *filter = get_stream_filter(&the_index, ce->name,
+		struct stream_filter *filter = get_stream_filter(state->istate, ce->name,
 								 &ce->oid);
 		if (filter &&
 		    !streaming_write_entry(ce, path, filter,
@@ -314,14 +314,14 @@ static int write_entry(struct cache_entry *ce,
 		 * Convert from git internal format to working tree format
 		 */
 		if (dco && dco->state != CE_NO_DELAY) {
-			ret = async_convert_to_working_tree(&the_index, ce->name, new_blob,
+			ret = async_convert_to_working_tree(state->istate, ce->name, new_blob,
 							    size, &buf, dco);
 			if (ret && string_list_has_string(&dco->paths, ce->name)) {
 				free(new_blob);
 				goto delayed;
 			}
 		} else
-			ret = convert_to_working_tree(&the_index, ce->name, new_blob, size, &buf);
+			ret = convert_to_working_tree(state->istate, ce->name, new_blob, size, &buf);
 
 		if (ret) {
 			free(new_blob);
@@ -422,7 +422,8 @@ int checkout_entry(struct cache_entry *ce,
 
 	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
 		const struct submodule *sub;
-		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+		unsigned changed = ie_match_stat(state->istate, ce, &st,
+						 CE_MATCH_IGNORE_VALID | CE_MATCH_IGNORE_SKIP_WORKTREE);
 		/*
 		 * Needs to be checked before !changed returns early,
 		 * as the possibly empty directory was not changed
-- 
2.18.0.1004.g6639190530

