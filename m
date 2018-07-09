Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBE1A1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933100AbeGIT0Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:26:16 -0400
Received: from s019.cyon.net ([149.126.4.28]:33914 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932813AbeGIT0D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sNojZQB150U80BZ9+jE3OreeUKXbZ+a9UBgJdI7Og94=; b=TAQp+KQbrM3nUEE+lR/6bJouaX
        UVnnBB5cXwwyb/jS2HrcEisCm3eD+AlEFPWQjhada8CuDuIiBK5OO835F5MU/OhnoBjl0HO5BoX8H
        n70jYxcRaOBbO1g/WZ7jpRGtZl1vZpf3b0srPrpPJbr4aS07iz/bwnA2f8lEE4ZmYOoUnfw8ksg62
        hIUJFDzNCbDU7Xsbl1HCyf5F50CSf4cNOJJkVqYIyE6444vPKyUYs8IBbW96G80hwI/sdIp0f7W6e
        5LYltDsQMAXFnWreelBKu3eH4TlAYXKbHWNenZZXB56+2kW9+QnA0aw4dt0s+3Fs4Zeo1c/yr7upF
        3fG/dwKQ==;
Received: from [10.20.10.233] (port=12206 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fcbnL-00Ck4G-Qw; Mon, 09 Jul 2018 21:26:01 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 80E31234EA; Mon,  9 Jul 2018 21:25:59 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 4/6] sequencer.c: avoid empty statements at top level
Date:   Mon,  9 Jul 2018 21:25:35 +0200
Message-Id: <20180709192537.18564-5-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180708144342.11922-1-dev+git@drbeat.li>
References: <20180708144342.11922-1-dev+git@drbeat.li>
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The macro GIT_PATH_FUNC expands to a function definition that ends with
a closing brace. Remove two extra semicolons.

While at it, fix the example in path.h.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 path.h      | 2 +-
 sequencer.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/path.h b/path.h
index 1ccd0373c9..fc9d3487a0 100644
--- a/path.h
+++ b/path.h
@@ -147,7 +147,7 @@ extern void report_linked_checkout_garbage(void);
 /*
  * You can define a static memoized git path like:
  *
- *    static GIT_PATH_FUNC(git_path_foo, "FOO");
+ *    static GIT_PATH_FUNC(git_path_foo, "FOO")
  *
  * or use one of the global ones below.
  */
diff --git a/sequencer.c b/sequencer.c
index 5354d4d51e..66e7073995 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -62,12 +62,12 @@ static GIT_PATH_FUNC(rebase_path_done, "rebase-merge/done")
  * The file to keep track of how many commands were already processed (e.g.
  * for the prompt).
  */
-static GIT_PATH_FUNC(rebase_path_msgnum, "rebase-merge/msgnum");
+static GIT_PATH_FUNC(rebase_path_msgnum, "rebase-merge/msgnum")
 /*
  * The file to keep track of how many commands are to be processed in total
  * (e.g. for the prompt).
  */
-static GIT_PATH_FUNC(rebase_path_msgtotal, "rebase-merge/end");
+static GIT_PATH_FUNC(rebase_path_msgtotal, "rebase-merge/end")
 /*
  * The commit message that is planned to be used for any changes that
  * need to be committed following a user interaction.
-- 
2.18.0.203.gfac676dfb9

