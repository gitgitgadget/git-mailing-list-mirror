Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62E520357
	for <e@80x24.org>; Tue, 11 Jul 2017 00:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755040AbdGKAHp (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 20:07:45 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35942 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754956AbdGKAHo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 20:07:44 -0400
Received: by mail-pg0-f46.google.com with SMTP id u62so57145683pgb.3
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 17:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=2Jxfnx3FBajg75Fp0CnbqfO5GfpsBe+nTnyay4+lt5w=;
        b=YEBPGxfPdZSJqwV7XcgF6j77niEDK/a5KEQOAMrzQB7YEPKV2JU6nWgksB0sBDsegs
         P79QgelIAEzhbhCEyxRMDL4JTlZkSC6Ar4rQUL0ruAw+1/Lc40KiC9fan5yYzOdHp2PQ
         oUxc9KlJ5AvsExTCIn2ABelnVBcFd9yJRY7lcqC8MzB923YGQ7fuNnp+4y4KmzQFpHRf
         iCnzMU5htca/y+9zg1TFQUB1ri8eYxD9okXdJ3JcSOJYwUucY+LdF0o27c+LAv2CQfgG
         1n+Ejwe6E/u+guV8VXyFA7shoM/gP3fgByj1W9XZpiKP+hi3O803+mQuQlnZXK4TByrW
         ZOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=2Jxfnx3FBajg75Fp0CnbqfO5GfpsBe+nTnyay4+lt5w=;
        b=pvRO4+98AxdZT+Um3uVadiIUZTAUYmmhFVORG04oU9gnqOzFEXrFKaeKkf3F767P67
         tP/btVoOUEAxLzDfjwPNYq8ger2eDZXpfDyJFYCPTOYU2ME/qDYHdl32TJT+6tVp+9vY
         J+OISp83TecuhTI6xEvJJoB/t8Y1tpvh64fcJavj3C8x44SHCgciI7P3pipB92FWyN3y
         3xufR9S3EDjt54Q/Pvkr79kNMwHQkOn6hKG1ciR4i/qA7GyiLh2pTlzk2Pv+bBuX34Q/
         OdWcBrurS7huXqjDbXuCi0CpULjJ88jlrOB5YAoOC6qg+0bGS9J1ux+/Tgt+oXq1KxKX
         3hAg==
X-Gm-Message-State: AIVw112PLfa9elHy58G5iix776SWqTkBlEWm6kb33HG2B15aboVeuK4B
        FL5FyT2Uea5MfcxDeeQgAebAbSdma4tn
X-Received: by 10.84.232.74 with SMTP id f10mr20442946pln.154.1499731664247;
 Mon, 10 Jul 2017 17:07:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Mon, 10 Jul 2017 17:07:43 -0700 (PDT)
In-Reply-To: <20170711000540.4tdytyiit27trmzo@genre.crustytoothpaste.net>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org> <20170711000540.4tdytyiit27trmzo@genre.crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Jul 2017 17:07:43 -0700
Message-ID: <CAGZ79kbWQT9n9BAmoHQsZfaEC5GahgOfOVAQGTSGWU1Np8=Nkw@mail.gmail.com>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 5:05 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Jul 10, 2017 at 09:57:40PM +0200, Johannes Sixt wrote:
>> It's a pity, though, that you do not suggest something even more useful,
>> such as C++14.
>
> I have tried compiling Git with a C++ compiler, so that I could test
> whether that was a viable alternative for MSVC in case its C++ mode
> supported features its C mode did not.  Let's just say that the
> compilation aborted very quickly and I gave up after a few minutes.

... because we use reserved C++ keywords such as 'new' as variable names?
