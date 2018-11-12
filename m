Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C06A1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 15:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeKMB0f (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 20:26:35 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42553 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeKMB0f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 20:26:35 -0500
Received: by mail-qk1-f196.google.com with SMTP id m5so13944273qka.9
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 07:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X/5lgBWdPM6LOeusuNRCM0nAU1Jy3dqnRNdhMUVzK3Q=;
        b=h7ea7v43TdbSaQqe7GLFs64BhpzWGTCINxyHPXxVssnySypmJkMhFnxlCdnrW0WNpO
         WfR2mN58HJdEkJ+JiXjD4YArkhsCGWCGFzqG9ZnbsMzO5BnvoCHIC8/nhbKhKFr9Ofvs
         iokx3X40R/E9YRExBJHiOzDKJ+RUbRVNm/5cAFO8iBua93sggFaZ3u35wpzMEl0eASzL
         uOKzA2aPTInmqvqs3swS2UbRt81RhAnXt8m91segkqAXYQQsk2N2smIOJYphENONdSsq
         4HiA6jIkBfjc2bS0HsaS5R4jiKOCmytXBkd5hD/nUvurlcYNuvpqA/qmTHVHkfWtm8iL
         SQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X/5lgBWdPM6LOeusuNRCM0nAU1Jy3dqnRNdhMUVzK3Q=;
        b=P0NFtm2XW4ZlzkLSz2ylr6mw8Za1bTGNBaMFVGZCGXY4Wwo+lXC72ZihUMVdwv26gy
         xwSl+C16+9Yi+OWZYIiINThSt+ubd/XOQLtXpNM0XbPGmoPjw/gb0aecDEOQ7wxDOg6K
         S/IOarzRpYNtGhlVLcxU374xMnXoI8HLZuMinTCKArTYgw3Bxqqd0BjQWUb5cMpfRlCP
         cn6HBdeI0k7OyPW8azXtYwVDIWN6F/4Pfb870/w2EIg/dQ5L9fKJdNNc4xNU/PV3rYQp
         mmAyXQwJHCaoK45Q8PHDZKlLmFEvEVOfyaw9DJXYjICjFyAQxwVoluoZkzSz0q0KiFr+
         3iXw==
X-Gm-Message-State: AGRZ1gLVaBO2ISNwCalpJv+G2cxTcwE9Z8qK93mqWxS5bZI/cYM7iaXc
        Sp1OkgerRsvrhZ5jswEN+Uk=
X-Google-Smtp-Source: AJdET5ctDkdefVfdcl6kNE6QX8ho7zq5qks9zqz/1QJDk0FdHDkWyGU8KyZQcJD0cR777V28GOQnFg==
X-Received: by 2002:aed:3fb1:: with SMTP id s46mr1340268qth.208.1542036770717;
        Mon, 12 Nov 2018 07:32:50 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:705f:75d7:178c:fe1c? ([2001:4898:8010:0:5995:75d7:178c:fe1c])
        by smtp.gmail.com with ESMTPSA id i33sm13939102qti.64.2018.11.12.07.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:32:50 -0800 (PST)
Subject: Re: [PATCH 4/9] sha1_file_name(): overwrite buffer instead of
 appending
To:     Jeff King <peff@peff.net>, Geert Jansen <gerardu@amazon.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112144856.GD7400@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f3547fa6-ba9e-0780-a1da-cc76aa0d4704@gmail.com>
Date:   Mon, 12 Nov 2018 10:32:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181112144856.GD7400@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/12/2018 9:48 AM, Jeff King wrote:
> Since we're changing the semantics, let's take the opportunity to give
> it a more hash-neutral name (which will also catch any callers from
> topics in flight).

THANK YOU! This method name confused me so much when I was first looking 
at the code, but the new name is so much better.

-Stolee
