Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF74C64ED6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 22:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjBWWfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 17:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBWWfv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 17:35:51 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0308018B0C
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 14:35:51 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d7so6877368pfu.4
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 14:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wq4ZVkr73hug5qGD0l2V5k5gBDUK1EaGMeVI0tmtrNI=;
        b=kWkSTqCsyoPIWA4pZ6pPbLd9NXqhO7jkJsqDQk+I/brSlN3TpaW2zqXS0RXo/k+faj
         o2OVor1xzSQlQvxg2zbOyvhpJ8wJLmiJVu3JigcrT8UOrdyDUf4by3kUlQUhBgJi7ADT
         h5jrJZufkI0Z8bjhKAzcgAZly+JJai4OH601eNzKPBgh6E4wHuwcLGdtEJgaOVG4qjX0
         xWBz1ITLy7k9MDiu5erxDaAg/yFvwNUSzn5gFWdrg3baNVL4EQdRSyjY855rGWRDznzf
         q+NE5VT/kklhK16kn3c4vH3z5QQ8TbvCCvXbbvli7QEOsgvXc8pz3Uls3QFzW2A9D0Kh
         pieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wq4ZVkr73hug5qGD0l2V5k5gBDUK1EaGMeVI0tmtrNI=;
        b=0cFzvT/n4BnOL8KFHgE9S3SpvxFmwJwPpRq5cz4yzsSay/5bvYLBY5ATWJK6t6Nbs/
         kC5Fwq5gSYMk1118dRPRnAWOPugqs1SaViRaxb0agLTCLFC2uw+R25laKJSCCGECrd6x
         gknKxYrQvMiA1olLLd9rdxZ+Lwokzbo9Ir6L/jwK9SXetPAcOZck38j616iJn1Og8zuB
         rCUYcCYuI6mliHKO6oefnsoRVEug/73r1d3b7ShCKF9Y+S2GHdRDKzwwCvKa3wjgYqWp
         qitXBKZpbw1HsDRIUzwVGFmtyhvKLx0BjQjkx3sKC5QWy0YQ/BFe/lxg0kscs7ymNJ+/
         hTQg==
X-Gm-Message-State: AO0yUKWUp9WiJvf2tDId16ygxCT3B/OEPvNPgBuovRvpY2my3e2kw+Uz
        0bDFZ/8E8xa4Qr4KbfBSonQdc6SN0EU=
X-Google-Smtp-Source: AK7set+FSRhW5MaXVV1cSmZRGRcxZISjUq+ny7XkNdFZoMrAzqTFbnASiIBLai8wVmx6151pSsfVJQ==
X-Received: by 2002:aa7:8ecc:0:b0:5a8:bcf2:125 with SMTP id b12-20020aa78ecc000000b005a8bcf20125mr10670948pfr.21.1677191750362;
        Thu, 23 Feb 2023 14:35:50 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id t10-20020a62ea0a000000b005d3901948d8sm4045392pfh.44.2023.02.23.14.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 14:35:49 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] rebase -i: fix parsing of "fixup -C<commit>"
References: <pull.1486.git.1677185701.gitgitgadget@gmail.com>
        <d670e284c175db67337ca7ce774ecd9afb089736.1677185702.git.gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 14:35:49 -0800
In-Reply-To: <d670e284c175db67337ca7ce774ecd9afb089736.1677185702.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Thu, 23 Feb 2023 20:55:01
        +0000")
Message-ID: <xmqq1qmg6md6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	if (item->command == TODO_FIXUP) {
> -		if (skip_prefix(bol, "-C", &bol) &&
> -		   (*bol == ' ' || *bol == '\t')) {
> +		if (skip_prefix(bol, "-C", &bol)) {
>  			bol += strspn(bol, " \t");
>  			item->flags |= TODO_REPLACE_FIXUP_MSG;

OK.  An explicit check followed by strspn() is an odd way to write
this even if it meant to require at least one whitespace, but I
agree that this one probably did not even mean to require a
whitespace there, and the updated code looks much easier to read.

> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 1d2f0429aea..7ca5b918f04 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> ...
> +test_expect_success 'fixup -[Cc]<commit> works' '
> +	test_when_finished "test_might_fail git rebase --abort" &&
> +	cat >todo <<-\EOF &&
> +	pick A
> +	fixup -CA1
> +	pick B
> +	fixup -cA2
> +	EOF

By the way, this is much easier to follow, than the todo file written
in the ugly FAKE_LINES language, to see what is being tested.

Will queue.  Thanks.
