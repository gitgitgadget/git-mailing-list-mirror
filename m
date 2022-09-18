Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3300C6FA82
	for <git@archiver.kernel.org>; Sun, 18 Sep 2022 19:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIRTwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Sep 2022 15:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIRTwl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2022 15:52:41 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCCA1BE
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 12:52:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q62-20020a17090a17c400b00202a3497516so4240610pja.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7Jq8jsWCBZqleZ+vQMI/ooqoiebOxepAXmfvhUobgV0=;
        b=QZIYRtldMPatmbDv4MnMSOrg05WXnk4LhlQEZoIwh1wmmJTXdbnMd3cLK80aRtpliO
         NQEBxn3TEFXwr3GdO6+YUMVf04D6KBsRAit1MZyKbIz01kZvXxXVZV5N2XNgcBvcMOw5
         +Q7v5dbaPMh6XUxGcLecpiRmB0jKNMi3w4YeyKQeGScEV/ca+CnfOxHj4v1IOfF5hL6P
         SswzKtgYEYdvsackAHM76qu9sBt9m2nphoAjmtn0aHksOfKu3+L0j07lcWc29jOSYe4P
         f/iaXV8TDT3dF4rU3/v9LkzIiUajJOBNJ4+lPPH3mViZx8F2wOT4cB3Q9nGVEBzSHCzr
         oFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7Jq8jsWCBZqleZ+vQMI/ooqoiebOxepAXmfvhUobgV0=;
        b=2jBVZHOnyVKcj8SFklaPa5P49KCS29LpT1tveru6I+9mOq0lYFvCO60MBTpVuml+dJ
         SpeJnwuS6OH8C7iNtzyrQHzjHEjZkBxerR8zhqo8mDPDmUaq2/bCAqMPuMGgOnV9QTOZ
         pDyuuOVZ24VKuSHTiGkfqmhIpwCsM4KhKUpVOCBSegO3qQiF+Fy3Mk//yHWhFVhGetds
         3p5Wn1TEsBpoZps/xGlMFQ6bCDJbQAwJaG37idO+AqpRW45BT+FsvFX+wV4qi03XHCaD
         QyFBTYOR0ubfRPS0Gt7g4587y8rgPKzvk8Cx1xdRfO44gZ6ihdebarvTiD08+YcKLz+D
         wJkg==
X-Gm-Message-State: ACrzQf3SW1LDlWYulRMDRw7oKbp0ZWhFMSYT3kwayPTKiA+rhPvCPnau
        LiBRardEo2pr4GThm9senuWw
X-Google-Smtp-Source: AMsMyM4K1Yphnw7nCuar+iEcWrwoM+De9f9XyoRT0oAPecoe4eCYrqCldns2Ktt0aUQJFEhrf3mmUA==
X-Received: by 2002:a17:903:24f:b0:172:7d68:cf1 with SMTP id j15-20020a170903024f00b001727d680cf1mr9626229plh.55.1663530760612;
        Sun, 18 Sep 2022 12:52:40 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id ix10-20020a170902f80a00b00174e5fe9ce1sm18811591plb.159.2022.09.18.12.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 12:52:40 -0700 (PDT)
Message-ID: <cafcedba-96a2-cb85-d593-ef47c8c8397c@github.com>
Date:   Sun, 18 Sep 2022 12:52:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v5 1/3] builtin/grep.c: add --sparse option
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
 <CABPp-BF-z72=hY_Jf8h3g95s+wwZOsV_S=+dDNs_AVskQxoaTw@mail.gmail.com>
 <xmqqh719pcoo.fsf@gitster.g>
 <CABPp-BEOVGfgmAMGCjP6Q3k-t=C1tL=f27buhiCiL-Wv0eDF_A@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BEOVGfgmAMGCjP6Q3k-t=C1tL=f27buhiCiL-Wv0eDF_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> == Overall ==
> 
> For existing querying commands (just ls-files), `--sparse` already
> means restrict to the sparse cone.  If we keep using the existing flag
> names, grep should follow suit.
> 
> For existing modification commands already released (add, rm), the
> fact that the command is modifying actually gives a different way to
> interpret things such that it's not clear `--sparse` was even a
> problem.  However, perhaps the name of the flag is bad just because
> there are multiple ways to view it and those who view it one way will
> see it as counter-intuitive.
> 
> == Flag rename? ==
> 
> There's another reason to potentially rename the flag.  We already
> have `--sparse` and `--dense` flags for rev-list and friends.  So,
> when we want to enable those other commands to restrict to the
> sparsity patterns, we probably need a different name.  So, perhaps, we
> should rename our `--sparse/--dense` to `--restrict/--no-restrict`.
> Such a rename would also likely clear up the ambiguity about which way
> to interpret the command for the add & rm commands (though it'd pick
> the second one and suggest we were using the wrong name after all).
> 
> (There are also two other commands that use `--sparse` -- pack-objects
> and show-branch, though in a much different way and neither would ever
> be affected by our new --sparse/--dense/--restrict/--no-restrict
> flags.)
> 
> Other names are also possible.  Any suggestions?
> 
> == global flag vs subcommand flags ==
> 
> Do we want to make --[no-]restrict a flag for each subcommand, or just
> make it a global git flag?  I kind of think it'd make sense to do the
> latter
> 
> == Defaults ==
> 
> As discussed before, we probably want querying commands (ls-files,
> grep, log, etc.) to default to --no-restrict for now, since we are
> otherwise slowly changing the defaults.  We may want to swap that
> default in the future.
> 
> However, for modification commands, I think we want the default to be
> --restrict, regardless of the default for querying commands.  There
> are some potentially very negative surprises for users if we don't,
> and those surprises will be delayed rather than occur at the time the
> user runs the command.  In fact, those negative surprises are likely
> why those commands were the first to gain an option controlling
> whether they operated on paths outside the sparsity specification.
> (Also, the modification commands print a warning if they could have
> affected other files but didn't due the the default of restricting, so
> I think we have their default correct, even if the flag name is
> suboptimal.)

One of the things I've found myself a bit frustrated with while working on
these sparse index integrations is that we haven't had a clear set of
guidelines for times when we need to make UI/UX changes relating to
'sparse-checkout' compatibility. I think what you've outlined here is a good
start to a larger discussion on the topic, but in the middle of this series
might not be the best place for that discussion (at least in terms of
preserving for later reference). 

Elijah, would you be interested in compiling your thoughts into a document
in 'Documentation/technical'? If not, Stolee or I could do it. If we could
settle on some guidelines (option names, behavior, etc.) for better
incorporating 'sparse-checkout' support into existing commands, it'd make
future sparse index work substantially easier for everyone involved.

As for this series, I think the best way to move the sparse index work along
is to drop this patch ("builtin/grep.c: add --sparse option") altogether.
Shaoxuan's updates in patch 3 [1] make 'git grep' sparse index-compatible
for *all* invocations (not just those without '--sparse'), so we don't need
the new option for sparse index compatibility. It can then be re-introduced
later (possibly modified) in a series dedicated to unifying the
sparse-checkout UX.

[1] https://lore.kernel.org/git/20220908001854.206789-4-shaoxuan.yuan02@gmail.com/
