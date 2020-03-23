Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10792C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8942072D
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCSvtQI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgCWSON (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:14:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37245 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCWSOM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 14:14:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12so14406902otp.4
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrwely10yFoKT2ZFpaXoAwBn+M8INfrpgEqmmu5v2cE=;
        b=rCSvtQI1QJPZgxiTSPLvi8bLxk9fcvr8A6PUJDPlzSV41IykAZGtSAA2TPuVpkoa+T
         GVWizV63QVv24V5iqEr2oq/S1a0LQhDrTKaKheVrsHc0ypXS8zhshvG0Ifvnwsy4X4IF
         IjnKU0DRe4YGu2YzNeQGRSOde4spuyzHxSUbLA48ptF+MDBngBoR/pdQb+tqn7SkJ5ia
         bAddPtVf7r87FnWQ4DMdSOkrZPqfWDerzZqxvroQ8JzV7lJUtItEHhZTfHqnSOObvm+6
         cPjJUBd6hZaLbZ492DzhI66LR30a0y7ftKRdiaZRXSu6jGd5BRbGt1uyBbiaCLOdc2R6
         qZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrwely10yFoKT2ZFpaXoAwBn+M8INfrpgEqmmu5v2cE=;
        b=bRf/GvEG2Yz964x9PcMXi5voJ2Uk3rEUuTS+pjWYaDF/xVuoVAVYSMAW3uk76rKwqh
         2/lKBiYl9YTp0ablR82dJ0tXpBYTOMf/GTN9N52NYpyQoE1AFJE2hfqUBqJ8dkVC3YLs
         EQZJzWKOOfdhH//Pavr0PdT8rwYhera0eZHXdHpaKnIIuhMtYQ+XAo7NJcziK4N8JLz/
         Px/mrAY93Txa0g9uii/+WYye17bcd+bpFGK90gEiQvja8IovHCf881qX7oEBQ8TeiOwV
         uhz8oCVEYV28xfU6XvWmWxCAVrRUCsaUjg5pfqQ872hLZhf5MUmsx8JWisMs9xn8c7l+
         Xf2w==
X-Gm-Message-State: ANhLgQ0W74Advgel6iYL8FPNVq+1d/FwnNKBoBmyP9YObUh10jKVYuO8
        ht8CigFEnDcRnwbboDTJCpbr24sON9kANFE6ML0=
X-Google-Smtp-Source: ADFU+vuuvA+scLcsfGd0GKYvQ2Eo/7PRLaKnjr+6TGZZKUiBoBPuhSZSJ0Tx/cZ7vjKzR3PVhfrpkvwDAC9Aay4iMXQ=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr19337170otl.162.1584987251593;
 Mon, 23 Mar 2020 11:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com> <27ed4a3f7a28c66d8185cb4c484e8b0af81b15c6.1584813609.git.gitgitgadget@gmail.com>
 <45021041-eab4-6e0e-5966-11db06333ab2@gmail.com>
In-Reply-To: <45021041-eab4-6e0e-5966-11db06333ab2@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Mar 2020 11:14:00 -0700
Message-ID: <CABPp-BH1BMZjLN91F5Ece6v30dw8RczrBY+9GnmPWCCdeH6Stg@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] sparse-checkout: use new update_sparsity() function
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 11:07 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/21/2020 2:00 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Remove the equivalent of 'git read-tree -mu HEAD' in the sparse-checkout
> > codepaths for setting the SKIP_WORKTREE bits and instead use the new
> > update_sparsity() function.
> >
> [snip]
> > diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> > index 8607a8e6d1a..86ae422ff5c 100755
> > --- a/t/t1091-sparse-checkout-builtin.sh
> > +++ b/t/t1091-sparse-checkout-builtin.sh
> > @@ -277,16 +277,23 @@ test_expect_success 'cone mode: add parent path' '
> >       check_files repo a deep folder1
> >  '
> >
> > -test_expect_success 'revert to old sparse-checkout on bad update' '
> > +test_expect_success 'not-up-to-date does not block rest of sparsification' '
> >       test_when_finished git -C repo sparse-checkout disable &&
> >       test_when_finished git -C repo reset --hard &&
> >       git -C repo sparse-checkout set deep &&
> > +
> >       echo update >repo/deep/deeper2/a &&
> >       cp repo/.git/info/sparse-checkout expect &&
> > -     test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
> > -     test_i18ngrep "cannot set sparse-checkout patterns" err &&
> > -     test_cmp repo/.git/info/sparse-checkout expect &&
> > -     check_files repo/deep a deeper1 deeper2
> > +     test_write_lines "!/deep/*/" "/deep/deeper1/" >>expect &&
> > +
> > +     git -C repo sparse-checkout set deep/deeper1 2>err &&
> > +
> > +     test_i18ngrep "Cannot update sparse checkout" err &&
> > +     test_cmp expect repo/.git/info/sparse-checkout &&
> > +     check_files repo/deep a deeper1 deeper2 &&
> > +     check_files repo/deep/deeper1 a deepest &&
> > +     check_files repo/deep/deeper1/deepest a &&
> > +     check_files repo/deep/deeper2 a
> >  '
>
> This demonstrates some of the value of using update_sparsity.
> I expect some more specific tests are coming later in the
> series.
>
> >  test_expect_success 'revert to old sparse-checkout on empty update' '
> > @@ -316,12 +323,22 @@ test_expect_success '.gitignore should not warn about cone mode' '
> >       test_i18ngrep ! "disabling cone patterns" err
> >  '
> >
> > -test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status' '
> > +test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status' '
> >       git clone repo dirty &&
> >       echo dirty >dirty/folder1/a &&
> > -     test_must_fail git -C dirty sparse-checkout init &&
> > -     test_must_fail git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
> > -     test_must_fail git -C dirty sparse-checkout disable &&
> > +
> > +     git -C dirty sparse-checkout init 2>err &&
> > +     test_i18ngrep "error" err &&
> > +     test_i18ngrep "Cannot update sparse checkout" err &&
> > +
> > +     git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
> > +     test_i18ngrep "error" err &&
> > +     test_i18ngrep "Cannot update sparse checkout" err &&
> > +
> > +     git -C dirty sparse-checkout disable &&
> > +     test_i18ngrep "error" err &&
> > +     test_i18ngrep "Cannot update sparse checkout" err &&
> > +
>
> Should the "error" messages we grep for be more specific? Are they
> the same as the "Cannot update sparse checkout"?

The two lines are checking for the same message, it's just that the
error message is split across multiple lines and thus requires two
greps.  The error messages are actually a bit of a mess, particularly
when they are triggered for multiple paths.  That's something that
subsequent commits will clean up.

I can add a note about this to the commit message.
