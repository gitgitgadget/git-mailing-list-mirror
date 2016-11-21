Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A15801FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 14:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932411AbcKUOTH (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 09:19:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:63435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753169AbcKUOTF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 09:19:05 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJngW-1c9vt40Zxk-0017nB; Mon, 21
 Nov 2016 15:18:30 +0100
Date:   Mon, 21 Nov 2016 15:18:29 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: [PATCH 3/3] rebase -i: handle core.commentChar=auto
In-Reply-To: <cover.1479737858.git.johannes.schindelin@gmx.de>
Message-ID: <9ef529a4fbb60990a91d7bbfdd49c6d20d49e442.1479737858.git.johannes.schindelin@gmx.de>
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:i1Tvc+Vuxmt+bFAHLklFPaVlh+OQkLVN7xK7JKCKGTZC/9DqB2s
 SrUHV1H5hUuoqVA616G5dkPT8PdIo06iJCVI2L9acSPMrmd5VtXkCNLLWiGcSyEbcNBIdMF
 Ao53TI8wrDRmmmdja39pEcoiz9cdyG2WtuDkIPOeOFdSVy4WUXbOqm8XuEhBZQ4L0wlmEsx
 UKXqj7PE1czx5vjIPdYgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jJFIJPDMF/M=:EeuwshNFbWGKUeGTktrPD4
 KrYoK1+YbidDDYeiAFJw+7mCjprNhyO5E8z3Eb8QwwSQzCFqloV3e5MrFHh2iIsNn96QWZguD
 ur3/l+eFg+q35jMS+WCsotHa7RXpj5z3p3zoyvRVyPyJyZCD/dRm5FoBKxLO8VwGUuQpPqPnO
 FHElF8B/JTVFRT0OZGOMgJY6E8CS/LmtHqCBGTh7ET9Yopm9SmRRSBZXsQoEp3Ar7JCEWccr9
 Mws7MYkqyYKItrQW0yFg3vxU42RtX6JRJCp9juyeMZZFXRuEi/fv6HPaAviEPtwbYDMLNG7Wu
 XGanpsWweB0JjlDTqcKPcSk0lw4rLXgfjwhL1aZVVmOkWkHfHdAgjxg+MJculGZF6YMYLWsUU
 sXkVUcQ0rs8X53qJiRKfUvXUKQHHk3crNlVIgpL7X0HSVoASXocbvDQJdvzXJsvFC6pGPBkc3
 utDPjNj0POZMpLZJmEQ+2dbvTBGhdhxnNscF3TYlFV4qZSU7aBZBsHnMbC2GpTSckbUp2uKX6
 RX2u1f0PGQvrfk/kbhhT/kOhYsuNzZNaUpaEcUGvPYDKHQuqFKhL4D09tkigfp9sAzkgHJwjU
 RkKfcw9mIMFoqD07jo0VrP/RG4jEYAltFb2LITTufBrNNALfbwNY/3wyd/GyBvsAg0M4Mwc3S
 Pa6cbyOf5+IqDak5Dl/Ify5/tzH98iWuJ14EyQige5otNK1vfQLQmW9DJ93ZmQZxARjeYcxVc
 pxSgRKXxTRgrQ7SLcMnfsFxYRwj3mLjqDc2enMvDKZHQMc4cVHYcFEz3l4qNTg9iyhGoTY+VY
 a6GRF2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 84c9dc2 (commit: allow core.commentChar=auto for character auto
selection, 2014-05-17) extended the core.commentChar functionality to
allow for the value 'auto', it forgot that rebase -i was already taught to
handle core.commentChar, and in turn forgot to let rebase -i handle that
new value gracefully.

Reported by Taufiq Hoven.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh    | 13 +++++++++++--
 t/t3404-rebase-interactive.sh |  2 +-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ca994c5..6bb740c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -93,8 +93,17 @@ eval '
 GIT_CHERRY_PICK_HELP="$resolvemsg"
 export GIT_CHERRY_PICK_HELP
 
-comment_char=$(git config --get core.commentchar 2>/dev/null | cut -c1)
-: ${comment_char:=#}
+comment_char=$(git config --get core.commentchar 2>/dev/null)
+case "$comment_char" in
+''|auto)
+	comment_char=#
+	;;
+?)
+	;;
+*)
+	comment_char=$(comment_char | cut -c1)
+	;;
+esac
 
 warn () {
 	printf '%s\n' "$*" >&2
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e080399..0f3d177 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -976,7 +976,7 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
-test_expect_failure 'rebase -i respects core.commentchar=auto' '
+test_expect_success 'rebase -i respects core.commentchar=auto' '
 	test_config core.commentchar auto &&
 	write_script copy-edit-script.sh <<-\EOF &&
 	cp "$1" edit-script
-- 
2.10.1.583.g721a9e0
