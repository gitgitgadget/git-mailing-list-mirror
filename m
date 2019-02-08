Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32DDB1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfBHJFU (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:05:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38963 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfBHJFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:05:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id f132so1380622pfa.6
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PhJtO55dZe388Tzq1pi0NTiEYb04QtxTZbfzdy0hmw4=;
        b=gn58zF5sTmSRpq4AWtUvJxU+HEH7f+ncEsEvNEGdpoY6xojWgNoLTbv/fDMcrlE9xs
         gK6WbRTLkxgvhglx9T2CzIhPNAEIKIYFh9DEJpZc6KQ7FK0IXInHDh58f+OJ4Nhg7MJI
         DfIbXHp2qMpqCQWZdPctMCn3iqyWL5pkogEaQ4afZFahYS8UcugEh6rGL7z4lRFvU2xG
         WcKn4BMfsF9bYZ1qvFLVcL3iJO/w4vW7hBRWhJUM+L+6ambh8eaQa+dAVIckWB4V8WRB
         84rU2BtARQnP8NzLG5noeckqMw+tD8AtkuRdg0Naq6CQCtCvbXFl6VKBov7/Qfv8u5Do
         I3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhJtO55dZe388Tzq1pi0NTiEYb04QtxTZbfzdy0hmw4=;
        b=L3PnkPTOqk/fJoCZ1dOLZbSevKnx9n+5rKBOcZsmbDh38RaKwSKkVhyeziw22edy4i
         b2f8LbY/AQIzLnBNu/MFkq8KAPoQSn7PVwIxZc+6kiuJRyXlnOEUDUVe0Gn23Vm3Nusk
         xDHILhalM0ehLYCUU51JMhXC1R9O5LVWVKqF0Bnv5blPo2D+m4uTeduRw7ZbMU30+RzQ
         FKvlJje+FeNx8vx0S51b0itftf9YKLP4+dDsGcXPTvWwYjUgTub4hMOKBSDi7ozoibUL
         V2gPkI1sMzORuRQwf5aOo1O6u5XBhtTdkRDlJ9ifKTr0AnfQi+ySEg+UHhgb4nV3yCPL
         F7Lw==
X-Gm-Message-State: AHQUAuY1nwjcNcrxs0LDsYPFhQvU9o/tEyDoZVz4/XnAWgUp6SLwtiKa
        B5ErCuEqFG1Mr8B+Q/sucSY=
X-Google-Smtp-Source: AHgI3IbEfeR5AUgnyTyPBsEIO+0qtXTbqPKbSeW9+QT5KJJfKc0evvbdFMlppfkLsEH4h02Agb0xDg==
X-Received: by 2002:a62:9683:: with SMTP id s3mr21077178pfk.60.1549616718991;
        Fri, 08 Feb 2019 01:05:18 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id z62sm3014783pfi.4.2019.02.08.01.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:05:18 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:05:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/19] switch: remove -l
Date:   Fri,  8 Feb 2019 16:03:52 +0700
Message-Id: <20190208090401.14793-11-pclouds@gmail.com>
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

This option is ancient. Nowadays reflog is enabled by default and
automatically created for new branches. Keep it in git-checkout only.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f6de232922..f7d8fa7caa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1357,7 +1357,6 @@ static struct option *add_common_switch_branch_options(
 	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_BOOL('l', NULL, &opts->new_branch_log, N_("create reflog for new branch")),
 		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
@@ -1558,6 +1557,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			   N_("create and checkout a new branch")),
 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
+		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
 		OPT_END()
 	};
 	int ret;
-- 
2.20.1.682.gd5861c6d90

