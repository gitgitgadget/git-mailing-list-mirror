Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0992FC433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D2064F14
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355364AbhCDAXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245229AbhCCTWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 14:22:16 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23ADC061760
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 11:21:35 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id x20so27191712oie.11
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 11:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+80dJk0KRGs0d1vcGY0/QNjtc+3Bg1JEd5AW28abnM=;
        b=d7DZy3MmugZJ8wzZwWUUoMWmepsg3HqYK9c+WkFxBM73pU+I32OIYANixOAjtmvYOB
         +p8DEkVxSbT7DWnudTnuKh0aMpNhpKOR5Cg32cyxznbbZ/QcCRuQw89OPa59JrU3u8vL
         h4jf7uXfoqAWe+G6P6F6KoBOPX8vMptuobK9wgmOiWaLqINN1uwLs8ZfL9GZqkT1SUfH
         ykbagZG+ydaqARbH0tFNS+qnuG9j3+oOl62o5qD5Xg9c71pxdTi6iPhvgc3Qa1JuXtPT
         c9W0M8ytkD2StdyVtMt8qdpYIc0im/CPijoYaFqdd6AV5xJy2hgaNlfFj2ZlROm0rR1k
         2MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+80dJk0KRGs0d1vcGY0/QNjtc+3Bg1JEd5AW28abnM=;
        b=cI/Hl9gR3TvnU7vq75LEhDTdgBCRtM1mxm2iOekd1I7ivNi2v1NV/urx5wGC5vT4Z9
         b8qPNqS67IRyABKctiSD46OnBhQdrHbla11e8iZkETuyLAJN0EOrboNzkAaoQk4VgosK
         ilbPIuOCnoVer2hOC2/6BA2Wuctud+CkyFUHRqzSF+g+11CafNIPdh603R5EQS38ez3A
         a81w4DIQBQ0ifC0i9nWcpwd6Z5Ft0Dw+h5mZ7WN798+rYQ+qr7MFCB8Ipfx+rHbjD28a
         v7Dl5ww1WYA3G6RUk8PV/0irKla29ef+QozIxO8shcckQsbEmrQaN19AsIfxF9wRpCCU
         aJqg==
X-Gm-Message-State: AOAM531k/X9KuifiJ7AmbKWKTedQD/a7nU8D8bshhVOg0s4AhZFacwQd
        OCHd8x8D+RMx+s+Nti+qdlZ9STmCPxFJ6ROy6NM=
X-Google-Smtp-Source: ABdhPJyXGwokf2c2jJn3w3s5zyRhESCsw1yYtG4HZ9VFlXnfO9UVOVSJnbvwkQ70a35AQux4MkUlWgwKnl03vQmbxTc=
X-Received: by 2002:aca:a809:: with SMTP id r9mr253660oie.163.1614799295101;
 Wed, 03 Mar 2021 11:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-3-charvi077@gmail.com>
 <CAPig+cQAG3p6rhGHzBNGPUxMXQbbLZgiw-uUpizNiEWY9wm-3A@mail.gmail.com>
 <CAPSFM5dm7vD8pszCG+JKNb7Hu6Zp48wKXaj9ayxe6yaf6swePA@mail.gmail.com> <CAPig+cSJCSLBDumaXvnkdSBTATs62h9EfgtgJu0O7R_PJEumCg@mail.gmail.com>
In-Reply-To: <CAPig+cSJCSLBDumaXvnkdSBTATs62h9EfgtgJu0O7R_PJEumCg@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 4 Mar 2021 00:51:23 +0530
Message-ID: <CAPSFM5cECFPk180G3aOdqnZ09FogwsBzC_WwO4OFutsjnTXQ7w@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     20210217072904.16257-1-charvi077@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 3 Mar 2021 at 13:16, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Mar 3, 2021 at 2:37 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > On Tue, 2 Mar 2021 at 03:45, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > > +       if (starts_with(sb->buf, "amend! amend!"))
> > >
> > > Is the content of the incoming strbuf created mechanically so that we
> > > know that there will only ever be one space between the two "amend!"
> > > literals? If not, then this starts_with() check feels fragile.
> >
> > Yes, so for preparing each "amend!" commit we add prefix "amend! '' to
> > the subject of the specific commit. And further if we amend the
> > "amend!" commit then this above code is checked before creating a
> > "amend! amend!" commit for the user. So I think maybe we don't need to
> > check for multiple spaces ?
>
> Okay, if this is guaranteed to be created mechanically, then what you
> have should work, though it may be a good idea to add an in-code
> comment stating the reason it is okay to expect just the single space.
>
> The alternative would be to avoid having "amend! amend!" in the first
> place.

Agree. I think we can do this...

> I didn't trace through the code carefully so I don't know if it
> is possible, but would it make sense for the caller(s) to check before
> adding a second "amend!", thus eliminating the need to do so here?
> (Perhaps I'm misunderstanding, but the above code almost feels like a
> case of "whoops, we did something undesirable, so let's undo it.".)

I looked into it and got another alternative, to extend the same
prepare_amend_commit() function and replace the check condition of
if (starts_with(sb->buf, "amend! amend!")) with the code as below :

const char *buffer = get_commit_buffer(commit, NULL);
const char *subject;
find_commit_subject(buffer, &subject);
if (starts_with(subject, "amend!"))
const char *fmt = starts_with(subject, "amend!") ? "%b" : "%B";
format_commit_message(commit, fmt, sb, ctx);
unuse_commit_buffer(commit, buffer);

So, now it checks the commit subject here only. Otherwise as you have
suggested above to check before adding a second "amend!", I think that
can result in confusion as currently both "fixup!" and "amend!"
commits (commit's subject) are prepared by same code and further for
"amend!" commit as we write a commit message body also so we used
prepare_amend_commit() to do that stuff.
