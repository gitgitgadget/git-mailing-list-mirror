Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D875FC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 18:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiHASfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 14:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiHASfp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 14:35:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E015DF15
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 11:35:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kb8so7377310ejc.4
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 11:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OKCL3bvUo+P6PG+brQlGU9icsEYAYChGul59HDCYdE8=;
        b=N1VW2DEdPs0JCGrQVgQBOyxY5blCGzh/1CeidvPFtRwsBKx+jrFjiQUoeOr2MvBGYY
         oTM+6e9slL8V/pM6HmfOJz03jHMVQ/vea6IYjPSzL6uEsBH/2v4EGKJJFKGBvWf1rCRO
         u9JcOLjFmf7WZeJrZm4vkT1PkJbkIaiUK93efeC7DyuWvc+VdF5Sx1BHXyuU7cbNAZQr
         FTfpv1GpUmhkD5sSv9oyUFyEnXFLTPMrAh6PHlBX2GddwF49SKP6wQEGTXDxdmgAT80X
         mvp7WLveidjiq9sabaJKQJ0s/V45L8v0HT86FmTB9NO3XKQylbKz04ZGOLW7hrxE0K/k
         Uang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OKCL3bvUo+P6PG+brQlGU9icsEYAYChGul59HDCYdE8=;
        b=alh8J1/zjZSzXZXIUEVf6R4eXESZ/Ecmph49FwjPui5sO888FVqGyRVelwCaLfBxm/
         keYZ4SiQWFRUU/WDd9Cm/oJD9/cAVa6yWtBrnEe57kr/bpjJBBwX7T98LH5SwIfjPTm2
         vE5Q1yExLq0c4CgqRlJSFy0qk/97DgfrD882PhIp8YkMv2vAn0butpyEBdZyq9MeQKqd
         EsRthtJHX6geadOEXvEihKEle6Z0LD6CKumhbR/C1dM0/du1+/0NRFIWhE/jL8fieAAl
         S7y012v9ecA6vHx8uxPJ6+ilr2cSjWG/SDMcke2cM/kdT6PPR4XUx0LeCLLcnA+CxEiQ
         X+2A==
X-Gm-Message-State: ACgBeo14KP5Yn2hILISoqvIEoq1UjsSmEavcElELBd4JP7h6/jemNzX5
        WubtSyoX6kcA5NCz3uPnlVakg17AaC+o+AxOZX9o4bEUxhM=
X-Google-Smtp-Source: AA6agR6D7E+o5s5RKBbcZ/cXWSUri8M2V60NhQXkgY9GkBwwrPJbuDg1t5LBbSUVJeDjPg/76kOVmqiOx38Pf9M90CA=
X-Received: by 2002:a17:907:1629:b0:730:7ad7:24f2 with SMTP id
 hb41-20020a170907162900b007307ad724f2mr5678043ejc.261.1659378941886; Mon, 01
 Aug 2022 11:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAMxJVdH+o+H56tJ4UmD8YcsNsLuutiUXpOP=euQbomBe1kLkMw@mail.gmail.com>
 <16832f8a-c582-23bb-dda9-b7b2597a42eb@jeffhostetler.com> <xmqqmtds8ylz.fsf@gitster.g>
 <CAMxJVdG5OCgWMN+0aymdVTorrkeViGNy=f49fu7GJE6trwyoWw@mail.gmail.com>
In-Reply-To: <CAMxJVdG5OCgWMN+0aymdVTorrkeViGNy=f49fu7GJE6trwyoWw@mail.gmail.com>
From:   Eric D <eric.decosta@gmail.com>
Date:   Mon, 1 Aug 2022 14:35:28 -0400
Message-ID: <CAMxJVdH9EJCtg_J=HQtH9ghSWS1EOUqmU8rdAVTP+mL3gH6h=w@mail.gmail.com>
Subject: Re: Option to allow fsmonitor to run against repos on network file systems
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 1, 2022 at 3:15 PM Eric D <eric.decosta@gmail.com> wrote:
>
> One more possibility:
>
> Leave the check, but make it a warning if there are still concerns
> about running fsmonitor against network file systems. Maybe also
> provide an option to suppress the warning? Not that much different
> from having "fsmonitor.allowRemote" I suppose other than by default
> fsmonitor would "just work" for network mounts.
>
> On Fri, Jul 1, 2022 at 2:41 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Jeff Hostetler <git@jeffhostetler.com> writes:
> >
> > > Having said all of that, I did do lots of testing and never had an
> > > issue with remote drives actually working correctly, so I think it'd
> > > be fine allow a config setting to optionally allow it.  I just didn't
> > > want to clutter up things in advance if no one actually wanted to
> > > use it on remote file systems.
> > >
> > > I think it would be fine to have a "fsmonitor.allowRemote" or
> > > "fsmonitor.allowWindowsRemote" config setting and default them to false
> > > for now.  Or until we learn which combinations of remote mounts are
> > > safe and/or problematic.
> >
> > How about getting rid of "is this remote?" check altogether (which
> > presumably would simplify the logic) and make it totally up to the
> > user of the repository?  fsmonitor.disableInRepository that is set
> > in ~/.gitignore and lists the paths to the repositories (like
> > safe.directory does), for which fsmonitor gets disabled, may be a
> > handy mechanism to set up the default (and it can be re-enabled with
> > per-repository core.fsmonitor).
> >
> >

After modifying the code and playing with it for a bit, I think simply
removing the check (but still being able to report on it if tracing is
enabled) is the way to go. Keep it simple and if new use cases arrive,
deal with them then.

-Eric
