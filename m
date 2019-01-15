Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E581F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 01:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfAOBty (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 20:49:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34445 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAOBty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 20:49:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so499418pga.1
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 17:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xQa/kZ3ONm5YqibJu8lsPw6elZN1NoSLpu2VHJz752s=;
        b=cUKXUOdyni8MFYe68/i8pVe0QOjfu9QjQe0jrgZao99OoSbq0VE8mUHaasGFj9pDge
         p0OqgCqR0OtKU+kVF0zueY5lGADyfnJlTfSEVsGTTHbKPOmHpqIlnrcbAVeuf+Pqq09w
         g8+uX3EWD65IjXwHvrI3aBg81OGnYWYuaBWFkCKf7vo957F5XkQI8qDl+kqco9mpBlzn
         gPlm4eFG/abcESG+bQMLFNVZbfAeVB9x3eeG3xPM7BuLEpfbBvglrtiFljUww1ZJ23bb
         cmIxJq6Ozja6jiV2PdcqJ7yBTgUIWYyUytiufuMbKvCv0nBhGp28hoh/qyC+HiEjey63
         nKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xQa/kZ3ONm5YqibJu8lsPw6elZN1NoSLpu2VHJz752s=;
        b=qIdRiaOtDtDPVsqnVNJe53kF98Ud18O/7s/bMRoMK13VZxdS9/3BtvsciCVi/mbcCu
         vrmU6ImW3ELM+iQUtripo//qCo0YcL9I7Ty/aanlxt8BrTtG+4IHRfKR2O9Pfj3ujvis
         qzM8uowhLEaUw+4x7Lit+0y2SoVAxDgKOqDe1ELHwh4ao1wekqri1ktiG/9iY8/ufean
         /R9SYXrqreIrPhvC2KwD1UMaPu7+Ugk0hL+ig3i0zYbqga8vwDpgcp1yA2UOypnxu9YD
         TFsPQK/cu4pfkyZHYdKF9ZUmnKzbg0nbM84EAp7mlGpFwRgcl6IC064EFYWS/5WH5/KS
         wBtg==
X-Gm-Message-State: AJcUukdkxSa38dO09K6GFcaYfmM3fn5KxzwYx8C6JquKjZ/xjBihIkfS
        /rkZHwxs9QzA/mswR8VwDkY=
X-Google-Smtp-Source: ALg8bN4P3Nb49+/lHuBua7iGHbCU8P+we5AlnVgC/fWWp9ZlLXR4YsUuEgytjP3922Wot7b6V5vmBw==
X-Received: by 2002:a63:f811:: with SMTP id n17mr1461646pgh.23.1547516993052;
        Mon, 14 Jan 2019 17:49:53 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id t185sm1775061pgd.90.2019.01.14.17.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 17:49:52 -0800 (PST)
Date:   Mon, 14 Jan 2019 17:49:50 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Masaya Suzuki <masayasuzuki@google.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v2 0/2] Accept error packets in any context
Message-ID: <20190115014950.GN162110@google.com>
References: <reply-to=20181127045301.103807-1-masayasuzuki@google.com>
 <20181229211915.161686-1-masayasuzuki@google.com>
 <xmqqef9tfikg.fsf@gitster-ct.c.googlers.com>
 <20190115014348.GM162110@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115014348.GM162110@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Junio C Hamano wrote:

>> In short, are you shooting js/smart-http-detect-remote-error topic
>> down and replacing it with this one?
>>
>> As that topic is not yet in 'next', I am perfectly fine doing that.
>> I just want to make sure that is what you meant, as my reading of
>> [4] was a bit fuzzy.
>
> Josh, looking at that branch, I see:
>
>  remote-curl: die on server-side errors
>
> 	Includes a test illustrating error handling in the ref
> 	advertisement.  Should that be revived as a standalone patch,
> 	without the remote-curl.c change?

In fact, it appears I have that locally:

 commit 7fe6abcd775dbffd919891d5838f8d125e41f160
 Author: Josh Steadmon <steadmon@google.com>
 Date:   Tue Dec 11 16:25:18 2018 -0800

    lib-httpd, t5551: check server-side HTTP errors

    Add an HTTP path to the test server config that returns an ERR pkt-line
    unconditionally. Verify in t5551 that remote-curl properly detects this
    ERR message and aborts.

    Signed-off-by: Josh Steadmon <steadmon@google.com>
    Signed-off-by: Jeff King <peff@peff.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

It's handled fine by the merge 7be333a6362882e8ffceef3de830dbbfafe99995
(Merge branch 'js/smart-http-detect-remote-error' into pu, 2019-01-11),
though.  So I think what is in "pu" is okay, without shooting any series
down.  (Alternatively we can combine them into a single five-patch
series, if the maintainer prefers.)

Thanks,
Jonathan
