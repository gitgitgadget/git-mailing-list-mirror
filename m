Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A3DC433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE22661242
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbhIXG63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244228AbhIXG61 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 02:58:27 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE00C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:56:54 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id o13so5918241uat.6
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLRTbGS1GP0T8FjgetFx7XcPLWUYQLRtJyTbXQNonPM=;
        b=GyR3yOn+mu83uspj8SY9OWwH7WM5EG0OvhsDdRz0SGWTNrwZ87QSEFk0aoJ1hYQdzD
         0FRL4Tn4ly4KweVLj0VPMZkCQRPGXrf1vgd6Mw5FKB56qKIxIuRWeOIxAIUcg4RCBtrL
         U9W6ksiFayIWGfXqT+2uh3/bN4CzVoZbyQnlIv1ulLBfueiPittqAZ9pcO3PFPFkJAN8
         gnWqhEpSvLNPFivpBpi/g9Nlqw3qpTnDKipB1QwVfKqLKG0wnjRQR5W692/dRc1iCxE2
         G5inRq8p62XklGXvFSpvXfJWvOifFMZfJFNGzBA+KIzvQQMQJbtUZ3S2l1IFa8kExeL5
         OXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLRTbGS1GP0T8FjgetFx7XcPLWUYQLRtJyTbXQNonPM=;
        b=sqBepKtXe2VccY/wqGzDQ4lwyvluNbrvxN7jMVh0N0eeJRsR8/QUipDcVGC1j5OC30
         BF7tiGZvYEMhZvh6i2sJiCLG+qAWpdQLVpX0C/I87wqZsDS4eryyz5YSFtJuc1imi/8J
         2HyMJOKut9nLNZS+AYi9RRX47OgAf5hv7nfW2WvDJBmPkMy5MbUH3LP3jg63pFuRsY+C
         jUN4ZkJABY5/615BL4yCfom/gmKBkXn95wGBzTea6KFzjrY3qqoZO9QW/sqNoowjhuHj
         S0enG/yNk+Ts8vUZLdRfkxDbN6Pe6QlBZDJ1aLWKrX9yfZ4Im4A/UdhsT4e8S+nIfFg/
         KMLQ==
X-Gm-Message-State: AOAM532qBOZkuUPHj8tVeXblPpJzjCmh7JIFGkUqZ6LCs4SVLX0oOYgg
        j0dN04WcwLWh6dmfaYuGYJt3OJVkJ/enPSYJrlEKik3s
X-Google-Smtp-Source: ABdhPJzaPHJ/BRjIlZ3I3GI0PXEwz/UzQnLWCgnM/+B1bUbHsbZS1WeLRO7Hn9NQmJ1d5h7BgOxHsi3pCK5JOgttciM=
X-Received: by 2002:a9f:311a:: with SMTP id m26mr7947895uab.15.1632466613169;
 Thu, 23 Sep 2021 23:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <87zgs34ccx.fsf@evledraar.gmail.com> <20210924024606.20542-4-tbperrotta@gmail.com>
 <9a60226c-7a35-0486-a687-31f7691e7551@gmail.com> <CAPUEspjxYy4GOABXkzRza-wmKnZAdq-v=OP-9+-wfV2PCnDGwQ@mail.gmail.com>
 <4c415fd4-a74e-5eb0-061e-39185be623ca@gmail.com>
In-Reply-To: <4c415fd4-a74e-5eb0-061e-39185be623ca@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 23 Sep 2021 23:56:42 -0700
Message-ID: <CAPUEspg23UqzrVSFb9KYY9k0bcp2wo4kfNbjE_ma6j4fM1=gNA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] send-email docs: add format-patch options
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, gitster@pobox.com,
        avarab@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 11:19 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 24/09/21 11.53, Carlo Arenas wrote:
> > no; as Junio explained [1] this omission is intentional while the
> > rev-list options that
> > got cut to make space are not and are more relevant.
> >
> > IMHO leaving [<options>] to imply ALL options (that also include diff
> > options, for example) is better
>
> Quoting what you linked:
>
> > The program works in two majorly different modes.  It either takes
> >
> >  * message files that are already proof-read and copy-edited from
> >    the filesystem and sends them out, or
> >
> >  * format-patch options to generate message files out of the commits
> >    and send them out without any proofreading.
>
> I think we need to again modify SYNOPSIS and DESCRIPTIONS to highlight
> above fact:

Bagas,

This is much better; can you SOB and help Thiago import it into his
tree so it can be included in the next reroll?

Thiago,

Let's wait a little while to collect more feedback on patch2 before
sending it, though

Carlo
