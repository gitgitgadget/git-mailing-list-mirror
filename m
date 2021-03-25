Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C40C433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 16:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4447061A0D
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 16:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhCYQV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 12:21:57 -0400
Received: from mout.web.de ([212.227.17.12]:35451 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229961AbhCYQVh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 12:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616689285;
        bh=poEHJ36i8fjEaWFCKwl32mfSCc9rjBByOZEBsWwKT3w=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
        b=W6nQJhl3I+PUHAJiY5SFe2a5RSonWYw9oAkvYmJVrg+Aa6M9wBtN20m562Zt5IiIr
         Kw6vr5+YvFsNCyrdtoZIY5/6ENrx67z5EO1ImyYtTTdDx82v5yWMXG9e/jzhRylwiN
         EXLgcPGG9tO+PUrmKMwY5MwbX63md+bHltQP+K0k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.22.17]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1Mmhjw-1m6kBH0Psk-00k0pj; Thu, 25 Mar 2021 17:21:25 +0100
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Subject: [PATCH] daemon: sanitize all directory separators
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Message-ID: <314451a4-ee8f-fb68-016f-66a4f3bea409@web.de>
Date:   Thu, 25 Mar 2021 17:21:24 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p8MPw4ZDoF4Jh8/u8LUtisW+ssKgKJQ0miGkpZC5FFNuznaomlU
 YH/AhQcb61POJ6wUqMXYz1Ql2BTka+uaVc88fFsfrEvifyPfsjYBMasSQPTrhHbNFEPOYm4
 C9+WpkOq2qocFkD0Gy/A3KAc8iJRTrcQsZVyTwsRz+hb0Zsy+oiq73Blq4qDNoTKmcOj+YT
 h/zKWT6LktBZuN5FZhbEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fgoT7YqYG+Q=:cpuFOndZGUju0ZtWi2KdK7
 9p2yTAmQBn33MEObcmGu/7HACgNoOUYzY4kuIYPXIEyxjwM3nPHQo52v/w9/0TlrTNMDoH43v
 7sS8mt5emLtMBjxTMITF6ANHyHijyDOjIH+kTX4GUiA7r46VjJeXHIqAmXFEdvsxNTTw/Y/zg
 kGWveBYzDNrpc92IeqHCCgVeWsABzIc7KMQVDciIA9zlrpkebfjBErpg5F3uduCiT8GPmZ+6z
 Ciyb+gJFXw11KriNB+ujkbGx45X+rl2IYxHwrOzbF10JfE1O3lNFtKMfQY8kQSOzJdL3a5QxN
 n50v705Nur6QIUtPff7l20QL5ocjWjCZ++QVzhi805cyKaStkcc0Duuu+/gR+oUUlflxq7EIS
 C/QKGjrFHwVjJEyRPJxtIGTCzcuBsNQXzsmC1LSOOcKxYKPS+HFWRu38JvlK2cmNyGj42OnQn
 LFDkt4RctIYKQtRVp2Cx3THxyaZdt8LW4feOTKAcCH7DHNHtULowQ5IHnc4SmPnzXUCnkxJfX
 qMQrPO3sU1IjAAfR3UwaOYezbXIKCIPTJtfZszPniXZ8gzYq62O66aE5YtytPNzNDLgaUKP3P
 Mtx+kt0+EcC8W3hH4uCXzDaGm5lB66j9tRbeb7VW2LhbZBvFaFmt3ZH7z9Qb7UOnV9gR2L2zN
 HsMESkDOB8R0k8aEmGvRzPFb6Ur6G9FoEz4J16TxBfnytevQZgkRg9qI5QEZa6bUIqjO8gv68
 qXxU6du0sxgVyVI7026jrvoiTmLfD3nx4mx029YZ+mDP7Qdh/zaNuwBEHQ4r4bWsAyoz3d1ze
 vFn+fAVY28v2m/x9jsQ9/oHaF26Cv7JHQItDMrA1zOOzUj8IY3pMpRkA4bZhlO9BuwcsYDADD
 CoGp20yKtCMsadWc3VFw3X9xQbYgeIk0zflr7Az2LkNhS+w1ONNtVI2Nmjo+w4qLxeBX/VQQ7
 5wjV8hhw9rJjjclTz0NEl9R5KrOrEtebChP7fPZYwIXaP/9qlTVcZ2HtOC6YKR97SNQpTdz5k
 Vsyzlt5Ioo9DUsBrRD/YyrzzY4RbgXTI0aR8eS2rMbjtODqygMqFNMLPqBgUo4zWjN0GlAzyB
 ehdGsVXbO9jiGYHBinKd1SziZSrrpGzKAByqvwfAX+KfGRGahzB40BYPSTpFU4slgTdb40zuv
 oBvC9u/hkC65/XjJ249TOWa0pipZMK9dA9wWx3hZLhTMfvF7sr6O/sHzCwIWWIcWo+EPE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When sanitizing client-supplied strings on Windows, also strip off
backslashes, not just slashes.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 daemon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index 2ab7ea82eb..0561c19ee8 100644
=2D-- a/daemon.c
+++ b/daemon.c
@@ -566,14 +566,14 @@ static void parse_host_and_port(char *hostport, char=
 **host,

 /*
  * Sanitize a string from the client so that it's OK to be inserted into =
a
- * filesystem path. Specifically, we disallow slashes, runs of "..", and
- * trailing and leading dots, which means that the client cannot escape
- * our base path via ".." traversal.
+ * filesystem path. Specifically, we disallow directory separators, runs
+ * of "..", and trailing and leading dots, which means that the client
+ * cannot escape our base path via ".." traversal.
  */
 static void sanitize_client(struct strbuf *out, const char *in)
 {
 	for (; *in; in++) {
-		if (*in =3D=3D '/')
+		if (is_dir_sep(*in))
 			continue;
 		if (*in =3D=3D '.' && (!out->len || out->buf[out->len - 1] =3D=3D '.'))
 			continue;
=2D-
2.30.2
