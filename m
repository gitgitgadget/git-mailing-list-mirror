Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB5AC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 10:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiBXKJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiBXKJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 05:09:26 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3994A28A104
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:08:56 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id b9-20020a17090aa58900b001b8b14b4aabso1155699pjq.9
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=dki7nJfYFix75j88KqOmfOlRoDEdUO8th/JF5kfALoo=;
        b=EcOr8eOEDhd9DtiBSHKamx281ikFB6dEG6kZNMg831kkItWV1/sEfTtFufNWjD8shQ
         zTcWaIqhOqFp+pCHjioG8Homzys0GYliisBnyeKxM3Cd4QWscmZD7LL4x7q4Ke39Cjbc
         KwSFK0X2yAzwXb5NSV13/uq3cn/mmX7Nrvihmn57nMTL8lZJxc25i9Is6Bvo+XVML0A+
         KoHUS3lowDus+larxQAR1sAmu/Xtx+1foAmDsrHp60YX2bWfI36J33TWiFY+QB+zYNiY
         3Qs6z283Iq2edhMgLUuVqGeCpecJ3QeJ3Wlk7L3eUef8aDF+EgHqmX8qMuxbEQAqcFVS
         bPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=dki7nJfYFix75j88KqOmfOlRoDEdUO8th/JF5kfALoo=;
        b=upOXpunxRzmMntnXElxX9LPpgHkgYt5NzowGyZlxLbgs6UGiySHZ5G91q4nNcIbDHt
         7utWX1HKkNP1bU4URtoXl8WtIxBJ57mcAIaKG3+SiMd6Oq0w/GBTPDGjeX7KuUJWokF7
         CYivBrfR8Tg7OwQuuskFgedo4EFR8PZnsOgkubdg2onThlZeSC/f711zt/UA9AqpIEmJ
         tldKK07dx4ycJYzEasN0NLA51s0TmF0ItNgpalwD3kgrXifVdnZCf8X4jw2ovslKLKQe
         cVVEqOTN4cq9wwKoqOGZ3HEEAygjRquWYHbgxzzBjIdmJWSlIqN6hn9b5QnlXlxIFph5
         mNYA==
X-Gm-Message-State: AOAM5330S72YNb7TMGENgfxHYEDtRERiAc2tG9xZ7YhJfl8XLqO5NwjD
        CLAPjlx7PbzacUKlOemFM7kjdlEBQx4Qvg489zBnZTOCvs6GMXmwudEqXnKZbiFaky3qvzE28+2
        hB7D4WkdC/ReBN8xxL7jLxEARp/5Oy9ApB0gTo90KAB6pyViJXgQIixiQYsdzVQY=
X-Google-Smtp-Source: ABdhPJzBN5VFXp2X9tollTRq79mzYP+Eq22RRDI8e8n4d830zPIlKBfYmL2ZPhOIle1dyT0nf4gTy0JKpySFyA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1d8b:b0:4f1:bd8:811 with SMTP id
 z11-20020a056a001d8b00b004f10bd80811mr2079841pfw.25.1645697335566; Thu, 24
 Feb 2022 02:08:55 -0800 (PST)
Date:   Thu, 24 Feb 2022 18:08:34 +0800
In-Reply-To: <20220224100842.95827-1-chooglen@google.com>
Message-Id: <20220224100842.95827-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 02/10] t5526: stop asserting on stderr literally
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous commit message, we noted that not all of the "git fetch"
stderr is relevant to the tests. Most of the test setup lines are
dedicated to these details of the stderr:

1. which repos (super/sub/deep) are involved in the fetch
2. the head of the remote-tracking branch before the fetch (i.e. $head1)
3. the head of the remote-tracking branch after the fetch (i.e. $head2)

1. and 3. are relevant because they tell us that the expected commit is
fetched by the expected repo, but 2. is completely irrelevant.

Stop asserting on $head1 by replacing it with a dummy value in the
actual and expected output. Do this by introducing test
helpers (check_*()) that make it easier to construct the expected
output, and use sed to munge the actual output.

Signed-off-by: Glen Choo <chooglen@google.com>
---
Per =C3=86var's suggestion [1], I reverted the test suite changes that
replaced "test_cmp" with "grep", and opted to munge out irrelevant
details with "sed". Opinion on "grep" vs "test_cmp" seems a bit split,
and there are good arguments for either, but for these tests, I think
test_cmp works better for a few reasons:

- The motivation for removing test_cmp in the old patch 1 [2], i.e.
  we _want_ to ignore changes in the test output, turned out to be
  absolutely incorrect. We actually care a lot about the changes in test
  output because it tells us where we are reading the submodule info
  from.

  In the v1-2 test scheme, verify_fetch_result() would ignore those
  changes, so I added extra extra grep-s specifically to check
  where the submodule is read from. ([3] comments on one of these). I
  could have generalized verify_fetch_result() to handle those extra
  grep-s, but since the original motivation for using grep is gone,
  test_cmp seemed like a viable alternative for an intuitive test
  scheme.

- verify_fetch_result() is easier to reason about because we now assert
  on the output almost verbatim (besides munging), instead of mixing
  greps and negative greps to get a similar result. This should be
  helpful for someone updating the tests later.

- When a test can't use verify_fetch_result() (e.g. it involves other
  submodules, patch 9 adds some of these), I found it a lot easier to
  write the test using test_cmp instead of grep.

- test_cmp tests are sensitive to unmeaningful changes, but this
  behavior helps us catch unwanted regressions and (in these tests at
  least) it is relatively easy to change test_cmp tests to do the right
  thing.

[1] https://lore.kernel.org/git/220216.86y22bt8gp.gmgdl@evledraar.gmail.com
[2] https://lore.kernel.org/git/20220215172318.73533-2-chooglen@google.com
[3] https://lore.kernel.org/git/20220215220229.1633486-1-jonathantanmy@goog=
le.com

 t/t5526-fetch-submodules.sh | 117 +++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 61 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 0e93df1665..a3890e2f6c 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -13,6 +13,32 @@ export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
=20
 pwd=3D$(pwd)
=20
+check_sub() {
+	NEW_HEAD=3D$1 &&
+	cat <<-EOF >$pwd/expect.err.sub
+	Fetching submodule submodule
+	From $pwd/submodule
+	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
+	EOF
+}
+
+check_deep() {
+	NEW_HEAD=3D$1 &&
+	cat <<-EOF >$pwd/expect.err.deep
+	Fetching submodule submodule/subdir/deepsubmodule
+	From $pwd/deepsubmodule
+	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
+	EOF
+}
+
+check_super() {
+	NEW_HEAD=3D$1 &&
+	cat <<-EOF >$pwd/expect.err.super
+	From $pwd/.
+	   OLD_HEAD..$NEW_HEAD  super      -> origin/super
+	EOF
+}
+
 # For each submodule in the test setup, this creates a commit and writes
 # a file that contains the expected err if that new commit were fetched.
 # These output files get concatenated in the right order by
@@ -20,27 +46,21 @@ pwd=3D$(pwd)
 add_upstream_commit() {
 	(
 		cd submodule &&
-		head1=3D$(git rev-parse --short HEAD) &&
 		echo new >> subfile &&
 		test_tick &&
 		git add subfile &&
 		git commit -m new subfile &&
-		head2=3D$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule" > ../expect.err.sub &&
-		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
+		new_head=3D$(git rev-parse --short HEAD) &&
+		check_sub $new_head
 	) &&
 	(
 		cd deepsubmodule &&
-		head1=3D$(git rev-parse --short HEAD) &&
 		echo new >> deepsubfile &&
 		test_tick &&
 		git add deepsubfile &&
 		git commit -m new deepsubfile &&
-		head2=3D$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule/subdir/deepsubmodule" > ../expect.err=
.deep
-		echo "From $pwd/deepsubmodule" >> ../expect.err.deep &&
-		echo "   $head1..$head2  deep       -> origin/deep" >> ../expect.err.dee=
p
+		new_head=3D$(git rev-parse --short HEAD) &&
+		check_deep $new_head
 	)
 }
=20
@@ -62,7 +82,8 @@ verify_fetch_result() {
 	if [ -f expect.err.deep ]; then
 		cat expect.err.deep >>expect.err.combined
 	fi &&
-	test_cmp expect.err.combined $ACTUAL_ERR
+	sed -E 's/[0-9a-f]+\.\./OLD_HEAD\.\./' $ACTUAL_ERR >actual.err.cmp &&
+	test_cmp expect.err.combined actual.err.cmp
 }
=20
 test_expect_success setup '
@@ -274,12 +295,10 @@ test_expect_success "Recursion doesn't happen when no=
 new commits are fetched in
 '
=20
 test_expect_success "Recursion stops when no new submodule commits are fet=
ched" '
-	head1=3D$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=3D$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &=
&
+	new_head=3D$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	rm expect.err.deep &&
 	(
 		cd downstream &&
@@ -291,13 +310,11 @@ test_expect_success "Recursion stops when no new subm=
odule commits are fetched"
=20
 test_expect_success "Recursion doesn't happen when new superproject commit=
s don't change any submodules" '
 	add_upstream_commit &&
-	head1=3D$(git rev-parse --short HEAD) &&
 	echo a > file &&
 	git add file &&
 	git commit -m "new file" &&
-	head2=3D$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super =
&&
+	new_head=3D$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	rm expect.err.sub &&
 	rm expect.err.deep &&
 	(
@@ -318,12 +335,10 @@ test_expect_success "Recursion picks up config in sub=
module" '
 		)
 	) &&
 	add_upstream_commit &&
-	head1=3D$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=3D$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super =
&&
+	new_head=3D$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err &&
@@ -345,20 +360,15 @@ test_expect_success "Recursion picks up all submodule=
s when necessary" '
 			git fetch &&
 			git checkout -q FETCH_HEAD
 		) &&
-		head1=3D$(git rev-parse --short HEAD^) &&
 		git add subdir/deepsubmodule &&
 		git commit -m "new deepsubmodule" &&
-		head2=3D$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule" > ../expect.err.sub &&
-		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
+		new_head=3D$(git rev-parse --short HEAD) &&
+		check_sub $new_head
 	) &&
-	head1=3D$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=3D$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super =
&&
+	new_head=3D$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -376,13 +386,10 @@ test_expect_success "'--recurse-submodules=3Don-deman=
d' doesn't recurse when no ne
 			git fetch &&
 			git checkout -q FETCH_HEAD
 		) &&
-		head1=3D$(git rev-parse --short HEAD^) &&
 		git add subdir/deepsubmodule &&
 		git commit -m "new deepsubmodule" &&
-		head2=3D$(git rev-parse --short HEAD) &&
-		echo Fetching submodule submodule > ../expect.err.sub &&
-		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
+		new_head=3D$(git rev-parse --short HEAD) &&
+		check_sub $new_head
 	) &&
 	(
 		cd downstream &&
@@ -395,12 +402,10 @@ test_expect_success "'--recurse-submodules=3Don-deman=
d' doesn't recurse when no ne
 '
=20
 test_expect_success "'--recurse-submodules=3Don-demand' recurses as deep a=
s necessary (and ignores config)" '
-	head1=3D$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=3D$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &=
&
+	new_head=3D$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules false &&
@@ -421,13 +426,11 @@ test_expect_success "'--recurse-submodules=3Don-deman=
d' recurses as deep as necess
=20
 test_expect_success "'--recurse-submodules=3Don-demand' stops when no new =
submodule commits are found in the superproject (and ignores config)" '
 	add_upstream_commit &&
-	head1=3D$(git rev-parse --short HEAD) &&
 	echo a >> file &&
 	git add file &&
 	git commit -m "new file" &&
-	head2=3D$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super =
&&
+	new_head=3D$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	rm expect.err.sub &&
 	rm expect.err.deep &&
 	(
@@ -445,12 +448,10 @@ test_expect_success "'fetch.recurseSubmodules=3Don-de=
mand' overrides global config
 	) &&
 	add_upstream_commit &&
 	git config --global fetch.recurseSubmodules false &&
-	head1=3D$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=3D$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &=
&
+	new_head=3D$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	rm expect.err.deep &&
 	(
 		cd downstream &&
@@ -473,12 +474,10 @@ test_expect_success "'submodule.<sub>.fetchRecurseSub=
modules=3Don-demand' override
 	) &&
 	add_upstream_commit &&
 	git config fetch.recurseSubmodules false &&
-	head1=3D$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=3D$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &=
&
+	new_head=3D$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	rm expect.err.deep &&
 	(
 		cd downstream &&
@@ -499,12 +498,10 @@ test_expect_success "don't fetch submodule when newly=
 recorded commits are alrea
 		cd submodule &&
 		git checkout -q HEAD^^
 	) &&
-	head1=3D$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "submodule rewound" &&
-	head2=3D$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super =
&&
+	new_head=3D$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	rm expect.err.sub &&
 	# This file does not exist, but rm -f for readability
 	rm -f expect.err.deep &&
@@ -526,13 +523,11 @@ test_expect_success "'fetch.recurseSubmodules=3Don-de=
mand' works also without .git
 		git fetch --recurse-submodules
 	) &&
 	add_upstream_commit &&
-	head1=3D$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git rm .gitmodules &&
 	git commit -m "new submodule without .gitmodules" &&
-	head2=3D$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." >expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &=
&
+	new_head=3D$(git rev-parse --short HEAD) &&
+	check_super $new_head &&
 	rm expect.err.deep &&
 	(
 		cd downstream &&
--=20
2.33.GIT

