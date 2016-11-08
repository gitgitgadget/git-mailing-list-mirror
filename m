Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70C12022C
	for <e@80x24.org>; Tue,  8 Nov 2016 12:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933253AbcKHMLu (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 07:11:50 -0500
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:55398 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932503AbcKHMLr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 07:11:47 -0500
Received: (qmail 16362 invoked from network); 8 Nov 2016 12:11:44 -0000
Received: (qmail 7910 invoked from network); 8 Nov 2016 12:11:44 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 Nov 2016 12:11:44 -0000
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
Subject: [PATCH v5 01/16] Git.pm: add subroutines for commenting lines
Date:   Tue,  8 Nov 2016 11:08:08 -0100
Message-Id: <20161108120823.11204-2-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.11.0.rc0.23.g8236252
In-Reply-To: <20161108120823.11204-1-vascomalmeida@sapo.pt>
References: <20161108120823.11204-1-vascomalmeida@sapo.pt>
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add subroutines prefix_lines and comment_lines.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 perl/Git.pm | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/perl/Git.pm b/perl/Git.pm
index b2732822a..17be59fb7 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1438,6 +1438,29 @@ sub END {
 
 } # %TEMP_* Lexical Context
 
+=item prefix_lines ( PREFIX, STRING )
+
+Prefixes lines in C<STRING> with C<PREFIX>.
+
+=cut
+
+sub prefix_lines {
+	my ($prefix, $string) = @_;
+	$string =~ s/^/$prefix/mg;
+	return $string;
+}
+
+=item comment_lines ( STRING )
+
+Comments lines following core.commentchar configuration.
+
+=cut
+
+sub comment_lines {
+	my $comment_line_char = config("core.commentchar") || '#';
+	return prefix_lines("$comment_line_char ", @_);
+}
+
 =back
 
 =head1 ERROR HANDLING
-- 
2.11.0.rc0.23.g8236252

