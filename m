Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D91F1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 09:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfKNJxB (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 04:53:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46098 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKNJxB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 04:53:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so5650562wrs.13
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 01:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbhwYnBw4TykgG3TPyB8VhXjwFep13eKy3yx3mZfUEs=;
        b=fbKhqNKG8yOugntc57wuFwUm2b24ipAE+ZA2T2xBQfMhr57SCpGzc8KAA8sw0iKQBb
         yKKYsnlBbNCVr24Qor6FNPIdFWGXZArmTj9+828n9THqEuCK06gVJHpyOBS+xGHMHQPR
         LOaZF7ehLaYY8qfPKBVFPAdnKXbAyTBZsjRTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbhwYnBw4TykgG3TPyB8VhXjwFep13eKy3yx3mZfUEs=;
        b=Kx5LSu+p9vRbqDNEi0tJFJv0ktLWlZrgLYLYiZJPZgF04b8zSW9qjEi0V1i+2AjXtp
         Az3bFaCV5FcUbOO6+SMkHTS4s0gxvfRzHqHaq0XT5DXbHt7eXx+/dX91FRwuTRVO22WX
         jIxzo0iclyb2sTu8ed8cnBTPZuwm/fGbfu/q5pt2jGO+R4mtNgheUko+GbWVrUTd8MU7
         GOtkH4wb4y5ohrWEFYwKtXcn1EGpcVECvjkdTtLPljWtn4gej2HrqSEtvHNxsTZcuAjY
         4UuR1Y7BXjg45ofDF4giXLChczYaEd1+d5AU0hyLuM1XDkjfkf8jdbC/HstuRSs17RVP
         nRIg==
X-Gm-Message-State: APjAAAWfZsKjAdnlJn8jA1d9+Xszx+J5qoGPeHSnjPPGASAa8HOrs/qI
        NAW/TwMOFCjY6pZnQjBCt2bLOyL6GPU0I8P29m+/oA==
X-Google-Smtp-Source: APXvYqxxUvDSVmVNRohHAX681Hdq6aNHf0ibm9+MXzfvoyqJKGiVUdUPwCrQBWAkI1R7zvBrRmuoPfL2CIe0QF5b0Uw=
X-Received: by 2002:a5d:4585:: with SMTP id p5mr7488349wrq.134.1573725178212;
 Thu, 14 Nov 2019 01:52:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.465.git.1573679665.gitgitgadget@gmail.com> <xmqq5zjn9oaz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zjn9oaz.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Thu, 14 Nov 2019 09:53:10 +0000
Message-ID: <CAE5ih7-_ZESWAGAiXL4vT-P0aVYtrOAHn6dbhsfTmmeKVkSUWA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Feature: New Variable git-p4.binary
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>, Ben Keene <seraphire@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Nov 2019 at 02:36, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Issue: Using git-p4.py on Windows does not resolve properly to the p4.exe
> > binary in all instances.
> >
> > Two new code features are added to resolve the p4 executable location:
> >
> >  1. A new variable, git-p4.binary, has been added that takes precedence over
> >     the default p4 executable name. If this git option is set and the
> >     path.exists() passes for this file it will be used as executable for the
> >     system.popen calls.
> >
> >
> >  2. If the new variable git-p4.binary is not set, the program checks if the
> >     operating system is Windows. If it is, the executable is changed to
> >     'p4.exe'. All other operating systems
> >     (those that do not report 'Windows' in the platform.system() call)
> >     continue to use the current executable of 'p4'.
>
> I do not use Windows nor git-p4, but the above two changes make
> sense to me at the design level.  One thing that needs to be updated
> is the configuration variable, though.  It is more in line with the
> other parts of the system to name this "git-p4.program", because
> binary-ness does not matter much to you, as long as the named thing
> works correctly as "p4" program replacement.
>
> Seeing "gpg.program" is used in a similar way, it also is tempting
> to call it "p4.program", but no other parts of Git other than
> "git-p4" uses P4, and the "git-p4." prefix is to collect variables
> related to "git-p4" together, so calling it "p4.program" may not be
> a good idea---it would hurt discoverability.  "git-p4.p4program"
> may be OK, if we anticipate that git-p4 may need to use (and its
> users need to specify paths to) external programs other than "p4",
> but it probably is overkill.
>
> Thanks.

There's some trailing whitespace in 98bae, can we get that tidied up?

Otherwise, modulo Junio's comments, it looks good.

I agree that "git-p4.binary" might be harder to discover ("Oh, I
assumed that enabled binary mode!"). p4program should be fine.
