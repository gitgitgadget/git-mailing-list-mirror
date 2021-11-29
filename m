Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E89AC4332F
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhK2WQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhK2WQn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:16:43 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854D8C127116
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:20:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so38743770wru.13
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LN0HHdN2T+RXhEKaCacYM3KW1j6dblnAdMDnmCDNJUs=;
        b=NNXLcZ+DaB6WuoyiEQMRcaVBUssH1cgWkrvVHwRYFtkm1x0qyL3DlJg4qan6jlUv8h
         GECXpx8k6kThWDkEdSevFchpIYpafWDImlvA8dTE0X5leeypZd6Y+7yuqZIUrYZQj5Vz
         XkbRjl3C9HgI5hjegf6RAcqjJkQikfHfHLJ4TLg7IU9b2n2dy1w9Kh2rBdVQuIeEZZqx
         R2UTDWCfqMUy/gKnSFthXROnxtOLU3W1+Iy9TtX3DWeRs7proG2BENV7LEC/jBWgg93U
         vuDQGunJ77YGAj5P2E5oqSoG2++Au/oTWStFV3NkipbBfUp/uewfhh2MKRpk8KmLJGbk
         qThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LN0HHdN2T+RXhEKaCacYM3KW1j6dblnAdMDnmCDNJUs=;
        b=M0I19wLyFGTONdESokdqEXmYLR3cmlMDnlpGOo/41CaV8KhYikbcPJaDVDLx4rs6fh
         BbjL18CzIdzPuTHaGZ2yAGhoIEIG3xUk2tq8F5nCowwur9U8Y7VeyQ11RmKrPOKUEq7Y
         SmyuIxJIqlo3GgzO2fI02fkz3llDEPy6OaxFjQ7B6bNU1gt8BaK2UVCGM11XzbVxFOOZ
         GvlYfn2rVe8jjp6tWoaAv9uhPfjaILq1sQeVfFUEm+P9SNe5whCnp+zkSgkbUiKPf3aa
         GmItOeCBJ29guyi1FIhZYBJlsvneOgm2iMzilmnnfg3iXZdunKvoEvoxOjwVjJ31gHFc
         8Uzg==
X-Gm-Message-State: AOAM533HWkxvkIL1g09l6zA7wSMHL/fXQnHTYXBqdNx+TB4v7qYwWb4C
        2HxUrrBQqV135pPVlWI0vEUILUQ0YbE=
X-Google-Smtp-Source: ABdhPJzr1+DMMmqhIryGXEMHPrahh7g8Jcvcu2DSYpDb4IbXSTKD+6CVVJxTVANZsRcBi12+MxXwAQ==
X-Received: by 2002:a5d:4846:: with SMTP id n6mr35983200wrs.249.1638210023862;
        Mon, 29 Nov 2021 10:20:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1sm18542891wri.89.2021.11.29.10.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:20:23 -0800 (PST)
Message-Id: <pull.1148.v2.git.git.1638210022966.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.git.git.1637855828856.gitgitgadget@gmail.com>
References: <pull.1148.git.git.1637855828856.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 18:20:22 +0000
Subject: [PATCH v2] t1404: mark directory/file conflict tests with REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The files backend uses file system locking on individual refs, which means a
directory/file conflict can prevent locks being taken. For example, in a repo
with just the ref "foo", an update

    (DELETE "foo") + (ADD "foo/bar")

cannot be executed in the files backend, as one cannot take a lock on foo/bar.

The current reftable proof-of-concept integration supports these tranactions, as
the result is a repo with just "foo/bar", which has no directory/file conflict.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    t1404: mark directory/file conflict tests with REFFILES
    
    The files backend uses file system locking on individual refs, which
    means a directory/file conflict can prevent locks being taken. For
    example, in a repo with just the ref "foo", an update
    
    (DELETE "foo") + (ADD "foo/bar")
    
    
    cannot be executed in the files backend, as one cannot take a lock on
    foo/bar.
    
    The result is a repo with just "foo/bar", which has no directory/file
    conflict, and this is a valid transaction in reftable.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1148%2Fhanwen%2Ft1404-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1148/hanwen/t1404-v2
Pull-Request: https://github.com/git/git/pull/1148

Range-diff vs v1:

 1:  55d200a6a83 ! 1:  59e9ea188f5 t1404: mark directory/file conflict tests with REFFILES
     @@ Commit message
      
          cannot be executed in the files backend, as one cannot take a lock on foo/bar.
      
     -    The result is a repo with just "foo/bar", which has no directory/file conflict,
     -    and this is a valid transaction in reftable.
     +    The current reftable proof-of-concept integration supports these tranactions, as
     +    the result is a repo with just "foo/bar", which has no directory/file conflict.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     @@ t/t1404-update-ref-errors.sh: test_expect_success REFFILES 'empty directory shou
       '
       
      -test_expect_success 'D/F conflict prevents add long + delete short' '
     -+test_expect_success REFFILES  'D/F conflict prevents add long + delete short' '
     ++test_expect_success REFFILES 'D/F conflict prevents add long + delete short' '
       	df_test refs/df-al-ds --add-del foo/bar foo
       '
       
     @@ t/t1404-update-ref-errors.sh: test_expect_success REFFILES 'empty directory shou
       '
       
      -test_expect_success 'D/F conflict prevents delete long + add short' '
     -+test_expect_success REFFILES  'D/F conflict prevents delete long + add short' '
     ++test_expect_success REFFILES 'D/F conflict prevents delete long + add short' '
       	df_test refs/df-dl-as --del-add foo/bar foo
       '
       
     @@ t/t1404-update-ref-errors.sh: test_expect_success REFFILES 'empty directory shou
       '
       
      -test_expect_success 'D/F conflict prevents indirect add long + indirect delete short' '
     -+test_expect_success REFFILES 'D/F conflict prevents indirect add long + delete short' '
     -+	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
     -+'
     -+
     -+test_expect_success REFFILES 'D/F conflict prevents indirect add long + delete short' '
     -+	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
     -+'
     -+
      +test_expect_success REFFILES 'D/F conflict prevents indirect add long + indirect delete short' '
       	df_test refs/df-ial-ids --sym-add --sym-del --add-del foo/bar foo
       '


 t/t1404-update-ref-errors.sh | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index b729c1f4803..13c2b43bbae 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -261,69 +261,69 @@ test_expect_success REFFILES 'empty directory should not fool 1-arg delete' '
 	git update-ref --stdin
 '
 
-test_expect_success 'D/F conflict prevents add long + delete short' '
+test_expect_success REFFILES 'D/F conflict prevents add long + delete short' '
 	df_test refs/df-al-ds --add-del foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents add short + delete long' '
+test_expect_success REFFILES 'D/F conflict prevents add short + delete long' '
 	df_test refs/df-as-dl --add-del foo foo/bar
 '
 
-test_expect_success 'D/F conflict prevents delete long + add short' '
+test_expect_success REFFILES 'D/F conflict prevents delete long + add short' '
 	df_test refs/df-dl-as --del-add foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents delete short + add long' '
+test_expect_success REFFILES 'D/F conflict prevents delete short + add long' '
 	df_test refs/df-ds-al --del-add foo foo/bar
 '
 
-test_expect_success 'D/F conflict prevents add long + delete short packed' '
+test_expect_success REFFILES 'D/F conflict prevents add long + delete short packed' '
 	df_test refs/df-al-dsp --pack --add-del foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents add short + delete long packed' '
+test_expect_success REFFILES 'D/F conflict prevents add short + delete long packed' '
 	df_test refs/df-as-dlp --pack --add-del foo foo/bar
 '
 
-test_expect_success 'D/F conflict prevents delete long packed + add short' '
+test_expect_success REFFILES 'D/F conflict prevents delete long packed + add short' '
 	df_test refs/df-dlp-as --pack --del-add foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents delete short packed + add long' '
+test_expect_success REFFILES 'D/F conflict prevents delete short packed + add long' '
 	df_test refs/df-dsp-al --pack --del-add foo foo/bar
 '
 
 # Try some combinations involving symbolic refs...
 
-test_expect_success 'D/F conflict prevents indirect add long + delete short' '
+test_expect_success REFFILES 'D/F conflict prevents indirect add long + delete short' '
 	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents indirect add long + indirect delete short' '
+test_expect_success REFFILES 'D/F conflict prevents indirect add long + indirect delete short' '
 	df_test refs/df-ial-ids --sym-add --sym-del --add-del foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents indirect add short + indirect delete long' '
+test_expect_success REFFILES 'D/F conflict prevents indirect add short + indirect delete long' '
 	df_test refs/df-ias-idl --sym-add --sym-del --add-del foo foo/bar
 '
 
-test_expect_success 'D/F conflict prevents indirect delete long + indirect add short' '
+test_expect_success REFFILES 'D/F conflict prevents indirect delete long + indirect add short' '
 	df_test refs/df-idl-ias --sym-add --sym-del --del-add foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents indirect add long + delete short packed' '
+test_expect_success REFFILES 'D/F conflict prevents indirect add long + delete short packed' '
 	df_test refs/df-ial-dsp --sym-add --pack --add-del foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents indirect add long + indirect delete short packed' '
+test_expect_success REFFILES 'D/F conflict prevents indirect add long + indirect delete short packed' '
 	df_test refs/df-ial-idsp --sym-add --sym-del --pack --add-del foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents add long + indirect delete short packed' '
+test_expect_success REFFILES 'D/F conflict prevents add long + indirect delete short packed' '
 	df_test refs/df-al-idsp --sym-del --pack --add-del foo/bar foo
 '
 
-test_expect_success 'D/F conflict prevents indirect delete long packed + indirect add short' '
+test_expect_success REFFILES 'D/F conflict prevents indirect delete long packed + indirect add short' '
 	df_test refs/df-idlp-ias --sym-add --sym-del --pack --del-add foo/bar foo
 '
 

base-commit: 35151cf0720460a897cde9b8039af364743240e7
-- 
gitgitgadget
