Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA705201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 18:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755039AbdBVSuh (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 13:50:37 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33503 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754936AbdBVSub (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 13:50:31 -0500
Received: by mail-pf0-f196.google.com with SMTP id p185so90744pfb.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 10:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bDOXp85u+oAS0W0hhdueSm2vaiViE6QDZ9sz3jvGbNY=;
        b=qaM/j6etrZ4edje9WfgZA7T8x+/ZI8OS2BeslG3e6YCmvJjF9fJ5yNpFq9UCq356Zv
         9Sfyg7obqkNWugKowZzn/5UcbyKy4r5YFv8uGNmKSCSxOQIIaQKnGJh6junXgVHZK5au
         Dq+YwYOUIoajQPiuTSw4NFM8z8NbCn9Vxc2GJ6DN/lEib9QqyilrGNvGJ8zlf/w0DUs9
         42P8qRvjVYcbiAAe7AaOdb6j1TvB8Dpo8iQDxf02J/ULI25/rG5YcVxrn5jt79EDIku5
         qZ93h8gLPbbKkwdnrLBdFouz/RnRW3PIsa6avlKGsZNafeoj6AsrhJQWywVMN5aMYnjX
         +odQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bDOXp85u+oAS0W0hhdueSm2vaiViE6QDZ9sz3jvGbNY=;
        b=TnJ+BzXdUO/OQlglvKXOE37/wUEEcK5oguKKXAa/O4Hk1OCaAB9ykbz+2My8yVLzM+
         dTOeUf57vpklZzpGu/EaXLp0+hkuWUx2FC2pqzKiBy3lJPKFgs7s2uucEM0G+ESpeXLr
         hpg7IRby6ZXEz8VBEezLOQrldRyJfjDdZ+YneiAzO8OaddWpHfYqFOKyapRU+s/pER2k
         4CI2F3jYv+3AaIq7yupPFeomASRLXB3pOEwjpzvy4wsc3VSup2M5lJvc4ycE7T4PB/hl
         nLJMfdzlfoGNEj3Ke2eGNWmDZQ7pLM6t9EimSpCaQbiF69YOCqwYn9k8As+MzDWTrU1b
         3qPA==
X-Gm-Message-State: AMke39kswNbJDKLLFnLvwuzn1Eb9RvddU5NABFD2wtAuPNW3c7Zpmhm2aA+8OxI+fI940g==
X-Received: by 10.99.1.87 with SMTP id 84mr43544423pgb.142.1487789423013;
        Wed, 22 Feb 2017 10:50:23 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id n123sm5120818pga.9.2017.02.22.10.50.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 10:50:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 03/19] builtin/diff-tree: convert to struct object_id
References: <20170221234737.894681-1-sandals@crustytoothpaste.net>
        <20170221234737.894681-4-sandals@crustytoothpaste.net>
Date:   Wed, 22 Feb 2017 10:50:21 -0800
In-Reply-To: <20170221234737.894681-4-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 21 Feb 2017 23:47:21 +0000")
Message-ID: <xmqqy3wyawlu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Convert most leaf functions to struct object_id.  Change several
> hardcoded numbers to uses of parse_oid_hex.  In doing so, verify that we
> when we want two trees, we have exactly two trees.
>
> Finally, in stdin_diff_commit, avoid accessing the byte after the NUL.
> This will be a NUL as well, since the first NUL was a newline we
> overwrote.  However, with parse_oid_hex, we no longer need to increment
> the pointer directly, and can simply increment it as part of our check
> for the space character.

After reading the pre- and post-image twice, I think I convinced
myself that this is a faithful conersion and they do the same thing.

What the function does appears somewhat iffy in the modern world.
We are relying on the fact that while Git is operating in this mode
of reading a tuple of commits per line and doing log-tree, that Git
itself will not do the history traversal (instead, another instance
of Git that feeds us via our standard input is walking the history)
for this piece of code to work correctly.  

Of course, the "diff-tree --stdin" command was meant to sit on the
downstream of "rev-list --parents", so the assumption the code makes
(i.e. the parents field of the in-core commit objects do not have to
be usable for history traversal) may be reasonable, but still...

