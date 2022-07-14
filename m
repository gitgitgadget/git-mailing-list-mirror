Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5A2C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 00:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiGNAD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 20:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGNAD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 20:03:57 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D682B1CD
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 17:03:56 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g6so274756qtu.2
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 17:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=521BAo8XBHZBecGHOxLyGVBA5UONU07KXVBWw4ySDog=;
        b=VFO41DwvpZu118ETb9UjEHMlTiTKqFxavf5K7GYDghCf/DX59pmHUugT67MSVx5vru
         rsFX5BYvvyUG+rUqZXUmO/czUSRkldy9rzX5hdZ78czUMXTaDNLHaC1BVgP76NJif0gV
         0eiJHjKanV9zb1U2kaM6Kw5Bu9audlqwcDBQHQXuW3aiNYvriZn+1pYnaK+jCw+OQ4k5
         lGNZ7mksoRxukEOmNHN6LGzVNSTm8Q86I6jtdNpclAWTON6c/ltdnSLgMj3PCAQ4IqXg
         eeggHT4zpDZfORLQHrfPs9gE8tmlNrZQh+wwowS8c2Ze0YXBaoSBqejJIE1aV++IF7cU
         KFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=521BAo8XBHZBecGHOxLyGVBA5UONU07KXVBWw4ySDog=;
        b=tvYWBeJ08iYPC50FtYRmuPihKMTtpNwrohS9mxQF8hCBfDALBoebS3fuS+UGswXFqX
         vkJ+QCs8f1Irkwc9fGyt5vHpmjYn4lC3u35KxPKkygHdQ7hjnWlZNqQxL/BUmGePim+f
         xBjI4pp+V0KfWGVb2/s6zUXDepbopIGYoBF3wQtiWEUt4Cypk+Gml6hZij8yGiSPSLXh
         YUKk/W1F5QiK9VfqMNV81orPdJ3DsX7JflU/0HU5oPbvdr9AjJ7qQv00i7a3T5O7/Krr
         pRTHbtbYc5RgS0v+Y62STugdeL/MAUC+vETUwhccPcYCGvfDzj9sDFj4f9BnaePVomMT
         vDQQ==
X-Gm-Message-State: AJIora+vXs5EKGV2IH+GoBQtH+smWOeaMsxvOngy8EzsjhEPJX3AoaPd
        fGVXeWRQoupo93kMENPJEGa1ZzEj16cYNr1e
X-Google-Smtp-Source: AGRyM1s8qaKIqzx0EIcVIwGJSHbHJr5VyhpUcBwCtV0WR750OuPldGlk3LMaxFeF3Z1Gw0yju2YC4A==
X-Received: by 2002:a05:622a:110e:b0:31e:b568:b5a5 with SMTP id e14-20020a05622a110e00b0031eb568b5a5mr5469459qty.54.1657757035240;
        Wed, 13 Jul 2022 17:03:55 -0700 (PDT)
Received: from ?IPV6:2605:2a00:8000:dead:55a4:52ad:2bdc:5b8c? ([2605:2a00:8000:dead:55a4:52ad:2bdc:5b8c])
        by smtp.gmail.com with ESMTPSA id r14-20020ac867ce000000b0031eb47652dcsm154059qtp.59.2022.07.13.17.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 17:03:55 -0700 (PDT)
Message-ID: <c12c14a9-9948-a47c-35a0-869f95d95bb9@gmail.com>
Date:   Wed, 13 Jul 2022 20:03:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Why is reflog so obscure?
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Gerriko io <gerriko.iot@gmail.com>,
        git@vger.kernel.org
References: <CALF=2ANoq1eL-RqK_dLaVThoxbvfhzgPJXFHyD1kX8CFCPx3XA@mail.gmail.com>
 <f0bb8ee8-9b38-45a7-a54b-24cf245bb3c8@gmail.com>
 <Ys0e9MxIWQj/pVXx@coredump.intra.peff.net>
 <a8d2a61d-b86f-9b89-6391-36c58c390a12@gmail.com> <xmqqo7xuif46.fsf@gitster.g>
 <87ilo2we9o.fsf@osv.gnss.ru> <xmqq4jzmib3n.fsf@gitster.g>
From:   Thomas Guyot <tguyot@gmail.com>
In-Reply-To: <xmqq4jzmib3n.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-07-12 11:50, Junio C Hamano wrote:
> Sergey Organov <sorganov@gmail.com> writes:
>
>> Very handy, thanks! Would be nice to have this in EXAMPLES section of
>> corresponding manual page.
>>
>> Honestly, I tried (admittedly not very hard) to figure how to get dates
>> from "git reflog" a few times, but every time I gave up, so this (along
>> with the --dates option turning dates output on) is not very
>> discoverable.
> Heh, I wouldn't have bothered writing the message you are responding
> to if it were documented already ;-)
>
> Patches welcome.

Indeed these are great! I was thinking the same thing, I can work on a 
patch shortly.

Regards,

--
Thomas

