Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E33C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41706615E2
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhKSOyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhKSOyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 09:54:16 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A0EC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 06:51:14 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso17145903ots.6
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 06:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vQcmpQjbKtJK6jCEHAzRxaj4cUE3MqPaGDEkDFS+C0k=;
        b=aGaZ8hE0XHWbXRaV0zB/bEUnnwicb9JGPbug310AlK+CQ4c4Go9wW9jnL1pEg5s196
         sa0OxGQSSDHs9wGOOPBqE/BKCD+YvCIuNWvN6EX9Xh5airBMQXmRThg1jmRETbmNlXKm
         1TV64ASRE1H/n3q5gIh76ztc8tSrUw0c/OAbWpO2XRDim0EFVCkwlezjl7GMTvc5SC3G
         wES9XAcIlR625OMSHmp7X1uc8bMgDzNamYYDZ3oMGH7DXGMcXLEQ8RDjVYGLrUL9Ofzi
         g+DPUa7L0/STOMUg9X/xSGe1chsUzFM8ENzKoRdh84N8xXfnXyUKrA4x4pRLiZT/rpOY
         LZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vQcmpQjbKtJK6jCEHAzRxaj4cUE3MqPaGDEkDFS+C0k=;
        b=zuK8/nrqLcESwYBPVCTpHBAZmEaxejCrwP8dFCfVuL7Az0yMnXOOATh6nSUGPqTN9q
         k6j3+lMe4CjvOUVUSZgsPa3xWww//FzM8RiUE5G2FYLnlR5ltbNez9DxrKwBLFXmOZcA
         drvXA7vkS16YXxQesIVF7+BGZ4To8Ifanj8B44eGeTJsMi51DspXdZtqA6abtNxeJPv4
         +scFLK8LsNFgg0hykjrqTRP2VLUYzb8XLmnwZMNxgSRIit5cpnw9lUKR5qMRGPA7trQ3
         cAvNAItKHsGAPBLRd+/xAvxa6y25uHGa+zW55UfYAwrEh6fEWrS726OdS/6xmQkjkvEP
         wrXg==
X-Gm-Message-State: AOAM530xAPnb7X8iWY4Urm+AG8VpIS5oOvxzgq2nIHqFQUnfODIpJ4ND
        SPwF0J6cn4BPyN35tjYZIys=
X-Google-Smtp-Source: ABdhPJxfGGcIU3WBB9daMx2kqccvnY1MCfm2FizpOnIBO0MAhQD9DBO/QfmooJ7DNiq6wKVW9BhmBg==
X-Received: by 2002:a05:6830:278b:: with SMTP id x11mr5034914otu.293.1637333473967;
        Fri, 19 Nov 2021 06:51:13 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3441:8b39:39a2:9208? ([2600:1700:e72:80a0:3441:8b39:39a2:9208])
        by smtp.gmail.com with ESMTPSA id b26sm11961oti.56.2021.11.19.06.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 06:51:13 -0800 (PST)
Message-ID: <72fffbff-16f7-fa17-b212-67aae9e1b034@gmail.com>
Date:   Fri, 19 Nov 2021 09:51:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: git 2.34.0: Behavior of `**` in gitignore is different from
 previous versions.
Content-Language: en-US
To:     Danial Alihosseini <danial.alihosseini@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>,
        git@vger.kernel.org
References: <CACLOEFZz7bunO2S5-ec1K10B9AJU4-m50j3j9c=12R6d1D+-dg@mail.gmail.com>
 <YZaHpJKeyDEY8qKW@coredump.intra.peff.net>
 <2bd2269f-c7f1-7afb-7052-48fac148dffd@gmail.com>
 <CACLOEFbY3LwMa2uhc=9jmcGFf0mvWzEM=YityLyFcuGWXVmqbw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CACLOEFbY3LwMa2uhc=9jmcGFf0mvWzEM=YityLyFcuGWXVmqbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18/2021 11:01 PM, Danial Alihosseini wrote:
> Thanks for your follow-up.
> 
> I wanted to ignore all files in the "data" folder except ".txt" ones.
> 
> As mentioned in the gitignore doc, there should be a difference
> between "**" and "**/".
> 
>> A trailing "/**" matches everything inside. For example, "abc/**" matches all files inside directory "abc", relative to the location of the .gitignore file, with infinite depth.
> 
> and,
>>
>> A slash followed by two consecutive asterisks then a slash matches zero or more directories. For example, "a/**/b" matches "a/b", "a/x/b", "a/x/y/b" and so on.
> 
> and also,
>>
>> It is not possible to re-include a file if a parent directory of that file is excluded.

So this is the key point of why you can't just omit the !data/**/
line.

What is unclear to me is what exactly "match a directory" means.
If we ignore a directory, then we ignore everything inside it (until
another pattern says we should care about it), but the converse
should also hold: if we have a pattern like "!data/**/", then that
should mean "include everything inside data/<A>/ where <A> is any
directory name".

My inability to form a mental model where the existing behavior
matches the documented specification is an indicator that this was
changed erroneously. A revert patch is included at the end of this
message.

If anyone could help clarify my understanding here, then maybe
there is room for improving the documentation.

> So, I excluded all files by "data/**", re-included just directories
> (at any depth) by "!data/**/" and, re-included ".txt" files (at any
> depth) by "!data/**/*.txt".
> However, if I wanted to re-include a directory and all of its
> contents, I could use something like "!data/data1/**", without
> trailing slash.
> As I see, there is no separation between "**" and "**/" in the current version.
> 
> I think there is another point that the previous behavior test case
> should be like this:
> test_expect_success 'directories and ** matches' '
>     cat >.gitignore <<-\EOF &&
>     data/**
>     !data/**/
>     !data/**/*.txt
>     EOF
>     git check-ignore file \
>         data/file data/data1/file1 data/data1/file1.txt \
>         data/data2/file2 data/data2/file2.txt >actual &&
>     cat >expect <<-\EOF &&
>     data/file
>     data/data1/file1
>     data/data2/file2
>     EOF
>     test_cmp expect actual
> '

Thank you for seeing my poorly-edited test and understanding
what it _should_ have been.

Here is a revert including this new test. I further tested
with the Scalar functional tests [1] to see if I could find
what I was thinking when making this original change. Since
this is so similar to another revert we caught before the
2.34.0 release, I regret not checking adjacent commits for
a similar "reverting does not affect the test suite" case.

---- >8 ----

From f833967da83ecd51090ebb75a4b8173a775d16f1 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Fri, 19 Nov 2021 09:13:49 -0500
Subject: [PATCH] dir: revert "dir: select directories correctly"

This reverts commit f6526728f950cacfd5b5e42bcc65f2c47f3da654.

The change in f652672 (dir: select directories correctly, 2021-09-24)
caused a regression in directory-based matches with non-cone-mode
patterns, especially for .gitignore patterns. A test is included to
prevent this regression in the future.

The commit ed495847 (dir: fix pattern matching on dirs, 2021-09-24) was
reverted in 5ceb663 (dir: fix directory-matching bug, 2021-11-02) for
similar reasons. Neither commit changed tests, and tests added later in
the series continue to pass when these commits are reverted.

Reported-by: Danial Alihosseini <danial.alihosseini@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c              | 54 +++++-----------------------------------------
 t/t0008-ignores.sh | 17 +++++++++++++++
 2 files changed, 22 insertions(+), 49 deletions(-)

diff --git a/dir.c b/dir.c
index 9ea6cfe61c..86afa2eae0 100644
--- a/dir.c
+++ b/dir.c
@@ -1303,44 +1303,6 @@ int match_pathname(const char *pathname, int pathlen,
 				 WM_PATHNAME) == 0;
 }
 
-static int path_matches_dir_pattern(const char *pathname,
-				    int pathlen,
-				    struct strbuf **path_parent,
-				    int *dtype,
-				    struct path_pattern *pattern,
-				    struct index_state *istate)
-{
-	if (!*path_parent) {
-		char *slash;
-		CALLOC_ARRAY(*path_parent, 1);
-		strbuf_add(*path_parent, pathname, pathlen);
-		slash = find_last_dir_sep((*path_parent)->buf);
-
-		if (slash)
-			strbuf_setlen(*path_parent, slash - (*path_parent)->buf);
-		else
-			strbuf_setlen(*path_parent, 0);
-	}
-
-	/*
-	 * If the parent directory matches the pattern, then we do not
-	 * need to check for dtype.
-	 */
-	if ((*path_parent)->len &&
-	    match_pathname((*path_parent)->buf, (*path_parent)->len,
-			   pattern->base,
-			   pattern->baselen ? pattern->baselen - 1 : 0,
-			   pattern->pattern, pattern->nowildcardlen,
-			   pattern->patternlen, pattern->flags))
-		return 1;
-
-	*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
-	if (*dtype != DT_DIR)
-		return 0;
-
-	return 1;
-}
-
 /*
  * Scan the given exclude list in reverse to see whether pathname
  * should be ignored.  The first match (i.e. the last on the list), if
@@ -1356,7 +1318,6 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 {
 	struct path_pattern *res = NULL; /* undecided */
 	int i;
-	struct strbuf *path_parent = NULL;
 
 	if (!pl->nr)
 		return NULL;	/* undefined */
@@ -1366,10 +1327,11 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 		const char *exclude = pattern->pattern;
 		int prefix = pattern->nowildcardlen;
 
-		if (pattern->flags & PATTERN_FLAG_MUSTBEDIR &&
-		    !path_matches_dir_pattern(pathname, pathlen, &path_parent,
-					      dtype, pattern, istate))
-			continue;
+		if (pattern->flags & PATTERN_FLAG_MUSTBEDIR) {
+			*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
+			if (*dtype != DT_DIR)
+				continue;
+		}
 
 		if (pattern->flags & PATTERN_FLAG_NODIR) {
 			if (match_basename(basename,
@@ -1393,12 +1355,6 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 			break;
 		}
 	}
-
-	if (path_parent) {
-		strbuf_release(path_parent);
-		free(path_parent);
-	}
-
 	return res;
 }
 
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 46a5038fed..fce7c7b408 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -828,6 +828,23 @@ test_expect_success 'exact prefix matching (without root)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'directories and ** matches' '
+	cat >.gitignore <<-\EOF &&
+	data/**
+	!data/**/
+	!data/**/*.txt
+	EOF
+	git check-ignore file \
+		data/file data/data1/file1 data/data1/file1.txt \
+		data/data2/file2 data/data2/file2.txt >actual &&
+	cat >expect <<-\EOF &&
+	data/file
+	data/data1/file1
+	data/data2/file2
+	EOF
+	test_cmp expect actual
+'
+
 ############################################################################
 #
 # test whitespace handling
-- 
2.34.0.dirty

