Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592BC20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 20:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLKULu (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 15:11:50 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46512 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKULu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 15:11:50 -0500
Received: by mail-io1-f68.google.com with SMTP id v10so12863394ios.13
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 12:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=boQeOjE6SD8JaCsqzfgLxBaWYc9YZEJRCgwGQbwjx3Q=;
        b=a2WER6Bae2p7ru4jBpy65aYRMjtEsdDEDnYjzqAR3n1uDkZPegc0GcTUzByGF3vCFh
         BKyWHr9GPAW74/RWqJiZa0pwKWeXJpuqvaj1byiE5MnFLlMCH6GP3wu2kY+Ad075AYan
         tam269k8/BAgPhS8d6tgoYk5z6Red4/koTfqd1A986SwtkJlQ52+iFuRxuGBIdZOm+Nh
         Jmdn2dOzuVg6rJb3pGAyaedVJE/P74r0nocOQ/JQAVStDwn4yaE1J16XrN5idzS6ifbV
         s0PvoGWb7NWXNsdWvCQlwtcoSxIvoWSTNQuDSTb7o0tzzn1KQy0I6zmQ7KzIlqwuPMoL
         9ukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=boQeOjE6SD8JaCsqzfgLxBaWYc9YZEJRCgwGQbwjx3Q=;
        b=l0r5+Z/cboYfxLDeB9zhlM1ae6tgewwLB+HJV30X27L1J9hO6CoUbCU9+nh8GlHhM6
         Wqhc1m4RJMPGxGTugWfINUDlmS5IwC1UegDucH6i5MYT5L77/JljZQBNpTn1pgAnfeT3
         Vfas9RQvAcDiB7MYyPylvF0lXWURZkJBe6ckHQLfo2qgjngOIRgbxhNYv0wgD84oiDvG
         njGQK57vc/HcxCGdoK8baX5XZxPEIUFfsB0+C64SOpcFIjSc8vV43e4VL9cmUj7v0Fv2
         oP3ZvDROuHCUg8ntgn8kbGxCyvtr/Iuz9/xXa9d/QfeyfMYdhzLloDQ7Q9FjLPe5JJYw
         HGNQ==
X-Gm-Message-State: AA+aEWYmME9RVPqsTGc424l+xo6HahtfIw1jerDya1vvmqygFfY3hqnC
        BJHA0b7qbSbs9Y8wfHxZaUAdjK7ee5JbPxmkZwkSUw==
X-Google-Smtp-Source: AFSGD/Xu1TqUxm8+fk73VNksclAQa2rZt4ED4JqZEruKftag78dteXGnlFXUKsP//1S9sXZ2Lp/4NBZP+e0Pbm9tnpQ=
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr14250294ior.169.1544559108951;
 Tue, 11 Dec 2018 12:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20181209230024.43444-1-carenas@gmail.com> <20181209230024.43444-2-carenas@gmail.com>
 <87r2eqxnru.fsf@evledraar.gmail.com> <20181210004252.GK890086@genre.crustytoothpaste.net>
 <87pnu9yekk.fsf@evledraar.gmail.com>
In-Reply-To: <87pnu9yekk.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 11 Dec 2018 12:11:36 -0800
Message-ID: <CAPUEspjHs7+G+FHXjxb4rCcNLqaybbhZESik=14_9Q5h2HMzMA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] grep: fallback to interpreter if JIT fails with pcre1
To:     avarab@gmail.com
Cc:     sandals@crustytoothpaste.net, git@vger.kernel.org,
        pcre-dev@exim.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 12:24 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Dec 10 2018, brian m. carlson wrote:
> > Considering that some Linux users use PaX kernels with standard
> > distributions and that most BSD kernels can be custom-compiled with a
> > variety of options enabled or disabled, I think this is something we
> > should detect dynamically.
>
> Right. I'm asking whether we're mixing up cases where it can always be
> detected at compile-time on some systems v.s. cases where it'll
> potentially change at runtime.

the closer we come to a system specific issues is with macOS where the
compiler (in some newer versions) is allocating the memory using the
MAP_JIT flag, which seems was originally meant to be only used in iOS
and has the strange characteristic of failing the mmap for versions
older than 10.14 if it was called more than once.

IMHO as brian pointed out, this is better done at runtime.

> >> I'm inclined to suggest that we should have another ifdef here for "if
> >> JIT fails I'd like it to die", so that e.g. packages I build (for
> >> internal use) don't silently slow down in the future, only for me to
> >> find some months later that someone enabled an overzealous SELinux
> >> policy and we swept this under the rug.
> >
> > My view is that JIT is a nice performance optimization, but it's
> > optional. I honestly don't think it should even be exposed through the
> > API: if it works, then things are faster, and if it doesn't, then
> > they're not. I don't see the value in an option for causing things to b=
e
> > broken if someone improves the security of the system.
>
> For many users that's definitely the case, but for others that's like
> saying a RDBMS is still going to be functional if the "ORDER BY"
> function degrades to bubblesort. The JIT improves performance my
> multi-hundred percents sometimes, so some users (e.g. me) rely on that
> not being silently degraded.

the opposite is also true, specially considering that some old
versions of pcre result in a segfault instead of an error message and
therefore since there is no way to disable JIT, the only option left
is not to use `git grep -P` (or the equivalent git log call)

> So I'm wondering if we can have something like:
>
>     if (!jit)
>         if (must_have_jit)
>             BUG(...); // Like currently
>         else
>             fallback(); // new behavior

I am wondering if something like a `git doctor` command might be an
interesting alternative to this.

This way we could (for ex: in NetBSD) give the user a hint of what to
do to make their git grep -P faster when we detect we are running the
fallback, and might be useful as well to provide hints for
optimizations that could be used in other cases (probably even
depending on the size of the git repository)

For your use case, you just need to add a crontab that will trigger an
alarm if this command ever mentions PCRE

Carlo
