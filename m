Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520A51F453
	for <e@80x24.org>; Tue, 23 Apr 2019 23:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfDWXku (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 19:40:50 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:44808 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbfDWXku (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 19:40:50 -0400
Received: by mail-pl1-f172.google.com with SMTP id y12so5707035plk.11
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 16:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k2VMUY+Q1sABigwsf2quOtbvNvhoXH+v2Pv4I46Yz7g=;
        b=acCUhQS39SRm/b5xlPO4b5hAuW+5OJw0dbPKZo++wt8G2j86rHn7HGG61H0V8K9EjF
         j/7wThWj8pz2myT7SAOpuM//lPjtMhJxduh5F9+S9+sUQ0++/0JT7CmDQvzvlHvNrYLI
         2bRLv16T1NNKTK6omW9d22zO+j7+4wSW4+51CcgMWNywHDdOaNjZhhcEcZzn6TtKot3y
         8yboundZQUK9YDolFhXwRtR/Ongx8TDJl417727fPgfjzAilhne50DPpZL5UAWmXwUxm
         IZ6UFDvaBbtVTyivl5l/M6/MAggwFI7C/A3LxYLksluX4CZQ+QhXHvgkBIUYNW1L2EDx
         PzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k2VMUY+Q1sABigwsf2quOtbvNvhoXH+v2Pv4I46Yz7g=;
        b=Wa0NgLm6YcHotyc5SocvyHafrmTcXamnBHRp2inqEg8b6iJtobr1x4xhEpjEXtQl1D
         FF1tDWz1LM9Lf70VPGGwoSNGH1IqaCQ7W1btMK6HsljtIxVsY4sGTnJVBGuBAXmnhoqf
         ZH8KySY3nZc41GawpyyVVCr3vb3Qx8xkqudn13DSbaiOJlqQ23josTxHc6tJBERHf42z
         Q3mQMUH6SbH0zwWkEaQYnk3aHzlcR5e880fg7PO0jOKo4isj9HFT/817IFybfx4qRh9v
         x2dnwddF/vTuBuuWFMVx8fwQqf3jmFTf67miyytD2Wk0qCCJLk2Wyku5ITqkvmlacn4/
         Uryw==
X-Gm-Message-State: APjAAAUTEqxy9fIaSFK6GtMp9XI3r+jLmglRgWdGrYqDshRCHzPnKm22
        Ibw0RhvGaqPxw6QZdesZvP5VUNwC
X-Google-Smtp-Source: APXvYqx/z368kef5qiSCmCp3bkqv3J3fsVYZWngZdrRm8bGb4UzryRmX/zj6EIH7+wZI6Gb1N5Litg==
X-Received: by 2002:a17:902:4643:: with SMTP id o61mr5630683pld.249.1556062849284;
        Tue, 23 Apr 2019 16:40:49 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id f2sm32033412pgc.30.2019.04.23.16.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 16:40:48 -0700 (PDT)
Date:   Tue, 23 Apr 2019 16:40:48 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 4/4] cocci: prevent extern function declarations
Message-ID: <23ed6ad679bb0e631872f229702934cd9ea55e20.1556062365.git.liu.denton@gmail.com>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1556062365.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556062365.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since function declarations already implicitly imply extern, create a
Coccinelle rule which removes the redundant extern.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/coccinelle/noextern.cocci | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 contrib/coccinelle/noextern.cocci

diff --git a/contrib/coccinelle/noextern.cocci b/contrib/coccinelle/noextern.cocci
new file mode 100644
index 0000000000..8cb39ac947
--- /dev/null
+++ b/contrib/coccinelle/noextern.cocci
@@ -0,0 +1,6 @@
+@@
+type T;
+identifier f;
+@@
+- extern
+  T f(...);
-- 
2.21.0.1000.g7817e26e80

