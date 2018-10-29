Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EAF31F453
	for <e@80x24.org>; Mon, 29 Oct 2018 05:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbeJ2Nuk (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 09:50:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34672 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbeJ2Nuk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 09:50:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id f1-v6so8632342wmg.1
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 22:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Uf8TB/h63+sFu7akXXL/YWnJZhoTD6r3zNc8JUZBvBg=;
        b=fUNUEJOwOi6vwkzt23BREUG3QKvMQ9qj952N4PiIHjlnZsrQ6F/mRXRV5m7UND8tgv
         stPmAofdv+SNeVpA0mD7BBmRvkLokECJBofuNbE+Idgaw8HeZePpA9BohJnKJWbUNkI8
         kJsKnXWguQjv4lDHDEtB6AuDYWvPQ0Mc748s0Qtr+AZBJHER6N9OTiGKg8BTVjYECmw5
         qeyYbEsPnjXbsDWvIAn+DXi07yQpYyOaVI3B3tvfvwP0ziPMHv3Fu9NPYZtw8XjDGCE5
         fWNVtsIvA0ExU+thRFOgSsFg+KAefUz1m7xzXBbfB1czQ58pTdQuRksNSxyBqhMtJbV1
         931g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Uf8TB/h63+sFu7akXXL/YWnJZhoTD6r3zNc8JUZBvBg=;
        b=ORL54eM7Sur0hr9MqWMNLMLNBVZhjEms3xwRvUg/3cW2y6zwZpneFxjpNID5H3NdsJ
         QnZqVqTVRZrL6AH90VN6QtLupZffRGcY3avFRo4n2yjdvdaDhFNWjAcThs8RXutVHfyr
         5rph8MOd0qduvIlrWECO263W9UIBWeHu+6AT5t56qqoZN+6FzgsQA5MHxrO1q7RQmwtx
         AWrp5SYaqvcvQH39ge1KrnIdXEQkZqbVv6QVCnwxlecPVtXOVKrnFkVx5naCDI82yR3I
         TCnXe7A5NNL+2Q3R1iWyRoWAuZOpJXZdhstRe+RYl+gCgs1o/IRtHb1n5YGNXQw6fJ3N
         wXkw==
X-Gm-Message-State: AGRZ1gIIo25MYC4FrILfqNamljxDrfFhC4C9OlBxhCuVqncyUFUOKtnq
        2KNxSjIgEQD2psEXTp5nSd0=
X-Google-Smtp-Source: AJdET5dV3raO51zjOXfDN5fOpfdqC2f5bztexw8kFof06fQ+LOeSieH1eVAAg1N8XL+iuzQVcg+7aQ==
X-Received: by 2002:a1c:cc0f:: with SMTP id h15-v6mr12661174wmb.1.1540789415674;
        Sun, 28 Oct 2018 22:03:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o4-v6sm13985268wrj.45.2018.10.28.22.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 22:03:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 3/8] push: improve the error shown on unqualified <dst> push
References: <20181026192734.9609-1-avarab@gmail.com>
        <20181026230741.23321-4-avarab@gmail.com>
Date:   Mon, 29 Oct 2018 14:03:33 +0900
In-Reply-To: <20181026230741.23321-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 26 Oct 2018 23:07:36 +0000")
Message-ID: <xmqq8t2h5opm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Improve the error message added in f8aae12034 ("push: allow
> unqualified dest refspecs to DWIM", 2008-04-23), which before this
> change looks like this:
>
>     $ git push avar v2.19.0^{commit}:newbranch -n
>     error: unable to push to unqualified destination: newbranch
>     The destination refspec neither matches an existing ref on the remote nor
>     begins with refs/, and we are unable to guess a prefix based on the source ref.
>     error: failed to push some refs to 'git@github.com:avar/git.git'
>
> This message needed to be read very carefully to spot how to fix the
> error, i.e. to push to refs/heads/newbranch. Now the message will look
> like this instead:
>
>     $ ./git-push avar v2.19.0^{commit}:newbranch -n
>     error: The destination you provided is not a full refname (i.e.,
>     starting with "refs/"). We tried to guess what you meant by:
>
>     - Looking for a ref that matches 'newbranch' on the remote side.
>     - Checking if the <src> being pushed ('v2.19.0^{commit}')
>       is a ref in "refs/{heads,tags}/". If so we add a
>       corresponding refs/{heads,tags}/ prefix on the remote side.

If so, we would have added ..., but we couldn't, because <src> was
not such a local ref.

But is that a useful/actionable piece of information?  The user said
v2.19.0^{commit} because there was no such local ref the user could
have used instead to allow the DWIM to work on the destination side.

Perhaps it may be a good thing to remember for the next time, but it
does not help the user at all while redoing this failed push.

>     Neither worked, so we gave up. You must fully-qualify the ref.
>     error: failed to push some refs to 'git@github.com:avar/git.git'

I am not sure if this is an improvement, quite honestly.  

The only part that directly matters to the end user and is is more
understandable than the original is "You must fully qualify the ref"
(by the way, that dash is probably not what you want).  As I already
said, "if this were local ref we can guess the location, it would
have worked better" is not relevant to the end user, so it is a
better use of the extra bytes to explain what it is to "fully"
qualify the ref, than telling what would have helped us make a
better guess.  Perhaps something along the lines of...

	'newbranch' does not match any existing ref on the remote
	side.  Please fully specify the destination refname starting
	from "refs/" (e.g. "v2.19.0^{commit}:refs/heads/newbranch"
	for creating a "newbranch" branch).

