Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ABCC1F744
	for <e@80x24.org>; Sat,  9 Jul 2016 06:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540AbcGIGY4 (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 02:24:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:54811 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731AbcGIGYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 02:24:55 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MZTw5-1bh0Xf4Bsj-00LChs; Sat, 09 Jul 2016 08:24:51
 +0200
Date:	Sat, 9 Jul 2016 08:24:50 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Naja Melan <najamelan@autistici.org>
cc:	git@vger.kernel.org
Subject: Re: Git 2.8.1 - bug in patience diff algorithm when used with
 --ignore-space-at-eol?
In-Reply-To: <3153d359-2b82-d5e2-9e92-7a28bcd8bc48@autistici.org>
Message-ID: <alpine.DEB.2.20.1607090823270.6426@virtualbox>
References: <3153d359-2b82-d5e2-9e92-7a28bcd8bc48@autistici.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GFOzgG41zrrzPO+EU3oDOENdcq6rSic8cMIVdQhYfeBzG8htqD4
 LG6YM7LO9UuP+SYLCw7kDy8Oq3CaHuJQpGEXopzJLN7fSw8pV0pLDpWXV/YI2OlZ+z5D29Y
 jMFhM4w5kD2rJUu4AZczf8GLyidVB+Mx/B9S73GT5wPm9E2IgfvuzAl/bMHAkdA+rXvnBUC
 T2/gzwzt1q4OIB/cPoX6g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:lH+h/hLeo18=:asmyn477+nQfLjM9RCBYlm
 o/nxYvTOoL/9z+qdbzl2wP+CiVywmPe0bqoRjlgndFMSacunodvRm6LoIHP9maqnrW9BXjNsy
 qe1zMzbz7TiqhyVEaG3Bhk1iVEOFX7XtXMq2pOEiNClHI6/82xXuRZayR2NNbYG2Lkn/yuWNK
 CCgafNevUpS4V+OTC1PYu6sDkNMcWUoNXmTNggtCw5cAqbERIROPGNU/KOriZl7GV3uBua6p2
 wxdxh/i7+xPCafkvk8HZ6weFMj00abXCAfobMDbMsJXNRiQwOwSoAn2grb/EYSHQedyAWD5hN
 c+BG3oIHN4maLBzDN2sPgZBmj3+xamHGZ6Kpds+jiqi2XpXNIrQ2A7dA6RsI6LsoCgLRcKvw+
 odDDrwn9pRu/GfiVR/2hqvwY6zqI7zfcGl4YTtId0ShoPPGQsemEx3DeXDR8GsCPOBJLPakif
 47k0tvykTcE1QbCsqfAoforeU1QkvD2wUXagrgN44MXhHwso63bj/tDCrv3rJKuS/jpiix5cv
 pZuOva7I8Bu5l+hC05xxaYbFRRxF7eYAYHce/1cqVuRiy64B0Rnz4+K96CAI2DfJCKtJBfwy8
 Z0h9kpsligD83wraaOitHAvEcu+d/daiAZZPvEzWHZQOvD0Mqf/5+88xKTAEw1W0TFfYo7zeo
 NnkxO2OxUizO4Ol+hGhy7nh/3UDZFQtVv7/EIiDTJjTFohNJe3r3SMWZVRs2iP/0Zbu9Tfc2W
 stiiQXCHlcmic8LDQezgOJd7s6oerKg22Igp7INJuseUjnZNnCVgQ0dszyan2IIClLAef0Lkb
 oIH+WN9
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Naja,

On Fri, 8 Jul 2016, Naja Melan wrote:

> When diffing with --patience and --ignore-space-at-eol, a change that
> adds or removes just one character a the end of a line isn't picked up.

Confirmed with the current 'master'. I am on it, building on top of this
diff:

-- snipsnap --
diff --git a/t/t4033-diff-patience.sh b/t/t4033-diff-patience.sh
index 3c9932e..6da435b 100755
--- a/t/t4033-diff-patience.sh
+++ b/t/t4033-diff-patience.sh
@@ -5,6 +5,13 @@ test_description='patience diff algorithm'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-alternative.sh
 
+test_expect_failure '--ignore-space-at-eol with a single appended character' '
+	printf "a\nb\nc\n" >pre &&
+	printf "a\nbX\nc\n" >post &&
+	git diff --no-index --patience --ignore-space-at-eol pre post >diff &&
+	grep "^+.*X" diff
+'
+
 test_diff_frobnitz "patience"
 
 test_diff_unique "patience"
