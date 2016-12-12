Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7FD3203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 23:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932581AbcLLX6w (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 18:58:52 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33607 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932221AbcLLX6u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 18:58:50 -0500
Received: by mail-qt0-f172.google.com with SMTP id p16so92206562qta.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 15:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OoQQ1pD20pGsmCgQOcmHvlMy3Vf12BxNW2s/JxFPSkw=;
        b=I00TMAutPpVKdPTndhjesz8N5V6Se+gMKVozxwkVrdMTVZoBkUg88ZLMVz/T2R/XeN
         8vtwt6Lk5egeskCz/z8PCCDniS4Gh4W9y2qtYjrWxYYk49bLEttaqVLo++zlIzOzYOPN
         gZ7Ov2GMpMm0hdBcrSJf6AV//mJEnr6KAgpgsXA4J2NrlqpzB5t7dAacCbsZ96lHAdon
         UVk8fhrAEX3aN+7Icthr+lUnj2H1n+5kMpuwPjqhoypsa8psUh8iF0K25vtuvsF1yl5N
         V5ao89c93QBLL1hoG+t64gFv6KPiLNd+z2PYJtdKuyF7UBgm05pb+B+lNytIwTb2nOIM
         ytmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OoQQ1pD20pGsmCgQOcmHvlMy3Vf12BxNW2s/JxFPSkw=;
        b=GlNWghdamnRC0gRkgocwA1CHldUw677RrqSeJWJ0m56s0r703og9aT7QdOi0bVRCUv
         aeygxriBeZwn+nQW/r+GF+JIaIFq1P6m6Z1DXvaHJg0MT6C15r0UOzn3fRG2TlMKxd7S
         p3X6QTiHuu0GXXw2AqeS8M5sJYNMPCCH4XXwJotFv/CwRROfOWfMLwDJh3DYHzUId8m+
         0HvxsP5SCOnG1UXl94Y89q3T12AzDD7qHdHuPee3Yli+tGpBiPS13YqZWyS9fjmG4r3u
         mRPVGeMR1NGJXu4VlAh0Du4lAEq5f2KzSI3W0Qe50+wz6ANpeESethFFkNuBs6qUODPS
         ebWQ==
X-Gm-Message-State: AKaTC023+RJRsApg3VgplxwTIgZ4q9E5KSucextAoSDFEBitU2fnw8OyDYe/Su6wukvlRTeLPVGgIOWUND31muU5
X-Received: by 10.200.49.235 with SMTP id i40mr92343775qte.170.1481587129487;
 Mon, 12 Dec 2016 15:58:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 12 Dec 2016 15:58:49 -0800 (PST)
In-Reply-To: <xmqqfuls7lri.fsf@gitster.mtv.corp.google.com>
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
 <1481566615-75299-1-git-send-email-bmwill@google.com> <1481566615-75299-5-git-send-email-bmwill@google.com>
 <xmqqzik07pin.fsf@gitster.mtv.corp.google.com> <xmqqfuls7lri.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Dec 2016 15:58:49 -0800
Message-ID: <CAGZ79kbYAyGwTb7AkymoaMo+TPGVRiv8kn00fXGS=S_ZVFG0Jw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] real_path: have callers use real_pathdup and strbuf_realpath
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 3:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Brandon Williams <bmwill@google.com> writes:
>>
>>> Migrate callers of real_path() who duplicate the retern value to use
>>> real_pathdup or strbuf_realpath.
>>
>> Looks good.
>
> This has small non-textual conflicts with Stefan's embed^Wabsorption
> topic; please holler if you spot my mismerge.  Thanks.
>

5f6a003727 (Merge branch 'bw/realpath-wo-chdir' into jch)
looks good to me.
