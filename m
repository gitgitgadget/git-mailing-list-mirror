Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C932EECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 17:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiHaRWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiHaRWN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 13:22:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657C6543D7
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 10:22:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c59so13065236edf.10
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=QxkcDivFIBDKCkYmtIFQ8CVHq0G0p6tEKOhVIMK9jjQ=;
        b=BC7hedfIlDo+uZUx2kZ9vIKZTxVunkR0F2QeFjZZj9yU94UCPlnoMsYXabwag9qBu1
         1+N5l+eXZfCSEm7cboXTf+ZTv1UUeigZHWmiaei8eCKiQA+a9R/gG0yEuQiaO7teEwDL
         McsX+PCLr4zPJJGZ9RHJVGgFDJZkQsCUqaXP2MOymxMNCWjV1VfZk2necere8YL3ce/a
         Uw+6lu0xetjEZW8YthZNU7dMKQJfQN4dZDxPdX293ZeScA0haziuo2fe6qL/FlVU9G1/
         qV6q8pLH0fanQ7iicirTWRJsZi9wVdytKHqJL0t0pzgXARPHg0yDehtoxiPBK4gj5M6s
         N3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QxkcDivFIBDKCkYmtIFQ8CVHq0G0p6tEKOhVIMK9jjQ=;
        b=ZjJcBy3NQvTt29hLyj/0mAGSG5etFHK4xLW6wZp98Sgk0e9LqYvGR7ME8jQy87N+i4
         u4bZjsBXkvD8LvHS0CjQVNY0qAJjMxzMGU2l9ePvu1+dw45Qy2PsvRGjjepfAMMN2sjp
         e4DgQA+9q4ODNSCMgKh8XT0qKPNPdcgjautTRFXjPXugv4xA9OiroO0Us8k4etLYj1Hk
         BBLJV0TZHG7n7hDVc6hvn/ZAaJeQYphuVukdznt+ut6a6FfpNGitXdpgZwZU8vWSbN7P
         GkNSlu3tSSNvE+vMvoKd5IjTUGf9KlfUsA9Yhve/WbvqQLBlKYL5mqHX046VwWSSIsXX
         9Jbg==
X-Gm-Message-State: ACgBeo0JibfseSpfjLax/CCH2TyFnZnaO//d4hQMf2HY5nqN0X0DCGd3
        3wBiKcExGZyy6PZ7fDEk3xs=
X-Google-Smtp-Source: AA6agR77EblTu2t9rHWqKXVX/gfabXRQOY2Jqfb7yjlnTET79ipZ6xFF3e5fiqw/E6c+ZV1nHpVRVg==
X-Received: by 2002:a05:6402:176c:b0:448:3920:14d3 with SMTP id da12-20020a056402176c00b00448392014d3mr16489284edb.299.1661966530738;
        Wed, 31 Aug 2022 10:22:10 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709063d2100b0072f1d8e7301sm7426422ejf.66.2022.08.31.10.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:22:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTRPl-000NG3-1T;
        Wed, 31 Aug 2022 19:22:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: jk/unused-annotation + ab/unused-annotation
Date:   Wed, 31 Aug 2022 19:21:18 +0200
References: <xmqqilm9k0bc.fsf@gitster.g>
 <220831.86fshcal32.gmgdl@evledraar.gmail.com>
 <Yw99xMnkiv/Qjnst@coredump.intra.peff.net> <xmqqr10wgz64.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqr10wgz64.fsf@gitster.g>
Message-ID: <220831.86tu5s8h1a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 31 2022, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> Yeah, I think we should use the deprecated attribute. Since the original
>> has been reverted, I think the next step would be for me to fix up the
>> patches to use that approach from the start, and re-submit.
>>
>> I was dragging my feet a little hoping that we might get some coccinelle
>> parsing miracle in the interim.
>
> Yup, that was why I ignored the "deprecated" one when I dealt with
> the replacement series yesterday.

Ah, even if that's the case we'd need to start requiring bleeding-edge
spatch, which doesn't seem practical to me, and would reduce the
audience for our rules.

Or we'd need to split off the "bleeding edge" rules, or something...

