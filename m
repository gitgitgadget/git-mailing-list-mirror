Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E2661FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 16:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932557AbcIBQXn (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 12:23:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:57098 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932495AbcIBQXm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 12:23:42 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M1iGk-1anLgf2Edm-00tn8y; Fri, 02 Sep 2016 18:23:39
 +0200
Date:   Fri, 2 Sep 2016 18:23:39 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/9] t3415: test fixup with wrapped oneline
In-Reply-To: <cover.1472833365.git.johannes.schindelin@gmx.de>
Message-ID: <9fc25ce0614ea1b38b0e56143510b0f7290ac3dd.1472833365.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:h5RLHsymmW5SI92iG0xeeSV3CrLqnuDKXyN5h+LEiAGtNU0cElE
 UVEfi4dUpepcyhEygKl0iigqSFQVhTvff+dnyENP58roTh8CFVsukNTYLXn+vgoc/u2bBuv
 JkuB8eKE9VIwewsQCX4V0Nj/XjtbJM/JoG8mHQmjvc6SSqF8aXDX7BQ4giqByNXAyRJ0mMa
 kuFIcm2+3e7hn2ZZkr8Fg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UTEff87//uo=:NpwEK0QEqZLHOMh+GsnpmR
 HzjtBgnEh5oHV1sK2Squs2tcVRneJ7qFFRe7PZLwF9CrYZoGzNwSYFZ/DzEqdTzKy4d4yl0dL
 KPCxWU6XtNlo7nnFMs9EkUfdUGJvk9tMbiUgwZaerQSFi/IxuUW7LJgULbH2Pf+FQ5E/yvsdt
 g8ymKXfz937ssFGkOhJsDKdUfaGBjlQVDnuUUJpyyRVVI32MIE7+4eYuoVuqqvbea+m/HFIj+
 Ep3ZGVzTFFlmJadd8xI1kJb6TPsx8QO+dQHwz9Su6o1Prt04sAydNlrdIVnY2MjP4iOGto/Bm
 kX4PS7YIRkwgcyj/S+CbUbVoy0i35HeSt0JoklyJj2gf9M647w9J2ziF8kPL987BBNNJdb7sj
 hlyiWeFhoAw8frQlQ8q/wdDYoxBSprMuHevxlpLjPLKQKCy2kM6BSGZ49NSV5fNrWmd3EEAAE
 eVVJRzQhtH494HdaKpmEOT/jPisSopJM8WMh/dVMlc5gdwMPN3hfaXixck10eBN8M7A7cuyU0
 56XPSONhNKoMD4Uh4E8mi4+WaDXWp5Hcb0CdtTqQp/ntnu3rSb9cc3sAOehxZI4Tor8pivVxY
 t3a84DWDDj0Hz4tfULbCNYsXUFjhly68+w4dP4Q7gVl/uFv7sobl6nQepdC7l2skdash0KTlO
 zFRQsZVcU2pX4yFNXDXvlBkbSB5QK1AJ4hR3EXjVYnWrxzDkskiqlFPVUDifLYV4kYvjBnQ6m
 K+8ZZMy39aqypQHRB0q4GwAhwDaEZKkihAodFVzqgMlVGDTe57hvpE79ib4zczSs94FoJGZmu
 h2NyE7V
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
index 48346f1..9fd629a 100755
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
2.9.3.windows.3


