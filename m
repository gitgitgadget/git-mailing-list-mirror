Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BECF11F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 21:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933187AbeGIVLd (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 17:11:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32859 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933003AbeGIVLc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 17:11:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so3474302wrp.0
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 14:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RbGEaTIbcuO6mzzyc0UqDi/wtjF19ERUg9vDUndmgl8=;
        b=V3jSYgMWB7rVvnBrsi0vnn772O5XE55nEj9tgfVX1p+GnVVVsODFOp/uRthwc2l1H8
         ZlRW/OltxTUqSqb2ItWNasoLl1SBlp6Adi8BbuRSltoowGjgXTHIzt9XaXYo8bnoolmk
         4x/PW+i/Ezdpz7LJQuep13dhyRygUL8Yhsoc02QCXieI9iWzBkXb8aQxDP4tYXMQiJbG
         fWCQeX9nOnVy+wxu1dhU58RxsNR+RIcXN0Jdndc6VDTg96vytTraQJTwKaEc1DWKtUQf
         xUIYl0vNHqC4B/fwZS968EUdiEW2q1JWHI8R4VNsfNyXV+wDO/w1yN2e6nktQdXNxhKS
         aWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RbGEaTIbcuO6mzzyc0UqDi/wtjF19ERUg9vDUndmgl8=;
        b=aCVqe/vkgItWo++vhM5jDI3CEnQzLYArEPJH8ZsV7QHAO38tfkIIAILXuq8WSGC/Yw
         srTaseom0fMRfn0u+qBap7un79yK2UE5fZdn4o2tl7l+t1amV7n1dCXCySOXk/RfXOQF
         3L1AujDtZKV1u5vcC5q0pV5hktixYBUp7KQYP8hynF54xB7zIBf1kcZOzBXQiNO9x0aR
         zG/4ZBK3K94ytmI8TjPMRX5HR04NsXYtYGz/KV6LeVe6Xg+z+7FvIjaf1/tRwUafGvAO
         9Rt/x8CK8QjwG5zXOOD06iTgvETq2jlHCPHKqoXTyVMeCuexfh9KdBGRWkqrTVJjuEqP
         PxLg==
X-Gm-Message-State: APt69E3moieu2QNO5Vdjea3qP4apNEeLPJl0Q0RFJhreAwwA6VNDHYVz
        oT2kdeKm5xh/HcPG48l8jUdw4m6U
X-Google-Smtp-Source: AAOMgpcZDKk7JDqgSTW2fspDcFBYppWyeBFGTeCiJMCQOdkC4MpixdVBezv4n7MhnBQpv7G6nAN89A==
X-Received: by 2002:adf:9246:: with SMTP id 64-v6mr16463907wrj.109.1531170691652;
        Mon, 09 Jul 2018 14:11:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n8-v6sm17768330wrt.56.2018.07.09.14.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 14:11:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Andrei Rybak <rybak.a.v@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] sequencer: don't say BUG on bogus input
References: <20180709194636.GB9852@sigill.intra.peff.net>
        <20180709194912.GB7980@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1807092222300.75@tvgsbejvaqbjf.bet>
Date:   Mon, 09 Jul 2018 14:11:30 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807092222300.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 9 Jul 2018 22:24:25 +0200 (DST)")
Message-ID: <xmqqsh4sazct.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Peff,
>
> On Mon, 9 Jul 2018, Jeff King wrote:
>
>> diff --git a/sequencer.c b/sequencer.c
>> index f692b2ef44..234666b980 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -3637,7 +3637,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>>  			return error(_("revision walk setup failed"));
>>  		cmit = get_revision(opts->revs);
>>  		if (!cmit || get_revision(opts->revs))
>> -			return error("BUG: expected exactly one commit from walk");
>> +			return error(_("empty commit set passed"));
>
> Should this not rather be
>
> -		if (!cmit || get_revision(opts->revs))
> -			return error("BUG: expected exactly one commit from walk");
> +		if (!cmit)
> +			return error(_("empty commit set passed"));
> +		if (get_revision(opts->revs))
> +			return error(_("unexpected extra commit from walk"));

Good eyes.
