Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D224C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 15:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F4C61139
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 15:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354884AbhJAPJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 11:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354988AbhJAPJW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 11:09:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA69C0613EC
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 08:07:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g8so36100553edt.7
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=S1LdALXRpVYn98SVKFCkJGccLgtcVvaX58skofWJac8=;
        b=gIybxG7UngVCDoN7SrZSREYGWZZS663FqaJ+aKyr+D10+1lD4QFRxXDJ9BlkGeJCQ/
         rVrm5ULn9E5yCVS9xk2zqDFUQ66FHhNnzrn8lRyzbKnABvz/nLt2gtoBIIZ6B+/7S3ZA
         5Kc/KG8N3omTNEcehcSoEzeGQmbgrx0cF/PnWu4d7OAODUPPkMOkI5U1H301eA95D4Lu
         Fk6xn9CDHKSmH1aTmEWrNVaHIXsstQjs03eFS8KGEM1FPQoQlx42vIoXtvmn9UGy/GDR
         oEvQ7nn4lLapS2THOWVWBlFm5CbllrsNbhNNrGnlFV2/MLQnhl5rGDm9MhpyoQ2wselH
         hHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=S1LdALXRpVYn98SVKFCkJGccLgtcVvaX58skofWJac8=;
        b=KDQ2fVxnW52HILAp3sEOTxp0cjWDEz3h2lAHDbZvuUNQovYHplZgWMOQnO/ZcXhUlA
         gHVdPOFBz94YKvHVxDUvwJPJ4VQKzkbonaQnNz6EAch/I7Gd4BQTwAOrALhMqw6HYmNH
         LaJ2fCCIXtphh7l2QGF9+bz2VS6mjcjEvYTNalHR/b/f5gIlIC08LASOKhiWvuOTtQjL
         rHzYKT4XNWAy5jZlftuyUVPD71cdf5qRfHnuFiZg3rFiyVnwS9FmVK6NfmXBgx03Y6d7
         L91nkSXXoNbJk5Hxzo3dNc+jtfv9D7b5gT/CrFdMYWqEBhjD3/qgtAaBT9z0NFQjNqel
         nc9Q==
X-Gm-Message-State: AOAM530Ng/9RhJye/a5qd6VtsOCJY7cTY7YJreI/R0cbrZBPB07hCBQU
        MbZVocMopF9RbxTWzo/NjCA=
X-Google-Smtp-Source: ABdhPJxEMVA/oeQ5BuC05NKVLsrL+z01wDUtv/I9IWFubTf33RwEa4U+zX1gE/8NU1mdnSvrynZOtg==
X-Received: by 2002:a17:906:b097:: with SMTP id x23mr6552301ejy.501.1633100852166;
        Fri, 01 Oct 2021 08:07:32 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i6sm3744469edc.50.2021.10.01.08.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 08:07:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: ab/lib-subtest
Date:   Fri, 01 Oct 2021 17:05:55 +0200
References: <xmqqh7e18soj.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqh7e18soj.fsf@gitster.g>
Message-ID: <875yugrdfw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Junio C Hamano wrote:

> * ab/lib-subtest (2021-09-22) 9 commits
>  - test-lib tests: get rid of copy/pasted mock test code
>  - test-lib tests: assert 1 exit code, not non-zero
>  - test-lib tests: refactor common part of check_sub_test_lib_test*()
>  - test-lib tests: avoid subshell for "test_cmp" for readability
>  - test-lib tests: don't provide a description for the sub-tests
>  - test-lib tests: split up "write and run" into two functions
>  - test-lib tests: move "run_sub_test" to a new lib-subtest.sh
>  - Merge branch 'ps/t0000-output-directory-fix' into ab/lib-subtest
>  - Merge branch 'jk/t0000-subtests-fix' into ab/lib-subtest
>
>  Updates to the tests in t0000 to test the test framework.
>
>  Will merge to 'next'?

I think it's ready, Carlo (CC'd) gave it a look and I re-rolled
addressing his feedback:
https://lore.kernel.org/git/cover-v4-0.7-00000000000-20210922T111734Z-avarab@gmail.com/

It's something I have some test-lib.sh UX improvements/simplification
waiting on, so having it go forward would be great :) Thanks!
