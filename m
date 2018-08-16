Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4231F404
	for <e@80x24.org>; Thu, 16 Aug 2018 15:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbeHPSGP (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 14:06:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53084 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeHPSGP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 14:06:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so4756167wmh.2
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9m8pSg9lWrAsss8aVP75QzLjMx972ENzjdnNnNcAFp0=;
        b=aEg0IABCD2bvVd6PJ6tnO2s9wLfqqg1voz5GF4AbsZkPXRXC+pCZ/aRrVq1HUOCI9c
         5EQjzU8TBBm9ye28m99KKb9y0gMLo+4yG8K8ndB0cLoVqb2TzgeWvLjHhs8rFyI7vITP
         ZehBUn71yj0bY6gmfbW7Ks1ij6wX/U9KgnjYL3P1aN6LDBZPgpuZBn2EvQySMtl4MYjH
         0QYKRf4NeTFAXtaid1x4F7WKAnYyq0epyyxFeGox9Fj/Y5OwpC0f+eFmVW8lFGKjzRkJ
         15X1PgjKRn+gHmWhdXUKBnU2cNEpK4XiDNpDot7U0JPr6E7wSihvO7f62Sdn1j8idtpq
         MzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9m8pSg9lWrAsss8aVP75QzLjMx972ENzjdnNnNcAFp0=;
        b=bKrNXDm/QfUg5gJuszTaPZMhsLZssbLxeMqS9W/IJefLxf7C/erIotGTB9gbx1DqHY
         UxaZASiS8S7GiAWfVaejdVEUTBoU+25Z8AzTwvIhSc9Y7a6b2Z2yknci43HXSjrJKJtB
         lGoIJnM+HVxE9CfOy3uAd/mZAunRIeTWEXZ/V217yFNZqi3opXlsFC5I4Ey2+jnfu8V8
         v445dSKYSMEa6a8PJZ7AXX9KXn/bI/aWqfKuOUAPldox3JHeicK6GLsZWBBD39kqa5cl
         Q7lkGBgyvnGsno+3fShd8PpTewjXRjHZoF5/Ssjmo1NNL8KRoG8ES1Ualh1cZAC1S3hI
         rjLg==
X-Gm-Message-State: AOUpUlGnL4wNq5n+IXRwFWTawiORx0kP5UopqHfLb7UU4/ebcvhG91mz
        0bRT/DOs2zOU9Te1dxQwR4k=
X-Google-Smtp-Source: AA+uWPxRs+TUqjHRYe24lkPp3m9cmx4tRBAXxFRLVkJqPIummbGoK8UfH8vgVirFOvjesyCt+9BFHg==
X-Received: by 2002:a1c:90e:: with SMTP id 14-v6mr16568869wmj.130.1534432030508;
        Thu, 16 Aug 2018 08:07:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v5-v6sm19033765wru.60.2018.08.16.08.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 08:07:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
References: <20180807230637.247200-1-bmwill@google.com>
        <20180808223323.79989-1-bmwill@google.com>
        <20180808223323.79989-3-bmwill@google.com>
        <20180809212602.GA11342@sigill.intra.peff.net>
        <20180814180406.GA86804@google.com>
        <20180814185743.GE142615@aiede.svl.corp.google.com>
        <CAGZ79kZUq5jPqyb=B1ppEi1QhNGmhLXeV6vPn8ouR=YGEN32pg@mail.gmail.com>
        <20180814211211.GF142615@aiede.svl.corp.google.com>
        <CAGZ79kYfoK9hfXM2-VMAZLPpqBOFQYKtyYuYJb8twzz6Oz5ymQ@mail.gmail.com>
        <20180816023446.GA127655@aiede.svl.corp.google.com>
Date:   Thu, 16 Aug 2018 08:07:07 -0700
In-Reply-To: <20180816023446.GA127655@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Wed, 15 Aug 2018 19:34:46 -0700")
Message-ID: <xmqqh8jugxk4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> So it would be nice, for future-proofing, if we can change the naming
> scheme later.
> ...
> All at the cost of recording a little configuration somewhere.  If we
> want to decrease the configuration, we can avoid recording it there in
> the easy cases (e.g. when name == gitdirname).  That's "just" an
> optimization.
>
> And then we have the ability later to handle all the edge cases we
> haven't handled yet today:
>
> - sharding when the number of submodules is too large
> - case-insensitive filesystems
> - path name length limits
> - different sets of filesystem-special characters
>
> Sane?

Yup.

