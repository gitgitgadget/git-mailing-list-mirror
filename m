Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB691C2D0C2
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 09:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A7C206DB
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 09:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFGZqasu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfLaJx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 04:53:57 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37326 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfLaJx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 04:53:57 -0500
Received: by mail-ed1-f68.google.com with SMTP id cy15so34887597edb.4
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 01:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+rtclFkHcZ4z0JaO7PBrNeADXWpFFElgSoQp9fcdqVE=;
        b=UFGZqasucPcdkEzP3IbWfdRrvCsAE139HUjs+yfwNE00O1jxqIpbB1RQ+OkNAMOdp7
         elUCBzjj2h289yM+LKUGrYM+53uOLBCm8taleJ26R1RRY1/vbIpAYBt55Tudrd/qC7Mq
         WXCBQU16u7JN30/ZuTnol6+kSP/dLJPRBt5d1rEp+qKmlB8jfIS4tYCO62WLLnEzTHdU
         BcngAh8eh4O+udNAQlVjmO+ENtiTE4jpL2drv1SSap6wB4vVPWhMON4KNxrkmU5WtbUd
         HB54aabklkG+vfholwkQ75GjMGYN9i4CzaECQMzpChjDavZroRDOZIpZV9cSEHVrXVkP
         gG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+rtclFkHcZ4z0JaO7PBrNeADXWpFFElgSoQp9fcdqVE=;
        b=Tomd7FOjWjYO5IlRTJ7vPGa6cVcYq7Ef8Hefo8iXNJyKpAPdT+pesWogFWOotU7RE/
         L72exDNxIAvkQTpSvb2anIwLw8rkDVTm9CzYUSP3IBKN1psIxmO+weugkoy91QOK3yRp
         +5pmtLlZHhn/F4ZPcRbaUB5opI9f+Vkf351gUBt6bgwuUWszUP3+g0qQF7/V4AjP2Z4o
         N2xKinxPxhtYYkj7ipMULuvpvVcem24uUiJyAL5ASffxAkpR2HD8BbGePr0VtH7pxMUb
         gFj7Vn+r3QPskOF5EBbeHpnx12GKvvKYPZ2UqugreL9dCpgxIyREemz0zTM5S1qox1tX
         pSZA==
X-Gm-Message-State: APjAAAW/oPBkxF031viEyi6EkmeqWBfe3cr+ZTUPajZjsEoyd+smVT4W
        lxjFY9nPYMJJD5VjZ4jsiuZo2vX2
X-Google-Smtp-Source: APXvYqzCBm0Nxzk0N8yEVcVrTm0EIiF3v+WWfwqq5ZirrSVTBiraVzK/ZBJC57OoOlhlh5AR1TGLsA==
X-Received: by 2002:a17:906:560e:: with SMTP id f14mr74469500ejq.300.1577786034126;
        Tue, 31 Dec 2019 01:53:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm6101708ejx.20.2019.12.31.01.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 01:53:53 -0800 (PST)
Message-Id: <pull.503.v3.git.1577786032.gitgitgadget@gmail.com>
In-Reply-To: <pull.503.v2.git.1577733329.gitgitgadget@gmail.com>
References: <pull.503.v2.git.1577733329.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Dec 2019 09:53:49 +0000
Subject: [PATCH v3 0/3] t: rework tests for --pathspec-from-file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please refer to commit messages for rationale.

This branch is a follow-up for [1] where part of branch was merged into `master` via [2].

Previously in [3] there were some concerns on whether removing
copy&pasted tests is good. I still think that yes, it 's a good thing,
mostly because of high volume of potential 13*6=78 duplicate tests.

Still, I separated this change as last patch, so that the remaining
part of the branch can be taken without it.

[1] https://lore.kernel.org/git/pull.490.git.1576161385.gitgitgadget@gmail.com/
[2] https://public-inbox.org/git/pull.445.v4.git.1575381738.gitgitgadget@gmail.com/
[3] https://lore.kernel.org/git/xmqqwoatcn5u.fsf@gitster-ct.c.googlers.com/

Changes since V1
----------------
Small code formatting changes suggested in V1.

Alexandr Miloslavskiy (3):
  t: fix quotes tests for --pathspec-from-file
  t: directly test parse_pathspec_file()
  t: drop copy&pasted tests for --pathspec-from-file

 Makefile                            |   1 +
 t/helper/test-parse-pathspec-file.c |  33 +++++++++
 t/helper/test-tool.c                |   1 +
 t/helper/test-tool.h                |   1 +
 t/t0067-parse_pathspec_file.sh      | 108 ++++++++++++++++++++++++++++
 t/t2026-checkout-pathspec-file.sh   |  70 +-----------------
 t/t2072-restore-pathspec-file.sh    |  70 +-----------------
 t/t3704-add-pathspec-file.sh        |  70 +-----------------
 t/t7107-reset-pathspec-file.sh      |  79 +++-----------------
 t/t7526-commit-pathspec-file.sh     |  70 +-----------------
 10 files changed, 160 insertions(+), 343 deletions(-)
 create mode 100644 t/helper/test-parse-pathspec-file.c
 create mode 100755 t/t0067-parse_pathspec_file.sh


base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-503%2FSyntevoAlex%2F%230207(git)_2b_test_parse_directly-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-503/SyntevoAlex/#0207(git)_2b_test_parse_directly-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/503

Range-diff vs v2:

 1:  6193dc7396 ! 1:  88790669ce t: fix quotes tests for --pathspec-from-file
     @@ -7,7 +7,7 @@
          I had to escape it two times! Tests still worked due to `"` being
          preserved which in turn prevented pathspec from matching files.
      
     -    Fix this by properly escaping one more time.
     +    Fix this by using here-doc instead.
      
          Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
      
     @@ -19,10 +19,11 @@
       	restore_checkpoint &&
       
      -	printf "\"file\\101.t\"" | git checkout --pathspec-from-file=- HEAD^1 &&
     -+	# shell  takes \\\\101 and spits \\101
     -+	# printf takes   \\101 and spits  \101
     -+	# git    takes    \101 and spits     A
     -+	printf "\"file\\\\101.t\"" | git checkout --pathspec-from-file=- HEAD^1 &&
     ++	cat >list <<-\EOF &&
     ++	"file\101.t"
     ++	EOF
     ++
     ++	git checkout --pathspec-from-file=list HEAD^1 &&
       
       	cat >expect <<-\EOF &&
       	M  fileA.t
     @@ -31,9 +32,10 @@
       	restore_checkpoint &&
       
      -	printf "\"file\\101.t\"" >list &&
     -+	# shell  takes \\\\101 and spits \\101
     -+	# printf takes   \\101 and spits  \101
     -+	printf "\"file\\\\101.t\"" >list &&
     ++	cat >list <<-\EOF &&
     ++	"file\101.t"
     ++	EOF
     ++
       	test_must_fail git checkout --pathspec-from-file=list --pathspec-file-nul HEAD^1
       '
       
     @@ -46,10 +48,11 @@
       	restore_checkpoint &&
       
      -	printf "\"file\\101.t\"" | git restore --pathspec-from-file=- --source=HEAD^1 &&
     -+	# shell  takes \\\\101 and spits \\101
     -+	# printf takes   \\101 and spits  \101
     -+	# git    takes    \101 and spits     A
     -+	printf "\"file\\\\101.t\"" | git restore --pathspec-from-file=- --source=HEAD^1 &&
     ++	cat >list <<-\EOF &&
     ++	"file\101.t"
     ++	EOF
     ++
     ++	git restore --pathspec-from-file=list --source=HEAD^1 &&
       
       	cat >expect <<-\EOF &&
       	 M fileA.t
     @@ -58,9 +61,10 @@
       	restore_checkpoint &&
       
      -	printf "\"file\\101.t\"" >list &&
     -+	# shell  takes \\\\101 and spits \\101
     -+	# printf takes   \\101 and spits  \101
     -+	printf "\"file\\\\101.t\"" >list &&
     ++	cat >list <<-\EOF &&
     ++	"file\101.t"
     ++	EOF
     ++
       	test_must_fail git restore --pathspec-from-file=list --pathspec-file-nul --source=HEAD^1
       '
       
     @@ -73,10 +77,11 @@
       	restore_checkpoint &&
       
      -	printf "\"file\\101.t\"" | git add --pathspec-from-file=- &&
     -+	# shell  takes \\\\101 and spits \\101
     -+	# printf takes   \\101 and spits  \101
     -+	# git    takes    \101 and spits     A
     -+	printf "\"file\\\\101.t\"" | git add --pathspec-from-file=- &&
     ++	cat >list <<-\EOF &&
     ++	"file\101.t"
     ++	EOF
     ++
     ++	git add --pathspec-from-file=list &&
       
       	cat >expect <<-\EOF &&
       	A  fileA.t
     @@ -85,9 +90,10 @@
       	restore_checkpoint &&
       
      -	printf "\"file\\101.t\"" >list &&
     -+	# shell  takes \\\\101 and spits \\101
     -+	# printf takes   \\101 and spits  \101
     -+	printf "\"file\\\\101.t\"" >list &&
     ++	cat >list <<-\EOF &&
     ++	"file\101.t"
     ++	EOF
     ++
       	test_must_fail git add --pathspec-from-file=list --pathspec-file-nul
       '
       
     @@ -99,12 +105,13 @@
       test_expect_success 'quotes' '
       	restore_checkpoint &&
       
     -+	# shell  takes \\\\101 and spits \\101
     -+	# printf takes   \\101 and spits  \101
     -+	# git    takes    \101 and spits     A
     ++	cat >list <<-\EOF &&
     ++	"file\101.t"
     ++	EOF
     ++
       	git rm fileA.t &&
      -	printf "\"file\\101.t\"" | git reset --pathspec-from-file=- &&
     -+	printf "\"file\\\\101.t\"" | git reset --pathspec-from-file=- &&
     ++	git reset --pathspec-from-file=list &&
       
       	cat >expect <<-\EOF &&
       	 D fileA.t
     @@ -112,11 +119,12 @@
       test_expect_success 'quotes not compatible with --pathspec-file-nul' '
       	restore_checkpoint &&
       
     -+	# shell  takes \\\\101 and spits \\101
     -+	# printf takes   \\101 and spits  \101
     - 	git rm fileA.t &&
     +-	git rm fileA.t &&
      -	printf "\"file\\101.t\"" >list &&
     -+	printf "\"file\\\\101.t\"" >list &&
     ++	cat >list <<-\EOF &&
     ++	"file\101.t"
     ++	EOF
     ++
       	# Note: "git reset" has not yet learned to fail on wrong pathspecs
       	git reset --pathspec-from-file=list --pathspec-file-nul &&
       
     @@ -129,10 +137,11 @@
       	restore_checkpoint &&
       
      -	printf "\"file\\101.t\"" | git commit --pathspec-from-file=- -m "Commit" &&
     -+	# shell  takes \\\\101 and spits \\101
     -+	# printf takes   \\101 and spits  \101
     -+	# git    takes    \101 and spits     A
     -+	printf "\"file\\\\101.t\"" | git commit --pathspec-from-file=- -m "Commit" &&
     ++	cat >list <<-\EOF &&
     ++	"file\101.t"
     ++	EOF
     ++
     ++	git commit --pathspec-from-file=list -m "Commit" &&
       
       	cat >expect <<-\EOF &&
       	A	fileA.t
     @@ -141,9 +150,10 @@
       	restore_checkpoint &&
       
      -	printf "\"file\\101.t\"" >list &&
     -+	# shell  takes \\\\101 and spits \\101
     -+	# printf takes   \\101 and spits  \101
     -+	printf "\"file\\\\101.t\"" >list &&
     ++	cat >list <<-\EOF &&
     ++	"file\101.t"
     ++	EOF
     ++
       	test_must_fail git commit --pathspec-from-file=list --pathspec-file-nul -m "Commit"
       '
       
 2:  ab449ac15a ! 2:  68925c2712 t: directly test parse_pathspec_file()
     @@ -172,24 +172,28 @@
      +	fileA.t
      +	EOF
      +
     -+	# shell  takes \\\\101 and spits \\101
     -+	# printf takes   \\101 and spits  \101
     -+	# git    takes    \101 and spits     A
     -+	printf "\"file\\\\101.t\"" |
     -+	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
     ++	cat >list <<-\EOF &&
     ++	"file\101.t"
     ++	EOF
     ++
     ++	test-tool parse-pathspec-file --pathspec-from-file=list >actual &&
      +
      +	test_cmp expect actual
      +'
      +
      +test_expect_success '--pathspec-file-nul takes quotes literally' '
     ++	# Note: there is an extra newline because --pathspec-file-nul takes
     ++	# input \n literally, too
      +	cat >expect <<-\EOF &&
      +	"file\101.t"
     ++
      +	EOF
      +
     -+	# shell  takes \\\\101 and spits \\101
     -+	# printf takes   \\101 and spits  \101
     -+	printf "\"file\\\\101.t\"" |
     -+	test-tool parse-pathspec-file --pathspec-from-file=- --pathspec-file-nul >actual &&
     ++	cat >list <<-\EOF &&
     ++	"file\101.t"
     ++	EOF
     ++
     ++	test-tool parse-pathspec-file --pathspec-from-file=list --pathspec-file-nul >actual &&
      +
      +	test_cmp expect actual
      +'
 3:  88086cebce ! 3:  f71021b0dd t: drop copy&pasted tests for --pathspec-from-file
     @@ -88,10 +88,11 @@
      -test_expect_success 'quotes' '
      -	restore_checkpoint &&
      -
     --	# shell  takes \\\\101 and spits \\101
     --	# printf takes   \\101 and spits  \101
     --	# git    takes    \101 and spits     A
     --	printf "\"file\\\\101.t\"" | git checkout --pathspec-from-file=- HEAD^1 &&
     +-	cat >list <<-\EOF &&
     +-	"file\101.t"
     +-	EOF
     +-
     +-	git checkout --pathspec-from-file=list HEAD^1 &&
      -
      -	cat >expect <<-\EOF &&
      -	M  fileA.t
     @@ -102,9 +103,10 @@
      -test_expect_success 'quotes not compatible with --pathspec-file-nul' '
      -	restore_checkpoint &&
      -
     --	# shell  takes \\\\101 and spits \\101
     --	# printf takes   \\101 and spits  \101
     --	printf "\"file\\\\101.t\"" >list &&
     +-	cat >list <<-\EOF &&
     +-	"file\101.t"
     +-	EOF
     +-
      -	test_must_fail git checkout --pathspec-from-file=list --pathspec-file-nul HEAD^1
      -'
      -
     @@ -188,10 +190,11 @@
      -test_expect_success 'quotes' '
      -	restore_checkpoint &&
      -
     --	# shell  takes \\\\101 and spits \\101
     --	# printf takes   \\101 and spits  \101
     --	# git    takes    \101 and spits     A
     --	printf "\"file\\\\101.t\"" | git restore --pathspec-from-file=- --source=HEAD^1 &&
     +-	cat >list <<-\EOF &&
     +-	"file\101.t"
     +-	EOF
     +-
     +-	git restore --pathspec-from-file=list --source=HEAD^1 &&
      -
      -	cat >expect <<-\EOF &&
      -	 M fileA.t
     @@ -202,9 +205,10 @@
      -test_expect_success 'quotes not compatible with --pathspec-file-nul' '
      -	restore_checkpoint &&
      -
     --	# shell  takes \\\\101 and spits \\101
     --	# printf takes   \\101 and spits  \101
     --	printf "\"file\\\\101.t\"" >list &&
     +-	cat >list <<-\EOF &&
     +-	"file\101.t"
     +-	EOF
     +-
      -	test_must_fail git restore --pathspec-from-file=list --pathspec-file-nul --source=HEAD^1
      -'
      -
     @@ -288,10 +292,11 @@
      -test_expect_success 'quotes' '
      -	restore_checkpoint &&
      -
     --	# shell  takes \\\\101 and spits \\101
     --	# printf takes   \\101 and spits  \101
     --	# git    takes    \101 and spits     A
     --	printf "\"file\\\\101.t\"" | git add --pathspec-from-file=- &&
     +-	cat >list <<-\EOF &&
     +-	"file\101.t"
     +-	EOF
     +-
     +-	git add --pathspec-from-file=list &&
      -
      -	cat >expect <<-\EOF &&
      -	A  fileA.t
     @@ -302,9 +307,10 @@
      -test_expect_success 'quotes not compatible with --pathspec-file-nul' '
      -	restore_checkpoint &&
      -
     --	# shell  takes \\\\101 and spits \\101
     --	# printf takes   \\101 and spits  \101
     --	printf "\"file\\\\101.t\"" >list &&
     +-	cat >list <<-\EOF &&
     +-	"file\101.t"
     +-	EOF
     +-
      -	test_must_fail git add --pathspec-from-file=list --pathspec-file-nul
      -'
      -
     @@ -398,11 +404,12 @@
      -test_expect_success 'quotes' '
      -	restore_checkpoint &&
      -
     --	# shell  takes \\\\101 and spits \\101
     --	# printf takes   \\101 and spits  \101
     --	# git    takes    \101 and spits     A
     +-	cat >list <<-\EOF &&
     +-	"file\101.t"
     +-	EOF
     +-
      -	git rm fileA.t &&
     --	printf "\"file\\\\101.t\"" | git reset --pathspec-from-file=- &&
     +-	git reset --pathspec-from-file=list &&
      -
      -	cat >expect <<-\EOF &&
      -	 D fileA.t
     @@ -413,10 +420,10 @@
      -test_expect_success 'quotes not compatible with --pathspec-file-nul' '
      -	restore_checkpoint &&
      -
     --	# shell  takes \\\\101 and spits \\101
     --	# printf takes   \\101 and spits  \101
     --	git rm fileA.t &&
     --	printf "\"file\\\\101.t\"" >list &&
     +-	cat >list <<-\EOF &&
     +-	"file\101.t"
     +-	EOF
     +-
      -	# Note: "git reset" has not yet learned to fail on wrong pathspecs
      -	git reset --pathspec-from-file=list --pathspec-file-nul &&
      -
     @@ -506,10 +513,11 @@
      -test_expect_success 'quotes' '
      -	restore_checkpoint &&
      -
     --	# shell  takes \\\\101 and spits \\101
     --	# printf takes   \\101 and spits  \101
     --	# git    takes    \101 and spits     A
     --	printf "\"file\\\\101.t\"" | git commit --pathspec-from-file=- -m "Commit" &&
     +-	cat >list <<-\EOF &&
     +-	"file\101.t"
     +-	EOF
     +-
     +-	git commit --pathspec-from-file=list -m "Commit" &&
      -
      -	cat >expect <<-\EOF &&
      -	A	fileA.t
     @@ -520,9 +528,10 @@
      -test_expect_success 'quotes not compatible with --pathspec-file-nul' '
      -	restore_checkpoint &&
      -
     --	# shell  takes \\\\101 and spits \\101
     --	# printf takes   \\101 and spits  \101
     --	printf "\"file\\\\101.t\"" >list &&
     +-	cat >list <<-\EOF &&
     +-	"file\101.t"
     +-	EOF
     +-
      -	test_must_fail git commit --pathspec-from-file=list --pathspec-file-nul -m "Commit"
      -'
      -

-- 
gitgitgadget
