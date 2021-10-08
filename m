Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396A5C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125E360F11
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhJHWHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 18:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243533AbhJHWHj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 18:07:39 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C10C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 15:05:43 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id q205so12267468iod.8
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 15:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2f5gMxbaIUMper557oX8QPzAS2Xcz5J7QvQClMrlZbk=;
        b=P4zmgzTa1TSYOM6TlU5ApPM8P51KcG6B+cyfzCWY3u7YMMaGhkK43v7m8a4WdYpi3z
         S8QpdsXq4tuU3P4xgVukdfj4eZBtw2ZeNKHrIAQcdAxwzcdxpYmJeV90UeW2Bj7nP76w
         verUsEhnmFK61zTsN0b6ISr5CrQdxtexf4o/eoX9iC6FYKOPzUvQ6ofF4LsmaQknWqB+
         LoQOiiVBDclVdVLCOy1QLO41Q7G6WL+rmk6lcBBtzN8bSlpOFAM2mpxzFItdKx6Qnmqw
         YCvecpvNBrhTLqc4yb1CZo/zh4Vi0ZW1Hw9tg9/rG0XpntwHs04NIWL4O1jhs4tKsJiC
         kulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2f5gMxbaIUMper557oX8QPzAS2Xcz5J7QvQClMrlZbk=;
        b=paX7ajpy+fgIE5Yb8ZJij10Yj45GC2BDLPiYaVYgIblNUasdW6zPUsdEysA5q2IWR+
         h8M2T3cp4+LoNGk/wX7ZpayW+aVubVVAG/GAr+TXSy3U8H7VWHh0fiWQ9JCJmGB4qk4J
         NauDp4WjKjl+xsMWgw6FaClS2pJdTHfmF1oXIPNZ5FD3zP1gkAvJR6574JMJkDlPoKhc
         DdvpMbRvECjfYicd+us6hHPHPRxfy9WWBXoWMnV9tVsC5k+WiLBazjK4QjxpMuQ15Ccs
         RwiePwt7EXezzyfsnT6q5HxLjuOnOlIv977D5vvIcZq3ZtOcAilEh3qjVOWwkFZ4hz+3
         sB+Q==
X-Gm-Message-State: AOAM531o0DzkQ3h8DvnXRbeGMbkAo7ySmuiNQUKhM4T9Vcl54CJa7ovy
        WFkbyazzvfE6uco/wAg9hB6jensn35q6u/EkmH/CyDs4ue4=
X-Google-Smtp-Source: ABdhPJyb47g5QuV5p53TR1av4tz8BK0t+0+zK41HuDNyvkKfJOpNOactBxumK7sIGzVOxeTHB/IWRPUgxEoQSqpCPts=
X-Received: by 2002:a05:6602:2d86:: with SMTP id k6mr5516031iow.130.1633730742400;
 Fri, 08 Oct 2021 15:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1096.git.git.1633642772432.gitgitgadget@gmail.com> <xmqqbl3zjl5y.fsf@gitster.g>
In-Reply-To: <xmqqbl3zjl5y.fsf@gitster.g>
From:   Robert Estelle <robertestelle@gmail.com>
Date:   Fri, 8 Oct 2021 15:05:15 -0700
Message-ID: <CAMmwyQpP0m6dTdC-L9abZqk9nJkcYy=j4_s0+EdGDr__pykeXQ@mail.gmail.com>
Subject: Re: [PATCH] completion: fix incorrect bash/zsh string equality check
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Estelle via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 8, 2021 at 1:50 PM Junio C Hamano <gitster@pobox.com> wrote:
> Would it be equally a valid fix to use "=" instead of "==", or would
> that change the meaning? This is a bash-only piece of code, so use
> of [[ ... ]] is not technically incorrect, but if the basic [] works
> well enough with "=", we should prefer that.

Yes, `[` is preferable for portability and they'd behave the same in
this case. I consciously chose to use `[[` because that's what all the
other comparisons in that script use. (I think I noted that in the
commit message, maybe). I think there's value in consistency, and not
enough value of `[` over `[[` to justify changing all the other lines.
