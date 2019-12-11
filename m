Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1A1C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 20:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A66C20836
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 20:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="IwGn0+n3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfLKUTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:19:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41797 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfLKUTp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 15:19:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so63285wrw.8
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 12:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCmzwAmqpVH0YDMMy9fvP4eY2+qzFly+W3faPtz+A7E=;
        b=IwGn0+n3lY3JMvBfJgdJf0g7ouyGhQLt+l0DwdUHQ634eh6NG1EO5An6BUqTpGmujV
         pJ+KkzY75u3VN7puY9yC++cPqgCuVVWkb1MmqN5E7UKyGD+KQtoeFrRCcL19XK+KF6kW
         fqldd0Yjcux8kV5O6N4Z9htaOd9p04Ls3UYzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCmzwAmqpVH0YDMMy9fvP4eY2+qzFly+W3faPtz+A7E=;
        b=UbR6dKmvUWHsZuRcE7qBTrmrQB4O/0uRe/hTn8KwBKTkk8l5rgWPtah/pcdsuNuTL4
         NofsVbONogzxZWsX8PiimODQoUd4FOe+YMaZAevbqxG6A2z6F8SFyL8eaLvmNYMjxalg
         AaAVfWTZYO9rfjnHc5b3H1gz2NuXPfKbW3Hod1brQVzxhtsDn+PCglBVfOvuQ1g29QoX
         CL01lRf5/hboDH05mV+obl9fHRftz6uBll0f7axzD9acshZ+WosmYtRIcKro4SZ+LwBD
         PL4SArWNBLLX904O3m+AJyTlRrkHSUMOVgo5a2uKqvhBdhkzxiJHCZxL3aMXevzlYnJ0
         6LGw==
X-Gm-Message-State: APjAAAUjKyk2Hj0qs8gyt5WIAYtASmIL9qfaSqoD/kI6gkJmKyT5MPc1
        xkIdgWb27RWWbwCOYo2HQLGGbIcycZ1t2400u4n+GQ==
X-Google-Smtp-Source: APXvYqym/9Q7vsk8xO9ojEk2w7t99J98LqvmH7N/7rVxF4muTntUjmLynqxoytXjIQe1/0ZB283CYdU50hin4lZ6Dho=
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr1744494wrp.110.1576095583209;
 Wed, 11 Dec 2019 12:19:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <pull.463.v5.git.1575740863.gitgitgadget@gmail.com> <20191207194756.GA43949@coredump.intra.peff.net>
 <95ead4b6-21bb-1aa2-f16f-888e61a4e4c0@gmail.com> <xmqqwob2pzty.fsf@gitster-ct.c.googlers.com>
 <20191211171356.GA72178@generichostname> <xmqq1rtapwy1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1rtapwy1.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 11 Dec 2019 20:19:48 +0000
Message-ID: <CAE5ih78O4_ZPm1sxA=D9Ff-u3ga5Ax1CbvrFg0_E4KrRdUihDQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] git-p4.py: Cast byte strings to unicode strings
 in python3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>, Ben Keene <seraphire@gmail.com>,
        Jeff King <peff@peff.net>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Yang Zhao <yang.zhao@skyboxlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 11 Dec 2019 at 17:57, Junio C Hamano <gitster@pobox.com> wrote:
>
> Denton Liu <liu.denton@gmail.com> writes:
>
> > On Wed, Dec 11, 2019 at 08:54:49AM -0800, Junio C Hamano wrote:
> >> Ben Keene <seraphire@gmail.com> writes:
> >>
> >> > Yes indeed!
> >> >
> >> > I hadn't pulled before I attempted the rebase, and got bit.  Yes those
> >> > shouldn't be there!
> >>
> >> So, other than that, this is ready to be at least queued on 'pu' if
> >> not 'next' at this point?
> >
> > From what I can tell, Ben agreed to have this series superseded by Yang
> > Zhao's competing series[1].
>
> OK.  Let me not worry about this one, then, at least not yet.
>

Oh, I hadn't seen Yang's python3 changes!

What do we need to do to get these ready for merging?
