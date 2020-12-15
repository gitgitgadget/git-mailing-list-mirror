Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABAAC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 16:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93FF2078B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 16:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgLOQWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 11:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbgLOQW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 11:22:29 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DFBC06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 08:21:48 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id x13so19933651oto.8
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 08:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YXb7+0Qv2elZJ9f3HG8g7y0WEeio+d0/EbDGWsAnssU=;
        b=okTZg8QwSduW00M19GW7m391aOfD3jQPgzxabKCeiG3KdgBRPTPOqYd1GMwO9QsZBZ
         kJydVj7J37Bv341DcoPE0SplTYtgC08PA89kpM4OsUTnAHuSGZJ1xbFHJFTqsxPlvBJ6
         hrssHTQ4EEqMetzdwtLNd5CmatFmvUmx5z17WcADPtZIG+n+IfP3i30gaU0H2ljs4Ve9
         9uM/pwxmhomOP5JtSCJdF081SdoywbxzDBLn1SifEJKguBKozWgsqPmRQz1ZrHSzbBQj
         aCJ9E49wXtl5vxhm7kOcMNfaiTxQCGwSdNzhO3XNLKYyL8cdvrQwAFV1mkLOSZCGJFPU
         hZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXb7+0Qv2elZJ9f3HG8g7y0WEeio+d0/EbDGWsAnssU=;
        b=fmPC4jX1rc1U96CSe4Rv4HgEjzjO7Iq45D7J7YeFYJ0cTzZd/JbrE62+clBA+R6r2w
         gdF1jiwug7gtjfaTrqRCAo7eYF7jRszJyyaBZ7tAjfu4mM8BGRul9eqmz119vpYTvNr1
         d2SVcPNKXC3eXAl2Cn2QNhRSURpIHO9CyO5J/dBxCqG1TCT8Ct4fI12kdZIsoWXY7zTH
         4D++Era/UxLRa4K9JgW9d38RQq85w1p7UyPRn9H42zlUuhSY5h9tXmj5T4H/oZVEIgje
         zK47+17152AOdJzKBHWO9R/V+3ywMZL0isOGKes/vSOUL4t9k8iDo45knjTnE6OVjq8B
         BMBg==
X-Gm-Message-State: AOAM533IzUjuEKaGTINRa/vWVnaF51NgdAOUJhkgPyYDmQee/BRUD4dS
        jNLK4Ztq4moGHCStvb7lNuA/FeVsZ4XP+V4hVqI=
X-Google-Smtp-Source: ABdhPJxSDqHMqz3xZyIU8Aa8ishiMBavidICpVBDwhJH5+lkDox+rR+rnp+s+TAMwdqwifAgDDBFxAqUYYkIORwcH5s=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr23468659oth.316.1608049308172;
 Tue, 15 Dec 2020 08:21:48 -0800 (PST)
MIME-Version: 1.0
References: <035d01d6d26e$8c255260$a46ff720$@nexbridge.com>
 <xmqqeejraiw7.fsf@gitster.c.googlers.com> <X9glBJnlLMTW6Dns@coredump.intra.peff.net>
In-Reply-To: <X9glBJnlLMTW6Dns@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Dec 2020 08:21:37 -0800
Message-ID: <CABPp-BEnkQahdVJP+rfQho+S_hcS3y-o3cZBUMhU-EQHjJTLOQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] git-2.30.0-rc0 - Compile Fails on HPE NonStop
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 14, 2020 at 6:52 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Dec 14, 2020 at 06:43:36PM -0800, Junio C Hamano wrote:
>
> > diff --git c/git-compat-util.h w/git-compat-util.h
> > index 7d509c5022..58cd0761be 100644
> > --- c/git-compat-util.h
> > +++ w/git-compat-util.h
> > @@ -273,7 +273,8 @@ struct itimerval {
> >
> >  #ifdef NO_SETITIMER
> >  static inline int setitimer(int which, const struct itimerval *value, struct itimerval *newvalue) {
> > -     ; /* nothing */
> > +     errno = ENOSYS;
> > +     return -1; /* not implemented */
> >  }
> >  #endif
> >
> > Alternatively we could pretend that the call always succeeds by
> > without touching errno and returning 0.  That might be safer, but I
> > dunno which one we want, and I do not have a system affected by the
> > choice.
>
> I think this is a sensible choice. Before the conversion to an inline,
> the code was removed entirely! So anybody checking the return value
> would have seen an error, and we do not have to worry much about
> breaking them.
>
> For new callers, anybody checking the return value would probably
> appreciate the warning that support for the function is optional (OTOH,
> they would probably not find out themselves, but rather when Randall
> tells them ;) ).
>
> It would be nice to have a way to warn them even on platforms that have
> setitimer(), but I can't think of an easy way.
>
> > > Aside from inlining bodies, this should not have compiled on any platform:
> > >
> > > static inline void strset_remove(struct strset *set, const char *str)
> > > {
> > >         return strmap_remove(&set->map, str, 0);
> > > }
> > >
> > > What is really intended here?
> >
> > I think we should just drop "return"; a void function should be
> > called in void context without requiring a value, even if that
> > return expects no value.
>
> Yeah, I think that is right. I checked earlier iterations of the series
> to see if perhaps strmap_remove() had previously returned a value, but
> it never did in any on the list.
>
> > diff --git i/strmap.h w/strmap.h
> > index c4c104411b..1e152d832d 100644
> > --- i/strmap.h
> > +++ w/strmap.h
> > @@ -165,7 +165,7 @@ static inline int strintmap_contains(struct strintmap *map, const char *str)
> >
> >  static inline void strintmap_remove(struct strintmap *map, const char *str)
> >  {
> > -     return strmap_remove(&map->map, str, 0);
> > +     strmap_remove(&map->map, str, 0);
> >  }
>
> So yeah, I think that is the right fix. +cc Elijah for any other
> insight.

Doh, sorry for the bug.  Yeah, that's the exact fix I'd make.  Junio,
do you want to just use the changes you've already got, or would you
like me to submit a patch removing these two 'return's?
