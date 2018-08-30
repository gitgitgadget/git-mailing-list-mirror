Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2451F404
	for <e@80x24.org>; Thu, 30 Aug 2018 17:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeH3Vlh (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 17:41:37 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:39903 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbeH3Vlh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 17:41:37 -0400
Received: by mail-wm0-f50.google.com with SMTP id q8-v6so2849728wmq.4
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b1uAT04l1U48Q5wrfRYPz6ojnBGKq+PoE5WYtFPfg1A=;
        b=uOhyKar4OfbcsA3Bd7Fz29kG8aSnaB+IzFyaH/hWDiJ5Sp02hYssobDoMP24AFIzyY
         S0op7ZKFXotOaKAB2JwHV3wWlf0/nar13TU6MIjUlIZXYq/3ZEdf7i7VrLEZFSqzwffL
         NcZPIigd61aSzaA7fUC3bkLCN9NIyAbxYQBKRGU8TTMmrTP/V7tPV/d8F/G1V5lUXVTF
         qU2dWhMntARFTX29dnU+bF1fo0MfTVRno5cE/0Ch6/6fM9IDuObX9miNuJ0W57gzodsr
         hmNG77bUjP4A9kY2iTkamu21uvARSzjI76rKSddT5En06wsRz0cf2K0iClZddTkpTYvV
         B11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b1uAT04l1U48Q5wrfRYPz6ojnBGKq+PoE5WYtFPfg1A=;
        b=Vc2dZ8CfjP1elUAfSOdKh/nCBsBPo5XGhiGwJk2IEUBgUbi6rT8KE5Yn5BoxBE4PFa
         8Kk4Fpz3K2odkjDQRiLZDE6ScMad+fgJNExvAg6bqZPoROQzhk8igXHfQnXXFB9boEJ0
         Jsb5nTKcDbDtbf52hgR0MY4bpVia95Bozy1yB63YCnJGGS25FVOO4Yj1L81soeSNiagi
         AnckC3WMcIcttKimJM2iv1gT5cM3VvpeA8UCFomor0GjDJThBXOAvR7WJ8kSVlXm+Ovz
         ExMchiXyqRJ0AE91SRzSePCGFi97GF06l2tCGg4lQqiyEsyQBdy66ExF0Pln1E9laIcK
         Ge4A==
X-Gm-Message-State: APzg51DOrX00WyDy6S33yPp5mdKEXviQ8efRFRJrl5DfzpI5PCZyi0CL
        gMW+Zf0ev3rBcWCp1WwZu1Q=
X-Google-Smtp-Source: ANB0VdbBkXh+hJz9vwfagEOW3jG+89nFqYyicwBgiEev4CSIMm/CMq5spR3lx7XDzCnkuViv5NkZDg==
X-Received: by 2002:a1c:3b56:: with SMTP id i83-v6mr2398426wma.66.1535650702849;
        Thu, 30 Aug 2018 10:38:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p11-v6sm11727543wrd.74.2018.08.30.10.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 10:38:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jann Horn <jannh@google.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/5] t5303: test some corrupt deltas
References: <20180830070548.GA15081@sigill.intra.peff.net>
        <20180830070932.GB15420@sigill.intra.peff.net>
Date:   Thu, 30 Aug 2018 10:38:21 -0700
In-Reply-To: <20180830070932.GB15420@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 30 Aug 2018 03:09:32 -0400")
Message-ID: <xmqq8t4n69gy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +test_expect_success \
> +    'apply delta with too many copied bytes' \
> +    'printf "\5\1\221\0\2" > too_big_copy &&
> +     echo base >base &&
> +     test_must_fail test-tool delta -p base too_big_copy /dev/null'

Would "echo base >base" give us 5-byte long base even on Windows?
Or the test does not care if it is either "base\n" or "base\r\n"?

Just double-checking.


