Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A391F406
	for <e@80x24.org>; Mon, 25 Dec 2017 17:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbdLYRqW (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 12:46:22 -0500
Received: from mout.web.de ([212.227.17.12]:59101 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752547AbdLYRqV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 12:46:21 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3Bhz-1emiKu32r1-00suo2; Mon, 25
 Dec 2017 18:46:15 +0100
Subject: [PATCH v2 6/9] bundle: avoid using the rev_info flag leak_pending
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5fe3b4c8-e48c-1922-f564-e75c5a354cef@web.de>
Date:   Mon, 25 Dec 2017 18:46:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:fzxBepDXkSzhlNzzzfvoBaENYMoCJsi5ZEKBo1iLgQyF7Ia0Ol5
 7GMoR8rA/0Y8W6kgbMu4pXFYiB8wUeQ1x5m552gaYIiCKPrpXRw2So6GUQ8eVj0fXwEIwng
 AUyKU5ndOFneCNYjmlrdCf1q1wJst5jdQwvIahgYagkpbdKAYkhZnFKCZupcDL2gIiwmKSS
 CLD73VvTD1qyVrmalBn5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:em7Osyre7eE=:Kr81cj/0hXUQoLu6uyxvmh
 Zb6YDQeprKkZxVDbkFlmiqP2Cn9Hctj+kdAVBqAMO196DlGO9A7r4hvXSDxAlIr6F9y1E0CZ1
 xFO6FzvL+xw0m0FKnhUHBezuypnP4HElZiVaQuZYgt6HUOe3gGe0YAYA56d6jT+On52iFrnIP
 heUjt/iEpdoNw8b02L6+hSYjByaoWepo9wlTPZcezWnbFFLB3N+2F7pQekCKwseO4ruXEXRqI
 +8yEeORdFhnnbwamV3e9xcaj33o60fV9lmIT5OwNsFKrJs9rGY5EnwT6smaFzVwhBcQM1RTIb
 uxxDxtI+5ZhbkqHzJBDLuLCON6f1zbncwFkGjxLkn1BtQ7dB2YZtVg1ZapagAvyUheoU/V9+4
 5bFS3A9ZpA91mrINt5XFiLHfZrKYqtYWGqe7kbukOo++matZJ7uoAz7PZL+oiOPot9IFDHJ11
 2JCB2rCsqnyJ9dUfgv8YtE1oZeUlHEIeG9x4EOZbSdynx47nGoNs9aqHDmrsfZR5cwkuzCsVp
 voPx6kRZC/IfoaZxeu8TdQPJ0p4934n2K80SESnAHF/ggWi1RMQznAxah2m1PrkeNc/PG0ywq
 5IrmJYW1YzWzkB3T9J43V2bI9/Jxk/CyFkB8USeTqAMAsbNKeQ2XnstpbEwYea+cf028RkjEV
 HQmvTIaIocR+IcQ4864jO+SZwEkr2GishgR0xx8sstB7+XmaAozH7uoyMH/gHzFAkAFeyoPCE
 cD1NHXeD4968pNE4OkH1iefUIt06hH8IrDA0D8siZ4I6tRHmtW5Boav1npsgdK6NcWGRvxk6V
 MGu0P7EmgCrRhjcbA2AifTMTQLdZ+4cAbrJNvm7HkEtr/rr6sbWA+epH7GM/uNyWx0sheUp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The leak_pending flag is so awkward to use that multiple comments had to
be added around each occurrence.  We use it for remembering the
prerequisites for the bundle.  That is easy, though: We have the
ref_list named "prerequisites" in the header for just that purpose.

Use this original list of prerequisites to check if all of them are
present and to clear their commit marks afterward.  The two new loops
are intentionally kept similar to the first one in the function.
Calling parse_object() a second time is expected be quick and successful
in each case -- any errors should have been handled in the first round.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 bundle.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/bundle.c b/bundle.c
index 93290962c9..efe547e25f 100644
--- a/bundle.c
+++ b/bundle.c
@@ -128,83 +128,80 @@ static int list_refs(struct ref_list *r, int argc, const char **argv)
 int verify_bundle(struct bundle_header *header, int verbose)
 {
 	/*
 	 * Do fast check, then if any prereqs are missing then go line by line
 	 * to be verbose about the errors
 	 */
 	struct ref_list *p = &header->prerequisites;
 	struct rev_info revs;
 	const char *argv[] = {NULL, "--all", NULL};
-	struct object_array refs;
 	struct commit *commit;
 	int i, ret = 0, req_nr;
 	const char *message = _("Repository lacks these prerequisite commits:");
 
 	init_revisions(&revs, NULL);
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
 		struct object *o = parse_object(&e->oid);
 		if (o) {
 			o->flags |= PREREQ_MARK;
 			add_pending_object(&revs, o, e->name);
 			continue;
 		}
 		if (++ret == 1)
 			error("%s", message);
 		error("%s %s", oid_to_hex(&e->oid), e->name);
 	}
 	if (revs.pending.nr != p->nr)
 		return ret;
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
 
-	/* Save pending objects, so they can be cleaned up later. */
-	refs = revs.pending;
-	revs.leak_pending = 1;
-
-	/*
-	 * prepare_revision_walk (together with .leak_pending = 1) makes us
-	 * the sole owner of the list of pending objects.
-	 */
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
 	i = req_nr;
 	while (i && (commit = get_revision(&revs)))
 		if (commit->object.flags & PREREQ_MARK)
 			i--;
 
-	for (i = 0; i < req_nr; i++)
-		if (!(refs.objects[i].item->flags & SHOWN)) {
-			if (++ret == 1)
-				error("%s", message);
-			error("%s %s", oid_to_hex(&refs.objects[i].item->oid),
-				refs.objects[i].name);
-		}
+	for (i = 0; i < p->nr; i++) {
+		struct ref_list_entry *e = p->list + i;
+		struct object *o = parse_object(&e->oid);
+		assert(o); /* otherwise we'd have returned early */
+		if (o->flags & SHOWN)
+			continue;
+		if (++ret == 1)
+			error("%s", message);
+		error("%s %s", oid_to_hex(&e->oid), e->name);
+	}
 
 	/* Clean up objects used, as they will be reused. */
-	clear_commit_marks_for_object_array(&refs, ALL_REV_FLAGS);
-
-	object_array_clear(&refs);
+	for (i = 0; i < p->nr; i++) {
+		struct ref_list_entry *e = p->list + i;
+		commit = lookup_commit_reference_gently(&e->oid, 1);
+		if (commit)
+			clear_commit_marks(commit, ALL_REV_FLAGS);
+	}
 
 	if (verbose) {
 		struct ref_list *r;
 
 		r = &header->references;
 		printf_ln(Q_("The bundle contains this ref:",
 			     "The bundle contains these %d refs:",
 			     r->nr),
 			  r->nr);
 		list_refs(r, 0, NULL);
 		r = &header->prerequisites;
 		if (!r->nr) {
 			printf_ln(_("The bundle records a complete history."));
 		} else {
 			printf_ln(Q_("The bundle requires this ref:",
 				     "The bundle requires these %d refs:",
 				     r->nr),
 				  r->nr);
 			list_refs(r, 0, NULL);
 		}
 	}
 	return ret;
 }
-- 
2.15.1
