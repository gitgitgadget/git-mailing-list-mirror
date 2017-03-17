Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F6C20951
	for <e@80x24.org>; Sat, 18 Mar 2017 00:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbdCRAlf (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 20:41:35 -0400
Received: from mout.web.de ([212.227.15.3]:52055 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbdCRAle (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 20:41:34 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZUjd-1cUIIq3Mnl-00LBvs; Fri, 17
 Mar 2017 23:12:53 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] http-push: don't check return value of
 lookup_unknown_object()
Message-ID: <1a7123f5-9017-7602-03f4-5123cdebe541@web.de>
Date:   Fri, 17 Mar 2017 23:12:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:g+GHPCPvwzJYcJHGOl1HHywhEQv6rB7AB1885jjw+UH6WCwwD6+
 QWnM6LXl3Dm4JO9xiWk0iFhZxhSRpd8c+sEK5seRJGpPbLb3m5GU53SNgvtZcONvw+9veY3
 xWVzr7qyqIFJGc7j8f3mbXNcWfTZheNI5N/yi/vZk79HuK1H/hTYVfoQbQkemOX7dAH1c0M
 a2P2KDdFc2n+pzR/RtfVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PYHl3VCYHgY=:UGINfRQP6C9ykLaV7Ehnnk
 7PIlRWTD+EME/QEUQR/l7MV4Du8nE59vQV4nRaK3boGr/JvmMA7TiXFcBlIUXGxE2Oj7tAmJU
 YJ6p05KbLtNyDE/femrk0vAVLy4DUZamw05VECd2Y1aSMSfvAO9aix7s90uyQhimDykNKaCcx
 SGZl9mk1w+7F9gELI/hSKZtdkPjfnLdvwZgi6puA6e5iV9d31L7UU7bxjgxyJD15fUekPQe7L
 kewqg1TPs7jTCZMtyoq18zWrB4diXBSj2Tlb0VfKvWmkKHEJobUQf3cGn6LIl+i+sSyb3CJ/E
 JWyLwg+ZNfHDEb5vtEbAK40v+b9BqbdiVGLIG2QsupDlX+e6nKkWQ7xsWX9PLtfvgKera9K45
 Fanh0hbbMDQdVxo3K7BwMHdWxSNl3e/kvu1Nx9wh/I0Hi4iKQP4cR2q8isLH924k16UYkQUmy
 cRWiMjro6s2pLsJGm8ljbqYSA63YCew6ZIBT2/vkK3NQvooZpO/Q0XaYlPe9HdlkwTf1zob2N
 ExRzwjCnNfA99hOzOvgyEHjyTatFswi8MAgscCCzNN3ioJMdXO2Zr8Vjfg4Yh5nxkjdipZWzT
 adOovtMCalk0XkX+qh5MXGceygiTSFVL0orJ/Cs3dA1PMfaTrlERCoLT8fgS7cX5fGV3SdwaX
 n6TL2KFzt4FDA5fE/dIm83w4fFKDCmtYHLD4Pxqt6KhZUaW+K7NIipvusysl3g6MxnkHhdc97
 xF1rEdBGA5gWlcQ+UuozMJyyXRJ4JP+HT7YeORZn5FZ2mpTWscAnOtHAJtxYgrczzadYaTV8+
 PnbMnZ5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function always returns a reference to an object, creating one if
needed, so remove the unnecessary NULL check.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 http-push.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/http-push.c b/http-push.c
index 704b1c837c..f0e3108f71 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1431,11 +1431,9 @@ static void one_remote_ref(const char *refname)
 	 */
 	if (repo->can_update_info_refs && !has_object_file(&ref->old_oid)) {
 		obj = lookup_unknown_object(ref->old_oid.hash);
-		if (obj) {
-			fprintf(stderr,	"  fetch %s for %s\n",
-				oid_to_hex(&ref->old_oid), refname);
-			add_fetch_request(obj);
-		}
+		fprintf(stderr,	"  fetch %s for %s\n",
+			oid_to_hex(&ref->old_oid), refname);
+		add_fetch_request(obj);
 	}
 
 	ref->next = remote_refs;
-- 
2.12.0

