Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74CD1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbeBVS7v (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:59:51 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44188 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVS7v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:59:51 -0500
Received: by mail-pg0-f65.google.com with SMTP id l4so2351916pgp.11
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NbX2y9ElakAcQ6LbL9gSJ35miPKMFNwCaPgVAqjv6hU=;
        b=QRCHOVkyvDtDLLocehglmvR+FNi7wxh4aRkawf7V5tek1svb31An8C7lLK5kp+w1xH
         qcQHmyVHBnWk5Vbhd1vf2B5Jrz8xGNpmuZbfv5xJQNTg8XKOd+8haLYgmQ66hoD0l0oE
         MKA3v8BZ9BQJCgjKWb3qIReJsHjwe6KWaDbZzzdYP7jPT3nQhaCwpWo6DsFI2MeQyVp/
         iX1GE7d/X/tBX1HVnjRvtj50GJDNYRxAOLD+WnpDKS4qWWVMDGwVItRwD39F/LKATDp9
         mBmOZv2MaWRrjSSZ6CbQExSeEsf0csH8qRGnXZkwqS/xxKBNs6ZeD/4YgVuk+BRLtz6R
         5syQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NbX2y9ElakAcQ6LbL9gSJ35miPKMFNwCaPgVAqjv6hU=;
        b=oin09lhYXKbCA98oNdv18yl1DZXT30RFcVrnNypSwS+5QIUEd/wct2L8tYE+t1q6b8
         RBsH0sQNBKrN2J1gUqjwmKON3IhU2gpVVUcWZCWNAjJcsQZRPLC2otaFF8kIV1DJeFco
         iF4RG9L3EGH2mKj8xEeArmwaHuEKaFX7vM32veyBLsCUD6GvOUysN46mSZT6pFNMbXv8
         X9hS176Mm0Qx8pkj4O3JWfxdvtdomMtM97d43GmJLuis6jVWTEW48eXY2voMTDc/N/uJ
         dkQ7FBgYCFlx2Qum02p/R9WsOeF7QX9mpiVLMAgqHwXnsb9JS0Y/zGHUTXGU5e5LWr5z
         El3A==
X-Gm-Message-State: APf1xPA0YeiSX70Qez2H0Sihzr4orHC/IKJIoPZCMMet9FKvVgb2SFlX
        0DkFtt4syQD+r9RXJi6ifxRzv40CJ7o=
X-Google-Smtp-Source: AH8x2268xfkfg2Lx9dXdC95cVghoPyc7PastzAt5tiMUcUUmDgbVJ3kGu0M0mweO7/nT/sadnc+taQ==
X-Received: by 10.99.179.8 with SMTP id i8mr6388753pgf.337.1519325990287;
        Thu, 22 Feb 2018 10:59:50 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id q76sm1511904pfj.149.2018.02.22.10.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:59:49 -0800 (PST)
Date:   Thu, 22 Feb 2018 10:59:48 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 35/35] remote-curl: don't request v2 when pushing
Message-ID: <20180222185948.GK185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-36-bmwill@google.com>
 <20180221161209.80f0a3b941a069ea78ccf43e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221161209.80f0a3b941a069ea78ccf43e@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/21, Jonathan Tan wrote:
> On Tue,  6 Feb 2018 17:13:12 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > +test_expect_success 'push with http:// and a config of v2 does not request v2' '
> > +	# Till v2 for push is designed, make sure that if a client has
> > +	# protocol.version configured to use v2, that the client instead falls
> > +	# back and uses v0.
> > +
> > +	test_commit -C http_child three &&
> > +
> > +	# Push to another branch, as the target repository has the
> > +	# master branch checked out and we cannot push into it.
> > +	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=1 \
> > +		push origin HEAD:client_branch && 2>log &&
> 
> Should it be protocol.version=2? Also, two double ampersands?
> 
> Also, optionally, it might be better to do
> GIT_TRACE_PACKET="$(pwd)/log", so that it does not get mixed with other
> stderr output.

Wow thanks for catching that, let me fix that.

-- 
Brandon Williams
