Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A268FC4361B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55AAF20C56
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgLCS4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 13:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgLCS4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 13:56:02 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4514AC061A51
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 10:55:22 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q10so1919701pfn.0
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 10:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tNsynivzXM6+qPIKKMBm8jqB52zRYhcBoNOsVLWNic0=;
        b=KDFPo9d8b3K8A8EVTuSpH0pVJBw2lzn0n3p93Esqru3GEFp/iWCVRk3X045RtlT2m5
         2QNqhgeqqy2IoeALhuCtNv+AcUNKvbaduxTT23pttN6d3ID5U2SfyfOJeEbDcM/zNXTv
         RZJUTq3nOlw/C5QPx7VNz7n6Pnd2eXW3KuigrrMwnL6isCGszo14TlZk+RkLMvOE3Mra
         ozx2txItjOQVUo8jrF4nnuXmOuqab54uoLjK0GGqIya0gdKp9W+L98tMPpSFbqFKzIn9
         LCyreZJa2t7K5glau8G+mmt9/TrumfLseK1gbC4XErR+Npm4ugxVC6XI54zuxzg0l0Kn
         Uy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tNsynivzXM6+qPIKKMBm8jqB52zRYhcBoNOsVLWNic0=;
        b=MIcLa/pPsJAq9kKpMyYZM1mCH0jkkBpMjtocI91Zv7XEfpqONFfZpBk0QLE1GQGBNG
         Lu/nImoeZnurxtPVnofsOCIBL71dQbN4GAL5bWvkZqL4DyvM921o4C/3ksXCtdbyuGzh
         0pONqRqsuh6dSGQhznfwlIIYd6DZ25ErQm8emIbDR+F3TIb0Th/P6ZzbIYzN0HrwrRDC
         PMI5D5VCEndV5Zy2MXdvxwC3x+NNGS4SaQ5u/4EQ8rZkurto5HG0cvdYBZN+vQ+JTUA9
         GBPmzIgM/muO0rljvqXd6O5EPTVELnwAIFAL99fu+l/j55DpZmQSyKrxPknfAog7Gc1g
         k7KA==
X-Gm-Message-State: AOAM533RfRNxIvyZ/lmynO9yXi+3/slYN7wFDpjTiFiB9ecHgzD5Uq2A
        MkCJxwgzkp2gvSjsnObrzWosGX5eppFPfV1t
X-Google-Smtp-Source: ABdhPJxY2MFnMd9Hxy4jLQ3htl8tnA9DUYs/IS1Aqz8cg5z/jjGiEgCoMOoXW5Oz3leTd8vsutT58Q==
X-Received: by 2002:a65:6a16:: with SMTP id m22mr4269810pgu.175.1607021721120;
        Thu, 03 Dec 2020 10:55:21 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id s7sm135993pju.37.2020.12.03.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:55:20 -0800 (PST)
Date:   Thu, 3 Dec 2020 13:55:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 2/2] upload-pack.c: don't free allowed_filters util pointers
Message-ID: <a3c721054f337eac2b3a038e51693f44b68dd619.1607021483.git.me@ttaylorr.com>
References: <cover.1607021483.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607021483.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To keep track of which object filters are allowed or not, 'git
upload-pack' stores the name of each filter in a string_list, and sets
it ->util pointer to be either 0 or 1, indicating whether it is banned
or allowed.

Later on, we attempt to clear that list, but we incorrectly ask for the
util pointers to be free()'d, too. This behavior (introduced back in
6dd3456a8c (upload-pack.c: allow banning certain object filter(s),
2020-08-03)) leads to an invalid free, and causes us to crash.

In order to trigger this, one needs to fetch from a server that (a) has
at least one object filter allowed, and (b) issue a fetch that contains
a subset of the allowed filters (i.e., we cannot ask for a banned
filter, since this causes us to die() before we hit the bogus
string_list_clear()).

In that case, whatever banned filters exist will cause a noop free()
(since those ->util pointers are set to 0), but the first allowed filter
we try to free will crash us.

We never noticed this in the tests because we didn't have an example of
setting 'uploadPackFilter' configuration variables and then following up
with a valid fetch. The first new 'git clone' prevents further
regression here. For good measure on top, add a test which checks the
same behavior at a tree depth greater than 0.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5616-partial-clone.sh | 10 +++++++++-
 upload-pack.c            |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index f4d49d8335..5da945cf15 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -281,7 +281,15 @@ test_expect_success 'upload-pack limits tree depth filters' '
 	test_config -C srv.bare uploadpackfilter.tree.maxDepth 0 &&
 	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
 		"file://$(pwd)/srv.bare" pc3 2>err &&
-	test_i18ngrep "tree filter allows max depth 0, but got 1" err
+	test_i18ngrep "tree filter allows max depth 0, but got 1" err &&
+
+	git clone --no-checkout --filter=tree:0 "file://$(pwd)/srv.bare" pc4 &&
+
+	test_config -C srv.bare uploadpackfilter.tree.maxDepth 5 &&
+	git clone --no-checkout --filter=tree:5 "file://$(pwd)/srv.bare" pc5 &&
+	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:6 \
+		"file://$(pwd)/srv.bare" pc6 2>err &&
+	test_i18ngrep "tree filter allows max depth 5, but got 6" err
 '
 
 test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
diff --git a/upload-pack.c b/upload-pack.c
index 5dc8e1f844..d89c7e4a02 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -154,7 +154,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	string_list_clear(&data->deepen_not, 0);
 	object_array_clear(&data->extra_edge_obj);
 	list_objects_filter_release(&data->filter_options);
-	string_list_clear(&data->allowed_filters, 1);
+	string_list_clear(&data->allowed_filters, 0);
 
 	free((char *)data->pack_objects_hook);
 }
-- 
2.29.2.533.g07db1f5344
