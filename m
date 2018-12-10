Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE0D20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeLJSGW (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:06:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43132 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeLJSGW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:06:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so5755449pfk.10
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oPhwjCljrpIbDCNIeVimceXeqfwO/L3v+NlwINj7Fbc=;
        b=SRWmkUyOjZQ+tR7J7wYnF0Dzi9jd0/GpR00di8tvJnujmJfIqtF2RM0TcgKKUjTQoG
         AFSWJxwLxtg4DLUFhs+EBBCRBhoTDGKLWX+oKVU+ZbkJG4kHpOPD+TrTuf0xDmZAj9of
         js1XK4fDIdpHFU4R3H+SLsdr5cYc9YrwLNtt5VO2dtLrxjmb0Zk4Pqp5D5CsXZ4zcKiH
         28dcw2OpIoAkSTlmfOIiQ1yUzVolEVWSenaMd3df0N1lauBW9aQTiz1j5Jz70otxE047
         cHGrt/9gVxL4Fw6wMoVrWhSG2dV4EiltN/mYVC3sAipJyGt55bfhGT96dMokZeluLsnQ
         rUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oPhwjCljrpIbDCNIeVimceXeqfwO/L3v+NlwINj7Fbc=;
        b=gOyCE9puYDW62//cC0R3UDbB73OwnlaVb+Et89XYcwXeGygac0zYIP7Pa2Eetj/fLe
         TCY4EtOo5hRshwyrCXRIvbUEtZ9UDMWwu5GUH3x9Seu9RJ9AO4ToO2Hp85uoHzUfV2lC
         BQZEA3bbrpF+1fA2eBtHyEqUesdn7NRA5SOReUokUchiBXc22/3PNYOMJ6T/Ma0wdJgi
         4CSje3cyG+e1NvLF2XO/S5yw5xgoeg8VXJzCkl3/Kq7GVA0B8i6n28ecJi3bdlfzYFeQ
         K00YjTU1sP60va75XCqgHechYtzvWbyhqjMdrLG5NmC3zxUt+0gaVU7T5K58379vHnxA
         kIWw==
X-Gm-Message-State: AA+aEWbMFj9j8F2Nzm2C7xWDOppN0OuDAxXAhVOXmmWDCw0OkkAsUecY
        zQtxMktQC9M505l+RNZa7AWz0REI
X-Google-Smtp-Source: AFSGD/UaxyS0/B4SNOogGJYxgF7VWmCqEzioOzmwzUoIMuEeAzjU3RUhdMuUFjantD9w5pEcnWb5MA==
X-Received: by 2002:a63:d301:: with SMTP id b1mr11844385pgg.61.1544465180831;
        Mon, 10 Dec 2018 10:06:20 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 12sm12073756pgd.35.2018.12.10.10.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 10:06:20 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:06:20 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 18:06:12 GMT
Message-Id: <1e34b48a2051089052c0b53b0059576b5ace45de.1544465177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.git.gitgitgadget@gmail.com>
References: <pull.92.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/5] multi-pack-index: prepare for 'expire' verb
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

The multi-pack-index tracks objects in a collection of pack-files.
Only one copy of each object is indexed, using the modified time
of the pack-files to determine tie-breakers. It is possible to
have a pack-file with no referenced objects because all objects
have a duplicate in a newer pack-file.

Introduce a new 'expire' verb to the multi-pack-index builtin.
This verb will delete these unused pack-files and rewrite the
multi-pack-index to no longer refer to those files. More details
about the specifics will follow as the method is implemented.

Add a test that verifies the 'expire' verb is correctly wired,
but will still be valid when the verb is implemented. Specifically,
create a set of packs that should all have referenced objects and
should not be removed during an 'expire' operation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt |  8 +++++
 builtin/multi-pack-index.c             |  4 ++-
 midx.c                                 |  5 +++
 midx.h                                 |  1 +
 t/t5319-multi-pack-index.sh            | 47 ++++++++++++++++++++++++++
 5 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index f7778a2c85..822d83c845 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -31,6 +31,14 @@ verify::
 	When given as the verb, verify the contents of the MIDX file
 	at `<dir>/packs/multi-pack-index`.
 
+expire::
+	When given as the verb, delete the pack-files that are tracked
+	by the MIDX file at `<dir>/packs/multi-pack-index` but have
+	no objects referenced by the MIDX. All objects in these pack-
+	files have another copy in a more-recently modified pack-file.
+	Rewrite the MIDX file afterward to remove all references to
+	these pack-files.
+
 
 EXAMPLES
 --------
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index fca70f8e4f..145de3a46c 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -5,7 +5,7 @@
 #include "midx.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [--object-dir=<dir>] (write|verify)"),
+	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire)"),
 	NULL
 };
 
@@ -44,6 +44,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		return write_midx_file(opts.object_dir);
 	if (!strcmp(argv[0], "verify"))
 		return verify_midx_file(opts.object_dir);
+	if (!strcmp(argv[0], "expire"))
+		return expire_midx_packs(opts.object_dir);
 
 	die(_("unrecognized verb: %s"), argv[0]);
 }
diff --git a/midx.c b/midx.c
index 730ff84dff..bb825ef816 100644
--- a/midx.c
+++ b/midx.c
@@ -1025,3 +1025,8 @@ int verify_midx_file(const char *object_dir)
 
 	return verify_midx_error;
 }
+
+int expire_midx_packs(const char *object_dir)
+{
+	return 0;
+}
diff --git a/midx.h b/midx.h
index 774f652530..e3a2b740b5 100644
--- a/midx.h
+++ b/midx.h
@@ -49,6 +49,7 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 int write_midx_file(const char *object_dir);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(const char *object_dir);
+int expire_midx_packs(const char *object_dir);
 
 void close_midx(struct multi_pack_index *m);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 70926b5bc0..948effc1ee 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -348,4 +348,51 @@ test_expect_success 'verify incorrect 64-bit offset' '
 		"incorrect object offset"
 '
 
+test_expect_success 'setup expire tests' '
+	mkdir dup &&
+	(
+		cd dup &&
+		git init &&
+		for i in $(test_seq 1 20)
+		do
+			test_commit $i
+		done &&
+		git branch A HEAD &&
+		git branch B HEAD~8 &&
+		git branch C HEAD~13 &&
+		git branch D HEAD~16 &&
+		git branch E HEAD~18 &&
+		git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
+		refs/heads/E
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-D <<-EOF &&
+		refs/heads/D
+		^refs/heads/E
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-C <<-EOF &&
+		refs/heads/C
+		^refs/heads/D
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-B <<-EOF &&
+		refs/heads/B
+		^refs/heads/C
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-A <<-EOF &&
+		refs/heads/A
+		^refs/heads/B
+		EOF
+		git multi-pack-index write
+	)
+'
+
+test_expect_success 'expire does not remove any packs' '
+	(
+		cd dup &&
+		ls .git/objects/pack >expect &&
+		git multi-pack-index expire &&
+		ls .git/objects/pack >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget

