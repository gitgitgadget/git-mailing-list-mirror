Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009B3C61DA4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 13:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBKNNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 08:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKNNC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 08:13:02 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590AC11EB5
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 05:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676121173; bh=Xf3NLivsPKxkA9WSNkn8ELP5dt02eEU0ID+bFAFOdSM=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=hTHTjng3dIg5F4D0qcO7ht4nV7Lx11kq25M3EY3mURgXqmV1JY6Qna/vV7dJ/RWMu
         ahAkWnAXSZdfzgRkGSaCJHbIFOVJSInQGcIb/t5eqxn+tZ5iOfNeBfMUqZHgb7jW7Z
         MxUqgMLqBFfpTkI/TjRzLJIyIoVyhXNsxFrIz0kPrSx63dYPqxWvdvS1kv33NNPnF+
         aAHJjEO+K2U8k9qwxV+7sikSXHrrfrJJmV1eiUIMj0sXZEHxIUwZw1Xn0CNJ/RMnRV
         G2f+tGwJMdInMxPdErxxTrXpoLIbcHlYosTgEGLlIMTGD2CaAddXgY9wwKkuykx1gN
         +YwopP+imRMkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1d7s-1oTPY51hY8-0122dv; Sat, 11
 Feb 2023 14:12:53 +0100
Message-ID: <bf9ef090-dcd3-e92b-948e-e31ca1243d28@web.de>
Date:   Sat, 11 Feb 2023 14:12:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: [PATCH 2/3] test-ctype: test islower and isupper
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
In-Reply-To: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:agT8FcZDR50/fxhhgudzrv9evcWRKXO1eNz+mCZnKGh4OmBMDH9
 EFESdibAeW9ePtn3sKAPodSzlhHOGFTZ22fevlpe9kEzZ0mEHjsj9e0XIjnkRlifbTt2J3p
 oosidS/BG3dOJt8fhIklINGxxLwXHjdJSbEh2zyq8GE5azvpMLUkyY56lxMRXtYv42YaPSm
 LjkGCa+cm7GA1tYwCZV0A==
UI-OutboundReport: notjunk:1;M01:P0:L4x+AO9nBqU=;D7Ca+Y1EQlH1UWcX/rXx08eFPmM
 SehbfDYzzfCOZ0ddlWbYq4/KSgpbzzxJv5xKBH3QU+Vz1FeQWf86rhRq8kfK5J8ER6LUkgL5F
 eQyhhOEDr1wYwvG1E8Re4b7bnfsqIJw20imz5p/iLsTp06XMfkoGiz42znhTa4u7/EGDlxFXM
 bPeyLCsRmhVWpSGLF9zSVNb5dnwIZpMOfdF3Wxc2fqZ78sW50m1NVr10gnFlwi83revAQFI7P
 7C9iprDq2d9TnR2louIaABXs38BTwYx1ZmHrFthoi2qqFZiP/9cjRrK8K7vMCM1ORepIY3ydn
 EZF2s8+gaB9gECyu68/qfWBDAoBNw9ZeJ3vCi4cauUPTtxcTiavsFFP5tk/cf3tOdqtEejGgC
 atQ2yXeuxbBLaCbbl/HsvqIZfGVX3zNoKucJALnkRuZ2tnpDiUOAmh3BzEOdejzacwSfzrUqU
 hUWulwKRDOD90QLwF6I9oN61/JGt/GLcqusfScySvbOjVF30rA3OaJ5ypUqhmR4KODCH0HRd0
 BweEV8yyRoFirh8StlKKhKcvAVgx82MYpb+C2RWHGfhR6Zk70W2lgM82c/NvuovKsTOCaC95u
 XApQgOQW8lmQRjSOlCHtlYsYFLYEpvNaIT1702yF6brcrEQCty4K0pOJDess20UA2kW4jMrry
 cmImhUUEcd9syypEeUyliT5gUBUaehWnTJN/fl4xJ7hvCyXpf2n76EdM2CFLOEOzUSLkUNACe
 1gnbQZW3L2MQOk14X2JL9LaTLQPZLg31FxBflQ1xGZEiceaCOrWcJGVm2VLaF/FLZiCNNLNdZ
 LJXEbSg4TbOygZxsnFRsM6LXsjrREaRAn4DZGlki31Nz7cP+a8b7NALpowCoDGAES9UHL6fZC
 kqb9G8kXtT1M5++Kv2P74HAKcOCV7VOgXNgTJIUedlwc/x6GXAfEAQQEoZ8YmIz85fJeiWjc4
 laufZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the character classifiers added by 43ccdf56ec (ctype: implement
islower/isupper macro, 2012-02-10).

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-ctype.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
index caf586649f..8ac76e93e4 100644
=2D-- a/t/helper/test-ctype.c
+++ b/t/helper/test-ctype.c
@@ -53,6 +53,8 @@ int cmd__ctype(int argc, const char **argv)
 	TEST_CLASS(is_regex_special, "$()*+.?[\\^{|");
 	TEST_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~");
 	TEST_CLASS(isascii, ASCII);
+	TEST_CLASS(islower, LOWER);
+	TEST_CLASS(isupper, UPPER);

 	return rc;
 }
=2D-
2.39.1
