Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12B21F42B
	for <e@80x24.org>; Wed, 12 Sep 2018 06:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeILL3w (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 07:29:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36128 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeILL3w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 07:29:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so492131pfo.3
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 23:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U9QPCxUx6UpSNui1uZ0dvgoGhyXdIOz9ODsniEaA0UQ=;
        b=ljVpAwGVY78Mt4z2k95b1xS7c2GqgZZoaozdWBH4pIHO8b3iMRTz21G0WyeI0oCB8S
         EXLKbu+M/uTpOPKXC8pi/dlaNtQI96GBX03a7sJ6HY3KQ4h9zzZpBCpgD0FOvV7CEVd8
         eVDoQvKAgJQX1LuzIblea50K7si08LLzkDKQy+Nza6P7DeiAbPyAFUPoQJRzfnRe5+tl
         NSJDqCqUfCNiOP6n3Co90NGZPEodXgb6kTI0bt2odyHZfiGMAKaRHjAOWq6v2Cz3AzSk
         rpvEyZrN9v9UP7lqYG7i4lBYEoh7lQGDg1GaOkHxF0IHvK40F3qBJYpFpBL4Y50pJqD4
         VZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U9QPCxUx6UpSNui1uZ0dvgoGhyXdIOz9ODsniEaA0UQ=;
        b=TBxq3LEnx/ygJv1yTz1MzTod8mPkwBesZLApK/J/+u9UWKc7O1h4enay9E1ygX40EI
         RQv1Usz5hiluH2E2GnBWzw/YROCYDb62xYpyJ65HEyUVnErsbJCT+R3Im6QZCSt1cRPQ
         bt9NHNyZb0C1tzeags8eE6eEcqdGrwHvLjw0t/G33oxZ/0ck4RCPt6RUvSxD5HXZJ28I
         GRiSHytL8lr0mXefAUM8a+TOfKNDp3UD0WA1WiJAKSvmFo4bXC/w2dGj/TfCt6btb55y
         lUzePzqooU10XFLlTBs4g1p69RDxOD9Bn+iCFS7kgxBXEQUCNrvPJlUbPavTO0l70GPP
         n3Yg==
X-Gm-Message-State: APzg51A4i1vHwIb4Dure98qX2Gdv217xkhAiEkH726ujxBa/LCPVwY21
        D9A8aXCJwkWqYKmpqKtuhiiSPlur
X-Google-Smtp-Source: ANB0Vda0zVlU1jtKDT8rau4syvTkjD/oV5NS+PiVaV2akoGHq3y7uD4lc3DfEdY1aeURsRKNJc/3ng==
X-Received: by 2002:a62:3703:: with SMTP id e3-v6mr398407pfa.117.1536733611511;
        Tue, 11 Sep 2018 23:26:51 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 5-v6sm161022pgc.86.2018.09.11.23.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 23:26:50 -0700 (PDT)
Date:   Tue, 11 Sep 2018 23:26:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
        git@vger.kernel.org,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH] http-backend: treat empty CONTENT_LENGTH as zero
Message-ID: <20180912062648.GA197819@aiede.svl.corp.google.com>
References: <20180910052558.GB55941@aiede.svl.corp.google.com>
 <20180910205359.32332-1-max@max630.net>
 <20180911034227.GB20518@aiede.svl.corp.google.com>
 <20180911040343.GC20518@aiede.svl.corp.google.com>
 <xmqqk1nrq4su.fsf@gitster-ct.c.googlers.com>
 <20180912055626.GA13642@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912055626.GA13642@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, Sep 11, 2018 at 11:15:13AM -0700, Junio C Hamano wrote:

>> I do not think we would mind terribly if we do not support
>> combinations like gzipped-and-then-chunked from day one.  An in-code
>> NEEDSWORK comment that refers to the production in RFC 2616 Page 143
>> may not hurt, though.
>
> It's pretty common for Git to send gzip'd contents, so this might
> actually be necessary on day one. However, it looks like we do so by
> setting the content-encoding header.

Correct, we haven't been using Transfer-Encoding for that.

> I really wonder if this topic is worth pursuing further without finding
> a real-world case that actually fails with the v2.19 code. I.e., is
> there actually a server that doesn't set CONTENT_LENGTH and really can't
> handle read-to-eof? It's plausible to me, but it's also equally
> plausible that we'd be breaking some other case.

I wonder about the motivating IIS case.  The CGI spec says that
CONTENT_LENGTH is set if and only if the message has a message-body.
When discussing message-body, it says

      Request-Data   = [ request-body ] [ extension-data ]
[...]
   A request-body is supplied with the request if the CONTENT_LENGTH is
   not NULL.  The server MUST make at least that many bytes available
   for the script to read.  The server MAY signal an end-of-file
   condition after CONTENT_LENGTH bytes have been read or it MAY supply
   extension data.  Therefore, the script MUST NOT attempt to read more
   than CONTENT_LENGTH bytes, even if more data is available.

Does that mean that if CONTENT_LENGTH is not set, then we are
guaranteed to see EOF, because extension-data cannot be present?  If
so, then what we have in v2.19 (plus Max's test improvement that is in
"next") is already enough.

So I agree.

 1. Junio, please eject this patch from "pu", since we don't have any
    need for it.

 2. IIS users, please test v2.19 and let us know how it goes.

Do we have any scenarios that would use an empty POST (or other
non-GET) request?

Thanks,
Jonathan
