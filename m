Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B4CC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3896221E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCNKAo1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgHFUJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFUJM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 16:09:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CF8C061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 13:09:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s9so26801615lfs.4
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 13:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zm3JeK5YMFu0alNKS9A3w5g1ygMEMumrbHQKgIFQmOg=;
        b=nCNKAo1gV9D3a1RmXjBO6LvqdHnFTA40tX7Fyp9kbXC/FP+r1UvW+jbPDnQgjSNj4b
         DsSbv1lByU4aQ5LBRJCTAhoDwnr3EyoDO1/Bnl6l2NK9DIND66EVuNc7zxNx19huATg8
         VuyyBLIp/PXyqx3HD1yjE9hsn7V8tx2HefzUUqb7wSVbce2XmqsWC6t0zXeuNL6D4M1s
         dPRu3E05Xesl1P3CCdz/QVHELkElRwVfr36Qb3Tn7IR5LovZ76/1ZDjHU2fARvM1bvZH
         VAwp+I0hnOf3zZ66ntuoUYCqgbsrg/Hwpjw2G8+1M0CIwmJQOW8PK3cMd1qr1IxeBa/k
         p69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zm3JeK5YMFu0alNKS9A3w5g1ygMEMumrbHQKgIFQmOg=;
        b=ZURiU+sPhwH7qEHd6Compc1/zs8bD5YHf2dR9ipEiOJ0sNOtCJGmmfEDSwfD5NjFtk
         iDDM0z01QSbawv9zrBecmIZXk6ApXbrhbdjiiWQbDkBtS6Mhdw/s4l3updYlOoGEFXvM
         QpbzzIFPbGxvAitmzdQnX39bjGCfaoUQyL7eKvc4Cuj5CFGavVSED9ibMDqe4t19SI07
         lBTw82/TKOrFzFUYwoqXC4+jVtGSfuk07kwV983rDGMY14w0Gs8Nb4S5WTujWkjtz5YN
         4qN0RU0Qb2+lnEaVgKrZ15E0yVsw7CPBMKkUBfJfO7gzOvxuf2UMoxMJGza9DvLhEd+M
         w9Dg==
X-Gm-Message-State: AOAM531ej08rdAi25lYmO4znxPOt0N9IxSmszLBaC9yrf5QhLAsxITzb
        l0bZotatx1TIaCbjuYOR8fGuqSxG
X-Google-Smtp-Source: ABdhPJyqfe4l2DMNEovhj271KAXPmuhyN6CqglMhTd5qwPhk19NO9HxnV9nEBrR+uyYcuZMa/L193A==
X-Received: by 2002:ac2:5933:: with SMTP id v19mr4678736lfi.94.1596744549216;
        Thu, 06 Aug 2020 13:09:09 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id k84sm3436130lfd.90.2020.08.06.13.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 13:09:08 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: [PATCH v2 1/2] t: don't spuriously close and reopen quotes
Date:   Thu,  6 Aug 2020 22:08:53 +0200
Message-Id: <c60416a111bada9624b8b64235ac5c4dd3dedac4.1596742823.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.199.g4234a9100e
In-Reply-To: <cover.1596742823.git.martin.agren@gmail.com>
References: <20200802143018.5501-1-martin.agren@gmail.com> <cover.1596742823.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the test scripts, the recommended style is, e.g.:

    test_expect_success 'name' '
        do-something somehow &&
        do-some-more testing
    '

When using this style, any single quote in the multi-line test section
is actually closing the lone single quotes that surround it.

It can be a non-issue in practice:

    test_expect_success 'sed a little' '
        sed -e 's/hi/lo/' in >out # "ok": no whitespace in s/hi/lo/
    '

Or it can be a bug in the test, e.g., because variable interpolation
happens before the test even begins executing:

    v=abc

    test_expect_success 'variable interpolation' '
        v=def &&
        echo '"$v"' # abc
    '

Change several such in-test single quotes to use double quotes instead
or, in a few cases, drop them altogether. These were identified using
some crude grepping. We're not fixing any test bugs here, but we're
hopefully making these tests slightly easier to grok and to maintain.

There are legitimate use cases for closing a quote and opening a new
one, e.g., both '\'' and '"'"' can be used to produce a literal single
quote. I'm not touching any of those here.

In t9401, tuck the redirecting ">" to the filename while we're touching
those lines.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t1400-update-ref.sh           |  2 +-
 t/t3501-revert-cherry-pick.sh   |  4 ++--
 t/t3507-cherry-pick-conflict.sh |  4 ++--
 t/t4005-diff-rename-2.sh        |  4 ++--
 t/t4034-diff-words.sh           |  2 +-
 t/t4150-am.sh                   |  8 ++++----
 t/t4200-rerere.sh               |  2 +-
 t/t5302-pack-index.sh           |  2 +-
 t/t5510-fetch.sh                |  4 ++--
 t/t5553-set-upstream.sh         |  6 +++---
 t/t6026-merge-attr.sh           |  4 ++--
 t/t7001-mv.sh                   |  2 +-
 t/t7600-merge.sh                |  6 +++---
 t/t9001-send-email.sh           | 10 +++++-----
 t/t9100-git-svn-basic.sh        |  6 +++---
 t/t9401-git-cvsserver-crlf.sh   |  8 ++++----
 t/t9402-git-cvsserver-refs.sh   |  2 +-
 17 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 27171f8261..d0d36750bc 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -324,7 +324,7 @@ test_expect_success "create $m (logged by config)" '
 test_expect_success "update $m (logged by config)" '
 	test_config core.logAllRefUpdates true &&
 	GIT_COMMITTER_DATE="2005-05-26 23:33" \
-	git update-ref HEAD'" $B $A "'-m "Switch" &&
+	git update-ref HEAD $B $A -m "Switch" &&
 	test $B = $(git show-ref -s --verify $m)
 '
 test_expect_success "set $m (logged by config)" '
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 7c1da21df1..3669dfb1be 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -47,7 +47,7 @@ test_expect_success 'cherry-pick --nonsense' '
 	git diff --exit-code HEAD &&
 	test_must_fail git cherry-pick --nonsense 2>msg &&
 	git diff --exit-code HEAD "$pos" &&
-	test_i18ngrep '[Uu]sage:' msg
+	test_i18ngrep "[Uu]sage:" msg
 '
 
 test_expect_success 'revert --nonsense' '
@@ -56,7 +56,7 @@ test_expect_success 'revert --nonsense' '
 	git diff --exit-code HEAD &&
 	test_must_fail git revert --nonsense 2>msg &&
 	git diff --exit-code HEAD "$pos" &&
-	test_i18ngrep '[Uu]sage:' msg
+	test_i18ngrep "[Uu]sage:" msg
 '
 
 test_expect_success 'cherry-pick after renaming branch' '
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 752bc43487..f107622a9e 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -512,7 +512,7 @@ test_expect_success 'commit after failed cherry-pick adds -s at the right place'
 	Signed-off-by: C O Mitter <committer@example.com>
 	# Conflicts:
 	EOF
-	grep -e "^# Conflicts:" -e '^Signed-off-by' .git/COMMIT_EDITMSG >actual &&
+	grep -e "^# Conflicts:" -e "^Signed-off-by" .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual &&
 
 	cat <<-\EOF >expected &&
@@ -541,7 +541,7 @@ test_expect_success 'commit --amend -s places the sign-off at the right place' '
 	Signed-off-by: C O Mitter <committer@example.com>
 	Conflicts:
 	EOF
-	grep -e "^Conflicts:" -e '^Signed-off-by' .git/COMMIT_EDITMSG >actual &&
+	grep -e "^Conflicts:" -e "^Signed-off-by" .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
index f542d2929d..d18a80493c 100755
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -14,8 +14,8 @@ test_expect_success 'setup reference tree' '
 	git update-index --add COPYING rezrov &&
 	tree=$(git write-tree) &&
 	echo $tree &&
-	sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
-	sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
+	sed -e "s/HOWEVER/However/" <COPYING >COPYING.1 &&
+	sed -e "s/GPL/G.P.L/g" <COPYING >COPYING.2 &&
 	origoid=$(git hash-object COPYING) &&
 	oid1=$(git hash-object COPYING.1) &&
 	oid2=$(git hash-object COPYING.2)
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index fb145aa173..0c8fb39ced 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -102,7 +102,7 @@ test_expect_success 'word diff with runs of whitespace' '
 '
 
 test_expect_success '--word-diff=porcelain' '
-	sed 's/#.*$//' >expect <<-EOF &&
+	sed "s/#.*$//" >expect <<-EOF &&
 		diff --git a/pre b/post
 		index $pre..$post 100644
 		--- a/pre
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index bda4586a79..855ed11b32 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -989,7 +989,7 @@ test_expect_success 'am -s unexpected trailer block' '
 	Signed-off-by: J C H <j@c.h>
 	EOF
 	git commit -F msg &&
-	git cat-file commit HEAD | sed -e '1,/^$/d' >original &&
+	git cat-file commit HEAD | sed -e "1,/^$/d" >original &&
 	git format-patch --stdout -1 >patch &&
 
 	git reset --hard HEAD^ &&
@@ -998,7 +998,7 @@ test_expect_success 'am -s unexpected trailer block' '
 		cat original &&
 		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 	) >expect &&
-	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
 	test_cmp expect actual &&
 
 	cat >msg <<-\EOF &&
@@ -1009,7 +1009,7 @@ test_expect_success 'am -s unexpected trailer block' '
 	EOF
 	git reset HEAD^ &&
 	git commit -F msg file &&
-	git cat-file commit HEAD | sed -e '1,/^$/d' >original &&
+	git cat-file commit HEAD | sed -e "1,/^$/d" >original &&
 	git format-patch --stdout -1 >patch &&
 
 	git reset --hard HEAD^ &&
@@ -1020,7 +1020,7 @@ test_expect_success 'am -s unexpected trailer block' '
 		echo &&
 		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 	) >expect &&
-	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 831d424c47..f99385c191 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -364,7 +364,7 @@ test_expect_success 'set up an unresolved merge' '
 	git reset --hard &&
 	git checkout version2 &&
 	fifth=$(git rev-parse fifth) &&
-	echo "$fifth		branch 'fifth' of ." |
+	echo "$fifth		branch fifth of ." |
 	git fmt-merge-msg >msg &&
 	ancestor=$(git merge-base version2 fifth) &&
 	test_must_fail git merge-recursive "$ancestor" -- HEAD fifth &&
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 8981c9b90e..d1a6a3c37a 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -15,7 +15,7 @@ test_expect_success 'setup' '
 	i=1 &&
 	while test $i -le 100
 	do
-		iii=$(printf '%03i' $i)
+		iii=$(printf "%03i" $i)
 		test-tool genrandom "bar" 200 > wide_delta_$iii &&
 		test-tool genrandom "baz $iii" 50 >> wide_delta_$iii &&
 		test-tool genrandom "foo"$i 100 > deep_delta_$iii &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a66dbe0bde..6cb954e2f0 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -213,7 +213,7 @@ test_expect_success 'fetch tags when there is no tags' '
 test_expect_success 'fetch following tags' '
 
 	cd "$D" &&
-	git tag -a -m 'annotated' anno HEAD &&
+	git tag -a -m "annotated" anno HEAD &&
 	git tag light HEAD &&
 
 	mkdir four &&
@@ -331,7 +331,7 @@ test_expect_success 'bundle does not prerequisite objects' '
 test_expect_success 'bundle should be able to create a full history' '
 
 	cd "$D" &&
-	git tag -a -m '1.0' v1.0 master &&
+	git tag -a -m "1.0" v1.0 master &&
 	git bundle create bundle4 v1.0
 
 '
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index 81975ad8f9..7622981cbf 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -81,7 +81,7 @@ test_expect_success 'fetch --set-upstream http://nosuchdomain.example.com fails
 
 test_expect_success 'fetch --set-upstream with valid URL sets upstream to URL' '
 	clear_config other other2 &&
-	url="file://'"$PWD"'" &&
+	url="file://$PWD" &&
 	git fetch --set-upstream "$url" &&
 	check_config master "$url" HEAD &&
 	check_config_missing other &&
@@ -158,7 +158,7 @@ test_expect_success 'pull --set-upstream upstream with more than one branch does
 test_expect_success 'pull --set-upstream with valid URL sets upstream to URL' '
 	clear_config master other other2 &&
 	git checkout master &&
-	url="file://'"$PWD"'" &&
+	url="file://$PWD" &&
 	git pull --set-upstream "$url" &&
 	check_config master "$url" HEAD &&
 	check_config_missing other &&
@@ -168,7 +168,7 @@ test_expect_success 'pull --set-upstream with valid URL sets upstream to URL' '
 test_expect_success 'pull --set-upstream with valid URL and branch sets branch' '
 	clear_config master other other2 &&
 	git checkout master &&
-	url="file://'"$PWD"'" &&
+	url="file://$PWD" &&
 	git pull --set-upstream "$url" master &&
 	check_config master "$url" refs/heads/master &&
 	check_config_missing other &&
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 5900358ce9..76a55f838c 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -122,7 +122,7 @@ test_expect_success 'custom merge backend' '
 	o=$(git unpack-file master^:text) &&
 	a=$(git unpack-file side^:text) &&
 	b=$(git unpack-file master:text) &&
-	sh -c "./custom-merge $o $a $b 0 'text'" &&
+	sh -c "./custom-merge $o $a $b 0 text" &&
 	sed -e 1,3d $a >check-2 &&
 	cmp check-1 check-2 &&
 	rm -f $o $a $b
@@ -149,7 +149,7 @@ test_expect_success 'custom merge backend' '
 	o=$(git unpack-file master^:text) &&
 	a=$(git unpack-file anchor:text) &&
 	b=$(git unpack-file master:text) &&
-	sh -c "./custom-merge $o $a $b 0 'text'" &&
+	sh -c "./custom-merge $o $a $b 0 text" &&
 	sed -e 1,3d $a >check-2 &&
 	cmp check-1 check-2 &&
 	sed -e 1,3d -e 4q $a >check-3 &&
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 36b50d0b4c..b64b736d2f 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -177,7 +177,7 @@ test_expect_success "Sergey Vlasov's test case" '
 	date >ab.c &&
 	date >ab/d &&
 	git add ab.c ab &&
-	git commit -m 'initial' &&
+	git commit -m "initial" &&
 	git mv ab a
 '
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 1d45f9a4ed..dffcf053db 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -246,7 +246,7 @@ test_expect_success 'merge --squash c3 with c7' '
 	#	file
 	EOF
 	git cat-file commit HEAD >raw &&
-	sed -e '1,/^$/d' raw >actual &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_cmp expect actual
 '
 
@@ -268,7 +268,7 @@ test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
 	#	file
 	EOF
 	git cat-file commit HEAD >raw &&
-	sed -e '1,/^$/d' raw >actual &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_i18ncmp expect actual
 '
 
@@ -292,7 +292,7 @@ test_expect_success 'merge c3 with c7 with --squash commit.cleanup = scissors' '
 	#	file
 	EOF
 	git cat-file commit HEAD >raw &&
-	sed -e '1,/^$/d' raw >actual &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_i18ncmp expect actual
 '
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ec261085ec..3d68570450 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1551,7 +1551,7 @@ test_expect_success $PREREQ '8-bit and sendemail.transferencoding=quoted-printab
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-8bit \
 		2>errors >out &&
-	sed '1,/^$/d' msgtxt1 >actual &&
+	sed "1,/^$/d" msgtxt1 >actual &&
 	test_cmp expected actual
 '
 
@@ -1568,7 +1568,7 @@ test_expect_success $PREREQ '8-bit and sendemail.transferencoding=base64' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-8bit \
 		2>errors >out &&
-	sed '1,/^$/d' msgtxt1 >actual &&
+	sed "1,/^$/d" msgtxt1 >actual &&
 	test_cmp expected actual
 '
 
@@ -1594,7 +1594,7 @@ test_expect_success $PREREQ 'convert from quoted-printable to base64' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-qp \
 		2>errors >out &&
-	sed '1,/^$/d' msgtxt1 >actual &&
+	sed "1,/^$/d" msgtxt1 >actual &&
 	test_cmp expected actual
 '
 
@@ -1624,7 +1624,7 @@ test_expect_success $PREREQ 'CRLF and sendemail.transferencoding=quoted-printabl
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-crlf \
 		2>errors >out &&
-	sed '1,/^$/d' msgtxt1 >actual &&
+	sed "1,/^$/d" msgtxt1 >actual &&
 	test_cmp expected actual
 '
 
@@ -1641,7 +1641,7 @@ test_expect_success $PREREQ 'CRLF and sendemail.transferencoding=base64' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-crlf \
 		2>errors >out &&
-	sed '1,/^$/d' msgtxt1 >actual &&
+	sed "1,/^$/d" msgtxt1 >actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 9f2d19ecc4..e9c575c359 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -63,16 +63,16 @@ test_expect_success "$name" '
 
 
 name='detect node change from file to directory #1'
-test_expect_success "$name" "
+test_expect_success "$name" '
 	mkdir dir/new_file &&
 	mv dir/file dir/new_file/file &&
 	mv dir/new_file dir/file &&
 	git update-index --remove dir/file &&
 	git update-index --add dir/file/file &&
-	git commit -m '$name' &&
+	git commit -m "$name" &&
 	test_must_fail git svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch
-"
+'
 
 
 name='detect node change from directory to file #1'
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 84787eee9a..c7a0dd84a4 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -167,10 +167,10 @@ test_expect_success 'adding files' '
 
 test_expect_success 'updating' '
     git pull gitcvs.git &&
-    echo 'hi' > subdir/newfile.bin &&
-    echo 'junk' > subdir/file.h &&
-    echo 'hi' > subdir/newfile.c &&
-    echo 'hello' >> binfile.bin &&
+    echo "hi" >subdir/newfile.bin &&
+    echo "junk" >subdir/file.h &&
+    echo "hi" >subdir/newfile.c &&
+    echo "hello" >>binfile.bin &&
     git add subdir/newfile.bin subdir/file.h subdir/newfile.c binfile.bin &&
     git commit -q -m "Add and change some files" &&
     git push gitcvs.git >/dev/null &&
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index cf31ace667..6436c91a3c 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -178,7 +178,7 @@ test_expect_success 'setup v1.2 on b1' '
 	mkdir cdir &&
 	echo "cdir/cfile" >cdir/cfile &&
 	git add -A cdir adir t3 t2 &&
-	git commit -q -m 'v1.2' &&
+	git commit -q -m "v1.2" &&
 	git tag v1.2 &&
 	git push --tags gitcvs.git b1:b1
 '
-- 
2.28.0.199.g4234a9100e

