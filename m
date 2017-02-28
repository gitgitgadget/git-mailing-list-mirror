Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6C3E201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 12:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbdB1MQa (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 07:16:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:35528 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752107AbdB1MQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 07:16:26 -0500
Received: (qmail 22063 invoked by uid 109); 28 Feb 2017 12:07:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 12:07:45 +0000
Received: (qmail 25336 invoked by uid 111); 28 Feb 2017 12:07:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 07:07:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 07:07:43 -0500
Date:   Tue, 28 Feb 2017 07:07:43 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: [PATCH 3/8] strbuf_branchname: add docstring
Message-ID: <20170228120743.jrqulh2nts2m7xmu@sigill.intra.peff.net>
References: <20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function and its companion, strbuf_check_branch_ref(),
did not have their purpose or semantics explained. Let's do
so.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/strbuf.h b/strbuf.h
index 47df0500d..6b51b2604 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -560,7 +560,22 @@ static inline void strbuf_complete_line(struct strbuf *sb)
 	strbuf_complete(sb, '\n');
 }
 
+/*
+ * Copy "name" to "sb", expanding any special @-marks as handled by
+ * interpret_branch_name(). The result is a non-qualified branch name
+ * (so "foo" or "origin/master" instead of "refs/heads/foo" or
+ * "refs/remotes/origin/master").
+ *
+ * Note that the resulting name may not be a syntactically valid refname.
+ */
 extern void strbuf_branchname(struct strbuf *sb, const char *name);
+
+/*
+ * Like strbuf_branchname() above, but confirm that the result is
+ * syntactically valid to be used as a local branch name in refs/heads/.
+ *
+ * The return value is "0" if the result is valid, and "-1" otherwise.
+ */
 extern int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
 extern void strbuf_addstr_urlencode(struct strbuf *, const char *,
-- 
2.12.0.359.gd4c8c42e9

