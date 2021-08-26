Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326BEC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 07:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10649610E9
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 07:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbhHZHtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 03:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239817AbhHZHtk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 03:49:40 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC3FC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 00:48:53 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id k24so1411331vsg.9
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 00:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIRmUJHHvnC+UHeCYv+oHPe8gxiAMUilRBr28tAUCTQ=;
        b=aDuLKPqTAOC8ha4Vbx+dtHrdYangdiMF78gj/XwETNRPnE9zyH9lLJpQFwsq3KWJhU
         OD6V8undu/qJrY8xw/h/1kMgjYgjNiU4qt7OOr8vKk0SHg+HJtNY6oEn7a5cL10D/A1x
         Lf5ouhkKjVNHRaF8rvqqYwxT2MYqr8q69qFfA1s+O38CH3qj44xunTLOtPNrTb3swyZk
         u15DKjh6rZDH0l6f8rME4SIt8M8+IT2SHFwn9RBQGZitvkfvZDQ8odJiUU0NXhyV3dbh
         8Z1JYbpJ9iTQPY/oy34h5nyERyjAAIIlk/LeA0CCFqFy81oz9vHeRoouQ/Z10/kjrmhZ
         kpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIRmUJHHvnC+UHeCYv+oHPe8gxiAMUilRBr28tAUCTQ=;
        b=CWfzzXH2Cy3JnYN5a544xKzO4/r5bko0W8zi2Uyh2mgXb+jqCeRtW61eAw9eqEnXvi
         GnhFon8u3jCcgzi74wFp80MNb0nnU2LYTlwYPgUFjZsWwNgoVp+mV4d9Sb3VfSuhuYiI
         2cNNZ/hUN0Q0LHyZVgX83AtWdlkD08sFe20ldnkqFSlPrsVnmHctAgruNz//edGvQESY
         APkbpJbEBRd3VHmehRKiug4PILT2TcZDRiBjW5gNTVbhdnosbVrkWPyoABj2WwMqxgJX
         1RXKQrFRC5+Sawnlg66Yoy4G7vv+cQHb7u2o8IV1BA7KKxAIrcv+MlU5NI05KrJoK1zb
         200A==
X-Gm-Message-State: AOAM533h5/bmIk4ynBvvvGvUUV07T/8d5NmnmRMtivpilPEuB2CexjOc
        6ElGYT/OR+v7Eg1ODKTT7fujzQOaXTeGqobqVOeR7VSI
X-Google-Smtp-Source: ABdhPJzS9ErEu0phDCOHVcQnYRe9LUTqNK6GFhgzj6DBKahK1nojcRyG8u6sNKUlWbiUsOhn1MrY5nDlpkZse/Zkj2U=
X-Received: by 2002:a05:6102:11e3:: with SMTP id e3mr1239207vsg.49.1629964132441;
 Thu, 26 Aug 2021 00:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210826031710.32980-1-carenas@gmail.com> <YScXboC0M1IPNFon@nand.local>
 <xmqqlf4ohgdv.fsf@gitster.g>
In-Reply-To: <xmqqlf4ohgdv.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 26 Aug 2021 00:48:41 -0700
Message-ID: <CAPUEspj4F6=c_WPnb==enx6n1wY6LgOXbRm_kZCSnoOf5qcNsg@mail.gmail.com>
Subject: Re: [PATCH] test-lib-functions: avoid non POSIX ERE in test_dir_is_empty()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jens.Lehmann@web.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 11:25 PM Junio C Hamano <gitster@pobox.com> wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> >> -    if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
> >> +    if test -n "$(ls -a1 "$1" | grep -v '^\.$' | grep -v '^\.\.$')"
> >
> > This replacement is correct, but I'm not sure that I necessarily find it
> > simpler. If we really are concerned about egrep usage, then
> >
> >     if test -n "$(find "$1" | grep -v '^\.$')"
> >
> > would suffice. But it looks like we are fairly OK with egrep in t (`git
> > grep 'egrep' -- t | wc -l` turns up 19 matches), so I'm not sure the
> > change is necessary in the first place.
>
> It is true that we have been OK with egrep.

note that will be an issue at least in a future release of GNU grep
where the deprecated {e,f}grep commands won't be available.

> "grep -E" is in POSIX (so is "grep -F") and that you might be able
> to make an argument to use them instead of "egrep" and "fgrep".

I misread the POSIX specification, and had confirmed that the ?
operator works fine in BSD and busybox grep so apologies and
will see to resubmit this change together with the others that will
be required to deal with the deprecated binaries.

> at least at one point in the past, 87539416 (tests: grep portability
> fixes, 2008-09-30) favoured "fgrep" over "grep -F", claiming that
> the former was more widely available than the latter.
>
> The world may have changed since then, though.  IIRC, the 2008's
> topic was mostly about portability to Solaris and AIX, and their
> peculiarity (or their relevance) may have waned.

was hoping to deal with fgrep using a function (just like is done with
perl), but was also hoping that a compatibility layer wouldn't be
needed.
testing on AIX (that seems to stick around) will definitely be needed.

Carlo
