Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B401F453
	for <e@80x24.org>; Wed, 31 Oct 2018 10:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeJaTNg (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 15:13:36 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:43551 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbeJaTNf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 15:13:35 -0400
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id HnXagXodRpXFjHnXggCXrC; Wed, 31 Oct 2018 10:16:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1540980965;
        bh=V98OIZ9/wcZEy6Q93qylF+8qhLCcXXMbKsMwFt8Ajes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=AiYJWHiScdWXhOv8wV7bHnejdqBS5IqRhW1+iiaD9Zm2OMteVwJCOy4j96JqUvXXq
         RXk6lBLMJzrJP+AWWUvl3KF/RJeaZ0ax6J7bbOv81kdSe4hHOwMoHBLYg9qiZENlNu
         b+CacvC9qT8dakg4vlHF9i5cgIFNOVReKtLyA8QA=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=jAbL0x3HlbHIGo4u6YsA:9
 a=2pq0VG0WY9_6zSxb:21 a=q43gRipxSBSK2way:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 3/5] am: rename read_author_script()
Date:   Wed, 31 Oct 2018 10:15:54 +0000
Message-Id: <20181031101556.27169-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181031101556.27169-1-phillip.wood@talktalk.net>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20181031101556.27169-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfH0WBvjXayG5EUSWJso4ZfaPJU67mQCEnXoPAKnr1QcPOjkbwvgXGlSJAMtxgAvJPFLuqOAiyBu9tjSv3AxxCmL9PjKFp5YvIQ6OyzTszjLL2mAJ2Qlv
 Ct9xc1/ULR0DhLQC3mdwMc7wsP3v+HITrPNf2opnE2A5g9HKqFSFWUTmHtHSqvNm4iASiyPKH992qt1DPkfwC6Yg6Lammi6J5niOdjvx2BJvNHJ1p8m2ZD8P
 MjWGC43LUV2q9ixjIs00jJhMDtYD73ta8ihSbxQBJY7Ghx5fiBDABssfWd3v2cBsHH+FDrOCJhRykxFJznKrtCdHWHPFUXYTY6nMSqmqFpo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rename read_author_script() in preparation for adding a shared
read_author_script() function to libgit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/am.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index d42b725273..991d13f9a2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -306,7 +306,7 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
  * script, and thus if the file differs from what this function expects, it is
  * better to bail out than to do something that the user does not expect.
  */
-static int read_author_script(struct am_state *state)
+static int read_am_author_script(struct am_state *state)
 {
 	const char *filename = am_path(state, "author-script");
 	struct strbuf buf = STRBUF_INIT;
@@ -441,7 +441,7 @@ static void am_load(struct am_state *state)
 		BUG("state file 'last' does not exist");
 	state->last = strtol(sb.buf, NULL, 10);
 
-	if (read_author_script(state) < 0)
+	if (read_am_author_script(state) < 0)
 		die(_("could not parse author script"));
 
 	read_commit_msg(state);
-- 
2.19.1

