Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A9AD2047F
	for <e@80x24.org>; Tue, 25 Jul 2017 08:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751068AbdGYIgi (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 04:36:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:62400 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750885AbdGYIgV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 04:36:21 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRXVc-1dBpuo3oue-00SciR; Tue, 25
 Jul 2017 10:35:59 +0200
Date:   Tue, 25 Jul 2017 10:35:57 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH] git-gui (MinGW): make use of MSys2's msgfmt
Message-ID: <8a13544743fd5e6a3b3b5fdb35e02c9c34695e25.1500971399.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:S/h80qaA2MlY6Lny/HzrSMdwehv/LP4T2pXlrl/mrkTVwRnHZHP
 7yVUoPovLBkaYyfbNYmahZX54d/LWoiy0gWIR8BQA54TwYiJgD7pfPIZ2xES6xsZq5UN68G
 3AmC3TSfC+OUnDCv7d+ej1ulqegeYK2hH/6Sdbj2j9roPTVgxGAMV5MzUa07xz4zFZI7034
 3oH3PcJMPW/y/3Cq5AQPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aWYUPjU88L4=:Rl4VqnlFgpocavJ0BUFgkB
 QTRLE6Ry7bFMRAN8XX0z/9/drfHmNc5qvgJlfONmAk+KL67LmuFT7fGxT43Ry+71rPK1md296
 1crdJG8wB2gGdAzSv4kpoDv4xPOC/z+At+MCQ8zpKri28A4OxQnV2La95j6T9fj1Byna6xX2g
 BfOZ9XOC7gdywvBh4LwN1kV3zmw8dXzAFTEDB14087ae4JQAR4N/opWlUzpq1ZRod8ZQJ73sf
 C+3KgkX13LCJPf6w5w4rdLGcEVm8Ye5CLoZ4rjuLnHqqTDhRVoPkLAAdmhGbPF8ChtyNkbeNy
 HDFSePRCjqwkhBWQHPjRF2HSrV8D48it4AkP4cZ2jTgaVPHV/JjuEciT3uMT8k/HSn72FArbJ
 H0anlDDQbFMwEgvvbCVc7cD9obYCRWHbeBsiitElUHLzpd811EOdbLB6oaW0t0Nh1yZdsGrOM
 zu1U9va6xxBv1/nsq/N2C5ELB70UHCzO5a9KUtUOl6WXkcly+uNlJ/mVIdFvE0dZzXtUCd2rH
 3J3YbNhmDpBgZZsx3CMoRY90j/XW67M/A6xe4XzJaus1im5nJwlw4z2LjJBdiOaCvIEWAr0QL
 tdqrJHJbDRDu/0uHrE7b6QJbQ6riTLp9er4LfrmHkw8ue9XkCuIE9bQJOM6D65vGtqSjTr7+0
 vL9rECVJF/g7za7foX/yGZGTWwy8O7bMWXdp8pWW+oiThYMzuu7JZ0aQhLAFO2S8RHV+9pUJE
 vydN0m/BKXsgBv9Qhe1Xs2OtOeuXbqTNUY/LcuHBfQUhJE6D1cB87mh9x4bNcVI2aDkOUpFr7
 B4cKLUm30GJ7qc7dk+WUfWHtsNPxZl/IUay0/SL5b1Vq6MQKyk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When Git for Windows was still based on MSys1, we had no gettext, ergo
no msgfmt, either. Therefore, we introduced a small and simple Tcl
script to perform the same task.

However, with MSys2, we no longer need that because we have a proper
msgfmt executable. Plus, the po2msg.sh script somehow manages to hang
when run in parallel in Git for Windows' SDK (symptom: the Continuous
Testing tasks timing out).

Two reasons to use real msgfmt.exe instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This hopefully fixes the hangs with the Windows builds triggered
	by Travis. It was a tough one to figure out originally, and it is
	my fault for prioritizing other patch contributions of this one;
	Git for Windows has been carrying this patch since April 6th, 2015.

	Pat, I still have a couple of Pull Request open in your repository
	at https://github.com/patthoyts/git-gui/pulls/dscho that await any
	reaction since October 14th last year. Please let me know when you
	are ready to accept code contributions again. In the meantime, I
	will send git-gui patches to this here mailing list, Cc:ing you,
	and hoping that Junio will take the patches.

Published-As: https://github.com/dscho/git/releases/tag/git-gui-msgfmt-on-windows-v1
Fetch-It-Via: git fetch https://github.com/dscho/git git-gui-msgfmt-on-windows-v1

 git-gui/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index fe30be38dc8..918a8de3691 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -161,7 +161,9 @@ ifeq ($(uname_S),Darwin)
 	endif
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
+ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
 	NO_MSGFMT=1
+endif
 	GITGUI_WINDOWS_WRAPPER := YesPlease
 	GITGUI_RELATIVE := 1
 endif

base-commit: 5eada8987e79f216f2002a3cd991360a50cd577c
-- 
2.13.3.windows.1.13.gaf0c2223da0
