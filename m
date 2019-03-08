Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F335820248
	for <e@80x24.org>; Fri,  8 Mar 2019 01:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfCHBhL (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 20:37:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53290 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfCHBhL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 20:37:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id e74so11073517wmg.3
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 17:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AqV9WW8gfriWlS+bHANFTd3VxfbEcqcxy3hn/Y8CDzs=;
        b=fmUrqfUXE94O3220cZ7f3bW1dZh7PT71Av/KKvfy7A4bTE+DvGdGzq7Xf060l1oXLY
         RTDnW4vr2fdwtsPab85Y69xzolvdH2LEjcozOvtiLUdPGe4JVACcwCpNsY7jIpx6d/dm
         V3KIsJHHbtB5Bj0gG3yzGGgKmXuol7b2m1fSs/wYb1eGKoFw3M0drBdfrguRg8aiwsc/
         7LmWGRNd1vyluKVhw5CDlE6MxJTQdPSKRYNIeyjNqNttNDyi1v5rwTn4mOGUGNrgkOos
         eP2vgTiPHwn0u6yQHve14S8Ma2lAidBkV6nARaJTdCZIgBsA6V55Mc5FLMN9OSay5Orq
         RcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AqV9WW8gfriWlS+bHANFTd3VxfbEcqcxy3hn/Y8CDzs=;
        b=BZ/59t3BFyGJhHHg07MavjLaVJeIhI7LwlHoyifBtQUqkiprIfW7meYKq29ieZ5n9I
         +GftHM+P37auW0WsGh+uCl1qwbW92LFpEa8+pUiCl7L1Xnm/FUUDCFHP62EVF5cdDpci
         h+t6EMpsCmZ7gltcnF7gU56s+JFhtwHXLk0D279h3QYbs/W7N/E5r2Y6xpRJBgqva+6t
         00DvbnWDRuTe738/vUVTJye6nKo06xEcaCDpen9NXB1BZgjnKJysRQGQgU4fNOtzbDsw
         xasizGFmGCExCPq33lcPNRhsjMKy4f0K7gGOBs80OJqcvtp/rdy86xxIOPKsE07RxDYw
         OggQ==
X-Gm-Message-State: APjAAAXXYvu3tlzxa14hJQwzqa80xoicnbN0iFoqVtZ9jKB3ZF72XZuI
        xeKYZUplOEi3/jyBcC/b860=
X-Google-Smtp-Source: APXvYqzUDmHlZpOeG/vEs7lvHqyh6X3XJCI9R9csEz/ip93iN6FBTVxEwnNrflffnWkIS5c81r5XNQ==
X-Received: by 2002:a1c:3b06:: with SMTP id i6mr7310701wma.55.1552009029582;
        Thu, 07 Mar 2019 17:37:09 -0800 (PST)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z8sm4458799wmi.28.2019.03.07.17.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 17:37:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] stash: handle pathspec magic again
References: <pull.159.git.gitgitgadget@gmail.com>
Date:   Fri, 08 Mar 2019 10:37:08 +0900
In-Reply-To: <pull.159.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Thu, 07 Mar 2019 07:29:32 -0800 (PST)")
Message-ID: <xmqq5zsukuyj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> It was reported in https://github.com/git-for-windows/git/issues/2037 that 
> git stash -- ':(glob)**/*.testextension is broken. The problem is not even
> the stash operation itself, it happens when the git add part of dropping the
> local changes is spawned: we simply passed the parsed pathspec instead of
> the unparsed one.
>
> While verifying the fix, I also realized that the escape hatch was seriously
> broken by my "backport of the -q option": It introduced four bogus eval 
> statements, which really need to be dropped.

Thanks.

We seem to be piling many "oops" on top, even after the topic hits
'next'.  But fixes are better late than never ;-).

Will queue.
