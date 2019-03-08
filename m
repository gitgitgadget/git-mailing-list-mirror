Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D0D20248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfCHJ7X (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:59:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34341 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfCHJ7X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:59:23 -0500
Received: by mail-pg1-f193.google.com with SMTP id i130so13769986pgd.1
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FnF2L6QDxP0YAwFQEc20Ssn+pX+ixwsOfp0iluxLORI=;
        b=ad+ujwF+QzuAqbCDoGX74eSVNhFL3oVOvCsFG+HDLV81PyZUdeza4p1CROo6fBjEoh
         rVx+lAuaQM1PNIKGMlDwmpJNgQauEPjXZovFSMC9Frj4W3pgRX1QtpiJhYUS+1O42Prq
         NVJXRaNUtyf3IWyoWAEzOFGCUxFgR1e8hdvmb963RmC9StOWYI/WWfoAdquTn7AjYtNR
         h64WCFw1QO7Cx7KDav2NeS0UjVz8vazecoWSCh41yHSTmmniMmMeuszi6018x20gl4u4
         Ig3lmG+aC+9mAxzyAg5sPNKaTYNwEqmIt7AwwFAPqmsyEQ068PzPxrrCzKwoyEVJcTDl
         8V1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FnF2L6QDxP0YAwFQEc20Ssn+pX+ixwsOfp0iluxLORI=;
        b=XpzxC6UG+qm4PR01H4WcxAusDi8+2QP8DY7D/H9xmaE8mlTru39rN6rjV13IBa4VnX
         PWf9Y2zSJhQAUCbLMxkHqwKPB9N6zaRiHj0HhJHYDNDW5fgXxrwTspozEqBuC24rpE74
         spj9fX52zvBS70fQXAq3KCZXOoeu5i7/hrBrOjcSJgchzhZxBvGIwqyGabOxNDJ4cX80
         K+9sA/O7wTWbE53tbhLa9xYKaLKqf78/cAIb/4MHOlD0XAfV53aQgV75Ikcggd6GLJWk
         JEpNLi7Znw5G9ctwcHRziBweStHutgAInQhXDHMcKGcuOf3y7Y2UjlfO/zedjQdEfa/L
         xTSQ==
X-Gm-Message-State: APjAAAXrIvff4JfUrXb6qCZ3wRZVgyFHX6B3k4Nd3ttRCOUWOtlAY/L7
        j/Ay5vqHlao1K9nHduLPMqw=
X-Google-Smtp-Source: APXvYqy0lVxaEmFFCTe53z/req52eUq50Jlq5zEA9YNFcT7nof4GgWtLCshpK0UeVC14e9f3QpyddA==
X-Received: by 2002:a17:902:234b:: with SMTP id n11mr13313056plg.89.1552039162716;
        Fri, 08 Mar 2019 01:59:22 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id p5sm9896008pfn.154.2019.03.08.01.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:59:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:59:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 16/21] switch: add short option for --detach
Date:   Fri,  8 Mar 2019 16:57:47 +0700
Message-Id: <20190308095752.8574-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git checkout" automatically detaches branches and --detach is not
that useful (--no-detach is more likely). But for "switch", you
may want to use it more often once you're used to detached HEAD. This
of course adds -d to git-checkout but it does not harm (yet?) to do it.
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2e150f0175..0866aeba83 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1396,7 +1396,7 @@ static struct option *add_common_switch_branch_options(
 	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
+		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
-- 
2.21.0.rc1.337.gdf7f8d0522

