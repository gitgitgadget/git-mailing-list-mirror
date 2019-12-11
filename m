Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D06CC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 23:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCEC214AF
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 23:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anKAPCcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLKXO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:14:57 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40711 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLKXO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 18:14:57 -0500
Received: by mail-vk1-f196.google.com with SMTP id i18so217359vkk.7
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 15:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HyEB+4HgRhpZkb6+BRpzRIrSzOExW1lPZ+g48T+muhw=;
        b=anKAPCcSr1DqDbwyCL6ox6w9yVRbPasMPBWUR0pvF6p7c046HW0ggSq2Rqo2FkyMd8
         0exQTB8oWnYjHxqAOLIJGE3V1NFJn4Nr18DtH/J3X9FDGBhjynd9R0MuhXhFCL1lNDoL
         Gov2rzQuPVHhh96DSFnrvrEHKgdNuqNyDlTduXSjOV97LVudpMlleS5w6hJ4HWepyPYn
         V6eOqhCQpLG6Ra/D+9fLxUKX43poe2YO2mRcpT0hPuZvTYOFn79+06ognfpVw93nErmR
         BJyhHrKwVWwlo18MNZnM+U3WJKTgZIcduzY8af9ommVDLenT9B7KLihHcN9aXnUoqPPr
         9FDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HyEB+4HgRhpZkb6+BRpzRIrSzOExW1lPZ+g48T+muhw=;
        b=SkXcLlV9Ia/ezXDzBm7Ou3gS8LAa/7O85iKgk+SMFvedPEfyAoomp1tnpPWRS3asZn
         WgR1YQOsdg+FetWWiE9j15L3bQDwCDbX8CxS7PaHFNFHWB/R7mWbiU6TQ/4JilBFqwmH
         QgGdPjUDbhJV294AVXwTPT28BKUKKsjN25Mx/p260wJjl36kXJ15zf97EAuKxnviT8PB
         kebghNO1AeuXQWxW/R6osEP9LvgdY4F9QjlaRldyMHimCBw7tIFsy2i8su0mHCzH5XVx
         qCPwzV6rB2y+YoeqJMvyZ3e9Pa8MCsyvzgKFiIUwQcZGHYeuVcPZkTwm3XUdw71U/KeF
         WjdQ==
X-Gm-Message-State: APjAAAUQYsHFLlfZfIOTirlxw162OJbMqZR3unapXssRjY8M7XOK95qi
        P9MIS1e6FTG/4Jx43KuqyPyNlee3z7sMrM9ZRLM=
X-Google-Smtp-Source: APXvYqwPBlNPg2uS5T/yrs44P8x8MpA1epMKgRY/BMsZDf/Qm20pEqU66owvjLfIgv15NrW21jUCQDxTepk4WQSbpSI=
X-Received: by 2002:a1f:5e13:: with SMTP id s19mr6047334vkb.12.1576106096433;
 Wed, 11 Dec 2019 15:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20191211220933.48678-1-emilyshaffer@google.com>
 <xmqqsglqmrn6.fsf@gitster-ct.c.googlers.com> <20191211231146.GC8464@google.com>
In-Reply-To: <20191211231146.GC8464@google.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Wed, 11 Dec 2019 18:14:44 -0500
Message-ID: <CAOjrSZuOOG=MbetP0RWYwLB+Zv5EZAHqkvkm0+WkBmSqxXiVTQ@mail.gmail.com>
Subject: Re: [PATCH] config: add string mapping for enum config_scope
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another thing I also want to point out is that outside of this
function... when git config is called with the --local, etc. the
config scope is not actually CONFIG_SCOPE_LOCAL but
CONFIG_SCOPE_UNKNOWN.  This is because the config machinery pretty
much equates --local and --file=./.git/config as pretty much
equivalent (assuming ./.git is the actual repo directory location).
So just something to keep in mind.

On Wed, Dec 11, 2019 at 6:11 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Wed, Dec 11, 2019 at 02:19:57PM -0800, Junio C Hamano wrote:
> > Emily Shaffer <emilyshaffer@google.com> writes:
> >
> > > If a user is interacting with their config files primarily by the 'git
> > > config' command, using the location flags (--global, --system, etc) then
> > > they may be more interested to see the scope of the config file they are
> > > editing, rather than the filepath.
> > >
> > > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > > ---
> > > Note: This commit has been cherry-picked out of the "configuration-based
> > > hook management" topic, at
> > > lore.kernel.org/git/20191210023335.49987-1-emilyshaffer@google.com
> > >
> > > It turned out that I wanted to use it for git-bugreport as well - to
> > > explain the origin of the configs we are printing in the bugreport,
> > > without directly exposing the user's home directory path.
> > >
> > > This seems to have similar work to https://github.com/gitgitgadget/git/pull/478
> > > which I believe hasn't been mailed yet; but that change is targeted
> > > towards the builtin config command, rather than the config library.
> > > Since I wanted to use the library, I'm sending on my own now. Maybe
> > > this commit will be useful to that change's author.
> >
> > One thing I wondered about this in the original version was if the
> > returned value should be localized.  In the context of the original,
> > the --porcelain mode refused to give this information in its output,
> > so it was OK to always localize the returned value to satisify the
> > other caller who wanted end-user-facing output.
> >
> > But as a more general helper, I am not sure if this is the most
> > useful way to implement it.  Shouldn't the function rather return
> > the machine-readable tokens and allow callers to localize it as
> > needed with its own _() around the returned value?  I dunno.
> >
> Hm. I think that's a good point, and allows this helper to be used for
> something silly like putting together a sample invocation to 'git
> config' if desired. It's meant to mirror the scope given to 'git config'
> - which makes me think that no, it shouldn't be localized, since the
> argument isn't localized either.
>
> Ok, I'll take the locale marker off.
>
>  - Emily



-- 
Matthew Rogers
