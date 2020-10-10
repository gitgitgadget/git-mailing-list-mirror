Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3ACC35267
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A0D2075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Z3TKPeeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgJJW4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:20 -0400
Received: from mout.web.de ([212.227.17.11]:51815 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731429AbgJJTW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1602357736;
        bh=+Ev3TCgRqo0KgB2FN7GB4sgp7vXz3WFRdRHeHIiEL88=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Z3TKPeePhVHfu0k22XInqRZ+T1OdLP+lfMMc0XpP9pe7j9p53VTqXF6PT+stEuAf8
         wUVxJWvU8kCCQq0am+tiHSNYAR3NJSEt6q1IzYXU6KvApJ47vcnhVGnQVuEk0+oeH/
         KinwyPKG8YtktPZjcwxlboXVrDkI5o+6L8vL8Du8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.172]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lr2VT-1jweCa1FtD-00eh5o; Sat, 10
 Oct 2020 18:45:19 +0200
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] Makefile: use git init/add/commit/archive for dist-doc
Message-ID: <40da2404-8504-e134-7176-f3429c081f12@web.de>
Date:   Sat, 10 Oct 2020 18:45:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k1aRQiR3ekedhNIjZjgHrxaf4TGTDytmRsw/sfVTCBHhBJxGNrE
 fA0rLqpuLuH9kmQ8/BDCur1GIA97t2WIhrbjNMuomv6NI1w13byFT38z71rqoEGBE5A8RMd
 UfJ5vYKlTCHNi8sMmQOEVAavwnEQHjCPbcXSqcPHWDJwNegRmc9E5SOxif6SVpPOa2kxRrP
 kXqWNG//xLxXAQA9RBunA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+WE6NIz4Ajs=:Fbbu2J5RuAqTzJBoyS5/L/
 dWjPvLnBsMXZLf4/DvnOYMi15X012MDylMicwZMcz0WbTdUUKakYayhd1EZzxbjJHIyKe51+H
 rymOrtuWUyPpb7Rc9JSV8E44D2XeO42cxEEtR8x7uJzLmBaH/HySoQSFFpHsemYC3Kityr6l+
 Aq2PclfTsAl/8rQNnJNNKx2sQedRQrIAgpLdm0Zolrj7Lq9AeJs7JsoJrnUI2FRH2NSNdb1pp
 3bIt5h4RZJonAltpo1ebZRyd6MVuYTXMDczMFV16BeHBr88JFDe8fbfTMFm27GzwLHCpWcLo4
 Zj9dJKaDta7KFaf0fR9KwyTMbe0T5oFlFBbOre10Usdby6zuZPRYZyMbK0bPHmeGJWPDjksik
 Y3AiY1dnhR27c5OJkUITAndaPeucTnAQ4aUUb4aK169FxGx7YnQM4xb6mHQLYylKHb/EbfpH9
 0yIwxvm3UFPW/fUjNe9gkMK6G3HPqpNXD9COhlWeTTUWS4S0raraV8htd3YGE2HTbA0f4GPUc
 Ljh1xb+SlYUvDfgfVZGPtR516g7Vfti5D7X3ubM+gOgrHvYezMmNZfa3jWVTCm5GPbPfSpzY/
 rkkUya8tpLEeYXSi9FmA2ZAQ02LmG3IjCgbmMYY8qFlF9yGD1Xip52UeXs0eIa0gWnNf1JAFA
 g7r53TVcjRuRTByehZ+XbQsdSM5hIjJRf2/ottAFKmXKAmKfMZcbaMpwMcUTHIc43ATeFzIZv
 8mTuM9Xk7c6Z4x+ToS64nUtrCQOYumSFILD+IPwWyusZ5EBMdYzeofZOTeG3CNdYmXrM1ePVi
 gynjl37tYrGqClYxE+rVwijWaoX0ayfdLcBK0J4qM69qC6tpqdH3MbRU/6hnO2VzPD3PPUy4V
 psWmtsEPPaP6kY2rSdxNDAPSZf5h/6f5wbVDZc9C+zaGqX2PaoPh5y/sXcTcF5uy/1GBelai4
 GBkLAXFk13xHJTObdgMA8eLjmkB+bgYGOeHimBFU7J6lnyP2a/kYyVw57lK0pxNVXl+ph5iSX
 gkXlfFeVxGV4ziVofKbQSEKYOX2BxUbILJ1RjoDa7AfJUtbqPM/qaSK4Ln/YEUD0y1w9+saBn
 e4ml1lyCaFsS88ObYUJnT5+ahO+pgNUBDnAwzfbbMqnQN29A5/kJD5YQL14CT2+UlY9+zC35z
 AmYftfDH/j/I+NhVsiVLgaWwYASOS9+raYTFK3aXQYe6rYwASEnQtxLlN29l8Ei5u9FIk9yrp
 t02ueE3KiV3RsyGXJ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reduce the dependency on external tools by generating the distribution
archives for HTML documentation and manpages using git commands instead
of tar. This gives the archive entries the same meta data as those in
the dist archive for binaries.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 95571ee3fc..b7f3708292 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -3105,11 +3105,15 @@ artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIP=
T_LIB) $(OTHER_PROGRAMS) \
 htmldocs =3D git-htmldocs-$(GIT_VERSION)
 manpages =3D git-manpages-$(GIT_VERSION)
 .PHONY: dist-doc distclean
-dist-doc:
+dist-doc: git$X
 	$(RM) -r .doc-tmp-dir
 	mkdir .doc-tmp-dir
 	$(MAKE) -C Documentation WEBDOC_DEST=3D../.doc-tmp-dir install-webdoc
-	cd .doc-tmp-dir && $(TAR) cf ../$(htmldocs).tar $(TAR_DIST_EXTRA_OPTS) .
+	./git -C .doc-tmp-dir init
+	./git -C .doc-tmp-dir add .
+	./git -C .doc-tmp-dir commit -m htmldocs
+	./git -C .doc-tmp-dir archive --format=3Dtar --prefix=3D./ HEAD^{tree} \
+		> $(htmldocs).tar
 	gzip -n -9 -f $(htmldocs).tar
 	:
 	$(RM) -r .doc-tmp-dir
@@ -3119,7 +3123,11 @@ dist-doc:
 		man5dir=3D../.doc-tmp-dir/man5 \
 		man7dir=3D../.doc-tmp-dir/man7 \
 		install
-	cd .doc-tmp-dir && $(TAR) cf ../$(manpages).tar $(TAR_DIST_EXTRA_OPTS) .
+	./git -C .doc-tmp-dir init
+	./git -C .doc-tmp-dir add .
+	./git -C .doc-tmp-dir commit -m manpages
+	./git -C .doc-tmp-dir archive --format=3Dtar --prefix=3D./ HEAD^{tree} \
+		> $(manpages).tar
 	gzip -n -9 -f $(manpages).tar
 	$(RM) -r .doc-tmp-dir

=2D-
2.28.0
