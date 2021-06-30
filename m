Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A30C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 16:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC67B61456
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 16:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhF3QPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 12:15:19 -0400
Received: from mout.web.de ([212.227.15.4]:35745 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhF3QPS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 12:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625069564;
        bh=zWb7s8PuJbBrsRU1laFF4O90rQSci8TZIysBanU7Pz4=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=DiBxi6Mkhk651qyGJJJz5wgOl83SG/BZfMdZwxFv0En82MxjS5TBr+tWuwJ0sLL2a
         9iiLHWmLINZEAoF5uFQAgoxmcXJDUAJns1En9GSYhI3mwObXsBnQasIFaCKEs8kPpH
         DwOnzpP4D1ftoAlZZa+z8CNNj42PAIQfI6LX4eSw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MDjw6-1m0IJ00LC2-00H86f; Wed, 30 Jun 2021 18:12:44 +0200
Subject: [PATCH v2] grep: report missing left operand of --and
To:     Matthew Hughes <matthewhughes934@gmail.com>, git@vger.kernel.org
References: <20210628121748.f3yrc72v4mynknl3@debianXPS.lan>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1eeb34cf-3229-21f8-23ca-ab3c6d4dff2e@web.de>
Date:   Wed, 30 Jun 2021 18:12:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628121748.f3yrc72v4mynknl3@debianXPS.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f4btspnJs2+c9vqEL4owksk+j16BdSzJOWGJlBUuuCUZY7xh+SG
 8vFEZQfNB8dRZPhbhcgGocwXruFisuZB3kHBNhEDr9zZZ4jwDZS+/2E6k/hcbmq7dhzttPF
 hubPItax6pxfWgdWoZRSkD5OVzAnnhinqgK3bqwZnx+lob7QZThNcSJnzuaB1gzkOLEDBa2
 et9kRx7YdmNUgPLhOlBhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ix3cMitgCXY=:wzMtsFerV9ET2WVvz030+8
 h3YTcYVPuWqlGPXKvLOz7nMz8RyCjBwHYmnxRnmOs69BBX8tv81tFDlwiFJ3tOoUiMGdfTO0a
 TAEhQ6QL/JXigJM5//M3cRObuUFd6BPyLj27E2J4T947B0GShiGoDArfkuyPqhsvqvhm73uZL
 UYcHxWuPianr+WpMTo3t4qI8B3VmAabq+UbIGmdwZ5RKZ/72Iej/iHEbv80+jXEaQgLLCZrGn
 kBNTKVmeRdc3k74cVKEaswm22doHqSaOS/76XOmiEXHcvfJTISLJCG6RXQH7KWu0QKofScSK+
 VPApM1UG9FnflVs43icSKVb5KOJIm2idSTL/Dwd02Ya5Q/DLyOLsBOzpYv3qshtNa56WkoQ0v
 fwVIa/hIEaam3aiWvC3dNj9KFqQjtV05yr3J5eMOJ00Gb7eImP5CbW3L8EP16Ty4CoJVEQExr
 i5+HRVqgfYmqpirTrzaYrNnX2NLky8Yd11ARQCLiawIAdjc5EiJfZiuqTMBSIIDzfGeUKni6A
 V75g6vJmcYIDidaZVyseg04CfzDuprOZ73dFtaQAOyiAf5k9R5YxbQva0oO/RDEtDarkP1BEt
 zOqE4qUwov+ptEl4HAckFwZ7Pr/RE+U65CE5zffwwNl5LJmmmeRShc7XtzPZC9Sd9eAZZBH+6
 ONpFvfmgHlLHRPbbI2/74ODEw/A7H6V89RhoLaHF6nf2+kQvruwRhoC6zLUzyKS6ZDiddShPu
 7Uq6hkqbZkNGiG6fQBp362irrIGNLGXLdUH+h/mcLWGh3vffdgmAjvXWdR09VF4XlpCbg9ZyU
 F8Pazeu0r0LNrTXjw3QR/U9Iegs4wuWTcDQ5Hs1covo3bVDAMpbXQd8HlXCFvVXhNXJMScfxq
 Tlo+tuGGkdkYfuZhItEvV2moqhV0Jn+eQVlwhg2giB1A4jOi5EKTMKxwav9weHubAgLiatQbm
 QpjzQZ8/7IDBiT2KK5BAeBu6h/jZXdBUi7w0wRrMQ7v7DgSWjYPdodJeC1Zgftfx5j+dDkTD+
 3ZHn53MFBpjIyapVaAsh6yzvADgufTqhmgOCulXBbtT26Wvap9eqfbGVBwjAkTNFA1hb+wj3u
 XXC72vTrIcmJY8FNkoJ4Ho6gP+bSYglaD5m
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git grep allows combining two patterns with --and.  It checks and
reports if the second pattern is missing when compiling the expression.
A missing first pattern, however, is only reported later at match time.
Thus no error is returned if no matching is done, e.g. because no file
matches the also given pathspec.

When that happens we get an expression tree with an GREP_NODE_AND node
and a NULL pointer to the missing left child.  free_pattern_expr()
tries to dereference it during the cleanup at the end, which results
in a segmentation fault.

Fix this by verifying the presence of the left operand at expression
compilation time.

Reported-by: Matthew Hughes <matthewhughes934@gmail.com>
Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v2:
- more specific error message,
- grammar error fix in commit message,
- no test of already working behavior.

 grep.c          | 2 ++
 t/t7810-grep.sh | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/grep.c b/grep.c
index 8f91af1cb0..424a39591b 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -657,6 +657,8 @@ static struct grep_expr *compile_pattern_and(struct gr=
ep_pat **list)
 	x =3D compile_pattern_not(list);
 	p =3D *list;
 	if (p && p->token =3D=3D GREP_AND) {
+		if (!x)
+			die("--and not preceded by pattern expression");
 		if (!p->next)
 			die("--and not followed by pattern expression");
 		*list =3D p->next;
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 5830733f3d..6b6423a07c 100755
=2D-- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -11,6 +11,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

 . ./test-lib.sh

+test_invalid_grep_expression() {
+	params=3D"$@" &&
+	test_expect_success "invalid expression: grep $params" '
+		test_must_fail git grep $params -- nonexisting
+	'
+}
+
 cat >hello.c <<EOF
 #include <assert.h>
 #include <stdio.h>
@@ -89,6 +96,8 @@ test_expect_success 'grep should not segfault with a bad=
 input' '
 	test_must_fail git grep "("
 '

+test_invalid_grep_expression --and -e A
+
 for H in HEAD ''
 do
 	case "$H" in
=2D-
2.32.0
