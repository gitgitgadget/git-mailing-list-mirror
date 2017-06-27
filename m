Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D62F20401
	for <e@80x24.org>; Tue, 27 Jun 2017 21:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbdF0V01 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 17:26:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35774 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753795AbdF0V0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 17:26:25 -0400
Received: by mail-pf0-f193.google.com with SMTP id s66so6234756pfs.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 14:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fxEenRz6oflbYNp97h+qbEKVecCVWX9/gPkcs6IxWVM=;
        b=gajj0Pvbu/ReNjVz2u3XNtoqNzUfGRrF+memna0kgDqGfIhsBxvKG1Bjk43JLTYXUa
         Fv7oMryFF1vtdBwIfzY/VTEDOhxxuzksiEHrwt4oI27q9LSuOc3L79KBGW//SXjlVbVL
         TXeTZnbz1xfdNtEYHaZOVk2w8l6k0mlI/ar7A6FIWeX4bKEtPygpISZZOxKvVFlkhM6/
         epETwUOuPMH6uKicnOHrFUkan+jyiT40enydj/6cCqfKsBCQUWAKSrkDWKK6S+q547R/
         8Bn/00zqhHcKD+Nxbphdccux3qqS+4gtqUsXf63nd1MZN5iFypMcFJlmogZ44pHeiPph
         XROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fxEenRz6oflbYNp97h+qbEKVecCVWX9/gPkcs6IxWVM=;
        b=siRB0u7tJAiNCqM/RfB00414qt859hnE7WlHhcksYPGhm/Gx0ZipYzwas4SBN6o9as
         Zw7Dy85niWv7eIIidN2E6uFfVcBbdAj8/QBmDWzmmDwrIAnK8HBanfxDBdSYeWhBPwZ4
         OAy8CCGwEUnyxjcZnEUU1kKPqwjVIw3C0PL7li1eBCYizH05CkeK0greinzFKP5V7+Hn
         K8mGkNoKV3NPcWOSbK7rbsV6YAk7pLTSIUtly6v0mIxxBxM9U8yqZ4hGScnTJT9c9IC6
         DD7mEXMyFVxBDiOffCkAS2UiFcdeETIqAitATCMCl0TvSMcmQk0uNJv9CUowTDBE/sxT
         awPw==
X-Gm-Message-State: AKS2vOyHsqtPzzWgjLbsXz2396PkIlkUPZe5esV/4vUnYavfZWGf+9IV
        gvL+dQD8iMp94Q==
X-Received: by 10.99.7.72 with SMTP id 69mr7087518pgh.136.1498598784802;
        Tue, 27 Jun 2017 14:26:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id w190sm349362pgb.30.2017.06.27.14.26.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 14:26:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v7 3/6] t0021: write "OUT <size>" only on success
References: <20170627121027.99209-1-larsxschneider@gmail.com>
        <20170627121027.99209-4-larsxschneider@gmail.com>
        <xmqqfuel1d9s.fsf@gitster.mtv.corp.google.com>
        <BEB23654-54FB-40B0-8C7B-E70D1E5BBCF7@gmail.com>
Date:   Tue, 27 Jun 2017 14:26:22 -0700
In-Reply-To: <BEB23654-54FB-40B0-8C7B-E70D1E5BBCF7@gmail.com> (Lars
        Schneider's message of "Tue, 27 Jun 2017 22:51:46 +0200")
Message-ID: <xmqqpodpyvep.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Correct! Sorry for the confusion. How about this?
>
>     "rot13-filter.pl" always writes "OUT <size>" to the debug log at the end
>     of a response.
>
>     This works perfectly for the existing responses "abort", "error", and 
>     "success". A new response "delayed", that will be introduced in a
>     subsequent patch, accepts the input without giving the filtered result
>     right away. At this point we cannot know the size of the response.
>     Therefore, we do not write "OUT <size>" for "delayed" responses.
>
>     To simplify the code we do not write "OUT <size>" for "abort" and
>     "error" responses either as their size is always zero.

That unconfuses me tremendously.

Unless there are other issues in v7 (which I am not aware of but
there may be somebody else slow responding), I plan to amend the log
message with the above, so no need to resend.

Thanks.

