Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9A9C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC4623406
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgLGTKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgLGTKi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:10:38 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AC4C061793
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 11:09:35 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 91so9922434wrj.7
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 11:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yG15oXZSRoxtalpWJUp48doYzFawaJoGjdK4EoQ7cG8=;
        b=KQhFp/AbeBNSkmtjTb9Suan5b9l9SdFSK1yj1TXGsv1DYbRv2eHYaUmcHXpIvPC63r
         3YIcrm9VcPrzRuPmP/3BOM3L61g3OQO8+G+sWJ8C228pe6Kf7p1SMNPmD1+Xr+mNyQcP
         TP3FNkl6suFU/z2B8zcaAdDkofDmpl/ILVOhyh+5lRMzntDuLHHhv+liQoRlha49eZv1
         Q2EifducUnkLcMwDUUavcQ04ings5SOCICTMgGrPZINjy8L+rw8zWoxmP1cxk4x4vp5r
         dDRUo3EhezKcFEwwwPykQQvPdLxrhyuxty/wyrVshSlp2EuWIcVm/F+F7NyZjvvhvIfE
         VwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yG15oXZSRoxtalpWJUp48doYzFawaJoGjdK4EoQ7cG8=;
        b=qbRqUMzXzmaHoZ4s/5Bqzd4s81TXF1l8r2VRk9O0Efwoe0XbQLVvGCwSfTWNkc0Ect
         5R2WFxK+EQEPERUsHVpVI+eQ7wB/wgW23bmALoP//K/68S1QYJuH8KM61dYejCbhaCXZ
         4byFdhN0PNgsrBGc7qkPS/mwHT6OvWCBlOUfmRX3XwXSWBlaX+2fVUNg/gdO0U2LM2Ej
         q1trQGYIEc5GpXtBTxEU2/S34tI7lVo+aH/tBwFmrYWZuWAQ1B4NnYSXUko1cc+ggI0y
         ruxxrHDWw5vQquKQGDVk3uDClUWNBcLYtDLyc8+OZjqLVk1XGANXqLzChiY25/m3y5Z+
         dddQ==
X-Gm-Message-State: AOAM531VO/mpFjkSaDP5EKsgBS4++MDNJV5q13mHu7vlvzaEA9U1ESf+
        OhQub6jabhoZdVaHk1u5ooZmJnJuRVE9mqUnv5U=
X-Google-Smtp-Source: ABdhPJw5lIG6+embCum5Tuff50w+v0IgZB6tmFWbwcMuGqOGedrdfphin2q4VdcVjhpe8SIG8RHfByNZR/NKM7kgNuw=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr21449647wrv.255.1607368173839;
 Mon, 07 Dec 2020 11:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
 <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
 <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
 <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
 <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
 <xmqqeek2cc14.fsf@gitster.c.googlers.com> <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
 <xmqqpn3lbhxn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn3lbhxn.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 7 Dec 2020 13:09:22 -0600
Message-ID: <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 7, 2020 at 12:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > When the user has specified "pull.mode=ff-only", the command dies with:
> >
> >   The pull was not fast-forward, please either merge or rebase.
> >
> > When the user has not specified any mode (by default), the command
> > would output a warning:
> >
> >   The pull was not fast-forward, in the future you will have to choose a
> >   merge, or a rebase.
>
> I quite don't get it.  They say the same thing.  At that point the
> user needs to choose between merge and rebase to move forward and
> ff-only would not be a sensible choice to offer the user.

The error happens *only* when the user has explicitly set
"pull.mode=ff-only", and the pull dies. At that point; yes, the user
must choose between one or the other.

But the warning happens by default, when the user has not chosen any
mode, and the pull succeeds. The user doesn't need to choose; the pull
continues as if the user chose the "merge" mode, which is the historic
behavior.

They start by saying the same thing. But one errors out and says the
user must choose, and the other warns that in the future the user must
choose.

> > Just to put this series in context: it's only part 1; it does not
> > introduce pull.mode, and it doesn't make --ff-only the default.
>
> I'd view the "in a non-fast-forward situation, the warning kicks in
> to those who haven't chosen between merge and rebase (i.e. no
> pull.rebase set to either true or false, and pull.ff not set to
> only), which is a bit more gentle than the current situtation" a
> good stopping point.  That state is already making ff-only the
> default for unconfigured users, or you can view it as shipping "git
> pull" in a shape that has the more dangerous half of its feature
> disabled to avoid hurting users.  So I am not sure why you keep
> saying you do not have --ff-only as the default.

The warning doesn't make the pull fail, ff-only does.

On the current master this works:

  test_expect_success 'non-fast-forward (default)' '
    setup_non_ff &&
    git pull
  '

And after my patch series (part 1) it still does. The default behavior
has not changed.

I'm not sure what it is that I'm not explaining correctly.

-- 
Felipe Contreras
