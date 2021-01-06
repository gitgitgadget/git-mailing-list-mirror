Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A66C433E9
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 16:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C202312F
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 16:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbhAFQS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbhAFQS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 11:18:28 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EB6C06134D
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 08:17:48 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id k7so873329ooa.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 08:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eIGFHtPkibnpR2qOhuxI6wBILHbc+2P+DOBej2PoBl4=;
        b=X8XzbrphJ8cYevwczvaXBWeueaj3BIvnFBNmWmCrCM6UBlnVvlXdXSbHeYIFMP7q8V
         U5FEkt2igziDrAypQqgFPubflDdQvEnUkGkSCxd1N0BYIqclwQ5aDDbZUWe+hxUUWNiH
         OdGVE6B+2OkK45DxxV6JdZ0bXTwZMn2iO/rC3bX4yV2pSzFccBCQ+XZ/XLPfbi8DWNIL
         UKGtyfxHUnUt9VHsjYVLi02458LgKKo3jwHr/GqdjdbXOafxTFHN8Ts2+FL+XqM4m33d
         TCYfIzj6mPGxQa/G9O8fcfHET/mCa28gVB3rrdEuTnoQZ/WxnUxrs0lSIfoFY8EJjHRG
         4ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eIGFHtPkibnpR2qOhuxI6wBILHbc+2P+DOBej2PoBl4=;
        b=ZFMUO2a9nbdaK1ovI/r7IM5+kkEJUs27NNKh6YIOV00VrZBtmjdxKg7R8EcGWs7CjM
         N8r2zlLDH/YqbIW+HRUsTp0DO/rP4IrxytI+9aCOI06yo9m6yxw4ZjrmmN0+NyC/C186
         CT1z18qoAm9cOlyMTxzQcvf6QVVx1B7J8qQF1g6cCyYLeAPmOZRuIMhg1Ew+s/FzpNmC
         ZKvSAWMBY+kqp29J4riOkEgME0As0LIMCWSjmnyKTvQj+BcEuT+4SGNmaCHcnn360Yqd
         55GNe8PpPT56f5qPz1HbUw32+rYgTESkHeXG5jcUMholcDNrGTSFn2pUz4VaH80NPzIe
         gRpw==
X-Gm-Message-State: AOAM531FECUPS3NTTeh/A17TqRMMmhPip+ONmjig0A50YYPDwfRgoX2e
        lIHdKQnfvXfIfuPfIjbYDjMmEiN5mbNB0b7fVLCAMwIGvGU=
X-Google-Smtp-Source: ABdhPJwro0nv9EEHHuSSb1oAAupQfnvANNKJg2E95oGUVIrvJc9PnL1AIVbk6/70gdMkr+DVL4nHZGwOAFlzNYvBegw=
X-Received: by 2002:a4a:ea5a:: with SMTP id j26mr3259645ooe.45.1609949867402;
 Wed, 06 Jan 2021 08:17:47 -0800 (PST)
MIME-Version: 1.0
References: <c22ba034-6d7d-866a-c6fb-d769d117eec4@daenzer.net>
 <34b425b5-0237-fb46-5613-e90346bd7114@daenzer.net> <CAPig+cSe267W7hO8a38ifCw_r4eabUA6WB9MDhS=GttTxELpVg@mail.gmail.com>
In-Reply-To: <CAPig+cSe267W7hO8a38ifCw_r4eabUA6WB9MDhS=GttTxELpVg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Jan 2021 08:17:36 -0800
Message-ID: <CABPp-BEOXgyq-JtjEkTkPe1sbW5e6hwwAgHc88n09PtAbZBBYQ@mail.gmail.com>
Subject: Re: Bug report: git rebase ignores different context, resulting in
 subtle breakage
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Git List <git@vger.kernel.org>,
        Daniel Stone <daniel@fooishbar.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 5, 2021 at 10:12 AM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> On Tue, Jan 5, 2021 at 4:34 AM Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:
> > On 2020-12-14 3:37 p.m., Michel D=C3=A4nzer wrote:
> > > (Originally reported as a GitLab issue:
> > > https://gitlab.com/gitlab-org/gitlab/-/issues/292754)
> >
> > Does the lack of response mean this is considered not a bug?
>
> Perhaps the original slipped under the radar of the area experts.
> Adding Elijah to the Cc: list...

I'm not actually an expert with three-way content merging.  That's the
stuff handled by the xdiff library; I work on the stuff above that
layer (covering things such as directory/file conflicts, rename
detection, recursive merge base consolidation, not enough or too many
files for three-way content merging, filetypes that can't be three-way
content merged such as symlinks or submodules or binary files, etc.)

It looks like Phillip already answered here too, but you had more
questions.  Maybe I could try to elaborate on the answer a tiny bit.
I did try out the testcase and noted that while "git apply" fails
(unless you pass the --3way flag), a "git rebase --apply" succeeds due
to usage of the --3way flag which falls back to a three-way merge
instead of doing a patch application.  "git rebase --merge" succeeds
since it jumps straight to the three-way merge.

git-apply/git-am need three context lines to succeed, yes, but xdiff
has a full copy of all three files it is merging.  It does NOT apply
patches.  And if you line up the relevant sections of the three files,
to me it looks like the relevant change made by
gitlab-issue-292754/pre-rebase is a subset of the change made by
gitlab-issue-292754/base.  Yes, there's just one common unchanged line
separating the two hunks in the second commit, which seems to be your
point of contention, but it doesn't seem surprising to me at least.  I
think it's kind of similar to
clean-textual-merge-but-semantic-conflict cases -- for example, one
side adds a new caller of some function, and the other side changes
the signature of that function.  That will merge cleanly, but fail to
even compile.  The "context" is different, but the only way to
correctly merge that is have a human (perhaps with the aid of an
automated testsuite) take a look at the result.  Such is always the
case with merges.

However, that's just my gut take and as I said, I'm by no means an
expert with three-way content merges.  Maybe an xdiff expert could
comment more.

Elijah
