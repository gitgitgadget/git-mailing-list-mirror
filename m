Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946DB1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 18:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeFZS7a (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 14:59:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54445 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbeFZS73 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 14:59:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so3093654wmf.4
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 11:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hm0sE9O9gioctTMSLKPG415RVy57W6yEQRX4dGykkHQ=;
        b=eut5isICgyjLw7V8Q5vE62kR6o/aN5P3ZnH0tazHk7/O0DmfPn72wzqbS8PRyGTlxM
         wTm2+XpARGEJ+JWfUKH0ypdrTNhkubuW9iSPcj4XG8JXJ11gystqiueFoZWVfqfpP/JR
         qw+oEdV8y9wqPHLl2/z246frdgi9fqHZz46JdIyOoNTGkl8CC+Z45FWIs7jLg8R6henN
         jAO09mRpdg+W8+lc/pjyE7plodYdEODjzBTXIyVzqn02/MZiL1W0bFla5kCErDQclOvh
         7ENNrS964zlvtw/I4kPxb4pqOkwhIcMmdmzwbtcInpGOWM8d2jmE/e96Eikfd77DzLCb
         6TrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hm0sE9O9gioctTMSLKPG415RVy57W6yEQRX4dGykkHQ=;
        b=rXBeiq6nFp/WPc9V8WgdpqlZcyTA3mIJirYQg86LVjGjb0BGNtEfy77xOVQrHfG4t0
         6xcrJdrTKRDPP6IGJVr2RFvQ4n/gWQsPKMJTVuGHad3L4ZDAyp5be9bK6ZpKx88Wavyf
         nukNs7MBj+nX2/TOl4Y8j+mB/esmgXIA6D2oOM26CwoNh78S5U3yHnp9+iazc/aDKutg
         E3YioJHKcrhpvpukkWaIDKXPBEORgYx/1WkheidPagy915azaUwuCxDdBTMKiSMsWiJb
         gn17BYj1o40BYMkBD+IuSy058sYAElS1OajqElMF7JrmEj0/CEhXRE/3GEcryBpK38Q0
         9KhQ==
X-Gm-Message-State: APt69E0wpwB7xDm8E3M98Y4ZRnyhR/rRZAPZjz/uN3Bxd7rZYOeEfBtA
        s8+IgPjohyEFNqkWlV0S+LA=
X-Google-Smtp-Source: AAOMgpcUhf8l9aQzAXd2v3zOcNbajR9jXlaQ+ywLBrrnqLd25wsi2iYmjx6v0F4HiAmY8eV4IU0ktw==
X-Received: by 2002:a1c:e846:: with SMTP id f67-v6mr2553223wmh.63.1530039568313;
        Tue, 26 Jun 2018 11:59:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t10-v6sm2006494wrq.74.2018.06.26.11.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 11:59:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: support negotiation tip whitelist
References: <20180625193752.255319-1-jonathantanmy@google.com>
Date:   Tue, 26 Jun 2018 11:59:27 -0700
In-Reply-To: <20180625193752.255319-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 25 Jun 2018 12:37:52 -0700")
Message-ID: <xmqq6025l6gg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> During negotiation, fetch-pack eventually reports as "have" lines all
> commits reachable from all refs. Allow the user to restrict the commits
> sent in this way by providing a whitelist of tips; only the tips
> themselves and their ancestors will be sent.
>
> This feature is only supported for protocols that support connect or
> stateless-connect (such as HTTP with protocol v2).
>
> This will speed up negotiation when the repository has multiple
> relatively independent branches (for example, when a repository
> interacts with multiple repositories, such as with linux-next [1] and
> torvalds/linux [2]), and the user knows which local branch is likely to
> have commits in common with the upstream branch they are fetching.
>
> [1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/
> [2] https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This is based on jt/fetch-pack-negotiator, but if that branch is
> undesirable for whatever reason, I can port this to master.
> ---
>  builtin/fetch.c    | 21 ++++++++++++++++++
>  fetch-pack.c       | 19 ++++++++++++++--
>  fetch-pack.h       |  7 ++++++
>  t/t5510-fetch.sh   | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>  transport-helper.c |  3 +++
>  transport.c        |  1 +
>  transport.h        | 10 +++++++++
>  7 files changed, 114 insertions(+), 2 deletions(-)

What's the plan to expose this "feature" to end-users?  There is no
end-user facing documentation added by this patch, and in-code
comments only talk about what (mechanical) effect the option has,
but not when a user may want to use the feature, or how the user
would best decide the set of commits to pass to this new option.

Would something like this

    git fetch $(git for-each-ref \
	--format=--nego-tip="%(objectname)" \
	refs/remotes/linux-next/) \
	linux-next

be an expected typical way to pull from one remote, exposing only
the tips of refs we got from that remote and not the ones we
obtained from other places?
