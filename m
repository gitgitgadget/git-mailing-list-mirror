Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB041F453
	for <e@80x24.org>; Fri, 21 Sep 2018 01:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbeIUHaZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 03:30:25 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:41201 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIUHaY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 03:30:24 -0400
Received: by mail-io1-f74.google.com with SMTP id q24-v6so16787830iog.8
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 18:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YXIo1FH1fR1mSKy0CeZwVTISsyiFVyBFWHq2lvkAPco=;
        b=MG5+LBOXjefsJvHW97tA+T2B2nLfdLvkWLqLfVrnEevQbRhJJh9QX4pj3v08hU1dwZ
         n64g5sGXmJJd6zQzIq9KqTS0KEMl20Ij6LmGRSXfcHvBguEPm9RzeAmeYnXu9VjS+FtB
         8mBJK/v7ZQIXyPMMx39Gs08QP8zz8adB3ixHtyMEAGzgb85LVDFi3TNgLYGo8dOkXEoy
         H5UjZWj9cfCygFCVxLs0Q5P/+fMm38oj2gpkDK6IXiih6L5Zge+ZJaHPzQJRlwHPvrYq
         sS7kEqysUY67BVIBljlXuvDWwnl910ncmN7IhmV/AVIjuoNgJPDSKXmd8tIa3ol4tsWY
         s5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YXIo1FH1fR1mSKy0CeZwVTISsyiFVyBFWHq2lvkAPco=;
        b=iNpje3YEV3wHD/y0B2PNS5QRJb8frqTFbac9P8YHkyJdJJWG/+RtEZ29pul2uGGhA9
         Z9Qh4HTnvKpccDdIH/ITNN2BzVImiRIxafUYk8rO8Q5Y/ANZmDbrHKkQHCtbfGvQJ3vU
         Tl5N3rkxJFxkJTpIwQzuZNSR+Jnl0OouPanK7E0Mk81IlKYGL6e3A+04lMsfN3+kysUb
         GK1QuQ8Q2Y5UWD4H9NYLwg7bHiQd74+H9RSBErvw9wP+Rsapq5bwlQ1T6Rbbv11rxbEZ
         XCFt/0IM8O9iY5kJf6ScOGr2PdXXvfOcyCBF7whjiWBt0KnQtqlbnHsMf1YC7cvUTTN5
         qa9g==
X-Gm-Message-State: APzg51Aaq3gkkXs/OV65qxZfzBiNf+r8akZhkr+VsWCqRR0xQ+qL4v5X
        enkDSF6In2hpbJrwGX9oJDR+sZuhugsA7sbYlFuSv42233EkTr9u79J/PxL8h8zT8ip0RQyarsU
        aURL/CDCNSNg2DRYPLcGkgoQryvisPg1eNp9SJyHcohavXeylPAt2/PydZhI=
X-Google-Smtp-Source: ANB0VdaeDKbt3OtchrNHKMpReEY6NlndJu1Zn35bmBaZFf3rgUk6efxJd6bGOIwraHFOC/IHN+rcVzehgznS
X-Received: by 2002:a5e:9901:: with SMTP id t1-v6mr33357512ioj.41.1537494239990;
 Thu, 20 Sep 2018 18:43:59 -0700 (PDT)
Date:   Thu, 20 Sep 2018 18:43:31 -0700
In-Reply-To: <cover.1537493611.git.matvore@google.com>
Message-Id: <52456f96545d2034b1fe01f4ae82fe9b75ff6c4c.1537493611.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537493611.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v3 5/5] t9109: don't swallow Git errors upstream of pipes
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git ... | foo' will mask any errors or crashes in git, so split up such
pipes in this file.

One testcase uses several separate pipe sequences in a row which are
awkward to split up. Wrap the split-up pipe in a function so the
awkwardness is not repeated. Also change that testcase's surrounding
quotes from double to single to avoid premature string interpolation.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 t/t9101-git-svn-props.sh | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 8cba331fc..c26c4b092 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -190,17 +190,21 @@ EOF
 # This test can be improved: since all the svn:ignore contain the same
 # pattern, it can pass even though the propget did not execute on the
 # right directory.
-test_expect_success 'test propget' "
-	git svn propget svn:ignore . | cmp - prop.expect &&
+test_expect_success 'test propget' '
+	test_propget () {
+		git svn propget $1 $2 >actual &&
+		cmp $3 actual
+	} &&
+	test_propget svn:ignore . prop.expect &&
 	cd deeply &&
-	git svn propget svn:ignore . | cmp - ../prop.expect &&
-	git svn propget svn:entry:committed-rev nested/directory/.keep \
-	  | cmp - ../prop2.expect &&
-	git svn propget svn:ignore .. | cmp - ../prop.expect &&
-	git svn propget svn:ignore nested/ | cmp - ../prop.expect &&
-	git svn propget svn:ignore ./nested | cmp - ../prop.expect &&
-	git svn propget svn:ignore .././deeply/nested | cmp - ../prop.expect
-	"
+	test_propget svn:ignore . ../prop.expect &&
+	test_propget svn:entry:committed-rev nested/directory/.keep \
+		../prop2.expect &&
+	test_propget svn:ignore .. ../prop.expect &&
+	test_propget svn:ignore nested/ ../prop.expect &&
+	test_propget svn:ignore ./nested ../prop.expect &&
+	test_propget svn:ignore .././deeply/nested ../prop.expect
+	'
 
 cat >prop.expect <<\EOF
 Properties on '.':
@@ -219,8 +223,11 @@ Properties on 'nested/directory/.keep':
 EOF
 
 test_expect_success 'test proplist' "
-	git svn proplist . | cmp - prop.expect &&
-	git svn proplist nested/directory/.keep | cmp - prop2.expect
+	git svn proplist . >actual &&
+	cmp prop.expect actual &&
+
+	git svn proplist nested/directory/.keep >actual &&
+	cmp prop2.expect actual
 	"
 
 test_done
-- 
2.19.0.444.g18242da7ef-goog

