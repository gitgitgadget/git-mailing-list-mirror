Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D467C433FE
	for <git@archiver.kernel.org>; Tue, 10 May 2022 06:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiEJGIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 02:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiEJGIw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 02:08:52 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A052A374A
        for <git@vger.kernel.org>; Mon,  9 May 2022 23:04:56 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id q10so2371862oia.9
        for <git@vger.kernel.org>; Mon, 09 May 2022 23:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sGlGHQ4Li+EY5sSJbOJS+gM6YsQoao901CIkv519HHM=;
        b=T1vOGBBoKNv9eLJARv9BEsPyrhhXyGAkY+k6VUtoqjnceFRK/FtkTztBwdVZzm5S7i
         /Z8nIQSjOZqSQ68qML4oLZk9967Q8mNawzzMzq5vGrA9GPpBEw/UjEa6qtBfjQgNBql5
         u0SZFSy9nmnSCcVVLXp7b0aoQik+OjNGBQoVNaHWReiHmtbwRow7MzhZAkNogUyuHi0v
         cv1+aq+IkIGGLZPwCuVG1zeQffFdg4SxOkC25n8Wlnm+809NJpyHNsyYNn+POyz0r9ms
         SXnpOkRHHE2FCdtQZdRZQhICMQI/EwZw+4IShW67g44H8uG9BSecCKJnFbpQil+enA9u
         wNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sGlGHQ4Li+EY5sSJbOJS+gM6YsQoao901CIkv519HHM=;
        b=ks1Q/KNGCVlRE15AYwAQySRxIVnOFk4bzornHWkCclD4gPfPykJuvxOyQ3LCf/RcwZ
         AEtGPbGCHn6rMzI5VOlrL7zchFAZgtm3XO4qElC/zqoyhJx6QvfrAXsjQHG4rlQGCpoo
         7lCH06I2hAvZNzUDOXbay5D40DA1fwswga+Fd0NT1w0swQ72+hHvGEZzvg8XVHAcQs81
         X9GZJpQZAKB0ga4ZzkiZulvD3juRBZE4OPWu+0En3zfkAEvVTDAg3qMVMWIGpr50YK+N
         ctJ0h9vNLqQbsZWvOjiB/1kEg/MQDNE89/+teR86064QVefX0S3Y/WoI8KZ9ul3J86Nm
         /NYA==
X-Gm-Message-State: AOAM533+WlKwsaHNRfMJnVHkFPxcu7b4bi4hjz25aWsUbNCZVzdRk6rm
        Be1ifOaSFjH1hn73jyySUzQ=
X-Google-Smtp-Source: ABdhPJxvGI+WZooVROjM87+nEt31pfqme+gPA54Nj7RuOXVE7aZYC1RvHydxYtXRPn0o+WX0bVYfEw==
X-Received: by 2002:a05:6808:11ca:b0:2d4:6861:2a9e with SMTP id p10-20020a05680811ca00b002d468612a9emr9991968oiv.114.1652162695343;
        Mon, 09 May 2022 23:04:55 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id u13-20020acaab0d000000b003263cf0f282sm5208274oie.26.2022.05.09.23.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 23:04:54 -0700 (PDT)
Date:   Mon, 9 May 2022 23:04:53 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t0033-safe-directory: check the error message
 without matching the trash dir
Message-ID: <20220510060453.d6t5q5lqssvba6tg@carlos-mbp.lan>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
 <20220427170649.4949-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427170649.4949-2-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies for the late feedback, hoping it is still timely though.

On Wed, Apr 27, 2022 at 07:06:47PM +0200, SZEDER Gábor wrote:
> 
>   - it only appears in the advice part, not in the actual error
>     message.
> 
>   - it is interpreted as a regexp by 'grep', so, because of the dot,
>     it matches the name of the test script and the path of the trash
>     directory as well.  Consequently, these tests could be fooled by
>     any error message that would happen to include the path of the
>     test repository.

The subject says something else and I think it is confusing because the
change you propose only seems to be removing the path as an implementation
detail while the core of the change seems to be making sure that the text
that is being matched is a "Fixed String" and part of the real error.

I agree is an improvement, but I think it could be done better by :

* using `grep -F` instead to make sure we don't interpret that string
  as a regex by mistake.
* including the path, so we are sure we really matched the error message
  that was really expected.  As a side effect we also validate this way
  that the code that does the lookup and reports the "name" of the
  repository that could be added to the exception list, reports the righ
  directory, which seems by itself an important thing we should want to
  avoid regressing against in future changes.

Both changed are implemented by the patch below and I think might be
worth considering as a replacement of this one.

Carlo

PS. Commit message could be improved, but wasn't sure how in the context
    of your series, so left it as a barebones one hoping it would be part
    of the patch you could adopt into your series.

----- >8 -----
Subject: t0033: verify detected worktree is accurate and part of the error
    
Change the helper function to check for a fixed message and make
sure to include the directory that we are testing from (which in
all current tests is the current directory).
    
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>

diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 239d93f4d2..c524b74b01 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -9,7 +9,7 @@ export GIT_TEST_ASSUME_DIFFERENT_OWNER
 
 expect_rejected_dir () {
 	test_must_fail git status 2>err &&
-	grep "safe.directory" err
+	grep -F "unsafe repository ('$(pwd)'" err
 }
 
 test_expect_success 'safe.directory is not set' '
