Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669C3C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 17:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiGRRAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 13:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbiGRRAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 13:00:32 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6332B19A
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 10:00:31 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 64-20020a621643000000b0052b51cf6b2aso697524pfw.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J8syxYIygx+y/CTsfqy2MONsgf4cpgTz1E53anGIwuw=;
        b=cSzIvw2C5GnV+QrEi4DY1V+XfpDY2oIDTuJCb+UaXsNlrHsCPPqJQw/+Vbgd52VtKd
         1j3TmDAODOMoZDW2h6hqcOp6CVZj5Bmt8ByHUWSZ+n9Ns9OyMwuPkc+TDbVDrXy+A3dd
         P7Gb8tsXS4Wle7bSMwCd2Yn7qGiO4pKI7yIFjZCDTG+mqifCJdYiRjzzv4K52FhoaoJC
         j33UeGlvKCGwkbp7BsCz55ra//nKv0tOX9CHMOKHSmDqN0SMPOGXaHAkpaZE3RLqxLYW
         4X4X7KbKLUKp7fWpG1cj6R7bz+90Aqe1RfHrcMYCRDHKlUwVlXzuw0CfhM2N82wVeAC5
         IhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J8syxYIygx+y/CTsfqy2MONsgf4cpgTz1E53anGIwuw=;
        b=EhFUWersqsJgqbMVDVEmWTfDK0q/hMpQG+bMg5uhKvuJr2lmc2RaiwucXOhJt7o/KI
         8PxjRBDFC4q27+bfaNjViLZZEDoHobG5xjcsSS9+nIqjsUOzu+cauYQ6C7A1cJvcPnMg
         euwnR20KU1tCsHqoPwUw7XSwsreQvNDScqGVztfgtlPgXx99XScniX1MUfvn2T8jNFGk
         pZ5s5bubL/jGv0pFN3JALe47XdWfxDXf5z0FKl0w/EL6C7KXkA/IzC6GZpKtoc/mH++A
         i4YB8vBDQGFu++dzLZS3a19J1XEpAB/8f2SC/FePTMiabjF7aczIreM8aTDKdGvs1FA3
         834g==
X-Gm-Message-State: AJIora+uFRuGj20HTqUKHiSnI0WpgY7edcxAjrQfVCNQ5LpaPU3Na18U
        YTE2Hl0uvW/Eb3rPl22MlX7H3ak2AupG+OoOoC2wqmVyIZ87NMdXyLHaYb8IB4WkXdiX+fj/Hi2
        oFqVC+IJtcgpPedarwy41Qo75tU/XnKJ4b9GeSipqEMVBaZdBffYKIumG649xzcqpqUGb5aRp+i
        XE
X-Google-Smtp-Source: AGRyM1vv1BtZjqUF8+aqMwztNMGorjZdtiLWM0Ojb7dRmama0J/56PJ9xI9pnqhMg0YrBOflOirZR1fOyx/my/Y38beG
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:350b:b0:1f0:23d9:57eb with
 SMTP id ls11-20020a17090b350b00b001f023d957ebmr38905541pjb.17.1658163630938;
 Mon, 18 Jul 2022 10:00:30 -0700 (PDT)
Date:   Mon, 18 Jul 2022 10:00:27 -0700
In-Reply-To: <20220715172943.2681492-1-jonathantanmy@google.com>
Message-Id: <20220718170027.3993042-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20220715172943.2681492-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v2] fetch-pack: write effective filter to trace2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Administrators of a managed Git environment (like the one at $DAYJOB)
might want to quantify the performance change of fetches with and
without filters from the client's point of view, and also detect if a
server does not support it. Therefore, log the filter information being
sent to the server whenever a fetch (or clone) occurs. Note that this is
not necessarily the same as what's specified on the CLI, because during
a fetch, the configured filter is used whenever a filter is not
specified on the CLI.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks everyone for your comments. I've renamed the keys and
distinguished the case in which the server does not support filters
following Jeff's suggestions.

A few small discussion points:
 - whether we need the print_verbose now that we have traces
 - should we log if no filter is specified
 - if yes, what key should it be logged under (I used "filter/none" for
   now)
---
 fetch-pack.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index cb6647d657..68820f9a1a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -292,6 +292,29 @@ static void mark_tips(struct fetch_negotiator *negotiator,
 	return;
 }
 
+static void write_and_trace_filter(struct fetch_pack_args *args,
+				   struct strbuf *req_buf,
+				   int server_supports_filter)
+{
+	if (args->filter_options.choice) {
+		const char *spec =
+			expand_list_objects_filter_spec(&args->filter_options);
+		if (server_supports_filter) {
+			print_verbose(args, _("Server supports filter"));
+			packet_buf_write(req_buf, "filter %s", spec);
+			trace2_data_string("fetch", the_repository,
+					   "filter/effective", spec);
+		} else {
+			warning("filtering not recognized by server, ignoring");
+			trace2_data_string("fetch", the_repository,
+					   "filter/unsupported", spec);
+		}
+	} else {
+		trace2_data_string("fetch", the_repository,
+				   "filter/none", "");
+	}
+}
+
 static int find_common(struct fetch_negotiator *negotiator,
 		       struct fetch_pack_args *args,
 		       int fd[2], struct object_id *result_oid,
@@ -389,11 +412,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 			packet_buf_write(&req_buf, "deepen-not %s", s->string);
 		}
 	}
-	if (server_supports_filtering && args->filter_options.choice) {
-		const char *spec =
-			expand_list_objects_filter_spec(&args->filter_options);
-		packet_buf_write(&req_buf, "filter %s", spec);
-	}
+	write_and_trace_filter(args, &req_buf, server_supports_filtering);
 	packet_buf_flush(&req_buf);
 	state_len = req_buf.len;
 
@@ -1323,15 +1342,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		die(_("Server does not support shallow requests"));
 
 	/* Add filter */
-	if (server_supports_feature("fetch", "filter", 0) &&
-	    args->filter_options.choice) {
-		const char *spec =
-			expand_list_objects_filter_spec(&args->filter_options);
-		print_verbose(args, _("Server supports filter"));
-		packet_buf_write(&req_buf, "filter %s", spec);
-	} else if (args->filter_options.choice) {
-		warning("filtering not recognized by server, ignoring");
-	}
+	write_and_trace_filter(args, &req_buf,
+			       server_supports_feature("fetch", "filter", 0));
 
 	if (server_supports_feature("fetch", "packfile-uris", 0)) {
 		int i;
-- 
2.37.0.170.g444d1eabd0-goog

