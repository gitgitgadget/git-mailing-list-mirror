Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2488AC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D209661278
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhELAYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 20:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhELAYb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 20:24:31 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F5BC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 17:23:24 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id t6so8672849vsp.13
        for <git@vger.kernel.org>; Tue, 11 May 2021 17:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jAZ0YfCybjiVZz9qmCbXWdIDebcw/hr13FA1nnNBMb8=;
        b=Lob3U6MNlHgwfHX5fyAXX4dj9ogjtHZ4C+PDzd1XA5oEoHMLTn+Lnj+oPNVU8hXvsV
         dCGWH5kxP/aAdLmdPctRvZUlSD2/lwKzAYMNSrCIpwWmeEPXlehDHYqMKOCl1RymQD6W
         Rxf0i2OSdiL8kg3Q2Ge3TqjpJ23e0iqYqEv2KWG1lGOUbY/yyvLUQRyM0hSgWLFhlaIS
         ++NdE1po6MrP/CI0AX93GDWLeAsF/iM9uuaGp653FvWxMX8SWWha5uEoTBX6li1Ftm3+
         Rd5uJpmrJtb1/OooGR2FlHrk+TJZMEBMHaTsxTedLR5Zb5UWbSbBnH2znWFfOB1oiKKn
         heqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jAZ0YfCybjiVZz9qmCbXWdIDebcw/hr13FA1nnNBMb8=;
        b=lDDtINqKxWu/7jyFFUSk+A0UIN7XfT2zD6hgBmLdkDrnuIBqcKLTS/9MtU1H06Wqbn
         J3/7LIF/EK27uN3XKbRmn/VpbTU1Ulw/kXZ7Ox5Wy1WMt4FlMClCEr9DjNNkgcO6nfDz
         Ai6fP8QV/xWwJ/7zMzLf8ltHc6rcixoHCCNGLuRu++9eqBnIdHHmIfSj86Sri52s5/kk
         fs6PT6dT1kdyoRllFITupaHUybnrWcdx+OM4kGejJwqE1wnyR1F6l53faep1yehHtyml
         8vvAsUTNXuHXHCCkNoEG1BDEvrIQQyrOhV8KLcwDYjOZ8BUMynT/qGELnQf9PEkmHXPD
         7RmQ==
X-Gm-Message-State: AOAM531sBkIoOKwmpKnYo7a/nQnUwH8t9jsh4qyL7HZHV5GqTHRph0SE
        oicJMJHaXw/l6tD6YtPPzjF9w6UvbpJUXL4p5gLtV8IPq40=
X-Google-Smtp-Source: ABdhPJxplGSHgGIRkCWZ3CC4DsX49Id9fxNhBihKpGDE62i46aeTUD8YwO27jWE0YY5eknb0JYYFK9APPuULpEOIeu0=
X-Received: by 2002:a05:6102:e0d:: with SMTP id o13mr24764941vst.17.1620779004139;
 Tue, 11 May 2021 17:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <MN2PR07MB59526F40B255183931649AD19C529@MN2PR07MB5952.namprd07.prod.outlook.com>
In-Reply-To: <MN2PR07MB59526F40B255183931649AD19C529@MN2PR07MB5952.namprd07.prod.outlook.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 11 May 2021 17:23:13 -0700
Message-ID: <CA+P7+xraXVhvjNhJqrzDGNh=RZqC0HnKLBved+7RukC9pmMthQ@mail.gmail.com>
Subject: Re: Rebase Question
To:     Andrew Ottaviano <andrew_o1995@live.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 5:08 PM Andrew Ottaviano <andrew_o1995@live.com> wr=
ote:
>
> Hello all!
>
> I=E2=80=99ve used git for a few years now and I
> think it is an amazing tool! Thank you for your hard work in
> developing/maintaining it! I really appreciate it!
>
> I have a question. Let=E2=80=99s say that my
> colleague and I branch off of master and are working. Let=E2=80=99s say I=
=E2=80=99m 5 commits
> ahead of master and my colleague merges in ahead of me. The logical thing=
 in my
> mind is to rebase off of master. The difficulty with this is that if I ha=
ve
> merge conflicts that show up on my first commit, I have to resolve that s=
tupid
> thing for every subsequent commit. I could squash, but then I loose branc=
h
> history, so I don=E2=80=99t really want to do that. I could rebase in int=
eractive mode,
> but if I recall, I still need to resolve all the conflicts on every commi=
t
> before it squashes.
>
> The solution that I thought of is instead
> of resolving conflicts from the bottom up (starting with earliest history=
),
> resolving from the top down (latest to earliest) and resolving the confli=
ct in
> the commit it occurred. If that doesn=E2=80=99t work (or I guess it might=
 be the same
> as a merge of master into my branch), then couldn=E2=80=99t git at least =
store the
> conflict resolution?

You might try looking at git imerge for this
https://github.com/mhagger/git-imerge

It resolves conflicts by doing incremental merges, and then you can
have an option to produce the end result of a merge or a rebase.

>
> Maybe I=E2=80=99m silly for asking this question,
> I just really like rebase because it is so clean and this is my one frust=
ration
> with this method.
>

It's definitely a potential frustration that can occur during large
rebases like this.

Thanks,
Jake

>
> Thanks for humoring me
> Andrew Ottaviano
