Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057ACC433E6
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 19:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF5D61490
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 19:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbhCATkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 14:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237908AbhCAThW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 14:37:22 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2B6C06178A
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 11:36:41 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m22so27420790lfg.5
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 11:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wB5ge/QVk6iwTT95hm1pdyaHWzgGeVSQ0/c81nZn4lQ=;
        b=UUmAgqfWHbuY8XkVPWKHLClb3t7ltyYuOdNMn9Y+3VE1NYrQdO2gd2/YRyNt/GMEd6
         FLj/8wM4AFqDPcLW4M5q+BCWN1wWyiQ+aFMTnzPQHwjtAJopR7mjxx0yH90MxfepcS06
         cA9eOFyuEPlh2Dt331VevhncZwHL7nxAfIFLjBEdEqFpEaO5XbiVrlSAw3sGJXjxPlkl
         +Zj8xMeO1Ec0rlNKDm3xLAnEyQJxsoQL9aRs0p7X8fvqB+QfB1/roh8dx2GttffWvwKS
         ocKIFaJ/N9jPAeKjuNSpcpCpO/dcAufS2KRtSIJtvq1k6TMFnU0TeEwKtjKVS0EQdJoI
         YTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wB5ge/QVk6iwTT95hm1pdyaHWzgGeVSQ0/c81nZn4lQ=;
        b=HiOlWqo3vbT3RR1vBydJW5r07leYNs9oUfbhd4sd/ig8o3kYEq2mRCsJQylfmheQID
         RhGX7a/IC6rFPBzmeHBuGueGj+MO2QR/H8vqM0PoPxvDv8fLQU2Z6VKi51Rx7JYdGAlw
         novA8O+BH76JrEoaOv5Ymfvf6CgOexiU6CCVZrltooVTlKDcn15c7KRP1e9cqeFmnrEd
         VABqinRSkXhwn4n4B4HoGVyWReJLAapPYpOipuZzSeck3hM2WX6yNHNz79g4VpLB+9vS
         afbr/cfwsUEeZfvoJdYelCtaTd2RqHXrLOdekVU4zHqGhontGcrKHQa5UCEXGzmYvPTm
         xIdg==
X-Gm-Message-State: AOAM530lwANyfQscYcgNKv+43KO2UnTRTJRCa6w+yqmkXqVkKoLQE3Cx
        kCd4V1xmEIuAJBa9S4KvduSkFK3Ptx/JVdE6gFI=
X-Google-Smtp-Source: ABdhPJxsiEGfiNn6kb/fII7Dm0F1Wl87vvNavvDG3ZylqiD1peFj1/qieukgxgMVhy+3VXsvw7MoxNLJLLLsnoNv3Rg=
X-Received: by 2002:ac2:482b:: with SMTP id 11mr9975792lft.642.1614627399737;
 Mon, 01 Mar 2021 11:36:39 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7doqwvzx.fsf@gitster.c.googlers.com> <20210301170536.12265-1-tboegi@web.de>
 <xmqqzgzmptmy.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzgzmptmy.fsf@gitster.c.googlers.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Mon, 1 Mar 2021 11:36:28 -0800
Message-ID: <CAPx1GvcjO0-3nbcC_oYkYjhYenb_J9CoM6bZNaR_-t93cpppSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] git mv foo FOO ; git mv foo bar gave an assert
To:     Junio C Hamano <gitster@pobox.com>
Cc:     tboegi@web.de, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Dan.Moseley@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 1, 2021 at 11:26 AM Junio C Hamano <gitster@pobox.com> wrote:
> Before the problematic patch, this used to be
>
>                } else if (cache_name_pos(src, length) < 0)
>
> I wonder if we should revert the change to use cache_file_exists()
> in the first place (and rewrite the subsequent use of ce to match),
> though.

For what it's worth, that was what I did originally; the change
to look up the ce "up front" was because someone objected to the
double search implied by calling cache_name_pos once, then
cache_file_exists to determine the correct error message...

(I've never been 100% on how the ignore-case stuff works
internally.)

Chris
