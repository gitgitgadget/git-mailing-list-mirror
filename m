Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1FDC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8562075F
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMmLSbHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404053AbgE1PDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 11:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403912AbgE1PDo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 11:03:44 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094D3C08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 08:03:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y18so13635360pfl.9
        for <git@vger.kernel.org>; Thu, 28 May 2020 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UHCbmqec1OIyY6hXjx/4OKHXzXKPJvfXqs9sJ9glttU=;
        b=uMmLSbHHCk0mDpF9DpU3HNzsaU+X8wC1x/JwiVWoXjj5AKiT2LngF1Jf2pJ/FvJUB/
         5xphxTuBD0zyJEyzNQtf/pQCbKGqauUywiDNH1GqRvbT4X/h0oLvfi0apyCVbmuCCX7t
         MwW19sn+EjTIdIWxkqSybsk9JL6BaE83LQ0gl0m+5hq48Pa6xzsd2wPIOAF/lj2R1QQ1
         kFRf5D6eRDn+T9/g5atZ5hESXWyzw89wtX8RLhPyE6vu27l/mN/hdc7lGv9zALxmvXTQ
         c8yVdhfx1QicVKeDOKJS9QFNTIfOBrP/Qz+v5lb7QUoHL/6ZSb7qeJjfw0vP0jkz9DdB
         rzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UHCbmqec1OIyY6hXjx/4OKHXzXKPJvfXqs9sJ9glttU=;
        b=Gu8r9Y7b1W/TmxAwZVAjYz3V1/5yY8yBRezru3JANl7WlILZh4ilhFjJ2SgHlyoIYL
         VvmG83h/swRdrE9C1vnS7aPwyQZ5c0gJMIo0cSE1GRI7OBGDaCo5qTa3DngRun9ZsR6E
         a+x9t3VpCdab7aOYvO+QMipms0tXnU50dqmff2+gk29dSPBInalt44b4hTluwbH9fRqb
         PoQEPUYJf9WQvgmqjRDQ6J/cSyw07cLXJucNw6eh337UHFWFN/k+ESCjgIa3fOfLf94h
         YK5XON3gJlSbHZa3K5cH3/V8K/v8h2Ka3Mq/8CUtqNfJx7fphpKIiT3K6/DizmeVJpid
         JBmQ==
X-Gm-Message-State: AOAM533BC1u5/wv0Bi1ZZi6WWtf048gop3XEWwkU1GyGEKv5t+T1rq6X
        7ppkZsRQOE2r0twKird+fKk=
X-Google-Smtp-Source: ABdhPJzSEPmpnizFCrkYbyeUZcFeUPIgZ/eNMG8AyrAW7swHGQkd647Aj4D+qvUwKUtv9RKyNxErBw==
X-Received: by 2002:a63:5f41:: with SMTP id t62mr3450862pgb.252.1590678223336;
        Thu, 28 May 2020 08:03:43 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id g65sm976399pfb.61.2020.05.28.08.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:03:42 -0700 (PDT)
Date:   Thu, 28 May 2020 08:03:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Steadmon <steadmon@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
Message-ID: <20200528150340.GB58643@google.com>
References: <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
 <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
 <20200407014829.GL6369@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2004072355100.46@tvgsbejvaqbjf.bet>
 <20200408000149.GN6369@camp.crustytoothpaste.net>
 <20200527223907.GB65111@google.com>
 <xmqqa71s6g1w.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2005272334560.56@tvgsbejvaqbjf.bet>
 <20200528145018.GA58643@google.com>
 <xmqqwo4w3y4s.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwo4w3y4s.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>                              The real question is, do we consider the
>> existing "git gc" infrastructure such a lost cause that we should
>> touch it as little as possible?
>
> I am fine with that, as long as the "new" thing will take over what
> "git gc" currently does.

Good reminder, thank you.

Yes, as long as we end up replacing the old thing, making a parallel
new thing (e.g. with a config option for switching between during a
transition period) can be a fine approach.

Thanks,
Jonathan
