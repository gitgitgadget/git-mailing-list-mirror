Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D78CF20248
	for <e@80x24.org>; Thu, 21 Mar 2019 19:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfCUTgP (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 15:36:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44689 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfCUTgP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 15:36:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id x10so5993583edh.11
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 12:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1BAJ1dWiMNR9FfM4UFvqm0+O42wpLuK7jA9Ou1q51zc=;
        b=YkIgHAxByh8NQVgB1wp+bjPVrDV/D3aWe9lnlrtmjhfxw2RTYBql3UQjvRQNXe3b5x
         jGJ+1kGG8CTfVlXPPLjUDSxBmpe931Dp//hLqPcYWSlgzznIYaEPoZq5XTWE3hAWvH9L
         s2tko6sp+leqxXZidr0mcpy+0PhlK42GTg63Cupe21bjKYaOtTMTeWLUOZo2RLTiMNWT
         qJ7Y9EKwM0QWa03ccM6EIdXEig8wx9v0nPStVqaaSusM7rhDu0RnObyzHQSbXb3PKFST
         BZMbMVu0J4RsPwZTBUIu3bu6tdrNzOI6t7HOJAQGZMBKwoZmSend37t2wrJ1Og8WxLrx
         V/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1BAJ1dWiMNR9FfM4UFvqm0+O42wpLuK7jA9Ou1q51zc=;
        b=sNNiw+B0uhCU6i9GkqX6n9XEXI1HgHaujGibkuqYT7UIm0ElEl9lMNY8Ky0S5gnU0h
         Lgq9nlGyU8D/IfqEbLNL4PYcDkibcfuj5Pw8tTe0ec06tOjv3cfNpaZndT+WnhyoA81V
         dtJ+LVIegRIHMkhoFsurciDguMEyAOxG92BShy9pfceUKPfnj2g9blVDlDBWm1cd+sNU
         8+7NwBpaLiF/8ri4dg/yTTpRh0+1ye+htqExcRNUuu67CmSLkmhlwq1SnsbxW1SsT/jJ
         c4W32GY4OWtPhUfydxtWpX9FwU6iYxpbnn9dMiw+tHnTsX2WeY32AULQ+V41OS4TyU7V
         UHsg==
X-Gm-Message-State: APjAAAVIFn/Tz1OSEwFUlY1fN4B2rxVmKctNgs+CYFiacdD2t34YhwMm
        lO+UO/eTo+3i7+udvtTiUQ0eMUNr
X-Google-Smtp-Source: APXvYqwbbyTs/mOn3mwsalYlMs9dKRPkZM8IEiqmwdoIGY1jx6M4A6Ws4T8GhOpKyfye7ppP/obJDQ==
X-Received: by 2002:a50:95fa:: with SMTP id x55mr3377819eda.49.1553196971680;
        Thu, 21 Mar 2019 12:36:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm1237658ejk.38.2019.03.21.12.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 12:36:11 -0700 (PDT)
Date:   Thu, 21 Mar 2019 12:36:11 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Mar 2019 19:36:06 GMT
Message-Id: <pull.166.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.166.v2.git.gitgitgadget@gmail.com>
References: <pull.166.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/4] multi-pack-index: fix verify on large repos
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

Version 3 drops the packed-git commit I mentioned earlier, simplifies the
finish_if_sparse API as suggested by Eric, and splits the object sort commit
into 2 commits: one to add the additional progress indicators and one to
sort the objects by packfile. This makes it easier to follow.


----------------------------------------------------------------------------

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
  midx: add progress indicators in multi-pack-index verify
  midx: during verify group objects by packfile to speed verification

 builtin/multi-pack-index.c |  3 ++
 midx.c                     | 79 +++++++++++++++++++++++++++++++++++---
 packfile.c                 |  2 +-
 packfile.h                 |  2 +
 progress.c                 | 38 ++++++++++++++++--
 progress.h                 |  3 ++
 6 files changed, 118 insertions(+), 9 deletions(-)


base-commit: e902e9bcae2010bc42648c80ab6adc6c5a16a4a5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-166%2Fjeffhostetler%2Fupstream-midx-verify-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-166/jeffhostetler/upstream-midx-verify-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/166

Range-diff vs v2:

 1:  e1da1f84a8 ! 1:  5595e019c8 progress: add sparse mode to force 100% complete message
     @@ -80,10 +80,8 @@
      +	return start_progress_delay(title, total, 2, 1);
      +}
      +
     -+static void finish_if_sparse(struct progress **p_progress)
     ++static void finish_if_sparse(struct progress *progress)
      +{
     -+	struct progress *progress = *p_progress;
     -+
      +	if (progress &&
      +	    progress->sparse &&
      +	    progress->last_value != progress->total)
     @@ -92,7 +90,7 @@
       
       void stop_progress(struct progress **p_progress)
       {
     -+	finish_if_sparse(p_progress);
     ++	finish_if_sparse(*p_progress);
      +
       	stop_progress_msg(p_progress, _("done"));
       }
 2:  11c88845e7 = 2:  498258b120 trace2:data: add trace2 data to midx
 3:  ced7f1cb34 < -:  ---------- midx: verify: add midx packfiles to the packed_git list
 -:  ---------- > 3:  8a60902d65 midx: add progress indicators in multi-pack-index verify
 4:  e2dd99911f ! 4:  7e98ea005a midx: verify: group objects by packfile to speed up object verification
     @@ -1,8 +1,8 @@
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
     -    midx: verify: group objects by packfile to speed up object verification
     +    midx: during verify group objects by packfile to speed verification
      
     -    Teach `multi-pack-index verify` to sort the set of objects by
     +    Teach `multi-pack-index verify` to sort the set of object by
          packfile so that only one packfile needs to be open at a time.
      
          This is a performance improvement.  Previously, objects were
     @@ -34,64 +34,21 @@
      +	return b->pack_int_id - a->pack_int_id;
      +}
      +
     -+/*
     -+ * Limit calls to display_progress() for performance reasons.
     -+ * The interval here was arbitrarily chosen.
     -+ */
     -+#define SPARSE_PROGRESS_INTERVAL (1 << 12)
     -+#define midx_display_sparse_progress(progress, n) \
     -+	do { \
     -+		uint64_t _n = (n); \
     -+		if ((_n & (SPARSE_PROGRESS_INTERVAL - 1)) == 0)	\
     -+			display_progress(progress, _n); \
     -+	} while (0)
     -+
     + /*
     +  * Limit calls to display_progress() for performance reasons.
     +  * The interval here was arbitrarily chosen.
     +@@
     + 
       int verify_midx_file(const char *object_dir)
       {
     --	uint32_t i;
      +	struct pair_pos_vs_id *pairs = NULL;
     -+	uint32_t i, k;
     + 	uint32_t i;
       	struct progress *progress;
       	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
     - 	verify_midx_error = 0;
     -@@
     - 	if (!m)
     - 		return 0;
     - 
     -+	progress = start_progress(_("Looking for referenced packfiles"),
     -+				  m->num_packs);
     - 	for (i = 0; i < m->num_packs; i++) {
     - 		if (prepare_midx_pack(m, i))
     - 			midx_report("failed to load pack in position %d", i);
     - 
     - 		if (m->packs[i])
     - 			install_packed_git(the_repository, m->packs[i]);
     -+
     -+		display_progress(progress, i + 1);
     - 	}
     -+	stop_progress(&progress);
     - 
     - 	for (i = 0; i < 255; i++) {
     - 		uint32_t oid_fanout1 = ntohl(m->chunk_oid_fanout[i]);
      @@
     - 				    i, oid_fanout1, oid_fanout2, i + 1);
       	}
     + 	stop_progress(&progress);
       
     -+	progress = start_sparse_progress(_("Verifying OID order in MIDX"),
     -+					 m->num_objects - 1);
     - 	for (i = 0; i < m->num_objects - 1; i++) {
     - 		struct object_id oid1, oid2;
     - 
     -@@
     - 		if (oidcmp(&oid1, &oid2) >= 0)
     - 			midx_report(_("oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"),
     - 				    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
     -+
     -+		midx_display_sparse_progress(progress, i + 1);
     - 	}
     -+	stop_progress(&progress);
     - 
     --	progress = start_progress(_("Verifying object offsets"), m->num_objects);
      +	/*
      +	 * Create an array mapping each object to its packfile id.  Sort it
      +	 * to group the objects by packfile.  Use this permutation to visit
     @@ -99,37 +56,37 @@
      +	 * time.
      +	 */
      +	ALLOC_ARRAY(pairs, m->num_objects);
     - 	for (i = 0; i < m->num_objects; i++) {
     ++	for (i = 0; i < m->num_objects; i++) {
      +		pairs[i].pos = i;
      +		pairs[i].pack_int_id = nth_midxed_pack_int_id(m, i);
      +	}
      +
     -+	progress = start_sparse_progress(
     -+		_("Sorting objects by packfile"), m->num_objects);
     ++	progress = start_sparse_progress(_("Sorting objects by packfile"),
     ++					 m->num_objects);
      +	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
      +	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
      +	stop_progress(&progress);
      +
     -+	progress = start_sparse_progress(_("Verifying object offsets"),
     -+					 m->num_objects);
     -+	for (k = 0; k < m->num_objects; k++) {
     + 	progress = start_sparse_progress(_("Verifying object offsets"), m->num_objects);
     + 	for (i = 0; i < m->num_objects; i++) {
       		struct object_id oid;
       		struct pack_entry e;
       		off_t m_offset, p_offset;
       
      -		nth_midxed_object_oid(&oid, m, i);
     -+		if (k > 0 && pairs[k-1].pack_int_id != pairs[k].pack_int_id &&
     -+		    m->packs[pairs[k-1].pack_int_id])
     ++		if (i > 0 && pairs[i-1].pack_int_id != pairs[i].pack_int_id &&
     ++		    m->packs[pairs[i-1].pack_int_id])
      +		{
     -+			close_pack_fd(m->packs[pairs[k-1].pack_int_id]);
     -+			close_pack_index(m->packs[pairs[k-1].pack_int_id]);
     ++			close_pack_fd(m->packs[pairs[i-1].pack_int_id]);
     ++			close_pack_index(m->packs[pairs[i-1].pack_int_id]);
      +		}
      +
     -+		nth_midxed_object_oid(&oid, m, pairs[k].pos);
     ++		nth_midxed_object_oid(&oid, m, pairs[i].pos);
     ++
       		if (!fill_midx_entry(&oid, &e, m)) {
       			midx_report(_("failed to load pack entry for oid[%d] = %s"),
      -				    i, oid_to_hex(&oid));
     -+				    pairs[k].pos, oid_to_hex(&oid));
     ++				    pairs[i].pos, oid_to_hex(&oid));
       			continue;
       		}
       
     @@ -138,10 +95,9 @@
       		if (m_offset != p_offset)
       			midx_report(_("incorrect object offset for oid[%d] = %s: %"PRIx64" != %"PRIx64),
      -				    i, oid_to_hex(&oid), m_offset, p_offset);
     -+				    pairs[k].pos, oid_to_hex(&oid), m_offset, p_offset);
     ++				    pairs[i].pos, oid_to_hex(&oid), m_offset, p_offset);
       
     --		display_progress(progress, i + 1);
     -+		midx_display_sparse_progress(progress, k + 1);
     + 		midx_display_sparse_progress(progress, i + 1);
       	}
       	stop_progress(&progress);
       

-- 
gitgitgadget
