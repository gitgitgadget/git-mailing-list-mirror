Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2768C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 23:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B48207BC
	for <git@archiver.kernel.org>; Wed, 27 May 2020 23:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwucVz+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgE0XF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 19:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgE0XF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 19:05:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32535C08C5C1
        for <git@vger.kernel.org>; Wed, 27 May 2020 16:05:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f5so1272696wmh.2
        for <git@vger.kernel.org>; Wed, 27 May 2020 16:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvYxbSfl1Q6tbC62N7MRTJmMgO8vLzkJylFjQRRe9pI=;
        b=qwucVz+esEqNhcSp/j9T806L27zNdi9oKOYGgFi2Ula+d/eP3oqj+pK475qJZ7OYMu
         RNlijkrNFm7im4MmBEu2e9VsIogJqX/teNokzKq1IPc3sZZrB+8hem7kPZ1G0JqDAC1g
         UXFfCzhVHw3Z3mDv7LjqRMfGSuuJ//LXjR4swAARQfpYMX13C+Zjx+1YUBhTCh7bGJrX
         hV33qfL6VvLdZV6ttnmHF+y/Egb6y5CQh4R7IpxWLLglZthZFCU/2Lb4IFSiVn/k51mB
         Cx46GfKHy8XrScesSI82QXsNg4ppzmihzkm4n7IbZeMAcO4D2BGgqjufuYwz+7dC3vXf
         2NUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvYxbSfl1Q6tbC62N7MRTJmMgO8vLzkJylFjQRRe9pI=;
        b=q/x8cPyAUTNeCO2kikGEPDXb94sYZUnxaJ7kbK10Ta72iSZehLOsnpglPGguDlCUDm
         C7LGXQ8HJ/6jDfnNE0H1R10VG3sOum/SH+ygCF7DKwVbD9vKYzy1NzoSLv+Lw3H3W8jk
         /YugWPxJe7J0eJvBaRy6EBFp6lkXsPGS8Fbx7zjqs/0xmgdIVLydm6KsMmDqSSgXn6vx
         kVSiuNzWE2fpG6Fw6MsfjmkU6kXpNpWwuGigK3v0f5/hCwhDFCrVm2QuA5MG79a7gc4m
         ijGVJzWpTUHwvHj2OKp2Oats8Yg5624NTLjRfTCuvKFNPebmnVdTX22TNShePuhFB9Xn
         tTJw==
X-Gm-Message-State: AOAM531UAZ/nVe2sP9mRigHrT+x0pnYaCooYLAFQrqHLElQcgO5zEjdP
        o2k346/qqpN1l8pkLHINbBOfd5vTKm9zwAvJmL8=
X-Google-Smtp-Source: ABdhPJwrqfVYWi37DHObI0HgotvMYzM+brGbeH6zr5cFiGeYsVlB0M1pLeKiIAvhOO6+ggEUU+ZgJI6A0Cu4vyBriCU=
X-Received: by 2002:a1c:c203:: with SMTP id s3mr380528wmf.174.1590620725849;
 Wed, 27 May 2020 16:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAMP9c5k=Ci8eQyOdzW7a-sssgp9g9TJ+rxAAPF3YLDCr7t6wrg@mail.gmail.com>
 <20200527224824.GA546534@coredump.intra.peff.net> <CAMP9c5=kRAfKqfWL4AJg1m9c-3OwG1Vv=vBaiOhsD6abjtXH=A@mail.gmail.com>
 <CAMP9c5m65hBXKgP76iUCGe79c_s5p106K6iwzJyPmm7fCsc7LA@mail.gmail.com>
In-Reply-To: <CAMP9c5m65hBXKgP76iUCGe79c_s5p106K6iwzJyPmm7fCsc7LA@mail.gmail.com>
From:   Zach Riggle <zachriggle@gmail.com>
Date:   Wed, 27 May 2020 18:05:14 -0500
Message-ID: <CAMP9c5nROh5DxbfwgKL3vNWsr=RYYgkEHCeaEMVN3gq1xkPkLA@mail.gmail.com>
Subject: Re: git grep --show-function treats GOTO labels as function names
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I made a mistake copy-pasting; things work correctly when the
attribute is on the same line, but not when it is split:

$ cat attr.cpp
int main()
__attribute__ ( (no_sanitize("alignment")) )
{
    FOO
}

Zach Riggle

On Wed, May 27, 2020 at 6:04 PM Zach Riggle <zachriggle@gmail.com> wrote:
>
> It looks like that does the trick for "goto" labels, but there are
> also some issue on function name parsing with attributes when they are
> split onto a second line.
>
> $ cat attr.cpp
> int main() __attribute__ ( (no_sanitize("alignment")) )
> {
>     FOO
> }
> $ git grep --no-index --show-function -e FOO attr.cpp
> attr.cpp=2=__attribute__ ( (no_sanitize("alignment")) )
> attr.cpp:4:    FOO
>
> Zach Riggle
>
> On Wed, May 27, 2020 at 5:54 PM Zach Riggle <zachriggle@gmail.com> wrote:
> >
> > Awesome, thanks!
> >
> >
> > Zach Riggle
> >
> > On Wed, May 27, 2020 at 5:48 PM Jeff King <peff@peff.net> wrote:
> > >
> > > On Wed, May 27, 2020 at 05:29:08PM -0500, Zach Riggle wrote:
> > >
> > > > It looks like there is an issue with how the parser handles "goto"
> > > > labels, as it treats them the same as a function name.
> > >
> > > By default, the function-finding isn't aware of the specific content in
> > > the file. But you can associate extensions with particular types, like:
> > >
> > >   $ echo '*.cpp diff=cpp' >~/.gitattributes
> > >   $ git config --global core.attributesFile ~/.gitattributes
> > >   $ git grep --no-index --show-function -e FOO test2.cpp
> > >   test2.cpp=int main() {
> > >   test2.cpp:    FOO
> > >   test2.cpp:    FOO
> > >
> > > Usually this is done in-repo, but since your example used --no-index, I
> > > showed how to set up a per-user attribute file. The "diff" attribute
> > > covers both diff and grep (for diff, the hunk headers will also show the
> > > function).
> > >
> > > The "cpp" diff regexes are built-in to the git binary. We just don't
> > > associate any filenames by default. You can also add your own; see the
> > > section "Defining a custom hunk-header" from "git help attributes".
> > >
> > > -Peff
