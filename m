Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A5920248
	for <e@80x24.org>; Sun, 14 Apr 2019 10:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfDNKdn (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 06:33:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54640 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfDNKdn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 06:33:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so16735364wml.4
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 03:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5hE3zE1mDc/MowbWwaHwvG5INIeR5VdtbMdB9brAbec=;
        b=u1Taci2cnrZXqA0twoPiuOwlcEMJ9IBkZq0kwj10ynYfpnpQLgDAKSI2kK/Xg5abp6
         rs1Mu+7sThTY2g6eVYMMwKBOWZ5SoPVCwb2uWLEryya/jaUFNsJqqDkMuq7oTEBLfY9z
         lfYlSWv+7MJwGvluH0DUdDmoFsDfhe9SEKsOJY4cYoGk9lLXSf1Aaj/3KLjpgRTRQaEU
         35BY+7NQSQJupGTpn8Ro3yelRPhyokA0teyuQudCK8L+/+kSo22KLMObgduyEye+BHv6
         Nn4lIHlEmMk1ET/k2ewn+FwdZRthjown6Mm1daBW9oYmk6xqCKD+yoQAQNoI1LFLgTCV
         dA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5hE3zE1mDc/MowbWwaHwvG5INIeR5VdtbMdB9brAbec=;
        b=KNSWaOJS8a+FR27gIXc9SS2nBen2F9/gV9oZkV7zg14tz5KFihsQjitGAN96+V6kcd
         pf+/KZB7PjA+r2/PM5k1BqhriVBDTdOQdqFIxGmrYrSLYQIn39WMRh1uZn5dW3G9BPPH
         Z8VG9zFZJmJCcyqTI6BmsdcC3XZnEfdfgCc1Y9Hv7n1e/voz3iIf0WHHI/JEz2vh+To6
         kZsVxGm5XES1zdj3B2Ufv4JKD12Rl87TktHZQRUJeN10MordEQxG3nNisKthGdd8Ymr1
         iWHWCx+5CNRXxzC437yfcF1gyhEFkIEtXCNBDlCwCCzI2Mc+LRIoZm9grFTOgy1gNtir
         nHgQ==
X-Gm-Message-State: APjAAAWu5frcSAOK13Bq+52xcAo87FQ/ctk4kYxeu3SN1PBRx1dp9nw2
        1Ezfy5NYSdUSjgFm4PF9rqs=
X-Google-Smtp-Source: APXvYqw1APWvmAMv6RzGM/77JFQ6JHsnHLOFn2IOaRMbso8YTy25k1lqpDTgG0vxCCdUTCKjHWxczg==
X-Received: by 2002:a1c:1a46:: with SMTP id a67mr18405475wma.21.1555238020668;
        Sun, 14 Apr 2019 03:33:40 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id f128sm14515646wme.28.2019.04.14.03.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 03:33:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org, gitgitgadget@gmail.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/2] archive: replace write_or_die() calls with write_block_or_die()
References: <20190413013451.GB2040@sigill.intra.peff.net>
        <20190414043409.9547-1-rohit.ashiwal265@gmail.com>
Date:   Sun, 14 Apr 2019 19:33:39 +0900
In-Reply-To: <20190414043409.9547-1-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Sun, 14 Apr 2019 10:04:09 +0530")
Message-ID: <xmqq7ebwx4e4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> On 2019-04-13  1:34 UTC Jeff King <peff@peff.net> wrote:
>
>> What is gzwrite()?
>> [...]
>> I think it would be less confusing if this just factored out
>> write_block_or_die(), which starts as a thin wrapper and then grows the
>> gzip parts in the next patch.
>
> You are right, it might appear to someone as a bit confusing, but I feel
> like, this is the right commit to put it.

Often, the original author is the worst judge about the patch series
organization, because s/he has been staring at his or her own
patches too long and knows too much about them.  Unless the author
is very experienced and is good at pretending to be the first-time
reader when proofreading his or her own patch, that is.

FWIW, I tend to agree with Peff that the organization would become
much easier to follow with "first refactor without new feature, and
in gzip related step add gzip thing".

>> Is it OK for us to ask about the truthiness of this opaque type? That
>> works if it's really a pointer behind the scenes, but it seems like it
>> would be equally OK for zlib to declare it as a struct.

Or a small integer indexing into an internal array the library keeps
track of ;-) At that point, truthiness would be completely gone, and
the compiler would not help catching "if (opaque)" as a syntax error
(if the library implements the opaque thing as a structure, then we
will be saved).

> It would be perfectly sane on zlib's part to make gzFile a struct, and if
> so happens, I'll be there to refactor the code.

We do not trust any single developer enough with "I'll do so when
needed"---in practice, it will often be done by somebody else, and
more importantly, we would want anybody to be able to take things
over, instead of relying on any one "indispensable contributor".

If it is reasonable to expect that things can easily be broken by an
external factor, I'd prefer to see us being defensive from day one.

