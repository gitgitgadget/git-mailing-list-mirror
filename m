Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC73A20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 17:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbdK0R3A (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 12:29:00 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43930 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbdK0R27 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 12:28:59 -0500
Received: by mail-pf0-f195.google.com with SMTP id r68so11509438pfe.10
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 09:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DEFojdt+y4hEsbxdVhH6mREnKuY5XCHB/eemViQ3h0M=;
        b=KLnvLpK00JHYY02xwxZOr+UVscznwQl9HKYwCj2U4j24yQ2bvpppbp+hzB9VfkiB8t
         8irx9f3oPliCtVPnRwjNwzUy04cxzUohTNIuJWCUvUC6YFH2JKqdS/rhuJAB1NYZOeG8
         rOIfviVazHPL9X33gCppNlBXpQ0UAIXhvj70/8WBpXtFV065Y1+oe41ZH8q4zpdrFdR2
         8JPnF+YzKT+9b5tiD92f3EY6X0zw/G4sDIc5vyE0MlJTD3swmxr+zhpar3ZzzlCLcGRt
         w1XQrDSAhLZE3P1x0XLIdnZiqVUp0LAGBs+Nkp6Aw/c4wGFkrRtTYesL1lIuesHBfK+r
         JiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DEFojdt+y4hEsbxdVhH6mREnKuY5XCHB/eemViQ3h0M=;
        b=PF8GQqTIR2J+wB6CqTi09UCyekBDo3RhW2drbFgX9xdgcpF32i38HYNPhXp2SUCpYZ
         WQaAs5PZpAqPQN43jntMeUklNa1kgEqELltVwKCja3Odm+5DrUeisPySX9HyNN/QrJ/z
         vkJLikYbh6qyVw7WbZHbRmyMRiKvhEcDQqf17GXsleivH8pIWkTucDWMnDFdyg5SmvP8
         FkNmGjIo2IWVVjf/LUqK0Yb0zQf3qjwqFUdgHoCBmCYaFaKg6yF7KiRmUfAU7HCSyCzJ
         BQoK8jnMIh3WWXCtGcs2B5c2mlWF97snKtZtAmld1YXRHSneesIG3sPwRrxTP6YE6IQy
         K0yw==
X-Gm-Message-State: AJaThX6QHTAn11UwRx/60avQ9lVFwFdcIOfxEiN6Isg8mPj9PkR/xnnb
        MhRRmcEhc9Nnpprs8tvfeOc=
X-Google-Smtp-Source: AGs4zMZA/8iw7elewgscGrvIiOeyCJNXa5d2IFEBvBJqWRZjXf7NLRFt+BOsnWj2HSO83VYfby4KTQ==
X-Received: by 10.101.70.196 with SMTP id n4mr15829317pgr.353.1511803739248;
        Mon, 27 Nov 2017 09:28:59 -0800 (PST)
Received: from localhost.localdomain ([2405:204:73c7:b4fb:72c8:dd31:37ff:6021])
        by smtp.gmail.com with ESMTPSA id s81sm51232454pfg.60.2017.11.27.09.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 09:28:58 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH v2 1/2] Doc/checkout: checking out using @{-N} can lead to detached state
Date:   Mon, 27 Nov 2017 22:58:33 +0530
Message-Id: <20171127172834.6396-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <xmqqpo8dn1jd.fsf@gitster.mtv.corp.google.com>
References: <xmqqpo8dn1jd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

@{-N} is a syntax for the N-th last "checkout" and not the N-th
last "branch". Therefore, in some cases using `git checkout @{-$N}`
DOES lead to a "detached HEAD" state. This can also be ensured by
the commit message of 75d6e552a (Documentation: @{-N} can refer to
a commit, 2014-01-19) which clearly specifies how @{-N} can be used
to refer not only to a branch but also to a commit.

Correct the misleading sentence which states that @{-N} doesn't
detach HEAD.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/git-checkout.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index e108b0f74..d5a57ac90 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -272,11 +272,11 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	commit, your HEAD becomes "detached" and you are no longer on
 	any branch (see below for details).
 +
-As a special case, the `"@{-N}"` syntax for the N-th last branch/commit
-checks out branches (instead of detaching).  You may also specify
-`-` which is synonymous with `"@{-1}"`.
+You can use the `"@{-N}"` syntax to refer to the N-th last
+branch/commit checked out using "git checkout" operation. You may
+also specify `-` which is synonymous to `"@{-1}`.
 +
-As a further special case, you may use `"A...B"` as a shortcut for the
+As a special case, you may use `"A...B"` as a shortcut for the
 merge base of `A` and `B` if there is exactly one merge base. You can
 leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
-- 
2.15.0.345.gf926f18f3

