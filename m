Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650D420958
	for <e@80x24.org>; Sun, 26 Mar 2017 12:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdCZMRF (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 08:17:05 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32970 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdCZMRE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 08:17:04 -0400
Received: by mail-wr0-f195.google.com with SMTP id 20so4912469wrx.0
        for <git@vger.kernel.org>; Sun, 26 Mar 2017 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eT08us2NYFxdl65SxjCETZa63njU7ep7Sfji2koZebY=;
        b=j1Dii7xubWJx0ugP2NhmNKZ2B28NnKgLu/ZuQGssiodCAzEp109w6wbR7L7gJSjFFF
         3WjiA00R+UtoyK3E7BIO/cThqX4rcNJjqU3X9ItHUzms8p3fZkZgdq1DMXqY5olMiyqC
         EGwyCZAwAGeM/3pGzitNx0+urgkyX3QxHqzuw4kM6HFUQp2qxRRvLx//pm1U4yYe69t0
         PNUrW1CggfCDFDd70spsQ1WS1cVGCb516xJL9RD+5cVRfIrXtOtqg8LgM1t6lgWQ2Vnn
         MdqxxrAnXH3eEdox5UgoWuTTM7ZSrQveNnfLPXE2yiKX+5Z7RnWAtzWgvoBWm1kMwntp
         FAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eT08us2NYFxdl65SxjCETZa63njU7ep7Sfji2koZebY=;
        b=YQWi4vpULZo3ERnbXYGQ3/aTOgIWNTpcaaJfHEZcOlQYJPQUE+nVC9TwivxSNPMGfX
         s4B01mi33VbaIz3uRDSQO1vLh5y3A31ceuml2Mck/G3ZUq4G1Y9Pqdd3um7Rm+zMk+WE
         fOoH27FWkb1Hd/FsFUzNFHsbLz1SefDR+AFIk8AgUGv88pIXx25W+QJ4fk/+HMbFZ8Eh
         wyv1V6FuwbTaJoGWKNkK3beTz2spZLVcWSrJQO61kq8C630goOU6iSglaPK3RsXta/zL
         zHfo/quRiyqPxV8l3whltgnbm3XfkXLqjKqyJk6jZcatHs4Oh5HSJPuIKAXggDn70Kym
         mf+Q==
X-Gm-Message-State: AFeK/H1W4qLb3jBJgKiOmoNUxORK46WvC1mKoDL7Bcu6gcRnqRuuA8+iYdB+HSYNPjpojA==
X-Received: by 10.223.135.252 with SMTP id c57mr15978201wrc.109.1490530622133;
        Sun, 26 Mar 2017 05:17:02 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 134sm10167638wmj.6.2017.03.26.05.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Mar 2017 05:17:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] rev-parse: match @{upstream}, @{u} and @{push} case-insensitively
Date:   Sun, 26 Mar 2017 12:16:52 +0000
Message-Id: <20170326121654.22035-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170326121654.22035-1-avarab@gmail.com>
References: <20170326121654.22035-1-avarab@gmail.com>
In-Reply-To: <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
References: <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
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

The ^{<type>} suffix could be changed to be case-insensitive as well
without introducing any ambiguities. That was included in an earlier
version of this patch, but Junio objected to its inclusion in [2].

This change was independently authored to scratch a longtime itch, but
when I was about to submit it I discovered that a similar patch had
been submitted unsuccessfully before by Conrad Irwin in August 2011 as
"rev-parse: Allow @{U} as a synonym for @{u}"[1].

The tests for this patch are more exhaustive than in the 2011
submission. The starting point for them was to first change the code
to only support upper-case versions of the existing words, seeing what
broke, and amending the breaking tests to check upper case & mixed
case as appropriate, and where not redundant to other similar
tests. The implementation itself is equivalent.

1. <1313287071-7851-1-git-send-email-conrad.irwin@gmail.com>
2. <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
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

