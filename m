Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9482CC43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 21:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D581222BB
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 21:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Z3KnUK0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgISVXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 17:23:55 -0400
Received: from mout.web.de ([212.227.17.12]:50845 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgISVXz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 17:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600550631;
        bh=IBWQRwIJFEfZ+g3DiwQ6ltOq+qk856XMoRXDL6s2HUg=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=Z3KnUK0nWywdKxfcPMHIvHur92zIRqN91xfjleV5WGPyJsy2u80I6QtELD5stxSe8
         6luSBvbIWiOIflbvfMoRGwwrp3fJHm0zy4ntr32dUpFRr/a5YiOLL1jgnJO6yM/Q1Y
         DPKeufB01ya0EJNx6MUxDEXBJK21nRsHLVszI5sQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3ouw-1kSZyJ0KVE-00zpmv; Sat, 19
 Sep 2020 23:23:51 +0200
Subject: [PATCH 3/3] Makefile: use git-archive --add-file
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwo0qk0fw.fsf@gitster.c.googlers.com>
 <b7ef3952-872a-40af-0f2e-c392b031a280@web.de>
Message-ID: <f6570064-48a8-299c-6192-7c888e90c949@web.de>
Date:   Sat, 19 Sep 2020 23:23:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b7ef3952-872a-40af-0f2e-c392b031a280@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R7PSy/OolzoQ5xJXbUmhhCXjU5BqARoLzVQBTaj/QQAikY80in7
 qsQBQGvIIDzq3P40nYzqp1bfAqNh1KaemcUvkshFbzBotbHEFo8QLyu2gPwf218kccCnuoI
 4xgWNUP/k2wkjmYzfKAzSMGy/wn+8URlYncb3oo8zFTFqgXtKWPFpr/RqUC/T4x7cxtY8o8
 uvyQsoNimREFK5nHJos3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fj6//WxjnVI=:4b5ITIOjQ5ohmIpzISYgfq
 R7KXOeDwwTTPUixgdde5niPYbn4iaMq44tQSlw4+UQaHQnldReREng+cQd/ZCNmwbSYbdk59v
 sPFicuDHm2iZVDUXhKm88ZJRMSeU/DQJcFbLCfZQp6FAJUhQlbRrOKRrXVGpuNMjxk6y2ZOyB
 UrsrSpWmMMSt1APyIXDGgVkj2K7EC2khF6liOxj0rMs8vyIj7agv5mvp+VsxwTBrMIxz6+b2O
 zunuo1X9HFIrsvLlLxB/YpNwETE+n6J+GtCnamRxOs6Sz1YvsT5D7t2ZUAL9CFwLAVTxtJ/Mi
 q6kfG/ve5pnzUg7HtRhpWELcyh7BLmw1RjLXAlqeEi4EuvevcEPMgcHbShcseCiIDEkJenYMh
 llbs63P3h7QFVLzwuK8H8YwccEpXlZCTpDPTIECTERwm+zTFu9Xnkk03LEVeibap5oQwzVyFI
 Dc0C5W7neopjU6h3o4Ikav0VLuM8o6ZcgkSVY4Bot11mR27ilA5m2Eb/A70g7lSS6rxdLgkp9
 blJAO+G2mzWRW1wE7znnaFBaap0SHvLCX4h0t+Uv2QrwX72/qHz7Ve8v93A2B1ux8P6XFRNAY
 5cwdCU++s2pEB+wfNGuGYtTETNQiN/O3X5ixLqYuTQdF/ZCBe2bBv+YLS59fQ5ENtWo/HQFEL
 jlI65XhOh0FI5oer2iYk+uUDiyh0+Y5Iudhv9TxgQghLmq54YXp9UyOjt/V1lG+JpTL6NbzHk
 qFTk9t85ZeqMyu6aYtr08G//aJn2X3MDBEjdn8v2KMIQQoWg+reJ32G+ohGzl3f9bM0UTxrET
 PwIQI+5+0gyI5TKxnxFpGfC378jV5X3virlVQ5OY8cJ7NRN/8KDdm/8nmIXsaPJAQl3pjIw8o
 uYhqdZnipbsClcJI0JRNjyWu25AEmohH5gwP0AbqLsSlE9qd12Uzk+OuImaHraIf2CFydDmgS
 crpM43YVWxfqR+FalFM23mw1hoewGlhmeWSSg9jSbxm9RoKMqtYUQ9IkNXxoe7pFcdS2WlUlR
 GrJdfQ5OJWztRarpLWxR0JvciSDsbfqLIfz595NP5aSe7rP5/Os8P00yxR/0s1pmxg5I+SMsi
 kpxYAwpyQqnZf5OBHwh8S80uW1+rimnplPngSn697z9zFLIZUH/E68sNhdWzf1SwG4DKC8+0h
 eJVwIjtTaI3/bd077/GRJBvbtaL6NFenD2dP6Q/1+mW0e/fCDdtveZNJsSkQIdrD/HcLl1QFl
 5ZBdJAl8WbsWHjm97
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add untracked files for the dist target directly using git archive
instead of calling tar cr to append them.  This reduces the dependency
on external tools and gives the untracked files the same access times
and user information as tracked ones, integrating them seamlessly.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Makefile | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index f1b1bc8aa0..56bf12b238 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -3045,32 +3045,29 @@ quick-install-html:
 # With GNU tar, "--mode=3Du+rwX,og+rX,og-w" would be a good idea, for exa=
mple.
 TAR_DIST_EXTRA_OPTS =3D
 GIT_TARNAME =3D git-$(GIT_VERSION)
+GIT_ARCHIVE_EXTRA_FILES =3D \
+	--prefix=3D$(GIT_TARNAME)/ \
+	--add-file=3Dconfigure \
+	--add-file=3D$(GIT_TARNAME)/version \
+	--prefix=3D$(GIT_TARNAME)/git-gui/ \
+	--add-file=3D$(GIT_TARNAME)/git-gui/version
+ifdef DC_SHA1_SUBMODULE
+GIT_ARCHIVE_EXTRA_FILES +=3D \
+	--prefix=3D$(GIT_TARNAME)/sha1collisiondetection/ \
+	--add-file=3Dsha1collisiondetection/LICENSE.txt \
+	--prefix=3D$(GIT_TARNAME)/sha1collisiondetection/lib/ \
+	--add-file=3Dsha1collisiondetection/lib/sha1.c \
+	--add-file=3Dsha1collisiondetection/lib/sha1.h \
+	--add-file=3Dsha1collisiondetection/lib/ubc_check.c \
+	--add-file=3Dsha1collisiondetection/lib/ubc_check.h
+endif
 dist: git-archive$(X) configure
-	./git-archive --format=3Dtar \
-		--prefix=3D$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
 	@mkdir -p $(GIT_TARNAME)
-	@cp configure $(GIT_TARNAME)
 	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
 	@$(MAKE) -C git-gui TARDIR=3D../$(GIT_TARNAME)/git-gui dist-version
-	$(TAR) rf $(GIT_TARNAME).tar $(TAR_DIST_EXTRA_OPTS) \
-		$(GIT_TARNAME)/configure \
-		$(GIT_TARNAME)/version \
-		$(GIT_TARNAME)/git-gui/version
-ifdef DC_SHA1_SUBMODULE
-	@mkdir -p $(GIT_TARNAME)/sha1collisiondetection/lib
-	@cp sha1collisiondetection/LICENSE.txt \
-		$(GIT_TARNAME)/sha1collisiondetection/
-	@cp sha1collisiondetection/LICENSE.txt \
-		$(GIT_TARNAME)/sha1collisiondetection/
-	@cp sha1collisiondetection/lib/sha1.[ch] \
-		$(GIT_TARNAME)/sha1collisiondetection/lib/
-	@cp sha1collisiondetection/lib/ubc_check.[ch] \
-		$(GIT_TARNAME)/sha1collisiondetection/lib/
-	$(TAR) rf $(GIT_TARNAME).tar $(TAR_DIST_EXTRA_OPTS) \
-		$(GIT_TARNAME)/sha1collisiondetection/LICENSE.txt \
-		$(GIT_TARNAME)/sha1collisiondetection/lib/sha1.[ch] \
-		$(GIT_TARNAME)/sha1collisiondetection/lib/ubc_check.[ch]
-endif
+	./git-archive --format=3Dtar \
+		$(GIT_ARCHIVE_EXTRA_FILES) \
+		--prefix=3D$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
 	@$(RM) -r $(GIT_TARNAME)
 	gzip -f -9 $(GIT_TARNAME).tar

=2D-
2.28.0

