Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77C841F405
	for <e@80x24.org>; Sun, 16 Dec 2018 21:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbeLPV6R (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 16:58:17 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42510 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbeLPV6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 16:58:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so5338060pfr.9
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 13:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XhC1SAWGvS243nhf21eDQu7vxRqmiTk0D1KP5SxjkmU=;
        b=FJbDoBnwcjGcGe93VBv1EW6nvhiD/4X+puF7QbGBXJtRde1FvybEbt+9Lc15PJo4BS
         OLe1E0E23vr46p9WyN88z1RT9uKsGrbjBLFOBJUtPbD1NKqmo+vq33rf8uabfffB5CNt
         C6WvAEJ+jnejZkbNwCD66KaEIfNyl91KND5e55TOELzzAdg0Np4ucoVMen1HgF7TonjU
         eWLHHbxHHmHcRmU+ijEoM+W4nkRryurbwCsrlCVqjg6sJdB2oC1oMD2MZYZ3QjM8o9iz
         WunUnCPKODKZgIJDfiGXtVM5ix9gLmLBZelqXZ/iCevMilyBDP3EnGb4r219aJJ1Xb4v
         S8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XhC1SAWGvS243nhf21eDQu7vxRqmiTk0D1KP5SxjkmU=;
        b=IPjgxx+c996zw2a5mKl7KT6C1gQ1zY4YBDRBJgyiVfvk2D93J9WWfQoesxNNglFhVg
         N1UlHhsrjxWGLa5N6l7sNu0AKh3TzoGOzs9vhCKEdR2xII3UbyQirzsZNTWMkIedFP7G
         3Bh3DM7yfnvRuy0geAY7JsNXZdOjWx4Te+IiIwOS54nyV92ghxEWhfJ0MCOj0VMaCRz2
         yXJtDV4IXr8jxo+2c2ZhoTBPu3NcXaXX/mSjQmeGpMnWwHFtI3MVsCbYwX4sI8efpHEz
         gRzSkFg0Lyw8AK5h9NH/uePRHcwnrvVM5UySBm9qYYz5+wKDbwUEdYNMrtX+xgwGhnY1
         jbFg==
X-Gm-Message-State: AA+aEWYXDzgiNUoxSAPKZwj61VRxnbR/2oEI8jpEvaC3YK96KIcaZlHw
        MazTTFwV+tIstKGclHtOiA8bRuZx
X-Google-Smtp-Source: AFSGD/XJ55LVquN3wayh/xFjmnUUcVGquPtAfEKSvikmJd3k9jRduOglnans2V5iRACp5fXOHVyUqw==
X-Received: by 2002:a63:a553:: with SMTP id r19mr10013533pgu.53.1544997494710;
        Sun, 16 Dec 2018 13:58:14 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id k191sm12736056pgd.9.2018.12.16.13.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 13:58:14 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v3 3/3] branch: Add an extra verbose output displaying worktree path for refs checked out in a linked worktree
Date:   Sun, 16 Dec 2018 13:57:59 -0800
Message-Id: <20181216215759.24011-4-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20181216215759.24011-1-nbelakovski@gmail.com>
References: <20181111235831.44824-1-nbelakovski@gmail.com>
 <20181216215759.24011-1-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

---
 builtin/branch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2a24153b78..56589a3684 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -366,6 +366,10 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 		strbuf_addstr(&local, branch_get_color(BRANCH_COLOR_RESET));
 		strbuf_addf(&local, " %s ", obname.buf);
 
+		if (filter->verbose > 2)
+			strbuf_addf(&local, "%s%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)%%(worktreepath) %%(end)%%(end)%s",
+				    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
+
 		if (filter->verbose > 1)
 			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
 				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
-- 
2.14.2

