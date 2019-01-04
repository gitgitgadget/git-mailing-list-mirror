Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EDC41F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 23:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfADXTL (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 18:19:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39999 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfADXTK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 18:19:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so37910588wrt.7
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 15:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5whouJ2oxEVN88juFMMNirTXZG5pivw0E2zGT28SY40=;
        b=K30N/UqQpvvmd7IE8YdSGPAQtjWmfrRxu7bYjtOYTPadAnxtKU4GPRWIDEM4MrihKT
         CgptlaZxPYvFTUIgGKMgvNFtSGW18WCpQdSGPtx2mNrReH0+CKhuI3DJW5oVQrJWE3W+
         ZS9tks6n97sbMe6RKGwgaMGJ6gllLvxKVm6i7Jpza7ZqZUsxWi5+dpNvnaFbH9q4Y6C+
         CvEc1+pBbUaDmz2JUm89wLj9lD7U2UFlnNsiCUvT6aMkAPO1aY9vDaAo7EpJHeC6FPeR
         i/uFFjj/gmE6XJlRnl1wuifjDXaJjXjnlGTjbu7+cZ7iyMiT/CsPG057yk0hmTHpOiDI
         QhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5whouJ2oxEVN88juFMMNirTXZG5pivw0E2zGT28SY40=;
        b=fTqJCOSGoVs6Ihx58Kqe0f3w434Nkw1UuLJHuwJ8r2aYuNLsvEr0AtGOu8lpkF7PNI
         BTO+c1lEnLOsq5WPJWCLdHbfwaF/H/9fQM70c8gT8XfWXojKiYS7dXF2nComNKRNG5ia
         uaYEtZWIjkK0ew78gCE6MtjCX17jEVJPgsigh4ueniOqC5VgVrib3uKiHBcoSq3ZYmwc
         +aAVHOtZQl3rjwV49UvajEKI9ZwVvU4Wws7LnBl2gHN1TOu5pUxVXsy8NrlOUX6BEggd
         RtIpk4MrRfw7wc5Y0susb10h5qnfoxuP9hq+Hhu1njNRqV99oWvcJkx7Fqj7o1s92Hx/
         o3OQ==
X-Gm-Message-State: AJcUukfYV0wUxc5KWWC/19UtODZ2yf3GS3GPSYuKXQz5m/fZ0QDWvGRy
        uwy8ebcU9+zlwEpWO7Yg8EQ=
X-Google-Smtp-Source: ALg8bN7iimym28r9EH+gpcQpUr6S0/OWPiOOznjKmAFdwbgRqgn+2nxYaG7v2rO6CTHAN97msoNDIg==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr45377912wrq.15.1546643948740;
        Fri, 04 Jan 2019 15:19:08 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g188sm1596381wmf.32.2019.01.04.15.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 15:19:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] built-in rebase: call `git am` directly
References: <pull.24.git.gitgitgadget@gmail.com>
        <2b5ece8263936f0a7dfad864c0de43d784fdaf1f.1545398254.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Jan 2019 15:19:06 -0800
In-Reply-To: <2b5ece8263936f0a7dfad864c0de43d784fdaf1f.1545398254.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 21 Dec 2018
        05:17:38 -0800 (PST)")
Message-ID: <xmqqbm4wau51.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> While the scripted `git rebase` still has to rely on the
> `git-rebase--am.sh` script to implement the glue between the `rebase`
> and the `am` commands, we can go a more direct route in the built-in
> rebase and avoid using a shell script altogether.

 ...

>  builtin/rebase.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++

Now at some point as a follow-up change, we'd need to remove the
git-rebase--am.sh that is no longer used, together with the
reference to it in the Makefile, no?
