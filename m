Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120F9207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 23:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999774AbdD1Xy0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 19:54:26 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33929 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1951458AbdD1XyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 19:54:16 -0400
Received: by mail-pf0-f169.google.com with SMTP id e64so17545211pfd.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 16:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yud+dx8ZGzLP/KtNm3r3oMmwGSiq4W9jGc20wb/6Leg=;
        b=fOlwIjGD1iiMYJpY6no+UwyidPHR0QUBSOajmbGtKvTPDLa4ZjRXb9853s2Vh18IIP
         0PbKDTr92HC3hDRuUhUet841WNwlWwsJvpakcpFU9ntaCgMTDkfPpiLxOB04W/UUdmMt
         Xo439SeNRGP0wXVNdAsoVJWpqho1t01qM7V/uPQKfjm4DU6qA5BY4q29aaMpTN6LM97+
         NU1rxcf7VXbH7847fg8wjwUKT+UbI6KElfeevBNlLVlHljMmk22cseQyb1WkZDcZ4UB9
         AuekAdv+KZIMn7zNv/XUkEYsczaRHeX6hTuO9fbf0wrjoaLSHsB/1Ubx34DAOBd3R0fR
         Qgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yud+dx8ZGzLP/KtNm3r3oMmwGSiq4W9jGc20wb/6Leg=;
        b=sHdkE2l2MgGcME/OORFkPv30GCKrzjUSCMz54mVnSMl/ya27XzTYzjxJfsyszevRVW
         AD00aavqhOY1GnObjynyFUh3oPs/7RempkO/XuxP5JiTdPppfYubawUPYqyGN1FjtECO
         GLrGMeHqTdSalUCmi/OfHG3jCqv5kstPepwxDhboc8FwQgKWzv7MBOxb1ppl4gXmjmfZ
         VLXLPCqgSoW+s5VS2cFq4Nb09AzwLf2+FCl6+Nj1qzXRypACPNH1HCrdwt5lmZuQCRKf
         GYCqWHFMN1UsN/60ZPMNcfLH/KKF8IVUYBaXWbycLNYaNxYL8R4EJ4XOvpRPG4k0ERfl
         mz5Q==
X-Gm-Message-State: AN3rC/6piY7nfnytOsPeutyx48NcRSRZI7gneQHGAL+yApHHdI/8iR52
        XlzpzfmrsQn1Q27w
X-Received: by 10.84.236.79 with SMTP id h15mr18354541pln.110.1493423655189;
        Fri, 28 Apr 2017 16:54:15 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 188sm5332429pfu.15.2017.04.28.16.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Apr 2017 16:54:14 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 3/6] submodule: remove add_oid_to_argv
Date:   Fri, 28 Apr 2017 16:53:59 -0700
Message-Id: <20170428235402.162251-4-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
In-Reply-To: <20170428235402.162251-1-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function 'add_oid_to_argv()' provides the same functionality as
'append_oid_to_argv()'.  Remove this duplicate function and instead use
'append_oid_to_argv()' where 'add_oid_to_argv()' was previously used.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/submodule.c b/submodule.c
index 46abd52b1..7baa28ae0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -970,12 +970,6 @@ void check_for_new_submodule_commits(struct object_id *oid)
 	oid_array_append(&ref_tips_after_fetch, oid);
 }
 
-static int add_oid_to_argv(const struct object_id *oid, void *data)
-{
-	argv_array_push(data, oid_to_hex(oid));
-	return 0;
-}
-
 static void calculate_changed_submodule_paths(void)
 {
 	struct rev_info rev;
@@ -989,10 +983,10 @@ static void calculate_changed_submodule_paths(void)
 	init_revisions(&rev, NULL);
 	argv_array_push(&argv, "--"); /* argv[0] program name */
 	oid_array_for_each_unique(&ref_tips_after_fetch,
-				   add_oid_to_argv, &argv);
+				   append_oid_to_argv, &argv);
 	argv_array_push(&argv, "--not");
 	oid_array_for_each_unique(&ref_tips_before_fetch,
-				   add_oid_to_argv, &argv);
+				   append_oid_to_argv, &argv);
 	setup_revisions(argv.argc, argv.argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
-- 
2.13.0.rc0.306.g87b477812d-goog

