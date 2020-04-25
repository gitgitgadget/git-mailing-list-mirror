Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975CDC2BA1A
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E0C20776
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgDYCSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:18:00 -0400
Received: from aibo.runbox.com ([91.220.196.211]:58926 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgDYCSA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 22:18:00 -0400
Received: from [10.9.9.202] (helo=mailfront20.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1jSAOD-0000W5-GP; Sat, 25 Apr 2020 04:17:57 +0200
Received: by mailfront20.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1jSAO2-0004I7-Nb; Sat, 25 Apr 2020 04:17:47 +0200
From:   Emma Brooks <me@pluvano.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Namhyung Kim <namhyung@gmail.com>, Emma Brooks <me@pluvano.com>
Subject: [PATCH] gitweb: Recognize *-to and Closes/Fixes trailers
Date:   Sat, 25 Apr 2020 02:17:23 +0000
Message-Id: <20200425021723.16346-1-me@pluvano.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit trailers like "Thanks-to:", "Fixes:", and "Closes:" are fairly
common, but gitweb didn't highlight them like other trailers.

Signed-off-by: Emma Brooks <me@pluvano.com>
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1a02a1242d..0959a782ec 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4641,7 +4641,7 @@ sub git_print_log {
 	# print log
 	my $skip_blank_line = 0;
 	foreach my $line (@$log) {
-		if ($line =~ m/^\s*([A-Z][-A-Za-z]*-[Bb]y|C[Cc]): /) {
+		if ($line =~ m/^\s*([A-Z][-A-Za-z]*-([Bb]y|[Tt]o)|C[Cc]|(Clos|Fix)es): /) {
 			if (! $opts{'-remove_signoff'}) {
 				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
 				$skip_blank_line = 1;
