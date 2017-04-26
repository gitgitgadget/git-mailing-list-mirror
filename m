Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82448207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 12:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954433AbdDZMAd (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 08:00:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:58092 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2999140AbdDZMAb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 08:00:31 -0400
Received: from virtualbox ([95.208.59.147]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9b4B-1dGIac1NWR-00CwXz; Wed, 26
 Apr 2017 14:00:25 +0200
Date:   Wed, 26 Apr 2017 14:00:24 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 8/9] t3415: test fixup with wrapped oneline
In-Reply-To: <cover.1493207864.git.johannes.schindelin@gmx.de>
Message-ID: <6e4c116952e0e86484a5a0264071e64f0e5b4d94.1493207864.git.johannes.schindelin@gmx.de>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aNEVuJSveeibeUdUD7/XAzzXKrPOfZvCoxUfearUxb38rC35KOX
 QeyVeuz/5hmeeVJ+93cyKnBW9miwxHZG8EgjSOmhZf9rn3TQUM21kFXKKV8WSEh6kk0K8iv
 mEbDZ99nz9JodiECohmZGml24Du0TXW4w9eyJqjIY9/M5scURIjEE3FHXbYIMYTmAtxS/P8
 a+8e4KpYBTj2nGSOHqIjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n4SIJXuu4ts=:KFVXOqxwdHlBoEpQk3+zQX
 cJHaYLQc0aWlCrgYl6KlKK6p3EyrIqpaR1Kv6xMG+uosuuih2yE/bzTx2TF27GxFsHxp3i8Hd
 Rb0C+vhUOg6hkqjYDmpEbUefaFhyYmuSU8s13YWsVBnsZp3eesEs0gJGlmZaln020vrnXEqFh
 OZKgsKjmQTs6ycrJwdV0bYPGNtO1nYB7/23JkPBhfvNjfAX5QJCFkQ8xWVndjHSPrTKNa0WOc
 2e2+z6yFWpOT5zeTA+kjWsjkp42PlIJNQ803XCFa8MHSEPSZHF/z8Oz7kXi9WvexIP+qBENB4
 RrAhjmknK3ATFQqFVM3eE6nR103v1r97Sd+Qe5uyh9wQHSl1Gbc/oBcqoo/BeTPXijAmn0e7i
 wiD6tw1RGC2JbrBZbUKP6RXN0xwBGbmvScCDDVR1uTTupINKW8NalxxyV9h7ajp9cTe126ftM
 e2zOZueV6HYAN8t/3ubZ82XOWJc/+ef/nfxRcZoX4mKSoDGfzpRf60c92VyBXiIgXrnWeDKq4
 2XX8LIP3PezTSboBT6WUpWNgSUgovjFPqY3t1tULlq47VRo4NZZ7aTtZWblA+ZhfEvFzVQo4Y
 DnCysuIOemGXOjvAbQpSj49Y/ZhMKn4FCb3p0vJdNotBPq2hm6GWNcjNONpomQLNMmY0BRFo7
 wJdJS//qnXphgF+MoVDGvtaua1eAT7c1n/D2k5rS4RWauF3ORmXJHyi7Ymw6S9t6wqvVE7RwD
 VWfqooZfNfFeEYG/8SQI4yOFhdGp2q8NdI5z4QvikrdwmtOuvn1r7vuTqGds7MWBfeDHjIgG+
 +LnqLLB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git commit --fixup` command unwraps wrapped onelines when
constructing the commit message, without wrapping the result.

We need to make sure that `git rebase --autosquash` keeps handling such
cases correctly, in particular since we are about to move the autosquash
handling into the rebase--helper.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3415-rebase-autosquash.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 48346f1cc0c..9fd629a6e21 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -304,4 +304,18 @@ test_expect_success 'extra spaces after fixup!' '
 	test $base = $parent
 '
 
+test_expect_success 'wrapped original subject' '
+	if test -d .git/rebase-merge; then git rebase --abort; fi &&
+	base=$(git rev-parse HEAD) &&
+	echo "wrapped subject" >wrapped &&
+	git add wrapped &&
+	test_tick &&
+	git commit --allow-empty -m "$(printf "To\nfixup")" &&
+	test_tick &&
+	git commit --allow-empty -m "fixup! To fixup" &&
+	git rebase -i --autosquash --keep-empty HEAD~2 &&
+	parent=$(git rev-parse HEAD^) &&
+	test $base = $parent
+'
+
 test_done
-- 
2.12.2.windows.2.406.gd14a8f8640f


