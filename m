Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E373C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FB6206FB
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiC27S3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbgJONjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 09:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgJONjv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 09:39:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772D2C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:39:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d81so3232031wmc.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AeFCpK2nHR75LawpK3LIXhrd4xzI26mJaYu7ivNrbcM=;
        b=uiC27S3IhhUWXiP202op4uh9DclVqHsYL1+iWwblnMJYUDt8SSN1tRmJlfyzo2i1z2
         WvcFro3y9Q8JKcryGCpmTot2JR4yjlUrpmccqTVH3sIaATvBo0XTPLeGNuDK1O4Fp8FB
         C00/KkcoDaz5F38c4UTUtjVxA5mYk+l8UCC+JgxpbBcUpKe6v5IorKk6ojgRDyePsLlF
         mK8ktSteC/4RsKZcMlVXgkB/HH4aNvaqtpOVqiYkiJ35XdNoUIAY/kHmKpEA/HEaBsMd
         frCbuSysUT5TkovLwEqPrHTB2Uze66SQtLeWdCyrVpTNUfREosLvoD3JjtzkuCkcFixO
         WELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AeFCpK2nHR75LawpK3LIXhrd4xzI26mJaYu7ivNrbcM=;
        b=K9PTOT4odvoS8MzVrDxxfej1K1OMBSqqVr3Bm9kYO+72qZsYq/Lp94b2d2vb8TpTRN
         OOH0kQRddg+Ck7phswZF8Zh2or2IdKrwDX2/tFedih8IPQv7JgAknDBEOPFv00ZSoO8A
         iN0PHaG7IzgJCg/CbU7gCT3NpRjda4Gf8y2bVdfs6j+whVgZfft+RlhdwaEDrI6Mg8zM
         4vNelXLklDUTUJ/US0emmxCkjwzVYbK1i4nkSJvC0K7G0HRhPffhkYzXqT6L9J/DeVgL
         xw0+qfrgYqRk4z5xKLWpvpgVYwk0e3fhyERJcsOmusGdWfxjsENAXN1j8dJs7BgjWfnZ
         7deg==
X-Gm-Message-State: AOAM531C8d7CmGwHABeu0pGrFS/pwfWGcB9Ka8r5Iytj/RskGvZxTvFb
        T/r4jrHw7SqXJPClKoG3LKamVIpnJ/s=
X-Google-Smtp-Source: ABdhPJwxXKHu0Fe3HskF5dKKCmaGofsglrGEJlE7VzvtJa6BQ6SO8ClwuAF/nBpdjGqb3vihfh13wg==
X-Received: by 2002:a1c:b486:: with SMTP id d128mr4009297wmf.164.1602769189931;
        Thu, 15 Oct 2020 06:39:49 -0700 (PDT)
Received: from [192.168.1.240] (48.45.90.146.dyn.plus.net. [146.90.45.48])
        by smtp.gmail.com with ESMTPSA id c68sm4564799wmd.34.2020.10.15.06.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 06:39:49 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy] Introduction
To:     Sangeeta NB <sangunb09@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, kaartic.sivaraam@gmail.com,
        git@vger.kernel.org
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
 <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com>
 <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
 <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com>
 <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
 <xmqq362jsahk.fsf@gitster.c.googlers.com>
 <CAHjREB4Qw78xS-T=LA80yVf_u3=Hbpxg5tqBnP1QK44FRkBFOQ@mail.gmail.com>
 <3c0bf417-b3d5-b615-c605-49a5d8be4e06@gmail.com>
 <CAHjREB7xhBWHUCJ+T78i6dDGQr055sMAaYzG4gaQSr0T88cseg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <95c90e7a-8f4c-32b9-2b0e-9efce2acfb8e@gmail.com>
Date:   Thu, 15 Oct 2020 14:39:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHjREB7xhBWHUCJ+T78i6dDGQr055sMAaYzG4gaQSr0T88cseg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sangeeta

On 15/10/2020 11:18, Sangeeta NB wrote:
> Hey,
> 
>> I've got a fixup which I'll post after this which gets rid of the global
>> flag and instead uses a flag in struct diff_options.
> 
> Thanks for the patch, I was thinking about something on similar lines
> but couldn't come up with anything.

As we store the config options in default_diff_options and then copy 
them across at the beginning of repo_setup_diff() we can use a flag in 
struct diff_options which is set by handle_ignore_submodule_arg() to 
tell if we need to initialize opts->flags.ignore_untracked_in_submodules 
in repo_setup_diff()

> Also, one thing I observed that when I add a printf statement in
> wt-status.c, something like this:
> 
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -601,11 +601,11 @@ static void
> wt_status_collect_changes_worktree(struct wt_status *s)
>          rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
>          rev.diffopt.flags.dirty_submodules = 1;
>          rev.diffopt.ita_invisible_in_index = 1;
> +       printf("a printf statement\n");
>          if (!s->show_untracked_files)
> 
> then git status shows output:
> 
> sh-3.2$ git status -s -uno --ignore-submodules=none
> a printf statement
>   m submod
> 
> which is what is expected. But when I comment out the printf statement
> it again gives no output. I couldn't understand why this is taking
> place and how can a printf line modify the behavior of git status.

Are you adding the printf and then running t3600? If so then the extra 
line of output breaks a lot of tests which in turn breaks to setup for 
the test that was failing so there are uncommitted changes. 
Unfortunately it is hard to run a subset of tests in a lot the test 
scripts as there are implicit dependencies between the individual tests 
them.

>> I thinking it would be worth considering if
>> some of them should instead be changed to pass --ignore-submodules=none
>> rather than changing the expected result.
> 
> Ya, that's a good suggestion. Would look at those tests again and see
> if I can pass the --ignore-submodules=none option.

For the diff tests I think we want to test the new default and check 
that --ignore-submodules=none works. I think for the other tests we 
probably want to just add --ignore-submodules=none

I'm afraid I'm still no closer to figuring out why that test in t3600 fails

Phillip

> Thanks
> 
