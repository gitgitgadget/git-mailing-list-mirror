Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F425C7EE23
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 18:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjBXSzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 13:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXSzt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 13:55:49 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0455193F3
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 10:55:48 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1723ab0375eso561649fac.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 10:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7S5Uc2QgfMg5F+ZXAV1/ha8pfXrdLla39lwVqzc9by8=;
        b=gkyYkLJx4JG82vg2XVEnlIddcZmy8FJmi4rfnr+Lxz0jpDCY44SuZjgvIMhBSyaQ1W
         AohP3YEMwFeDM72EdHCDr6O+2uABFPsec9gzLKb7ZAOKihHcLuNKa4zsS83NG6YtjjhL
         Xe70BzO3G9g57GpT6qJwdIv1QngV2Fmye5AeNTQiYFQCZ8p2B4RUqvEvPAoqdkaM9NkR
         Cs9oPYGgUHHyH75CGIfuUXqfjdG6VeXXGWhtB5luBbnUO1zLOn/C/wHjd7V1rtyQyGuu
         zZlhwyaU08Kxlq3qR1V/SQUxa5pMocNL51b4V5Vdx0gI8gLjc8IguiopuVfOZAe+qmIy
         6VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7S5Uc2QgfMg5F+ZXAV1/ha8pfXrdLla39lwVqzc9by8=;
        b=YKyQrh83LkD/m9o1z1H7YivPghk6jAt4wg1ru0k7KqPNU5yzqeLsLONWKYxHV/VqjJ
         5NW1DoEUX4MpOk96yJl29pVCUjei5oLGrx8kLkpnJzXL1Kzc8OsPTCI/L9o6lI+PayQ3
         v9GvskFi1xKVUWVMXtfx00e53scwx4675AdcjkqiiX4K+E+Rer3JtAksZj/RGa9i7ZQQ
         kzgpXwBoT58wN0wIxbIiYtoJW0brNkXwyzRJIKjxqGnjKHF4ADBT/5cbiaSSZTxKxwoa
         qUL4Sd2KYGNmWGc6otBbxJgHcX0ae6ecctOHFFed5r0BFU7ElpDPFmAM3I4zM4PTEaO0
         Y8Zw==
X-Gm-Message-State: AO0yUKURCDfN3+b+i5kWJ7iRrRowX7UuwjoDnxSXmsvhx/ilIQ9RvV3U
        zJ66EuNRUKs6ZnwBAhDcEt27Zz+3ENJ6vh/Kl4c=
X-Google-Smtp-Source: AK7set/z8OGeJ94tYTdEGag9Czvyrv1W4TEy39vuSHIRApvvOb7dAwD/IcluAtwpw50VVdDQtsX9R/Ptxg0ThWQ3SRk=
X-Received: by 2002:a05:6870:955e:b0:16a:1d37:78dd with SMTP id
 v30-20020a056870955e00b0016a1d3778ddmr1090948oal.5.1677264947707; Fri, 24 Feb
 2023 10:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230223053410.644503-2-alexhenrie24@gmail.com> <b4be9cb3-c24b-4377-bab3-5d53035efdf8@gmx.de>
 <xmqqy1on0yla.fsf@gitster.g> <CAMMLpeQKJeZn4rcTJzFR-ixQXKQMT7t-BKvJqXV4o_4VM=tHYg@mail.gmail.com>
 <xmqqcz5z0wdb.fsf@gitster.g> <CAMMLpeSH1itopDuON=7ms_7Li7Qk+9dhzKjT5f7UE11posKK=g@mail.gmail.com>
 <xmqq8rgm29fw.fsf@gitster.g>
In-Reply-To: <xmqq8rgm29fw.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 24 Feb 2023 11:55:31 -0700
Message-ID: <CAMMLpeTvyYgGNBQWtRBg3ZNuXeCMxiem-5LAdu0ex7XCuf0wAA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] rebase: stop accepting --rebase-merges=""
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, sorganov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 11:40 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > The only way to truly make "[rebase] merges =" invalid is to print an
> > error message and die with that configuration. I think that would be
> > confusing too, especially since it's now looking like rebase.merges
> > needs to be a pure boolean and an independent rebase.cousins boolean
> > option is needed as well.
>
> Oh, I wasn't aware of that direction.
>
> I do not know why rebase.cousins, which would only be meaningful
> when rebase.merges is true, is a better design than rebase.merges
> that is an enum of "don't do the merges stuff" plus "do the merges
> stuff with cousins", "without cousins" (which may allow us to gain
> more different ways to do "merges stuff" later), but that is what
> gained consensus on the list, then "[rebase]merges=" would become a
> problem.
>
> But --rebase-merges from the command line is not a pure Boolean
> already, so what does "[rebase]merges" that is a pure Boolean aim to
> help?

Phillip is concerned about people and scripts assuming that
--rebase-merges is equivalent to --rebase-merges=no-rebase-cousins,
see [1].

Tao and others are probably not going to like it if --rebase-merges
without an argument undoes a rebase.merges=rebase-cousins
configuration.

It seems to me that the only way to make everyone happy is to have
separate rebase.merges and rebase.cousins options. You have a point
that separating the options could cause problems if --rebase-merges
starts accepting more arguments in the future, but if that happens we
could deal with it by adding more possible values to rebase.cousins or
introducing a third config option.

-Alex

[1] https://lore.kernel.org/git/CAMMLpeQ98BTCGE2tcVdZ99eU6cLh4Rd_hc8C_PmKvsBkjXUWPw@mail.gmail.com/
