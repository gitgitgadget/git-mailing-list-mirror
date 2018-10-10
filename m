Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA3A1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 02:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJJJjb (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 05:39:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50911 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeJJJjb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 05:39:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id i8-v6so3699721wmg.0
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 19:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=60gGFbmieufi+BFgZ+LUt9pTxH092pD+J+bOa0bNu2E=;
        b=IvMnScSySAUA3Y1MfXlsOlye8yT1jq6EecOw0VQIxl87YaCIU2241ljX/jRc7H2Yg0
         KpeSJohEholL3Kbzz4drTu82JfWa476WIvxutaPO0ygm/dNtxECWTHPPupk4Vu1J012+
         9mAYxa34tbbIK/kOMA79vibsCBfcDmRlP1L85REaFI5Ad9CjUl4FpT7lpdc0w4L/jW93
         TlKe7RZNRQKm2VMLuexUEhKep4xaM3l9FRyRF6szIWIP3CoqHNGpkgchCSflMxgKwUMO
         /zp3thZTBuoCyrMLb9sPQKKh48SgutxYI1DpzbXy9WZkclWMMuOogTu1wvmPe38NeZCz
         ygQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=60gGFbmieufi+BFgZ+LUt9pTxH092pD+J+bOa0bNu2E=;
        b=VgDa0XI95OqTnHHdpFNv3rXMR3QJRDKB+9+sBXg498VmG2jzvQadz6KAvs9sQLQKTJ
         caymXNDvAKsR/i/OCz5z3376j6TDZexPsKC65Nfsrxchdnh7DLOCgR+ZMQc2qQV3jz2D
         rBZwlz9inzeF5kjL2gE9KGfyf0frwAyn9Dglev33zQiKDmaO1bR+lOSJyT/ir5c1Tnw0
         lxa12VXfPo1ehta3EAXYX2yUmie/a2gnb1n6vNs4vEFioxRFDCo6moAICMc8MvFDRIRj
         XxPuxGJkk6biV9MhBJzsdkcDFEeIHp/UncqgqmJYhYQ9V6VtdPOLpyQZBJ6e2D5i/1fX
         k9xA==
X-Gm-Message-State: ABuFfoj4tp3oQ+SsI8s0Y5jrKXD/R6JOtrbHCjPyA38792pUgCkuWYf8
        IgS30bU91EMyrROWNWwkSRc=
X-Google-Smtp-Source: ACcGV63vp0jRahcu27i3jQ8G24ZTWqBRu3Xv4oDCXXk6IeWfwJWsF68wOdMkmm5llAja/TqWeoaNOg==
X-Received: by 2002:a1c:1984:: with SMTP id 126-v6mr3681392wmz.7.1539137977025;
        Tue, 09 Oct 2018 19:19:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 77-v6sm29331506wmv.6.2018.10.09.19.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 19:19:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] fuzz: Add fuzz testing for packfile indices.
References: <cover.1538693039.git.steadmon@google.com>
        <60b9daad5c5132811875b6094abf4d87852e4263.1538693039.git.steadmon@google.com>
Date:   Wed, 10 Oct 2018 11:19:35 +0900
In-Reply-To: <60b9daad5c5132811875b6094abf4d87852e4263.1538693039.git.steadmon@google.com>
        (Josh Steadmon's message of "Thu, 4 Oct 2018 16:01:29 -0700")
Message-ID: <xmqqr2gymtl4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>  ### Fuzz testing
>  #
> -.PHONY: fuzz-clean fuzz-objs fuzz-compile
> +.PHONY: fuzz-clean fuzz-objs fuzz-compile fuzz-all
> ...
>  FUZZ_CFLAGS = $(CFLAGS) -fsanitize-coverage=trace-pc-guard -fsanitize=address
> ...
> +
> +fuzz-all: $(FUZZ_PROGRAMS)

I guess I read your mind ;-) Please do this in 1/2 instead of adding
it at 2/2 as "oops, we'd need it more and more as we add these".



