Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C680C432C3
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 19:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397C02075C
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 19:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="SlpZ5B2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfKZTqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:46:39 -0500
Received: from mout.web.de ([212.227.15.3]:52003 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKZTqj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 14:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574797594;
        bh=dZHebHZ50eAge4pPo0jcOzOHRgHsHuhEVtiZNyxDRCg=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=SlpZ5B2k/3yL3Z+1HmXy5trvvaNz2hGQDEw+7S8gcWVQh4nSxW8M3LebVxxk7u7bU
         etKrDf8TBO2PQXByT6GtUe/Bnn+eOHLdzA0SAAgHp/wnk/1wvVU3jEFrQHmvj6Gip2
         yEVp5of7WClePq5wQoXggeFzkGRc+KdiKr3QpxF0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LuuC9-1hrNmN2iY5-0104Bo; Tue, 26
 Nov 2019 20:46:34 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] test: use test_must_be_empty F instead of test_cmp empty F
Message-ID: <52479277-b753-c3c0-7f6c-5d013016964e@web.de>
Date:   Tue, 26 Nov 2019 20:46:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Be/zGLAdufkalAp0waExEie7nKJ67EhZhDznQrbg+pVXdFHYqQl
 PwTnsrg59kuyiMpp1b7EW9PDQlmJqYwf40nlCqHkpxalf2sHvdVZzOJbTwa57T7FKvwNgjy
 uIPsbQEeI3RhhwY3fKhlI0OMECsCYK3qoRyL7rPsqL7hYJMzIawy2lZk0hYq09SrXfTLCoE
 hjX0itAOf12CkFmmf63Lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OIJ0st9IkGU=:RVbe32R5F9Ab1RA5vrqwWb
 7yI1MgrjR2FmZme8ZSlVGsBnZyq9nAUAeJbjH+YH7lJ6jXdxvCBd+uixhXKXmxX+2kZVrXdoz
 B0xhxiWTjUcZ3E4N5JUI1d7U9grcJLkr0mdr/sRxHouS4uSaUXWcm8g6lJAoTm8JHQSfI//O3
 M04+VyRjKOlFQ/i5tSJtfpH0/pE+QfjLtnzM0M8KPmt1Wq2KTB+IFrMcTwk45DOFzchHPWFuv
 FeU0u3LUZIspWb5luqQWH3gtt5f+WayGRXN+gPsGjiXORB6rmc+xYJ3fGZXzPt5x9iN5UmZva
 mHqi4hhzHgeR5jP2MHUTFbpTnFKCope3gk+VtVVkCnxeEZUyNvoZehQYU0rblKsHs1T+14l97
 3zNULU1eSllfxF54SLNSQ1BnJEjInO8VN3pqhGy8T5R1bi8ZFuFFyn2KTd9NV5PB4TGXRZs9G
 1GlJmsvmKL9Te7YYRVzRHfnDrgmkAi64TVZMgfI7/sM2QYTojtAG2j9gwjPmVC6RbljmBkOMS
 ah7OHaNZBz3MbF43jKRJn5J00PTRmCxNeL/uRJiZ1QakBtRPw1YqW+721MkPQ4PZrRJ0FeDtX
 WNlg7VxJK1gWJmLJ2ERsEuEfb1rKB4q+91zHNrLMf30G/dDjsJNaqlxAxbUU38NcOkKpme4Hi
 foYrdvx2SNQQ7IlrqbFx9npE4MAzPYnvDsUOCWDH4xGIGpgA/znxmjWnCKyxh6lpWnVTMG7RR
 jFiSB1PUQiaFebFAqIEZud3jfUp3Jr0An5B9okx57l4xzMByoy28smy0BNlAAIa4X955fLVr7
 d9ZNWU9DbSPHHq0DbjXYjSUctVEqQQN86mqip3m1Hk3sjUk0UmJU+gSy2E2Iq+h/TlCxmDBYB
 jSJunsIwhXSplL6rchEbZzenkud9IgfYs7wkQGGcmSs8IaB8YmZ9tFnXi88kFqYskWZMSZwCT
 Ll5UKeaE7/WCVYCudXiJBk6MGWuo/IIacxY6eGTig4SXzPd6yGXiNKMS8j/QHm063WB8LJTCx
 yG/mLWtr5V2HBnevJijWuw8tm9wcyTyBDo6oLAK1ymtyBz84Yt3uz3VAwbXxrzkDtcNzW8Evc
 0JbPy7piql3i7yJEVQzdJY24+AXmJmoEiZfv0WrVEYMB9uxAanRqUPWu6FIU7L1OwoloL+Gjp
 un0idp9IM+cKQWbOLXqVeu0Ur+A+qJEF7D1xlNKSRGRDFZagYHtD6MMpsaBIGfxx3QAWc1SPX
 J/d/IoxqfZA44bipRJ7a1SKKaWDzaONAw3p0jbA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use test_must_be_empty instead of comparing it to an empty file.  That's
more efficient, as the function only needs built-in meta-data only check
in the usual case, and provides nicer debug output otherwise.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t1011-read-tree-sparse-checkout.sh | 3 +--
 t/t9010-svn-fe.sh                    | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-spar=
se-checkout.sh
index ba71b159ba..eb44bafb59 100755
=2D-- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -215,7 +215,6 @@ test_expect_success 'read-tree adds to worktree, dirty=
 case' '
 '

 test_expect_success 'index removal and worktree narrowing at the same tim=
e' '
-	>empty &&
 	echo init.t >.git/info/sparse-checkout &&
 	echo sub/added >>.git/info/sparse-checkout &&
 	git checkout -f top &&
@@ -223,7 +222,7 @@ test_expect_success 'index removal and worktree narrow=
ing at the same time' '
 	git checkout removed &&
 	git ls-files sub/added >result &&
 	test ! -f sub/added &&
-	test_cmp empty result
+	test_must_be_empty result
 '

 test_expect_success 'read-tree --reset removes outside worktree' '
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 0b20b07e68..3a3d8d3bd5 100755
=2D-- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -53,9 +53,7 @@ text_no_props () {
 	printf "%s\n" "$text"
 }

->empty
-
-test_expect_success 'empty dump' '
+test_expect_success PIPE 'empty dump' '
 	reinit_git &&
 	echo "SVN-fs-dump-format-version: 2" >input &&
 	try_dump input
@@ -208,7 +206,7 @@ test_expect_failure 'timestamp and empty file' '
 	test_cmp expect.date actual.date &&
 	test_cmp expect.files actual.files &&
 	git checkout HEAD empty-file &&
-	test_cmp empty file
+	test_must_be_empty file
 '

 test_expect_success 'directory with files' '
=2D-
2.24.0

