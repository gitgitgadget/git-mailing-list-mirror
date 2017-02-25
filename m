Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3D772022D
	for <e@80x24.org>; Sat, 25 Feb 2017 10:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbdBYKal (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 05:30:41 -0500
Received: from mout.web.de ([212.227.17.11]:63072 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbdBYKal (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 05:30:41 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8zFx-1cboyO3N3l-00CTrK; Sat, 25
 Feb 2017 11:30:05 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] cocci: use ALLOC_ARRAY
Message-ID: <6652d950-7de3-3b6d-0a2d-414e0e4247f4@web.de>
Date:   Sat, 25 Feb 2017 11:30:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ZrddaTlyslB55CafA33d6/b5P2aVTRBTfPZVniQMvv86/Vl5GgE
 3INfPp0k7whGLt1+HiMwqIrtp0AIJClZmT+3X05dsfTy0OyQrnaP4IAYMWNmH3oAMCmsxap
 cnmzkx1impM+P8cbCP9sws86EBRPnPrcyz6dK5nqZqtmcBNAn904ow9YiexLZLp4pFl7IPs
 dQDcDxy/570Pr5PwAsOPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QyzRXM/Bts4=:4EqLcQ5baW/9C0R8eQNcg0
 9LmAWJJWxPPsXdrRM9Ql2Jbq50qpx3ruyYRcxW89U0gSFO/sDUu17FoBm9rbbnSqqJc7JjxE+
 Z5t+u0hEwbNbLytyvlST0GowbK5S8N0E2rLkkiiUfgtvPdgEO7t6WiaxLkpyfAUqPOZ9dw/wy
 kAFKkFMPrj0ttG033RUxr+JJLo8ZAj+EKZSAzTTPKdgPfDo+1tXkkIkQvrFtan6w44+loQ7DT
 o7/PNT6GOQb8O5nBgffusi5E4R4tHh1ssP9K4Qstg/8y78jK6k7OVg0lNEO6MuCtEJu0+c78m
 T8AeM6LuH/UVQ7mog2opr9igpmI8TVpRvToe5HB8MQxYI2pVjCm3eQmNqIKbV4T88ccq7/f31
 jn1TmdYEFhhlF8NA+kkDs7423ztN+WpgaRve0rnfJc1oJ4qzMsQmAlS3q71yXWvcEfkqEaohv
 i5JCfu89mGhNoj7AjozG9jRr1bwOQEkxLFHWbeTzliV1723G9DawsISe3KPTSQ0cNu1SPLZa1
 6u1PjxOCDwfVTFQLviADjNxXU5wqpbyuCYiZw4thmOMovcyarYHCTwrcdxT8GXY3sA90UbAu4
 /9x0HDcDqVrNjhglQPUz452aNf6WyyBOqEVNGNcFoRwO9kG8AFCbD0zucQg8aAsTb8r7w6mUx
 OaS9izUo1v7RYmCrjv1e/OFafuDN/Wt5JKUFXeIbsdL68P26Uc9bRckAapgByCacRYx2dv5Pq
 pOmWqwPGYyoiyEevQoRpWeahAtpZ7CIhQvBL8Cv7Rx128JpVncitVwQWxXr3X5uLJaAqLZ2F/
 H0JXWQ+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a semantic patch for using ALLOC_ARRAY to allocate arrays and apply
the transformation on the current source tree.  The macro checks for
multiplication overflow and infers the element size automatically; the
result is shorter and safer code.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/array.cocci | 16 ++++++++++++++++
 worktree.c                     |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.cocci
index 2d7f25d99f..4ba98b7eaf 100644
--- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -24,3 +24,19 @@ expression n;
 @@
 - memcpy(dst, src, n * sizeof(T));
 + COPY_ARRAY(dst, src, n);
+
+@@
+type T;
+T *ptr;
+expression n;
+@@
+- ptr = xmalloc(n * sizeof(*ptr));
++ ALLOC_ARRAY(ptr, n);
+
+@@
+type T;
+T *ptr;
+expression n;
+@@
+- ptr = xmalloc(n * sizeof(T));
++ ALLOC_ARRAY(ptr, n);
diff --git a/worktree.c b/worktree.c
index d633761575..d7b911aac7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -175,7 +175,7 @@ struct worktree **get_worktrees(unsigned flags)
 	struct dirent *d;
 	int counter = 0, alloc = 2;
 
-	list = xmalloc(alloc * sizeof(struct worktree *));
+	ALLOC_ARRAY(list, alloc);
 
 	list[counter++] = get_main_worktree();
 
-- 
2.12.0

