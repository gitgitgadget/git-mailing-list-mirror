Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC2441F597
	for <e@80x24.org>; Tue, 24 Jul 2018 05:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbeGXG7c (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 02:59:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34416 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbeGXG7c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 02:59:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so2823641wrt.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 22:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=loQyNE8YgbUuwnAFYq5O3vQKndRepEg0cwO7fEAf04w=;
        b=GbXfkJpvHHzeddss/m/VuU/MhzIQDQPIDtldNwErhj7wngxLNZiusoP6N9y/BgEctC
         NhxevsOpkilF4Tmfw/goGSHfSXtZ+wbGHs9jXtNHvkMlbCFXWalblx4ofWXIR97dzKb2
         fMMuj2v5SDsCpUzdbeIgtH32yaFaYMILOqk/IEm9ZZ8KnDPGv8YnMYzgA4QELs1uCpm2
         Ax6G6IIhboJrLgpOARRe3shV3n80C16rLxuSgxs8s4XI44aU5SOm/azrRuKXSZXwThpi
         oD/0XMSrPRLQolyAfxM2a0rjAHCyjfdIjY5DbOcfOhy862fyaiM7usjguaAVFLRL+7KO
         qbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=loQyNE8YgbUuwnAFYq5O3vQKndRepEg0cwO7fEAf04w=;
        b=hFaaQi8Ve7Qsw/fwUtMdWK5Y41zVdsdpuZymxSq+xpPGn0nOpXwAKFnn7HVCnrgvEy
         b+KC1FM8aD+HmNQyehiYkJfpgTXtnO6iotrpDuajGTyZ0k93uLxuj37qEhGDriqb4qz6
         mm7zRNOFTFOuqeN/b7FBDhrx7smqNEUQWMS+eHOktc5jP748LCL2nyj0W3sqUiRc1gRM
         cUb3PbEP4Fi8uL+etKU/71HBZBan202olBW1EFSsL246vnANH3vx2wTbz+gytxuT4y4P
         xwSiFYTtuwNxSLMdRiqI97jCiXBTbuScJEXA6gZANQZKtgPzxPpRqHYyEtjgUjnJa3NU
         PsqA==
X-Gm-Message-State: AOUpUlG81S7/DofbOkpUhaXeiv/8HTViaPckrHPvBQdoI8F2fIifH9bB
        Uz2ttoTnKKQQgJzg4CBrGAE=
X-Google-Smtp-Source: AAOMgpc/tUuj7k3PAuROwg2XTDfjsHJ7i3aedY25o2z0DS+yWgS8ERQbtNbYRzLPekwIR1JfAI6crg==
X-Received: by 2002:adf:a0f3:: with SMTP id n48-v6mr10885476wrn.23.1532411685400;
        Mon, 23 Jul 2018 22:54:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m207-v6sm800212wma.31.2018.07.23.22.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 22:54:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase, etc)
References: <20180718204458.20936-1-benpeart@microsoft.com>
        <20180718213420.GA17291@sigill.intra.peff.net>
        <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
        <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
        <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
Date:   Mon, 23 Jul 2018 22:54:44 -0700
Message-ID: <xmqqefft18m3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>> Hmm.. this means cache-tree is fully valid, unless you have changes in
>> index. We're quite aggressive in repairing cache-tree since aecf567cbf
>> (cache-tree: create/update cache-tree on checkout - 2014-07-05). If we
>> have very good cache-tree records and still spend 33s on
>> traverse_trees, maybe there's something else.
>>
>
> I'm not at all familiar with the cache-tree and couldn't find any
> documentation on it other than index-format.txt which says "it helps
> speed up tree object generation for a new commit."  In this particular
> case, no new commit is being created so I don't know that the
> cache-tree would help.

cache-tree is an index extension that records tree object names for
subdirectories you see in the index.  Every time you write the
contents of the index as a tree object, we need to collect the
object name for each top-level paths and write a new top-level tree
object out, after doing the same recursively for any modified
subdirectory.  Whenever you add, remove or modify a path in the
index, the cache-tree entry for enclosing directories are
invalidated, so a cache-tree entry that is still valid means that
all the paths in the index under that directory match the contents
of the tree object that the cache-tree entry holds.

And that property is used by "diff-index --cached $TREE" that is run
internally.  When we find that the subdirectory "D"'s cache-tree
entry is valid in the index, and the tree object recorded in the
cache-tree for that subdirectory matches the subtree D in the tree
object $TREE, then "diff-index --cached" ignores the entire
subdirectory D (which saves relatively little in the index as it
only needs to scan what is already in the memory forward, but on the
$TREE traversal side, it does not have to even open a subtree, that
can save a lot), and with a well-populated cache-tree, it can save a
significant processing.

I think that is what Duy meant to refer to while looking at the
numbers.

> After a quick look at the code, the only place I can find that tries
> to use cache_tree_matches_traversal() is in unpack_callback() and that
> only happens if n == 1 and in the "git checkout" case, n == 2. Am I
> missing something?
