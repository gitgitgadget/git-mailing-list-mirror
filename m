Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABA391F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 10:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeCTKLb (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 06:11:31 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:42472 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752555AbeCTKLX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 06:11:23 -0400
Received: from lindisfarne.localdomain ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yEEeeoX3nwheayEEkepmVc; Tue, 20 Mar 2018 10:11:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521540682;
        bh=JN6tm1/eFDzlJ9cij3EmqsklqygsleA+GnFhoMMOjBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=nvvk2xDJ1GBchG/vb30mXiv8RlwvkKa4VMfKpIuoEti/mP4ENCfOCls9rymHkLYAz
         A+VKjCo88UKJeIjJbfT2qLHfJLYThw/+TM9BeoFECUfYrRSCVQ1j8XPlP2rU4Swn/p
         mXMMK0kj9zwCaQKpLmMYb2Tm0PGKNeGeGQy7uFCg=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=evINK-nbAAAA:8 a=CetYfRad01Jzwee36Q8A:9
 a=bKVrrO9k-L5Jmzy2:21 a=qhQ4cclmUCcAGj-F:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/2] add failing test for rebase --recreate-merges --keep-empty
Date:   Tue, 20 Mar 2018 10:11:13 +0000
Message-Id: <20180320101114.17663-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320101114.17663-1-phillip.wood@talktalk.net>
References: <20180320101114.17663-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKvGpbgyEarOy+Bcue6/LLyNpdFoFJw7bQmnqjXkOLN7p+3/4vZB5yjRIQ+NMuEdT2b44m6L0dkKe6YXRsuGoWE7SMpxu+03lVDmZ/a0xz/1cRK5Dd7+
 duFQ7szCreUQdWZMaLYzmnBFL9DklhFZJYnmKrQJUlSP0BkoJ/01B+tlpXzcRUwcB7OM7un7gc9B7FoUZuynIVSskTBhTMjbmft1VFfLlQlx8y9Nuf7syhaD
 cXL/JuAQ6R9pDLDopWMSGvL4cuxJcg0wE5QOBHFxikQ3mQY+fqbpcwraFvbBFit8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there are empty commits on the left hand side of $upstream...HEAD
then the empty commits on the right hand side that we want to keep are
being pruned. This will be fixed in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3421-rebase-topology-linear.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 68fe2003ef..cb7f176f1d 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -217,6 +217,7 @@ test_run_rebase success ''
 test_run_rebase failure -m
 test_run_rebase failure -i
 test_run_rebase failure -p
+test_run_rebase failure --recreate-merges
 
 #       m
 #      /
-- 
2.16.2

