Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4B0E20986
	for <e@80x24.org>; Mon, 10 Oct 2016 12:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbcJJMzo (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 08:55:44 -0400
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:37496 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752220AbcJJMzn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 08:55:43 -0400
Received: (qmail 11277 invoked from network); 10 Oct 2016 12:55:41 -0000
Received: (qmail 13505 invoked from network); 10 Oct 2016 12:55:40 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 10 Oct 2016 12:55:38 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 02/14] i18n: add--interactive: mark simple here-documents for translation
Date:   Mon, 10 Oct 2016 12:54:37 +0000
Message-Id: <20161010125449.7929-3-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.396.g621fe23
In-Reply-To: <20161010125449.7929-1-vascomalmeida@sapo.pt>
References: <20161010125449.7929-1-vascomalmeida@sapo.pt>
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark messages in here-document without interpolation for translation.

The here-document delimiter \EOF, which is the same as 'EOF', indicate
that the text is to be treated literally without interpolation of its
content.  Unfortunately xgettext is not able to extract here documents
with delimiter \EOF but it is with delimiter enclosed in single quotes.
Then change \EOF to 'EOF', although in this case does not make
difference what variation of here-document to use since there is nothing
to interpolate.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-add--interactive.perl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index cf216ec..5800010 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -639,7 +639,7 @@ sub list_and_choose {
 }
 
 sub singleton_prompt_help_cmd {
-	print colored $help_color, <<\EOF ;
+	print colored $help_color, __ <<'EOF' ;
 Prompt help:
 1          - select a numbered item
 foo        - select item based on unique prefix
@@ -648,7 +648,7 @@ EOF
 }
 
 sub prompt_help_cmd {
-	print colored $help_color, <<\EOF ;
+	print colored $help_color, __ <<'EOF' ;
 Prompt help:
 1          - select a single item
 3-5        - select a range of items
@@ -1584,7 +1584,9 @@ sub quit_cmd {
 }
 
 sub help_cmd {
-	print colored $help_color, <<\EOF ;
+# TRANSLATORS: please do not translate the command names
+# 'status', 'update', 'revert', etc.
+	print colored $help_color, __ <<'EOF' ;
 status        - show paths with changes
 update        - add working tree state to the staged set of changes
 revert        - revert staged set of changes back to the HEAD version
-- 
2.7.4

