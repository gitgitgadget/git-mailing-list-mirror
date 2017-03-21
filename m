Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B2052095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757284AbdCUNAx (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:00:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33829 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756897AbdCUNAv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:00:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id u132so2771420wmg.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rTySXPoAE4JFQqMnzfgOwSDn1jLpZf405cxkoeJliKc=;
        b=OY3QQtW2zJ5drMyLXWrHOGOgE9TQTH/y9I9iH8vZ+0/1uK0SQ8uDw93LYGxVu6Y71S
         CC0FLF5mIKzun/H2VYpQIYu0JkZ5veLPtdmdqhuzZHdsH9mP4NjBfBgFyjIaZsx/XtNb
         09NH59ekUPPEAjmcBPJkbhRsgvLI4tqIuLCMjXh5/RyivmNC7htV3hEgMngqhVFrJJCe
         5TQYS9jalAH+leikZ45I4pugVmggnqA4+JOqtjV2gnKuR5DanvntmgApc96sXg/Wvk/B
         xZfNrClKrUVm2LU/B1ZsoaM2RDdrCSCb9mLilrlZh7Do0hOZ7NHcLlKP+0I4wATXOa9O
         j9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rTySXPoAE4JFQqMnzfgOwSDn1jLpZf405cxkoeJliKc=;
        b=OzsAEMdywXsUF2VGK3BSHf5hZTLxzqv0AHZL38XuDNp5iShP+remd3/NgOgRpt5CfC
         GNS3V1ivbwRAr62Wy9TnWBa69DusZnnR5WdQXaexW59Q+lcdCogkZn2OSRRg1ZBZChsb
         QWygTDoWQiDyl65cmyZpOaQZuIxqr1vbEienQ2EVtPruuE4jTfbGRfejdJ20eyyX7if5
         hEf10AqkvTq3ZQAh+/k8VRF7DzuAYBXAUnFNM1ltSRiJuJ3K5ofsE160ZoBYgs4kbUa+
         SmRRrMl/MtPFDgxABVTiEnttF2fJLDBnsIZ/PIdsjvQhEfLRn+nmIiJlINxjG+A1jCfZ
         eDDA==
X-Gm-Message-State: AFeK/H3ItXqPn7iAU+4vl0KxIP/qfTtukc+6gDddUmFIW+j+Y27b0QwSB3GWOCZgP0QWPA==
X-Received: by 10.28.129.212 with SMTP id c203mr2645726wmd.19.1490101178867;
        Tue, 21 Mar 2017 05:59:38 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.05.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 05:59:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/16] tag doc: split up the --[no-]merged documentation
Date:   Tue, 21 Mar 2017 12:58:47 +0000
Message-Id: <20170321125901.10652-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170321125901.10652-1-avarab@gmail.com>
References: <20170321125901.10652-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the --[no-]merged documentation into documentation that
documents each option independently. This is in line with how "branch"
and "for-each-ref" are documented, and makes subsequent changes to
discuss the limits & caveats of each option easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 33f18ea5fb..68b0ab2410 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -124,10 +124,13 @@ This option is only applicable when listing tags without annotation lines.
 	Only list tags which contain the specified commit (HEAD if not
 	specified).
 
---[no-]merged [<commit>]::
-	Only list tags whose tips are reachable, or not reachable
-	if `--no-merged` is used, from the specified commit (`HEAD`
-	if not specified).
+--merged [<commit>]::
+	Only list tags whose tips are reachable from the specified commit
+	(`HEAD` if not specified).
+
+--no-merged [<commit>]::
+	Only list tags whose tips are not reachable from the specified
+	commit (`HEAD` if not specified).
 
 --points-at <object>::
 	Only list tags of the given object.
-- 
2.11.0

