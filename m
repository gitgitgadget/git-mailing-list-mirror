Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D52EC1FAE2
	for <e@80x24.org>; Fri, 23 Mar 2018 14:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeCWOIR (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 10:08:17 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:40447 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752361AbeCWOIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 10:08:16 -0400
Received: by mail-it0-f52.google.com with SMTP id y20-v6so2738398itc.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mqSk3bEGg9WsTEeB5GWfH++fVs6xoHJzeq86e+lj/78=;
        b=FP3tMJmZ34SmChhMkt7FY9R/eBqEmCYa5TYQg4LpSI+bND7r6Krg4QkzlgOhKIcYpC
         LhPW84ZoOYcsyVJ9YUUoKZzQoiRlNwckivjS/45VpI6M54dZsqqNYM79iHNO2+lyjSvQ
         4ZE3+3ilR2/wy8vINgluv2zqiVMRpsbWxJcwKciCs5dFMAhRjCNj6a1LY/eWN2mNmyWm
         xNyIdSMqmcL0cat9tAVuHwI0+q0Bm9YeRHgkwmYn7Oh3+IOpYUjf7Mq0XQKPV6WMVURv
         XKVtO5rpi0T0YqjvCnyqDuic/nFSn2ZCKf975tz3XMxG3eKQtJPkf8Hg+cfH9MgZZ3C8
         cSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mqSk3bEGg9WsTEeB5GWfH++fVs6xoHJzeq86e+lj/78=;
        b=k9MYil89NvkDFn2NOpWDVHsvjydLDHLSrsDqinWjuiJi/BMtBd/Td/CkE3TWFoSi39
         QP1oMEA9udhf21cW4ysr0Kc8aNFLLzCphnF8bDUdzdkAABzpoxXCSo3tpDDtUTYZ4cIp
         z9OhD8nSjFMg80w8jXCdvmNHchujEDfwc3nL6CN5GBQjDtwKGXGuvh6BWZ6075F+DdaH
         5myzOvpOJ1eBiAdvMDVPBr9TVU5m6xOo0Apw3U2HIoIJ08ZXSO6dLCPDhKmnVbfhhCG/
         tzfO9n8QPsTTSkrpEtNbg6Tt7+F096LJyxAsWxL53PtJd7fVAQOMtfBnznf5sTibiRBW
         mtuw==
X-Gm-Message-State: AElRT7E5pJ68Pzl3wVvxtVL2dUSSeKP856CsvhzCtjqXl7eUxumtcfUy
        Qonj0i+uWZFZcE3oP+DhkhEwMiWxSEmXpqhDby1/Ww==
X-Google-Smtp-Source: AG47ELvzQow7A/YV6i18y3dLJtEYoHhiUij60dIXfxGgFa4gprHa17qJWyE+OmQTVreCZn8ZcZXgO83FQdeE/tpissQ=
X-Received: by 2002:a24:c457:: with SMTP id v84-v6mr12368136itf.81.1521814095724;
 Fri, 23 Mar 2018 07:08:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Fri, 23 Mar 2018 07:08:15 -0700 (PDT)
In-Reply-To: <20180323140007.12096-1-chriscool@tuxfamily.org>
References: <20180323140007.12096-1-chriscool@tuxfamily.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 23 Mar 2018 15:08:15 +0100
Message-ID: <CAP8UFD2pUwV-GM=qvbJXCW4kcXFoYdjMJU69k+i13q4_x-9bfw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] perf/aggregate: sort result by regression
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 3:00 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> This small patch series makes it easy to spot big performance
> regressions, so that they can later be investigated.

Sorry I just realized there are indent problems in the patches.
