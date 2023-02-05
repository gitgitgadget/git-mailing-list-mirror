Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C40C636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 06:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjBEGen (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 01:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBEGem (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 01:34:42 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC5E1C7F4
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 22:34:41 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s8so4133828pgg.11
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 22:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hbu4Wexu/Www8khq9kBmzC/SUh1fmph5B3HooqN/5vo=;
        b=U7A2NvosV9/eLrvvnaWnQHOUaztRMkEGVGPvWZg3HuZ68WAUcvr6drmhBJJoZHTX6o
         i6yOLtxadV6OcNWqTzbNHGaIVcMzT7DApNWN6CPJDIxm07ofoxjLO3Wy6p8ew80TvCfO
         x1IlIy87CKugXyg/pmsKHXn7B0crOwLWpI2U5ByA7osJ5OU5Whjqi3aeI274qRqms5zZ
         pq1zeV2xQbnClIXgl/vqFEqaBWDg5sxbZ5Yik4bcewMShDsamB4NgVB4lfE4+tjZoeEd
         1nqV3bUSBEAOJIMRgJC43zVptYa1w4YuX9NfFYE4p22NNAe5WYiw2UDe6q2cxUzcjKLc
         8bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hbu4Wexu/Www8khq9kBmzC/SUh1fmph5B3HooqN/5vo=;
        b=2KlxMdsizxFOGVfJM3oNGSNmWCJ4MIIw9RgnwSowdOLD16+oitXKnLP+bHweQwwxkG
         5p0fpyIqYh/n4iwlkjduor/e3bw1DKQJL9XXf791wytNmZlZHZ+uD5U/vJfrQgo3zUUT
         rJ9HgNVnkhvaeYqfBRAxYGxQPiCaBG0XmZuhYgS8xxhJ7yNYdXBlRl0tLxovt5Me5T8A
         AOPCgKQxPGQvkLD0+Dhd1lPW0nDr8XMQ7u3OJcjcbRqB/0VaA5LDcBH1vaRj1bYC0YVi
         qHbw+R/CVgRSqQJxLf5tUkFt9f5QpIWZ4kei9nLwUXp6AQ7CXHVOY5XItYtRTSkZAnkf
         P61Q==
X-Gm-Message-State: AO0yUKWI8tkYrGFhkB81JBloUz7i3FPBxPNGJtY5FhnzCzETS1R3NEjX
        Dpjt3lKOD0Abxv9T6xfifMrCvvF3pB14jFhTrKFu7BB2ClabYQ==
X-Google-Smtp-Source: AK7set9JlDcBpQxjBwa8CFVSr3TvjdlhjpyEn/DfQ4Ic+2z74LG4ewhcLpSn9IYDpchR2W6ZQrLd8rfesIJP4WRg6Fg=
X-Received: by 2002:a05:6a00:809:b0:592:5885:862f with SMTP id
 m9-20020a056a00080900b005925885862fmr3505484pfk.18.1675578880248; Sat, 04 Feb
 2023 22:34:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
 <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com> <Y9pWxHfgPtgCKO+B@coredump.intra.peff.net>
In-Reply-To: <Y9pWxHfgPtgCKO+B@coredump.intra.peff.net>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Sun, 5 Feb 2023 06:34:00 +0000
Message-ID: <CAGJzqsmN4=SQv+6wPP8Tb+jmiyw=wrDKz49=s1+as+VkHgF1MQ@mail.gmail.com>
Subject: Re: [PATCH v2] credential: new attribute password_expiry_utc
To:     Jeff King <peff@peff.net>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jeff for the review

On Wed, 1 Feb 2023 at 12:10, Jeff King <peff@peff.net> wrote:
>
> On Wed, Feb 01, 2023 at 09:39:51AM +0000, M Hickford via GitGitGadget wrote:
>
> > +`password_expiry_utc`::
> > +
> > +     If password is a personal access token or OAuth access token, it may have an
> > +     expiry date. When getting credentials from a helper, `git credential fill`
> > +     ignores the password attribute if the expiry date has passed. Storage
> > +     helpers should store this attribute if possible. Helpers should not
> > +     implement expiry logic themselves. Represented as Unix time UTC, seconds
> > +     since 1970.
>
> This "should not" seems weird to me. The logic you have here throws out
> entries that have expired when they pass through Git. But wouldn't
> helpers which store things want to know about and act on the expiration,
> too?

I wanted to keep the helper contract as simple as possible "here is an
attribute to store and retrieve like any other". It doesn't matter if
a helper stores a password beyond expiry, because Git will erase or
replace it when it fails authentication or another succeeds. Relax the
language in the patch v3 commit message to describe "self-pruning of
expired passwords is unnecessary but harmless".

>
> For example, if Git learns about a credential that expires in 60
> seconds and passes it to credential-cache which is configured
> --timeout=300, wouldn't it want to set its internal ttl on the
> credential to 60, rather than 300?
>
> I think your plan here is that Git would then reject the credential if a
> request is made at time now+65. But the cache is holding onto it much
> longer than necessary.

Even after the password expires, there's value to storing other
attributes such as username and (perhaps in future)
oauth-refresh-token. Hence I named the attribute 'password_expiry_utc'
explicitly rather than 'credential_expiry_utc'.

>
> Likewise, wouldn't anything that stores credentials at least want to be
> able to store and regurgitate the expiration? For instance, even
> credential-store would want to do this. I'm OK if it doesn't, and we can
> consider it a quality-of-implementation issue and see if anybody cares
> enough to implement it. But I'd think most "real" helpers would want to
> do so.

Absolutely. Eventually I'd like to see support in
git-credential-osxkeychain, git-credential-wincred,
git-credential-libsecret etc. Mentioned this in patch v3 description.

>
> So it seems like helpers really do need to support this "expiration"
> notion. And it's actually Git itself which doesn't need to care about
> it, assuming the helpers are doing something sensible (though it is OK
> if Git _also_ throws away expired credentials to support helpers which
> don't).
>
> > diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> > index f3c89831d4a..338058be7f9 100644
> > --- a/builtin/credential-cache--daemon.c
> > +++ b/builtin/credential-cache--daemon.c
> > @@ -127,6 +127,9 @@ static void serve_one_client(FILE *in, FILE *out)
> >               if (e) {
> >                       fprintf(out, "username=%s\n", e->item.username);
> >                       fprintf(out, "password=%s\n", e->item.password);
> > +                     if (e->item.password_expiry_utc != TIME_MAX)
> > +                             fprintf(out, "password_expiry_utc=%"PRItime"\n",
> > +                                     e->item.password_expiry_utc);
> >               }
>
> Is there a particular reason to use TIME_MAX as the sentinel value here,
> and not just "0"? It's not that big a deal either way, but it's more
> usual in our code base to use "0" if there's no reason not to (and it
> seems like nothing should be expiring in 1970 these days).

Junio made a persuasive argument for readability
https://lore.kernel.org/git/CAPig+cQPLMrUKp0aqLCknSYCs5TAso-VSBYsQbGZ8g8wgY2Liw@mail.gmail.com/T/#mf66955cf3f53c073c68ad5ade7213617907bab63

>
> > @@ -195,15 +196,20 @@ static void credential_getpass(struct credential *c)
> >       if (!c->username)
> >               c->username = credential_ask_one("Username", c,
> >                                                PROMPT_ASKPASS|PROMPT_ECHO);
> > -     if (!c->password)
> > +     if (!c->password || c->password_expiry_utc < time(NULL)) {
>
> This is comparing a timestamp_t to a time_t, which may mix
> signed/unsigned. I can't offhand think of anything that would go too
> wrong there before 2038, so it's probably OK, but I wanted to call it
> out.
>
> > @@ -225,6 +231,7 @@ int credential_read(struct credential *c, FILE *fp)
> >               } else if (!strcmp(key, "password")) {
> >                       free(c->password);
> >                       c->password = xstrdup(value);
> > +                     password_updated = 1;
> >               } else if (!strcmp(key, "protocol")) {
> >                       free(c->protocol);
> >                       c->protocol = xstrdup(value);
> > @@ -234,6 +241,11 @@ int credential_read(struct credential *c, FILE *fp)
> >               } else if (!strcmp(key, "path")) {
> >                       free(c->path);
> >                       c->path = xstrdup(value);
> > +             } else if (!strcmp(key, "password_expiry_utc")) {
> > +                     this_password_expiry = parse_timestamp(value, NULL, 10);
> > +                     if (this_password_expiry == 0 || errno) {
> > +                             this_password_expiry = TIME_MAX;
> > +                     }
> >               } else if (!strcmp(key, "url")) {
> >                       credential_from_url(c, value);
> >               } else if (!strcmp(key, "quit")) {
> > @@ -246,6 +258,9 @@ int credential_read(struct credential *c, FILE *fp)
> >                */
> >       }
> >
> > +     if (password_updated)
> > +             c->password_expiry_utc = this_password_expiry;
>
> Do we need this logic? It seems weird that a helper would output an
> expiration but not a password in the first place. I guess ignoring the
> expiration is probably a reasonable outcome, but I wonder if a helper
> would ever want to just add an expiration to the data coming from
> another helper.
> I.e., could we just read the value directly into c->password_expiry_utc
> as we do with other fields?

Done in patch v3. The logic that remains (moved to credential_fill) is
a simple sanity check.

>
> -Peff
