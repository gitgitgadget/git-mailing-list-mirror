Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAEDC1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeCORJb (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:09:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39037 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeCORJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:09:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id u10so11751918wmu.4
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qwbXf0toY8R+zI20Q9RIRh/jJ1S8fz2bnPFNhBmfyAw=;
        b=Ahco7AVV7Hj1c3q65xaRfP0nQ3PahKs7iuZ2tDdqAkHo6hDbNAEt6I2xX2dUYg6npK
         OzCetGs86D4NwssomRJM1eovGsGYu3eYvhvlge4B3w2Zh4YR8BypTBD3VQIjM+GrxzMF
         ERicwMDgrfmA6vqDHyH+cv4O4MYhm6DzSeCvDiaWMPEjE4LzXPA9a5pB+Nafs4XyqDNY
         K0ASnGpd7eKvOT10Z2sF565Vz6uBvp2TSpJN+A8954klT5O2zWPyGLdE0ogulmPyT2GK
         2Uu4XFoGcVCiudu5tbrKYXK7qLB+payIIPnm2VPe4SBgvjFEHAjygGI6GSwJQuW6QJ7s
         xjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=qwbXf0toY8R+zI20Q9RIRh/jJ1S8fz2bnPFNhBmfyAw=;
        b=H4KMdUuNuc+caXy41rQULPdwaYfbUuLb7uonam3csRMSMmXkX2lvxua9gLGg+raBQK
         mPr4HL6d8d9GChy3oNQOchHrMq2LbVz89wnDf1tY/dOwKIZTZy79BVPj52QdXlnRkikb
         p0rYxtu7dF8Gxzk6k+FEm/rZo3QdXdXE1t2X1clJtE7XqD0S0aQLPFfqVnZ8FDK7Y7GZ
         niTakPtvQdfmMuBtNJsYXv5H3oW2plsy4+NMs0nGc+cr9VV77dYPfPwIUPc7pCufT30p
         JyiSvXC+9Lv0adIZTSv1ju1YI6ijypiqpjw+SZYrl9Z+1qj0xYMJmm4lZddtYTiehON9
         y3Nw==
X-Gm-Message-State: AElRT7FEo3Vy8GTiqR74rgNj/geGRs2xPZkcGaIogMdtC6PtWiM9wDT6
        irBiosQS89nUNaoimv9vhZh2zLM1
X-Google-Smtp-Source: AG47ELvkrs3vOrq/CNH4OQZnIrSc9KbaR+mWjRa3wWhBYCQiSngAjjcFFKXklFwXEQewH7Y6GC9pHQ==
X-Received: by 10.28.66.130 with SMTP id k2mr4978226wmi.15.1521133768163;
        Thu, 15 Mar 2018 10:09:28 -0700 (PDT)
Received: from FUJITSU-PCD-030.progesoft.local (151-0-155-178.ip281.fastwebnet.it. [151.0.155.178])
        by smtp.gmail.com with ESMTPSA id o2sm5282458wro.31.2018.03.15.10.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Mar 2018 10:09:27 -0700 (PDT)
From:   Michele Locati <michele@locati.it>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, michele@locati.it
Subject: [PATCH v2] filter-branch: return 2 when nothing to rewrite
Date:   Thu, 15 Mar 2018 18:09:18 +0100
Message-Id: <20180315170918.1984-1-michele@locati.it>
X-Mailer: git-send-email 2.16.2.windows.1
In-Reply-To: <20180315130359.6108-1-michele@locati.it>
References: <20180315130359.6108-1-michele@locati.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the --state-branch option allows us to perform incremental filtering.
This may lead to having nothing to rewrite in subsequent filtering, so we need
a way to recognize this case.
So, let's exit with 2 instead of 1 when this "error" occurs.

Signed-off-by: Michele Locati <michele@locati.it>
---
 Documentation/git-filter-branch.txt | 8 ++++++++
 git-filter-branch.sh                | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 3a52e4dce..b63404318 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -222,6 +222,14 @@ this purpose, they are instead rewritten to point at the nearest ancestor that
 was not excluded.
 
 
+EXIT STATUS
+-----------
+
+On success, the exit status is `0`.  If the filter can't find any commits to
+rewrite, the exit status is `2`.  On any other error, the exit status may be
+any other non-zero value.
+
+
 Examples
 --------
 
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 1b7e4b2cd..c285fdb90 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -310,7 +310,7 @@ git rev-list --reverse --topo-order --default HEAD \
 	die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
-test $commits -eq 0 && die "Found nothing to rewrite"
+test $commits -eq 0 && die_with_status 2 "Found nothing to rewrite"
 
 # Rewrite the commits
 report_progress ()
-- 
2.16.2.windows.1

