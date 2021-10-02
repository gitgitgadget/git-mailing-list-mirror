Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BFCC433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 17:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437F061AF7
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 17:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhJBRjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 13:39:22 -0400
Received: from mout.web.de ([212.227.15.14]:49343 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232043AbhJBRjW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 13:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633196254;
        bh=AYj2ITh/Va0+Q21NfO/C/1kSnjh6vE2cs77aAsMDXdA=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=EcrZE3+EheWRKn6FEvx9+x+Ze/dRTKuJfohaZXYhvCEwEbVbfOvgXW4ub8QKXnhpy
         Xn4PKtVpaxT4Lp35mTRKiYZdaUgKwwpRqmoWNimNbmzUeAl+tMOeLFLwWkfap6n363
         jhtoWke7T98127HfbT11eSBEBUG6NECQ8yyRoFIU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MDSxB-1maJSF04oH-00Go9K; Sat, 02 Oct 2021 19:37:34 +0200
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: p2000 failure due to empty reflog
Message-ID: <b25ac1cc-8e77-17e6-602a-b289c1e1cfeb@web.de>
Date:   Sat, 2 Oct 2021 19:37:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zETBNq0qzQvVgxg9ok7Gv642h7ZLMZBr2RvXesk+nIxvOhu+BLn
 nzScguh6FXLn7TXC1jNqpS1yrTFeRdGRiyWDb5d3YlXTYGlOxM6c4Pn1pQ05YfO5OBl3Ll2
 CFMY+6tsOD2pLyh9WI9sDrtldGdRJimZnZbjvPSqIJ+R3bMtlnFJq270hSLSHS7mDgbiBYf
 9f/Ha7WY57nPES5GmoJYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pQRpfZEgE0c=:oGPSH9KllAwm3qCuFn+1z0
 pCjBU/jzJYFVX2hs/R6RRxuKt07CRGdqv1fzYOWoRN6npJ9RMPlsUBSXmv3BBYeCNZOIsNYRk
 sCXNtT5w7jLZQiDQozfU04MsG0AjohitBVKHTiaRbcSFDQVVwWl0CEBb3VdZmUsQJGflt3VNM
 DGhYmFT7QSHgWCoDaiqBkXlCEmSv4yv9kh2QcdPY7ICjf/BXrD0jrQY4EF9PoodukSbszAE4i
 kiN5OJ7FKKeoq0b9Lq12pqTd3aXN6mHAsyv8/rWQjB1/90z+xsaxIOlusy2kxcRW0clyBwoF4
 S3LFlSxZdxwkB7uaVWocG7aERO/3bryc6+LrgFG5z8COo33Yug8FPjdMyOCR4rnVaqRaXCBOv
 QThPGAzbJSQ6MYCoTH8IYtVUr9ePp1ZBX8/cxsDnTIV4hqUsyHMn5MmMBwvWQ8iL3NzesYF7J
 nrD3w1eIWMgIFzFQp0/6H+2MH/cKt81Srm0zPIvbW3lI3/rrRN9BxyYfS2URKjUijhg7jmD36
 8bjWjR0xmr45l6Fr2J60lrNTHO2HZQGCkzFLZQpJIDJgvQmMN7Us8EuNciqo7s3ZmivGd7SKe
 qyUHllfoeiAgdhGfjD1RfzK6IPNp/BuiiDbb/oPmpNR8vUl8aeBDMKdnoY1LyiY1O+qfkcjPZ
 MyLZ/I2DW5+S49vdQ+AyvJkaeaYbYaYmodmhhFtYNpEXgsVVEYUb6Ywk7ErPHLCKT3GU0Svj0
 y/g53bqyFcHFMOmw+kL4psR6Pu+LeYahw/yHxkxZJg1xWS1rlaIQlnwgOucexEEH2a4D2p29h
 LKnUv8LjhIqP/MG9kjdg32+YLH0Il3vbGNQNUaY6gVgZ9H2NKTSklETmR8GbkmwvhkduZXMQl
 1/cvcg8xSVSMDloIyBPJVkgU1AGYEwqOP1heqGrui652yHopbwS3KNwBA7QlEPzOnZD74Ut8m
 wiJUUifEp9kxosQ4AXT/6nGkXXannBc4c+11qCURV6uqCFVv9bV//xewVIbOY+u9PA9mw+7pZ
 VyRlE9r2RRdNvQvuOswTtUqas0ovhxIElZcFngVD6y/suxUxs+6haJGQ79VjYm/ukuFGSDd2m
 Dx1ErZKQbP3aAo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

p2000 fails for me and reports:

   perf 18 - git checkout -f - (full-v3):
   running:
   			(
   				cd full-v3 &&
   				echo >>f2/f4/a &&
   				git checkout -f -
   			)

   error: pathspec '-' did not match any file(s) known to git

checkout fails because the reflog is empty, so the "-" can't be
resolved.  The pathspec error message is confusing, though.

The patch below adds a reflog entry and allows the script to
succeed.

Before the "test_perf_on_all git commit -a -m A", there are two
reflog entries in each of the five clones, after it there are
none.  How is that even possible?


=2D--
 t/perf/p2000-sparse-operations.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-opera=
tions.sh
index 597626276f..8529e3d295 100755
=2D-- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -25,6 +25,7 @@ test_expect_success 'setup repo and indexes' '
 	git commit -m "level 0" &&
 	BLOB=3D$(git rev-parse HEAD:a) &&
 	OLD_COMMIT=3D$(git rev-parse HEAD) &&
+	test_export OLD_COMMIT &&
 	OLD_TREE=3D$(git rev-parse HEAD^{tree}) &&

 	for i in $(test_seq 1 3)
@@ -109,6 +110,14 @@ test_perf_on_all git status
 test_perf_on_all git add -A
 test_perf_on_all git add .
 test_perf_on_all git commit -a -m A
+
+test_expect_success 'add reflog entry' '
+	for repo in full-v3 full-v4 sparse-v3 sparse-v4
+	do
+		git -C $repo checkout $OLD_COMMIT
+	done
+'
+
 test_perf_on_all git checkout -f -

 test_done
=2D-
2.33.0
