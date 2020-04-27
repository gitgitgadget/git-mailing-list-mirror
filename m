Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE30C81CFF
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 22:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88460206A5
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 22:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+tb3mwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgD0WXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgD0WXf (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 18:23:35 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F156C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 15:23:35 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m18so29156549otq.9
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXtW1ywxdwII+gmKdCxdt0O2QYp2kBqNzWx7zu+sgl4=;
        b=M+tb3mwVEHcqUj8K0X3Ui713WgUTO6zUTK+kZo5MovudzIN0QEbrVRw2DMWhBMFQtK
         5UOcAgEcFQadjyZDxWiFv2IgSsFn0/tF4qGyMBflxFtXjHbFQrNEh0f2slDAv7gsgVtF
         +0yKbiAmenNMFfYgT/8PK/XUJZyKHes4WYgSfMYRtILUWb+qX7xsWyDGsjwHZIpMe2q8
         KH2w26dMSHUqEYgaVkW21xoUo+5HZAmAPqxsoCA3IbJZEcHSJi0KOX90PTwMEIYFNz9W
         jgsSwIpdcD7PXbODJRtXu9pJ1Kjzp7oE9zu3t0y3R2I04TGfF72zvalc8JAjpSegVVU3
         g1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXtW1ywxdwII+gmKdCxdt0O2QYp2kBqNzWx7zu+sgl4=;
        b=Owv7ZUnPEyX8A4AGb00I1uy7XZo1nTmKA0pQRU5i/o9vIq7pVN8FswQZ1OQ017QZmA
         BWXHZypo9msfFNbzwma7iRhmW7OF9YJlUoALISJgWkm9CpVsVDQsD+GEuiKnP8b+mdyw
         9XEL2j9MlmmosCRdnPds0SUVJr6RPpCVgd2foTC/9GMollacf86lKP65SH2ANtTNrn90
         J2286bzqotKpQThXoWJXQpU4LJxKmpXhU83sZDggy29q4JjlBRMzH8h5ipc9yJoCe/oy
         Ma1RaIlVnFc/wnybG3MSX+YsmQCuIoYgTOE9kRPi05jW1Ci52dZ9WoOYI6Yj7wjAA/HR
         ZyPA==
X-Gm-Message-State: AGi0PuZuL9IWNxqr5RyIZbGgZ1/WHpldE2QHgLh2atZhsC2SEO03CoqV
        Mh0/JO98T14Vfs12RHA/5Jmipwtu8azGZqNXHJQ=
X-Google-Smtp-Source: APiQypKtcO7OgWvGTSUDBnFhVKTtpgRFO0mZeQ820NL0Bq1jqKeNPve+zQwhTxiQrgjP+KCG9uh3OAg0WmEkZVsKJn0=
X-Received: by 2002:a05:6830:1ae3:: with SMTP id c3mr20935080otd.345.1588026214300;
 Mon, 27 Apr 2020 15:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net> <xmqqlfmg7hn7.fsf@gitster.c.googlers.com>
 <20200427220955.GA1747507@coredump.intra.peff.net>
In-Reply-To: <20200427220955.GA1747507@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Apr 2020 15:23:22 -0700
Message-ID: <CABPp-BE4qBquBwHp6QH31WNcQ-jUMrC+SqCbnBWKtCxdhoWRCQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] CMake build system for git
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 3:12 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Apr 27, 2020 at 02:17:32PM -0700, Junio C Hamano wrote:
>
> > If we were to adopt it as an experiment, hoping to gain exposure,
> > nothing above 'master' (or tagged releases) won't work.  And once a
> > thing is in 'master', users will ignore the "this is merely an
> > experiment" warning and expect it to be fully functional and usable.
>
> Yeah, that is a problem. I wonder if the state would be more obvious if
> it lived in contrib/. We already have contrib/buildsystems,
> which seems like an earlier attempt at this exact problem?
>
> > But in the meantime, those who are interested in building Git with
> > cmake do not have to wait, doing nothing, I would imagine.  I wonder
> > if they can work on a separate project (let's call it git-on-cmake)
> > whose sole purpose is to develop and polish CMakeLists.txt, waiting
> > for an advanced enough version of cmake becomes commonplace.  Then,
> > anybody who are interested and has recent cmake can subtree-merge
> > git-on-cmake project into their own clone of our project somewhere,
> > and help developing git-on-cmake further.
>
> I think there's actually a good reason to have it in your tree: people
> use your tree as the basis to build (and submit!) changes.
>
> I noticed the same thing with trying to play with CI changes. As a
> contributor, yes I _can_ make my CI changes, and then base my branches
> on that. But it gets rather awkward juggling branches that contain some
> changes that should go upstream, and some which should not. And quite a
> bit more difficult if people want to use tools like GitGitGadget to just
> target a PR against git.git and send it to the mailing list.
>
> If it lived in contrib/ that might strike a good balance between making
> it available for people to experiment with, but not having people
> confuse it for the official build system.

Maybe we could move configure.ac and config.mak.in into contrib as well?
