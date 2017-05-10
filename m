Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA1862018D
	for <e@80x24.org>; Wed, 10 May 2017 05:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbdEJFzx (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 01:55:53 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35316 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750986AbdEJFzw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 01:55:52 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so2595311pfd.2
        for <git@vger.kernel.org>; Tue, 09 May 2017 22:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4BDWIF68EsPrF96JS/y9YdhSLHCAX6ySCKndrVa8YHI=;
        b=HiqoYPhX6uf2yYwnwWeNEh21VIGJVdZ7WxYsw79lRkoNMtAgb/cRZDG8GusDOkqaYk
         6VV5cmNbssUnk4KSrkALFM335kAyryJfKEnDbE2swD+zwjYILLt+9iQEojkKObU/AV44
         D2aslln4oLt7fN2FrFILZgjyHD+qpRIqtMYmcesuxKoLTj2yeh40mN5jj9WBMBkAtP8c
         sAoqI4NJ7WYuOvzML9disoY5uJAin8huTUffrK+5O3HgK2Q5vO4B+I0P0CKaqM9POXtC
         fY9rZU8UvkWmp9Ha/Fz9eMTLj8tP2Pq/Pu2/JMpJJooflTbu+a+Ln89wAbqvwEWTYAW+
         k+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4BDWIF68EsPrF96JS/y9YdhSLHCAX6ySCKndrVa8YHI=;
        b=X8ySu4zbCFpWWAV7UxQ6ypAXLf/p06I/D9tC/p/zgeXvxiK3sfH4K0S+DZkUCFTAkx
         0Buga7/D2VWXGNEs+HS5yMGBY69H13RRO3HTf5jL+2GLKr4cNo2//8LcNE9SLrwlSL7t
         22g7Q4Q+W1dUK5TlyaXbOGNBO5eT9ABhApv955l+C/dHH1hacnlH+rhpL1Ft0dSt5RS8
         oy+q/N2An1gaKXed2XeWgNUg3l8jVu1UcVVYaLe97ANSdJqmNBOCojYIfCNduJaRfdoK
         AW2bmQ9xmEhyvAanWOZc72yN4E9Z+xsvnyPfvEeXJhL3vX0R9DuQSIoVg53U/vzy/vzp
         wm2A==
X-Gm-Message-State: AODbwcDOCSI5E6PLst6mXFCoAj7v77KDMOEajBecEn2zprRvYLWtFYK2
        GKElKC6RjF4HAszZSIM=
X-Received: by 10.98.71.214 with SMTP id p83mr4186542pfi.236.1494395752243;
        Tue, 09 May 2017 22:55:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id z21sm3190488pgc.15.2017.05.09.22.55.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 22:55:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] pathspec: convert strip_submodule_slash to take an index
References: <20170509191805.176266-1-bmwill@google.com>
        <20170509191805.176266-6-bmwill@google.com>
Date:   Wed, 10 May 2017 14:55:50 +0900
In-Reply-To: <20170509191805.176266-6-bmwill@google.com> (Brandon Williams's
        message of "Tue, 9 May 2017 12:18:02 -0700")
Message-ID: <xmqq60h9xnkp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  pathspec.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

This conversion is not wrong per-se, but I wonder if there is a
practical situation where we want to validate a pathspec element
against an in-core index that does not represent the index currently
in effect (aka "the_index").  I do not think of any offhand myself.
