Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12591FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 22:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753754AbcHZWXU (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 18:23:20 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:35456 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbcHZWXU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 18:23:20 -0400
Received: by mail-it0-f53.google.com with SMTP id x131so15636100ite.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 15:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y7NWQ9HAIGi/SGcivOk+T1mpXgANe3e/ZFoHgNMxTT0=;
        b=fdBG4jc5j/zjIBxjGkdSlvbek+eV6Dq5bZT9JMnpUthH5M1JUWTWP5G1b/i8GLUJsY
         Y1a7kAF2/YULXG9XHGFpWyuOEhVNjj67q9tIOqpG+FUKr5orru0YjKopDq5rCiewiKJt
         w1mfcldFrb4q7z6P39h41JZU9I5KSYp7Nk4bVtMiHeti6eeUDkYIMPODTmB+LYhoDBt0
         ZVVkPjJ3vDw3kuXOCp0ORSQoSRAe1L7j7dpR84+bLjgVmRh5pcuo0v70g5mG6vagisyV
         K/sr17FCtb4fS2UDcZmoLaa+baFw24HedQFRfwZEuIJ4kQ2DAecmaByfm76crWua+qXz
         Qbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y7NWQ9HAIGi/SGcivOk+T1mpXgANe3e/ZFoHgNMxTT0=;
        b=cA1jQKWAM+iGS3LvFMhYXROPYR1b/z8+ZfXQhoaITvUPeNCeg0I4AyL7zCpfl1Sr2X
         i0JsiyiKKT5pk1uVN8nZZ1za73kIgPU7fmtJU4lKsARdEGhHKaKuaLqg2tNldjlh+pPN
         eKLCm/PQiWq+rYbdG6vFYFSD1UIaBA71nBRPbtDAy5lqPuYAtT+ifDNSB+i9eaEOkWHx
         8j3Xy0DzTe0flXYudxO05WiQ+bUTjB2eTSbv+Q+fz1bSrOQI+DAfuLEg7yKDcCS7nyuJ
         vPBT+ZS4tZ4QPgv2mP4D159qPgN4o6WRbUj90S9dZLWeyRLwsvO8rOHK3DXizM0xTtIG
         +XhQ==
X-Gm-Message-State: AE9vXwOTCSJUMdqskTZ9atFwMperoheniq8JVpuyMGbYzybd3cVSseWTxnE0IsTFue9geMOwLylcu4RspBiFyv3X
X-Received: by 10.36.228.138 with SMTP id o132mr1232951ith.49.1472250114547;
 Fri, 26 Aug 2016 15:21:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 26 Aug 2016 15:21:53 -0700 (PDT)
In-Reply-To: <CAGZ79kb1ur=s+FYcdCh+obKyfaozX=adAPESu9G9FQxVtLTDbg@mail.gmail.com>
References: <20160823214008.32331-1-sbeller@google.com> <20160824122828.0c2688e8@labs-064.localdomain>
 <CAGZ79kb1ur=s+FYcdCh+obKyfaozX=adAPESu9G9FQxVtLTDbg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Aug 2016 15:21:53 -0700
Message-ID: <CAGZ79kaT79WBfwbRw5bw9LOQgHThVOpn66siwr14kU7=ju2WZA@mail.gmail.com>
Subject: Re: [PATCH] transport: report missing submodule pushes consistently
 on stderr
To:     Leandro Lucarella <leandro.lucarella@sociomantic.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 9:35 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Aug 24, 2016 at 3:28 AM, Leandro Lucarella
> <leandro.lucarella@sociomantic.com> wrote:
>> On Tue, 23 Aug 2016 14:40:08 -0700
>> Stefan Beller <sbeller@google.com> wrote:
>>> The surrounding advice is printed to stderr, but the list of
>>> submodules is not. Make the report consistent by reporting everything
>>> to stderr.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---

So we seem to have dropped the ball on the followup; this patch nevertheless
is a good idea?
