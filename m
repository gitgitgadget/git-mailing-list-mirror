Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E715320281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbdISGWr (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:22:47 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64765 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751341AbdISGWp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:22:45 -0400
X-AuditID: 1207440d-853ff70000000f42-11-59c0b7b01e38
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.1B.03906.0B7B0C95; Tue, 19 Sep 2017 02:22:40 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1Z002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:22:38 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/21] prefix_ref_iterator: break when we leave the prefix
Date:   Tue, 19 Sep 2017 08:22:10 +0200
Message-Id: <2bb2e8ccb57eef8acbea5004167751a007a1bd2f.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqLth+4FIgzmNshZrn91hsni+/gS7
        RdeVbiaLht4rzBb9y7vYLG6vmM9s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8PH+M8
        Fmwq9XjWu4fR4+IlZY/Pm+QC2KO4bFJSczLLUov07RK4Mha98C/oF6q4dH8vcwPjSr4uRk4O
        CQETibalHaxdjFwcQgI7mCSW9Oxlh3BOMUk8/juBBaSKTUBXYlFPMxOILSKgJjGx7RALSBGz
        wEpmiUlbr7CCJIQFfCUa535jB7FZBFQlbty9CtbAKxAl8fFoCyPEOnmJcw9uM4PYnAIWEs17
        tgMN4gDaZi5x4GjxBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0UlNKNzFC
        Ao53B+P/dTKHGAU4GJV4eAWu7Y8UYk0sK67MPcQoycGkJMobtulApBBfUn5KZUZicUZ8UWlO
        avEhRgkOZiUR3kOLgHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQle
        RWBkCQkWpaanVqRl5pQgpJk4OEGG8wANVwGp4S0uSMwtzkyHyJ9i1OXouHn3D5MQS15+XqqU
        OO/nrUBFAiBFGaV5cHNgieIVozjQW8K8DduAqniASQZu0iugJUxAS7I3gC0pSURISTUw+oQX
        sersPT7rV+KGk0+33V+0QlQ5butJt2kHpqecvWvbJtWwwD+sJ2jmdveymfYrS+p23+DkatX+
        u2RzwyNlucKO8P1rd4XoWy57ynTq3u6fAlMOmxSVPTOc99zUvoVjmqqOeZiud1zQkYolU39I
        8hr2Wnqe4++duqF4ls7eWfmTXxsvev/hrxJLcUaioRZzUXEiAGqUmMLvAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

If the underlying iterator is ordered, then `prefix_ref_iterator` can
stop as soon as it sees a refname that comes after the prefix. This
will rarely make a big difference now, because `ref_cache_iterator`
only iterates over the directory containing the prefix (and usually
the prefix will span a whole directory anyway). But if *hint, hint* a
future reference backend doesn't itself know where to stop the
iteration, then this optimization will be a big win.

Note that there is no guarantee that the underlying iterator doesn't
include output preceding the prefix, so we have to skip over any
unwanted references before we get to the ones that we want.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/iterator.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/refs/iterator.c b/refs/iterator.c
index c475360f0a..bd35da4e62 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -287,6 +287,20 @@ struct prefix_ref_iterator {
 	int trim;
 };
 
+/* Return -1, 0, 1 if refname is before, inside, or after the prefix. */
+static int compare_prefix(const char *refname, const char *prefix)
+{
+	while (*prefix) {
+		if (*refname != *prefix)
+			return ((unsigned char)*refname < (unsigned char)*prefix) ? -1 : +1;
+
+		refname++;
+		prefix++;
+	}
+
+	return 0;
+}
+
 static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 {
 	struct prefix_ref_iterator *iter =
@@ -294,9 +308,25 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	int ok;
 
 	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
-		if (!starts_with(iter->iter0->refname, iter->prefix))
+		int cmp = compare_prefix(iter->iter0->refname, iter->prefix);
+
+		if (cmp < 0)
 			continue;
 
+		if (cmp > 0) {
+			/*
+			 * If the source iterator is ordered, then we
+			 * can stop the iteration as soon as we see a
+			 * refname that comes after the prefix:
+			 */
+			if (iter->iter0->ordered) {
+				ok = ref_iterator_abort(iter->iter0);
+				break;
+			} else {
+				continue;
+			}
+		}
+
 		if (iter->trim) {
 			/*
 			 * It is nonsense to trim off characters that
-- 
2.14.1

