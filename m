Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B016CC4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5978821D43
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0/nTqZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgJADny (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 23:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgJADny (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 23:43:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C43C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:43:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so1132757pjb.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hqxf2e70kAJ0UsPoPqADiZT7ngr2QYolOx29jtxGhik=;
        b=T0/nTqZm1y0n/rD2H6LEMs03sW4n/+5lh1D1fQj/7JOjV840R7jkvmu3KaAoFKSR2n
         0Y4Qi/3fpXISnOxWaKOpI0s6zLRE+DXJFFmjm8CD1+yDB/ObjVU9zA+l7yZMnkgH5r5J
         DHoYzS4a7OliyEFLINkxw+TLwxb+wUL3YAlD3T7h0dSKYI87oYt4qcq/MO0ea1RE2q8x
         RrWhorF0BxWJxryfBu3nDeUWPBd/3wWr5HIT+Utl0rnYV2rk1s8qbhX6lUcTja4nwETn
         WSG+BDoBAY4jlLqLFKDqmgvSvEBn/utmYlbE/LVAi0UFrn5X83Z/+1QVufJoIj/x9YSw
         GjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hqxf2e70kAJ0UsPoPqADiZT7ngr2QYolOx29jtxGhik=;
        b=nWm0iXovrEWQbtITDroUTPhUr4868nTJVIu5dIjRzgQ5+K5tn2HiCHpvf5tK+Mc948
         bjSnCj2vYZCjxYTo+MXs+gpi0Hu2/50fvE+EYVXi+9tS+Wq+5YIu6BSk+L27hWIXY4HM
         TdecmGYNjiHZMofQh7zFRJSsbXMjyGqlnwDyRLR+AFwIIkkmgNEoL6eUsQq7kJcPvtWv
         nKrg7xQ+sz3PobgB+1/dwCyIqB05hiLDa4PuIKqTTDitGEV8Wz1MIzIQN7uBA/3Mgyd9
         V1h1/o4Ss9ayD/XOvucrHrq/zl/KaulRBgCLZdmkJ9IvsBEzzFaCtWpJQ4LRwHCgTBCV
         H4UA==
X-Gm-Message-State: AOAM531fjnlxs1HSwWuDgt5ErJgaAHAUTssWrk3CL4Ssi6u2f7jiKWpC
        5OxW6wvMG9YcpusJqBWgUJc=
X-Google-Smtp-Source: ABdhPJwqoKVIRL4MIuPNagShNHacfz9gedUIDzHvVHmHRnwdMj6sLQRyZEgo6fKUPHEFXbnXP952Ow==
X-Received: by 2002:a17:90a:4043:: with SMTP id k3mr5298290pjg.141.1601523833306;
        Wed, 30 Sep 2020 20:43:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id 187sm4312072pfx.174.2020.09.30.20.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 20:43:52 -0700 (PDT)
Date:   Wed, 30 Sep 2020 20:43:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shengfa Lin <shengfa@google.com>, git@vger.kernel.org,
        nathaniel@google.com, rsbecker@nexbridge.com, santiago@nyu.edu
Subject: Re: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
Message-ID: <20201001034350.GB2930867@google.com>
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
 <20200930232138.3656304-1-shengfa@google.com>
 <xmqqlfgqes95.fsf@gitster.c.googlers.com>
 <xmqqtuved70y.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtuved70y.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

>                                                Our setenv() may not
> be early enough---before the code that decides to call a setenv()
> is run, there are many things that are outside your control (like
> the tracing subsystem, repository discovery, etc.) will run, and if
> any of them does something that triggers tzset() to be called, it
> will be done with the value of TZ the process started with, and our
> setenv() that happens much later won't have any effect to it.

I thought about this before, but in fact it's okay: when calling a
function like localtime() (though not localetime_r() --- see my other
reply), tzset() is called each time so it is able to reflect any
updates to the TZ envvar from the interim.

[....]
> You can let the existing code produce its natural result and then
> when the "force UTC" flag is set, override the offset part to +0000
> if and only if the timezone was obtained from the current
> environment (this if-and-only-if is necessary, because you do not
> want to rewrite and force UTC when you run "git commit --amend"
> without the "--reset-author" option to update a commit that was
> created somewhere else to UTC).  That way, we do not have to futz
> with TZ environment or tzset.

Yes, I think this is simpler and nicer than the proposal in my other
reply.

In addition to not having to futz with TZ, I think I like the
semantics better.  The motivation that started this thread was not so
much "I want to set a custom timezone to blend in" but rather "why are
we recording the timezone at all here?"  In that context, it makes
sense to me to have a setting such as

	core.recordTimeZone

that I can turn *off* to say that I don't think datestamp() callers
should consider the timezone to be information worth recording (and
instead they should write +0000).  To me that seems a little simpler
to understand than user.hideTimezone since this focuses on turning
some functionality off (recording of the time zone) instead of turning
on a new stealth mode.

Thanks,
Jonathan
