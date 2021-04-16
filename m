Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67802C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 12:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47DBF61107
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 12:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbhDPMzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhDPMzh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 08:55:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DCAC061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 05:55:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id bx20so31001919edb.12
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 05:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENAjfa5rliul3XQTlYIVo7DPZ6hunFguCfXoiSu0h/0=;
        b=ldGRxlfZzbyla8+2fqYJ9gsLMgY7UiIld3sANn391ahgqzJtHxqKi1hhplBSdxiDcf
         pExEoE59iryJbx/RpRr8bzTmEcJT/A594I4d13cAzMsK6Qyhd0xHa1tJB3YJb96Cmjoj
         CJ04NE+3gBi/BToo8wihvRMm5wiB2IUtQU0Vqv15OMx/NflYJ6qRSyfDX+cgdFNvaGlp
         ANDWWuo0H5zSqRLvGlL+/hIovd/gI3xF/Xezv3ehgtXOzK6g6hLayPj5cIbJslbiABU9
         7j6tzrupDPpYi3QyQuQrXPNPo2uArCblzS0rORde7JxvneSZ1EQr450BPE4YkYOezzlS
         nDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENAjfa5rliul3XQTlYIVo7DPZ6hunFguCfXoiSu0h/0=;
        b=MgMHtbG0cSuEgYiKqSSqIvuW373kHFd68kcG8+4M8SBsFJfs2QsvJIeE4PTqKuwI+3
         pt0mU/eAwJ0oIIzwn1QkfkfDNLLV2YInhfPZAqEGkJ/6HBrkuYEwTeCjMWm03f7tRvWP
         ZjeqzCCHAWbvZ4862AUGIZVmCPwnBCkT9yHbmtqLTjn18DW4KXpwdXSXM5simTpDXxtQ
         e7eqmGkIR9oqqbD75GL1KFb7uw+4WnnCB2ibXRryGTWFIMEp/o0FVqbveDR09rkO+qXA
         H4dgZ63l14/B43apst0VRAd6qi4PS8wWPlj0c33XE8iEIdKJxS3jL2GaXl3fXCpgLf7S
         buCw==
X-Gm-Message-State: AOAM532vgkN5nNnWMkEGbYX5/prBis8VzJShuVjc6JGM1DxLw0EumYg+
        y/FIlDhfC0GzBp2SmAemdDJSDJuUjS7EAnogvUc=
X-Google-Smtp-Source: ABdhPJzmx1OVs6S3oqtFPG3t+hB9o8P1pVd+M4I/JVWJJLCZgSxZx+0aq+lyVMv21jja5O6m8EuTOYsFGzkB3lYxQyQ=
X-Received: by 2002:aa7:cf03:: with SMTP id a3mr9621175edy.142.1618577709688;
 Fri, 16 Apr 2021 05:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
 <pull.913.v9.git.1618245568.gitgitgadget@gmail.com> <7f645ec95f48a206311973ee45578ba14ac58b7f.1618245568.git.gitgitgadget@gmail.com>
 <xmqqsg3vb51n.fsf@gitster.g> <CAP8UFD1r2kUaKbjFcRn_FGxz5=hvwY+DHdmPKR61cNdHzBe26A@mail.gmail.com>
 <CAOLTT8TB9UF5z-51pLxdkRUxo5-w2+_U_e1wpDAdzBBmT3Og7w@mail.gmail.com>
 <xmqq35vum1rn.fsf@gitster.g> <CAOLTT8TNK55AprX2tezoX4YjWV31RRyLWc9NJOvidRqqSgBpQQ@mail.gmail.com>
 <xmqqv98oy5bh.fsf@gitster.g>
In-Reply-To: <xmqqv98oy5bh.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 16 Apr 2021 14:54:58 +0200
Message-ID: <CAP8UFD2J8jz2Ku4ur_L+36b9hKB5drrexKNHYF6dM9G9BKhFug@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] [GSOC] trailer: add new .cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 14, 2021 at 10:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >> So I am waiting to hear why it is not a misfeature.  If it is not,
> >> then surely I am fine to keep it for now and add a workaround later,
> >> but until that happens, I do not think "commit --trailer" can be
> >> used as a way to allow end-users emulate "-s" for their favorite
> >> trailer like helped-by, acked-by, etc.
> >>
> >
> > If it is really necessary to solve this "empty execution" in .cmd,
>
> > Maybe we need to consider two points:
> > * Do we need a new config flag as you said `[implicitExecution = false]`
> > or just drop it? Has anyone been relying on the "empty execution" of
> > .command before? This may be worthy of concern.
>
> Yes, if it is useful sometimes to run the .command or .cmd with
> empty <value> even when nobody asks for it on the command line with
> a "--trailer=<key>:<value>" option, then I agree that the users
> should be able to choose between running and not running [*].
>
> > *  Do we need `trailer.<token>.runMode` as Christan said before?
> > I rejected his this suggestion before, and now I regret it a bit.
>
> So far, I haven't heard anything that indicates it is a useful
> behaviour for .command,

Well the `git config trailer.sign.command 'echo "$(git config
user.name) <$(git config user.email)>"'` has been documented in the
EXAMPLES section of the `git interpret-trailers` doc since when
".command" was implemented, and I believe that reviewers thought that
it was a good feature to have then.

> so my preference is to get rid of the
> behaviour when we introduce .cmd to deprecate .command; yes, until
> we get rid of .command, the behaviour between the two would be
> inconsistent but that is unavoidable when making a bugfix that is
> backward incompatible.
>
> When (and only when) anybody finds a credible use case, we can add a
> mechanism to optionally turn it on (e.g. .runMode).
>
> That is my thinking right at this moment, but that's of course
> subject to change when a use case that would be helped by having
> this extra execution.

Such use cases and some of this were discussed when `git
interpret-trailers` was initially implemented.

For example in https://lore.kernel.org/git/CAP8UFD2oXpW9QEkSh+vpNGRAxRFp0zJF39ZZ8sUZLTcKB9mHWQ@mail.gmail.com/
I suggested the following:

         [trailer "m-o-b"]
                 key = "Made-on-branch: "
                 command = "git name-rev --name-only HEAD"

when someone wanted a way to always add "a trailer for the branch that
the commit was checked in to at the time"

In https://lore.kernel.org/git/534414FB.6040604@alum.mit.edu/ Michael
Haggerty suggested:

"Maybe there should be a trailer.<token>.trimEmpty config option."

I haven't fully checked the discussions, so there might be other examples.
