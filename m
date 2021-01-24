Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3089DC433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E343D22CAF
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbhAXKUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 05:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbhAXKUT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 05:20:19 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A26C061573
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 02:19:37 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id bx12so11678335edb.8
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 02:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=JBW/KkrtxXbxiRrgHUWFhTUY+SNHj5qPo52d34HRHME=;
        b=OUoXXB+hCOKb5ZjoL2PuGkbBvdHMkA7JXZYR/KpC/zvfyHtBnwqeIf4vUMqzwzyeJi
         KKvsJ1uG1n9cI0l0Vsbla+rmHngq1TiGsDjuL3iKfa/j+4h6prJ2Rdbd2XmN8y/Ll9eF
         ecVWvRpC1tGBtw93N4NicDkq686Y8zfjsu7Pg1Ny7al4FYykp9tRUAx0ng+JhyDdW/gb
         EjjGHK1nHcNA67X+gHj9QEHHJwCmhAbcCVYnhDZhx0ldSyBjXFJBWK2byPcCaGKTOfVr
         Dd6aCWQEIhTNHAlwDI7jhUqTX8DJ7AydSaWq4aERUl8B4IWqNeOZtM273FzYqU5JTDMp
         oagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=JBW/KkrtxXbxiRrgHUWFhTUY+SNHj5qPo52d34HRHME=;
        b=NnclTjwGpI0nI/IHnvwHfHxxZSvODlnhHHnp4nEW5DT+7ebjuJ3bFrPABT0kJfzAEf
         QuJY7MfyGZZCBWto+HS61Dgm3U3l/viFrQW9WYE9vA3RClaVrfq5hrfsj5Qoo/kdk5ur
         oVAwL6ecb4Ugz39nhIdd5M1uF20OwmmjWNqNX5Hoa40RWckxmIiljde0U0h5GHkhCoFz
         Fpk77TrSF9aMrRtfBkz0w3jgBBvr0513Nct1ExXFpVeKaJn3nLlD0+9Q22IHuEmJoj6v
         dGs3KiP+n2Dfk3F4XQhxlLe6xvom7/CbeRxGr0pVkSnHXfNBWl2YZ2DmmmqND08Ms5vY
         ZaSA==
X-Gm-Message-State: AOAM531U8se5o6cwRVwig3gZZRd9VXBfkFOhdscVMjzKljpxruQyJNLR
        XaJ22Q6X/YCVdwDihcN4aRg=
X-Google-Smtp-Source: ABdhPJyWYR2spSjcQlECQFV3J8GucOVA1YD2JaP8rCXuQvCP4yt9GGOEdBZYzmwwp4HCX/nk0Xvxyw==
X-Received: by 2002:aa7:cdcb:: with SMTP id h11mr539211edw.237.1611483576436;
        Sun, 24 Jan 2021 02:19:36 -0800 (PST)
Received: from cpm12071.local ([79.140.115.149])
        by smtp.gmail.com with ESMTPSA id x20sm6823389ejv.66.2021.01.24.02.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 02:19:35 -0800 (PST)
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-5-rafaeloliveira.cs@gmail.com>
 <CAPig+cQobybm7mddLws5v3F9A+uy2b5gV=UB10KG=iQAhFcBAA@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 4/7] t2402: ensure locked worktree is properly
 cleaned up
In-reply-to: <CAPig+cQobybm7mddLws5v3F9A+uy2b5gV=UB10KG=iQAhFcBAA@mail.gmail.com>
Message-ID: <gohp6klfciocwj.fsf@gmail.com>
Date:   Sun, 24 Jan 2021 11:19:34 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine writes:

> On Tue, Jan 19, 2021 at 4:28 PM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> In c57b3367be (worktree: teach `list` to annotate locked worktree,
>> 2020-10-11) introduced a new test to ensure locked worktrees are listed
>> with "locked" annotation. However, the test does not clean up after
>> itself as "git worktree prune" is not going to remove the locked worktree
>> in the first place. This not only leaves the test in an unclean state it
>> also potentially breaks following tests that relies on the
>> "git worktree list" output.
>
> A couple grammos:
>
> 1) Drop "In" from the start of the first sentence.
> 2) s/relies/rely/
>
> But please do not re-roll just for this. It's good enough as-is.
>
> The patch itself is fine.
>

Nice catch. I'll be re-rolling the series with the documentation addition
suggested by Phillip and the test fixes suggested by you. So, I'll
include these changes as well.

-- 
Thanks
Rafael
