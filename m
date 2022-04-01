Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B42C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 14:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiDAOjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347895AbiDAOdg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:33:36 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE1F28AC6E
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:30:50 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z6so3423522iot.0
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 07:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3soxtKNQuLe08qPQ8NwV+zHIqB5Fpk6E4aiwI2zi/o8=;
        b=LkwTaTFoURHrCNI6b2IIMHPUXoumNcR47syRZBf14gbT7CnbSEYe+kofPIOkxY0WKQ
         ZyS9Tq/cU6geKwsh+lGBk33mkDhO1ZjRWUHRJUhcFIRvrqKp/iaTbPkuht49kiYDIPO8
         PK38r3NjEP91RyJ43G/pPu3p0mZxTwU51a1pHu1OWN+wXK1ZQA7uhKniDtdN1gGzh073
         YYM7pdrGhKikwPgAD7qsEeJY8QQJeSCJVT9SwuWu136h7ATiye9LGw7tufl1ZuYT8gha
         Og+PjZCKK6+9CE7wZWGnGPDE33ILMJ4Lu1ie9rnF/sD2MxqyuqJEBFz608EbVrWsmoSj
         cXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3soxtKNQuLe08qPQ8NwV+zHIqB5Fpk6E4aiwI2zi/o8=;
        b=GnXuysUyj+n16WZkTXutowQhpWqQdCJe/8U1D1+giMUFlr4GTs2mR8yh/2ZFRyCXm4
         8ThWgjoaLgKM5n/Tn7jSWfHKJtp8/R1PJrf/6/xYV1g/UfYnS6WW7N8xL6giD7O++FxQ
         4hzUX9bM7ZKLefrNi2XtbdO3RpR9gTUezLnghftJGq6I1JvmliMJ/KNgViotPh5P/xIc
         aDYY6mAUJKzXRVTYqktXiTyjdNZr2vdgRLrYnEp4vm3cuRcn+cAN2f9+9gxdNvBOSSqp
         aJzCk14uKNstdZPdg2VRqDREdIOouDlssIbdlZXzGmGBqroxUpHC0D47I4hiak6UX6Ki
         y+2Q==
X-Gm-Message-State: AOAM532/dUuh9YeNKkSCtzF7mHopBKHiSnvhOWVhP2wBgQz5xakkGooQ
        7FLZZiolO/u1BVUlTsF1LZvc
X-Google-Smtp-Source: ABdhPJy5RMcxcv2voHSKmnGv+qcWcH0q1w5/FHSTMT+5nJSwrQgznQckKfxo3YSeNZWBBhQSEiqH8Q==
X-Received: by 2002:a05:6638:2646:b0:323:c330:9664 with SMTP id n6-20020a056638264600b00323c3309664mr733282jat.214.1648823449793;
        Fri, 01 Apr 2022 07:30:49 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id a3-20020a92d583000000b002c9fb55e727sm1384573iln.41.2022.04.01.07.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 07:30:49 -0700 (PDT)
Message-ID: <edbbd81e-2117-c9b9-76a5-4713e6326d2f@github.com>
Date:   Fri, 1 Apr 2022 10:30:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [WIP v1 1/4] mv: check if out-of-cone file exists in index with
 SKIP_WORKTREE bit
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-2-shaoxuan.yuan02@gmail.com>
 <180efaaf-7bb5-6ed7-2fc6-3c5d5f1304db@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <180efaaf-7bb5-6ed7-2fc6-3c5d5f1304db@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/31/2022 12:39 PM, Victoria Dye wrote:
> Shaoxuan Yuan wrote:

>>  		if (lstat(src, &st) < 0) {
>> +			/*
>> +			 * TODO: for now, when you try to overwrite a <destination>
>> +			 * with your <source> as a sparse file, if you supply a "--sparse"
>> +			 * flag, then the action will be done without providing "--force"
>> +			 * and no warning.
>> +			 *
>> +			 * This is mainly because the sparse <source>
>> +			 * is not on-disk, and this if-else chain will be cut off early in
>> +			 * this check, thus the "--force" check is ignored. Need fix.
>> +			 */
>> +
> 
> I can clarify this a bit. 'mv' is done in two steps: first the file-on-disk
> rename (in the call to 'rename()'), then the index entry (in
> 'rename_cache_entry_at()'). In the case of a sparse file, you're only
> dealing with the latter. However, 'rename_cache_entry_at()' moves the index
> entry with the flag 'ADD_CACHE_OK_TO_REPLACE', since it leaves it up to
> 'cmd_mv()' to enforce the "no overwrite" rule. 
> 
> So, in the case of moving *to* a SKIP_WORKTREE entry (where a file being
> present won't trigger the failure), you'll want to check that the
> destination *index entry* doesn't exist in addition to the 'lstat()' check.
> It might require some rearranging of if-statements in this block, but I
> think it can be done in 'cmd_mv'. 

This also explains the issue when going from sparse to non-sparse: the
file move is the expected way to populate the end-result, but we skip that
part in the sparse case. We need to do an extra step to populate the file
from the version in the index (after moving the cache entry).

Related to this chain of if/else if/else blocks, it might be worth
refactoring them to be sequential "if ()" blocks where we jump to a
"cleanup:" label via a 'goto' if we know that we are in a failure mode.

The previous organization made sense because any of the if () or else if
() conditions were a failure mode. However, it might be better to
rearrange things to be clearer about the situation.

Here is a diff from what I was playing with. It's... unclear if this is a
better arrangement, but I thought it worth discussing.

--- >8 ---

diff --git a/builtin/mv.c b/builtin/mv.c
index 83a465ba831..683a412a3fc 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -186,15 +186,22 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		length = strlen(src);
 		if (lstat(src, &st) < 0) {
 			/* only error if existence is expected. */
-			if (modes[i] != SPARSE)
+			if (modes[i] != SPARSE) {
 				bad = _("bad source");
-		} else if (!strncmp(src, dst, length) &&
+				goto checked_move;
+			}
+		}
+		if (!strncmp(src, dst, length) &&
 				(dst[length] == 0 || dst[length] == '/')) {
 			bad = _("can not move directory into itself");
-		} else if ((src_is_dir = S_ISDIR(st.st_mode))
-				&& lstat(dst, &st) == 0)
+			goto checked_move;
+		}
+		if ((src_is_dir = S_ISDIR(st.st_mode))
+				&& lstat(dst, &st) == 0) {
 			bad = _("cannot move directory over file");
-		else if (src_is_dir) {
+			goto checked_move;
+		}
+		if (src_is_dir) {
 			int first = cache_name_pos(src, length), last;
 
 			if (first >= 0)
@@ -227,11 +234,18 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				}
 				argc += last - first;
 			}
-		} else if (!(ce = cache_file_exists(src, length, 0))) {
+
+			goto checked_move;
+		}
+		if (!(ce = cache_file_exists(src, length, 0))) {
 			bad = _("not under version control");
-		} else if (ce_stage(ce)) {
+			goto checked_move;
+		}
+		if (ce_stage(ce)) {
 			bad = _("conflicted");
-		} else if (lstat(dst, &st) == 0 &&
+			goto checked_move;
+		}
+		if (lstat(dst, &st) == 0 &&
 			 (!ignore_case || strcasecmp(src, dst))) {
 			bad = _("destination exists");
 			if (force) {
@@ -246,34 +260,40 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				} else
 					bad = _("Cannot overwrite");
 			}
-		} else if (string_list_has_string(&src_for_dst, dst))
+			goto checked_move;
+		}
+		if (string_list_has_string(&src_for_dst, dst)) {
 			bad = _("multiple sources for the same target");
-		else if (is_dir_sep(dst[strlen(dst) - 1]))
+			goto checked_move;
+		}
+		if (is_dir_sep(dst[strlen(dst) - 1])) {
 			bad = _("destination directory does not exist");
-		else {
-			/*
-			 * We check if the paths are in the sparse-checkout
-			 * definition as a very final check, since that
-			 * allows us to point the user to the --sparse
-			 * option as a way to have a successful run.
-			 */
-			if (!ignore_sparse &&
-			    !path_in_sparse_checkout(src, &the_index)) {
-				string_list_append(&only_match_skip_worktree, src);
-				skip_sparse = 1;
-			}
-			if (!ignore_sparse &&
-			    !path_in_sparse_checkout(dst, &the_index)) {
-				string_list_append(&only_match_skip_worktree, dst);
-				skip_sparse = 1;
-			}
-
-			if (skip_sparse)
-				goto remove_entry;
+			goto checked_move;
+		}
 
-			string_list_insert(&src_for_dst, dst);
+		/*
+		 * We check if the paths are in the sparse-checkout
+		 * definition as a very final check, since that
+		 * allows us to point the user to the --sparse
+		 * option as a way to have a successful run.
+		 */
+		if (!ignore_sparse &&
+		    !path_in_sparse_checkout(src, &the_index)) {
+			string_list_append(&only_match_skip_worktree, src);
+			skip_sparse = 1;
+		}
+		if (!ignore_sparse &&
+		    !path_in_sparse_checkout(dst, &the_index)) {
+			string_list_append(&only_match_skip_worktree, dst);
+			skip_sparse = 1;
 		}
 
+		if (skip_sparse)
+			goto remove_entry;
+
+		string_list_insert(&src_for_dst, dst);
+
+checked_move:
 		if (!bad)
 			continue;
 		if (!ignore_errors)

--- >8 --- 
>> +			}
>>  			/* only error if existence is expected. */
>> -			if (modes[i] != SPARSE)
>> +			else if (modes[i] != SPARSE)
>>  				bad = _("bad source");
>>  		} else if (!strncmp(src, dst, length) &&
>>  				(dst[length] == 0 || dst[length] == '/')) {
> 
> For a change like this, it would be really helpful to include the tests
> showing how sparse file moves should now be treated in this commit. I see
> that you've added some in patch 4 - could you move the ones related tothis
> change into this commit?

I completely agree: it's nice to see how behavior is intended to change
next to your code change.

> Another way you could do this is to put your "add tests" commit first in
> this series, changing the condition on the ones that are fixed later in the
> series to "test_expect_failure". Then, in each commit that "fixes" a test's
> behavior, change that test to "test_expect_success". This approach had the
> added benefit of showing that, before this series, the tests would fail and
> that this series explicitly fixes those scenarios.

And this would be easier to adapt your current patch structure to this model:
move the last commit to be first, but flip the expectation. Then modify the
expectation for the tests that pass as you go.

This only works as long as you can make an entire test pass with each change.
If multiple changes are needed to make any one test pass, then we don't get
the benefit we're looking for. In that case, your test might be covering too
much behavior in a single test, so it would be worth rewriting the tests to
check a smaller part of the behavior.

Thanks,
-Stolee
