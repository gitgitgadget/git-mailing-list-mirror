Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD061C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 23:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894992072E
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 23:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wqr2vUpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgAIXlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:41:21 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38056 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIXlV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 18:41:21 -0500
Received: by mail-vs1-f67.google.com with SMTP id v12so167679vsv.5
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 15:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N3fuUl2zEao5FQlZk8WoiawtDaUhC1ncC+AcT1llK9M=;
        b=Wqr2vUpzczS1vtKdze0p7rhqARkH5Gg4Zab20JGgHrTMi6Gt7BMWgaPkthl3Ym/Em5
         tE8kN2rOgYAJfGqaGZ+Q8qXxAL2Y6Yb3Y4FE2KmIXgBOhyka//sMBuAn0yWe3mpuua57
         ZKKxIykzTDNWZToaJGkviFxhQfQWy3/79/+FvYoLfLW6OHMR9HEPKot+4zCG7bPBK2w5
         DtOIScbtDJ3TeH2fu+grKbHXeOBhgm/rf0VvEO75P6kQfc8vYdZiau78dEzovAhjf2L9
         IN8BKdOPQNhitW7kvwialDO6SvSujrHhGgicKOUlEQvFEiPKKTTdTgGo7lPO+SEK8w/Q
         Fv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3fuUl2zEao5FQlZk8WoiawtDaUhC1ncC+AcT1llK9M=;
        b=L5gD4IhDotdT0kK9WpQRyplZ2iJM5YlZDTT8iPVLk/eeFTjvioiW55X2GNPW8uRowG
         Xtb0eL98IoZf5Hpuysl0o3xLAIDtgRJD0dVpFcuc1P3fLqI6iqPWY1/TVoPzYqO5ZFtk
         acHQKgAMYhu74Kb1LrOnlo+OpUHeexKm8bZspWjecMX411MBT+s/AxQnQjq//MNojeS7
         ZVBMD49anddPvGgK8CH2PmpodL3OsROJ4jabqm4zc++by9wUpgvIE5UhvCVlKuUhRiK3
         MlIc6hgSe7r9ERZjb68v/+/gqQMxrgNBI6h4OG55AYZvzt1sb28fY2CFl+fgImopwCjr
         v1Sg==
X-Gm-Message-State: APjAAAVt2UNrZ90byu7uDT890lhbrptq25KIxdvf1NZLwZQeHTYHQexE
        p4lJHgbwEzidpXj2F1egM3OfsMSIHCMJ79yHAMr9KCMoKng=
X-Google-Smtp-Source: APXvYqzutFVPS6/MWhDwXSf9TKu2YbIhQxU5GQpwETg/olHxA3utTvjedb+uxTJKqte0h6VZ1JobOzMs91KmcSnSDrw=
X-Received: by 2002:a67:e3b1:: with SMTP id j17mr120503vsm.209.1578613280733;
 Thu, 09 Jan 2020 15:41:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
 <pull.478.v2.git.1578565001.gitgitgadget@gmail.com> <82252735467d876b4726f512a02cc44d271696ca.1578565001.git.gitgitgadget@gmail.com>
 <xmqqh814zbm0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh814zbm0.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Thu, 9 Jan 2020 18:41:08 -0500
Message-ID: <CAOjrSZu_fobU9bwDogt3YhR7C6amx=FgzYCDo_sU2_tR=Koj0g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] config: clarify meaning of command line scoping
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 9, 2020 at 2:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Matthew Rogers <mattr94@gmail.com>
> >
> > CONFIG_SCOPE_CMDLINE is generally used in the code to refer to config
> > values passed in via the -c option.  This is a little bit too specific
> > as there are other methods to pass config values so that the last for a
> > single command (namely --file and --blob).
>
> Sorry, but I cannot parse this, especially around "so that the last
> for ..." part.
>

My bad, I guess I must have not read as carefully as I thought I did.
It should read:
"... there are other methods to pass config values so that _they_ last
for a single command ..."

> > As the "visibility" of config
> > values passed by these situations is common, we unify them as having a
> > scope of "command" rather than "command line".
>
> Is the "unification" something done by this patch?  It does not
> appear to be so.  The existing code already was using CMDLINE to
> call "git -c VAR=VAL" and also something else (which is not clear to
> me, unfortunately, probably because I failed to parse the above
> X-<), and this step renames CMDLINE to COMMAND perhaps because
> CMDLINE has too strong connotation with the "-c" thing and much less
> with the other thing (which is not clear to me, unfortunately) and
> you found that renaming it to COMMAND would cover both cases better?

Essentially, the "unification" was referring to more the unification of all the
things that affect configuration only for the duration of a specific command.

The gist of this patch was to say "There are a few ways besides -c to pass
a configuration option that lasts for a single command, so it makes sense
to broaden that scope.".  The change is definitely justified in that COMMAND
communicates that much clearer than CMDLINE as REPO, GLOBAL, SYSTEM
all describe the thing that can see the configuration options, and
it's specifically the
command the can see the -c options and not the command line as a whole.

>
> I also do not get what you meant by "visibility", but it probably is
> primarily because it is not clear what "the other thing" is.

I was using visibility as another way to conceptualize scoping.  A
scope more or less determines who can "see" a thing, so maybe that
language was a little bit too much in my head.

The issue is that currently the code doesn't care about any of that (as only -c
options actually have COMMAND scoping), so maybe I should roll it into the
next patch of the series?  As that introduces code that actually cares about the
difference?
