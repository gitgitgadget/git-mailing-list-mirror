Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FF8C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 13:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C760F61380
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 13:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFEND7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 09:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFEND7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 09:03:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B6C061766
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 06:02:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ci15so18685513ejc.10
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 06:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=317N9Hc96mvQjsdRC2aPb7ewEqCsw2YG3WHw7Si5+bY=;
        b=PVrh35/Cu66ENi+P+8c7H8F5FS/T5Jmf/d5gly3hKlymDWOxFcrtPCFhCdsrcYWk8Q
         yOtUpYti01ITO0E4GLzmNP/yhdtKJjBiIFt36yl++XPA5nJU8rC8gc+47hJm2CFtKeRK
         gMrnxbQ+hykIP5Cw9jlES83PDTQX2QMRLpIEwvSu87CvFaSWigfnHkrHe6tG+9U4dXCT
         Y6LnQtcE4t2vuMA0aYJSW/0QttEoVy/vhpwOrxDL8eu0B/wh4Ek2Gu0PTQUlkqxiTfjb
         48aL8ajdzOfaAIjOAJb3411Vi8wkXGIGe92U3TlfdevHqDRvFtDlxAAyc93/inko7zCg
         uvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=317N9Hc96mvQjsdRC2aPb7ewEqCsw2YG3WHw7Si5+bY=;
        b=tzTOBIMarCBeazETxQ+Twq96pv0CjMIJa6eWFP9NBlyelXqu84+s81Pp8rhRxvaQyZ
         bV7P0sBs++4FAq/nj3+YKS+C6WStbSwqgFsiHO1GJX8cpQqgsVBfoW+yDS8c3iU0Y7Iq
         6tMh2p6WPoV/Ifk5QBCs03sJ9+f34ZOuq5Duq+BttQymJcg6KhN9cjjuT/rBj4toQh6c
         +ucypUox9rcTjSP3mC7MdK+JJhocRnzK/bZ+gzdSH7JN7pv/da9Ne0In4PrwJ9zxOuLD
         H9ByHr5qSepO9/xptqx94UF2W3Eh7QwcS4wT0fLhZ6Y3w68/nisaROADQxw9tCw4cIZ9
         TKWA==
X-Gm-Message-State: AOAM533TLFQcQ9KK1Cm6MyS0ika71zejHVEcDIw8co8Cz24Y/+orJgxn
        0VH5Vo7tz9uhwoBqC+KKPIl+yuUNCKYmUMzpLoNOIw==
X-Google-Smtp-Source: ABdhPJyh03Lt6CWX9gbR62ov9ZQKRU2UV2ETwJcgZolgzlFdU3fiPtkcO5WQrBHn6RXVPwgjhtTR5AwBJHtRp9EcV8E=
X-Received: by 2002:a17:906:4bcf:: with SMTP id x15mr3265995ejv.145.1622898129691;
 Sat, 05 Jun 2021 06:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <5981c317-4b39-de15-810b-a781aa79189d@gmail.com>
 <20200312170714.180996-1-jonathantanmy@google.com> <20200312175151.GB120942@google.com>
 <CAP8UFD0+fyz=S_VN=EzPOOxNSNkge0uB84kEqQD_mudsFtR8Lg@mail.gmail.com>
 <20200312230931.GF120942@google.com> <CAP8UFD1ouu1EkJjGYuzJahZNX+QW-XyEPD-2Vfp8jMYNuVYkAA@mail.gmail.com>
In-Reply-To: <CAP8UFD1ouu1EkJjGYuzJahZNX+QW-XyEPD-2Vfp8jMYNuVYkAA@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sat, 5 Jun 2021 15:01:58 +0200
Message-ID: <CAPMMpohp4TPAD2yswY5zEvC5vqiY-zoXKCU4eqWWGRngmZVkhg@mail.gmail.com>
Subject: Re: [Question] Is extensions.partialClone defunct?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks, my apologies if old thread reanimation is frowned upon, I
have not been able to find any indications that this is the case.

On Sat, Mar 14, 2020 at 6:43 AM Christian Couder
<christian.couder@gmail.com> wrote:
> On Fri, Mar 13, 2020 at 12:09 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> > [...]
> > >>> Hmm...besides giving the name of the promisor remote, the
> > >>> extensions.partialClone setting is there to prevent old versions of Git
> > >>> (that do not know this extension) from manipulating the repo.

I was going to start a new thread about just this topic today, but
learned to use the archives instead, for better or for worse...

> > I can start writing a proposed patch to send this evening or tomorrow.
> That would be very much appreciated! Thanks!

Was this change ever attempted? Git's current behavior (as of 2.31.1)
appears to still violate the semantics of
core.repositoryformatversion=1 as documented at
https://github.com/git/git/blob/master/Documentation/technical/repository-version.txt,
and this has been the case since git 2.24.
I assume the right fix at this point would be to do something like
auto-detecting promisor remotes and/or packfiles and adding the
extensions.partialClone config key automatically/transparently. The
main question seems to be *what value* the config key should hold, if
there are multiple promisor remotes?

> > >> Christian, what would your prefered way be to fix this?  Should
> > >> extensions.partialclone specify a particular "default" promisor
> > >> remote, or should we use a new repository extension for multiple
> > >> promisors?
> > [...]
> > > So I'd rather obsolete "extensions.partialClone = <remote>" and to
> > > find other ways.
> >
> > I *think* that means "new repository extension".
> > [...]
> > That suggests something like
> >
> >         [extensions]
> >                 multiplePromisors = true
> > [...]
> > > or maybe
> > > we could have another extension alltogether like
> > > "[extensions]\npromisorremotes=<bool>" and over time obsolete
> > > "extensions.partialClone" altogether. I prefer the later.
> >
> > I think we're going to have to continue to support
> > extensions.partialClone=<remote> for a long time anyway (breaking the
> > ability to work with existing repositories is expensive), so I'm
> > reasonably comfortable with multiplePromisors being a separate
> > extension.  Some faraway day, we can introduce
> > "repositoryFormatVersion = 2" that mandates support for these
> > extensions by default, allowing us to clean up and simplify.
>
> > This behavior has been around for a few releases so it would want to
> > cook until the 2.27 cycle.
>
> Yeah, and partial clone is experimental, so I think it's ok.
>

I'm a little confused by suggestions to create a *new* extension key
here. In principle, this would mean that existing repositories
created/updated by the newest git version would declare themselves to
be incompatible with git clients that don't understand this
entirely-new key, even though:
 * promisor packfiles are a reasonably longstanding thing now (several
years old),
 * they have officially/theoretically been associated with the
"partialClone" extension key throughout that time (at least in the
docs), and
 * partial clone is no longer considered "experimental" in any public doc,

The kind of sudden backwards-incompatibility implied by a new
"extensions.*" key seems... bad? (unless it's something that you
*newly* opt in to - which doesn't seem to be the case here)

Thanks,
Tao
