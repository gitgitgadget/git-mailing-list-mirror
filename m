Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B5EC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 07:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2374F20684
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 07:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jXpNCJdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfK0Hvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 02:51:49 -0500
Received: from mout.web.de ([212.227.15.14]:50529 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfK0Hvt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 02:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574841103;
        bh=MYFZbvEEciho8rTicDcwOXWR1YZLTJ0Yf0CVivOZ4y4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=jXpNCJdhlzqRFVOwHJNMO1baY2Hq0dwkRCk3UNFKC006RldCo7sN1NszVxikygQtx
         CIoTf+k2gGbWDFFKriQ90v6gMm3Jv+03+5m9u4zxUZK2LA85fO7LBEvx1O1PmhonW0
         o1BeBNBbdAl+8G33dyt85z2GsD7r0WBDhOlwUH4A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MHGJ1-1idyai2hAh-00E4hR; Wed, 27
 Nov 2019 08:51:43 +0100
Subject: [PATCH v2] test: use test_must_be_empty F instead of test_cmp empty F
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
References: <52479277-b753-c3c0-7f6c-5d013016964e@web.de>
Message-ID: <a56a4b33-61f8-d3a5-d85f-431c70b8f3e7@web.de>
Date:   Wed, 27 Nov 2019 08:51:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <52479277-b753-c3c0-7f6c-5d013016964e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dnc7n2L1n3BZJSFUzD2twS2JU8qh40v0gTFH4Dl/uQGO9W8R9x5
 whNpI3saomlWRrjxZXY7rS0APzLUrChKbFdA7UxoOgoP8jeOzmazPWZaBoK7qL5FkcsZk3U
 +iZP1W+fDP2TEQ8+J2hR96tjVEUNNoLg1YL7gL/8sG3whLvYLoTr86kcSKHBnQaBQvQNe3e
 Lbjik8/qOeuXpguyGSzKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CpALCX5hAao=:XryI6IER4uIGMpbQEKOsZk
 6tNBdMn5zLXfKFOkDtCwUI4yFQzpAdhUnS+r1MHLCfLhoSKTolynXb+mj0RFNMwV+BHVwhW74
 ElMy6yYPb7k+O+pVhFBzqxeHz2HWEhH3L5wheIkNpRQgtgwMt4LCp3666PQM1i4WuejKnDFfO
 d+9OtfzF9sFAlFanYZktILYD5RXFuPeR0aDFhsIdCrzDf+0HVbo46aTIjZigb2ZroeFHtnlGU
 tROfja0v+08+13KVpyci2HzK7CV3hMw3CWjvPV5t3egWRVg3cbqJI2NewbxhTj+5e1zz9nJho
 DoEq0YtdZijkKT3PG9fuNoyfOYxfh6OXV6OmvWomn23/u+j81k1dSKZMP0uI8az0voPrksih6
 oppwV+OyAnRiNTIXqGgP9kCJR634MHJWFSsNXbpvf75AGCXtjv2dLJHKDootyi5+BxlVF0UC6
 Q25/UUGZ45xhV6zguw6g7H884rgbDUdC/ct9RDL84YdKSizsWw9fjBfKoABTuwl8y8qeQjnnG
 Wi8E2GERfTe6Sfbj7LocyijThcJa5K2hQQtMpn4QpwFGONLGvvHovfLig6BBVDy4tT8jSKyNY
 +MRQS0YIXoU4uyrXH7Ddb5JUD1GTelHkXGsVqUIZZsKX7v3PPL+tvAeHTQXeB2bYkJdTs86yr
 YdQxCNxhSukzSghPdh32qRibljXJ6ed1zUGU7yDv0UGVP6HjOvVgeLl5llg6oT19kDBfin55k
 jSlgL9eMlQH7W7shS9STLB74u2YStSLElBhqY9gsRlyFQtf9SBY/MQkSF48bnA9VNfEi69rAl
 sz9HbTpwdp4gJ+QYDO/F8iMY96A7kdjQyxDwHZZ1yhhQkzjP0icY2KrNCkeVnSa+w9DyvnYvF
 vbGfnQneS8J6S0A758CKzwQybBGjB5FyB23nRJLWgMVsT9EsGZJmnOId9F8jtlFK3cDOBg/Uc
 npxMsnCJsBCcU3vyG5LatD6DfpbWURWU0sYKyM8vdMfccolZuJI7o0T7yS54Hmu11mIreE//k
 9YebTR6BV79bT3AdtT8a6bGYnOCikeFUeTEzaIReO8Ea4xf1tzDa7bJ95JjRJrzgPe5BpNQxf
 OwjFr14Y+hfJGbPVW8DPX2uL+5VK5jJMNwUaDs66MRgCPVl7G6kiBJKDFujgtBsFryWYnAIi5
 wLizLX4BV3ShoLvfgLfIaOqz0boE8vA5J5CX6rT53ViLQSo85t4mFTgCfGS/ssRaXESOcEm/w
 m8FMzaVa83yPwfTCIsfUBvoepdbbgHJBKsEuCZw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use test_must_be_empty instead of comparing it to an empty file.  That's
more efficient, as the function only needs built-in meta-data only check
in the usual case, and provides nicer debug output otherwise.

Helped-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Change since v1: Don't re-add PIPE prerequisite.

 t/t1011-read-tree-sparse-checkout.sh | 3 +--
 t/t9010-svn-fe.sh                    | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

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
index 0b20b07e68..c90fdc5c89 100755
=2D-- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -53,8 +53,6 @@ text_no_props () {
 	printf "%s\n" "$text"
 }

->empty
-
 test_expect_success 'empty dump' '
 	reinit_git &&
 	echo "SVN-fs-dump-format-version: 2" >input &&
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

