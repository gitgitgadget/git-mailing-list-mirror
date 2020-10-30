Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF72C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 11:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1E7207DE
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 11:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUl8bjH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgJ3LZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 07:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3LZl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 07:25:41 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663D0C0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 04:25:40 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id s144so1387834vkb.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 04:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5eISZumHamiqjNkWI78/+0W1GprUaJ9neoKDFJqWMM=;
        b=CUl8bjH2uRCG7OmfGJ0E0aJMwavA6KPpZLmZJngj+ClgrCD9bju1KI25Ws3mCzmXjj
         pZ5Oq41ugz9INpTzd3Ssy+oz2+XXw1N9bPtY0tp7Jf5LV8B6/vJ2g9FmDwuu+HmSL8vO
         9gEIbNuht/cXyPFySxtfecNhTeeThRL4vtJCdh760IyE8f6vQ/xVops6ZClJIvvHrTOA
         Ed/+LxauMvySTbijj3o6UWS9WQyGjbkS3UsuBBGqWJ6ctXW1OXN5iTB6ul2IhlomPdlu
         3XkZ1FBO6BQ7xhtYTWuGwBf3p6vyQyD/4aeP7Be13sH1DDpW6knJNOnsMIvbjbb5H7nP
         GjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5eISZumHamiqjNkWI78/+0W1GprUaJ9neoKDFJqWMM=;
        b=SZhBi0HRJeM+q4mnsreONm/lABI6GDtYvpGd5FKg+XPZQAweYoK+YHpF9/vb1bT3b1
         B6ohK/oaMazTsWWvBYXtrO2yILDEMjzjdoTGi7NOYn+4kXXJLcYCuabStCgM37wdbaU7
         zOhRXWPl9dmXrp5x5dFUkOQcT6sCr7h1wxwNDpZ9GWx0iFpsvYhjol4nUR+3DCF/mrMm
         8toLMO/SQKKvOPxYZKKlVuBfnVXOW9lLqPKkmumVkl+rMa/dTuIimkTHGpmCDuyAWSCZ
         2lG0ekZ53Cn2NmYx30iklOl1buZeYKdNWWQtPcMEr2YpTWgybdMrnrfOHZY4d8FefJHp
         CG+g==
X-Gm-Message-State: AOAM533U2SR3ebDtBnD7UQqugnQy5kXJ8FrwN8a/VZWlcUNrdIPw6IIw
        VvN+FPidzTH+ojUsfiDWK8yD+1IrWqKZBmgYiJI=
X-Google-Smtp-Source: ABdhPJzuX6ihZwwa38Yel6FVrt9kNiNLMMLw1YBz6uhQWr6y+wPOqjd4pomSHc0bJVO9ds8h05OlyNl99TuD0DVlUew=
X-Received: by 2002:a1f:9c04:: with SMTP id f4mr6378248vke.14.1604057139324;
 Fri, 30 Oct 2020 04:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <6a38e92e-ffd5-4b0e-b850-3697e47b2b92@xiplink.com>
 <20201029114400.38284-1-serg.partizan@gmail.com> <619dac64-106c-d6df-b121-ce6589b4af3a@xiplink.com>
In-Reply-To: <619dac64-106c-d6df-b121-ce6589b4af3a@xiplink.com>
From:   Pratyush Yadav <pratiy0100@gmail.com>
Date:   Fri, 30 Oct 2020 16:55:03 +0530
Message-ID: <CA+X=3TLqbSAj9Tzq2MCjf=Ufx0RzNuriqho_3zT7ffbazQ5btw@mail.gmail.com>
Subject: Re: git-gui: Why are the main panels no longer white?
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Serg Tereshchenko <serg.partizan@gmail.com>, git@vger.kernel.org,
        Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Using Gmail because my stupid email provider thinks this is spam.]

On 29/10/20 09:47AM, Marc Branchaud wrote:
> On 2020-10-29 7:44 a.m., Serg Tereshchenko wrote:
> > Hi Marc!
> >
> > What tcl-tk theme are you using? Autodetection supposed to fetch
> > color from TreeView background, and probably your theme using
> > that odd gray for TreeViews.
>
> Thanks for your reply!  It's been a long, long time since I've had to muck
> around with a .X* file...
>
> > To set your desired color for background, you can add
> >
> > *Text.Background: white
> >
> > to ~/.Xresources; and `xrdb -merge ~/.Xresources` to apply it.
> >
> > Or, try another theme. This one gives me white background.
> >
> > *TkTheme: clam
>
> Unfortunately none of those gives me white panels, although I do see other
> visual aspects change under different themes (also, `xrdb -query` shows that
> the *Text.Background setting has applied).
>
> However, saying
>     *background: white
> does the trick!
>
> To narrow the scope of that, I'm going with
>     git-gui*Text.Background: white

Your other option would be to disable theming completely by setting the
config `gui.usettk` to 0 (via git config). If you still see gray panels
with this option set to 0 I would consider that a bug.

> > To list available themes, run `wish`
> >
> > ::ttk::themes
>
> I have:
>     classic default clam alt
> "ttk::style theme use" says I'm using the "default" theme.
>
> Is there some way I can edit/view the theme definitions?

On my system the themes are located in /usr/lib/tk8.6/ttk/. So for
example, the theme clam can be found at
/usr/lib/tk8.6/ttk/clamTheme.tcl.

-- 
Regards,
Pratyush Yadav
