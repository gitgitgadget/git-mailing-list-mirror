Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92FE320248
	for <e@80x24.org>; Fri, 22 Mar 2019 23:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfCVXMg (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 19:12:36 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:36310
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726056AbfCVXMf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Mar 2019 19:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1553296354;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=jJV6h1D4OFFg6zuqgasAXFR6F/Z3p1JGZJptWBuh+5o=;
        b=WPelSpDFvYhJQGdw5xxbBwtGDNbJN2091AVTUndeConkCOAH3MvzwEH/NQ4X26sU
        deNVxMYs6F4WObzn54ehP8MmhW1RNdp66qXl/7Ft02E+iLomNFXn+BbeXqD7KYkhYsN
        zRUlGejwbjWzQ8mQCYpraHhW8C5ITdibQUVZoLAY=
From:   Keith Smiley <keithbsmiley@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020169a7ad6af3-ad50e2d1-19fb-46eb-b397-759f8d579e8b-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Make stashing nothing exit 1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Mar 2019 23:12:34 +0000
X-SES-Outgoing: 2019.03.22-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the case there are no files to stash, but the user asked to stash, we
should exit 1 since the stashing failed.
---
 git-stash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 789ce2f41d4a3..ca362b1a31277 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -318,7 +318,7 @@ push_stash () {
 	if no_changes "$@"
 	then
 		say "$(gettext "No local changes to save")"
-		exit 0
+		exit 1
 	fi
 
 	git reflog exists $ref_stash ||

--
https://github.com/git/git/pull/587
