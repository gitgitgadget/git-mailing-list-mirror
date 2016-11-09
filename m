Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E762C2021E
	for <e@80x24.org>; Wed,  9 Nov 2016 13:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932859AbcKINvl (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 08:51:41 -0500
Received: from mout.gmx.net ([212.227.15.15]:56667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932719AbcKINvk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 08:51:40 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Ma1pn-1cObtj3ldv-00LoT7; Wed, 09 Nov 2016 14:51:25
 +0100
Date:   Wed, 9 Nov 2016 14:51:22 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>, Andreas Schwab <schwab@suse.de>
Subject: [PATCH] t6026: ensure that long-running script really is
Message-ID: <16dc9f159b214997f7501006a8d1d8be2ef858e8.1478699463.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qWmFafJwFU7FKa07QIHK13eLq5coOzFoOn5cmCu2AE9hOGNRVJw
 8YNDjcRxk9KW+N68DDZL14VEpPnZ6sKqzTpVuab0BVxa0mIrsuCXUbUSRArqKVc8v32+/ly
 P60icY3qR+z31X5wQjukS9+ANAohfsPpYc6RqhgcB+PB8qIY1GLA+zoIMyxvrLSKF2tuPIE
 ax6X2P1pJEfB/UGnNW8Bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j497WxUvKBY=:R2+DsYhOZGWVSw1wEOJgmQ
 4CFgO5oHpKgSpKdHD5VzmU4hPHRpj/Ci/kc9/jSY2ZHJC5ty/Kox694hqeGHf3DMbuLduqjqE
 yneZpE12ZH4JZdd0xWhY3pjDWhFzDNsSb4i8V2GNMmEk6A4FqLhs3SW6UyWglIU1ovEqoRSg5
 Mg/dBTJ9y3DElEqtYHHnIr3VoJylf3FSu27i1wK3LOv961peSsvKQlJLhkivBZezA36M3CTyp
 UJSoig6jp6L6BnDTqzm2sjvQYYfG9JYLpFBnKk5bRoZWZlQ6lHAxpwzip+IvXe+z1IGKx3XDD
 XlXx/dZwTBbn9cMIoeMngCahUqMpZYUV4VEZHPzkvHUaLTeUzWZj4IJlgAmkh9sEYhgGbllZJ
 3AX/MN7JSZMuhwkjc05e9jDy09yuQAgb4nNr2ErXg1izqqO4ucQWViRu3tdj5DeUg4GHxYgf5
 JsdoQq+HBtUFmbGAQV1EcYOKPj83mADJbv/c4pfQpRqo25XWDCS3YLgrI9tIDqrXbFbsfPjO6
 HCbVgm1ECpBw12JWXgoEUSzNKYcTNV5+3j5JdZALQhP11YlRWe900yDizyr+q9jheUo3/wBF0
 juyDSKoCj9XkI6YojetGo8Q+oUnZVWGm+sMFIKddgIGZ8WObRG3gn7F8s5FjfzVblxRKEq9yc
 mHHAUW1d8W3smB7gqdsRDD4AMQ9uWmGSTvXG+XtJZHi8id/drWcirXXBZC46vqmIhya3icvVf
 A+ecv+j+mNzUc0P0TNdLshMxRvJRx9lu8nFOv36rI7Kgv560bExeNo3pD9CWcHBTNhCp92p4Y
 UJQW4F1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When making sure that background tasks are cleaned up in 5babb5b
(t6026-merge-attr: clean up background process at end of test case,
2016-09-07), we considered to let the background task sleep longer, just
to be certain that it will still be running when we want to kill it
after the test.

Sadly, the assumption appears not to hold true that the test case passes
quickly enough to kill the background task within a second.

Simply increase it to an hour. No system can be possibly slow enough to
make above-mentioned assumption incorrect.

Reported by Andreas Schwab.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/t6026-sleep-v1
Fetch-It-Via: git fetch https://github.com/dscho/git t6026-sleep-v1

 t/t6026-merge-attr.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 7a6e33e..348d78b 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -183,16 +183,16 @@ test_expect_success 'up-to-date merge without common ancestor' '
 
 test_expect_success 'custom merge does not lock index' '
 	git reset --hard anchor &&
-	write_script sleep-one-second.sh <<-\EOF &&
-		sleep 1 &
+	write_script sleep-an-hour.sh <<-\EOF &&
+		sleep 3600 &
 		echo $! >sleep.pid
 	EOF
 	test_when_finished "kill \$(cat sleep.pid)" &&
 
 	test_write_lines >.gitattributes \
-		"* merge=ours" "text merge=sleep-one-second" &&
+		"* merge=ours" "text merge=sleep-an-hour" &&
 	test_config merge.ours.driver true &&
-	test_config merge.sleep-one-second.driver ./sleep-one-second.sh &&
+	test_config merge.sleep-an-hour.driver ./sleep-an-hour.sh &&
 	git merge master
 '
 

base-commit: be5a750939c212bc0781ffa04fabcfd2b2bd744e
-- 
2.10.1.583.g721a9e0
