Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2DA01F404
	for <e@80x24.org>; Wed, 29 Aug 2018 22:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeH3CgK (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 22:36:10 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36719 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeH3CgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 22:36:09 -0400
Received: by mail-wm0-f49.google.com with SMTP id j192-v6so40704wmj.1
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=Bg682UXoUe4mQYKZbi9Mhjl7PY9ajACV5lnMcREQlHs=;
        b=muIO+ShZUBrCJLbGLLKQ3b549z5bL1ITTtsMkJcV/L/d+qqZJdh1KuJk5fVem0UAfD
         Rl9o11ZLIaDZK+o3gWJJCCnDZ4ZsPQ/7sEYbY8eylMb/gsfPD+/HvkBh8PCK37Z+BwKJ
         Uq1FDffiRS1xf+ovMxQBIZfBxWsKYvxiY3sN9aFstrd9p6BDjxsD1j4bOclj6pBjsQ9r
         Yr3o1jPQYP60bMittGWs6RxLf/8zlE08AYy1Lvoa0HBAIkR5ZDYMi2HP3GZ2iztqKw1l
         nnRgXnwxjxrczuUQPWXJbnQk6efbZtq/4xx8xALj3oXGg+F0otPvE8KX/u2J5utlemJe
         wHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=Bg682UXoUe4mQYKZbi9Mhjl7PY9ajACV5lnMcREQlHs=;
        b=PR68t7c9SE2f9EX/1Szwcapmdl9UaMKIIQZZv4a/LZWO33O85MU+raci3O2ccmRHmq
         tMwQs+EK6kJaXXrzc+sL7WdsaVx5ZNTiC6lX0KsbFQ/cvXFSZp/9WXV4q++VbUXQWXhC
         s7mTJoD2+TpPs0gw92fJZaNqvYvdEp1bzTKUnsm3n7UVeNtyMehN/YC2FSPYgbVIAIZc
         6S4tsN5QEuDtFAZhbD6kEONLzJlVgVdYdjfSPAilh8b/UwhX9+Bd+UmdwsccAOz/SQwa
         qr/1IyfaB/U1ZecbBUzwQhZv1x3rYXHXJqWM2C5IDx+uMZalY7CMXQ7twe5IjORZZxSh
         2tTQ==
X-Gm-Message-State: APzg51Ae08kBdZQPGUiLYORZgc3mFtbOWBVZC8jObgouWWDatDev0R1h
        B3Xz3J/6PX06wlttc529KL8cxqGf
X-Google-Smtp-Source: ANB0VdamfQ+zkxVxIpnardyurfhsNLHHoIVA8uB4zo9s2EzWMFNvjS2iMq03cNinDozbvX48BAoeHQ==
X-Received: by 2002:a1c:d0c8:: with SMTP id h191-v6mr13161wmg.155.1535582225576;
        Wed, 29 Aug 2018 15:37:05 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k13-v6sm3128936wrq.7.2018.08.29.15.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 15:37:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] chainlint: match "quoted" here-doc tags
Date:   Wed, 29 Aug 2018 10:57:21 -0700
References: <20180815184552.8418-1-sunshine@sunshineco.com>
        <20180829094532.41497-1-sunshine@sunshineco.com>
Message-ID: <xmqqzhx494vk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This is an extract from v3 of es/chain-lint-more[1] which never got
> picked up. Instead, v2 of that series[2] got merged to 'next' and later
> 'master'. The only change between v2 and v3 was to make 'chainlint' also
> recognize double-quoted here-doc tags. This solo patch makes that change
> incrementally atop v2.

Thanks.
