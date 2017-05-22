Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 301E32023D
	for <e@80x24.org>; Mon, 22 May 2017 14:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934720AbdEVOSz (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:55 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44117 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934407AbdEVOSr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:47 -0400
X-AuditID: 1207440f-701ff700000004e5-3e-5922f3461af2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.45.01253.643F2295; Mon, 22 May 2017 10:18:46 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24P023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:44 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/25] ref_update_reject_duplicates(): use `size_t` rather than `int`
Date:   Mon, 22 May 2017 16:17:46 +0200
Message-Id: <03b1bb62322361cd83016c1d824a7f2d12ad578a.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqOv2WSnSYNV+aYu1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxty5O1gLbrFU
        XNn3lrGB8TFzFyMnh4SAicS91fuBbC4OIYEdTBI/5txghHBOMUlMe3MHrIpNQFdiUU8zE4gt
        IqAmMbHtEAtIEbPABmaJN9NXgyWEBSIk5nX+B0pwcLAIqEq03E0CMXkFoiSOnPGCWCYvsavt
        IiuIzSlgIfF71gGwTiEBc4nef6tZJjDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6KX
        m1mil5pSuokREob8Oxi71sscYhTgYFTi4dV4rBQpxJpYVlyZe4hRkoNJSZT36BugEF9Sfkpl
        RmJxRnxRaU5q8SFGCQ5mJRFe7btAOd6UxMqq1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTUgtQi
        mKwGB4fA3SW9GxilWPLy81KVJHgnfwIaIliUmp5akZaZU4JQysTBCbKIB2gR02eQRcUFibnF
        mekQ+VOMuhxz7n19zyQENkhKnNcAZJAASFFGaR7cHFhaecUoDvSiMG8hSBUPMCXBTXoFtIQJ
        aIn1M3mQJSWJCCmpBsZSgaTgpfZfGjarR9+5nXbDpN4qOkDokuuD30JrN6tyeTbaLrimdmBR
        kJeqTdbCHSV7F58OW7h9j3vg/KxPC0N2/1jsrDJFd97Kl7PiIxiFf6kKCbeIWpY/vK7asGTe
        Ly+n1skzv3MpSbFq6thfuvZw5eXZx/l3lx9nf52i5pIl+t77R0TgQyMlluKMREMt5qLiRABH
        qXbKBgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eliminate a theoretical risk of integer overflow if the two types have
different sizes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index beb49fb297..143936a9c3 100644
--- a/refs.c
+++ b/refs.c
@@ -1705,7 +1705,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int ref_update_reject_duplicates(struct string_list *refnames,
 				 struct strbuf *err)
 {
-	int i, n = refnames->nr;
+	size_t i, n = refnames->nr;
 
 	assert(err);
 
-- 
2.11.0

