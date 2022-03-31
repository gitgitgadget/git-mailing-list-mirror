Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BF8C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 05:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiCaFRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 01:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiCaFRT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 01:17:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF33E580EE
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 22:15:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c62so26826615edf.5
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 22:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgtmjTSirKNSxCYotiLW4CqtHQT8pbKa0r9nyoEgzQs=;
        b=ATVCMOlC4Q1qaFZGVStJs6PEj6sMTxfWmxeNWYN8esTVXSUw69cCcdC7fTbqQ01VgX
         oigv8Hidw/O34wvjrOYNrROVMycwfvo7mYWlXcVPxGQjN2yvRQ5bZ8jAdqTi/lnQok5w
         6jFAvatCpEcFi7BL+X0QYyFpBSZCh9pIitZshIPb+kahhsJmNDKTMrYJ7mLugg32W5AH
         BXGpUSzIs7+gNJjOB4q+PydRIVN9JJwhwDlp/zWv/OE+S/+u3rKTxTeSh1CPOA82umGt
         l7aFHv0Gd+OKSvr5+HpeeJrZwydWyGB2eIIIJW8KjyFv5XZBJaPxTDtOVAd1bY/ato0f
         AT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgtmjTSirKNSxCYotiLW4CqtHQT8pbKa0r9nyoEgzQs=;
        b=Hr32dCuHAoOqLRtqW+xSGJDD2bfG9Fb20ZoOfD17l+wsBI4b9BGrJfUCA4W8XXU/YW
         3LgtefJoLqmNHfbcHgp4fcwR2AXVzX5l8IZR94UMJfvys+4yiCklIweobQJrer1p1T2N
         cl06zWMrq9Zy5b3FhhoJsHMwGDFrd6KNfvh9P51Jbcy51MHkhOqIv6FVN8jAwFZzdMq5
         AqKv8Wqvlc4qX14ebUalLJguFE1JPj5IKYdI8lRguHDywHWYtvvCwcQhAP3uE4q0iyXu
         QCEeJR81BSKuSmPgxEA9wl/669c1ju/GVtBdIsv1coSW2LB2PRgbXIPxlqbtq9i5psJ4
         TUFA==
X-Gm-Message-State: AOAM533Aury7eQP/rZ+U9Wl7lGlqcUXOeqNjZHifB3xqV+UGoaO85R/l
        zsTo3M/+GjXaky/w/0V5+B9CwNaur5I4kAivO6ujdw==
X-Google-Smtp-Source: ABdhPJzl7YVxJ4a3tNua/sYVa5UeWfx73bnIuQzDQAU+pXXC/R25CWvx7+U9iQ5kY8roKeWO7ckAef0S7wGhRxKKCGI=
X-Received: by 2002:aa7:cd81:0:b0:410:d64e:aa31 with SMTP id
 x1-20020aa7cd81000000b00410d64eaa31mr15033283edv.167.1648703730295; Wed, 30
 Mar 2022 22:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.985.v4.git.1645974782256.gitgitgadget@gmail.com>
 <pull.985.v5.git.1648553134.gitgitgadget@gmail.com> <98a4d8f35c5abfcda5590f7e511f7b576000fd5a.1648553134.git.gitgitgadget@gmail.com>
 <xmqq5ynwwvli.fsf@gitster.g> <CAPMMpoigpEi9mTET1r9sbSdw92kUXw9cRQPdUv-O179j3+_wAQ@mail.gmail.com>
 <xmqqwngb9yzd.fsf@gitster.g>
In-Reply-To: <xmqqwngb9yzd.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 31 Mar 2022 07:15:14 +0200
Message-ID: <CAPMMpoitmyhZZSzELFVSFd2GUKQweB7-c1JQQtaem1QvP48mZA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] untracked-cache: test untracked-cache-bypassing
 behavior with -uall
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 30, 2022 at 6:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > Sorry, I'm not completely sure whether my comment was misleading, or
> > whether I'm misunderstanding your feedback.
> >
> > The test added here does not test "desirable" behavior from an
> > end-user functional perspective, but it does test behavior that is
> > working "as-designed" as of many years ago.
>
> Is it "as-designed", or just "left buggy"?
>
> I somehow had an impression that you meant the latter, and it would
> be our aspirational goal to eventually fix it.  And for such case,
> it would be better to write the test body to show what the command
> should do, which would make the test fail with today's Git, and mark
> it as test_expect_failure (which is not an ideal mechanism to prepare
> for a future fix, but that is what we have now and should use, until
> a better alternative being worked on is finished).
>
> But if it is "as-designed, some users may find it suboptimal or
> confusing or with any other negative adjectives, but it is too late
> to change now and more importantly it is unthinkable to change it
> because existing tools and users do depend on the current behaviour",
> then what you did is perfectly fine.
>

Heh, the answer is in-between: there certainly is an aspiration that
someone figure out how to have the single untracked cache structure
safely support both -uall and -unormal modes with the same data... but
it's not clear that this is possible, and it's certainly not planned.

I don't feel comfortable saying "we should fix this", and that's not
the intent of this test - its intent is to say "this is how it is
(currently) designed to work. If you accidentally change it, be sure
that you are changing the design, not just accidentally changing
behavior and potentially/probably introducing a bug".

I'll try with this updated comment, using the term "current design" to
make the distinction:

# Bypassing the untracked cache here is not desirable from an
# end-user perspective, but is expected in the current design.
# The untracked cache data stored for a -unormal run cannot be
# correctly used in a -uall run - it would yield incorrect output.
