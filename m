Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86A741F404
	for <e@80x24.org>; Tue, 17 Apr 2018 03:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeDQDXX (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 23:23:23 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:37420 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeDQDXW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 23:23:22 -0400
Received: by mail-wr0-f172.google.com with SMTP id l49so31266893wrl.4
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 20:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uAR8BXAUAj8Am1Jp2XWQZqRYs2/tJ+W2WNRrjlXMKxw=;
        b=gJ9FuoIpywBkVr8+kmLSdGExdY6iBB74LEZYV5B/WIuIRMA82Uz+Zl3m9Lvdl5yo08
         gRGiVBVscDKBkc/laweqjyw9cXXpzSWxvjwlYgUoI3BeUCuxlMChn+6xeVKkVJ+99JBj
         i++M4BZQ0c6tN4x4AVt2/aO1XaTgR1QboCfpC+cmRrR+LYsv+RIdL8HMaQK4gLswq2tl
         R0IAf8SdGBoCk+QzpWfk2XJWs2gREPnZWH4BzEGK+4Kk80v6Nu5/Ru5iFOPf2yApiVhu
         5Z3PMxnnXmGZmxcK1pj5igX4mFi9n469mlBRle+TWHgj47fLKcja6cR8u9GpYDSvrJ/y
         WBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uAR8BXAUAj8Am1Jp2XWQZqRYs2/tJ+W2WNRrjlXMKxw=;
        b=NxkzR2V8r1V/GHTaN9frOfyL8jrWQVSWEd/5hFJ+ZF7/6p1blnyzZoKeaJKBwu6WcS
         dT0R+zATMXMcOvLMdZdR0QepvfBH3hXLNE+nD3WLFqXudmLqACR0QHClCwtzs8bxUdj5
         4uiuCFu8nW8NjnrIB5qbO225Bcqy3wgB7KX68PdNJzZt1DXSCA4K3CfF7N7bLxWV6oGS
         ia5Xn1uVYSR3oEvwW2QtqUiDER7qkaEzNanZ0fpCOfdEKfRwNITk+FioJppJORzOw72i
         BEqMZA72GsFjc1dOqnXdGilvXtWde0EEPOlxIn+/lhYeuZGGc4p1GnBNZf4ioRbFQeLk
         p0vg==
X-Gm-Message-State: ALQs6tDBhSiyHpFTq9fa5Spz8/wRHGpuLcRM4p3uD4lLhy0kobNfzQ2a
        UGAp7rTihtoWDpLT3tY6yCk=
X-Google-Smtp-Source: AIpwx4+fOKkhxG9LS+XJOJyhlr3RMItPvEBV8sarsnuOw/e+PMsLLlPo2Fib0xTJjn0JuO0oH09e9A==
X-Received: by 10.28.0.84 with SMTP id 81mr406585wma.31.1523935400976;
        Mon, 16 Apr 2018 20:23:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 185sm13409243wmj.46.2018.04.16.20.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 20:23:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 2/2] builtin/blame: highlight recently changed lines
References: <20180416220955.46163-1-sbeller@google.com>
        <20180416220955.46163-3-sbeller@google.com>
Date:   Tue, 17 Apr 2018 12:23:20 +0900
In-Reply-To: <20180416220955.46163-3-sbeller@google.com> (Stefan Beller's
        message of "Mon, 16 Apr 2018 15:09:55 -0700")
Message-ID: <xmqqfu3uv7mf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Choose a different color for dates and imitate a 'temperature cool down'
> depending upon age.
>
> Originally I had planned to have the temperature cooldown dependent on
> the age of the project or file for example, as that might scale better,
> but that can be added on top of this commit, e.g. instead of giving a
> date, you could imagine giving a percentage that would be the linearly
> interpolated between now and the beginning of the file.
> ...
> @@ -323,6 +324,7 @@ static const char *format_time(timestamp_t time, const char *tz_str,
>  #define OUTPUT_SHOW_EMAIL	0400
>  #define OUTPUT_LINE_PORCELAIN 	01000
>  #define OUTPUT_COLOR_LINE	02000
> +#define OUTPUT_HEATED_LINES	04000

How about calling it OUTPUT_SHOW_AGE_WITH_COLOR or something like
that instead?  Anything with "AGE" in it, if that is what you are
trying to indicate, would be more appropriate than "HEATED", which
does not convey much meaning to readers unless you explain what
determines the temperature in your mind.

