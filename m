Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAE6C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 23:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69453207BC
	for <git@archiver.kernel.org>; Wed, 27 May 2020 23:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoVVGeTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgE0XEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 19:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0XEe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 19:04:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC44C08C5C1
        for <git@vger.kernel.org>; Wed, 27 May 2020 16:04:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x14so20559175wrp.2
        for <git@vger.kernel.org>; Wed, 27 May 2020 16:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pHXnJi803fhZxO23ujtpldm/o0TrCmHf/Q7FuCRChw=;
        b=EoVVGeTRrlfiKxj8IgIQE5J5zF05K7gjj5yqfEyTmBFKBd+n0gCMHamcdFQ/NLR10v
         xypQBiyjj47yXTyLAxs/j8x2uEq36bwKkz+7KxeaWJUKVkcx7SYWM/bTBBJYwfuRF9sr
         /WnRfE5FEpT6gjsb8bQO1YG7502yMx/dfJOXTX0IvJsQj/LuB3Ub4B7B7fb/m2ALal7j
         Q7y5mQWnwrisujzt2frL42zeI6lLbrlYPLIMK57bdOM2xaU6NT11T3Gs3hLUZwgCeCnX
         /R3cR+qfgE3yy1pbJ2IaZP2yFgD9YcC3OgavcnqVKD5q1APTOv/OvsMAlmFTkuOj6bGI
         1zdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pHXnJi803fhZxO23ujtpldm/o0TrCmHf/Q7FuCRChw=;
        b=SRAcn7xXIuxsG7I7C3PgG3ebGnr4NvPgssMo6Hdz+srv0UJdnPbsR7XEsJLiUcxV8N
         wd+8wjRbeXKJz1fidd4on7xxsNTfAULBw6Rv4JNvY4LqScssbrPp3lbcMl7WXBBUFj3k
         zPwr2bKItqD/j1xxZF1TvcuTFQH8hxuOscwk5dLHWvRhVDoZ3/4LL6Pt9rJRiL4FGWzj
         grNTmjqEGkxo4v8J+/l0gGwKGPp0ozE6BcN2msIpDqpouxuHjyks77RR/PsmFNrX+lXl
         a/beJ1EfIyst9U+Vg7jDknh/mLuFaZG3ZxIXUzwBYlooYWZJEwJ/6DZen4aRwjqsGjJZ
         AU6g==
X-Gm-Message-State: AOAM530LXXJLbttwZrIehjvd0n4BZV5ue4pTDZ8vCAwa6cehaTxyUrtD
        4AVZ9wB5iBO5KOPVQmTzOgtGTU9YTvFju+w92cE=
X-Google-Smtp-Source: ABdhPJxeltpiQ4LDOEql9TqD6KuxxHl8XyxYzinaHy8HwKUGobVpEIq9d/JQg6Dw7DgIuWWtG2tNuWu9N/49KHjC6hs=
X-Received: by 2002:adf:de0b:: with SMTP id b11mr527919wrm.346.1590620672598;
 Wed, 27 May 2020 16:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAMP9c5k=Ci8eQyOdzW7a-sssgp9g9TJ+rxAAPF3YLDCr7t6wrg@mail.gmail.com>
 <20200527224824.GA546534@coredump.intra.peff.net> <CAMP9c5=kRAfKqfWL4AJg1m9c-3OwG1Vv=vBaiOhsD6abjtXH=A@mail.gmail.com>
In-Reply-To: <CAMP9c5=kRAfKqfWL4AJg1m9c-3OwG1Vv=vBaiOhsD6abjtXH=A@mail.gmail.com>
From:   Zach Riggle <zachriggle@gmail.com>
Date:   Wed, 27 May 2020 18:04:21 -0500
Message-ID: <CAMP9c5m65hBXKgP76iUCGe79c_s5p106K6iwzJyPmm7fCsc7LA@mail.gmail.com>
Subject: Re: git grep --show-function treats GOTO labels as function names
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like that does the trick for "goto" labels, but there are
also some issue on function name parsing with attributes when they are
split onto a second line.

$ cat attr.cpp
int main() __attribute__ ( (no_sanitize("alignment")) )
{
    FOO
}
$ git grep --no-index --show-function -e FOO attr.cpp
attr.cpp=2=__attribute__ ( (no_sanitize("alignment")) )
attr.cpp:4:    FOO

Zach Riggle

On Wed, May 27, 2020 at 5:54 PM Zach Riggle <zachriggle@gmail.com> wrote:
>
> Awesome, thanks!
>
>
> Zach Riggle
>
> On Wed, May 27, 2020 at 5:48 PM Jeff King <peff@peff.net> wrote:
> >
> > On Wed, May 27, 2020 at 05:29:08PM -0500, Zach Riggle wrote:
> >
> > > It looks like there is an issue with how the parser handles "goto"
> > > labels, as it treats them the same as a function name.
> >
> > By default, the function-finding isn't aware of the specific content in
> > the file. But you can associate extensions with particular types, like:
> >
> >   $ echo '*.cpp diff=cpp' >~/.gitattributes
> >   $ git config --global core.attributesFile ~/.gitattributes
> >   $ git grep --no-index --show-function -e FOO test2.cpp
> >   test2.cpp=int main() {
> >   test2.cpp:    FOO
> >   test2.cpp:    FOO
> >
> > Usually this is done in-repo, but since your example used --no-index, I
> > showed how to set up a per-user attribute file. The "diff" attribute
> > covers both diff and grep (for diff, the hunk headers will also show the
> > function).
> >
> > The "cpp" diff regexes are built-in to the git binary. We just don't
> > associate any filenames by default. You can also add your own; see the
> > section "Defining a custom hunk-header" from "git help attributes".
> >
> > -Peff
