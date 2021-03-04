Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA02C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 16:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D01964F53
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 16:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbhCDQ3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 11:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbhCDQ2u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 11:28:50 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F234C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 08:28:10 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x9so3889046edd.0
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 08:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=YIe4KmthCY90DNt1oVFN1+h5LP6wDodw2tu3dpxu3zo=;
        b=tOtHwkfNyNsjlEdUEN83PPGhSB01uGd4Ooobwy99BiyumFCK9wkiqg/Ih2YeSkHKPD
         hA/3Vr+AEgbRimVoH0GV7Yb00R5xmCkf2gYD0ZIQry4pvsBy8aNQe25K4w07A4gl5gsv
         cRAFTsEk/XmDuGgo6KwRJ9KIGOPmfcRKniV/Kt/rcJFmKtQZQHVOVkf2hWNAghqofVZt
         6tJZ6kWEdPDRLdR+9l6asXfj776jHS46FZcifHyONSqPMt+Kfv4A94EVq0kBrbzNvQVD
         BABobaMpJfnfsVXgD5CzDYzuc229mgW9qFu6E5yqF0gh93DNwd3eTI/GCqFlC7lulOkd
         IxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=YIe4KmthCY90DNt1oVFN1+h5LP6wDodw2tu3dpxu3zo=;
        b=GeoZRmS5mHfbg0thKBHYSzoTYSRDlpPJ0NTCTBDbWRpul2//n4/ZaY7RPQTwvRUoxh
         ydUEYlO2+2eu4LJ0d2AkV4glh+bKGf1b/aOIEqCyggG2HRIMJDeDPSLsga1qoAwjnUEb
         VDjLXnwsoj23hv3981rrCYGxsYOSOSRH75TFidSvo09qlSBtT3d8NH8JD7ahPP5/AsOn
         KvGZjCFcTiKA6t8ib1LO6SUlidjpfFaSvc6mZ5SGyGYewBF9D/uoqjXoabSoSVzDAWCU
         PfunLJaQRsjuu+hgMM/WLeE8cjNSmOFdvrG/wsMZlc077wIiqQu7GT/eyrLvzKYKXV21
         pzaA==
X-Gm-Message-State: AOAM5338bgYD0T9yp7J54alH+LBUWXnUxeXTyal5VFlUQkXpSIMb6IeH
        4CQYEg4O8e1TCL4WJfjc0M7bGHG49MU=
X-Google-Smtp-Source: ABdhPJykW1fFtdvd+H7Uw3zYdG/4BNEGnm/hZ7D61Vo/hzWd0sjkF3qqNiRDH7K/7huHMCOreB2uUw==
X-Received: by 2002:a05:6402:5255:: with SMTP id t21mr5310374edd.91.1614875288391;
        Thu, 04 Mar 2021 08:28:08 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f11sm24221488eje.107.2021.03.04.08.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 08:28:07 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: A merge-ort TODO comment, and how to test merge-ort?
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
 <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
 <69129a20edcfb57a3278285f31584ffcc2b3bad7.1609468488.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <69129a20edcfb57a3278285f31584ffcc2b3bad7.1609468488.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 17:28:06 +0100
Message-ID: <877dmmkhnt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 01 2021, Elijah Newren via GitGitGadget wrote:

> +	else {
> +		/* must be the 100644/100755 case */
> +		assert(S_ISREG(a->mode));
> +		result->mode = a->mode;
> +		clean = (b->mode == o->mode);
> +		/*
> +		 * FIXME: If opt->priv->call_depth && !clean, then we really
> +		 * should not make result->mode match either a->mode or
> +		 * b->mode; that causes t6036 "check conflicting mode for
> +		 * regular file" to fail.  It would be best to use some other
> +		 * mode, but we'll confuse all kinds of stuff if we use one
> +		 * where S_ISREG(result->mode) isn't true, and if we use
> +		 * something like 0100666, then tree-walk.c's calls to
> +		 * canon_mode() will just normalize that to 100644 for us and
> +		 * thus not solve anything.
> +		 *
> +		 * Figure out if there's some kind of way we can work around
> +		 * this...
> +		 */

So if tree-walk.c didn't call canon_mode() you would do:

    if (opt->priv->call_depth && !clean)
        result->mode = 0100666;
    else
        result->mode = a->mode;

I haven't looked at this bit closer, but that doesn't make the test
referenced here pass.

I'm refactoring tree-walk.h to do that in a WIP series, and ran into
this.

As an aside, how does one run the merge-ort tests in such a way as
they'll pass on master now? There's now a bunch of failures with
GIT_TEST_MERGE_ALGORITHM=ort, well, just for t*merge*.sh:
    
    t6409-merge-subtree.sh                        (Wstat: 256 Tests: 12 Failed: 1)
      Failed test:  12
      Non-zero exit status: 1
    t6418-merge-text-auto.sh                      (Wstat: 256 Tests: 10 Failed: 3)
      Failed tests:  4-5, 10
      Non-zero exit status: 1
    t6437-submodule-merge.sh                      (Wstat: 0 Tests: 18 Failed: 0)
      TODO passed:   13, 17
    t6423-merge-rename-directories.sh             (Wstat: 256 Tests: 68 Failed: 4)
      Failed tests:  7, 53, 55, 59
      Non-zero exit status: 1

And both test_expect_merge_algorithm and what seems to be a common
pattern of e.g.:
    
    t6400-merge-df.sh:      if test "$GIT_TEST_MERGE_ALGORITHM" = ort
    t6400-merge-df.sh-      then
    t6400-merge-df.sh-              test 0 -eq $(git ls-files -o | wc -l)
    t6400-merge-df.sh-      else
    t6400-merge-df.sh-              test 1 -eq $(git ls-files -o | wc -l)
    t6400-merge-df.sh-      fi &&

Will not run tests on both backends, I was expecting to find something
so we can the test N times for the backends, and declared if things were
to be skipped on ort or whatever.

I understand that this is still WIP code, but it would be nice to have
it in a state where one can confidently touch merge-ort.c when changing
some API or whatever and have it be tested by default.

Or maybe that's the case, and I've missed how it's happening...
