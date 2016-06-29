Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E0101FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbcF2Lgz (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:36:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:58318 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbcF2Lgy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:36:54 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lu8Ri-1bRT9k1Dug-011QHD; Wed, 29 Jun 2016 13:36:46
 +0200
Date:	Wed, 29 Jun 2016 13:36:45 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/9] merge-recursive: clarify code in was_tracked()
In-Reply-To: <cover.1467199553.git.johannes.schindelin@gmx.de>
Message-ID: <dd3e2cf842fd5e11e31914aa55b8b995e8d3d75c.1467199553.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:v/g9poMeYHaQ+Yi2QfaY9/TC0ngv1vxNyCwe8NPHrXa2dH3u9vC
 DBzResCaN9wr56u8TkOMKXmpyTZxeufCZkEfP5PPMBJ3a+oILH4eLS2V9wdSzQga60WbAOe
 uLS5XQkT+ojVEP3y9qEIrPbgTQrD8i9c5UHUvfviszbmz7cZenD1S4+C9gIBJd3xmS/Bor5
 GZJ/bOIsm0VlJ1Q4YvB7Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ERhtEglyQh0=:cRm8LnswLOgoiasEiWR4l5
 45PcxQ2wVXzwV2TXr8a0I7bWziNV/EaDIcpcxtbI8EXNRxbmvfIZH02/Zis6iULqysRXhrUlj
 UHGTEGboXVrU8BC5S040MsBRuA4+kMYItlwonCOfzhjETlZXTSOQqlmG21o6o0zyY6f5DWxCO
 tAVw0rZ7n3knDhK+OcOLzvGZAaowOzhDtqvY/znVHVEW/AiwFidcHl64PpiQTPa9WH3XmZMkR
 n1ArBzltbPAPSmPt3bGqgsEjoPdXrIQs59v6NjdTU82UuAbdf5G9Lobt7OSHxcyBFXYHS3WsS
 H4/IdJeg/ydDCu7t93koxAdRJQ/lvgTRFu4eNXnP1CUru2NITCqpqVCT/lAZl9p+sGl7Jb614
 TEX844Jo5kXyqvof0AhY7cHPJKzZMECmjA9dcA0ZGMbdiwQ643pj208BHaWKzp4pEORw6TGA6
 yqtIMKZVQ9wYX1xpfVGwmj59/YsR9q3kISi63DogyITyFsWrLTGmO0VyK+dfRSlp9XOQCv5tQ
 Y+Ys46PbgxL+6VpVvyUZssO9Ldm9YMfFfvS1k1XH3nbT9qzR82MCuFNPsMZ/32/mmes/AW+VV
 k7bUMxipDvkuWmCIlTXwNgZjT0ZoRnjy9Z3S4HGyjGp0eO0nH+PvHLQyzEVFFVpgBzB8ijIvU
 xzOb72s7KLXLNSVrpBrEzB4jqI1Z1UWeCU/xaF2RhnKIyMZ278YhoBjBY0c4Bej8WRbcuRr99
 q+qQfNgPRu2pdXkD+WxKR4YAEJLnrDkA45YvbwydwNxKiCThxl2Am3V8kyWbC11m2rDCpA7G0
 KvB6C77
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It can be puzzling to see that was_tracked() tries to match an index
entry by name even if cache_name_pos() returned a negative value. Let's
clarify that cache_name_pos() implicitly looks for stage 0, while we are
also okay with finding other stages.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 98f4632..bcb53f0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -658,6 +658,7 @@ static int was_tracked(const char *path)
 {
 	int pos = cache_name_pos(path, strlen(path));
 
+	/* cache_name_pos() looks for stage == 0, so pos may be < 0 */
 	if (pos < 0)
 		pos = -1 - pos;
 	while (pos < active_nr &&
-- 
2.9.0.268.gcabc8b0


