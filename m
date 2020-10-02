Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F586C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 13:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D02D206CD
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 13:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ebiE0MEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbgJBN5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 09:57:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:41093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBN5w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 09:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601647067;
        bh=6XDpGxUfv63VrkLGIWilxxnXB6V82OiLYgOeOp3tAuA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ebiE0MEObNvUjXaYObA/6NEXaVYzxZvyrl2JaQEooiFvML5ZlW6zBpdzqP3b4pT3Z
         ocDFETCrjFNOFzfhPOgGyWF9NqwLLJ40CtHhuzWwc2ugCjfmX+RBAVN8dmY2jiNwlc
         Nfz6ROyZ1TboHcXbjAwqhpcKU0Pn7cYsnGujl/js=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.114]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5UN-1k9B1B3XaJ-00FCf8; Fri, 02
 Oct 2020 15:57:46 +0200
Date:   Fri, 2 Oct 2020 15:57:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 12/13] reftable: rest of library
In-Reply-To: <4e38db7f48295c4e6d729880f5f1a63b0f90274e.1601568664.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010021555290.50@tvgsbejvaqbjf.bet>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>        <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <4e38db7f48295c4e6d729880f5f1a63b0f90274e.1601568664.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/FFPGQtGmzrCFrFaioNhie+gEOjNMLK3GlYjOdL7sK4BUh7Q4l1
 BA0xgZ5vjLYEONCz5Z/CwWBDxx6nShGGnosZOu+7kjb3ALMg2fHKgNz9be6LiF5lzKt3mnK
 tb5YDSpDmQGRmTeCS0fcPWz/NXnC+v9xLMV/rozmS3kKtLbv7sTRj1EIAA7c/6IR+gMywhe
 tASMoFofUU5p19hgWviGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zj8ibV5GhRM=:8YNiY6pImNYIr0N0NdEJFG
 QhQEv7UfKhcLUGajQAtVXvg3+tz1hd+iiqlr3bbPAslQnHKRAKxbIyI9bCK4UyAlbRcS78E4J
 c4q5V6eFHNBME+8vrwkNOcXw8qEEhLDib8eKzhGXdqXCAc78fw52Zaj0c5Om0F7d9uDaSXQUf
 YpdfHJiYr/WRravynSvy4SL+jdPoAyjtiFlnMm45KVbIpvV3+uKdQ1u220przWBq4/pNEnmLJ
 muLiza3ENatE3S2lyttx8DGGG57fcNHOucSN6YSgBlK4FEOYB+d7f/cfaG1O50J6XmGTeB8TX
 prtfRvcJbRwMVjNHUdfYDPieW+L4ndjEw5O+2bK2yNewG2vElWObBjddKM5A0cL3hEkyLUzcV
 XLXgn5OgTx25VNd9XZq6Zgd4+HVijuRfO5/qhkWashVGZJ6YyuNEvDwH5vbmps8S9NpIoRwt3
 pHA8bzjV++Z0h/8vnzalK0cLNpPE0ZyuYUU0YUKGjuanBxR6bMcZb27WMradJ+5+HbdFvBjxD
 B7M5Zw5eb+Sf/PTclnlqTVqsOM7L+hkDeQ+Mydix8U7b7rIui3YLRSOThH5zfQkaxyeCjUbnt
 +FmPFU6D/nr/bqXCN4Mk0Ekg+fY0zAJ6o+ijD/X5u3ZDCmM+qKZCbGjG/8xfIzNedc82DgyBA
 mFSjEL9FjW2psB9RCqzD4SdAiDOajupzJPnM+loxnFOjijwkY/ddYK5ZisDmSEoY3FWUUPD0d
 75poipjEsekoUS7pwhmHzIcZQPpjyUKw0uETI3ALThjFiAtM3R3dV5fIJx4BnU72NRmAIDPVI
 2fsNGuPjiyNaBrFXIqWVtnNz7QeGxa+pq/tSlT2Ad/JpsyxaYuXuThr2rwa72hWP7IlGSlLPL
 ZyLUcIxho8mFig94kDdTBg41KpOOn20gseF3oHUNrMdg5rc0xi64rBKXX68fqTftChaZksmsC
 F4oF0iEDe9SnKw54dVyTR/H4mONrlekDN48cQPD2ChqnqGdRBQdpT0PWTKGr8LDgOsRJmmUxt
 KF9vkJ4uCJIa1LVkaP5a4f1JAUu909QqnAN2mnyqxKRWTAQTntLHvjgaD25wNviUplZ1qp9M9
 Gdpzu5MEau1YrpH64j9kYwWFYWctL3YsOC+G28qvUfl/UwpPBsM6oEM3IMGSMm0J8jJAO49Gf
 vO7uu41i10Rf2Y7b4pJXylQ/5dIA7BJ4gCU4kFWVo9wk8hKERGaVdCkt4JNXavKnM58WYMdWT
 L7QrH2PJPmMZOtzl6428uI07fuhhIWQlXrG+MiQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen,

On Thu, 1 Oct 2020, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This will be further split up once preceding commits have passed review.

Before you further split it up, I encourage you to include these patches
without which the CI builds will continue to fail (Junio, could I ask you
to either cherry-pick them from https://github.com/git-for-windows/git's
shears/seen branch, or apply them from the mbox?):

=2D- snipsnap --
=46rom e485e006f34922439f2e971a1c5c38b8ca56c011 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 30 Sep 2020 14:46:59 +0200
Subject: [PATCH 1/3] fixup??? reftable: rest of library

	struct abc x =3D {}

is a GNUism.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 reftable/dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/dump.c b/reftable/dump.c
index ed09f2e2f94..233f0434e39 100644
=2D-- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -75,7 +75,7 @@ static int dump_table(const char *tablename)
 static int compact_stack(const char *stackdir)
 {
 	struct reftable_stack *stack =3D NULL;
-	struct reftable_write_options cfg =3D {};
+	struct reftable_write_options cfg =3D { 0 };

 	int err =3D reftable_new_stack(&stack, stackdir, cfg);
 	if (err < 0)
@@ -94,7 +94,7 @@ static int compact_stack(const char *stackdir)
 static int dump_stack(const char *stackdir)
 {
 	struct reftable_stack *stack =3D NULL;
-	struct reftable_write_options cfg =3D {};
+	struct reftable_write_options cfg =3D { 0 };
 	struct reftable_iterator it =3D { NULL };
 	struct reftable_ref_record ref =3D { NULL };
 	struct reftable_log_record log =3D { NULL };
=2D-
2.28.0.windows.1.18.g5300e52e185


=46rom d5faa818a1bc00016e310d27602551127db620fb Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 30 Sep 2020 14:55:28 +0200
Subject: [PATCH 2/3] fixup??? reftable: rest of library

0-sized arrays are actually not portable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 reftable/stack_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 534463829cb..e863cc3c0a2 100644
=2D-- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -572,11 +572,11 @@ static void test_sizes_to_segments(void)

 static void test_sizes_to_segments_empty(void)
 {
-	uint64_t sizes[0];
+	uint64_t sizes[1];

 	int seglen =3D 0;
 	struct segment *segs =3D
-		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
+		sizes_to_segments(&seglen, sizes, 0);
 	assert(seglen =3D=3D 0);
 	reftable_free(segs);
 }
=2D-
2.28.0.windows.1.18.g5300e52e185


=46rom d446e1a7354c676d60114b50ba96a6ea083441ae Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 30 Sep 2020 15:19:28 +0200
Subject: [PATCH 3/3] fixup??? reftable: rest of library

Avoid using `getopt()`: it might be POSIX, but Git's audience is much
larger than POSIX. MSVC, for example, does not support `getopt()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 reftable/dump.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/reftable/dump.c b/reftable/dump.c
index 233f0434e39..b63c9fe9e81 100644
=2D-- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -160,40 +160,34 @@ static void print_help(void)
 int reftable_dump_main(int argc, char *const *argv)
 {
 	int err =3D 0;
-	int opt;
 	int opt_dump_table =3D 0;
 	int opt_dump_stack =3D 0;
 	int opt_compact =3D 0;
-	const char *arg =3D NULL;
-	while ((opt =3D getopt(argc, argv, "2chts")) !=3D -1) {
-		switch (opt) {
-		case '2':
-			hash_id =3D 0x73323536;
+	const char *arg =3D NULL, *argv0 =3D argv[0];
+
+	for (; argc > 1; argv++, argc--)
+		if (*argv[1] !=3D '-')
 			break;
-		case 't':
+		else if (!strcmp("-2", argv[1]))
+			hash_id =3D 0x73323536;
+		else if (!strcmp("-t", argv[1]))
 			opt_dump_table =3D 1;
-			break;
-		case 's':
+		else if (!strcmp("-s", argv[1]))
 			opt_dump_stack =3D 1;
-			break;
-		case 'c':
+		else if (!strcmp("-c", argv[1]))
 			opt_compact =3D 1;
-			break;
-		case '?':
-		case 'h':
+		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
 			print_help();
 			return 2;
-			break;
 		}
-	}

-	if (argv[optind] =3D=3D NULL) {
+	if (argc !=3D 2) {
 		fprintf(stderr, "need argument\n");
 		print_help();
 		return 2;
 	}

-	arg =3D argv[optind];
+	arg =3D argv[1];

 	if (opt_dump_table) {
 		err =3D dump_table(arg);
@@ -204,7 +198,7 @@ int reftable_dump_main(int argc, char *const *argv)
 	}

 	if (err < 0) {
-		fprintf(stderr, "%s: %s: %s\n", argv[0], arg,
+		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
 			reftable_error_str(err));
 		return 1;
 	}
=2D-
2.28.0.windows.1.18.g5300e52e185

