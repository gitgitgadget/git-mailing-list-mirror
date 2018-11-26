Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C8D61F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 17:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeK0EM7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 23:12:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38180 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeK0EM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 23:12:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id k198so19424034wmd.3
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 09:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4SvMbqJfND3DC82BLKaHvlNvMB0GJ3+r1ONmcGJph20=;
        b=kGgGsqeK+L6l5GvZNKkNhcMTRpCFT2ZrxP6vABzj4PmPfGrZS+UzYoMMrr8fVYNes+
         BEfP2SnFmRwyjR2JrRyp5b0K6caj/5EVbF0e8IVJwbG4pjpXmk0vuo3TSld+zSrAtDRb
         3r4CKds67JIB5pHr2ct1mqaQ22RF/hstW/7P3fsPYjsB8Z20p17jZJci3Jt4FzD3TZwY
         ObY+rbZZDxh2+VUhx4zZz7gQwBzWYZf3F9yMAFpvuSlHRfgexgQhyRXh0+lHRRPFWrgU
         /6t8TOkWfl5uNuBZuy+1Pqp3JRSzjnMpNjF1W+vafoaFyvrpge3BQUVJpmqfKeAvtSRu
         nByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4SvMbqJfND3DC82BLKaHvlNvMB0GJ3+r1ONmcGJph20=;
        b=ph/DKWdrmGtEvu07HWByMmp/yMHwLtInBMNxglLU/QatvRYC0pgYNTpx1i4r3s+wKG
         +99eCQEBxLDMpNZf0cRU7OFB5KPQLbu7orPj4Qj5IOW2nEBSsp8EmHAKzbHu202s75Ay
         CQwrAEsZhhPmmkN+9IBPRiM/9LKKkDu7dESCQSERljTPYnUmbeq85kq+mbgiQbj3fkob
         sIvcHWqOMgEBy1jm8KvB21TMHSchikXfu6+j8Bt1pUtctcBeaOQGK8rceUDDaXYKOfR5
         +ZQs3068HycDy1B6kwQrlRuT3nUU/obFV69A6xWIr+mZ37QFpsruXAF9/RDPPY32n3MR
         nFbg==
X-Gm-Message-State: AGRZ1gIep1sGr0fzmCBSSbv9DPZoAam6LRGJHjP0p4+omu0ZQTXnSjfZ
        rCuSo+vM8JeUU/RSks7aHvRhMCFq
X-Google-Smtp-Source: AFSGD/UhChmleHbGM2l1Bacl5a1eamtxvTJlZjaFpYhRyGLoVIYqdyn7reqI+l3yHGEoiPZj0Qk3cw==
X-Received: by 2002:a1c:b70b:: with SMTP id h11mr25501526wmf.72.1543252692643;
        Mon, 26 Nov 2018 09:18:12 -0800 (PST)
Received: from [192.168.1.3] ([31.223.156.115])
        by smtp.gmail.com with ESMTPSA id 198sm1967777wmj.38.2018.11.26.09.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 09:18:12 -0800 (PST)
Subject: Re: [PATCH v2 0/4] Port git-add--interactive.perl:status_cmd to C
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        jrnieder@gmail.com
References: <1494907234-28903-1-git-send-email-bnmvco@gmail.com>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <f29f31a2-4e89-7ae8-26ee-12aba67cee10@gmail.com>
Date:   Mon, 26 Nov 2018 18:18:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1494907234-28903-1-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

On 16-May-17 6:00 AM, Daniel Ferreira wrote:
> This is the second version of a patch series to start porting
> git-add--interactive from Perl to C.
>
> Series:
> v1: https://public-inbox.org/git/1494009820-2090-1-git-send-email-bnmvco@gmail.com/
>
> Travis CI build: https://travis-ci.org/theiostream/git/builds/232669894
>
> I have applied most of the changes suggested by Johannes and Ã†var (thank
> you!). The one exception was Johannes' request to make this a WIP patch
> series with a sort-of "design" of what's next to come. I did not do
> this because I still have no clue...! I'll begin experimenting on
> update_cmd() to see if I gain some insight on this issue that I could
> bring to this series. I do think this would be a good idea, though! :)


I am Slavica Đukic, Outreachy intern for Git (Dec-March 2018/19 round).

Project I'll be working on is "Turn git add -i to built-in".

Would you mind if I use your work so far as head start?


>
> -- Daniel.
>
> Daniel Ferreira (4):
>    diff: export diffstat interface
>    add--helper: create builtin helper for interactive add
>    add--helper: implement interactive status command
>    add--interactive: use add-interactive--helper for status_cmd
>
>   .gitignore                |   1 +
>   Makefile                  |   1 +
>   builtin.h                 |   1 +
>   builtin/add--helper.c     | 285 ++++++++++++++++++++++++++++++++++++++++++++++
>   diff.c                    |  17 +--
>   diff.h                    |  19 +++-
>   git-add--interactive.perl |   4 +-
>   git.c                     |   1 +
>   8 files changed, 309 insertions(+), 20 deletions(-)
>   create mode 100644 builtin/add--helper.c
>
> --
> 2.7.4 (Apple Git-66)
>
>
>
Thank you,
Slavica
