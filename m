Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA1EC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A9AE2086A
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="eZxj2FHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgHCSAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgHCSAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:00:16 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F706C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:00:16 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so20386600qtp.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PJrFU+75QPJCoYigEyOKR4oxa0fQ98NHJ7TU05rAv8E=;
        b=eZxj2FHhNss1xlLhLQeM6KuCDRr/VW+0tkoxCz6DqlV52dMXCM4ZPxtEPv09wS8iRx
         BoI0pHnnJfe5iu3jXaP40fI4OGBNSP0ls0FfG6I/cCBeZHEXMIm+p8TezRs/Wxcu71pv
         xS0qj3uZF/ubC7MlaOXG2+14B/Z/iF7ukc0RiZMjbPDZOJKjcDS2mU/1sX6eAVDvl/RU
         2wOl9NmpXPwVzaMMSJZZYSyAbrbn+11Uf4pDbz2QCM9X0cbv2i2CmLM/OlpwkCBGAmjw
         E9BQVz8XkTYmevIXIkl5898fa/2/A+zQcE5Jbd+HCKgbXcUqXSi8IyqeAogOFGLsV+nN
         kPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJrFU+75QPJCoYigEyOKR4oxa0fQ98NHJ7TU05rAv8E=;
        b=H2JZBaTEj27Aido//wgD30iU77eas3vdj5lWeoUBmvzjlrRsSk+YxxOrb10mAKqDBU
         FiUUgNr/PJ3aTZk9pK4jpt2hnZbyeIX+ZcAB3rp7RIxg3hjRfwZG2IEhV9Ru0BCSXUAk
         D2pyeyVSaK1nCX0zjmTwObxFEKYDK45EsyTy4BiRopCSh8v45QGYgehTWILmiGSBUdmo
         fTVC66GJUIlrjMyDCRTHK8Jk2l2V3DGToAgAvD3qBNfeKcvyWrFRmwxibM2lzorRIqmq
         xtzmPRaG4favNqCmfjbtsLewuiKf/o8SVRH6S+ZXOk71ORHOkpWytVecnjLYA2CaqVOT
         5y1w==
X-Gm-Message-State: AOAM531rcDfWGFwkjX/0TmSFHJw4ZaiMfXIJIKjyY1Q+OdUL0R5r7pmf
        NCuPMrRTBOgYZnmBww1c//NSwa9eK0Uysg==
X-Google-Smtp-Source: ABdhPJxvyeaoN4GJEA2Yd6IhvYm8DTf5kkYlnhkd3+L0IJdzZ5m1prq34cxi7myOe0zgvDYhh7L8BA==
X-Received: by 2002:ac8:71cf:: with SMTP id i15mr17823412qtp.119.1596477615511;
        Mon, 03 Aug 2020 11:00:15 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id f4sm21752519qtp.38.2020.08.03.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:00:14 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:00:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: [PATCH v4 1/3] list_objects_filter_options: introduce
 'list_object_filter_config_name'
Message-ID: <f4c777187559cf48b82132413b5a1e18dab90e93.1596476929.git.me@ttaylorr.com>
References: <cover.1595468657.git.me@ttaylorr.com>
 <cover.1596476928.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596476928.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit, we will add configuration options that are
specific to each kind of object filter, in which case it is handy to
have a function that translates between 'enum
list_objects_filter_choice' and an appropriate configuration-friendly
string.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 list-objects-filter-options.c | 23 +++++++++++++++++++++++
 list-objects-filter-options.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 3553ad7b0a..92b408c0c8 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -15,6 +15,29 @@ static int parse_combine_filter(
 	const char *arg,
 	struct strbuf *errbuf);
 
+const char *list_object_filter_config_name(enum list_objects_filter_choice c)
+{
+	switch (c) {
+	case LOFC_DISABLED:
+		/* we have no name for "no filter at all" */
+		break;
+	case LOFC_BLOB_NONE:
+		return "blob:none";
+	case LOFC_BLOB_LIMIT:
+		return "blob:limit";
+	case LOFC_TREE_DEPTH:
+		return "tree";
+	case LOFC_SPARSE_OID:
+		return "sparse:oid";
+	case LOFC_COMBINE:
+		return "combine";
+	case LOFC__COUNT:
+		/* not a real filter type; just the count of all filters */
+		break;
+	}
+	BUG("list_object_filter_choice_name: invalid argument '%d'", c);
+}
+
 /*
  * Parse value of the argument to the "filter" keyword.
  * On the command line this looks like:
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 73fffa4ad7..01767c3c96 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -17,6 +17,12 @@ enum list_objects_filter_choice {
 	LOFC__COUNT /* must be last */
 };
 
+/*
+ * Returns a configuration key suitable for describing the given object filter,
+ * e.g.: "blob:none", "combine", etc.
+ */
+const char *list_object_filter_config_name(enum list_objects_filter_choice c);
+
 struct list_objects_filter_options {
 	/*
 	 * 'filter_spec' is the raw argument value given on the command line
-- 
2.28.0.rc1.13.ge78abce653

