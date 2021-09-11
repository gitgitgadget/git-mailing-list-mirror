Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C6C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 11:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A002A610CE
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 11:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhIKLrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 07:47:01 -0400
Received: from mout.web.de ([217.72.192.78]:55851 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhIKLrA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 07:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631360743;
        bh=Omqz02RqlmzXI8rMVFHWd8hYl7G6RrB8C4tQXLPI8Bo=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=WbgxpCyfX0zzTJmJ3THFqQ7VePzM94JY8iIBf57sOiDDKLmfgtJbX3994J3J0fHid
         XzHuMVMYnzEIgGvafBS8boMmZpaRUIfSPYSnTAM7Ws7ZDm83pOD5Aezwsg/XWFznYL
         95wv1Lfj7Ihf4dBPyINluj+MlpPUsk39pCHQijg4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0M3Bhz-1nFT96303b-00st35; Sat, 11 Sep 2021 13:45:43 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] compression: drop write-only core_compression_* variables
Message-ID: <6ed7da24-81d0-0b5e-dca3-664d2c773474@web.de>
Date:   Sat, 11 Sep 2021 13:45:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+6LQvHBCww55mBuFNIPBdl5TEgTC5yXU486qtH0/HpLB4AXTqIf
 OVDEeySiaDZvhcJTC/Rcee7+29T4AD/xzRd84axHKvDkag5EB88TZtTpwz2RIOA6cTrZ+00
 4aO7Q/eNK+vkvEmwF7gQ2aOjjmpUJ+pgV+zNCpFvuNg4RInMVvVHInviK9a0eUJve+L2nJV
 kQ7qgy1Lt/I/SPuPCItFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W5SAnsIpVjA=:JfoU3RdENLRb+pxo3ylyNN
 y69Ihc+vW498f0KZ6/3TiXvbEcoq/6xZvGk+XsuCFGX58MZMS9jzcCGzRWZUtX5ZyIi4f9v8Y
 wWMqJ8PRy97Dje+TZu4PzSDLdYccyw3AAb/Pur5syKLWTl5Vcb7FZDGc85ngZKtjGmYz+1hmP
 Fw4zp8xwrBwSbENKmKefF53RRiQZXiZMWR3zwiijG1Wm8fIqFWvfvrxEtn0dr8TC/wIKJ3sKB
 2L1x79an+CxhEwceXd6x5i3qR3etdypf8rPvmyROLZGbRRRrdOZPs39nBpbgZutKg+HxOTLRH
 udQhCeZuGaaNAIQeBFFJlvw1upkF1FgmlLdISW4lwF/5JloYsBHwZ9rjHBoTHkaEo1aTCyMzA
 TUH1ffPQK5ERrSnvRLPhyIo28KeLZcbjNakeTEYw8BtbpMcNeqxWgZdfFm/awVg+FxIRND1x0
 0LfjdEF+I6qaUGTin+c6AYL1lntMEAS1ExsiA5yqj9QBivGBOdPyuN1x8IgMLfT+GuOWLoLNk
 Qsge0aMdVn4CkGHJGkyX3e0dPltVd6ayPNAJ/7c7x9eVQiSw9Ygl7ql737Byozuip2zop9h7S
 Xb5GKzZ54pmWe8lRYErgscrci80Kye6To/bG2HwcX3Uppc77vmHAvG0ctJbpHAn+vXpf6610z
 kps/+KmjnT8iZvwIJigzYm4IKfxhCxGrIgsxB0X2HjBkhJwHo03gkckExYxD/wP9eGZyHHRw4
 n5repK532Wrknte4uAq5xsich7mxUgxaRH/FFC9psVA+UpV0YbRf5ToyeRQSpWvY+Xd51j+eo
 833tCw1aApwXC6Ls17z3vcQZMHf3k1RyHoyJDp2rgJxfBydL3zOPoEBUQ/MEiAQJHkqTFRhru
 E1kXHltjVIbjQcyKGg6DGd5j+Cx9NYIwiDtwpn1cXVNbhU5nk6OC1m2zuYvg0A/k6tx+mCuKJ
 vDkk+moqXeD33dwGctbBeeZZDhyGNNveNQz+U41KFpfnlr8hIbLVUU5fmIU1eQcVQvtLN5N30
 JlPY3iXHyp3F+5m3yyIAEkHa5C/z/TA8rtPJGeQsBZE1m0SauBK4bMQ0jJseWVMQoyzESpzZl
 xUKdJdsY7LWn0c=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 8de7eeb54b (compression: unify pack.compression configuration
parsing, 2016-11-15) the variables core_compression_level and
core_compression_seen are only set, but never read.  Remove them.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 cache.h       | 1 -
 config.c      | 3 ---
 environment.c | 1 -
 3 files changed, 5 deletions(-)

diff --git a/cache.h b/cache.h
index d23de69368..933bd33e69 100644
=2D-- a/cache.h
+++ b/cache.h
@@ -958,7 +958,6 @@ extern char *apply_default_ignorewhitespace;
 extern const char *git_attributes_file;
 extern const char *git_hooks_path;
 extern int zlib_compression_level;
-extern int core_compression_level;
 extern int pack_compression_level;
 extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
diff --git a/config.c b/config.c
index cb4a8058bf..7eca6aff8b 100644
=2D-- a/config.c
+++ b/config.c
@@ -76,7 +76,6 @@ static struct key_value_info *current_config_kvi;
  */
 static enum config_scope current_parsing_scope;

-static int core_compression_seen;
 static int pack_compression_seen;
 static int zlib_compression_seen;

@@ -1400,8 +1399,6 @@ static int git_default_core_config(const char *var, =
const char *value, void *cb)
 			level =3D Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
 			die(_("bad zlib compression level %d"), level);
-		core_compression_level =3D level;
-		core_compression_seen =3D 1;
 		if (!zlib_compression_seen)
 			zlib_compression_level =3D level;
 		if (!pack_compression_seen)
diff --git a/environment.c b/environment.c
index d6b22ede7e..b4ba4fa22d 100644
=2D-- a/environment.c
+++ b/environment.c
@@ -41,7 +41,6 @@ char *apply_default_ignorewhitespace;
 const char *git_attributes_file;
 const char *git_hooks_path;
 int zlib_compression_level =3D Z_BEST_SPEED;
-int core_compression_level;
 int pack_compression_level =3D Z_DEFAULT_COMPRESSION;
 int fsync_object_files;
 size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WINDOW_SIZE;
=2D-
2.33.0
