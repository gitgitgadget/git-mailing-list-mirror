Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17D661F453
	for <e@80x24.org>; Sat, 27 Oct 2018 17:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeJ1CMB (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 22:12:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40953 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbeJ1CMB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 22:12:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so4013712lji.7
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6xDyapWfwoqfEqSfPJe6Xohq4fxEOPqfhDua9vHp/Eg=;
        b=c+O+a5LFd7eD8Ce4+XJS15RNNebsdzuq07twsn7R4XkwPI7gTt4KcMp1kXZvh9X5UA
         h1PZflgOigWgAHxg+7j83E3izNQMrY3Djh+XsmNRpn3kUa+0GvEgNdJYCD5JkOtABi5S
         GyfAXnH1z6og1uusWPTQ1Be1h7tLy+t7ZWIAAcQ7jutRP57B9+L4rqjmmkezTiaknFsi
         YluvXzEepbWnvVg+U3ZoM+PcaFxPH8v3UdmT5pWmzUhEnIgHeOIFWcS1pBL+YNtJXiOA
         9C6uV/rFYpDclmGDno609a2YweRbqUYo+UZQHc9PIaVABJYTt5ebFxzvOagbsXJC4zZ4
         eJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xDyapWfwoqfEqSfPJe6Xohq4fxEOPqfhDua9vHp/Eg=;
        b=sx5y1J8tg5WEBXdOlsnug+nef9hY+oWqroF0yqhiPPxNJUcUAwKNB04vN6+ItfsWdr
         OqwnsD8+WHZ/walXCFaGHHNiyyNA9ZjPvDgcolK9AocLft+5TAb09ToU/19JMf9WFAuO
         ae5a3Ls+f25oM+IZzN0a30WE3MCY+6wZDaZTWE/znh4R9TqdQs26UqfeG1+ewQRdgpem
         Y3sh/Kgtgg71c48+G1OUrqFSFLhSsZtrj3ZS3Q+FgY5NN83YMce22sKz4NEIStMNUP/g
         Z26qG+LX3WhnyUsJwvyu4ewJxR8ML65uptNMCXqikOghuWiJK2MKc3v0tKfbKopp1kET
         SIbg==
X-Gm-Message-State: AGRZ1gKY8u/7igAcrKpVdBoyV4OhOTReie+7Z5hQ7/SM+imhJ6sVcXKQ
        dBY10mtmnLxJM8dtiyn5gvI=
X-Google-Smtp-Source: AJdET5e2MvUDIanCB54kDAI9HTIqeYm88JX7a0M8Fx/y+5U4mjvdkww298XtnuuaSjoKqO/PckASdg==
X-Received: by 2002:a2e:84c5:: with SMTP id q5-v6mr5067637ljh.65.1540661418467;
        Sat, 27 Oct 2018 10:30:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i185-v6sm2333517lfg.89.2018.10.27.10.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 10:30:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v2 02/10] index-pack: remove #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 19:30:00 +0200
Message-Id: <20181027173008.18852-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027173008.18852-1-pclouds@gmail.com>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027173008.18852-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/index-pack.c | 68 ++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 50 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2004e25da2..bbd66ca025 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -42,9 +42,7 @@ struct base_data {
 };
 
 struct thread_local {
-#ifndef NO_PTHREADS
 	pthread_t thread;
-#endif
 	struct base_data *base_cache;
 	size_t base_cache_used;
 	int pack_fd;
@@ -98,8 +96,6 @@ static uint32_t input_crc32;
 static int input_fd, output_fd;
 static const char *curr_pack;
 
-#ifndef NO_PTHREADS
-
 static struct thread_local *thread_data;
 static int nr_dispatched;
 static int threads_active;
@@ -179,26 +175,6 @@ static void cleanup_thread(void)
 	free(thread_data);
 }
 
-#else
-
-#define read_lock()
-#define read_unlock()
-
-#define counter_lock()
-#define counter_unlock()
-
-#define work_lock()
-#define work_unlock()
-
-#define deepest_delta_lock()
-#define deepest_delta_unlock()
-
-#define type_cas_lock()
-#define type_cas_unlock()
-
-#endif
-
-
 static int mark_link(struct object *obj, int type, void *data, struct fsck_options *options)
 {
 	if (!obj)
@@ -364,22 +340,20 @@ static NORETURN void bad_object(off_t offset, const char *format, ...)
 
 static inline struct thread_local *get_thread_data(void)
 {
-#ifndef NO_PTHREADS
-	if (threads_active)
-		return pthread_getspecific(key);
-	assert(!threads_active &&
-	       "This should only be reached when all threads are gone");
-#endif
+	if (HAVE_THREADS) {
+		if (threads_active)
+			return pthread_getspecific(key);
+		assert(!threads_active &&
+		       "This should only be reached when all threads are gone");
+	}
 	return &nothread_data;
 }
 
-#ifndef NO_PTHREADS
 static void set_thread_data(struct thread_local *data)
 {
 	if (threads_active)
 		pthread_setspecific(key, data);
 }
-#endif
 
 static struct base_data *alloc_base_data(void)
 {
@@ -1092,7 +1066,6 @@ static void resolve_base(struct object_entry *obj)
 	find_unresolved_deltas(base_obj);
 }
 
-#ifndef NO_PTHREADS
 static void *threaded_second_pass(void *data)
 {
 	set_thread_data(data);
@@ -1116,7 +1089,6 @@ static void *threaded_second_pass(void *data)
 	}
 	return NULL;
 }
-#endif
 
 /*
  * First pass:
@@ -1213,7 +1185,6 @@ static void resolve_deltas(void)
 		progress = start_progress(_("Resolving deltas"),
 					  nr_ref_deltas + nr_ofs_deltas);
 
-#ifndef NO_PTHREADS
 	nr_dispatched = 0;
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
 		init_thread();
@@ -1229,7 +1200,6 @@ static void resolve_deltas(void)
 		cleanup_thread();
 		return;
 	}
-#endif
 
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
@@ -1531,11 +1501,11 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 		if (nr_threads < 0)
 			die(_("invalid number of threads specified (%d)"),
 			    nr_threads);
-#ifdef NO_PTHREADS
-		if (nr_threads != 1)
-			warning(_("no threads support, ignoring %s"), k);
-		nr_threads = 1;
-#endif
+		if (!HAVE_THREADS) {
+			if (nr_threads != 1)
+				warning(_("no threads support, ignoring %s"), k);
+			nr_threads = 1;
+		}
 		return 0;
 	}
 	return git_default_config(k, v, cb);
@@ -1723,12 +1693,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				nr_threads = strtoul(arg+10, &end, 0);
 				if (!arg[10] || *end || nr_threads < 0)
 					usage(index_pack_usage);
-#ifdef NO_PTHREADS
-				if (nr_threads != 1)
-					warning(_("no threads support, "
-						  "ignoring %s"), arg);
-				nr_threads = 1;
-#endif
+				if (!HAVE_THREADS) {
+					if (nr_threads != 1)
+						warning(_("no threads support, "
+							  "ignoring %s"), arg);
+					nr_threads = 1;
+				}
 			} else if (starts_with(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
@@ -1791,14 +1761,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (strict)
 		opts.flags |= WRITE_IDX_STRICT;
 
-#ifndef NO_PTHREADS
-	if (!nr_threads) {
+	if (HAVE_THREADS && !nr_threads) {
 		nr_threads = online_cpus();
 		/* An experiment showed that more threads does not mean faster */
 		if (nr_threads > 3)
 			nr_threads = 3;
 	}
-#endif
 
 	curr_pack = open_pack_file(pack_name);
 	parse_pack_header();
-- 
2.19.1.647.g708186aaf9

