Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8061C8B4D0
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D028D20855
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="WDJ6+Eua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgKPMh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 07:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgKPMh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 07:37:29 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3DCC0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 04:37:28 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id i17so18834629ljd.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 04:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0M3XDgmSpSlKN7uGVbgpUk2zkeT30ZUDpuePr25Lks=;
        b=WDJ6+EuaOlz3jxU6KmvtlSCf+jUZQ+VDGWhe6fDkiRWsadv1IpegtO+yOQjd6EZuwg
         5eD00LT0IgEobbaQ4437tgiRsA7g1XDXOBHTtRLnn0fKd70Dx529ezZ3oJxsD33CLRQS
         k/ACRx3naaSEZbMf+C8b1uOpOYF2EU+pdx/pG+UGAUKrn87ZGvoNa+ag9bs9rOinz62j
         ev3RszjXa+79mmK9zXKyxc07PuizXPCrDhq2lyd7P906jTU5nTqaD4jm3OpJOA7+qCC0
         EoUlTPm1Gjhu3HyWH0TT9Ex4IugpA4fy8cFGZzyPBHJbu0K8ZbfPahSwiPTLN4bfiAWq
         jSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0M3XDgmSpSlKN7uGVbgpUk2zkeT30ZUDpuePr25Lks=;
        b=GXkwGWYwL90oOl1gb/ohk+iI1zZlD7sKWHDX0NQDtbYHPdrxdBAqn1RtQ4iGed2Ieq
         tSCglgaFWwmQTsHuAPcNoEUVMAQYRe3naeK8j9YZ5BRhJRN6ZSc4pxxZ6c14nS5FNAtD
         dlG8+UiQlmw9ZOF13FU0/MTN6uIswmza0J2BgBnRpXysZvIruYOAJVipkb9VufbvnMn6
         6FjrZln8kmkZa0L+fyLv2aWR4i4jhdZknwbiZn4OtlS2kaoM1Ddl428HU+lTpxTCq7f2
         0gi2sU2p0/n36Y3J4raaA1abDRyBn3fHk6IhFw7EJpIfBPXcDUwTRpqKVHcBsBusaVe8
         19pw==
X-Gm-Message-State: AOAM533rHiZMxnH0QakJZQ5XabtcYBn0eZ+N4/3t5o9a0aHFZMhQYNx6
        yJGrQ62U8r6FKdAKwuOSRm3VFK9OpMMCJNsz/QyR6A==
X-Google-Smtp-Source: ABdhPJxfhuBExooABFcfIfDyFokKxJrn1a7/9ZhYx18i4n8oq6zqWz/AXgeTQDlU1PMaUrYaihLRr59u2cmUryB/SWs=
X-Received: by 2002:a2e:9988:: with SMTP id w8mr6570331lji.107.1605530247431;
 Mon, 16 Nov 2020 04:37:27 -0800 (PST)
MIME-Version: 1.0
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
 <CABPp-BGkkNwdjLB4HSygvU43OZRiuhDyt7RjrDGodWrfNgkBXQ@mail.gmail.com>
 <70ae5b1d-b1d2-1b3f-11cf-8e5ceafe6048@gmail.com> <CAHd-oW7X3fEM8PDFWQVc4kG_vfkY4LbvADzJfQrocjyaAr28TQ@mail.gmail.com>
 <79313c8c-c927-78d4-bb1d-024f9feb553c@kdbg.org>
In-Reply-To: <79313c8c-c927-78d4-bb1d-024f9feb553c@kdbg.org>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 16 Nov 2020 09:37:16 -0300
Message-ID: <CAHd-oW4OVDvfkaMjsO4vLvwrnHbyhngwW2y6AkoScJmS6XGVeQ@mail.gmail.com>
Subject: Re: [PATCH] rm: honor sparse checkout patterns
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 15, 2020 at 6:42 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 15.11.20 um 21:12 schrieb Matheus Tavares Bernardino:
> > Thank you both for the comments. I'll try to send v2 soon.
> >
> > On Fri, Nov 13, 2020 at 10:47 AM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 11/12/2020 6:54 PM, Elijah Newren wrote:
> >>>
> >>> Do we also want to include a testcase where the user specifies a
> >>> directory and part of that directory is within the sparsity paths and
> >>> part is out?  E.g.  'git sparse-checkout set /sub/dir && git rm -r
> >>> sub' ?
> >>
> >> That is definitely an interesting case.
> >
> > I've added the test [1], but it's failing on Windows and I'm not quite
> > sure why. The trash dir artifact shows that `git sparse-checkout set
> > /sub/dir` produced the following path on the sparse-checkout file:
> > "D:/a/git/git/git-sdk-64-minimal/sub/dir".
>
> If 'git sparse-checkout' is run from a bash command line, I would not be
> surprised if the absolute path is munched in the way that you observe,
> provided that D:/a/git/git/git-sdk-64-minimal is where your MinGW
> subsystem is located. I that the case?

Yeah, that must be it, thanks. I didn't run the command myself as I'm
not on Windows, but D:/a/git/git/git-sdk-64-minimal must be the path
where MinGW was installed by our GitHub Actions script, then. I'll use
"sub/dir" without the root slash in t3600 to avoid the conversion.
Thanks again!
