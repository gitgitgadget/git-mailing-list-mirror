Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF021208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 09:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbdH3JqR (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 05:46:17 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:63052 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdH3JqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 05:46:16 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue001
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Lst3q-1dOCeP3fcg-012WvG; Wed, 30
 Aug 2017 11:46:11 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] name-rev: change ULONG_MAX to TIME_MAX
Date:   Wed, 30 Aug 2017 11:46:06 +0200
Message-Id: <ef9aebb63227c36b8b72a65240a416a0271cc618.1504086318.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.603.gf58147c36e
X-Provags-ID: V03:K0:PUdnzyxLM9f09rJZhLimruuOdOk/r8AV1IhYyecvR1Ru5JRHyrE
 dvBzvqZSoi1AbG3VmByIIouClw+AqcASuMelpvee2NaSY7B9hPmNsFnTqUzadkn4b+z71q8
 5LRwHJh0auYiuURRHDZAAqnsY/5C3U+e5m6mudxvu1YN8axHMiRhMoi2q34dsN+P648o1iA
 lfOModvRRs/d/rfRjP/dQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fl6uZYQEscQ=:mVt8ZU43EGSXabNypFz8xp
 8x7B1yoN+Q76jnYI6B+IWP/3n+PeP922+yDZ2xe2i7RY9Etm0j95AvjzCDliasj/fHwc6lbIW
 8MKu3BYmWf9znh8OXzBiybF1Wcl9pGnv0WkQfaQXI/vvPXe0OdsD4TQAgSUi4skbAP2C84F1X
 KYIfUxVTw7AbKLWAF+Rmh/DShu4stkiVdFedGpyhXlo67mcONWo6T7oMbc0BgPj3ob24G3Z/o
 kRt8ktIiu0jbWz1L+DgyucQQqQNCM82I/GTNSx8n3Hmy5Tz+Map+zR5BBzgCH5WR0/Prh8gw2
 dFDk1JqL0aU6rr4dTvVrlr1jRAqxC4PdPYOCqfF0dKPRT3RKMhr30MZVQKhwWl84zE29OsoLY
 8jexjueGHZAHjZ+37dU2TAa8kpHK2ARzQK0tmtuBI0Qm89wfXJLbQJFQ2qeTENLqViVS6CHvp
 f6NyXnXSDFsNVheLbCkNDYeTboi57RSHqznz8FOVDi4l3qVFooR+4mdfeQ5Tz+Ky8LpXlxVFL
 sQDpk0AGNI+NLfAHBAnlRtkOfA5Y1S4240A3GRSR/pgl87SMbonIR4cgtGhxThM4/7cHos/5d
 cV+eWCOBSfBkbfrP7JMLjaBdGZeUwyUBOKsgBKlm34vwfQ9xJKuNBWi9sEEsznPG/8SUqXoJr
 z8N7jyP2ObBdBWJEDnZGcVsyl7SnH4aLDWXNSs2zfmiIEjhbz9FlckCdZNOFSHhf9X3Pfp9ga
 neJsZp/iSmi3Rg+WiG/HljWkTT2+nkso+RJcgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier, dddbad728c ("timestamp_t: a new data type for timestamps",
2017-04-26) changed several types to timestamp_t.

5589e87fd8 ("name-rev: change a "long" variable to timestamp_t",
2017-05-20) cleaned up a missed variable, but both missed a _MAX
constant.

Change the remaining constant to the one appropriate for the current
type

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/name-rev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c41ea7c2a6..598da6c8bc 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -253,7 +253,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 		struct commit *commit = (struct commit *)o;
 		int from_tag = starts_with(path, "refs/tags/");
 
-		if (taggerdate == ULONG_MAX)
+		if (taggerdate == TIME_MAX)
 			taggerdate = ((struct commit *)o)->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
 		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
-- 
2.14.1.603.gf58147c36e

