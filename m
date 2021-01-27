Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4434C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 16:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F2B64DA0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 16:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhA0Q5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhA0QzY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 11:55:24 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB2BC061573
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 08:54:43 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id i20so2318788otl.7
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 08:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+u05uXtyIo/IPHYe4AzDNjTbcUrtgeYV8ckdi52a/LI=;
        b=ak5eWSd1tw2VPevi/IjBxoPch1r1MlFXakTVXRCHEEJk+lPU4PMzeMr92Yq2KHd4kr
         f1AyW73P8EcGwX32UeNy0UYM0C7AtjujSG9vG7fLPo6fJJNGCfnyk3CopZZ/So27AAG7
         l7MdwVN/k8n2hRhxOQUSSSHSZELYLVY9KVmprJlu7adhbeJWpDWd6GdCzQZOcs+/BV2k
         wLPlaLfxyh4qjS2p87hu+MCdjtiMygY4/Bu53mphFu2ahBTPOR5YK43ChmuvSikNhxq5
         bfRTr/EInOmEMjSlzE0E5hsfzHKQc6S3DZjsQr/PpW5TFWraU6bYG8ZddtZd2HgqlHUL
         2ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+u05uXtyIo/IPHYe4AzDNjTbcUrtgeYV8ckdi52a/LI=;
        b=h4V3gpDISx0MMmFNnhI3agXO1IBHp6RIvZEwcBkCD7smNoMhTXrN9ecn6Rzzng7yPH
         rg4OhRciJttyPMW6rOWEip0Y0aAskogCsiRbxiZTjNTbcOUXBZkqx24QiNn4Xymeatnq
         rh9vavVTOpXIGD707g5k67ILE2dUBe8MkXuEOejs60aToJQigVtyEtFSftY3hdUG0GQu
         TPbTCIZKk2Q0j/5pGYix3/IhW9FIh4K1dQD7Wt6qiN/rXhw2+8iUOysQC+XeIOzh0zR/
         rxBnPvAo/ZuFA1kPsoUnRV8927FMh8ey69JVSkNWP1eHWwdlnx5xaTEZwka0Ij5KZRUc
         mhKQ==
X-Gm-Message-State: AOAM532cgPtt7eyGVLJU8LQriQJq7DOOvRceWx60jtt7kfgAZLqXXErz
        bCQ8kt26Ba/gxcUKnYDBPwpbtlFFIZCFpf9zVpc=
X-Google-Smtp-Source: ABdhPJzG7IqbiDqEJiQrBwgKBl7zFEfFukCQlqNLlIPJa6w3jybS56uVrK/Z9yH9+7eqZsDbivUFN0Y/G4floPF6Emw=
X-Received: by 2002:a05:6830:402f:: with SMTP id i15mr8291304ots.345.1611766482821;
 Wed, 27 Jan 2021 08:54:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
 <b3696c823a24547be391c4ee35b99ba76cce42af.1611596534.git.gitgitgadget@gmail.com>
 <CABPp-BHKva46dZ7zqhy9Ey=cKfMpBNie-2h=yq6URa40WhGDjw@mail.gmail.com> <d652eb83-808a-946e-37ef-9112a1790199@gmail.com>
In-Reply-To: <d652eb83-808a-946e-37ef-9112a1790199@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Jan 2021 08:54:31 -0800
Message-ID: <CABPp-BEjwaXXJggNDGT4fN2s+A4S-3xkNDRqc4RqM5K5bmZpaw@mail.gmail.com>
Subject: Re: [PATCH 03/27] t1092: compare sparse-checkout to sparse-index
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2021 at 5:30 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/26/2021 10:08 PM, Elijah Newren wrote:
> > On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >>
> >> Add a new 'sparse-index' repo alongside the 'full-checkout' and
> >> 'sparse-checkout' repos in t1092-sparse-checkout-compatibility.sh. Also
> >> add run_on_sparse and test_sparse_match helpers. These helpers will be
> >> used when the sparse index is implemented.
> >>
> >> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> >> ---
> >>  t/t1092-sparse-checkout-compatibility.sh | 29 ++++++++++++++++++++----
> >>  1 file changed, 25 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> >> index 8cd3e5a8d22..8876eae0fe3 100755
> >> --- a/t/t1092-sparse-checkout-compatibility.sh
> >> +++ b/t/t1092-sparse-checkout-compatibility.sh
> >> @@ -7,6 +7,7 @@ test_description='compare full workdir to sparse workdir'
> >>  test_expect_success 'setup' '
> >>         git init initial-repo &&
> >>         (
> >> +               (GIT_TEST_SPARSE_INDEX=0 && export GIT_TEST_SPARSE_INDEX) &&
> >
> > I thought parentheses started a subshell; once the subshell ends,
> > wouldn't the setting of GIT_TEST_SPARSE_INDEX be thrown away?
>
> I think the "export" specifically pushes the setting out of the
> first level of subshell. This is the recommendation that comes up

You're having a child process change the environment variables of a
parent process? ...without some kind of gdb or other debugger
wizardry?

> if one runs
>
>         export GIT_TEST_SPARSE_INDEX=1 &&
>
> inside a test on macOS, since this isn't completely portable.

Um, I think you meant to run
      GIT_TEST_SPARSE_INDEX=0 &&
      export GIT_TEST_SPARSE_INDEX &&
in order to avoid the unportable
      export GIT_TEST_SPARSE_INDEX=0 &&
because
      (GIT_TEST_SPARSE_INDEX=0 &&
       export GIT_TEST_SPARSE_INDEX) &&
looks like a useless no-op.  At least it would be in normal bash; is
the test harness doing some special magic with it?  In normal bash,
the value definitely does NOT survive the subshell; (export just means
that subprocesses of the subshell where the environment variable is
set will see the value):

$ echo Before: $GIT_TEST_SPARSE_INDEX && (GIT_TEST_SPARSE_INDEX=0 &&
export GIT_TEST_SPARSE_INDEX) && echo After: $GIT_TEST_SPARSE_INDEX
Before:
After:

But in contrast, without the parentheses:
$ echo Before: $GIT_TEST_SPARSE_INDEX && GIT_TEST_SPARSE_INDEX=0 &&
export GIT_TEST_SPARSE_INDEX && echo After: $GIT_TEST_SPARSE_INDEX
Before:
After: 0
