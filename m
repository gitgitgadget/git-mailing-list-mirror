Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B7120248
	for <e@80x24.org>; Tue, 19 Mar 2019 14:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfCSOhw (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 10:37:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33952 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCSOhv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 10:37:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id a16so16817351edn.1
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ssgVxlRxmvWavM7lQQeuM3Jn3qGW+uMzStsp/B2z8sk=;
        b=cKYz1kS8RipZTQBVMbaAAYpuhVfMu/QCcB9cxFjNMw09uu16Gky5YeffgdIsF3Wkov
         xkw6OzTLVUDQ0E7Ws8a0uG7IwtQaOJmYCrjEEw+C8M2ZJcl2kazBNSFCwmfHeLZP2T7Z
         Ch4Kng/TVlA1lalSV0C/vM9V4o/Rx1RgtUx2P5VvBRKG+46vtkW1p06sKiBvvBlqugot
         xMkK3nE+3hpaRKuGDYd8iqh91SaAZMt7QF30TgSCfdEmi3COtdzTaZdwcm6o7WI7oL+1
         c3RwN+kRBQFFGqfQAJHxiNr+OZ3PHU5Tx9tASWpMUrpT6fKmgI7VjsmJl944MSRd5LSt
         /kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ssgVxlRxmvWavM7lQQeuM3Jn3qGW+uMzStsp/B2z8sk=;
        b=ooPzwXVSQyrHuM/T8dF11UbdIeFzG9lbo6MJJLX0Daql9B/7wdLUhJgJpQMUUzn5kg
         JRloQGUBVjezoVjnOMyYZZByKGdws4XWx1EOOHANJDnIJUvxTtBeMviPbyxmz0ij+ibB
         UZgIElDiI7BEd2rBkXXrZdW7f5Yw1JvQGxTd+LfNScRZ0KAF5fcN52xPjXtRz2ZB89lQ
         gHT3+wfyaunIgpq+1mHskQgvVg2ffOg4xO1t4MyNpDV7SnHB1y3n+G2fkCoxXj8sJ0Ay
         3WMjLnTD3hTrFpl39jQg1LWdpr04UKLyqdJBHex/KhgdaYeNcjbphNN1yQqBRLfevWsd
         cwBw==
X-Gm-Message-State: APjAAAVb+iU9yHAnuvg5LZvKfJCpmbv5F9szHf5QIdU+SXlQ2TGHxEcs
        cxi184N4PrNuuxrUTjs0AMZv6hNM
X-Google-Smtp-Source: APXvYqz+bYB3HAC6bONhMMzzcL/rUe91r0S16f9gEeqKuCTL1iwGgZHHm7Lz5oP25rdZf8UnhECpXA==
X-Received: by 2002:a17:906:7f06:: with SMTP id d6mr1083997ejr.239.1553006269387;
        Tue, 19 Mar 2019 07:37:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a51sm4421517edd.57.2019.03.19.07.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 07:37:48 -0700 (PDT)
Date:   Tue, 19 Mar 2019 07:37:48 -0700 (PDT)
X-Google-Original-Date: Tue, 19 Mar 2019 14:37:43 GMT
Message-Id: <pull.166.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.166.git.gitgitgadget@gmail.com>
References: <pull.166.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/4] multi-pack-index: fix verify on large repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Version 2 addresses progress-related concerns raised in the previous version
of the midx verify code.

This version also extends the existing progress.[ch] code and adds a
"sparse" mode that automatically ensures the 100% message is issued.


----------------------------------------------------------------------------

Teach "multi-pack-index verify" to handle cases where the number of
packfiles exceeds the open file handle limit.

The first commit fixes a problem that prevented the LRU-style
close_one_pack() mechanism from working which caused midx verify to run out
of file descriptors.

The second commit teaches midx verify to sort the set of objects to verify
by packfile rather than verifying them in OID order. This eliminates the
need to have more than one packfile/idx open at the same time.

With the second commit, runtime on 3600 packfiles went from 12 minutes to 25
seconds.

Thanks, Jeff

Cc: dstolee@microsoft.com

Jeff Hostetler (4):
  progress: add sparse mode to force 100% complete message
  trace2:data: add trace2 data to midx
  midx: verify: add midx packfiles to the packed_git list
  midx: verify: group objects by packfile to speed up object
    verification

 builtin/multi-pack-index.c |  3 ++
 midx.c                     | 84 +++++++++++++++++++++++++++++++++++---
 packfile.c                 |  2 +-
 packfile.h                 |  2 +
 progress.c                 | 40 ++++++++++++++++--
 progress.h                 |  3 ++
 6 files changed, 124 insertions(+), 10 deletions(-)


base-commit: e902e9bcae2010bc42648c80ab6adc6c5a16a4a5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-166%2Fjeffhostetler%2Fupstream-midx-verify-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-166/jeffhostetler/upstream-midx-verify-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/166

Range-diff vs v1:

 -:  ---------- > 1:  e1da1f84a8 progress: add sparse mode to force 100% complete message
 3:  2d23bc24b7 = 2:  11c88845e7 trace2:data: add trace2 data to midx
 1:  d1a730df94 = 3:  ced7f1cb34 midx: verify: add midx packfiles to the packed_git list
 2:  86f6b03258 ! 4:  e2dd99911f midx: verify: group objects by packfile to speed up object verification
     @@ -31,13 +31,20 @@
      +	struct pair_pos_vs_id *a = (struct pair_pos_vs_id *)_a;
      +	struct pair_pos_vs_id *b = (struct pair_pos_vs_id *)_b;
      +
     -+	if (a->pack_int_id < b->pack_int_id)
     -+		return -1;
     -+	if (a->pack_int_id > b->pack_int_id)
     -+		return 1;
     -+
     -+	return 0;
     ++	return b->pack_int_id - a->pack_int_id;
      +}
     ++
     ++/*
     ++ * Limit calls to display_progress() for performance reasons.
     ++ * The interval here was arbitrarily chosen.
     ++ */
     ++#define SPARSE_PROGRESS_INTERVAL (1 << 12)
     ++#define midx_display_sparse_progress(progress, n) \
     ++	do { \
     ++		uint64_t _n = (n); \
     ++		if ((_n & (SPARSE_PROGRESS_INTERVAL - 1)) == 0)	\
     ++			display_progress(progress, _n); \
     ++	} while (0)
      +
       int verify_midx_file(const char *object_dir)
       {
     @@ -48,10 +55,43 @@
       	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
       	verify_midx_error = 0;
      @@
     + 	if (!m)
     + 		return 0;
     + 
     ++	progress = start_progress(_("Looking for referenced packfiles"),
     ++				  m->num_packs);
     + 	for (i = 0; i < m->num_packs; i++) {
     + 		if (prepare_midx_pack(m, i))
     + 			midx_report("failed to load pack in position %d", i);
     + 
     + 		if (m->packs[i])
     + 			install_packed_git(the_repository, m->packs[i]);
     ++
     ++		display_progress(progress, i + 1);
     + 	}
     ++	stop_progress(&progress);
     + 
     + 	for (i = 0; i < 255; i++) {
     + 		uint32_t oid_fanout1 = ntohl(m->chunk_oid_fanout[i]);
     +@@
     + 				    i, oid_fanout1, oid_fanout2, i + 1);
       	}
       
     - 	progress = start_progress(_("Verifying object offsets"), m->num_objects);
     ++	progress = start_sparse_progress(_("Verifying OID order in MIDX"),
     ++					 m->num_objects - 1);
     + 	for (i = 0; i < m->num_objects - 1; i++) {
     + 		struct object_id oid1, oid2;
     + 
     +@@
     + 		if (oidcmp(&oid1, &oid2) >= 0)
     + 			midx_report(_("oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"),
     + 				    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
      +
     ++		midx_display_sparse_progress(progress, i + 1);
     + 	}
     ++	stop_progress(&progress);
     + 
     +-	progress = start_progress(_("Verifying object offsets"), m->num_objects);
      +	/*
      +	 * Create an array mapping each object to its packfile id.  Sort it
      +	 * to group the objects by packfile.  Use this permutation to visit
     @@ -63,8 +103,15 @@
      +		pairs[i].pos = i;
      +		pairs[i].pack_int_id = nth_midxed_pack_int_id(m, i);
      +	}
     ++
     ++	progress = start_sparse_progress(
     ++		_("Sorting objects by packfile"), m->num_objects);
     ++	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
      +	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
     ++	stop_progress(&progress);
      +
     ++	progress = start_sparse_progress(_("Verifying object offsets"),
     ++					 m->num_objects);
      +	for (k = 0; k < m->num_objects; k++) {
       		struct object_id oid;
       		struct pack_entry e;
     @@ -94,7 +141,7 @@
      +				    pairs[k].pos, oid_to_hex(&oid), m_offset, p_offset);
       
      -		display_progress(progress, i + 1);
     -+		display_progress(progress, k + 1);
     ++		midx_display_sparse_progress(progress, k + 1);
       	}
       	stop_progress(&progress);
       

-- 
gitgitgadget
