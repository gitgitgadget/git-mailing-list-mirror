Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099B3C61DA4
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 08:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBRIBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 03:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBRIBG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 03:01:06 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBA24DE2C
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 00:01:02 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z22so194529pfa.10
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 00:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eM8Hd1R/2xWAJGa1+CgrO+MqB2x8xdvBa+KsytRzhyg=;
        b=LoVXGsalyD5NhNVShuBPNrOscC2XfE/7XQ4v52iBj267Zl8Dx5f7zHeWVu1TS9PrRy
         bMr0gSrO/GvaYVb2loLyfyHV3kHSb6Ry01zQkAuzVtbvkb/j7u4PXlclCmhiqdmz2L2G
         AZyaBqFOXk526wAYT3HbsLgaIJ0dTBk5/UM+H7+DMP/7e0qWQGOI2g/EV/L60ZYpErtv
         MHO/ph/4sDRvu/+59r4b73BYHcv1QyWbqF+b18KNMAwz38mSWDXZ9pPZH6GE+VYilfzJ
         aQzEdqtNynBinOAkt4RrA+B6WmcgU1cHSgWiqPg8YUqYAJz//sDvn4hgTEpfTOPFdBX+
         xQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eM8Hd1R/2xWAJGa1+CgrO+MqB2x8xdvBa+KsytRzhyg=;
        b=UqBluuqZklCFRjYxBYHYEESFJhGvq9174GDNMOEWgML+0nRHSY7UeM1M/CUWD0CNAH
         HU8Jlg7d0dU+8x+oNwMR7dtL7d7itDLoFjhyZYFfIbV9dfFDRYDQ0JURMS8/RQwiwTkP
         q6yVRL6NsZgI5LRX7Ylo7UleZlNgWhT1C0Vgx1cuXYdZOIkgt7lY52l2StoO6CEDUJTW
         zhnAbVS2gWSeN6kUVl/UzOU/RkKW/IpZip2wamvPQXfhsjzRAKBHo5SQ8v6N10gHXajs
         WLwBLIHacY9RatYa9yU75MNAYjzaXSZBGSM9H8ZWAQyPh6J/DjPlVfysZ8uXq3hBm1JX
         9qlw==
X-Gm-Message-State: AO0yUKUhzCdjSrKrtfYIpUwpPYzTpgD7cVnwlxdsOvGYJ3kRUSJsPmu7
        9FLhWMbaZMF9Pt6RtE053spn82Nbh33itlvoFqZ0sSVQpeY=
X-Google-Smtp-Source: AK7set/3hMCcRhGlk42rYmEfhnViGhamOhXxNbfX6Vq+TGr+kKtLK9V/8SVCxMIEoLxnwvg1eHXO4X4PC/ifi645EYo=
X-Received: by 2002:a62:cd8a:0:b0:5a9:c22e:7764 with SMTP id
 o132-20020a62cd8a000000b005a9c22e7764mr565836pfg.5.1676707261722; Sat, 18 Feb
 2023 00:01:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
 <pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com>
 <xmqqmt5h80s8.fsf@gitster.g> <CAGJzqs=t7k2zRKKq9xN-Avbo2uXgqsg7i0Utfv-ee6yZ2CWNDA@mail.gmail.com>
 <85ab572a-cd00-f62a-97ab-f344e2b6f68e@gmail.com> <xmqqa61ckl6j.fsf@gitster.g>
In-Reply-To: <xmqqa61ckl6j.fsf@gitster.g>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Sat, 18 Feb 2023 08:00:00 +0000
Message-ID: <CAGJzqskEnFmH-df5w+9eB8f65cTe3foJv712+q4qCxjPLrh3gw@mail.gmail.com>
Subject: Re: [PATCH v3] credential: new attribute password_expiry_utc
To:     Junio C Hamano <gitster@pobox.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Cc:     M Hickford <mirth.hickford@gmail.com>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Cheetham <mjcheetham@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 17 Feb 2023 at 21:59, Junio C Hamano <gitster@pobox.com> wrote:
>
> Lessley Dennington <lessleydennington@gmail.com> writes:
>
> > diff --git a/credential.c b/credential.c
> > index d3e1bf7a67..b9a9a1d7b1 100644
> > --- a/credential.c
> > +++ b/credential.c
> > @@ -236,6 +236,7 @@ int credential_read(struct credential *c, FILE *fp)
> >                         free(c->path);
> >                         c->path = xstrdup(value);
> >                 } else if (!strcmp(key, "password_expiry_utc")) {
> > +                       errno = 0;
> >                         c->password_expiry_utc = parse_timestamp(value, NULL, 10);
> >                         if (c->password_expiry_utc == 0 || errno)
> >                                 c->password_expiry_utc = TIME_MAX;
>
> Ah, that is quite understandable. Successful library function calls
> would not _clera_ errno, so if there were a failure before the
> control reaches this codepath, errno may have been set, and then
> parse_timestamp() call, which would be a strto$some_integral_type() call,
> may succeed and will leave errno as-is.  Your fix is absolutely correct
> as long as we want to use "errno" after the call returns.
>
> When strtoumax() etc. wants to report overflow or underflow, the
> returned value must be UINTMAX_MAX/UINTMAX_MIN and errno would be
> ERANGE, so it would probably want to check that errno is that value,
> and/or what c->password_expiry_utc has these overflow/underflow
> values.
>
> > ... I have not confirmed on freebsd,
> > though, as a heads up.
>

That's a subtle one! Thanks Lessley very much for your help debugging.
I shall send a patch v4 with this and some minor changes discussed in
review club.
