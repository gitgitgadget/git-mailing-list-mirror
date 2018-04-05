Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406F51F404
	for <e@80x24.org>; Thu,  5 Apr 2018 03:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeDEDKj (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 23:10:39 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:58272
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750853AbeDEDKi (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Apr 2018 23:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1522897837;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Z3I5gv5DQj8op72/3gHigP3z/MOmmGzgUBGwaizH7No=;
        b=HDTa1FC4fQzqlKKvUkzOzWJHYSpx2A+WRaSwWKVZ0trLnA2xzeegclreSaQLigZg
        Cu8xnjdLzbhlQch76nsOas5ebSVnzw2d/0Wq26Ea9NTtg0M1cWNRh9IZ5O5L4ZvvbOH
        VNKrC7MGb8RZ/ACJ8dDOAAhtZHfu53CWkhTpWV58=
From:   Stephon Harris <theonestep4@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016293c8dca7-6626fcde-548d-476e-b61f-c83ecdeedfe1-000000@eu-west-1.amazonses.com>
Subject: [PATCH] specify encoding for sed command
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 5 Apr 2018 03:10:37 +0000
X-SES-Outgoing: 2018.04.05-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes issue with seeing `sed: RE error: illegal byte sequence` when running git-completion.bash
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b09c8a23626b4..52a4ab5e2165a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -282,7 +282,7 @@ __gitcomp ()
 
 # Clear the variables caching builtins' options when (re-)sourcing
 # the completion script.
-unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
+unset $(set |LANG=C sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
 
 # This function is equivalent to
 #

--
https://github.com/git/git/pull/481
