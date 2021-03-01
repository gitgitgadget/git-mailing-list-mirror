Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EE2C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394A7600EF
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbhCAVqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 16:46:06 -0500
Received: from mout.web.de ([212.227.15.4]:36681 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244416AbhCAVnh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 16:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1614634903;
        bh=mT71t9hkn2GuCrh4rfbzaMprtABriAP2VFFpj55uRtI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GwJ0GWBW7y/smeGCO4Gipuu/YhLrBAvJjpPKZHuxtlK5Z8yCEx2FDZRU2mZI4Xu5V
         obY4uy5qZMHC6gnNdGub3ydZgmFmy7tQ5CykXkurNEi0+jY2AwOKZJMSDqtQVqeQqg
         kqhSmATwuYHHeGMR5uUGz1IpZv2PvC54AP7xv30o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([195.198.252.176]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MWiA0-1lIyys3fOS-00XSG0; Mon, 01 Mar 2021 22:41:42 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Dan.Moseley@microsoft.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 1/1] git mv foo FOO ; git mv foo bar gave an assert
Date:   Mon,  1 Mar 2021 22:41:42 +0100
Message-Id: <20210301214142.5557-1-tboegi@web.de>
X-Mailer: git-send-email 2.30.0.155.g66e871b664
In-Reply-To: <xmqq7doqwvzx.fsf@gitster.c.googlers.com>
References: <xmqq7doqwvzx.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mKBF5lXK56wnuIDGV0jYb34PhLS1CogQ2hc8yCY08FKWlQz0Lb+
 zvcmRrpBrURxg0SMvZ9sSXSGKteDG574GHF7oVcNe5aOmgdInTi/eiPZrckgNp6nmYszrGF
 3yYCwNLVMkWll2xWoPeHY6rcdjx+PSCrfOU5aWIbuoH3sXRXKd743xgykHYLa7pGTre+FKH
 0ZKyoiznVc1uk76p/vZoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9kZrPku9cbo=:i4EvkyLwa2m5zuBdCOzuWg
 7N6nLJuerGhKccG+ShKAtPQzLk9cL2TXtW+tDMW9utsq4oVtga7EnbLtdC8WZ7UAnP9efNCtW
 dK7liF0bwW/twu+VnQ9FBmj54T+L3h0qtdYxfvyQJ+/VuIg4jpD0onr4Mki6sRHrSLuWzX1g0
 WH8aXNs4YC6/XUi8I5RyAC0PTZu3wbSjqloS43HRdfFmfZTFEwEidX/pDrirWtWLhjoGfYQPe
 9SWC7fkN9YxM+gqTgJvXMjsXEZoiNhJBboC4qXOuCrUguJGWOSZ3dhzbCs6P1r2+4Ytfiuhkc
 AzJ3ajOT5KltKFpWa3ieldHgr1ijsfGwgQPiwTtru5YAHCLUPeiduzYv2cx5hJjmHZyUcnM+5
 cdsk8PIxDqR7q5sV88B6sLI2KXz3RE10pegaEs+VyvFAccr0opYKUAeehxyuXGOXVAcggI0Q5
 HN2M8EHaSZlCka/sPLeKUUXUec1pPeuVoT+N0qjUXfKiBWJ2qjoBZw9QO7SanVSLGTbw4Bb0L
 hKhE92reYMkTfd8gfFa0gAEDT/HOyeGyqHag4LMB0gh+yR+OWUpP6a1ZTZoJE4LT+Xa/KEUCd
 m3sUoNc8nXUFYoKIF84kkZJvG6o5QIOybW+BcY41T5Gk6NQCAlwOhp3SVU6apQfBEMtCDBPWh
 1XXg3Fmg3T7Lkr9gzzQIgVRbnHMi+nQoi6+6rlhXlLd9r8VmsI+G8VNvA9pSHBiQ+/hwMcdFw
 kZxrDugz6vumgDTRC3JpWelG3rnY5fZIWxHZxArlIoNtnUkTRiWDsCdeS/nFMtK9X1l1va6DS
 EN9B43HSAWq0MiWq/qEKnnuiPofaRwOjRi6YE6eqrbOTtvB59Rx5YVOG/+9o/dDkWUx38aLNi
 WE4Iy4w1hO0AKCJLSNsg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

The following sequence, on a case-insensitive file system,
(strictly speeking with core.ignorecase=3Dtrue)
leads to an assertion failure and leaves .git/index.lock behind.

git init
echo foo >foo
git add foo
git mv foo FOO
git mv foo bar

This regression was introduced in Commit 9b906af657,
"git-mv: improve error message for conflicted file"

The bugfix is to change the "file exist case-insensitive in the index"
into the correct "file exist (case-sensitive) in the index".

This avoids the "assert" later in the code and keeps setting up the
"ce" pointer for ce_stage(ce) done in the next else if.

This fixes
https://github.com/git-for-windows/git/issues/2920

Reported-By: Dan Moseley <Dan.Moseley@microsoft.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
Changes since V2:
  avoid the trailer mess-up by putting "this fixes" before the trailers
  Make clearer why cache_name_pos() (leaving a dangling ce) followed
  by an additional cache_file_exists() to set up ce can be optimized
  into a single cache_file_exists()

builtin/mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 7dac714af9..3fccdcb645 100644
=2D-- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -221,7 +221,7 @@ int cmd_mv(int argc, const char **argv, const char *pr=
efix)
 				}
 				argc +=3D last - first;
 			}
-		} else if (!(ce =3D cache_file_exists(src, length, ignore_case))) {
+		} else if (!(ce =3D cache_file_exists(src, length, 0))) {
 			bad =3D _("not under version control");
 		} else if (ce_stage(ce)) {
 			bad =3D _("conflicted");
=2D-
2.30.0.155.g66e871b664

