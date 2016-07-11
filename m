Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207841F744
	for <e@80x24.org>; Mon, 11 Jul 2016 13:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbcGKNLq (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 09:11:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:62246 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588AbcGKNLp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 09:11:45 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lw285-1bLAHf3qsn-017liQ; Mon, 11 Jul 2016 15:11:39
 +0200
Date:	Mon, 11 Jul 2016 15:11:37 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: [PATCH] mingw: fix the shortlog --output=<file> test
Message-ID: <alpine.DEB.2.20.1607111507180.6426@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OXXGFmJPT8pO91HOEI+lsYmd90mETHdS0Sz7HAFSJlB5yRNmWkE
 AmHB4SUpBlq4WxKjKPfzbAk4ydmjr2SSAEXX1haThqZGfkizTBXJJ44W0oF1tgC++fmyTN/
 ri0V0OsOKjKXVjji6qV6UIt87/R+XA53DYWBFYIpLnz/pq4AQHQ+Rq2VHOJH4KpGqizPxCv
 sjV3fuAUVUhdWfxPJXglg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:bCr/Kl7OHso=:NjxEUkgNmGrD7ltAZJo8oJ
 mlodnP3GdpCrv3lmLQ8hFBMabE0h+wpRCxdKy/UB9nhi22oB5ZZV0jv7vNWIvVMCHmdq0Yz4u
 zgkJU3NipEbOfITU97whMnTovOeIOzvU1+GGMrarOjgIlr/3ShLY9oAycuLHeOJ3yPQfPuvpp
 GYLWJXRNDhUW0Fia3KOq+5LtQXkzYrmM4nHlJKrqp+/Op6bQBu4WaHW8LD8Vw+/isHpxLCGj6
 fwKiyvIB5LmRJe+c5ZWgrwmy7jsdFdBiifcsk27dTJTkhJSUPB2pngyOdhj8VZmZjjzDbb7df
 73PPtzU6SAvEgn+uD6Jm09tudxEbc8c7BT6FT4rZhq04DuvHcY3FKEV65LkyhuH2eFs6dDgzK
 uqRmRB6WM3v7TsH6q97i2BiFs5sbR+rJmhLvmHH89/pASTi/k2+GmOA5K8J/lliO8psJJ5G/R
 Lf/usMSOwFt8k7kDllCDQ9hMochnz1ktB0s1r/vYplUZoJ7yV9+lj1cvY157swlsIOC3Re31G
 IY6NDf/SyxYhrAymjSGgYOsIgb2PjKItMrumuYfhbPGcF82kKRdN2QiWzFWGUEGnVvpwjA0TW
 q4eT80sHs3WA9jLsj28nNIuDFy0VJT+hg9GgMZReM/X/+VDXFusgql2EU6EOkBVslQJufaP9l
 pkZ9u5x4uji4Z4TiSvJrS+3cU/umjTXZPXr40xN+OlxnSGs9FoAk//v3V5GZUoKVMTPk876lZ
 IKpDG7E+NsRq0K2ZbjjqED6pJ6RE2Rcfk7IXwhaTaQgSjBx9hX3Rythy8kYA3rEeUxrMBTwSJ
 2AwIAv2
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Adjust t4201 to pass on Windows; a couple of test cases need to be
skipped on Windows which leads to a different shortlog than on Linux.

Let's just fix that by limiting the shortlog's commit range to traverse
only one commit: that guarantees that it does not matter how many test
cases were skipped.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---

	On Fri, 8 Jul 2016, Junio C Hamano wrote:

	> * js/log-to-diffopt-file (2016-06-28) 11 commits
	>   (merged to 'next' on 2016-07-06 at 39e7a5f)
	>  + diff: do not color output when --color=auto and --output=<file>
	>    is given
	>  + t4211: ensure that log respects --output=<file>
	>  + shortlog: respect the --output=<file> setting

	Dang it! My original test series was well-tested on Linux *and* on
	Windows. Over the course of the iterations, Windows support broke.

	My apologies for not catching this earlier.

 t/t4201-shortlog.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index bd699e1..ae08b57 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -185,9 +185,9 @@ test_expect_success 'shortlog with revision pseudo options' '
 '
 
 test_expect_success 'shortlog with --output=<file>' '
-	git shortlog --output=shortlog master >output &&
+	git shortlog --output=shortlog -1 master >output &&
 	test ! -s output &&
-	test_line_count = 7 shortlog
+	test_line_count = 3 shortlog
 '
 
 test_done
-- 
2.9.0.278.g1caae67

