Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE31AC432C3
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 04:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C472080D
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 04:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnmE44Cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKYEI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 23:08:59 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34937 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKYEI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 23:08:59 -0500
Received: by mail-qk1-f193.google.com with SMTP id v23so3701506qkg.2
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 20:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfC9KzsEe0NIH9q0VlujWwkpw0e7Rnu9Eh66Ujts00I=;
        b=CnmE44Cz22BUPbxWgxgt9YtfwOAx/yEBPKKEYt1nNE8BZQ9e831B7CKYTwoGV9TV+6
         q3+oRXvWmeXgm8q/fplQxtLEMcixsvWtQl4vU3gfkJUxZ1TamMl6vs2kBlM70fjP9XUv
         PMMWtLFjhaa8Xy2KZKoKtmK6apD/u05urMHBj+1t3+dRDcFca/8tVd4GK5Z8qDJify0P
         FRJUUlFq8Lir4QcL2QF2700jJqwseLJ9uP6rbeTv5kx5CdkbCqSxmQHH1yNpZ4chxgXB
         I1oRtZgCCzykuAkFZbdEqXwC/lR3321RaQzAk6o4+O9ZVhAS/j+FBkgyDPbrSqFeBBV/
         5n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfC9KzsEe0NIH9q0VlujWwkpw0e7Rnu9Eh66Ujts00I=;
        b=qAGn44wPhFpGhey75lCwqio7Y/FxHn4OladPDiO0rhMXKN19W6ixp1hNR3D237xQRd
         Josg9YyxmQsPkW2YuGJSmA3qfMOVi0NJUZ0OSaXDz0zhmfooOX7RmwQeEuD8Zv3+RA3j
         K1e6NmcNZXnS8re+2wZK7BZ9IFkdpXg0efpgx6fCRU3VcXBlfSQdmS5O1q4hLYpbYlXD
         E4rQiKiFAs38zXeVO39sx7f1Q+d3j8mQe/RulA0psmiGDCTgBe4uEVp5kDaK78gKrswU
         jkHueB4j0wdBry/UkC5ZiGB6/lxohIaS9POSG1UGCPEJsvHZhrZqZPja/i9OCd43vWOK
         EKbA==
X-Gm-Message-State: APjAAAWORVRUgWvfLj4Vp1MPMhGGsWWinaLEXXxcIQizuMtas2pSjt0Q
        Ek/qlOpfjZG1Khw1D3oi54QWoO0h8nGN1aJNJy++4O9Uab4=
X-Google-Smtp-Source: APXvYqz8AyULYSp2d2lhmt0f1JnPfIwJR+CSqrXPEJaWtjF0k1Ew4aMTUdr8/WfX8rHX3a9F/SJnuLcCQ3WnnIVAUGM=
X-Received: by 2002:ae9:de44:: with SMTP id s65mr15711057qkf.203.1574654937342;
 Sun, 24 Nov 2019 20:08:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.472.git.1574490521.gitgitgadget@gmail.com>
 <pull.472.v2.git.1574582473.gitgitgadget@gmail.com> <e4c932bd0907daa53d1d721f9c9400bdad17fb62.1574582473.git.gitgitgadget@gmail.com>
 <xmqqfticzpke.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqfticzpke.fsf@gitster-ct.c.googlers.com>
From:   Manish Goregaokar <manishsmail@gmail.com>
Date:   Sun, 24 Nov 2019 20:08:41 -0800
Message-ID: <CACpkpxm3=6KjTjk3WAnAXg8_SibtPPo5B08d4mnOUCsMGwv9ag@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] submodule: fix 'submodule status' when called from
 a subdirectory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Manish Goregaokar via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll make the changes and submit, thanks.

> sed -e "s/ .*// >expect &&

This won't work since the output may start with a space, but I'll do
this as a two-step thing with awk

-Manish Goregaokar

On Sun, Nov 24, 2019 at 5:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Manish Goregaokar <manishsmail@gmail.com>
> >
> > When calling `git submodule status` while in a subdirectory, we are
> > incorrectly not detecting modified submodules and
> > thus reporting that all of the submodules are unchanged.
> >
> > This is because the submodule helper is calling `diff-index` with the
> > submodule path assuming the path is relative to the current prefix
> > directory, however the submodule path used is actually relative to the root.
> >
> > Always pass NULL as the `prefix` when running diff-files on the
> > submodule, to make sure the submodule's path is interpreted as relative
> > to the superproject's repository root.
> >
> > Signed-off-by: Manish Goregaokar <manishsmail@gmail.com>
> > ---
> >  builtin/submodule--helper.c |  3 ++-
> >  t/t7400-submodule-basic.sh  | 19 +++++++++++++++++++
> >  2 files changed, 21 insertions(+), 1 deletion(-)
>
> Thanks.
>
> Will queue as-is for now, but others may have comments on the patch
> (and certainly the test part would see a few issues pointed out),
> which we may want to address before this hits the 'next' and lower
> branches.
>
> > diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> > index a208cb26e1..4545b47ca4 100755
> > --- a/t/t7400-submodule-basic.sh
> > +++ b/t/t7400-submodule-basic.sh
> > @@ -356,6 +356,25 @@ test_expect_success 'status should only print one line' '
> >       test_line_count = 1 lines
> >  '
> >
> > +test_expect_success 'status from subdirectory should have the same SHA1' '
> > +     test_when_finished "rmdir addtest/subdir" &&
> > +     (
> > +             cd addtest &&
>
> > +             git status > /tmp/foo &&
>
> I think that you added this line for debugging the test; because
> what it does has no effect on anything in the test, let's remove it.
>
> > +             git submodule status | awk "{print \$1}" >expected &&
>
> This construct to have "git submodule status" on the left hand side
> of a pipe hides its exit status.  We wouldn't notice even if it
> crashes with a segfault, which is bad especially if it does so after
> showing the output we expect.  This instance is doubly bad because
> the output is not even compared against a known-good copy.  In fact,
> this is to create a known-good copy, so if "git submodule status"
> gets broken so badly that it crashes even before emitting anything,
> we would get an empty "expected" file (by the way, we tend to
> compare 'expect' and 'actual', not 'expected' and 'actual',
> especially in our newer tests) here, which would be compared with
> outputs from other invocations of "git submodule status" later in
> the test.  If "git ubmodule status" is so broken that it crashes
> immediately, these later invocations would die without showing any
> output, so all the actual* files would also be empty and out
> test_cmp would be very happy to report that all tests are good.
>
> Not so good.
>
>         git submodule status >output &&
>         sed -e "s/ .*// >expect &&
>
> perhaps?
>
> > +             mkdir subdir &&
>
> If the test fails before reaching this line for whatever reason,
> addtest/subdir directory won't exist, and test-when-finished would
> not be so happy.
>
> > +             cd subdir &&
> > +             git submodule status | awk "{print \$1}" >../actual &&
> > +             test_cmp ../expected ../actual &&
> > +             git -C ../submod checkout @^ &&
>
> Gahh.  Please stick to human language HEAD^ and avoid line noise @^.
>
> > +             git submodule status | awk "{print \$1}" >../actual2 &&
> > +             cd .. &&
> > +             git submodule status | awk "{print \$1}" >expected2 &&
> > +             test_cmp actual2 expected2 &&
> > +             test_must_fail test_cmp actual actual2
>
> Please do not apply test_must_fail to anything but "git subcmd".
> For now,
>
>         ! test_cmp actual actual2
>
> is a safer alternative.  Right now we are cooking a topic to allow
> us to write it as
>
>         test_cmp ! actual actual2
>
> but it hasn't been merged to 'master' yet.
>
> > +     )
> > +'
> > +
> >  test_expect_success 'setup - fetch commit name from submodule' '
> >       rev1=$(cd .subrepo && git rev-parse HEAD) &&
> >       printf "rev1: %s\n" "$rev1" &&
