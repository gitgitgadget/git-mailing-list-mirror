Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F7C1F406
	for <e@80x24.org>; Mon, 25 Dec 2017 17:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbdLYRpo (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 12:45:44 -0500
Received: from mout.web.de ([217.72.192.78]:52554 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbdLYRpn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 12:45:43 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlWGZ-1f4FDJ0ajH-00bMY9; Mon, 25
 Dec 2017 18:45:38 +0100
Subject: [PATCH v2 5/9] bisect: avoid using the rev_info flag leak_pending
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <07d0e0c6-d023-bd28-511b-78092cb35b4f@web.de>
Date:   Mon, 25 Dec 2017 18:45:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:N1iitZNR/RLZpvs9zIJfQtqfOndf1H+VdV+dXVFYSJh3BVuMBVw
 b2ATn1m9pDw/F+2hYhaa50pCYEAVDi5n/yTZwTTVsLeTHbgm6cFJ3egMuDTbnnM0ScWZF0C
 ipggG+ZDZhufzdkMQXvbmyyyMlM+OeQNOxAiODiyhkvANzpSVP3oQwGTX8nLdpRAXkmDLs3
 EenLVnpFCJpsFOltw5DNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BGm37nvbvvc=:NUzFNcfFeQMpaYBlO8hd+i
 7218rn+iR54o+FTjlcF9hJc8UInDevqg24u8hy6uocl18wyXLpiFCs45OHgaSwFsWeBu/MYu/
 yiKCVBnsFKkJLJFY423j41prpSyTpeG7FiBXxD9z1DUF8ForntbU8jR5lQD2zO2TGN6nPrlrS
 86fDGYitgs3ZyaRnYk2+5wjxESIsfrVSVXA/UqFuaFrCoXStwrP9js89Gof/1hqKevR4D2tk1
 8KzTi+Fvro5IDb/IP1AEwymdjhjZX7AsPLUnM2Uoq2/tJEmlIoZMixzNWhKrWnaESnB+Yc2X0
 cykT/7WAeqCLBMurtKnLcLwh05I39MIFQGbioaWGyoAZgHrpToYXcW5LkhGfZlM2B32Bhwd2M
 bBKISKJTvl1EqF729SnplN6Av96GEBuMlUZGrS/7S1lSfhEMDivOpilYSEr0VIxxcTCrEgI7q
 ds3uN2nNik/qrsCOhtJEt1yMzZ55Ghs4F3XrGzjtebbgKSvQH8hXUs7wdPY7lQt9L54t/65hM
 zGBEpyj8TtcWKzccGIhBtShj4+3fE0q+Mky3/qZ7Mhwrz7XlTYabnKGN9JjCdoymr1RWXOQ9N
 2aDyln7s2SQ08E22LWuly/b2aaz3rfM6KCd1f7ZsWyT2EjHp1m4WOROK9c4ecHPvZvFsu5wbG
 3dk6p27d9IhqJiOuNxfqqkAeX3sz6B0ibMUE5f3EiM/RTypCD3l+b6Fxz5sK7hLuQFZPUrrEp
 GZskUdL7BsaRsi4yDndffeEBW/Zjot85Suo6hmObW9dT5IKZ/ZHM0LUjoietsHOjN35QI4zBS
 qOyiGU0SZFsC0jEalyNrUy2QggraSaT7o/fX45+hCnvNtZUhX4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The leak_pending flag is so awkward to use that multiple comments had to
be added around each occurrence.  We only use it for remembering the
commits whose marks we have to clear after checking if all of the good
ones are ancestors of the bad one.  This is easy, though: We need to do
that for the bad and good commits, of course.

Let check_good_are_ancestors_of_bad() create and own the array of bad
and good commits, and use it to clear the commit marks as well.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 bisect.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/bisect.c b/bisect.c
index 0fca17c02b..c02accaf3c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -790,100 +790,88 @@ static void handle_skipped_merge_base(const struct object_id *mb)
  * - If one is "skipped", we can't know but we should warn.
  * - If we don't know, we should check it out and ask the user to test.
  */
-static void check_merge_bases(int no_checkout)
+static void check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 {
 	struct commit_list *result;
-	int rev_nr;
-	struct commit **rev = get_bad_and_good_commits(&rev_nr);
 
 	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1);
 
 	for (; result; result = result->next) {
 		const struct object_id *mb = &result->item->object.oid;
 		if (!oidcmp(mb, current_bad_oid)) {
 			handle_bad_merge_base();
 		} else if (0 <= oid_array_lookup(&good_revs, mb)) {
 			continue;
 		} else if (0 <= oid_array_lookup(&skipped_revs, mb)) {
 			handle_skipped_merge_base(mb);
 		} else {
 			printf(_("Bisecting: a merge base must be tested\n"));
 			exit(bisect_checkout(mb, no_checkout));
 		}
 	}
 
-	free(rev);
 	free_commit_list(result);
 }
 
-static int check_ancestors(const char *prefix)
+static int check_ancestors(int rev_nr, struct commit **rev, const char *prefix)
 {
 	struct rev_info revs;
-	struct object_array pending_copy;
 	int res;
 
 	bisect_rev_setup(&revs, prefix, "^%s", "%s", 0);
 
-	/* Save pending objects, so they can be cleaned up later. */
-	pending_copy = revs.pending;
-	revs.leak_pending = 1;
-
-	/*
-	 * bisect_common calls prepare_revision_walk right away, which
-	 * (together with .leak_pending = 1) makes us the sole owner of
-	 * the list of pending objects.
-	 */
 	bisect_common(&revs);
 	res = (revs.commits != NULL);
 
 	/* Clean up objects used, as they will be reused. */
-	clear_commit_marks_for_object_array(&pending_copy, ALL_REV_FLAGS);
-
-	object_array_clear(&pending_copy);
+	clear_commit_marks_many(rev_nr, rev, ALL_REV_FLAGS);
 
 	return res;
 }
 
 /*
  * "check_good_are_ancestors_of_bad" checks that all "good" revs are
  * ancestor of the "bad" rev.
  *
  * If that's not the case, we need to check the merge bases.
  * If a merge base must be tested by the user, its source code will be
  * checked out to be tested by the user and we will exit.
  */
 static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 {
 	char *filename = git_pathdup("BISECT_ANCESTORS_OK");
 	struct stat st;
-	int fd;
+	int fd, rev_nr;
+	struct commit **rev;
 
 	if (!current_bad_oid)
 		die(_("a %s revision is needed"), term_bad);
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
 		goto done;
 
 	/* Bisecting with no good rev is ok. */
 	if (good_revs.nr == 0)
 		goto done;
 
 	/* Check if all good revs are ancestor of the bad rev. */
-	if (check_ancestors(prefix))
-		check_merge_bases(no_checkout);
+	rev = get_bad_and_good_commits(&rev_nr);
+	if (check_ancestors(rev_nr, rev, prefix))
+		check_merge_bases(rev_nr, rev, no_checkout);
+	free(rev);
 
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 	if (fd < 0)
 		warning_errno(_("could not create file '%s'"),
 			      filename);
 	else
 		close(fd);
  done:
 	free(filename);
 }
 
 /*
  * This does "git diff-tree --pretty COMMIT" without one fork+exec.
  */
-- 
2.15.1
