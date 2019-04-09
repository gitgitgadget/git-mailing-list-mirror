Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD36320248
	for <e@80x24.org>; Tue,  9 Apr 2019 16:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfDIQfn (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:35:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44487 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIQfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:35:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so10014790pfm.11
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5dfeR/r1Kp5Y043nMFJ3bEqUtLmbXxvFBjSkcgTVxgw=;
        b=h8++TkCyaHLEhPg45+Dpc+VM1a4yvtt7C6UDgAZPBa/pWsBKiEFjlRUFDgFJISYFiR
         cWHYtrWpAcSu6WGP1Ar7vuaw19IMK8ugW2+0l211C3GpiK9TrlrAa2KQE8tme+/aLuk0
         szhniQURuZL4JyHLumNRc5UpxApuiFaKWaydQ4R+v2vWDbU2iL7cMFUBJ2H5k4WyVIw2
         L9p0dTX8lGAC/dI7pykZEMiwyGlIeQ7WZ4h9vMk4sT8fz5JEA9T4ZAo/66gCX1WMFSTA
         IDh/fNoIAg+V+avNk28Z4Q2VXnuU2IjbczhnSonO2KK2zfwFs77ysfBDTprpucXvzWLP
         jxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5dfeR/r1Kp5Y043nMFJ3bEqUtLmbXxvFBjSkcgTVxgw=;
        b=LHoJz9twuH0g4Fyacq7QVTp0KvLIDDs+kcb2U2IFuWPOLF4lgWHbsdyWFbpdae2vLb
         QTui8a9Z73grHjvMBjmJefoNat1dKa61gSucyrX7Iq/tAvEsitCLtrDWujiqGkdBpJfz
         7sErjs023VmDsTjHHRUpLy57f2YAyDT+hV/KRGxmrMs9umB+VctHt5fOQ7JaRM4XQxgA
         UMZ7tMzdEd5zJKA6onZVs8CYrmHuCSmKGjKhnvcHEgn6db1KeRRIlD5w5H8asHbwl766
         jAqxskOp3LC0ktbnFSD6/PdXLzNVbeJbOyRjSJj5bjEq8Vy+fUytV/doCfthpWGXKp7E
         8DGA==
X-Gm-Message-State: APjAAAWgmkfOLXCwPi3P+jxhosXfvpjjzbxvu/vxzZjrc5/9clxcnjuO
        edikl0Ob9edKf2R5K4+ZYvasnA==
X-Google-Smtp-Source: APXvYqwg8YZnpa8FYt/mY7Wrot98QRK3JiF896FWVjGJ7Ue5f2TztjA3aGiiVqK0LwWZwsTUSM6GRA==
X-Received: by 2002:a63:450f:: with SMTP id s15mr35100478pga.157.1554827741748;
        Tue, 09 Apr 2019 09:35:41 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id s16sm46654222pgo.69.2019.04.09.09.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:35:40 -0700 (PDT)
Date:   Tue, 9 Apr 2019 09:35:35 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        jonathantanmy@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3] rev-list: exclude promisor objects at walk time
Message-ID: <20190409163535.GL60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
 <xmqqo95f43dq.fsf@gitster-ct.c.googlers.com>
 <20190409151559.GB12627@sigill.intra.peff.net>
 <xmqqbm1f421c.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbm1f421c.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.04.10 00:43, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Apr 10, 2019 at 12:14:41AM +0900, Junio C Hamano wrote:
> >
> >> I've dealt with the stray double-sign-off locally, but is there
> >> anything else planned for v4 or later?  Is this performance-only
> >> change, or does it have an externally observable behaviour change
> >> that we can easily add to our test suite?
> >
> > I am OK if we do not include it, but even if this is "just" a
> > performance-only change, we can always add to our perf regression suite.
> 
> Hmph, that does not say much about a possible change in behaviour in
> corner cases you guys were discuussing near the beginning of the
> thread when an object can be reached from both a non-promisor and a
> promisor object, does it?
> 
> Shouldn't we at least tweak the log message to record that we were
> aware of the possibility even though we couldn't readily come up
> with a case where this optimization breaks things?  I suspect that
> it would help the next person who needs to deal with a possible
> regression coming from this change to understand the problem better
> and hopefully faster.
> 

I'll update the log message and send a v4 in a few minutes.
