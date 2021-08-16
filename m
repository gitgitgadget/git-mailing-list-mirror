Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FD9C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCAC60EB5
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhHPVuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhHPVuV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 17:50:21 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DC9C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:49:49 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id 67so8163249uaq.4
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eo938mqeBMrjQ61pfrqmlh9QpfalM21sS5cv8iupG14=;
        b=EaeF+5mYJF076VIXFmkuN8amqy2FLMd8y8qmnQKvaKh7wWQsDRNmrPIMrRW8DB6mf9
         n5lLBO3HWiJQp6dLsfzhyC4HeIO6nMUOWYExiSt1r+97xoH0COtUmI7Y8bz3xwFqCOJN
         sj/04+fkr5PjX6zf6GCmkp9VGQ1jSrkvsA35FTvEKB1qkc/aNA+VWvM3iyZx1N+NM1qs
         g31G25KpSd9Wcq90FThQT8V70QPGwEZ5uJWWECMc3e1+ExwFgP3zAelZDRVBt+M+t9+i
         6VKtW3/AFzbztmSKGa3jls4usoEFpBgPV7JxlG0H6wq7srV1PPZYIzdyiIdmbgE2e6co
         WAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eo938mqeBMrjQ61pfrqmlh9QpfalM21sS5cv8iupG14=;
        b=LkgVb0TOVp2VXlivkpbt5CGIptDSV25QAxBqTpixVmbQwAVnb83GcV2B5dzvVRJfy2
         pE6f0EIsajjrvhRB4E6hVP0jTRI+BkdNLx7F3UvM+9I0uYhl/3vL1ko9LTmBgVFa9tiO
         pvVKjtN+E8I8lkEyJx3jNbd9Ge6DMM22DwA73MqFxqPPBFxRGh/tmARb9tbPmwSw+n1x
         JHgBnh9P5SEOmelAN0pwq7S/kZcMS+0HbO7SdDoVzCVADfN5verZtZ3IU9iGcNQQqfYZ
         H97T9bZAG3UWkAcKNxxjWslHSese0D+jtvHGK79lOuTl9TZVqr8UH6qtyerRAE7pyH35
         wTaw==
X-Gm-Message-State: AOAM530kvOGfMZOo8Gc/ficoNTt8pSKZPDqAWV4gZmMfCMIPWVDjWxQ2
        6Kjc83KHS0DxeKMg+/ho0n+/dpXZLP5KeUopqU6VrklA
X-Google-Smtp-Source: ABdhPJwm7cGKU6hbYGXiIMKtwpcrgXRCQXNVYxn+yMhgAhsQ0wnqwD5FWcJ3O8D47uFWsfM880aLJkaYoD1nj7n+gS0=
X-Received: by 2002:ab0:695a:: with SMTP id c26mr31710uas.23.1629150588064;
 Mon, 16 Aug 2021 14:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxxT_7weC8_O=KYScSbDcSeBdb3v5d_gtn-NXzW_fKLrsA@mail.gmail.com>
 <YRqUK3cRFJmANzDd@coredump.intra.peff.net>
In-Reply-To: <YRqUK3cRFJmANzDd@coredump.intra.peff.net>
From:   jim.cromie@gmail.com
Date:   Mon, 16 Aug 2021 15:49:21 -0600
Message-ID: <CAJfuBxxuGf4aHjD6S0sLHgM0_SkqwY5tgEVBPvTANbak+5DFLA@mail.gmail.com>
Subject: Re: git format-patch -s enhancement
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 10:37 AM Jeff King <peff@peff.net> wrote:
>
> On Sun, Aug 15, 2021 at 05:07:34PM -0600, jim.cromie@gmail.com wrote:
>
> > git format-patch -s is sub-optimal :
> > it appends the SoB,
> > which falls after the snips
> > ---
> > changelog ...
> > that the commit message may contain
> >
> >
> > So it misfires on any maintainer scripts
> > expecting the SoB above the 1st snip.
> >
> > The workaround is manual SoBs above any snips.
> >
> > I note this in -s doc,
> >
> >            Add a Signed-off-by trailer to the commit message, using
> > the committer identity of yourself.
> >            See the signoff option in git-commit(1) for more information.
> >
> > "trailer" is really "document current working behavior"
> > (normative docu-speak, so to speak;)
> >
> > Ideal behavior is to find 1st in-body  --- snip
> > and insert there
>
> The big disconnect here is that "---" snip lines are not meant to be
> meaningful within commit messages themselves. They are part of the
> process of sticking a commit message into an email. So format-patch and
> git-am know about them, but "git commit" for example doesn't.
>
> So "git commit --signoff" probably shouldn't take them into account when
> deciding the end of a commit message. The user might or might not have
> meant "---" to be syntactically meaningful, depending on whether they
> plan to send the message with format-patch (and changing the behavior
> now is questionable).
>
> Doing so with "git format-patch --signoff" is a slightly different
> question.  The current behavior is working as intended, in the sense
> that it signs off just as "commit -s" would, and then separately sticks
> the result into the email. The fact that "---" in the commit message is
> indistinguishable from the ones added by format-patch is mostly an
> accident.
>
> That said, it's kind of a useful accident for some workflows, exactly
> because you can carry these non-commit-message notes inside the commit
> message. And since we know how any in-commit-message "---" will be
> treated by git-am on the other side, it might be reasonable for
> format-patch to start considering them to be syntactically significant.
>
> So I guess I would disagree that it's a bug exactly, in that the
> workflow you're advocating was never meant to be supported. But I don't
> see any reason we couldn't be a little friendlier to it, if somebody
> wanted to teach format-patch to do so.
>

agreed, notabug.

but it might fall afoul of others' mail handler scripts,
Ive had a couple replys implying missed delivery,
maybe because of details like '---'

Im just gonna add my SoB either at commit time, or manually.
It will be interesting to see what happens to an SoB in a commit
when its revised and --- changelogged

thanks


> An alternative workflow would be to use git-notes to attach the
> changelog data to the commit. Those are shown after the "---" by
> format-patch already. Unfortunately, keeping them up to date is kind of
> annoying. Ages ago, I had a patch to let you modify them while editing
> the commit message, which makes it pretty seamless:
>
>   https://lore.kernel.org/git/20110225133056.GA1026@sigill.intra.peff.net/
>
> I carried the patch in my local build for a while, but never really
> ended up using it. So I never polished it further. But I think it's
> still fundamentally a reasonable idea, if somebody is interested in
> carrying it forward. If so, here's the version I've been rebasing
> forward over the years:
>
>   https://github.com/peff/git jk/commit-notes-wip
>
> but it doesn't seem to actually pass its own tests anymore (so it may or
> may not be a helpful starting point. ;) ).
>
> -Peff
