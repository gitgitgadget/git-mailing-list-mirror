Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E865CC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 22:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C33A660FD9
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 22:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhHKWX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 18:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhHKWX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 18:23:26 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4011C0613D3
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 15:23:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id n6so7156322ljp.9
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 15:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uijB+RIS2OejaxNIJobrDKOhIY86EN1Zc9+a6bPNlC4=;
        b=ZXKkocpfWtgW7SQLu8RuufxTuQbopaRE7DrYSfKeakjs5pmSJImy+VyMUuoSaf9pvv
         lgf2mK5CXLdXLPZ2etldJIXzXOULhdcRaDGXvvZpCEO/2dZ6YdjgpaLFFmPRQAmY/ppN
         r9IiRk2kxtsZ24lgBMaJbcurIkShdwffy9P6Sgjw+k55hgQj8CfRbHt+TJirjNfR67AQ
         iG4tCFYbx3nNOxIZCe2aFbsqvwmrj7PPkQ1sDCjJ7OHOdYaAjBMFbFc76e8r4XPiVW19
         y+Fo/WDPI9thRYqiqUkP7Ua7yACrJtLarKL7vA5WoNlqVE2C0qVZNq5a3y/h5FV757Pk
         bwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uijB+RIS2OejaxNIJobrDKOhIY86EN1Zc9+a6bPNlC4=;
        b=JzLj+4eULxoE9K4TFtHy51c9/tj+YX/yc+T2Pf1nvwv4NdUCkzRKCZhh+KugIcaBYO
         eyvBtSeWXRK+j0Px/pw6PoHop07FXFyzR9xpQUk6gsYSsys7787TYj8Up3o+3TL/sWzY
         4JhPvP0Gl8EjbxYsi+IZki6KjInetCAjNuvBTzgvqeCijf8v2wH2NGL392B2kZ/EzEoq
         f5bY9AN5u3fVq65JNYLCzz/tnd54ww0jEjOf1YrCp5FZRik3la1x+MXlK6WGTx2eOZ5R
         Is89jCI1j3TJ9f0jFCBdS652xdcSnZlMs6z2rt2wm9JZv96IS9hTF/Xp1U5PQbcZIIb/
         8j/w==
X-Gm-Message-State: AOAM533A4/lYBLGbtrBV1HfmdN1rcF2yjDVAqvvMJQAlqzosiwahuwKC
        fGQyb0C9DMUEXe6qPAcCAKujSngh6D9jOnp9LkFz2w==
X-Google-Smtp-Source: ABdhPJxItBVosZ/uDruXON9UjKaUomHKBQ/saLEw24DRHUV7bxJCvtK6W/ACmk2kvhtU9HGxXdNJOf9hJMCfOp0Oi7o=
X-Received: by 2002:a05:651c:169c:: with SMTP id bd28mr633015ljb.248.1628720580131;
 Wed, 11 Aug 2021 15:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
 <f1fc89894b8832ab0f64f301b1621ae15654e08c.1628618950.git.jonathantanmy@google.com>
 <YRRHO0h+eDH8oxGX@google.com>
In-Reply-To: <YRRHO0h+eDH8oxGX@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 11 Aug 2021 19:22:49 -0300
Message-ID: <CAHd-oW7NKNeujverFiRUR2p1nfOpjrv1xDrsvTVa1Yw5jC1D0w@mail.gmail.com>
Subject: Re: [PATCH 7/7] t7814: show lack of alternate ODB-adding
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 6:55 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Tue, Aug 10, 2021 at 11:28:45AM -0700, Jonathan Tan wrote:
> >
> > The previous patches have made "git grep" no longer need to add
> > submodule ODBs as alternates, at least for the code paths tested in
> > t7814. Demonstrate this by making adding a submodule ODB as an alternate
> > fatal in this test.
> >
> > Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> > ---
> >  t/t7814-grep-recurse-submodules.sh | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> > index 828cb3ba58..3172f5b936 100755
> > --- a/t/t7814-grep-recurse-submodules.sh
> > +++ b/t/t7814-grep-recurse-submodules.sh
> > @@ -8,6 +8,9 @@ submodules.
> >
> >  . ./test-lib.sh
> >
> > +GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
> > +export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
> > +
> >  test_expect_success 'setup directory structure and submodule' '
> >       echo "(1|2)d(3|4)" >a &&
> >       mkdir b &&
> > --
> > 2.33.0.rc1.237.g0d66db33f3-goog
> >
>
> This proof seems pretty handy, assuming nobody else is directly calling
> add_to_alternates_memory() (and therefore skipping the envvar check).

Hmm, there is at least one call chain in grep which might end up
calling add_to_alternates_memory() directly (although it only seems to
happen on a very specific case):

        grep_submodule > repo_read_gitmodules >
        config_from_gitmodules > add_to_alternates_memory

We can check that with the following:

git init A
git init A/B
git init A/B/C

echo f >A/B/C/f
git -C A/B/C add f
git -C A/B/C commit -m f

git -C A/B submodule add ./C
git -C A/B commit -m C

git -C A submodule add ./B
git -C A commit -m B

rm B/.gitmodules

gdb -ex 'break add_to_alternates_memory' -ex 'run' --args \
    git grep --recurse-submodules .
