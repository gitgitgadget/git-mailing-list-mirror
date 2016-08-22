Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2A21FD99
	for <e@80x24.org>; Mon, 22 Aug 2016 11:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbcHVLYS (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 07:24:18 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:59217 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754310AbcHVLYP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Aug 2016 07:24:15 -0400
X-AuditID: 1207440d-be3ff700000008af-19-57bae0914ad1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 57.46.02223.190EAB75; Mon, 22 Aug 2016 07:22:57 -0400 (EDT)
Received: from bagpipes.fritz.box (p5790719A.dip0.t-ipconnect.de [87.144.113.154])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7MBMnQR027076
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 Aug 2016 07:22:56 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/7] is_blank_line(): take a single xrecord_t as argument
Date:   Mon, 22 Aug 2016 13:22:42 +0200
Message-Id: <453ac11efe49ada493dc8af2041ad6de190c5a77.1471864378.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1471864378.git.mhagger@alum.mit.edu>
References: <cover.1471864378.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsUixO6iqLvxwa5wg7d7dCy6rnQzWTT0XmG2
        2L24n9lixdU5zBa3V8xntvjR0sNssXlzO4sDu8ff9x+YPHbOusvusWBTqcez3j2MHhcvKXt8
        3iQXwBbFZZOSmpNZllqkb5fAlfFp126mgrfcFTuO3GNqYJzC2cXIySEhYCIx8+wT5i5GLg4h
        ga2MEgvu32GFcE4xSWzYspsNpIpNQFdiUU8zE4gtIiAu8fb4THaQImaBfiaJHx1djF2MHBzC
        Aj4SfydEgNSwCKhK/J16nxnE5hWIkpj49RE7xDY5iUvbvjCDlHMKWEhsbVEGCQsJmEs823GS
        fQIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYIUHFu4Px/zqZQ4wC
        HIxKPLweR3aGC7EmlhVX5h5ilORgUhLlNWsFCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhtbi/
        K1yINyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTB6wDSKFiUmp5akZaZ
        U4KQZuLgBBnOAzT82D2Q4cUFibnFmekQ+VOMilLivPkgCQGQREZpHlwvLOpfMYoDvSLMGwuy
        ggeYMOC6XwENZgIafP3/dpDBJYkIKakGRul9l5ss5SO1r4TuYnyvEHn/UejCe/cufzAJiG7X
        1b25TeXTD4Nem38ur9Z0tk/KcHZezVeV4hnnlaURbtIvebKj9qp4Tr6rZ8zhPCOPq64/8/e4
        fJBep8we0Nme7ft8KZPBzZoiMfc/zdeWzLEylZGflnJr89wGectLfIJ3jRmMTzNr1TArsRRn
        JBpqMRcVJwIAR4NKHNUCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no reason for it to take an array and index as argument, as it
only accesses a single element of the array.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 xdiff/xdiffi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 61deed8..ed2df64 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -400,9 +400,9 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 }
 
 
-static int is_blank_line(xrecord_t **recs, long ix, long flags)
+static int is_blank_line(xrecord_t *rec, long flags)
 {
-	return xdl_blankline(recs[ix]->ptr, recs[ix]->size, flags);
+	return xdl_blankline(rec->ptr, rec->size, flags);
 }
 
 static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
@@ -485,7 +485,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the group.
 			 */
 			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
-				blank_lines += is_blank_line(recs, ix, flags);
+				blank_lines += is_blank_line(recs[ix], flags);
 
 				rchg[ixs++] = 0;
 				rchg[ix++] = 1;
@@ -524,7 +524,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * back only if at all.
 			 */
 			while (ixs > 0 &&
-			       !is_blank_line(recs, ix - 1, flags) &&
+			       !is_blank_line(recs[ix - 1], flags) &&
 			       recs_match(recs, ixs - 1, ix - 1, flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
-- 
2.9.3

