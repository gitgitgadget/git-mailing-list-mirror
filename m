Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FEF1208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbdHJSdQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:33:16 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37644 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbdHJSdP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:33:15 -0400
Received: by mail-pg0-f65.google.com with SMTP id 83so1230293pgb.4
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 11:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qZaS/p7qMnvIddPt1dRIgkJeR6H00z3Qv5YWeifffdo=;
        b=OSwoLGzPpaM77QExs+rJ0nTYr8+xtpBYffWfb1Do/mpfgawkUhkyE6QIXxlrWYuW2K
         DoDuxxvrAcngrTbMyGNM4te6iTW165ef69X8U/H5aeZAQzXavnJu5x+XU/d0wQNVkfD2
         EvFVkYkEV9vKFgh50aowD3LKZ/OEeDCj6ovqzpCFbr/po289LekpJvmEZTgkMZ9U3CDu
         RWsFfQy+X8CJMFqZLhiBGsHfkew2DoX07AvoTBazCq9JLP12dGDy7q05xML702uoVTdr
         afF0PnFYW0O+EizalE91LQJe2kCpZxrUnLJdLT8wlL6fqiS+tmqEu3A9kmhSkM7nyLkZ
         xbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qZaS/p7qMnvIddPt1dRIgkJeR6H00z3Qv5YWeifffdo=;
        b=YP2Zqx+UUO0C62GsHlq8hZaaaVlHOZhH2+a2hn9n1JEvfQADRBIMztFe+WntvlHIq1
         +76hjibKI5dHMpm4iVm9BLmOM7mOVsaR2DFHfbcCeEIH13rbaiK3QLjTlrELv2t3dTPh
         EexlDjyB1Xzc0UlgcpeBOtzbdBwaDGiXBVgmInb8g37OHLk0gII3pQOBsWtd4bj3s/Dq
         9aHGp4Hjuig92nb67dZdnMVt71lmGETZvjC7NTS6CaFm1wzKknVG/E0wO72qL4PGeWW5
         zXPL01XL0BDOoMXtTwvgaFCM+nGBVuKwAHTyiEUCZE4Z4nGsrxL5OlgQPBvk5LAkcGZO
         qcew==
X-Gm-Message-State: AHYfb5ixmHpZHnFlQgGodVmK36tsN0JEVkm/mHOugHR3E/00sSmmso1i
        wsfGT4M0vNQd6sNjOd0=
X-Received: by 10.98.87.93 with SMTP id l90mr13213653pfb.3.1502389995298;
        Thu, 10 Aug 2017 11:33:15 -0700 (PDT)
Received: from kewillf-git01.redmond.corp.microsoft.com ([2001:4898:80e8:2::54f])
        by smtp.gmail.com with ESMTPSA id h14sm12953804pgn.34.2017.08.10.11.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Aug 2017 11:33:14 -0700 (PDT)
From:   Kevin Willford <kcwillford@gmail.com>
X-Google-Original-From: Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH v2 0/2] Add progress for format-patch and rebase
Date:   Thu, 10 Aug 2017 14:32:54 -0400
Message-Id: <20170810183256.12668-1-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.0.rc0.286.g44127d70e4
In-Reply-To: <20170531150427.7820-1-kewillf@microsoft.com>
References: <20170531150427.7820-1-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since last patch:
1. Use start_progress_delay so progress isn't shown if generating
   the patches is fast enough
2. Updated to have text of "Generating patches"
3. Only show progress when the --progress flag is passed
4. In the rebase script check stderr and the quiet option is not
   set before propagating the progress flag to format-patch

Kevin Willford (2):
  format-patch: have progress option while generating patches
  rebase: turn on progress option by default for format-patch

 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 10 ++++++++++
 git-rebase--am.sh                  |  1 +
 git-rebase.sh                      |  6 ++++++
 4 files changed, 21 insertions(+)

-- 
2.14.0.rc0.286.g44127d70e4

