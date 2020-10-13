Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC231C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 17:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D9625391
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 17:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK4cvlj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgJMR5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 13:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbgJMR5G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 13:57:06 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EC7C0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 10:57:06 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id y127so98313ooa.5
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 10:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aGJPjBRUr8YmS3Z932EuFPp3auCvB90lO5ZdqSmQU2M=;
        b=VK4cvlj5msWdilJQkJUINxMCsbpE/AWYh4PDXe3Hnq+JO44nm6wdXyaVWWamG0kqLF
         ynL7Wxs+/AGhU7PS6I3EetbtAsEE47EmBmFW27HvDboD7kQIhRqr1KURjbXnuV8TnTvB
         7iWS0fNLvPQ1N9LeR//ruoy5haJDLF38HYsNjcz7zWSkKdkrKuCuakdlLOLmrd69oB1r
         sKdmD3sunKxtiNFn1L3omuxHjumODVtf9yekg1PK6oWxBJWdeuEMr98/wJw0HW66ijRK
         ckWGqPQeF8ZI8QKGSZEp7OY08gU/gByFi+YaDEsq/CpvsmNitVuEllbKigRLUnQ2lQAT
         kKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGJPjBRUr8YmS3Z932EuFPp3auCvB90lO5ZdqSmQU2M=;
        b=ukhE+xu/pEi1F6ItdbIuVuPjZFIP1/VgAsmvGyHsxWZl7k5J8rOiIotFNVhBqHkrUJ
         J3jEr5nuMQb9AdSGO9Iuhvnc35ijJqdvCKYsJnURg1F1abWtCNLd8kd26lKtdGb4FFpG
         vtCobTmfkKTrcuMqlauacaaL/RiwZ25YuCNi9bPqc0Y14GoCQfEjiG/0IEgCQLaDxZ0i
         a0yMr8AVmBql3C6wc2pUVFXUnobUzAKv/cX2azz8ntUTDXw513WsL5HCiaU7Lli+Ffvj
         ekv82ioI1vXEVFRp4e4E18mDYDJCMde0KE10PVgR2vPPHqbjSutSKd+rLwqiE4xUgo8f
         apsw==
X-Gm-Message-State: AOAM532Z1/tTP/DKdnzb15ZmWti9z73LxowvKx5bHDAJYBcida1f7x6s
        tXSt6XLZhjhYc51v7Amdrr1myBr0XSgIiiW4c/SdKx+dXOb6PA==
X-Google-Smtp-Source: ABdhPJwRLwCI2u5Ms/nrd8yf94QzICD1LenMgXC5TaQaIuuywVC43R7CWUCXjodknQEc+aru69rkIHM7QGC1MYY88Y0=
X-Received: by 2002:a4a:b443:: with SMTP id h3mr413599ooo.45.1602611825293;
 Tue, 13 Oct 2020 10:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <bb2317972a8faf0358aaad1247fdfd2af2ea142d.1602545164.git.gitgitgadget@gmail.com>
 <20201013154439.GB1913367@nand.local>
In-Reply-To: <20201013154439.GB1913367@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Oct 2020 10:56:54 -0700
Message-ID: <CABPp-BFj0S1Z7rgNGsUuRurNgKFOqtD_Nm0Dr3fZt-RFMTwoDw@mail.gmail.com>
Subject: Re: [PATCH 3/3] test-lib: reduce verbosity of skipped tests
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 8:44 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Oct 12, 2020 at 11:26:04PM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > When using the --run flag to run just two or three tests from a test
> > file which contains several dozen tests, having every skipped test print
> > out dozens of lines of output for the test code for that skipped test
> > adds up to hundreds or thousands of lines of irrelevant output that make
> > it very hard to fish out the relevant results you were looking for.
> > Simplify the output for skipped tests down to just showing the one-line
> > descriptions.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  t/test-lib.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 2aca398e1e..7602bbe9e9 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -1059,7 +1059,7 @@ test_skip () {
> >                               "      <skipped message=\"$message\" />"
> >               fi
> >
> > -             say_color skip >&3 "skipping test: $@"
> > +             say_color skip >&3 "skipping test: $1"
>
> I would be comfortable going further than this and removing this line
> entirely. We need the "ok $test_count # skip" below since it's part of
> our TAP output, but now the output looks somewhat redundant.
>
> With this patch running a test that I'm working on with `--run=...`, I
> get output that looks like:
>
>   skipping test: writing bitmaps via command-line can duplicate .keep objects
>   ok 2 # skip writing bitmaps via command-line can duplicate .keep objects (--run)
>
>   skipping test: writing bitmaps via config can duplicate .keep objects
>   ok 3 # skip writing bitmaps via config can duplicate .keep objects (--run)
>
> Scanning over the same test description twice per skipped test makes the
> output difficult (but still much easier than before) to scan. What do
> you think about either of the following:
>
>   skipping test: writing bitmaps via command-line can duplicate .keep objects
>   ok 2 # skip (--run)
>
> or:
>
>   ok 2 # skip writing bitmaps via command-line can duplicate .keep objects (--run)
>
> I have a slight preference towards the latter, since it keeps more of
> the information in the TAP line, and it cuts the total line count of
> output from skipped tests in half.
>
> For what it's worth, I'd also be fine with the patch as-is.

I was worried that shortening it as much as I did would run into
objections for some obscure reason.  But if no one objects, I think
I'd also prefer your latter suggestion for shortening it even more.
It looks like the dual output for skipped tests comes from commit
04ece59399 ("GIT_SKIP_TESTS: allow users to omit tests that are known
to break", 2006-12-28) by Junio, so it'd be nice to hear his opinion
on how much we shorten it.
