Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FDE51F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 10:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeCTKDj (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 06:03:39 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:21260 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeCTKD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 06:03:27 -0400
Received: from lindisfarne.localdomain ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yE6xeoWARwheayE73epmBA; Tue, 20 Mar 2018 10:03:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521540205;
        bh=ir3N2monOxV8jMmlLQaLFsIqzuwP/YtqXQbnZeDX+vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=aeoEXjnksWsa7Gcu+p24FnFrbDt4Efsr7vLH/ZoR/4Eh3fccumo+VqTakvCSazp0f
         ucUwBOP/dD2TQD7LYEO/6XXw6rTCjI35+Ersp8JgbAae6kJm/rr6H82GMy+gCdSPHi
         PR2ySz51hpnJrTaXlMnHDa4sOL7pCNNPGeoAk+50=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=evINK-nbAAAA:8 a=sEaxSGsqlxX0m4mQMwsA:9
 a=50oZvINKe17K4m84:21 a=MpvaC7RdgplDIJWA:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/3] rebase --root: stop assuming squash_onto is unset
Date:   Tue, 20 Mar 2018 10:03:13 +0000
Message-Id: <20180320100315.15261-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320100315.15261-1-phillip.wood@talktalk.net>
References: <20180320100315.15261-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKpbV2abLDDUnnR2qMMKfs9GD9A4DfE6+Il3g+p43Fd3/+LouYslK7Rn9jUb1qG3HTxJqui4tjDPGjs8ny0OCmVMjNACZmb+tsAbaT6kxeLtX5Wt4zXb
 LxqHTFXTdulB8E8U92xW0fVMN8u/NDCbWLWJcakTq1pKUjZQba1jZP/x9o/zURFRDJt9+RjN1RO6dAyMmYx2k/jyYZd0QUi+oQrKqE81ZZrA4wUtjcY1TaxO
 7TD2F8KLGbqYp8WrNbX9TJQWg03bjgihED0MuEjK5EHIn/Gf1dRU/ro1iD2aEcr+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the user set the environment variable 'squash_onto', the 'rebase'
command would erroneously assume that the user passed the option
'--root'.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-rebase.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index fd72a35c65..8b1b892d72 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -60,6 +60,7 @@ $(gettext 'Resolve all conflicts manually, mark them as resolved with
 You can instead skip this commit: run "git rebase --skip".
 To abort and get back to the state before "git rebase", run "git rebase --abort".')
 "
+squash_onto=
 unset onto
 unset restrict_revision
 cmd=
-- 
2.16.2

