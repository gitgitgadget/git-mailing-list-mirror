Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B9D41FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 23:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbdBLXtT (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 18:49:19 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34561 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdBLXtS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 18:49:18 -0500
Received: by mail-pg0-f68.google.com with SMTP id v184so8086361pgv.1
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 15:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2yBgGgPLBuhwtzS2W+fnKplxHy4pBW+GdzehFrQVrt8=;
        b=LM3M+i3mWMVw5ZduOzfddyoXqARMTLzS29qW9e7VD2wfIkQdRAY6bOjKFf+pzuA492
         2qqAclbLJaDhqJB9R/yvxGj9Q69IXFTuTT9BcLN/1GopCwzOMZPzfne3ll42aFORY0Ko
         PFuLfIvkYe1i+5BdU8j80I7fyiwjPF8YlKONYFuKGZJd5EFJrDEMOnmZ47gbUPiSG+Vv
         J/bAoS7nX1mUTYW9ycoTAE2f9ogP3+ebGUlR5P0ms4XrvxRMCv/R0UECgDh3shS9UFdu
         CENg6lYtMyCDEFnAfVNaDO3CMuknFEeUWAdJSTUmgsR3UKZVAVwSR6W7zF5jrg0CqKHM
         PByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2yBgGgPLBuhwtzS2W+fnKplxHy4pBW+GdzehFrQVrt8=;
        b=gKblChPdBum6VPk1cVOcQgTuNOgxTAiehF3Hiqpi3lfYlR+9gXeA0beTgtVRnAhbSX
         fecR07qwyqiY2gkLtSx4ozuYfHmi7yobneYdX9ZGmUjEg9NkcAQCzEdfOaG/ST8MzVe0
         f4IY3V5WqwTo+M48lVuHf19T24s0ZQeluQXE6IXKEqhSnsWyxH/6zR4Zbsl4Dab7e46b
         AkPDBEwhkFtDVhh11LcnlTWnprGIpiAb0/wmIW0xYJA4FXC2qWB6/NUVqxoIDwZusEi3
         OYkVvRn9dW4wPRgFLNVmAI6AHsMGUI1fPzY4i1HRSIUos7oDsTvwF57TWyvpvt2UUe0I
         qLYQ==
X-Gm-Message-State: AMke39kQOwOIPp+D3XDZAFSzmP9lQythyyhqDYCQnyNNH0NkwZwQacbbk0c+7TpJwllJ6Q==
X-Received: by 10.98.35.207 with SMTP id q76mr22726399pfj.112.1486943357603;
        Sun, 12 Feb 2017 15:49:17 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:644a:2999:a3b7:74ee])
        by smtp.gmail.com with ESMTPSA id l25sm16817734pfb.24.2017.02.12.15.49.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 12 Feb 2017 15:49:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: print an error when declining to request an unadvertised object
References: <1486747828.17272.5.camel@mattmccutchen.net>
        <xmqqwpcxlwpv.fsf@gitster.mtv.corp.google.com>
        <1486934007.8517.10.camel@mattmccutchen.net>
Date:   Sun, 12 Feb 2017 15:49:14 -0800
In-Reply-To: <1486934007.8517.10.camel@mattmccutchen.net> (Matt McCutchen's
        message of "Sun, 12 Feb 2017 16:13:27 -0500")
Message-ID: <xmqq60kfezr9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

> What do you think?  Do you not care about having a more specific error,
> in which case I can copy the code from builtin/fetch-pack.c to
> fetch_refs_via_pack?  Or shall I add code to filter_refs to set a flag
> and add code to builtin/fetch-pack.c and fetch_refs_via_pack to check
> the flag?  Or what?

The fact that we have the above two choices tells me that a two-step
approach may be an appropriate approach.

The first step is to teach fetch_refs_via_pack() that it should not
ignore the information returned in sought[].  It would add new code
similar to what cmd_fetch_pack() uses to notice and report errors
[*1*] to the function.  It would be a sensible first step, but would
not let the user know which of multiple causes of "not matched" we
noticed.

By "a more specific error", I think you are envisioning that the
current boolean "matched" is made into an enum that allows the
caller to tell how each request did not match [*2*].  That can be
the topic of the second patch and would have to touch filter_refs()
[*3*], cmd_fetch_pack() and fetch_refs_via_pack().

I do not have strong preference myself offhand between stopping at
the first step or completing both.

Even if you did only the first step, as long as the second step can
be done without reverting what the first step did [*4*] by somebody
who cares the "specific error" deeply enough, I am OK with that.  Of
course if you did both steps, that is fine by me as well ;-)


[Footnote]

*1* While I know that it is not right to die() in filter_refs(), and
    fetch_refs_via_pack() is a better place to notice errors, I do
    not offhand know if it is the right place to report errors, or a
    caller higher in the callchain may want the callee to be silent
    and wants to show its own error message (in which case the error
    may have to percolate upwards in the callchain).

*2* e.g. "was it a ref but they did not advertise?  Did it request
    an explicit object name and they did not allow it?"  We may want
    to support other "more specific" errors that can be detected in
    the future.

*3* The current code flips the sought[i]->matched bit on for matched
    ones (relying on the initial state of the bit being false), but
    it now needs to stuff different kind of "not matched" to the
    field to allow the caller to act on it.

*4* IOW, I am OK with an initial "small" improvement, but I'd want
    to make sure that such an initial step does not make future
    enhancements by others harder.
