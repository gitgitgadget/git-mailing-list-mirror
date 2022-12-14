Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FFCC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 15:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiLNPfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 10:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiLNPfb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 10:35:31 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3A362CB
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 07:35:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id co23so106183wrb.4
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 07:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d4/MQRVeSnATP49koDSvc91BhO1AfbtZd496MNWqNNo=;
        b=YZNyQJNYW7hyuOYIB/XLkL3vfQ3R8nzd6GT1jWew2x2LBwx5zCl7UreRsu8mVTKEYG
         vaZCPUnt2Tse34+F/TCkhfuD07nMnn9RHAEHHuA3zAYdzpMrKbYMYmBvR1KaNxLpEnTz
         tuAwCldX3zUOd4kw6yOvHcq6NhMwxgTzx+QST2Ri1creTBxORhYD8gOuJfhXRy+adbLT
         xQ/On1alyj8S/HqQFaOxUj8R4uXWQpmiEEgLv+ozebPUofJUMvVf7hBDXfASVzk9q12v
         +vGaKVhoHbeUQIwYQXMsmkIqLFOdw+b+PozfW0dXq7XPCed71yPgTaPILe/CSM83wWyC
         gsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4/MQRVeSnATP49koDSvc91BhO1AfbtZd496MNWqNNo=;
        b=ydW7CAhOizPJr2cOtQkE1twfJ4Ln8PXUyQOoWJVZD4/+ilarhuw2gVqLvpWgx2uUNC
         sUO3XrqVj/lDN6ZEVc0BDl9PZbrLmRatm8lVOxjhH2SZHWZeSkHpGh1pKTZFmFlIU6Q4
         qzXEB/x1zQo5gigSikwwP3IkWy0/542e1Z8TVe+WMdPP3GAAy/X/8TUV62mbVvf4m9sV
         ar5OzTPOlR9kDyFtOu3SJZykEvA7Yun9xLpGKQsPkqMiw+EI+e5NkYVlIrW+vRGZQCyq
         y6Xm8gG1HACze+oawFyUxw0ZxWnL0VpMbqWLYap0ZAs+hClBx3mKzeNi9vlsreA05Fl5
         c8LA==
X-Gm-Message-State: ANoB5plQcRduveW6r29P7hVEMzXnlqUdsMxDX//WxQHTionBYfWNFTfs
        5D3Cv2fLj+U9t4Gj6g8VftoElIm0qMA=
X-Google-Smtp-Source: AA0mqf45ACgCL+zLvRPC7mmEHVUXwZ+7x2h/jBTgDG3vC7E2YJSarw201fbvUx7XNBy/kfPMHX+hMQ==
X-Received: by 2002:adf:f0d1:0:b0:24e:f72a:4285 with SMTP id x17-20020adff0d1000000b0024ef72a4285mr7614349wro.24.1671032127779;
        Wed, 14 Dec 2022 07:35:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k24-20020adfd238000000b002420fe50322sm3173954wrh.91.2022.12.14.07.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 07:35:27 -0800 (PST)
Message-Id: <pull.1396.git.git.1671032126602.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Dec 2022 15:35:26 +0000
Subject: [PATCH] git: remove unneeded casts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Many of these casts remain,
even though the target variable is the type it is being casted to.
We can safely remove said casts.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: remove unneeded casts
    
    Many of these casts remain, even though the target variable is the type
    it is being casted to. We can safely remove said casts.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1396%2FAtariDreams%2Ffix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1396/AtariDreams/fix-v1
Pull-Request: https://github.com/git/git/pull/1396

 builtin/credential-store.c    |  2 +-
 diff.c                        |  8 ++++----
 http.c                        |  4 ++--
 imap-send.c                   |  5 +++--
 merge-ort.c                   |  2 +-
 oidmap.h                      |  2 +-
 pack-revindex.c               |  3 ++-
 read-cache.c                  |  2 +-
 ref-filter.c                  |  2 +-
 strbuf.c                      |  2 +-
 t/helper/test-parse-options.c |  2 +-
 t/helper/test-path-utils.c    |  8 ++++++--
 t/helper/test-run-command.c   | 10 +++++-----
 t/helper/test-subprocess.c    |  2 +-
 thread-utils.c                |  2 +-
 xdiff/xprepare.c              |  2 +-
 xdiff/xutils.c                |  2 +-
 17 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 62a4f3c2653..93e521af395 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -165,7 +165,7 @@ int cmd_credential_store(int argc, const char **argv, const char *prefix)
 
 	umask(077);
 
-	argc = parse_options(argc, (const char **)argv, prefix, options, usage, 0);
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (argc != 1)
 		usage_with_options(usage, options);
 	op = argv[0];
diff --git a/diff.c b/diff.c
index 1054a4b7329..2e58c9372b4 100644
--- a/diff.c
+++ b/diff.c
@@ -1776,8 +1776,8 @@ static void emit_rewrite_diff(const char *name_a,
 	ecbdata.opt = o;
 	if (ecbdata.ws_rule & WS_BLANK_AT_EOF) {
 		mmfile_t mf1, mf2;
-		mf1.ptr = (char *)data_one;
-		mf2.ptr = (char *)data_two;
+		mf1.ptr = data_one;
+		mf2.ptr = data_two;
 		mf1.size = size_one;
 		mf2.size = size_two;
 		check_blank_at_eof(&mf1, &mf2, &ecbdata);
@@ -1809,9 +1809,9 @@ static void emit_rewrite_diff(const char *name_a,
 	if (lc_b)
 		emit_rewrite_lines(&ecbdata, '+', data_two, size_two);
 	if (textconv_one)
-		free((char *)data_one);
+		free(data_one);
 	if (textconv_two)
-		free((char *)data_two);
+		free(data_two);
 }
 
 struct diff_words_buffer {
diff --git a/http.c b/http.c
index 8a5ba3f4776..32db5d76a7c 100644
--- a/http.c
+++ b/http.c
@@ -2319,8 +2319,8 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 	}
 
 	do {
-		ssize_t retval = xwrite(freq->localfile,
-					(char *) ptr + posn, size - posn);
+		ssize_t retval =
+			xwrite(freq->localfile, ptr + posn, size - posn);
 		if (retval < 0)
 			return posn / eltsize;
 		posn += retval;
diff --git a/imap-send.c b/imap-send.c
index a50af56b827..e67dbfc5567 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -779,7 +779,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 			if (cmdp->cb.data) {
 				n = socket_write(&imap->buf.sock, cmdp->cb.data, cmdp->cb.dlen);
 				FREE_AND_NULL(cmdp->cb.data);
-				if (n != (int)cmdp->cb.dlen)
+				if (n != cmdp->cb.dlen)
 					return RESP_BAD;
 			} else if (cmdp->cb.cont) {
 				if (cmdp->cb.cont(ctx, cmdp, cmd))
@@ -1526,7 +1526,8 @@ int cmd_main(int argc, const char **argv)
 	setup_git_directory_gently(&nongit_ok);
 	git_config(git_imap_config, NULL);
 
-	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
+	argc = parse_options(argc, argv, "", imap_send_options, imap_send_usage,
+			     0);
 
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
diff --git a/merge-ort.c b/merge-ort.c
index d1611ca400a..a2aefd609ad 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2574,7 +2574,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 
 	/* Find parent directories missing from opt->priv->paths */
 	cur_path = mem_pool_strdup(&opt->priv->pool, new_path);
-	free((char*)new_path);
+	free(new_path);
 	new_path = (char *)cur_path;
 
 	while (1) {
diff --git a/oidmap.h b/oidmap.h
index c66a83ab1d6..9cefbba550d 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -87,7 +87,7 @@ static inline void *oidmap_iter_first(struct oidmap *map,
 {
 	oidmap_iter_init(map, iter);
 	/* TODO: this API could be reworked to do compile-time type checks */
-	return (void *)oidmap_iter_next(iter);
+	return oidmap_iter_next(iter);
 }
 
 #endif
diff --git a/pack-revindex.c b/pack-revindex.c
index 08dc1601679..fa897b54584 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -428,7 +428,8 @@ static int midx_pack_order_cmp(const void *va, const void *vb)
 	const struct midx_pack_key *key = va;
 	struct multi_pack_index *midx = key->midx;
 
-	uint32_t versus = pack_pos_to_midx(midx, (uint32_t*)vb - (const uint32_t *)midx->revindex_data);
+	uint32_t versus =
+		pack_pos_to_midx(midx, (uint32_t *)vb - midx->revindex_data);
 	uint32_t versus_pack = nth_midxed_pack_int_id(midx, versus);
 	off_t versus_offset;
 
diff --git a/read-cache.c b/read-cache.c
index 1ff518b2a7f..f4c4cc63dc4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3022,7 +3022,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 			offset = hashfile_total(f);
 		}
-		if (ce_write_entry(f, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
+		if (ce_write_entry(f, ce, previous_name, &ondisk) < 0)
 			err = -1;
 
 		if (err)
diff --git a/ref-filter.c b/ref-filter.c
index caf10ab23eb..e5993f7cc43 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -396,7 +396,7 @@ static int trailers_atom_parser(struct ref_format *format, struct used_atom *ato
 				strbuf_addf(err, _("expected %%(trailers:key=<value>)"));
 			else
 				strbuf_addf(err, _("unknown %%(trailers) argument: %s"), invalid_arg);
-			free((char *)invalid_arg);
+			free(invalid_arg);
 			return -1;
 		}
 	}
diff --git a/strbuf.c b/strbuf.c
index 0890b1405c5..940f59473eb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -493,7 +493,7 @@ void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags)
 		if (ch <= 0x1F || ch >= 0x7F ||
 		    (ch == '/' && (flags & STRBUF_ENCODE_SLASH)) ||
 		    strchr(URL_UNSAFE_CHARS, ch))
-			strbuf_addf(dst, "%%%02X", (unsigned char)ch);
+			strbuf_addf(dst, "%%%02X", ch);
 		else
 			strbuf_addch(dst, ch);
 	}
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 506835521a4..a788196adf5 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -161,7 +161,7 @@ int cmd__parse_options(int argc, const char **argv)
 
 	trace2_cmd_name("_parse_");
 
-	argc = parse_options(argc, (const char **)argv, prefix, options, usage, 0);
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (length_cb.called) {
 		const char *arg = length_cb.arg;
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index f69709d674f..eb7a204f3b7 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -276,13 +276,17 @@ static int protect_ntfs_hfs_benchmark(int argc, const char **argv)
 				for (j = 0; j < nr; j++)
 					verify_path(names[j], file_mode);
 				end = getnanotime();
-				printf("protect_ntfs = %d, protect_hfs = %d: %lfms\n", protect_ntfs, protect_hfs, (end-begin) / (double)1e6);
+				printf("protect_ntfs = %d, protect_hfs = %d: %lfms\n",
+				       protect_ntfs, protect_hfs,
+				       (end - begin) / 1e6);
 				cumul += end - begin;
 				cumul2 += (end - begin) * (end - begin);
 			}
 			m[protect_ntfs][protect_hfs] = cumul / (double)repetitions;
 			v[protect_ntfs][protect_hfs] = my_sqrt(cumul2 / (double)repetitions - m[protect_ntfs][protect_hfs] * m[protect_ntfs][protect_hfs]);
-			printf("mean: %lfms, stddev: %lfms\n", m[protect_ntfs][protect_hfs] / (double)1e6, v[protect_ntfs][protect_hfs] / (double)1e6);
+			printf("mean: %lfms, stddev: %lfms\n",
+			       m[protect_ntfs][protect_hfs] / 1e6,
+			       v[protect_ntfs][protect_hfs] / 1e6);
 		}
 
 	for (protect_ntfs = 0; protect_ntfs < 2; protect_ntfs++)
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 3ecb830f4a8..eadde7c47b1 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -312,8 +312,8 @@ static int quote_stress_test(int argc, const char **argv)
 		if (ret) {
 			fprintf(stderr, "Trial #%d failed. Arguments:\n", i);
 			for (j = 0; j < arg_count; j++)
-				fprintf(stderr, "arg #%d: '%s'\n",
-					(int)j, args.v[j + arg_offset]);
+				fprintf(stderr, "arg #%d: '%s'\n", j,
+					args.v[j + arg_offset]);
 
 			strbuf_release(&out);
 			strvec_clear(&args);
@@ -322,7 +322,7 @@ static int quote_stress_test(int argc, const char **argv)
 		}
 
 		if (i && (i % 100) == 0)
-			fprintf(stderr, "Trials completed: %d\n", (int)i);
+			fprintf(stderr, "Trials completed: %d\n", i);
 	}
 
 	strbuf_release(&out);
@@ -418,7 +418,7 @@ int cmd__run_command(int argc, const char **argv)
 		ret = 1;
 		goto cleanup;
 	}
-	strvec_pushv(&proc.args, (const char **)argv + 2);
+	strvec_pushv(&proc.args, argv + 2);
 
 	if (!strcmp(argv[1], "start-command-ENOENT")) {
 		if (start_command(&proc) < 0 && errno == ENOENT) {
@@ -441,7 +441,7 @@ int cmd__run_command(int argc, const char **argv)
 
 	jobs = atoi(argv[2]);
 	strvec_clear(&proc.args);
-	strvec_pushv(&proc.args, (const char **)argv + 3);
+	strvec_pushv(&proc.args, argv + 3);
 
 	if (!strcmp(argv[1], "run-command-parallel")) {
 		opts.get_next_task = parallel_next;
diff --git a/t/helper/test-subprocess.c b/t/helper/test-subprocess.c
index ff22f2fa2c5..32a5b339eae 100644
--- a/t/helper/test-subprocess.c
+++ b/t/helper/test-subprocess.c
@@ -15,6 +15,6 @@ int cmd__subprocess(int argc, const char **argv)
 		argv++;
 	}
 	cp.git_cmd = 1;
-	strvec_pushv(&cp.args, (const char **)argv + 1);
+	strvec_pushv(&cp.args, argv + 1);
 	return run_command(&cp);
 }
diff --git a/thread-utils.c b/thread-utils.c
index 53298456913..6d3de821473 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -57,7 +57,7 @@ int online_cpus(void)
 #endif /* defined(HAVE_BSD_SYSCTL) && defined(HW_NCPU) */
 
 #ifdef _SC_NPROCESSORS_ONLN
-	if ((ncpus = (long)sysconf(_SC_NPROCESSORS_ONLN)) > 0)
+	if ((ncpus = sysconf(_SC_NPROCESSORS_ONLN)) > 0)
 		return (int)ncpus;
 #endif
 
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index c84549f6c50..04fa4e5a01d 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -188,7 +188,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
 				goto abort;
 			crec->ptr = prev;
-			crec->size = (long) (cur - prev);
+			crec->size = (cur - prev);
 			crec->ha = hav;
 			recs[nrec++] = crec;
 			if (xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 9e36f24875d..853f2260a1d 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -130,7 +130,7 @@ long xdl_guess_lines(mmfile_t *mf, long sample) {
 			else
 				cur++;
 		}
-		tsize += (long) (cur - data);
+		tsize += (cur - data);
 	}
 
 	if (nl && tsize)

base-commit: 57e2c6ebbe7108b35ba30184dcbcb6c34c929ad8
-- 
gitgitgadget
