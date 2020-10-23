Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3A7C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 17:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F15920EDD
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 17:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/evkNM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbgJWR0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 13:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461030AbgJWR0G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 13:26:06 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A6CC0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 10:26:06 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id f37so2031290otf.12
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLjKdCn0Tey64Zl65PyolOaP46KSYDu3MDpbWtPjeHk=;
        b=V/evkNM2KYnNigHikzZRrqkEqtxcY3OqaN7E/cyfXnh+1FvW1cJT3/FXelICPidLP/
         az4hCC/xvXXhC2lnU7PmV4Lvwdsgo6MsQikFjVcJI5bz5Zff/p8KguGqhNSG4sWQzokC
         ZavN8kPL27IszKGI57X82rTKfN01blONcWoFd7EEYQGrrfHrxnqn4iOFTnjkCKe70a0g
         A2i0V1ebyWkVgViQpfAmvOpvIGyzD5BDdRzUQKIJShwdvMyShcE8gvP+plvCFogsFn87
         jEHTFw4zJQ+G57UUr9DehdVJFi+8NIS24lPK0HaPtOmvbBts6rbg2m1Rbs1B8CiHe2CU
         Vkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLjKdCn0Tey64Zl65PyolOaP46KSYDu3MDpbWtPjeHk=;
        b=XEBKspjx225VkUDISeb8Ta9BzAmVMrhhwWmlUiMaZQVq7drbQDMPzG1qJXoAWN5ICA
         fn5+3Ps+1nhFCBfrV74Notdx1A6WHAw0PjUCOeTMPfHvPgPbglcuwEgnVbK5mzMKULSo
         sNBKbk3VYmVKy1bIfc96sd1cLD3HUhpgSEEZF3b8K+yzi6qsDyXPcGI3cAVWNFDCMlas
         ywsrMP9IWAqhm2WPj7Hw79hvI2j+VrbGzSNf8aFogbGuWnaoHLZa0HWiiaJwf66CZrG+
         BG/kTkoCFWbeKtC5wEx5uZ6X5/tkAbs0ttFtXonMfNtSu6hJsvw/XEHA8oxOL/uTcugE
         zy6A==
X-Gm-Message-State: AOAM531ogAZVUYCjthDHy0XdAz9YiKRmyAJtVGUK7BSxX0oSPL6WtHLf
        cOoG5LOO8I2bOgZPLFywN9lBQ1OICKmLmn0uAJNLIddAx1c=
X-Google-Smtp-Source: ABdhPJzznNrIAr8VETLhmITHedyXVbT0MouAP4cUwwqDj2GuUaV5oac8/2TCyRM1MQOkzRWVQ7w8Mi/UJm4sA/0ZB8Y=
X-Received: by 2002:a05:6830:30ac:: with SMTP id g12mr2526164ots.162.1603473965590;
 Fri, 23 Oct 2020 10:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
 <a8d4825a323d5c1e7b2dc1edc8621c51c030ae1e.1603468885.git.gitgitgadget@gmail.com>
 <xmqqr1pohos4.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1pohos4.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Oct 2020 10:25:54 -0700
Message-ID: <CABPp-BEtBWktGB0ksfk5YLhVDfmUJ-QxUMiYtMANL1KhXd8qTA@mail.gmail.com>
Subject: Re: [PATCH 1/9] t/: new helper for tests that pass with ort but fail
 with recursive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 23, 2020 at 9:48 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > There are a number of tests that the "recursive" backend does not handle
> > correctly but which the redesign in "ort" will.  Add a new helper in
> > lib-merge.sh for selecting a different test expectation based on the
> > setting of GIT_TEST_MERGE_ALGORITHM, and use it in various testcases to
> > document which ones we expect to fail under recursive but pass under
> > ort.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  t/lib-merge.sh                         | 15 +++++++++++++++
> >  t/t6416-recursive-corner-cases.sh      | 11 ++++++-----
> >  t/t6422-merge-rename-corner-cases.sh   |  7 ++++---
> >  t/t6423-merge-rename-directories.sh    | 13 +++++++------
> >  t/t6426-merge-skip-unneeded-updates.sh |  3 ++-
> >  t/t6430-merge-recursive.sh             |  3 ++-
> >  6 files changed, 36 insertions(+), 16 deletions(-)
> >  create mode 100644 t/lib-merge.sh
> >
> > diff --git a/t/lib-merge.sh b/t/lib-merge.sh
> > new file mode 100644
> > index 0000000000..fac2bc5919
> > --- /dev/null
> > +++ b/t/lib-merge.sh
> > @@ -0,0 +1,15 @@
> > +# Helper functions used by merge tests.
> > +
> > +test_expect_merge_algorithm () {
> > +     status_for_recursive=$1
> > +     shift
> > +     status_for_ort=$1
> > +     shift
>
> Smaller than minor, but I'd find
>
>         status_for_recursive=$1 status_for_ort=$2
>         shift 2
>
> easier to see that which one is for which by matching the order in
> which the calling sites, e.g.
>
>         test_expect_merge_algorithm success failure \
>                 here comes the commands being tested
>
> lists them.

I can fix that up.

>
> > +     if test "$GIT_TEST_MERGE_ALGORITHM" = ort
> > +     then
> > +             test_expect_${status_for_ort} "$@"
> > +     else
> > +             test_expect_${status_for_recursive} "$@"
> > +     fi
>
> I expect this to be purely transitory, so it is fine.  If not,
> something along the lines of ...
>
>         eval test_expect='$'status_for_"$GIT_TEST_MERGE_ALGORITHM"
>         $test_expect "$@"
>
> ... might be what I would suggest, though ;-).

I also expect it to be transitory, but how long that transition is
depends more on how long it takes for others to become comfortable
with removing merge-recursive.c once merge-ort.c is in place.  I
suspect at a minimum it's a cycle or two after ort becomes the default
(which at a minimum would come a cycle or two after ort is finished
and available).  If for some reason folks don't eventually become
comfortable with removing merge-recursive, then we might need to
revisit.

> And the users are just too pleasant to see, with full of "failure
> sucess", which is the second best outcome we want to see ;-)
>
> > +test_expect_merge_algorithm failure success 'check symlink mo...
> > +test_expect_merge_algorithm failure success 'check symlink ad...
> > +test_expect_merge_algorithm failure success 'check submodule ...
> > +test_expect_merge_algorithm failure success 'check submodule ...
> > +test_expect_merge_algorithm failure success 'check conflictin...
> > +test_expect_merge_algorithm failure success 'rad-check: renam...
> > +test_expect_merge_algorithm failure success 'rrdd-check: rena...
> > +test_expect_merge_algorithm failure success 'mod6-check: chai...
> > +test_expect_merge_algorithm failure success '6b1: Same rename...
> > +test_expect_merge_algorithm failure success '6b2: Same rename...
> > +test_expect_merge_algorithm failure success '10e: Does git co...
> > +test_expect_merge_algorithm failure success '12b1: Moving two...
> > +test_expect_merge_algorithm failure success '12c1: Moving one...
> > +test_expect_merge_algorithm failure success '12f: Trivial dir...
> > +test_expect_merge_algorithm failure success '4a: Change on A,...
> > +test_expect_merge_algorithm failure success 'merge-recursive ...

:-)
