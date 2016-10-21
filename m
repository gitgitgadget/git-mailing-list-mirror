Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_PH_SURBL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0304820986
	for <e@80x24.org>; Fri, 21 Oct 2016 09:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933935AbcJUJUn (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 05:20:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50188 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933900AbcJUJUk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 05:20:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u9L9KUOS027387
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 21 Oct 2016 11:20:30 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u9L9KUiL009711;
        Fri, 21 Oct 2016 11:20:30 +0200
From:   Matthieu Moy <Matthieu.Moy@imag.fr>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] t9000-addresses: update expected results after fix
Date:   Fri, 21 Oct 2016 11:20:23 +0200
Message-Id: <20161021092024.15861-1-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 2.10.1.651.gffd0de0
In-Reply-To: <xmqq1szaeda9.fsf@gitster.mtv.corp.google.com>
References: <xmqq1szaeda9.fsf@gitster.mtv.corp.google.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Fri, 21 Oct 2016 11:20:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u9L9KUOS027387
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1477646432.18986@I6p0N6Low8w5bQy9rOPOyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

e3fdbcc8e1 (parse_mailboxes: accept extra text after <...> address,
2016-10-13) improved our in-house address parser and made it closer to
Mail::Address. As a consequence, some tests comparing it to
Mail::Address now pass, but e3fdbcc8e1 forgot to update the test.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t9000/test.pl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9000/test.pl b/t/t9000/test.pl
index 2d05d3eeab..dfeaa9c655 100755
--- a/t/t9000/test.pl
+++ b/t/t9000/test.pl
@@ -32,15 +32,15 @@ my @success_list = (q[Jane],
 	q["Jane\" Doe" <jdoe@example.com>],
 	q[Doe, jane <jdoe@example.com>],
 	q["Jane Doe <jdoe@example.com>],
-	q['Jane 'Doe' <jdoe@example.com>]);
+	q['Jane 'Doe' <jdoe@example.com>],
+	q[Jane@:;\.,()<>Doe <jdoe@example.com>],
+	q[Jane <jdoe@example.com> Doe],
+	q[<jdoe@example.com> Jane Doe]);
 
 my @known_failure_list = (q[Jane\ Doe <jdoe@example.com>],
 	q["Doe, Ja"ne <jdoe@example.com>],
 	q["Doe, Katarina" Jane <jdoe@example.com>],
-	q[Jane@:;\.,()<>Doe <jdoe@example.com>],
 	q[Jane jdoe@example.com],
-	q[<jdoe@example.com> Jane Doe],
-	q[Jane <jdoe@example.com> Doe],
 	q["Jane "Kat"a" ri"na" ",Doe" <jdoe@example.com>],
 	q[Jane Doe],
 	q[Jane "Doe <jdoe@example.com>"],
-- 
2.10.1.651.gffd0de0

