Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2820C2D0D1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEE220716
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhOP/LiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfLSSCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:09 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38388 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLSSCI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:08 -0500
Received: by mail-ed1-f54.google.com with SMTP id i16so5768584edr.5
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UTlc6qjNMhMEu4zUmegOUS6A2tNDjGefjNDO1CKZ5Kw=;
        b=nhOP/LiRV6W7qZRip7EfEfXRAgbCWydmQazBEKX/ELkO1QFKMYh+58RtKU3oEfmyja
         9Jv3msG1umi0/dDc7GFeNYAZJCw26ksna/8I+3MsoikIBiFz4qZERg3qCHFng5vh1c+K
         avn+y7LkP7T1Qm+lSVIjflNrpR8Bxc4nSwFB3XLFxlr2G2u1AzDBe8t1uAxQGmHnaLA5
         q3KE5JRaqF4ihV3wuUNd36Timr896hIZLiLeuye7R18g3PxA8wZYP3+WHwrywG31N/as
         H1/8olU+lVWqgl07C5XOO1dlSWgmXsH/eOfbRh+w6ZTj5InD3+maYsWP+xYDd3MVhhPo
         NobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UTlc6qjNMhMEu4zUmegOUS6A2tNDjGefjNDO1CKZ5Kw=;
        b=JrrZCyEr0mf14GP6oTyQGGxEdMBGyzN2KoJwNpCRZo0gHKUQmp6HmsH+XmimdoOzAa
         mVBUm7R1kdWi1eOSfchXpvdCqOcaDZM0pHiCAppCCec5tY46NUKeRuPCUmbnEFC9JSao
         TKmv6+1ysdooWOuymHe2jVu7OsrjfCEa4hBRVv+5ZtF2pQufauzpPfagct5x986bcgM1
         3S6gM2CuGNuXXAHNtsZy7awkrXtTEqXpkpqRcpvOfnHDwEygN9J7Nx6AALxZVM3CuD/X
         MIfzKExrEBM7EFyPfA4xpcipeHqNFO4iV1+bEmjp7pc4GHqfmSSy5efvwKPCuda/i+sG
         ZxfA==
X-Gm-Message-State: APjAAAX40BMiGFTeE+0+zkB5DZ2qUGnRewW6FxvCMabwiTdGgimjpVEr
        l/+rxoVTES4xINo8cPnRBzjewR+P
X-Google-Smtp-Source: APXvYqzj+sOFTITL5+jdkePMJEyXFq5Bh9RckXEJuEMjlsCQG3GyAEhpVbImJd6LUk25rkOWuXCj2g==
X-Received: by 2002:a17:906:a44d:: with SMTP id cb13mr10986806ejb.258.1576778526181;
        Thu, 19 Dec 2019 10:02:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18sm569529eds.18.2019.12.19.10.02.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:02:05 -0800 (PST)
Message-Id: <daf0d6c5364ba44f83d0be69e12f4bdf042c5f3d.1576778515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:45 +0000
Subject: [PATCH v3 08/18] doc: checkout: fix broken text reference
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-checkout.txt | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 2011fdbb1d..d47046e050 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -95,12 +95,10 @@ using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
 file can be discarded to re-create the original conflicted merge result.
 
 'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]::
-	This is similar to the "check out paths to the working tree
-	from either the index or from a tree-ish" mode described
-	above, but lets you use the interactive interface to show
-	the "diff" output and choose which hunks to use in the
-	result.  See below for the description of `--patch` option.
-
+	This is similar to the previous mode, but lets you use the
+	interactive interface to show the "diff" output and choose which
+	hunks to use in the result.  See below for the description of
+	`--patch` option.
 
 OPTIONS
 -------
-- 
gitgitgadget

