Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CB8F1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 22:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbeHNB0J (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 21:26:09 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44563 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeHNB0J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 21:26:09 -0400
Received: by mail-wr1-f41.google.com with SMTP id r16-v6so15553743wrt.11
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 15:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EKFjVo1UuT9jDG7NTw7DFPJydHFNbPovyxE5PPQ1QSg=;
        b=UetPbie0puV/i+YM8x+CETKEIlgGM6xLunPbfMhLazojI6WoNZrit7KQ/qCgYljmOL
         WgCvcITMWKcWz5T9sJ/ox73VIvxIRSZaUJ1ghV+7RFB3bOXUcGR/fW2nH3AZ7d1fI2KL
         h3AsOzAKsyFaHHblm8OF+c/+hq1z/X8eMGXMMqAqq19QTxdCACCGO24ns7TNJTQIVoZ0
         KOp5DXhMyF/bepeufb1j5c+HVoog2QKEy59Up8z7gBg1fZj8ubvawu+4cSxv/TXTsuRe
         RWWvSyebTzPQbFOf3y2kJUuIoiaVbY/Bc6AS/GYY1APA9CAlkvBjrRXPaedS3rGRXLC/
         CQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EKFjVo1UuT9jDG7NTw7DFPJydHFNbPovyxE5PPQ1QSg=;
        b=NVbNqEWcnBocPiaC6bjkWJfKMoyF2wD/PBz+P4fIeJQukkuz/HN5hKRzGzZCUJcc+R
         NE9T3rcbMVpnAzzzpYq/ILbBZM2ygMkYvMRzjdfmAMx2Myjn9Q9+5DZ6NbiRkMQm1DH1
         OhcOA4pp01VhfnTEZa03xzRzxjKxz7xiOL0ZnNql1dtqTROP7ZFbu96w2nzx/fgGpfy2
         2ybuBs0uY2KtZ0PHeYPX2PKvCZlK8bfqJrhOBcUugC+y1MiU2k35X86NVLCOyOgJWYHZ
         FB4OPxdQEPpMsG3BufLRoxjfdbrfk6PPt/phF8yqL+/uB+atV3z0Dtzm940VlBWxLwjR
         0DwA==
X-Gm-Message-State: AOUpUlEp4LbmQGBDYZFF8Is6sGYvHN/SLznt8zw8bImDuQRgHNEaz0Rl
        Nv1rgSBrBFLMtX32uHoMfbk=
X-Google-Smtp-Source: AA+uWPwy9hqd1TynJmo6Qzutk2sG6QC5jp7C9OY4T0HZgpYB70rBdrAxmed+ymXUpDoZyeSYkSb7ww==
X-Received: by 2002:adf:f9c9:: with SMTP id w9-v6mr11868152wrr.105.1534200112321;
        Mon, 13 Aug 2018 15:41:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e137-v6sm21005700wma.20.2018.08.13.15.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 15:41:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Ben.Peart@microsoft.com, git@vger.kernel.org, peartben@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
References: <20180804053723.4695-1-pclouds@gmail.com>
        <20180812081551.27927-1-pclouds@gmail.com>
        <20180812081551.27927-3-pclouds@gmail.com>
        <20180813192526.GC10013@sigill.intra.peff.net>
Date:   Mon, 13 Aug 2018 15:41:50 -0700
In-Reply-To: <20180813192526.GC10013@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 13 Aug 2018 15:25:26 -0400")
Message-ID: <xmqqk1ot3n4h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I can buy the argument that it's nice to have some form of profiling
> that works everywhere, even if it's lowest-common-denominator. I just
> wonder if we could be investing effort into tooling around existing
> solutions that will end up more powerful and flexible in the long run.

Another thing I noticed is that the codepaths we would find
interesting to annotate with trace_performance_* stuff often
overlaps with the "slog" thing.  If the latter aims to eventually
replace GIT_TRACE (and if not, I suspect there is not much point
adding it in the first place), perhaps we can extend it to also
cover the need of these trace_performance_* calls, so that we do not
have to carry three different tracing mechanisms.

