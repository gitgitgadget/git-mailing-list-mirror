Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97551F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbeBVAYD (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:24:03 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40077 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeBVAYC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:24:02 -0500
Received: by mail-wr0-f195.google.com with SMTP id o76so8837472wrb.7
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=DWYSWOV3f31JToifM0hfHZoS194RwsFsoMZcAfXmEhk=;
        b=JXOMJANVrnflt1NDmL9hRvSEG8EjlToV/ryw8MgnfiFHrHgfUVU7xiulkGW2gLyvv4
         1CxKt4CoMQ6SF6SIegYpqZ8coi3j2WbdFXI+eTsSAQAupQoAbbMR395PHX9w5PRKfNfe
         wjLlKh0PHZjsndm75AwJ0uKKxrXkHNL+Hmxe/t+iWV/flk93mbvK37THmh1GHvYoxrFL
         RSvsE6o/Q34SfRi44G6vGpahpgDrgX5XKN8ZDYVfrT9lvT/UO2/Slt+o+OqwgqS0q9Ml
         oo8Q8w+VZTKrIbEaqCUYa1JYbAIvhhJ9E8I2cxrRYbCXmuexQObLECMTWFO2U8qs2NZm
         h9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=DWYSWOV3f31JToifM0hfHZoS194RwsFsoMZcAfXmEhk=;
        b=b78Vh1zW52zIwfAH+De74S8Od2F31mSNZ4dn/8A0aocCEVbZ/Btts1yaYtX3eNsoTC
         mJB27VfpGIF+w3yIuRnDWPmCCmBspP7qCTonArAOnbTs9TJ2khxGyyunUXjbS0DzujdP
         c14AHGn6Q2PX+euozdUc3Up37Qh6dgQ4SUDdgBNdxaURCDBESRGXvMIriQhsjCUt8hcm
         deubL9b3GNk0EJ0R/3Vdv1cKVo2Wo4eZIa2kTUvz6Wll+0pLG2nYJY9mYqQstrcB+6WK
         Fx+4tiunnPTjVOfFSj4WotOOF9jGId+fxDYmQ0zgAEK3c9uzH5D0S/ubVyN497WRlG4k
         vCkA==
X-Gm-Message-State: APf1xPCBhI5LEN4IRVIdGYAd3Er33RLn0vyDObOdDkUNRTS5fM6MbH7X
        tPnOGBMgDi87c8kK9r1DmsQ=
X-Google-Smtp-Source: AH8x2259D0ZhR8dxCOIzXr7K2qgQ4ycA9nH/bR1/rz8NpFMmRIvfD7f2miE7JvJ/Mp/8uXPo0tNS3w==
X-Received: by 10.223.179.194 with SMTP id x2mr4773895wrd.94.1519259040676;
        Wed, 21 Feb 2018 16:24:00 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f142sm11200610wme.15.2018.02.21.16.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:23:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v5 00/17] document & test fetch pruning & add fetch.pruneTags
References: <20180121000304.32323-1-avarab@gmail.com>
        <20180209203216.11560-1-avarab@gmail.com>
Date:   Wed, 21 Feb 2018 16:23:59 -0800
In-Reply-To: <20180209203216.11560-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 9 Feb 2018 20:31:59 +0000")
Message-ID: <xmqq606pyiqo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Here's a v5 (correct subject line this time!). Many thanks to Eric for
> a thorough review.

We haven't seen any comments on this round.  Is everybody happy?

I do not have a strong opinion on the new feature, either for or
against.  I didn't find anything majorly questionable in the
execution, though, so...
