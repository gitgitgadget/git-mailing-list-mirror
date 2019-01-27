Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31881F453
	for <e@80x24.org>; Sun, 27 Jan 2019 13:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfA0N3A (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 08:29:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52003 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfA0N3A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 08:29:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so11085500wmj.1
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 05:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0BAAaETygoISl+RaPGF8AzvYP3ljIp8cgrS2j/9ylEc=;
        b=YX5XnY/zgPPONQBdznZJuK78gPphmFTF3kSogFfdnNwN7XTOckeptVCItUqRMmStiq
         AiZN6/xvQrqCf5HRnrMcoNP4hOVB01/TZ8N84SGrxk3LNDu8RVOL92+ywJTBxsCcO+3s
         Nm54cQ5qLd5/77Qlv32RzZxcZQMHg5e8GUGQMUh/yTYiVYErZqrUO5iDNcSiSy8IMuGU
         nCJdQfuM9iACRn9eH90lo3ZpQ6c2EKHdP7DQ85tgYOhxeLjhptqM3jewdqSepKVn1evm
         /rk1F9XQ/sl3+buTQGOabgb5fZiEap0RTzwwxcuzMLsa0zOBtVmQKD7zt4gD4mGpiSU6
         FnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0BAAaETygoISl+RaPGF8AzvYP3ljIp8cgrS2j/9ylEc=;
        b=YeLWNPJvRvxpmNk2UOBP8CTYRfaRcamq/UpjEAVJOXtdotMyZdjbS3F4FbC9k1HZis
         viUQ6GRxB+n4mmtKQkCGkxI2sGKaGhf8oJy48+d6v7rUgybfShCNRwt1p1V96WAoESgJ
         gv0H+Edo668OeqKgyeCiZCpb6VTzvQUYbHwtVquOM7YEKkGzuyevz4xs9KTihViF1hHI
         gO6n+GdovcfOudPfORCH8Tu03RlBFJ1i+DPyAMfmKhZFbs/6ydwuDSrc45damcRM32NH
         163TjVfRdncXfbhwc4wWl4ZtjiUo30JtwkaWZh/4JF6g7CEJcZCguv+xi6wANIGeg8Q7
         25fg==
X-Gm-Message-State: AJcUukcV2zfK/HnQUHOE+lerMDJOAz/MwTRHINB/nRa8OFjOD7vVlWsL
        k+NqUX1Qq1cAbqzHAs2fQvM=
X-Google-Smtp-Source: ALg8bN4UCIc2H5QFZw6Sz/qIY9N+4642i5mt0wXBa0G6+WY4git+T86cdSLs/eEZO54BUCW3AIKpQQ==
X-Received: by 2002:a1c:87cc:: with SMTP id j195mr13393625wmd.2.1548595737381;
        Sun, 27 Jan 2019 05:28:57 -0800 (PST)
Received: from szeder.dev (x4dbd90dd.dyn.telefonica.de. [77.189.144.221])
        by smtp.gmail.com with ESMTPSA id f192sm8835732wmd.25.2019.01.27.05.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 05:28:56 -0800 (PST)
Date:   Sun, 27 Jan 2019 14:28:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] object_as_type: initialize commit-graph-related fields
 of 'struct commit'
Message-ID: <20190127132854.GI6702@szeder.dev>
References: <20190125222126.GH6702@szeder.dev>
 <20190127130832.23652-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190127130832.23652-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 27, 2019 at 02:08:32PM +0100, SZEDER Gábor wrote:
> When the commit graph and generation numbers were introduced in
> commits 177722b344 (commit: integrate commit graph with commit
> parsing, 2018-04-10) and 83073cc994 (commit: add generation number to
> struct commit, 2018-04-25), they tried to make sure that the
> corresponding 'graph_pos' and 'generation' fields of 'struct commit'
> are initialized conservatively, as if the commit were not included in
> the commit-graph file.
> 
> Alas, initializing those fields only in alloc_commit_node() missed the
> case when an object that happens to be a commit is first looked up via
> lookup_unknown_object(), and is then later converted to a 'struct
> commit' via the object_as_type() helper function (either calling it
> directly, or as part of a subsequent lookup_commit() call).
> Consequently, both of those fields incorrectly remain set to zero,
> which means e.g. that the commit is present in and is the first entry
> of the commit-graph file.  This will result in wrong timestamp, parent
> and root tree hashes, if such a 'struct commit' instance is later
> filled from the commit-graph.
> 
> Extract the initialization of 'struct commit's fields from
> alloc_commit_node() into a helper function, and call it from
> object_as_type() as well, to make sure that it properly initializes
> the two commit-graph-related fields, too.  With this helper function
> it is hopefully less likely that any new fields added to 'struct
> commit' in the future would remain uninitialized.
> 
> With this change alloc_commit_index() won't have any remaining callers
> outside of 'alloc.c', so mark it as static.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
> 
> So, it turns out that ec0c5798ee (revision: use commit graph in
> get_reference(), 2018-12-04) is not the culprit after all, it merely
> highlighted a bug that is as old as the commit-graph feature itself.
> This patch fixes this and all other related issues I reported
> upthread.

And how/why does this affect 'git describe --dirty'?

  - 'git describe' first iterates over all refs, and somewhere deep
    inside for_each_ref() each commit (well, object) a ref points to
    is looked up via lookup_unknown_object().  This leaves all fields
    of the created object zero initialized.

  - Then it dereferences HEAD for '--dirty' and ec0c5798ee's changes
    to get_reference() kick in: lookup_commit() doesn't instantiate a
    brand new and freshly initialized 'struct commit', but returns the
    object created in the previous step converted into 'struct
    commit'.  This conversion doesn't set the commit-graph fields in
    'struct commit', but leaves both as zero.  get_reference() then
    tries to load HEAD's commit information from the commit-graph,
    find_commit_in_graph() sees the the still zero 'graph_pos' field
    and doesn't perform a search through the commit-graph file, and
    the subsequent fill_commit_in_graph() reads the commit info from
    the first entry.

    In case of the failing test I posted earlier, where only the first
    commit is in the commit-graph but HEAD isn't, this means that the
    HEAD's 'struct commit' is filled with the info of HEAD^.

  - Ultimately, the diff machinery then doesn't compare the worktree
    to HEAD's tree, but to HEAD^'s, finds that they differ, hence the
    incorrect '-dirty' flag in the output.

Before ec0c5798ee get_reference() simply called parse_object(), which
ignored the commit-graph, so the issue could remain hidden.

