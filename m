Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6B2208CD
	for <e@80x24.org>; Thu,  7 Sep 2017 14:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755407AbdIGOCq (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 10:02:46 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:61710 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755398AbdIGOCm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 10:02:42 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue003
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MY20C-1duIwa27cm-00UueM; Thu, 07
 Sep 2017 16:02:32 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] t6120: test describe and name-rev with deep repos
Date:   Thu,  7 Sep 2017 16:02:23 +0200
Message-Id: <3d30936525a83c6126155d1f32d43f3f09167904.1504792601.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.603.gf58147c36e
In-Reply-To: <c1cb526d-a567-b598-d980-5dbe695b7d6a@grubix.eu>
References: <c1cb526d-a567-b598-d980-5dbe695b7d6a@grubix.eu>
In-Reply-To: <cover.1504792601.git.git@grubix.eu>
References: <cover.1504792601.git.git@grubix.eu>
X-Provags-ID: V03:K0:kiDvST5FkBmANEn+l4qhE0XXfp+njOgSPk+x61SVCqC36z+89Xr
 tV9zG6hEtdJp/2NwWjKsAF9zV0cJfB4p/SbM/jx8AkP+NBPbgzH3hZP7iAxoq9RGwgGOMLr
 b8amw/uS39dzI7ruJQ6rTyg07ua4Jj3IA087bqPTLAWYmh9tz2M5npvfRA1XT9sTj3fcMu/
 Sjrn+Gua8Ex6Avq4aHgqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8wKmAEH06wI=:VwQzvtC/Avqo0H9ZIsRaKo
 mXxWzH1h2OYHy4wJd5hsMrE0ugGHOyGA7cPwqcVY8XY1UGNY4ht4RnqZfdhgB0EHW7pF3CJRy
 xLWcuwf27w/O8meSpwHvHeFPcfiwgS51o4R1ZePicOG5Ayo+e41BoiWNfLbtyHRuu/GvL18uV
 PYshUORYrEt3tqNB3FxQJbC56RwUfLNWRoYcTgVe2sMQ0ZER67PQmUA/h/Ukua3Lt7LmphSoO
 w+gjodKFJnqNaJQ3F6jr5ue2uXFE/irqun8z/qs8J7xRdowvuZyYfu0uiUYyMe1/FD1l9kg7s
 43CP4ItMj3Ik/8wk+OECF3oSp6K4B+fZ3YElYQstUFrPHVNh8SY5RPSzlnR5Irx13eGaATi9d
 4lO0E+0qn7OiF0Adbk6sVvj41XAxp3W5SnGgiXXDjuNbagm/F8Bx/Vhwtw/vzquFxcvJU6ntX
 Bg4QsGfT6/LYC7Qn6svE1xfAMCjskru4zNZhNpUIF321jhx8snAcRrJyqU4sYjeDt/T9tU39q
 W2YnX4zqdbUbjWRICqVtxVTPmyTiUotJhXB00p4c++G2LxZDWUKEjNQcj6rXHgHNbfj7Lbvio
 VbzGVbtsQ2BSe9we3ink+V9bQn7RNZC5U+QXtI5qFmd8gtMFfnvxD+SfaVvJG8rWL361NUuyz
 f3CYLlN+7/B4+SiVYCSqoKJ866kc/ImZSkWHo2m1XIJfP7gux/xHG5jtFihHwfmPsPfF6TLnN
 nVjegIWAtOmASs+Epwl/nj48x2kgWFEi1BlGlQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Depending on the implementation of walks, limitted stack size may lead
to problems (for recursion).

Test name-rev and describe with deep repos and limitted stack size and
mark the former with known failure.

We add these tests (which add gazillions of commits) last so as to keep
the runtime of other subtests the same.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 t/t6120-describe.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 1997ccde56..dd6dd9df9b 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -279,4 +279,35 @@ test_expect_success 'describe ignoring a borken submodule' '
 	grep broken out
 '
 
+# we require ulimit, this excludes Windows
+test_expect_failure ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
+	i=1 &&
+	while test $i -lt 8000
+	do
+		echo "commit refs/heads/master
+committer A U Thor <author@example.com> $((1000000000 + $i * 100)) +0200
+data <<EOF
+commit #$i
+EOF"
+		test $i = 1 && echo "from refs/heads/master^0"
+		i=$(($i + 1))
+	done | git fast-import &&
+	git checkout master &&
+	git tag far-far-away HEAD^ &&
+	echo "HEAD~4000 tags/far-far-away~3999" >expect &&
+	git name-rev HEAD~4000 >actual &&
+	test_cmp expect actual &&
+	run_with_limited_stack git name-rev HEAD~4000 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success ULIMIT_STACK_SIZE 'describe works in a deep repo' '
+	git tag -f far-far-away HEAD~7999 &&
+	echo "far-far-away" >expect &&
+	git describe --tags --abbrev=0 HEAD~4000 >actual &&
+	test_cmp expect actual &&
+	run_with_limited_stack git describe --tags --abbrev=0 HEAD~4000 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.14.1.603.gf58147c36e

