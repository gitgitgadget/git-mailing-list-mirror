Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C87C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 10:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356061AbiEEKwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 06:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiEEKwm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 06:52:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF59E15FD7
        for <git@vger.kernel.org>; Thu,  5 May 2022 03:49:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so3625080pji.3
        for <git@vger.kernel.org>; Thu, 05 May 2022 03:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T5KwN8wrknyRZJOBitIpSinGcHyVGsXdNjlWBqUKlXo=;
        b=CXZGhY09YC6rTsZ4B9n6i6PU240f/XBEDwhxGGm/kKyo5PqfevNoMpXBt8iuihoEcd
         YSeCFpNYP6CRlxQdlFkdB+d6viTfp+vRv+1FmGYypzC8HNTJpllfQiJ2LJZ1L8wXKiHY
         +eB67twiqgmGdz0sDBYFb+F/RoYSoNWd5jzSwCSPKYBLRyY0nFBCyGNSuevF4tb2dCuw
         Ot4nMC4mybTsrHxOpyqatuZPb31Kv/BNnNn8Gi6fS1yxEHJzltJvx+ZPd8+ULROCPtbW
         gTlxmdSerT0eYFIQJV43WIp1LYGLsMBBFyu/CZgmOyfE90xbQMZmwfSfCKuR+W5OKf2b
         T9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5KwN8wrknyRZJOBitIpSinGcHyVGsXdNjlWBqUKlXo=;
        b=NLTkwOBFEmLUgnwlVObKzK5cT7S8uKh9QCANo8ZwiUDSj0NRqHRgywwqX/qVTX6JHp
         oMFpJd2X7Dv7S7eTJRNe/8QykfNsmrc/JyqvrZkU+TXxEY60Cgd97dea66iRfHT2F4dx
         4+dIbOHW7czMDs6tRjXaD4nULV3iTs5wcbSXMWCStrzix3/gbMVw6CZhC1myCng9lmsT
         jCv/AIPpvb/fDi/LmocgiOvUwhmAy1kwBxOoIN0YeHZJI7btFmJnuOu+GoDBDaLKIk6y
         khc5OOdC7iwqmsPqsXQvy4IUCBR9WDQd4/vofP5No71HpHmCJBAoVpfLoBWFu7jv3qo2
         bJzA==
X-Gm-Message-State: AOAM532dYhrduQVGlvBvzkS62RhtwxThEiFXz+VipBe6gueDq9xHp2kY
        7w8957HFwGiK6d5qbxJSVm+1TGVCTizty0BG2IM=
X-Google-Smtp-Source: ABdhPJynwioRZbkCg3pFwk9QQUOLKUJvCOgq2pPm+JGjJU2GGveB8B1gjoN25GJ1+ZJknvfXNs/E3SDT2yzNGVhE40c=
X-Received: by 2002:a17:902:ce8b:b0:15e:c249:1bf0 with SMTP id
 f11-20020a170902ce8b00b0015ec2491bf0mr9174419plg.125.1651747742354; Thu, 05
 May 2022 03:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220502083639.610279-1-chriscool@tuxfamily.org>
 <xmqqfslrycvp.fsf@gitster.g> <CAP8UFD0hWUudP6pZVGS5yOVCjbBCm1LdK_EbrsQp9KiVPPMCyA@mail.gmail.com>
 <xmqqzgjxnz73.fsf@gitster.g>
In-Reply-To: <xmqqzgjxnz73.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 5 May 2022 12:48:50 +0200
Message-ID: <CAP8UFD0V6scSD8LuUiRQ0BWmG2mFATVFNQ2DgwaWFp6bigBkZw@mail.gmail.com>
Subject: Re: [PATCH] http: add custom hostname to IP address resolves
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Jacob Vosmaer <jacob@gitlab.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 4, 2022 at 4:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > I am Ok with just "http.resolve". I think using "curlopt" is perhaps
> > going into too many details about the implementation of the feature,
> > which could theoretically change if we ever decided to use something
> > other than curl.
>
> You may want to step back a bit and rethink.
>
> Even if we decide to rewrite that part of the system not to depend
> on cURL, end-user facing documented interface, i.e. how the mappings
> are given to the system, will stay with us, and it is clear that it
> was modeled after CURLOPT_RESOLVE---well, it was stolen from them
> verbatim ;-).
>
> So we may wean ourselves off of cURL, but CURLOPT_RESOLVE will stay
> with us for this particular feature.

Yeah, the CURLOPT_RESOLVE format will stay with us, so Ok, I will
rename it "http.curloptResolve" in the next iteration then.

> >> I am wondering if we want to mention the expected use case here
> >> as well, something like
> >>
> >>     This is designed to be used primarily from the command line
> >>     configuration variable override, e.g.
> >>
> >>         $ git -c http.resolve=example.com:443:127.0.0.1 \
> >>             clone https://example.com/user/project.git
> >>
> >> perhaps?  Not a suggestion, but soliciting thoughts.
> >
> > I am also interested in others' thoughts about this. If no one thinks
> > that a config option could be useful, I am Ok with making it a
> > "--resolve" command line option that can be passed to any Git command
> > similar to "-c <name>=<value>":
> >
> > git --resolve=... <command> [<args>]
>
> Absolutely not.
>
> "git [push|fetch|clone|ls-remote] --dns-pre-resolve=..." that is
> *NOT* git wide, but is only for transport commands might be a
> possibility, but even then, you'd need to invent a way to do the
> same for non cURL transports (we want to be able to pin the IP when
> going over SSH to a certain host, for the same reason) if we promote
> it to an officially supported command line option.

Ok with renaming and implementing it only in transport commands. I
don't want, and I don't think it should be necessary, to invent a way
to do the same for non cURL transports though. I think it should be Ok
with the doc saying that the option has only been implemented for
HTTP(S) yet and will have no effect when other transports are used.

If there is a simple way to do the same thing for ssh, then I might
take a look at it later. For "file" or bundle transports, I don't
think it makes sense, and the "git" transport is not used much in big
hosting services where this feature is likely to be used.

> Unless we do that, it is probably better to leave it as an obscure
> configuration meant to help server operators.  At least, with the
> name of the configuration variable prefixed with http.*, we have a
> valid excuse when somebody complains "the feature does not do
> anything for git:// transport".

I am happy with leaving it as an obscure configuration meant to help
server operators. So I will just rename it "http.curloptResolve" in
the next iteration.

Thanks!
