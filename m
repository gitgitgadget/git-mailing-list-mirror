Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6814820365
	for <e@80x24.org>; Fri, 14 Jul 2017 08:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbdGNIj6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 04:39:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:57452 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751340AbdGNIj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 04:39:57 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfEsY-1dHBCd2kZu-00Oqn4; Fri, 14
 Jul 2017 10:39:54 +0200
Date:   Fri, 14 Jul 2017 10:39:38 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] alias: compare alias name *case-insensitively*
In-Reply-To: <cover.1500021526.git.johannes.schindelin@gmx.de>
Message-ID: <75bfe3653dd65e4219a78cea8e9308060a84af4f.1500021526.git.johannes.schindelin@gmx.de>
References: <cover.1500021526.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5yqiP9XnUSjN/MAQVKwG58/lgieUxVhp62UiYNpmrajtKBk/MwO
 YYLN/VaheiT7D4ikDaKcvEcGbRw1hLoreBt5Hxz223uGZUOwzbsjVLxWxVrnfXXSl6l8msu
 kvS2hnhujcoxRdZTYh6joD3Q+QpaW9OPJ7Darl5djHceudxtCDy26oIzYxBzC8Qhr5eEbMJ
 wQ/Ze0qJcAjRJR1/iWWqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K0M1YyTKOns=:wKilU59qGoyVfnvIiB1LhX
 4YesPZorCM5u+ZDhRLQiix0MqWp/cDY0v7dt1ne9oYPSmCeJmq44ivKh0iLt1LArWHqICpa1q
 szu7PCylaezYeLz0rP00ECNuQiCCgV39HFXvMvAHVY+QggUwN51QADYAP4FOwyVYCUsyF2xUs
 lGEdqn2JjM0gMuAt9FPS/J3fivW5AQRc86tj01jiOOacURLRrcl1uFX+gf8KV+GqfAIzXBMst
 59Cce6Vd1UShHZOVRX9g4F6CZlzCXUn7G7yeWLbFL42/e6F8kq/h3OveW509i6i3XfgnJ3k8y
 G0d6lKSvYIlBJhQ23+L2WDGHvvZ/YMpKKbHf1nE6wumaST0AKlx6ObHAs7rro5myE7YNuAIGN
 PH/JXwn/z+sAAWztbHU/Y99/s8TrItp3dDBMXgh0LbMd06KFOuAXrJ+LvYJSNSnmBWroAZZ43
 /mCE1kFy311pzgEeL+W/l78SJGZtchGILCkz6nUsjYzapk0QFNdk9rcTANT85K4M1/JVU/ZbI
 tAbEeXf3t+rJnVxHlWDx2VCAtuZjUE6Za9+B72BKhcK/vKd1cvmlM+rrMHYf3almM+9Evap/g
 MK+4odqM0fjT5r0SM/IJZisRDF6lAKC94TZQFf+WGNh0hOaKRaj+jpmf0t17KxJ/q5Yv0DcHl
 JXTC962fUlbyrMxFabvVZrFr9Jw0bo97VwrjmAY5MoWSycU38sbYRUzY2WoUucYifMyjxkhaQ
 sBC5VBitSRXTgo6vfx0WV3hl3KhdLqwVlrvcScb+DuqamcLeokeyzLntOHKN0GHMB0JbTGyDa
 MMQVYuQl1syEj9roJMfytAGWwoNR1Oo7v8fWIWU9o1+UUf/TJo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is totally legitimate to add CamelCased aliases, but due to the way
config keys are compared, the case does not matter.

Therefore, we must compare the alias name insensitively to the config
keys.

This fixes a regression introduced by a9bcf6586d1 (alias: use
the early config machinery to expand aliases, 2017-06-14).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 alias.c                | 2 +-
 t/t1300-repo-config.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/alias.c b/alias.c
index 39f622e4141..bf146e52632 100644
--- a/alias.c
+++ b/alias.c
@@ -11,7 +11,7 @@ static int config_alias_cb(const char *key, const char *value, void *d)
 	struct config_alias_data *data = d;
 	const char *p;
 
-	if (skip_prefix(key, "alias.", &p) && !strcmp(p, data->alias))
+	if (skip_prefix(key, "alias.", &p) && !strcasecmp(p, data->alias))
 		return git_config_string((const char **)&data->v, key, value);
 
 	return 0;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 0df71b84ccf..364a537000b 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1075,7 +1075,7 @@ test_expect_success 'git -c works with aliases of builtins' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'aliases can be CamelCased' '
+test_expect_success 'aliases can be CamelCased' '
 	test_config alias.CamelCased "rev-parse HEAD" &&
 	git CamelCased >out &&
 	git rev-parse HEAD >expect &&
-- 
2.13.3.windows.1.13.gaf0c2223da0
