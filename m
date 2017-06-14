Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5689E20282
	for <e@80x24.org>; Wed, 14 Jun 2017 13:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752438AbdFNNHa (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 09:07:30 -0400
Received: from mout.gmx.net ([212.227.17.20]:61770 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751869AbdFNNH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 09:07:27 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIhDo-1dNKvx3TZo-002KK3; Wed, 14
 Jun 2017 15:07:05 +0200
Date:   Wed, 14 Jun 2017 15:07:04 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v5 01/10] t3415: verify that an empty instructionFormat is
 handled as before
In-Reply-To: <cover.1497444257.git.johannes.schindelin@gmx.de>
Message-ID: <5ab90ad1de6ece32c959115b046ab303503cd1ae.1497444257.git.johannes.schindelin@gmx.de>
References: <cover.1497444257.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NZZ+PGg5Z+mW9b61QA+mfHoomQn73lwTsMVIbEX/q+a6BRNimyn
 ruTatgXSKb/jOewt66hHYQgS5lhWJiAXhHPdJEv3R0XsRJiKdOUG5/4F0tHO5PImLi2UQQm
 0dy8825/sq34uBE7NyGUTTESOUAH2tkV2482c+TTerxjwOcJ9fvgJWIparHYf4grt+Hukci
 P/bo6Z6gd3xQmevWiIKSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FE3rEyFSAfM=:Dqws2iTtqrOwugdtplDWvI
 vqAiv/Gqqhsl5qDmNNDQXAXps5/J6YxsjS+enMbvUW7wkJqnHxKJJ+7/Q2Zq3Uty05uBYrzu/
 1nWtw5sodW4Co2OGpIGdiT2OLCpLXkEH0lUbxDcNE4g7j4grURlZvcYeQyHyIr8hOG455cAo6
 Y0XI0e9TvkdUzc5O8hg2iAkA21JauqyBr3f9BA9z4qAHMvmsRkq68Z0wIRBKk3uPkASemS5TM
 ertAM5rZd0bjw37h6XlwLyEmvH04B6d5kSisgZYc2eTxFHF3ZcQyyfsmJ6avBgabj5E7LF1E+
 bsYcytymtrt6Dnm8ciO/lZLU1fJ3ZW8HzhmVpQIqcIvvOvt1Lt7GBFluz8hBowiuh4XuSqo83
 8ALzdHDSF/15AMmCUGPSJ0Qw9OCcppyr2UjlavSB14JRfpFV8VrvUFXELVGuzIY7afgbysahA
 g3AyO/BfXg2D+dmwt2tvfyBgMUXwM4hlo13cRXMt18/R0pi3VMij2KrwEE8vZMK0HetIll64j
 +GZWHsvJ2Z61xong+STorUKoo7/fyOWEIRRXNthVaSMNLTrrOIfoRaF3DtDu4LsO53dQCVzN8
 SUxoajIhryEXn2VUmAbiZ9gqA4btXReLYGmdBjUOgEsxCj7MkTnx2PSMTm+uMKef7fRFExV12
 nTCgYhsvt+7Ck1z5wbHyLGE7SZRuPWCx5myo6iWyuSPD4jr3/KomrAbg39IfOiSWJLuEo/JK2
 Y7yky8p52i8E0/cK4jMIP5pwl/HRrd8XLa6/D/5obER6LoY7cAPFvx95P1J2WSVKn5IX/R2LQ
 n9QQwN3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An upcoming patch will move the todo list generation into the
rebase--helper. An early version of that patch regressed on an empty
rebase.instructionFormat value (the shell version could not discern
between an empty one and a non-existing one, but the C version used the
empty one as if that was intended to skip the oneline from the `pick
<hash>` lines).

Let's verify that this still works as before.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3415-rebase-autosquash.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 5848949ec37..6d99f624b62 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -271,6 +271,18 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
 	test 2 = $(git cat-file commit HEAD^ | grep squash | wc -l)
 '
 
+test_expect_success 'autosquash with empty custom instructionFormat' '
+	git reset --hard base &&
+	test_commit empty-instructionFormat-test &&
+	(
+		set_cat_todo_editor &&
+		test_must_fail git -c rebase.instructionFormat= \
+			rebase --autosquash  --force -i HEAD^ >actual &&
+		git log -1 --format="pick %h %s" >expect &&
+		test_cmp expect actual
+	)
+'
+
 set_backup_editor () {
 	write_script backup-editor.sh <<-\EOF
 	cp "$1" .git/backup-"$(basename "$1")"
-- 
2.13.1.windows.1.1.ga36e14b3aaa


