Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC1632070F
	for <e@80x24.org>; Mon, 19 Sep 2016 13:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760536AbcISNJU (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 09:09:20 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:56977 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758261AbcISNJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 09:09:16 -0400
Received: (qmail 23131 invoked from network); 19 Sep 2016 13:09:14 -0000
Received: (qmail 29945 invoked from network); 19 Sep 2016 13:09:14 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 19 Sep 2016 13:09:12 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>
Subject: [PATCH 2/6] i18n: connect: mark die messages for translation
Date:   Mon, 19 Sep 2016 13:08:17 +0000
Message-Id: <1474290501-2743-2-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt>
References: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark messages passed to die() in die_initial_contact().

Update test to reflect changes.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 connect.c            | 8 ++++----
 t/t5512-ls-remote.sh | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/connect.c b/connect.c
index 722dc3f..06bff0b 100644
--- a/connect.c
+++ b/connect.c
@@ -46,11 +46,11 @@ int check_ref_type(const struct ref *ref, int flags)
 static void die_initial_contact(int got_at_least_one_head)
 {
 	if (got_at_least_one_head)
-		die("The remote end hung up upon initial contact");
+		die(_("The remote end hung up upon initial contact"));
 	else
-		die("Could not read from remote repository.\n\n"
-		    "Please make sure you have the correct access rights\n"
-		    "and the repository exists.");
+		die(_("Could not read from remote repository.\n\n"
+		      "Please make sure you have the correct access rights\n"
+		      "and the repository exists."));
 }
 
 static void parse_one_symref_info(struct string_list *symref, const char *val, int len)
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 819b9dd..c23434b 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -99,7 +99,7 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 	# We could just as easily have used "master"; the "*" emphasizes its
 	# role as a pattern.
 	test_must_fail git ls-remote refs*master >actual 2>&1 &&
-	test_cmp exp actual
+	test_i18ncmp exp actual
 '
 
 test_expect_success 'die with non-2 for wrong repository even with --exit-code' '
-- 
2.7.4

