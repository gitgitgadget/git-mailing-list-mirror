Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0BDC433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 10:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346530AbiD3Kge (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiD3Kgd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 06:36:33 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F27D612B5
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1651314767;
        bh=alMXa1H1fkQN82eso7y5wb9O8nf3B8Tb0W3L01iXbdo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=L4CFpUJnB5HxaL5T+8xtg+v7DAzQBrBiGyGhMq5h8bU8S2xsOl2uAIjyXPg2Xm8oc
         KnD0e3QdzDiiQZgjjFSxHGXTS4wG6kjGiUZT7e9X2e8aVyQfQFmDY57j2S3InZyIUF
         861xGijtUN6YmOWmC4emT3K1JLQeccOG4XOIzD0U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGxQV-1ngdwr3uUd-00EDoW; Sat, 30
 Apr 2022 12:32:46 +0200
Message-ID: <c36896a1-6247-123b-4fa3-b7eb24af1897@web.de>
Date:   Sat, 30 Apr 2022 12:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: [PATCH] 2.36 format-patch regression fix
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Daniel Li <dan@danielyli.com>, git@vger.kernel.org
References: <CAHVT7hW28jMcphDPhcUG==mycCWDaAt46wWo68=oTcSvebHWwg@mail.gmail.com>
 <xmqqzgk388tt.fsf@gitster.g> <xmqqo80j87g0.fsf_-_@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo80j87g0.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p3D2L5UQfbi1hTdctb04goQK7ddFZAT5DUM0bguiq61PgzW6YsH
 PKmrIaGirRbtlFVoZui32gWnUGMrQqkduWU98d2ZJpM17gbYZbf6AN5J7ilmxg0cHN+htA6
 1zuVNEL93gJBePn3yQdviZXGY7nMVq5lrzSE2zYEY3m8grOVIP+RsOHLCFf7TLlUQQaj0xn
 rD31AZBWhmdG7Vnjb4S2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:25VGplwG4Ks=:k14H2nc/hvqYu95/n9ScgD
 jJxivkXEnVXFhsjdBblROLcYs0tmXfTyywVT2OpTGPzfudkEvCY0+Bk6pWZzcX9pPZlRUpRdQ
 j2W19B1J9G1Sj8dObABrxqewPBubBp053v8iQPgDzH547PGnI9rJzA2lCLJ//NvjHfxhkdEEs
 wTcgLAjUGdrL8LCz3SLlJOHF6Hg5p0e/ErspmNJycWsPjyYtrnaaCe3KRkJ6L+P03bINI16al
 XKKgQAIqWTpYjepF93hS3Q8ckgnB+2EHUPXqKAhnlFIcRxFYvWXoC4yQE//OF2SlAYUYY9lC7
 iyDj8ReOOIVFlc7IsyUwXvzmpXzyyucrjAyg5NarIrR01ZTauLa74j+i+h4d865VHTgK4kTPZ
 nrMAjcmJ9rZpeeAmMCR9CZq36H8f6PdccaStX/cyqUjaq2wlgv9SdmrFgGcvslYG1YFZpjAiv
 Llh3PaB0qNCe3lL+RkYuRHkjnHGRDGut/QDkzCK85+n7/+2RyKdLQCdvWekuElnbyBUpKuVA2
 SYi1y7gGFBC9kSw0yctI3rT8FdNkUkjWJTSaLkQ3hPbh5ljpSTOHr7Tkwai7GE7GHfZK6s1X4
 fTSBxEwBeI2JZsR8pJcBKsqyMyqC3ZFF2XTPc+helYkSBTs8PCL3u/H0UQXyJgkAks38cyh4w
 iJ0APQdV+2dwkJj7wtzG13hvC8Hby0Bd5vztRAsQeNjHWH3n/AX+gVt36gCGnq6FMgiGuweSv
 LbOnwPAvKIUeKNftgM79CrIkBXmdydEWTMgx3CjuRKP4Dk9tc4M4dbhe/vWW331xc9WoE17Oj
 X1m21mxoRX5B7I/8cKPc9+GwN7mGUxRgtDZcp0Ann9W5fja5OAuTThha+KVwQeDP/1vLSSTsE
 YSbHAKmU64a9+uVd34WmOIx5Skf2flXCEW6xe0cGOK+K6qg1aIvWAETrBM5cgy7YoLcZJcBpR
 BYRHQ1RiyhnhrHEgPaM44dZL9NDn9PhbfZHjZGDRHPWYE7KCAOR6j3Sv7dIuXFQA5c5bmGT9/
 0mLMr5+rnyygxBrUXwl7g2qmdKcQp4MonDKUX9VwY/9qOTkHnnGcPDeDJ6bxl738GQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

e900d494dc (diff: add an API for deferred freeing, 2021-02-11) added a
way to allow reusing diffopts: the no_free bit.  244c27242f (diff.[ch]:
have diff_free() call clear_pathspec(opts.pathspec), 2022-02-16) made
that mechanism mandatory.

git format-patch only sets no_free when --output is given, causing it to
forget pathspecs after the first commit.  Set no_free unconditionally
instead.

The existing test was unable to detect this breakage because it checks
stderr for the absence of a certain string, but format-patch writes to
stdout.  Also the test was not checking the case of one commit modifying
multiple files and a pathspec limiting the diff.  Replace it with a more
thorough one.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/log.c           |  9 ++-------
 t/t4014-format-patch.sh | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c211d66d1d..9acc130594 100644
=2D-- a/builtin/log.c
+++ b/builtin/log.c
@@ -1883,6 +1883,7 @@ int cmd_format_patch(int argc, const char **argv, co=
nst char *prefix)
 	rev.diff =3D 1;
 	rev.max_parents =3D 1;
 	rev.diffopt.flags.recursive =3D 1;
+	rev.diffopt.no_free =3D 1;
 	rev.subject_prefix =3D fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def =3D "HEAD";
@@ -2008,13 +2009,7 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)

 	if (use_stdout) {
 		setup_pager();
-	} else if (rev.diffopt.close_file) {
-		/*
-		 * The diff code parsed --output; it has already opened the
-		 * file, but we must instruct it not to close after each diff.
-		 */
-		rev.diffopt.no_free =3D 1;
-	} else {
+	} else if (!rev.diffopt.close_file) {
 		int saved;

 		if (!output_directory)
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7dc5a5c736..fbec8ad2ef 100755
=2D-- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -926,11 +926,40 @@ test_expect_success 'format-patch --numstat should p=
roduce a patch' '
 '

 test_expect_success 'format-patch -- <path>' '
-	git format-patch main..side -- file 2>error &&
-	! grep "Use .--" error
+	rm -f *.patch &&
+	git checkout -b pathspec main &&
+
+	echo file_a 1 >file_a &&
+	echo file_b 1 >file_b &&
+	git add file_a file_b &&
+	git commit -m pathspec_initial &&
+
+	echo file_a 2 >>file_a &&
+	git add file_a &&
+	git commit -m pathspec_a &&
+
+	echo file_b 2 >>file_b &&
+	git add file_b &&
+	git commit -m pathspec_b &&
+
+	echo file_a 3 >>file_a &&
+	echo file_b 3 >>file_b &&
+	git add file_a file_b &&
+	git commit -m pathspec_ab &&
+
+	cat >expect <<-\EOF &&
+	0001-pathspec_initial.patch
+	0002-pathspec_a.patch
+	0003-pathspec_ab.patch
+	EOF
+
+	git format-patch main..pathspec -- file_a >output &&
+	test_cmp expect output &&
+	! grep file_b *.patch
 '

 test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
+	git checkout side &&
 	git format-patch --ignore-if-in-upstream HEAD
 '

=2D-
2.35.3

