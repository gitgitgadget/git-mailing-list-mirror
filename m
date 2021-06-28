Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AFDC11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 18:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC9161C8C
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 18:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbhF1TAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:00:48 -0400
Received: from mout.web.de ([212.227.17.11]:44223 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234372AbhF1TAq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 15:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1624906693;
        bh=yDCkh1qkAxobaIk/lA2oYEKHDAF6mmrwdFxoIK8Z9zQ=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=hr8StC01gzTf9+YNJiSGULkya3o/FwVZFpwPbdCYvkrYQ5UtfjAoSq+PcishFh4Eo
         B5AD3sQTb9j7sRfoz2ienh5atSm6nFws+UQ3a1RfzFuN+xAPoJHGniD0Ur/9qvBIms
         cCl+bvEyt+EacVsrFw3auTcjr/EDG3zxiSfNwffg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MEmgA-1lzbAN1D4M-00FxCz; Mon, 28 Jun 2021 20:58:13 +0200
Subject: [PATCH] grep: report missing left operand of --and
To:     Matthew Hughes <matthewhughes934@gmail.com>, git@vger.kernel.org
References: <20210628121748.f3yrc72v4mynknl3@debianXPS.lan>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <98171911-ba39-27f1-d068-4d381bcd4804@web.de>
Date:   Mon, 28 Jun 2021 20:58:12 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628121748.f3yrc72v4mynknl3@debianXPS.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AhIqI3qCAf49I2sQaelHVYqJ8Qed3pSDFwdLrwTGAoNK/CB4Iii
 3mKQ0QrRjYLGBiRP7k4tl64imAIHfTxXH9SUg9rePDA8ofn2q4xsKa9r3UPXTAcO6SlIlh4
 QUowZDKa5FM1leb7WYRWSqjHlMCPji9SNvC4wyNytHv3WSfpGQE0aopmUO2gCGGsqxIHgK1
 g01+uGRq/q9RlxbYnXKDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rnKSCqYmO7Y=:iUNU7EaanBmAxzCthb/Z8+
 YroFYHys/lcEBYIElCjxiL9X9hR514MF848KloxhXXFBXUj53/YjbU6iuzbqFjo9jFAwM/I2+
 uiri6oZh+EKPlOjYesDGif+DVQjDGJdDN2gPFjCPtx5skeJw8lxSencwM7x8/1/3D/ukQkZo/
 8zE8id9WSsBshv+iWl4zL7AaOibfzGIFnlnJz9NwMd40EU05XEAqwPnzcQiIo3a2wi0WDfWng
 yar34oklaODMcUBzyi0LcqL0k0NLtaFJAfIQ85Pj2/OhIV+05Dm1U9JYf5UkaDJ1KVtA8D2+G
 s7Sk7DMDOOm3AHcOxXGMdyxqVv8xQWPWpWuR5CEJapT3Xcm6IDye/jLqhmBZJ+RjpN2GjGlqi
 yqFl4Ht1Ih/zr7BcbusI0Ccnd2rnV6/yGMw9tRnSpw0hCU088bIw4hODQ65jS/m3YdQFWhyjj
 +/taRz2PrzgkY9RM4oNrWIJgxxCAUGgqvmDqFi/Oh1a+rpj2PGHaZH0Cvb8lbsHZzdKIdmcd/
 Uk8eoB9j/NTD2EaCb9CmcxdiySeixdoZo7k5Wbli3Nc0PHBqY369ij9hcqJGzpunlSzXiwo0I
 7FU27F42Ok9xODHfLARNEpWRoKoDCg76txZbsN5Ixoi+aHGDP6PdvuGs/y84aAdCeYQfRz838
 lsdG7Ix6m37Oy4Tn1oXWG9Tq2lNseBIFt7kIZsUhy/hkf9+tMPU3gmkNID/AwzcGQtw+7AqkN
 unHa/pZCwLFNLLFshsR6cWzffCl9M/3Rnwgd17E1E07Ejni/ca/9C40/yBJylB89xfVPq6GM3
 08O44b0Z7jlnSwZTL9G5xQ9j6PFIG3uJzGGPZnTOpnMPZZw2gAH4KNIGtbqi8TvxLPb3vs42t
 Hwh2RQTHCtYne2ZMAV1wwk/Oc9Ujx1uFPB3rTYAUixtXxF2cJ7waNUNc9jAiKu76P1eFOZomX
 cxJl2mERZu7/KudsMjJzpvC/1ij5ZV0l+F2PN1c3TsB55Dddbg6AATfNm8IdRMrjEPp3uh2pW
 BBS6KXFQAcyRuM0hmqyypQL4+hB3jysD8pQTII+I3XRPFPOZz5xRdC6rwT3/mkGKyCQcqDmWP
 gpMtOK+QuiV55ABwAPvB5jUxX0df05x0nfi
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git grep allows combining two patterns with --and.  It checks and
reports if the second pattern is missing when compiling the expression.
A missing first pattern, however, is only reported later at match time.
Thus no error is returned if no matching is done, e.g. because no file
matches the also given pathspec.

When that happens we get an expression tree with an GREP_NODE_AND node
and a NULL pointer to the missing left child.  free_pattern_expr()
tries to dereference it during the cleanup at the end, which result in
a segmentation fault.

Fix this by verifying the presence of the left operand at expression
compilation time.

Reported-by: Matthew Hughes <matthewhughes934@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Whether the check in match_expr_eval() can now be turned into a BUG is
left as an exercise for the reader. ;-)

 grep.c          |  2 ++
 t/t7810-grep.sh | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/grep.c b/grep.c
index 8f91af1cb0..7d0ea4e956 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -655,6 +655,8 @@ static struct grep_expr *compile_pattern_and(struct gr=
ep_pat **list)
 	struct grep_expr *x, *y, *z;

 	x =3D compile_pattern_not(list);
+	if (!x)
+		die("Not a valid grep expression");
 	p =3D *list;
 	if (p && p->token =3D=3D GREP_AND) {
 		if (!p->next)
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 5830733f3d..c581239674 100755
=2D-- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -11,6 +11,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

 . ./test-lib.sh

+test_invalid_grep_expression() {
+	params=3D"$@" &&
+	test_expect_success "invalid expression: grep $params" '
+		test_must_fail git grep $params -- nonexisting
+	'
+}
+
 cat >hello.c <<EOF
 #include <assert.h>
 #include <stdio.h>
@@ -89,6 +96,9 @@ test_expect_success 'grep should not segfault with a bad=
 input' '
 	test_must_fail git grep "("
 '

+test_invalid_grep_expression -e A --and
+test_invalid_grep_expression --and -e A
+
 for H in HEAD ''
 do
 	case "$H" in
=2D-
2.32.0
