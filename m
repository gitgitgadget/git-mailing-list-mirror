Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ACE41F78F
	for <e@80x24.org>; Mon,  1 May 2017 22:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbdEAWN4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 18:13:56 -0400
Received: from [192.252.130.194] ([192.252.130.194]:5928 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751043AbdEAWNr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 18:13:47 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id 3BBF86187C;
        Mon,  1 May 2017 18:13:45 -0400 (EDT)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     Git <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 4/4] add--interactive: drop diff.indentHeuristic handling
Date:   Mon,  1 May 2017 18:13:45 -0400
Message-Id: <20170501221345.4025-5-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.13.0.rc1.15.gf67d331ad
In-Reply-To: <20170501221345.4025-1-marcnarc@xiplink.com>
References: <20170429131439.ohgren3i7xr4tjex@sigill.intra.peff.net>
 <20170501221345.4025-1-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Now that diff.indentHeuristic is handled automatically by the plumbing
commands, there's no need to propagate it manually.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 git-add--interactive.perl | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 709a5f6ce..79d675b5b 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -46,7 +46,6 @@ my ($diff_new_color) =
 my $normal_color = $repo->get_color("", "reset");
 
 my $diff_algorithm = $repo->config('diff.algorithm');
-my $diff_indent_heuristic = $repo->config_bool('diff.indentheuristic');
 my $diff_filter = $repo->config('interactive.difffilter');
 
 my $use_readkey = 0;
@@ -730,9 +729,6 @@ sub parse_diff {
 	if (defined $diff_algorithm) {
 		splice @diff_cmd, 1, 0, "--diff-algorithm=${diff_algorithm}";
 	}
-	if ($diff_indent_heuristic) {
-		splice @diff_cmd, 1, 0, "--indent-heuristic";
-	}
 	if (defined $patch_mode_revision) {
 		push @diff_cmd, get_diff_reference($patch_mode_revision);
 	}
-- 
2.13.0.rc1.15.gf67d331ad

