Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8E4D1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 20:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeBEUzZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 15:55:25 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42561 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeBEUzY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 15:55:24 -0500
Received: by mail-wr0-f193.google.com with SMTP id 41so29661893wrc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 12:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AlY1h+Yg3lFEYVKWHx+5acGAIJ2IVzaBrSfIA74pnRo=;
        b=S4eaI2WChRj/6YFGFzzjkpche77Ki9yxvFspNdb0/FeT9X0K6lP9MT+iAhYcx0wO+J
         pSy2kYIPQxYLnOiGNR71+olZ+6b6ud8VB4P65L10pU0oQUcFUJL/YjAQDYP1C7pfzR1t
         AJ7upwolFpOsVCi2pjhnkctgBIImC6hPWIjB0Zy2ChT6fNSzlKo3v6GoYQQOoFgyM7UY
         OgKS79D6fM2p6b/3gsrjw/Mbjo8Jnu7IL7BZkZDUGbgtsBm5cwS1PJtDMpUsAvQg/FPj
         8C1BKWqtvDIEVohUnP/0aKCxRbEPtyVYEUFVYIR/BAfxyXahjKRk3MXRoh9piJFysxJe
         sqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AlY1h+Yg3lFEYVKWHx+5acGAIJ2IVzaBrSfIA74pnRo=;
        b=N3i+fEUyyEI7hcXDuvYfVDiY2ZR1d7Mbu/SJ51zQowEaL163ozK24W5kY81Q10H0N+
         Vqbd8+MWksSP8FVq36YP6qNinT/Tx7eyEVQO74ptqT1RDshUWdoAqwgCxpRRWhH0yuy1
         Xks85qu57OEIe8hMWw7vkyudMZjXnfXyMQ3gocIA8YKZfQwVVs0yPgvmDD28C/K9wtkn
         wPPeluNFi0Ok/Xi/5EElpfuEE4qJ6tI/fXLQGt9ybwVYnnFRpPMAncxuMxPAajASe4ui
         mQ4e6MALXO0ZkXS90+fOjA+cYrGHX2MF08jnZ05DdOH9l2LX/OvQQR4/3MjHXaAFXMCP
         +isA==
X-Gm-Message-State: APf1xPAsdL5iiptDYHN5csUy7M0Bs+ro7JkdllIiujJFEEbE2hXjpMJC
        cCHzGjP8wo6o9teF28Vd/5oHpkqG
X-Google-Smtp-Source: AH8x227KYqKC/P6YDd4at841lHvoNfmySXkMlFHMyJY1ydtBe+Basc/E2KIAgnytKJ569N5d0Is3RQ==
X-Received: by 10.223.162.142 with SMTP id s14mr76005wra.175.1517864122730;
        Mon, 05 Feb 2018 12:55:22 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 7sm7184923wmq.42.2018.02.05.12.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 12:55:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, bmwill@google.com,
        avarab@gmail.com
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to the untracked cache
References: <20180205195619.31064-1-benpeart@microsoft.com>
Date:   Mon, 05 Feb 2018 12:55:21 -0800
In-Reply-To: <20180205195619.31064-1-benpeart@microsoft.com> (Ben Peart's
        message of "Mon, 5 Feb 2018 14:56:19 -0500")
Message-ID: <xmqqd11j9mx2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> The untracked cache saves its current state in the UNTR index extension.
> Currently, _any_ change to that state causes the index to be flagged as dirty
> and written out to disk.  Unfortunately, the cost to write out the index can
> exceed the savings gained by using the untracked cache.  Since it is a cache
> that can be updated from the current state of the working directory, there is
> no functional requirement that the index be written out for every change to the
> untracked cache.
>
> Update the untracked cache logic so that it no longer forces the index to be
> written to disk except in the case where the extension is being turned on or
> off.  When some other git command requires the index to be written to disk, the
> untracked cache will take advantage of that to save it's updated state as well.
> This results in a performance win when looked at over common sequences of git
> commands (ie such as a status followed by add, commit, etc).
>
> After this patch, all the logic to track statistics for the untracked cache
> could be removed as it is only used by debug tracing used to debug the untracked
> cache.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>

OK, so in other words (note: not a suggestion to use different
wording in the log message; just making sure I got the motivation
behind this change correctly), without this new environment
variable, changes to untracked cache alone (due to observed changes
in the filesystem) does not count as "in-core index changed so we
need to write it back to the disk".

That makes sense to me.

Is it envisioned that we want to have similar but different "testing
only" behaviour around this area?  If not, this environment variable
sounds more like "force-flush untracked cache", not "test untracked
cache", to me.

> +GIT_TEST_UNTRACKED_CACHE=true
> +export GIT_TEST_UNTRACKED_CACHE
> +
>  sync_mtime () {
>  	find . -type d -ls >/dev/null
>  }
>
> base-commit: 5be1f00a9a701532232f57958efab4be8c959a29
