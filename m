Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7F11FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 09:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965367AbeAJJhq (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 04:37:46 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:48806
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755987AbeAJJgn (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jan 2018 04:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515577001;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=aq5zsjJbI/b7MSVUj1dQ0wsa6ves2p66kj3KDFsTwHo=;
        b=CsPkKO4d0Kd9VUTMAgLiw+8XZBoKBspFzDmgc4P0atMRuPpPgB8OXxZqkqmZJR2M
        7AaOYvt7FFjhkgtI3NTiZfXZiTiOTfIy1HbrkvLFng6kFodyzAG9mQusWDaaUufj24W
        F6V092QSgol2CtL3ul3gW80g/oaFZCAxgoQF+jC4=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160df6dc580-335fa6d5-a506-49b7-a326-d85cb87af75b-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 10/18] cat-file: get rid of duplicate checking
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jan 2018 09:36:41 +0000
X-SES-Outgoing: 2018.01.10-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We could remove this because we have already checked that
at verify_ref_format function in ref-filter.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index dd43457c0ad7e..1f331559e55c7 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -197,8 +197,6 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		strbuf_addstr(sb, data->rest);
 	else if (is_atom("deltabase", atom, len))
 		strbuf_addstr(sb, oid_to_hex(&data->delta_base_oid));
-	else
-		die("unknown format element: %.*s", len, atom);
 }
 
 static size_t expand_format(struct strbuf *sb, const char *start, void *vdata)

--
https://github.com/git/git/pull/450
