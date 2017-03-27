Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8971D20966
	for <e@80x24.org>; Mon, 27 Mar 2017 11:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbdC0LYi (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 07:24:38 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34147 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbdC0LYg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 07:24:36 -0400
Received: by mail-wr0-f176.google.com with SMTP id l43so51661192wre.1
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 04:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I4xJzGrivLKoVkwoKegoCyl5RiQ2ieDPihTwt07lvKY=;
        b=ro2J6a6fImLj+JHEPcpUFG44IkRw3HobmSDbOftc5DCNaG2bvXWo23K27n3y5g4hfd
         LhL21+JXf7FyZwdxDqw3HFT38Oph3jYiCZULud68zNW8YkX0WbTG6Duy+FnSXVOWNVBe
         zXwz9j6Bm0fNSr394DxX66sh7SF01DWoA/LY33rQpr5ycJFzZQPErOqieBN9TNZTTzbW
         RZhQbO2KeSYHwUYoYBjTq9m3nkUaqPXVGDxNDmQbebU9SX2nGcCrCryPTJ3qA8fcB1cT
         4izRN4J5+Fb6QfUTHBq9xbiAb6kT8uONxuVZDRohqLzpCX2iM+xT6l+PzvdMPTx6FFBk
         bvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I4xJzGrivLKoVkwoKegoCyl5RiQ2ieDPihTwt07lvKY=;
        b=W5WgITibWlAMKpEaelobgjMg4J87Fv1RF6wnmWFpEgHzH798br/k6XoQ6QH0K9NFEX
         ZKgXBo+429iBSvmMRDLHmgHJwwgtOdXjWui62aKdomMID2LTLTzRel7OkqX1tvFUXdqo
         XmsPZB9LwniKZMHk8SIVSGuIA+B0qPI11luKMq1kMddeE/bnH+r5axc9tMJi5jmvY5sD
         Q21s1vMx9hfznWzjK9qIQ0x/iDP/AlCgc4/MOM4Nu6u1ngZkhHMp9rc3vIeLhasXt+8D
         vKSmvBT/soXaaqPgQtEzLZ94GEl4FZPjENy7X60QYrJUez+a1OlAKj0HNioF1zUStkgk
         ShZQ==
X-Gm-Message-State: AFeK/H2v2SpjB8XV/EBBHbaMPxgkPfTPgx5Pkjf3Wbsxsc7cnEDFqzL8rOHpzrqU902/Lg==
X-Received: by 10.223.164.85 with SMTP id e21mr20098641wra.58.1490613428680;
        Mon, 27 Mar 2017 04:17:08 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i130sm411215wmf.26.2017.03.27.04.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Mar 2017 04:17:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] rev-parse: match @{upstream}, @{u} and @{push} case-insensitively
Date:   Mon, 27 Mar 2017 11:16:55 +0000
Message-Id: <20170327111655.29941-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqqa8874l8t.fsf@gitster.mtv.corp.google.com>
References: <xmqqa8874l8t.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the revision parsing logic to match @{upstream}, @{u} & @{push}
case-insensitively.

Before this change supplying anything except the lower-case forms
emits an "unknown revision or path not in the working tree"
error. This change makes upper-case & mixed-case versions equivalent
to the lower-case versions.

The use-case for this is being able to hold the shift key down while
typing @{u} on certain keyboard layouts, which makes the sequence
easier to type, and reduces cases where git throws an error at the
user where it could do what he means instead.

These suffixes now join various other suffixes & special syntax
documented in gitrevisions(7) that matches case-insensitively. A table
showing the status of the various forms documented there before &
after this patch is shown below. The key for the table is:

 - CI  = Case Insensitive
 - CIP = Case Insensitive Possible (without ambiguities)
 - AG  = Accepts Garbage (.e.g. @{./.4.minutes./.})

Before this change:

    |----------------+-----+------+-----|
    | What?          | CI? | CIP? | AG? |
    |----------------+-----+------+-----|
    | sha1           | Y   | -    | N   |
    | describeOutput | N   | N    | N   |
    | refname        | N   | N    | N   |
    | @{<date>}      | Y   | Y    | Y   |
    | @{<n>}         | N/A | N/A  | N   |
    | @{-<n>}        | N/A | N/A  | N   |
    | @{upstream}    | N   | Y    | N   |
    | @{push}        | N   | Y    | N   |
    | ^{<type>}      | N   | Y    | N   |
    | ^{/regex}      | N   | N    | N   |
    |----------------+-----+------+-----|

After it:

    |----------------+-----+------+-----|
    | What?          | CI? | CIP? | AG? |
    |----------------+-----+------+-----|
    | sha1           | Y   | -    | N   |
    | describeOutput | N   | N    | N   |
    | refname        | N   | N    | N   |
    | @{<date>}      | Y   | Y    | Y   |
    | @{<n>}         | N/A | N/A  | N   |
    | @{-<n>}        | N/A | N/A  | N   |
    | @{upstream}    | Y   | -    | N   |
    | @{push}        | Y   | -    | N   |
    | ^{<type>}      | N   | Y    | N   |
    | ^{/regex}      | N   | N    | N   |
    |----------------+-----+------+-----|

The ^{<type>} suffix is not made case-insensitive, because other
places that take <type> like "cat-file -t <type>" do want them case
sensitively (after all we never declared that type names are case
insensitive). Allowing case-insensitive typename only with this syntax
will make the resulting Git as a whole inconsistent.

This change was independently authored to scratch a longtime itch, but
when I was about to submit it I discovered that a similar patch had
been submitted unsuccessfully before by Conrad Irwin in August 2011 as
"rev-parse: Allow @{U} as a synonym for
@{u}" (<1313287071-7851-1-git-send-email-conrad.irwin@gmail.com>).

The tests for this patch are more exhaustive than in the 2011
submission. The starting point for them was to first change the code
to only support upper-case versions of the existing words, seeing what
broke, and amending the breaking tests to check upper case & mixed
case as appropriate, and where not redundant to other similar
tests. The implementation itself is equivalent.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Mon, Mar 27, 2017 at 2:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> The ^{<type>} suffix could be changed to be case-insensitive as well
>> without introducing any ambiguities. That was included in an earlier
>> version of this patch, but Junio objected to its inclusion in [2].
>
> We try not to be personal in our log message.  It's not like my
> objection weighs heavier than objections from others.  The same
> number of bytes in the log message can better to spent to allow
> readers of "git log" independently to judge the rationle without
> referring to external material.

FWIW I just cited it because you went into a lot more detail in your
message, and thought I'd link to it in lieu of trying to paraphrase it
at even greater length.

> Perhaps replace this entire paragraph, including the URL in [2],
> with something like
>
>     The ^{type} suffix is not made case-insensitive, because other
>     places that take <type> like "cat-file -t <type>" do want them
>     case sensitively (after all we never declared that type names
>     are case insensitive). Allowing case-insensitive typename only
>     with this syntax will make the resulting Git as a whole
>     inconsistent.
>
> Other than that, the change to the code and the new tests all makes
> sense to me.

Makes sense, replaced that note with that summary. Here's hopefully a
final v3 with that change. I've omitted the other two patches as noted
in the discussion about those two, I don't think it makes sense to
include them.

 Documentation/revisions.txt   |  6 +++++-
 sha1_name.c                   |  2 +-
 t/t1507-rev-parse-upstream.sh | 15 +++++++++++----
 t/t1514-rev-parse-push.sh     |  8 ++++++--
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index ba11b9c95e..09e0d51b9e 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -96,7 +96,8 @@ some output processing may assume ref names in UTF-8.
   refers to the branch that the branch specified by branchname is set to build on
   top of (configured with `branch.<name>.remote` and
   `branch.<name>.merge`).  A missing branchname defaults to the
-  current one.
+  current one. These suffixes are accepted when spelled in uppercase, and
+  they mean the same thing no matter the case.
 
 '<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
   The suffix '@\{push}' reports the branch "where we would push to" if
@@ -122,6 +123,9 @@ refs/remotes/myfork/mybranch
 Note in the example that we set up a triangular workflow, where we pull
 from one location and push to another. In a non-triangular workflow,
 '@\{push}' is the same as '@\{upstream}', and there is no need for it.
++
+This suffix is accepted when spelled in uppercase, and means the same
+thing no matter the case.
 
 '<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
diff --git a/sha1_name.c b/sha1_name.c
index cda9e49b12..d9d1b2fce8 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -549,7 +549,7 @@ static inline int at_mark(const char *string, int len,
 	for (i = 0; i < nr; i++) {
 		int suffix_len = strlen(suffix[i]);
 		if (suffix_len <= len
-		    && !memcmp(string, suffix[i], suffix_len))
+		    && !strncasecmp(string, suffix[i], suffix_len))
 			return suffix_len;
 	}
 	return 0;
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 46ef1f22dc..b23c4e3fab 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -46,11 +46,14 @@ error_message () {
 }
 
 test_expect_success '@{upstream} resolves to correct full name' '
-	test refs/remotes/origin/master = "$(full_name @{upstream})"
+	test refs/remotes/origin/master = "$(full_name @{upstream})" &&
+	test refs/remotes/origin/master = "$(full_name @{UPSTREAM})" &&
+	test refs/remotes/origin/master = "$(full_name @{UpSTReam})"
 '
 
 test_expect_success '@{u} resolves to correct full name' '
-	test refs/remotes/origin/master = "$(full_name @{u})"
+	test refs/remotes/origin/master = "$(full_name @{u})" &&
+	test refs/remotes/origin/master = "$(full_name @{U})"
 '
 
 test_expect_success 'my-side@{upstream} resolves to correct full name' '
@@ -60,6 +63,8 @@ test_expect_success 'my-side@{upstream} resolves to correct full name' '
 test_expect_success 'upstream of branch with @ in middle' '
 	full_name fun@ny@{u} >actual &&
 	echo refs/remotes/origin/side >expect &&
+	test_cmp expect actual &&
+	full_name fun@ny@{U} >actual &&
 	test_cmp expect actual
 '
 
@@ -96,12 +101,14 @@ test_expect_success 'not-tracking@{u} fails' '
 test_expect_success '<branch>@{u}@{1} resolves correctly' '
 	test_commit 6 &&
 	(cd clone && git fetch) &&
-	test 5 = $(commit_subject my-side@{u}@{1})
+	test 5 = $(commit_subject my-side@{u}@{1}) &&
+	test 5 = $(commit_subject my-side@{U}@{1})
 '
 
 test_expect_success '@{u} without specifying branch fails on a detached HEAD' '
 	git checkout HEAD^0 &&
-	test_must_fail git rev-parse @{u}
+	test_must_fail git rev-parse @{u} &&
+	test_must_fail git rev-parse @{U}
 '
 
 test_expect_success 'checkout -b new my-side@{u} forks from the same' '
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index 623a32aa6e..788cc91e45 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -24,12 +24,16 @@ test_expect_success 'setup' '
 
 test_expect_success '@{push} with default=nothing' '
 	test_config push.default nothing &&
-	test_must_fail git rev-parse master@{push}
+	test_must_fail git rev-parse master@{push} &&
+	test_must_fail git rev-parse master@{PUSH} &&
+	test_must_fail git rev-parse master@{PuSH}
 '
 
 test_expect_success '@{push} with default=simple' '
 	test_config push.default simple &&
-	resolve master@{push} refs/remotes/origin/master
+	resolve master@{push} refs/remotes/origin/master &&
+	resolve master@{PUSH} refs/remotes/origin/master &&
+	resolve master@{pUSh} refs/remotes/origin/master
 '
 
 test_expect_success 'triangular @{push} fails with default=simple' '
-- 
2.11.0

