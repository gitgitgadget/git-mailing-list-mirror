Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DECEA215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754793AbeD3P4V (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:56:21 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36689 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754786AbeD3P4T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:56:19 -0400
Received: by mail-pg0-f65.google.com with SMTP id z129-v6so2404743pgz.3
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zBfWaj5imTr0ekcW74OHUjGQeuxLUkgYre3mbbxgKlQ=;
        b=p98wGXohWb2Jq5sOmhE/96hbj8cnyH4JPleDfcSvH0N1zkWEKOVrrwQQudxUD4NdEK
         AGfF+A/I7aR04M034IBqINIcy4UaF2KudLRES7v1gFgApIz9XHH4B54NbYsqz/gq2vw9
         Bc5PgcxIy5SMjb+ggQNKsMwwGVQ08pWmx+q8B0DaTy6pGAsoBfNNJSiJiZTA/9S2NIEn
         diUbRv8zuhiwDgsdu3L+5qil5Cx3Pmft13KHnUQx5swZWFyiuuNS9DB9asganjHB8d5X
         T09dwvbsJpe6kdKevNfipIvj9alANa9gW52TJdd+nZhVy1DuweoR5TgFqnLZppTWN2Ua
         hH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zBfWaj5imTr0ekcW74OHUjGQeuxLUkgYre3mbbxgKlQ=;
        b=sIVxsOEcdKR/DtHrr8KcM0fkEDIYE0kd5wXZH24c8NOg3bKfQXDqiLRecuhZU3uVh6
         Irxor9yIDXKP50mgZD+X3nZeSAvhRLf+1JLfXVM9zT5E8wOBJdRE6Yeh1GYJn4RAWAym
         D82/OULOIj2UJlf2AWB27Kt7qHBnf4aS7tMg8J2cArlbLd5gTfuC/Me1THRI3gFOeb5e
         iRRRi4e8u1E3vbkhXxxNyy5G8acjrOCKkjWAHllzXziRqMH6E3jBAXLm4ecL7ohPW32+
         XlCwyEp/up2M3AY8jNHRgZoPNllOq1uCfBuj9YzBr8pJtHYkOFZ4nmQnbcJVGfSJZU/U
         ajdQ==
X-Gm-Message-State: ALQs6tDPo9A4vtBqTP4gtNrenoc6rAP3Dd7nu0F2tYvAKdJOkmmRnNe+
        kTcapDZu/eXa5gdBhjmoCZdXRBCO
X-Google-Smtp-Source: AB8JxZoa/WrrFI+J9FW7jRZxn+FbbQAfzxADOFpZtu5p0PzG8rAnJ9sG5hw0t3KcBl9jQOQ77auwwA==
X-Received: by 2002:a65:6151:: with SMTP id o17-v6mr10618657pgv.120.1525103778950;
        Mon, 30 Apr 2018 08:56:18 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-236-28-204.dsl.chi2ca.sbcglobal.net. [76.236.28.204])
        by smtp.gmail.com with ESMTPSA id a12sm19392146pfe.78.2018.04.30.08.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 08:56:18 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v2 0/2] Fix --short and --porcelain options for commit
Date:   Thu, 26 Apr 2018 05:25:22 -0400
Message-Id: <20180426092524.25264-1-sxlijin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180418030655.19378-1-sxlijin@gmail.com>
References: <20180418030655.19378-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rerolling patch series to fix t7501.

Samuel Lijin (2):
  commit: fix --short and --porcelain options
  wt-status: const-ify all printf helper methods

 t/t7501-commit.sh |  4 ++--
 wt-status.c       | 56 ++++++++++++++++++++++++++++++-----------------
 wt-status.h       |  4 ++--
 3 files changed, 40 insertions(+), 24 deletions(-)

-- 
2.17.0

