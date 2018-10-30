Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9BAD1F454
	for <e@80x24.org>; Tue, 30 Oct 2018 10:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeJ3Tc0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 15:32:26 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:51848 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeJ3TcW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 15:32:22 -0400
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id HRQbg5GIzdJAeHRQjgS6Mv; Tue, 30 Oct 2018 10:39:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1540895965;
        bh=V98OIZ9/wcZEy6Q93qylF+8qhLCcXXMbKsMwFt8Ajes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=NLX898JTllOUaRuQglkPE/3a2uw//jVNUZqvZeTMhvLW4ki0Nc8l6chbcp0fQ9Goo
         RtX8M6qySIHXEo6boU7KsKzRs6QKxEQS5npJ4NA4+Dg69ys81mfBJyy4NrsgRQt1XV
         Uiqsgii6YRz15Y4U8yhrKXHiTGZw7PI7TNwMFTBU=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=jAbL0x3HlbHIGo4u6YsA:9
 a=2pq0VG0WY9_6zSxb:21 a=q43gRipxSBSK2way:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 3/5] am: rename read_author_script()
Date:   Tue, 30 Oct 2018 10:39:14 +0000
Message-Id: <20181030103916.6241-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181030103916.6241-1-phillip.wood@talktalk.net>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20181030103916.6241-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCWbeC7Y5QWISaNlSVo2M+qNSfkTjm9kRP7V/5SvTaiqgu/vY9LXDWBcS59uv2NYw0PoZnA1RNPghBj1yg4u/jJcnDQffHLXJsb7jy57NZ/UFDHIZFl3
 S+RIjQOuxCE130CeDrJPilfV4LbNVsJKdbSckn5s1UtYlPwmOjKya3gL166cKN+lzk3xe8awZIvCnWKeMhLSAXgUbhOASnlV9Fn+mcqeb/mLKKE9QWMsY3k4
 vAkamf87lrnP8DabyCJbkI9gO7RDVOzNF7XNhDxZy6lN+ASHJ6ySblrBarxDTHM6ciN4/gzXxXxDDSVL2N4G8tLeoFNmUFb46R02Gezq+Ek=
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

