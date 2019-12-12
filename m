Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5A7C00454
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2CA21655
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsuIEcvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfLLOge (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:34 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:50443 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbfLLOgc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:32 -0500
Received: by mail-wm1-f48.google.com with SMTP id a5so2632467wmb.0
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UTlc6qjNMhMEu4zUmegOUS6A2tNDjGefjNDO1CKZ5Kw=;
        b=fsuIEcvqfpEcYouMXesGUhv+Q/tKR/CjF1/b8ELdjOlgdb0Celg4pYU32X4uTl+3wv
         u79Ll3Ww2qzU90uE2y11/9h5gLducl12dgmeyluyIBtWf1X30BybuVcUeICtrZDJaFoH
         efqqFN/nVK9ksezbt8whW6+moDb/li1HpO83TFLiYDghOCexNqmmGehiqi/0x4PziLp3
         y+ZMkYajGzFR1S3/AdVRoYO5YYmwN0yoTledyAuiz6Ci3RgFeKps1e2dDr7+LhkTeIW4
         LLqP9KLeG0ox/R3IJII08FGF5uQ/Gap/xb/5hvx6mUeSEcP96/DXVwihkuwa6g9UPMcD
         gpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UTlc6qjNMhMEu4zUmegOUS6A2tNDjGefjNDO1CKZ5Kw=;
        b=as1tMiu1y1FDx640bhVlIEzZVbV5AncBD+bEYK0CJxU8ofJB/sXU+RSnYLWKY7jnlK
         jW47zRsTdkQnrScwYO7Pt45QHppNn4gyytqt38ry+efkU9NY51pERnDIwWLnoIME6+99
         yIbxYgMoHHVblLy7Mbn584WsXmfpVA03FB8n0IDw5iLtAyiHQVL/wYgBAfVdN/fAB9Cb
         YHpxsoaunM4hJAxczX4m4OG3qbrzmoew57orlH5u3LcseKSvEQE/7UOtqEurcks/BABS
         b9r51AzIde2JTKNopAs0/fD3JLPv9HJPsWQT5RTJuL0etKxX/E9Si6h/lSESlIoMEXzP
         OytQ==
X-Gm-Message-State: APjAAAVHdE372SPvOW3ryW2Qp0YIQiFYUxNQXYL7zFqffPIXsXVBc2nM
        C+kgoyeQB12hS5OoHd/FXkzX8zmh
X-Google-Smtp-Source: APXvYqwiQ3bTyR9f7WxyiGZ56Nb65gfSloFRiM3LyKUH/cvD/p4jyVf7D7yPzfkzc/ScxUELAM0mTg==
X-Received: by 2002:a05:600c:2150:: with SMTP id v16mr6513974wml.156.1576161390806;
        Thu, 12 Dec 2019 06:36:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1sm6239837wrr.80.2019.12.12.06.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:30 -0800 (PST)
Message-Id: <2d87b6433b8965b833e300b36110b17d936403d1.1576161385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:15 +0000
Subject: [PATCH 06/16] doc: checkout: fix broken text reference
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano" 
        <gitster@pobox.com>, Emily Shaffer <emilyshaffer@google.com>,
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

