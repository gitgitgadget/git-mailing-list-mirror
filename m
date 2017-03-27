Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74D291FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 16:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdC0Qu0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 12:50:26 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdC0QuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 12:50:25 -0400
Received: from localhost ([178.11.46.195]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0LqUEr-1cEpNZ2OY5-00e2C2; Mon, 27 Mar 2017 18:50:08 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH v2 1/2] describe: localize debug output fully
Date:   Mon, 27 Mar 2017 18:50:05 +0200
Message-Id: <baac53f99636b00880c72daf8aec4d66a4755af2.1490633145.git.git@grubix.eu>
X-Mailer: git-send-email 2.12.2.584.g7becbf139a
In-Reply-To: <xmqqpohf7opl.fsf@gitster.mtv.corp.google.com>
References: <xmqqpohf7opl.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <cover.1490633145.git.git@grubix.eu>
References: <cover.1490633145.git.git@grubix.eu>
X-Provags-ID: V03:K0:YhOfVM7DXjV1YreflVaQv1qv7tSFPAQs0TZL9N2dN8Y7gbtKd9T
 GZiCCanAYrOeYDYfGU6ZLA1Jw41cUqPo/hEbC1VlapO+n0KyYVCdL9+oWe6jLztHJLxx+sA
 tBm0Q32DsO6C4db8NOA5A4A5NmTYrRQGqOXtu4Gkz+xgN9MYIjB47cNW9LAL1iFNQSh90SB
 MVc8CIplrTbxABGKLjniA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1xYmyKgv3+g=:CWpS6sRp7qnakQ+tWneaxW
 HL6vMUBtS58El2L/HVIjd1OwXJTzJyJEjkdIVSMfBd56tGClWHqnEYhytN2qz85SYV5QLvjEz
 bXfn4kQO9s1pBJpJNw1/xEYOHqM0K2PQ9pjaN78Wf6JIBjher1timZutVEriU9sOdmAQa8tA6
 X7MJcZjwU01Z2gYCQpkuHL08hgwYZjjY80i7xwwL8Gp6aiuFPMnFzxzv7+gAnrNV7K1wYjvSj
 bUJLYtSVO63P73nt72eTlScnJYJf4E8IFvzdsr9I6rdpau3yofyYJZudsPtzqQo1LWR46JYWP
 3HKrzU2gFoslO3ynoHBQv6/C9Yf1vMZKHFWgbfe1hGMjAAPkpwhMfsjni2RHqSvSmRn575+b9
 6SbMUPhLrGCpjlcSD/C3mOn13ePu9g2lolT8ah5QV0HkntUe/XP/gLMOvVQRzztfEStvYOpIj
 7FXzU1bsjq9XUtbmGJVXO6W3+kkiRbyWEpeFZCEzbXmMbG/LQINEIPMbH95EHXEXRT86Dp7W2
 yI46ao+gpn7XqLrc5YOGwqlKQVciIifAhnw/yhurZnZxaIWeUA2qDVnczHsYuzTu3Gm3o9MuH
 SLC0yPJgKThOCxTDQC2n/ghfmgD/HftojOMB3YlNdw2VOkVQHL9zG1vQ3PkwSY1JY2uQIni6G
 iYmtFjffWVWiMbZ2e0egIm5e05/Kbmxwn1jZlN/DhwpUYbe3nUVnY1/ejEBw4j6bMwbk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git describe --debug localizes all debug messages but not the terms
head, lightweight, annotated that it outputs for the candidates.
Localize them, too.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/describe.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 45adbf67d5..99e963dfe7 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -50,7 +50,7 @@ struct commit_name {
 };
 
 static const char *prio_names[] = {
-	"head", "lightweight", "annotated",
+	N_("head"), N_("lightweight"), N_("annotated"),
 };
 
 static int commit_name_cmp(const struct commit_name *cn1,
@@ -395,10 +395,19 @@ static void describe(const char *arg, int last_one)
 	free_commit_list(list);
 
 	if (debug) {
+		static int label_width = -1;
+		if (label_width < 0) {
+			int i, w;
+			for (i = 0; i < ARRAY_SIZE(prio_names); i++) {
+				w = strlen(_(prio_names[i]));
+				if (label_width < w)
+					label_width = w;
+			}
+		}		
 		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
 			struct possible_tag *t = &all_matches[cur_match];
-			fprintf(stderr, " %-11s %8d %s\n",
-				prio_names[t->name->prio],
+			fprintf(stderr, " %-*s %8d %s\n",
+				label_width, _(prio_names[t->name->prio]),
 				t->depth, t->name->path);
 		}
 		fprintf(stderr, _("traversed %lu commits\n"), seen_commits);
-- 
2.12.2.584.g7becbf139a

