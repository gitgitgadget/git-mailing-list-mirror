Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7625E1F42D
	for <e@80x24.org>; Tue, 10 Apr 2018 01:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeDJBuo (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 21:50:44 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55378 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbeDJBum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 21:50:42 -0400
Received: by mail-wm0-f53.google.com with SMTP id b127so22865681wmf.5
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 18:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0UTCfWBn/s4lnMLbY2Exs2DgN++rEnmIgdrQyW7nMRw=;
        b=G437nE7DmFvMzuYJKdTf68PIjYwD8lm648fnlVTtKjKsRUurMFpiSxGuquq7o0vbzE
         pYwFd+LAeite6BwgjmHAHCeptoINThXDQI7wYY/XjrW3bFv1mBTzKl2wDbmHkmIlxBQQ
         yjtqrAiawfntSSObWjYYPd6OOlMAWVgZ/piubvsQ0E/sba1/ZrtAAXSJAXaJTzj041CO
         AWve9oA/hh1zw7/YMnof2JfM5Zn0DrwdT3EC04UEyO6lQGAc8lT0qPcUvFIubT6ufFBC
         ow3UdAhF6tn2jdO5SPYk/1SMwtXHUsCiNk8AS5rJJ6hMzAPVUwlRR4a8guSh7r2o980E
         xeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0UTCfWBn/s4lnMLbY2Exs2DgN++rEnmIgdrQyW7nMRw=;
        b=AWlH8+QwIMvbmGBwqy9gcIZQlUWdf81uotv/XS3iRZpKZCoxg/1a4tiqmYtrUW5dly
         MjKfIbC1CyZRCkkJ7PAdo19ahejJYHxpJdmLtpOfHxDfAd7oI8HcgS69VsyytLayMj8B
         2OV7XeucA/D+0uIcd9bT1oKFZySzEEul2ef2DLe8fR0L8NRoCVCJx+dABIiPQ6bmRO+b
         RFati9Y2inFH6UXVFqKKEqqKyHpkH+XDh0eXwkYkwQZiQrJcwrTlHZ0sS0vAXAIxQwFB
         oMca5SMyAYTF/AqAYL8RXcyzkgOMr3SAprN8XpXz+je4TixX/ik6ktjNyTYKlmTBWZfd
         /KOQ==
X-Gm-Message-State: ALQs6tCdYFcWYzmIUhFtmKXBVnGBXyIy88I5G5Y+0ldqy/j9sP/31fJO
        cG4ekmhfmlO1jShvheJcqyI=
X-Google-Smtp-Source: AIpwx4+JZSpDQPyMvazVBaxAiklaJBAp+A1rJnem/2pfaBvdy/mm4qkikwCVnw7sYHB1KNvTHSdu0g==
X-Received: by 10.28.234.26 with SMTP id i26mr139958wmh.104.1523325041345;
        Mon, 09 Apr 2018 18:50:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w69sm1189063wrb.94.2018.04.09.18.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 18:50:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net
Subject: Re: [PATCH v6 1/3] builtin/config: introduce `--default`
References: <20180306021729.45813-1-me@ttaylorr.com>
        <cover.1523319159.git.me@ttaylorr.com>
        <20180410001826.GB67209@syl.local>
Date:   Tue, 10 Apr 2018 10:50:40 +0900
In-Reply-To: <20180410001826.GB67209@syl.local> (Taylor Blau's message of
        "Mon, 9 Apr 2018 17:18:26 -0700")
Message-ID: <xmqqo9ir4yof.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> For some use cases, callers of the `git-config(1)` builtin would like to
> fallback to default values when the variable asked for does not exist.
> In addition, users would like to use existing type specifiers to ensure
> that values are parsed correctly when they do exist in the
> configuration.

Nicely done.
