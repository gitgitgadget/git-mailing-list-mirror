Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 460F320A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbeLJSG2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:06:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46962 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbeLJSG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:06:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so5302655pgp.13
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h/vNCjBo0G1jpG9POunS0it1v+UK17DMfsb6LuvCLyk=;
        b=uts+iUn25NWMjXT5BfYJ9sH6hewqK2O9RvZHDd4LPHbbb2cT16i+7JNhuhHFGGX9Lj
         EQknnjExBfKbwH/4ptBP8RVD1sowqWAWUmpAfLIsydAjAHjqsdbRi3YW29/g8+Dh2t3q
         g4rwqnrMgwxej/ccZz4eiab9OSFJ+yg91/PrEtOpGGCNOxO2rNLGCX1FJOJuH3vPrDCm
         Wu434jEjPnH8fNZG4VviaQUbXAXNcPoZ783K55Xag79504MYfGfEJfKxuiISOBh/9Wwb
         gM9XakDvL8BizvCCfZUrLTVhpXd5vsnZSR73bu2wF/1+2F6YVJA/41EnryF59b1qNHpZ
         PVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h/vNCjBo0G1jpG9POunS0it1v+UK17DMfsb6LuvCLyk=;
        b=TEXzMeAeuGEay78YTOFthWsMbIu1kevKXX+n5BFoUS+U66FA3DZqLoYMK0XPqyS/FX
         5SAFojxhf0VO+mjgIyiRD2EynXn3dswkVVluNdibA1pUAynVmNCj1LHdhge1cTKWPCPP
         fbnWciFd22cptwHTMPfA3g9Vr7u7C6YbrAxIvoj4lSOd8RUSvYzeZ9Ojsw0TclwcZ/yi
         KDyBlDRlgqQAAqHeoIkzqPE6D4lxMVpl0Wdor+w2YPyYeZ0B72Da+QnwObdcjJ94V816
         w01kPn97G7aB9nWHDCqFJAum8weey/lqM/tVrFX8x3KKm5Clkau8JzuJsJO2oYt4qtrD
         qjMw==
X-Gm-Message-State: AA+aEWZXTofZ6rYYOTqk97eCe8p8tSyuYjvxPbX0OhIJzsXjk4IhkDZr
        eeF4vopnwZgfpvm3qb1idA4WJB7F
X-Google-Smtp-Source: AFSGD/XIklhymiCda+QIrFncMdi+mjLpjBky3NWWhoo9Oq5M9n/FpL+OB+R7hutyS2l6QnEePzXXRA==
X-Received: by 2002:a63:d846:: with SMTP id k6mr11904623pgj.251.1544465185770;
        Mon, 10 Dec 2018 10:06:25 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id v191sm23391114pgb.77.2018.12.10.10.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 10:06:25 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:06:25 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 18:06:16 GMT
Message-Id: <41ef671ec8361a9635dc78c078d2d84e9d985236.1544465177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.git.gitgitgadget@gmail.com>
References: <pull.92.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/5] midx: implement midx_repack()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

To repack using a multi-pack-index, first sort all pack-files by
their modified time. Second, walk those pack-files from oldest
to newest, adding the packs to a list if they are smaller than the
given pack-size. Finally, collect the objects from the multi-pack-
index that are in those packs and send them to 'git pack-objects'.

While first designing a 'git multi-pack-index repack' operation, I
started by collecting the batches based on the size of the objects
instead of the size of the pack-files. This allows repacking a
large pack-file that has very few referencd objects. However, this
came at a significant cost of parsing pack-files instead of simply
reading the multi-pack-index and getting the file information for
the pack-files. This object-size idea could be a direction for
future expansion in this area.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 109 +++++++++++++++++++++++++++++++++++-
 t/t5319-multi-pack-index.sh |  25 +++++++++
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 4caf148464..3718e78132 100644
--- a/midx.c
+++ b/midx.c
@@ -8,6 +8,7 @@
 #include "sha1-lookup.h"
 #include "midx.h"
 #include "progress.h"
+#include "run-command.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -1116,7 +1117,113 @@ int expire_midx_packs(const char *object_dir)
 	return result;
 }
 
-int midx_repack(const char *object_dir, size_t batch_size)
+struct time_and_id {
+	timestamp_t mtime;
+	uint32_t pack_int_id;
+};
+
+static int compare_by_mtime(const void *a_, const void *b_)
 {
+	const struct time_and_id *a, *b;
+
+	a = (const struct time_and_id *)a_;
+	b = (const struct time_and_id *)b_;
+
+	if (a->mtime < b->mtime)
+		return -1;
+	if (a->mtime > b->mtime)
+		return 1;
 	return 0;
 }
+
+int midx_repack(const char *object_dir, size_t batch_size)
+{
+	int result = 0;
+	uint32_t i, packs_to_repack;
+	size_t total_size;
+	struct time_and_id *pack_ti;
+	unsigned char *include_pack;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf base_name = STRBUF_INIT;
+	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+
+	if (!m)
+		return 0;
+
+	include_pack = xcalloc(m->num_packs, sizeof(unsigned char));
+	pack_ti = xcalloc(m->num_packs, sizeof(struct time_and_id));
+
+	for (i = 0; i < m->num_packs; i++) {
+		pack_ti[i].pack_int_id = i;
+
+		if (prepare_midx_pack(m, i))
+			continue;
+
+		pack_ti[i].mtime = m->packs[i]->mtime;
+	}
+	QSORT(pack_ti, m->num_packs, compare_by_mtime);
+
+	total_size = 0;
+	packs_to_repack = 0;
+	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
+		int pack_int_id = pack_ti[i].pack_int_id;
+		struct packed_git *p = m->packs[pack_int_id];
+
+		if (!p)
+			continue;
+		if (p->pack_size >= batch_size)
+			continue;
+
+		packs_to_repack++;
+		total_size += p->pack_size;
+		include_pack[pack_int_id] = 1;
+	}
+
+	if (total_size < batch_size || packs_to_repack < 2)
+		goto cleanup;
+
+	argv_array_push(&cmd.args, "pack-objects");
+
+	strbuf_addstr(&base_name, object_dir);
+	strbuf_addstr(&base_name, "/pack/pack");
+	argv_array_push(&cmd.args, base_name.buf);
+	strbuf_release(&base_name);
+
+	cmd.git_cmd = 1;
+	cmd.in = cmd.out = -1;
+
+	if (start_command(&cmd)) {
+		error(_("could not start pack-objects"));
+		result = 1;
+		goto cleanup;
+	}
+
+	for (i = 0; i < m->num_objects; i++) {
+		struct object_id oid;
+		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
+
+		if (!include_pack[pack_int_id])
+			continue;
+
+		nth_midxed_object_oid(&oid, m, i);
+		xwrite(cmd.in, oid_to_hex(&oid), the_hash_algo->hexsz);
+		xwrite(cmd.in, "\n", 1);
+	}
+	close(cmd.in);
+
+	if (finish_command(&cmd)) {
+		error(_("could not finish pack-objects"));
+		result = 1;
+		goto cleanup;
+	}
+
+	result = write_midx_internal(object_dir, m, NULL);
+	m = NULL;
+
+cleanup:
+	if (m)
+		close_midx(m);
+	free(include_pack);
+	free(pack_ti);
+	return result;
+}
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index c23e930a5d..3cc9c918d5 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -421,4 +421,29 @@ test_expect_success 'repack does not create any packs' '
 	)
 '
 
+test_expect_success 'repack creates a new pack' '
+	(
+		cd dup &&
+		SECOND_SMALLEST_SIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 2 | tail -n 1) &&
+		BATCH_SIZE=$(($SECOND_SMALLEST_SIZE + 1)) &&
+		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 5 idx-list &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 5 midx-list
+	)
+'
+
+test_expect_success 'expire removes repacked packs' '
+	(
+		cd dup &&
+		ls -S .git/objects/pack/*pack | head -n 3 >expect &&
+		git multi-pack-index expire &&
+		ls -S .git/objects/pack/*pack >actual &&
+		test_cmp expect actual &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 3 midx-list
+	)
+'
+
 test_done
-- 
gitgitgadget
