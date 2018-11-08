Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E73081F453
	for <e@80x24.org>; Thu,  8 Nov 2018 03:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeKHNII (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 08:08:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38870 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbeKHNII (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 08:08:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id f2-v6so3905962wme.3
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 19:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7gGuasS67nTu3OYUXfr15fqcvxYiQRs8qhf4ogZ2LYk=;
        b=XAKidEf9Q8rZK2WhnwLg15Yx+ybLLYUDyV3JDzdDk/AEBpjAyUiBn1MHlQ3/nQLxFK
         YuOT1wVW2GMYyWssJutiu13T/4SPSetqBV5tERdSRrKgTYm7ywPTbtQGjrJ7DV0ghEjA
         gNnRxTUUJhgkvtEnkO/wzyXcKljv2X30A/3TFNwYpwY0t3vVfWe1vKuMAUyaU2+dTm5Y
         34POJIVPHbpTDSHdokHWh2/ZBsgNI/m9teI1zFv42Zb+CScv21ZVThzVyBA5XJHNqA/x
         8lKRMa430pEjP3ATS80fUJerPiKVGIXvfylBj24KHmTABHyxZ1GY/b6avybSWaupu23R
         cIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7gGuasS67nTu3OYUXfr15fqcvxYiQRs8qhf4ogZ2LYk=;
        b=nBErqNnBCFPPAGdUtAzBVEmp7De1h0DkrK1tnWepLBT1zfPGsFH3exzYUmpzjf0x8j
         ObTqyfVTGqFzqYkDZTVPIrG67St9Kq9TuvtyzWBJIWTYr/78rfGNH4iPTjwmyQP5kPVS
         kzOrHzJOuq+1jwxBqKPANpx/l2BWYrAqmh2Qy2FMSL9joN5JBxvtDQ9d/iwh2yBL6ZOt
         Rz0GXDn+4/Qr4jxztngFoEeYE6Ur/ak3jn2/8K6TfgPg+n9IAmFF1qr0aVt4Coo/v621
         r+pCyKX9qtfTHWFoI773/1kaaYffrcf6iBYmrA3+R42X65x5Ec9pBS874NQWaJPOCllk
         w5XA==
X-Gm-Message-State: AGRZ1gJ6z6LWWIkgiGWeFmNLFhOsA36dD7jZ8NZ5+nblmktoKblcncza
        SeG4xkrGqXFv2lLfgESIEBc=
X-Google-Smtp-Source: AJdET5dReY0FAOlkuRrDmfznnWeOmbb9pvdeWL7TJCYif+3uFPhND8XBpmnMDws9y0C+468AnBhgzg==
X-Received: by 2002:a1c:954b:: with SMTP id x72-v6mr2119717wmd.14.1541648083059;
        Wed, 07 Nov 2018 19:34:43 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y4-v6sm3310558wrd.61.2018.11.07.19.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 19:34:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        andals@crustytoothpaste.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Support --append-trailer in cherry-pick and revert
References: <20181104181026.8451-1-pclouds@gmail.com>
        <20181106171637.15562-1-pclouds@gmail.com>
        <871s7y6qs9.fsf@evledraar.gmail.com>
        <20181106221118.GA9975@sigill.intra.peff.net>
        <CACsJy8DTdW-P9zG3DBPArjhZU1VwwBmd7qNibyHxYkyjRrdWmw@mail.gmail.com>
        <xmqqh8gs9zh3.fsf@gitster-ct.c.googlers.com>
        <20181108012901.GB10148@sigill.intra.peff.net>
Date:   Thu, 08 Nov 2018 12:34:41 +0900
In-Reply-To: <20181108012901.GB10148@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 7 Nov 2018 20:29:01 -0500")
Message-ID: <xmqqh8gs8coe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So if we are comfortable with saying that this is a new feature to have
> the machine-readable trailer version, and there isn't a robust way to
> get historical revert information (because there really isn't[1]), then
> I think we can just punt on any kind of trailer-normalization magic.

Yes, I do consider that the original suggestion was two-part

 - cherry-pick did have machine readable info, but by historical
   accident, it is shaped differently from "trailers", so we'd
   transition into the new format.

 - revert did not have machine readble info at all, so we are adding
   one, even though it is not that interesting as cherry-pick (for
   the reasons you stated in an earlier message in this thread).

So my "honest answer" is your #1, "sorry, there was no
machine-readable version back then", for reverts.  We do not have
such a problem with cherry-pick luckily ;-)

> [1] Thinking back on reverts I have done, they are often _not_
>     straight-up reverts. For example, I may end up dropping half of a
>     commit, but leaving some traces of it in place in order to build up
>     the correct solution on top (i.e., fixing whatever problem caused me
>     to revert in the first place). I list those as "this is morally a
>     revert of 1234abcd...", which is definitely not machine readable. ;)

Yup, and it is debatable if it even makes sense to add the machine
readable trailer for such a commit.  A human-made claim that it is a
"moral equivalent of reverting X" may not look any different from a
"textual revert of X" to a machine, but the actual patch text would
be quite different---unless the machine reading it understands
"moral equivalence", letting it blindly take on faith whatever
humans say may not be a good idea.
