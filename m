Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5812EC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49C02311A
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WALoJhr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgHFRWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729759AbgHFRF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:05:26 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D16BC08EA0A
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 06:47:48 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id k4so5162034ooa.9
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DD+mnIPaHd2IUEye4vP9idgOUK1AI4/kzIio5TILVU4=;
        b=WALoJhr6mt/D+VpY9PuYICF6hAV3YsV2abuho2jmSSlFYFaEuzUH1NLJ18OVHLXzM3
         QSJTdUePIGVeCz9E+pXGS/fQ7C139fBfds8yudcbEeAZoMot9Dubs8Hq94hmSmEUbyX2
         byFZD1KZLZqzr7sfV3GXRS+9tGtHVC0WPXNzbPXKsLS6kn7Ye4c6wt9gA3cBnwNqkOvZ
         h3A1h7qfR4Gi1awWKQZL5Xg5JN8sRt2BbWKfYO/A0txzVXNu5Zpc4qtZJtFOyFF7riK+
         GgCiY8+K1HLVB9UCWwReivoNA4Di920iztYfTo4Fs5P8fmAqOVb+fQcjwnf+WUB3ZncO
         QWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DD+mnIPaHd2IUEye4vP9idgOUK1AI4/kzIio5TILVU4=;
        b=Vk/SD7jP2V1ARxcnrnNbP+1m4euJNPnN1Yusg60MZ2IC/4AY4ATT9YG3HqeCj1DcLC
         P3EQpBoG6ovJfmPYvEhKjxRcNZ5l3MA++I8BC9V0GrKnGn0CAkTu2Khn7NDgGRsZ3nMT
         bbj9mS+ApkMzSNXyyvTQaOxr27KLTcEhdW7swrIjYXVd4GshphbGrWL+FsHuysK3Dea3
         P6C2kDabOq6T0nW2TgAXgsDwxjhtAwIXKV8MO45MBqnWff5u4jpBQBhIHHmypFVxHlMp
         lHllxF5ChLBLx9iYtBs1x3QkZ2lRQ9DxSBRnQvlFQ9IwxfZVL5AOX+V3vTCYgef7GXjv
         LAsA==
X-Gm-Message-State: AOAM531Y+xiQTCY/dyhRealRjxvvFppdVMUAjoftMrq8OxppkB7CWSjH
        K10ZJfnOY5SFjcDApC3TWTR69I+LSMsqvnn/ZF0=
X-Google-Smtp-Source: ABdhPJx7bDpeJCxF98dpCCAmNckRe3yAjAGhcQn98voCwVE1TqUKDxqkF2zzFwD85GUtWkQTFv6888n8jYHxxIqpmM0=
X-Received: by 2002:a4a:98ed:: with SMTP id b42mr7889583ooj.32.1596721665691;
 Thu, 06 Aug 2020 06:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
 <pull.684.v2.git.1596664305.gitgitgadget@gmail.com> <xmqqtuxgn408.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtuxgn408.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Thu, 6 Aug 2020 19:17:34 +0530
Message-ID: <CA+CkUQ-kRjBRTOKC-fuY7p6tOZFTaMddNseOjbZV_Mf6_F2mDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] [GSoC] Improvements to ref-filter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Aug 6, 2020 at 3:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >      -@@ ref-filter.c: static struct ref_to_worktree_map {
> >      -        struct worktree **worktrees;
> >      - } ref_to_worktree_map;
> >      +@@ ref-filter.c: static struct used_atom {
> >      +                        enum { O_FULL, O_LENGTH, O_SHORT } option;
> >      +                        unsigned int length;
> >      +                } objectname;
> >      ++               struct email_option {
> >      ++                       enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
> >      ++               } email_option;
> >      +                struct refname_atom refname;
> >      +                char *head;
> >      +        } u;
>
> I'll try to find enough time to read the body of the series sometime
> later this week, but this interdiff alone smells that this is much
> closer to being correct (no, I am not saying I spotted a bug, but it
> certainly looks liek it is on the right track, relative to what I
> saw the last time, to be right).

Thanks. I'll wait for your review.

> A good test for this new feature may be to try using
>
>         "<%(authoremail:localpart)> <%(committeremail:trim)>"
>
> as a format to make sure e-mail options are done per-atom.

Yeah. This test will surely make its way to t6300 in the next version
of this patch series.

Thanks,
Hariom
