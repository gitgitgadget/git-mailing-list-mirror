Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD36C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A85B610A2
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhETITs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETITp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:19:45 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B19C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:18:23 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id c196so7472431oib.9
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ofltwwXyjekExZZyVSOeRbmTP/H6BQPzUmq2hv9Ca9E=;
        b=ZoeRxRJjoBNJXhpzisxHdtU9Ho7pcEE6I6yAvrajLbppsWrObwVuDTA85T2rJ+hz60
         UGc7VtYS5oIUmuxuxpPy1/u7UdvRsxF8JdUJd614KOBDw04kpf91+pjbviNV8UO/NG15
         ZHNyMRhTNCk67dURjTUlm2O+hvvRP4YOZI/UrCgfbNuKg6J/n5FPNpno3aW5V+k5vlLI
         kqSl47AGmryK3BGVHDFKGyuDKaAx2PmhKaygFrxyJE1zdKVyR+yI9iITM2oi98QgwDfc
         Y4ke9jMiusg3sU/swmQcUfsSDOUepQh5E3v1W2LUL+vHCw/kWIHG4buZqP2kcGeChXYr
         jhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofltwwXyjekExZZyVSOeRbmTP/H6BQPzUmq2hv9Ca9E=;
        b=tXdb4OguUq2ELMyBAzk1r8y8mLBaataf7AT8XcSOhM4dqeAv3hjhXUdcw4OWXjCado
         YtvqD8SQQj6LJ9ghtu7eIA+0yDO2XG09g0yxVhjl5oU/R2aSuqINQ4QMglmwbK4NCBC+
         V4PoYiPEjjYh0Hs2145cXRZcSbm0rHD3WTlpkb2FWBtVltYnN1t8jOAMiCswX1oHm7wG
         G/BP8tSkvJiB+oOJ+2gHV8X/4vcUKbqHUGDXRKW5Y74gmq0uCYyqpMTA8mDPe+GTEYQ8
         Ott9WCyNQvLtKQUNcIEsCZWVvEUiWX0eQEmsPXY0JNcE4sUjxAS8XdwyOOGkmShaI9Xy
         4Mjw==
X-Gm-Message-State: AOAM5321+JskRKbekezUVYlejU/xkvhKbMhf9V0yiD44GX3h+p7VYn9z
        PpD8s2bYK1yVv7nDI/HTBTU2DFmESnRfP3qdxOk=
X-Google-Smtp-Source: ABdhPJz8TO3d7k2PQf3FT6ThiwrqeMAHh6qJbB3nQEGPiGqODfmMqMnwOpDmdc1APWLNQ/tQO7FCEQJcs0zssJvAQcQ=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr2396216oiw.31.1621498702854;
 Thu, 20 May 2021 01:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqtumyulv8.fsf@gitster.g>
In-Reply-To: <xmqqtumyulv8.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 20 May 2021 01:18:12 -0700
Message-ID: <CABPp-BGmGbX6bz6mQPgqdo4KPdtEb2u6UMznCEedUf_iA0KVrw@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2021, #03; Thu, 20)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 8:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> [Graduated to 'master']
...

> * en/dir-traversal (2021-05-13) 9 commits
>   (merged to 'next' on 2021-05-14 at 316f9264c1)
>  + dir: introduce readdir_skip_dot_and_dotdot() helper
>  + dir: update stale description of treat_directory()
>  + dir: traverse into untracked directories if they may have ignored subfiles
>  + dir: avoid unnecessary traversal into ignored directory
>  + t3001, t7300: add testcase showcasing missed directory traversal
>  + t7300: add testcase showing unnecessary traversal into ignored directory
>  + ls-files: error out on -i unless -o or -c are specified
>  + dir: report number of visited directories and paths with trace2
>  + dir: convert trace calls to trace2 equivalents
>
>  "git clean" and "git ls-files -i" had confusion around working on
>  or showing ignored paths inside an ignored directory, which has
>  been corrected.

Did you change your mind since
https://lore.kernel.org/git/xmqqtumzzedd.fsf@gitster.g/, or did you
just accidentally merge all 9 patches instead of only the first 7?

Sorry about this, I was going to resend corrected versions of the last
two patches...but I'm guessing that's just not warranted anymore?
