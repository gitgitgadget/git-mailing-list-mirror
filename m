Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033EAC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 19:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C373B2075C
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 19:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="slGOgR6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfKZTqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:46:14 -0500
Received: from mout.web.de ([212.227.15.3]:35069 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKZTqN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 14:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574797568;
        bh=Ph4xgJwlE96jS6qPZBsjNNEiwVcWoe5Wzbt4ZsD1h4o=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=slGOgR6R2XCeBwVtlNrzbDSdpxaFCo+dCP2b6L/Nhpt/MJEk300DlZ0nBAexrV1hy
         kx7gdMjWqi60vhHjRQJHf+SbC2zb8rgTbQG4qpWMrO7MAHn0reiTEmMz5t5Dpu0ETz
         PekEx4E0tHnYhZcwqjBRBR3dj/+BOOFCUi6NLO7c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkyXt-1hyz3S3qaL-00anXO; Tue, 26
 Nov 2019 20:46:07 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] test: use test_must_be_empty F instead of test -z $(cat F)
Message-ID: <a374807f-0fcf-4ee5-f086-9d0ef6ca5865@web.de>
Date:   Tue, 26 Nov 2019 20:46:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xlVsP/UvRyvLJ0HFH+v51Zczwmdvvs0omn1lXl+iGHAxBtePC3z
 iPSoI2R8ax8dSAzJCH+jwwuMznn4+ZG4xsecjhMJhWWR5sLAyybwxBczkf8PAPIt0OwZidR
 gneUlS7qmyR/+mDjK7atPCHOAKdPTQkoZSz+3LtSF2mcrnkMXigQbDBwcP8OUGPGB/svUVD
 y3LSmgXQFEzVZl6nEjGmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iPzCKMbN/8U=:W/bmd8qPNDoCLXRNGWEcOa
 BbpqTPDJd0ujvu223QhomNCWcrfIzrMmR6QBff7patMOKNIrh56ae6XDjkXXPjDhSB23nI2Y5
 T3/bMnFqse8rNlzKYK/tmzpCxSC5s+hGmDGPi4qorlLYFHILhtULYZNz5B64x6lADWmX1C722
 Ic9BCpKt4d4xsuv8KYnvyzHi5jQlLoSidxjI4dE2wt6SnlkzfSicRj7vmDB6Xc6OmwZDmZ6uR
 xPPP/USOriQKZ9Z591SUrPpRjUyZwd6wJWg5tVEg9VgdIxQ8gDwdkAzxe4JA6Y11gd63Cp9ZZ
 7mLGwEgs9ix/upO5erq5HDZUk2rA3zlIKgysn3YCmIhSkjvib56eX1yNS3v7ZBQBTXwkSNna0
 mocwcisMbKZboDmMBAxUKpYn4oq/8B7HYtx11hozmLlxiMst4ii/PtW5L3LzqXs9W/f7ikteE
 8UN2xGHXGjIkls/Ne50pe4VCdXIUe5SPm/2O5kF1hq2PBp1kH2jXknFjg//1fZQxZurluBFF8
 4puXpW7RxjyZNSrEAJsnXbfU95on6R9c7988BC6Th6F53HxLBVQ9MZpGB1vrnWRIAKrqgNgFC
 nnlr7pXQLHA65byNeHESVDT23DJ8w6ojHApJN14jah7OhzasoMhxqDymjEU8NXyAGQWD3y4xL
 4VYbBoD5whZ7ICsTvpY4ToSKS73sxYvlbm91FkaHbng/ffhVPeJ1sUc8Wma0VBY246MwyJbVT
 tgp/XbeGanahBuV5hiG9ELEu1FVDiEQ89zNqPsccOznhHTYFtmYXJqN2Xz7BZN7w3IdvM1Voj
 0QGTgvxf4oXMN5iU0VUrhuPuCVdI5pWOG4dK87uRrclpHlhMZ/ctCHB00hXRxy/rV3vZ/+V8o
 DtlcGzJCaQn4T/22KV6h+lDLBN5RnmBovzCUJ7tlo7X+UmisFZjWmP0I/vPcFzwtKbGzQK53C
 fKvSByJPdobFQ9qqxM2/pN1NvZFTjnZDkfNIJxsBHztmwIyHcCUe+jmly4RLgfyp4762ELsDC
 oNXqS03EBYnjIcRj7lfb6Q481x0RcoEgQ0akec2k3rcIbbQw0Y1FZ162F+YNWwI6IhCm/OBxz
 Fr8yz/K/+/56LWUy/h/za+x2pjkzyQCoVLbVRtvotbnDgoVqp/YrrXQgItFsUMn1VTw0H2wjL
 UfQpoSFHPIpOuiUCUoyZuHX3U4bYSpG4XlwyUtjgZhKiTygbbRUQNHoZsrfa9B+Ltt0bUbcbP
 C/Ub+ZDpoFV53fdYxR7NDSJkQ9X0SLrm7bMcO7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use test_must_be_empty instead of reading the file and comparing its
contents to an empty string.  That's more efficient, as the function
only needs built-in meta-data only check in the usual case, and provides
nicer debug output otherwise.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t1309-early-config.sh           | 2 +-
 t/t1506-rev-parse-diagnosis.sh    | 8 ++++----
 t/t6019-rev-list-ancestry-path.sh | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 3a0de0ddaa..ebb8e1aecb 100755
=2D-- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -29,7 +29,7 @@ test_expect_success 'ceiling' '
 		cd sub &&
 		test-tool config read_early_config early.config
 	) >output &&
-	test -z "$(cat output)"
+	test_must_be_empty output
 '

 test_expect_success 'ceiling #2' '
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.=
sh
index 624d0a588f..6d951ca015 100755
=2D-- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -138,10 +138,10 @@ test_expect_success 'incorrect file in :path and :N:=
path' '

 test_expect_success 'invalid @{n} reference' '
 	test_must_fail git rev-parse master@{99999} >output 2>error &&
-	test -z "$(cat output)" &&
+	test_must_be_empty output &&
 	grep "fatal: Log for [^ ]* only has [0-9][0-9]* entries." error  &&
 	test_must_fail git rev-parse --verify master@{99999} >output 2>error &&
-	test -z "$(cat output)" &&
+	test_must_be_empty output &&
 	grep "fatal: Log for [^ ]* only has [0-9][0-9]* entries." error
 '

@@ -155,13 +155,13 @@ test_expect_success 'relative path not found' '

 test_expect_success 'relative path outside worktree' '
 	test_must_fail git rev-parse HEAD:../file.txt >output 2>error &&
-	test -z "$(cat output)" &&
+	test_must_be_empty output &&
 	test_i18ngrep "outside repository" error
 '

 test_expect_success 'relative path when cwd is outside worktree' '
 	test_must_fail git --git-dir=3D.git --work-tree=3Dsubdir rev-parse HEAD:=
./file.txt >output 2>error &&
-	test -z "$(cat output)" &&
+	test_must_be_empty output &&
 	grep "relative path syntax can.t be used outside working tree." error
 '

diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry=
-path.sh
index beadaf6cca..353f84313f 100755
=2D-- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -143,14 +143,14 @@ test_expect_success 'setup criss-cross' '
 test_expect_success 'criss-cross: rev-list --ancestry-path cb..bc' '
 	(cd criss-cross &&
 	 git rev-list --ancestry-path xcb..xbc > actual &&
-	 test -z "$(cat actual)")
+	 test_must_be_empty actual)
 '

 # no commits in repository descend from cb
 test_expect_success 'criss-cross: rev-list --ancestry-path --all ^cb' '
 	(cd criss-cross &&
 	 git rev-list --ancestry-path --all ^xcb > actual &&
-	 test -z "$(cat actual)")
+	 test_must_be_empty actual)
 '

 test_done
=2D-
2.24.0
