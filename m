Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C0CA1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 22:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932636AbeCEWJz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 17:09:55 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55508 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932430AbeCEWJy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 17:09:54 -0500
Received: by mail-wm0-f68.google.com with SMTP id q83so19046590wme.5
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 14:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vwp48Ke9WjF/5QTocaBdqUtG3xL8vB8AIdg0pF93ApE=;
        b=owcqMmglp9wQAzjDCKWJlvy8jt7sJ19orRkeCinBZXrRU4c2Riol/yKRiLh7AJNSHL
         pznlBHYJ1pr3khEn0NODSYKHVBE2mz5qPQ/h7yVEQJogKU760se47rjHsFkpXgczsHva
         B6l5vhOkaPiD1Xnuse/uFNC45bnukjzjCRkX32M9JazwCwVFFPDTXO25DfxK0Mqg9cSF
         OlpTHPhIZGeCU6eCPIrSvY6lmzq2Um+3GOwgHfAEhHIexNBtnTeoWOpgbUQZWfBbGeLx
         VlfrxF4smCkLkZgtVsEF7pPjWwri+ZUiLOvOYvpxGaIV40bl8mCdMiwxORDi60/vKsOZ
         hSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vwp48Ke9WjF/5QTocaBdqUtG3xL8vB8AIdg0pF93ApE=;
        b=Ge60l9Ye5IRU4ZNG4bTAFSl8rlCSNYBUWw0Z+Hb4mroeD//0K4i6G5GgUpbQS3T4/I
         jrOuq2qHr8JksdbeGkHCqPpEFfq8CmOC7UmXuNnK7XGyt+sxFb8qEG4eMf4xpD9lOvtP
         wpW5XATzzBZ38mqghg7b9+D0kPzt/Clhg23byKX5Myq4BEPM91dI+0A+MKC5ijg5NAFV
         5luJKr2Hcriy1aifnFEtQYJJ0PppBptWxA7btLqfde37deD5HD/ZHBNNhhK1g11MsGiG
         16yt2MAIz1KC9A1XQXjDyu/3rSudt7/yxNI8zW2b45su+17oqEkYGTf+SdOxHanZXtY1
         RVxQ==
X-Gm-Message-State: AElRT7HFHu34b9P9I5U1deQH2ozTbGeMzwddd6X11Ma4x+mE+KPNPhI9
        aZp7HBlqhS+0Diw9h9cqgIE=
X-Google-Smtp-Source: AG47ELu/xqpbcdizN/PV7krv1uZPRnW6WWpWM6gdBDHWC5eVFvK8HVI6dtCWLbar+q69LoS8M7UC1Q==
X-Received: by 10.28.239.8 with SMTP id n8mr9943696wmh.120.1520287793210;
        Mon, 05 Mar 2018 14:09:53 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q9sm16241648wrf.11.2018.03.05.14.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 14:09:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sam Kuper <sam.kuper@uclmail.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] add--interactive: detect bogus diffFilter output
References: <20180303055715.GH27689@sigill.intra.peff.net>
        <20180303055849.GB15952@sigill.intra.peff.net>
        <878tb6nr6u.fsf@evledraar.gmail.com>
Date:   Mon, 05 Mar 2018 14:09:51 -0800
In-Reply-To: <878tb6nr6u.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 05 Mar 2018 22:33:13 +0100")
Message-ID: <xmqqbmg2898w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Sat, Mar 03 2018, Jeff King jotted:
>
>> +	if (@colored && @colored != @diff) {
>
> nit: should just be:
>
>     if (@colored != @diff) {
>
> It's not possible for @arrays in scalar context to be undefined.

It is true that @array can not be undef, but your rewrite I think is
wrong.

The first "do the comparison only @colored is true" is not about
definedness.  It is "@colored can be an empty array when the user is
not using separate 'show these colored lines to the end user, feed
these noncolored lines to git-apply command' feature, so @colored==0
and @diff > 0 is perfectly fine".
