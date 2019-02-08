Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0E7A1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfBHJFl (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:05:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46977 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfBHJFl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:05:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so1290578pgp.13
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uhKchI7eQfzL1RnWGV+5KoBG6ln305GqsKCjRXYbYjw=;
        b=KbDhM+G24/pNZDmgNVxenCkg8sPW1CXU4ygLDZV/R2dYOMu72iMw8a/kwq6k4XPycU
         GbsxON00SKMQuPb9ACunou4GC1I23o3p4MbqvIfOgdeqP7ftCN2/cvKshPmc4LDJXyWT
         hKrillzjN+Yt0GfLqrWmIasMW/zFh+sLV7G0gw/gQSzEbHHJ8n6MzvszkG2NsnmlS27P
         SBBCtNsKekK1aY/+QIDYRsxJpfjDp3pxz8ls6ta0Ly20uveE6Lxa3GIvcbs5PutDpVIN
         aVKjZRmhsFe//DHEx0+vhzSLGidT6HnJI1B0J0IA+6Uqe70QkWYV4ktghsgA3KiIgp+i
         1h1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uhKchI7eQfzL1RnWGV+5KoBG6ln305GqsKCjRXYbYjw=;
        b=J+1HPd2Y3micpaIBzn6ZTy2QoWQBQ1eL3Z08Inc/XFreW2CUvDslJdvuPCtSSK/fBP
         Y630P76JEX9jwCeskv5kjnWxL4lvgzbanq77ta0ilRz7ftDkAqhLA5miFlSFKPK+3y1C
         5NX8v3KXx9l684oEWZiVCkdOaDO+npT3cXeN7hvbjrqdwdVlFR4x0Eya1c3gRVv3qzf2
         LtT4gVcSMDxuCdoQKheAcZ+GczWO4zNPtxqld+VePOGbnXCEEWha3gNiBVqwLVIPRoYq
         2lQl4yLXfwXmkvpn8dN8in24tYKIlVElA5LvMRjFNL19JKBGXLtDzZwO3nO9xhpCoTe/
         k6Iw==
X-Gm-Message-State: AHQUAuZUpOzEbvKiiJaKPPBUt7Ng8SWEvmWvDEIGg9hA2RPI2vbhrsWm
        Vpy8nvUvIN+WkSXm/LmP9ZlSTuPL
X-Google-Smtp-Source: AHgI3IbBv80bOOfwhFrlOmVIMwdj1t7FDXYxJQ2OIZEa+4T0jsyBvQc4WBAQpd/PhlPLjLE6Bktolw==
X-Received: by 2002:a63:454a:: with SMTP id u10mr18709236pgk.224.1549616740365;
        Fri, 08 Feb 2019 01:05:40 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id y184sm4182682pgd.71.2019.02.08.01.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:05:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:05:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/19] switch: add short option for --detach
Date:   Fri,  8 Feb 2019 16:03:56 +0700
Message-Id: <20190208090401.14793-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git checkout" automatically detaches branches and --detach is not
that useful (--no-detach is more likely). But for "switch", you
may want to use it more often once you're used to detached HEAD. This
of course adds -d to git-checkout but it does not harm (yet?) to do it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d6c968f5f3..a5284391a9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1381,7 +1381,7 @@ static struct option *add_common_switch_branch_options(
 	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
+		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
-- 
2.20.1.682.gd5861c6d90

