Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5898C4320A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 20:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A53EB60F21
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 20:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhHWUNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:13:32 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:36106 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhHWUNc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 16:13:32 -0400
Date:   Mon, 23 Aug 2021 20:12:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1629749566;
        bh=HwRzXe0LfhjNV1eGoTstBZlB4BRthmdTYAxt7o1bn0I=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=GHmm7JbpA46yxB6arG+WL7zR0sFHSwQcH/GvXaVLtj3RVMhLo8nyYCbwo5pZ3y9Jq
         EmZjoD0VWzVGcNW2QPe/xrdW8PPq9r/tqOa5noGRheqIgjdub2zhC+Y+wdV14oBEu8
         +9EVKJouveFZJEKEsmXjo6lqNh7COl1yJ91s9PWA=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Mickey Endito <mickey.endito.2323@protonmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>
Reply-To: Mickey Endito <mickey.endito.2323@protonmail.com>
Subject: [PATCH] t5582: remove spurious 'cd "$D"' line
Message-ID: <tV8xl8isDPhmGxCNmN06tTwhJTve0PsrkakKwLMcFQJybDZO2SGHHbDLZFrcLp1Yda1_KRygSm7-lVDSZSaG-antdalcPnhSqYqcK5Fpifk=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable D is never defined in test t5582, more severely the test
fails if D is defined by something outside the test suite, so remove
this spurious line.

Signed-off-by: Mickey Endito <mickey.endito.2323@protonmail.com>
---
To reproduce a failure do
D=3D/some/path/which/does/not/exist t/t5582-fetch-negative-refspec.sh

Note: The variable D seems to be a reminiscent similar to t/t5510-fetch.sh,
which defines "D=3D$(pwd)". If you want to adopt that way, then you have
to code a fix yourself. ;-)

 t/t5582-fetch-negative-refspec.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-ref=
spec.sh
index e5d2e79ad3..7a80e47c2b 100755
--- a/t/t5582-fetch-negative-refspec.sh
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -105,7 +105,6 @@ test_expect_success "fetch with negative pattern refspe=
c does not expand prefix"
 '

 test_expect_success "fetch with negative refspec avoids duplicate conflict=
" '
-=09cd "$D" &&
 =09(
 =09=09cd one &&
 =09=09git branch dups/a &&
--
2.30.2


