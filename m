Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB53C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE62C64EAA
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhBARdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhBARdi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 12:33:38 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9A9C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 09:32:58 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id l27so17034051qki.9
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 09:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BqTn9DT6pqth+Hd/pWvCoHvJz0SnhVeywhmNQh+fdXU=;
        b=VIxJO9ppkVL28UoxldtVA2+JLqdn4RnalcU348ZLOdaE4SdOzrBw/K6NGpSLl4laoR
         vkSfnHlzSzZfuVG6yPqGyJKdOqnNV2uOGii+/xtIg2Orv06lyVXxWhabULhBlSWZjcsJ
         51y05a9ZspRNiIoLfLUlhDOnOSpSgUJwcaTpNaFFWo0ccMJUNDiwoP4kjWdfy6aMYBE/
         UdvhayvC3tqJtZbLT1Yu6NBEgRFQyF8Xod3aV0JjYlfAboD7QgzDf1wgJwjXtwkEhytg
         MbC1K885sbKZFR/CPpIWHlBz90AT/XT73dF580YdQC7i0eJorTS4jWXtberWQxJTpmk8
         sgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BqTn9DT6pqth+Hd/pWvCoHvJz0SnhVeywhmNQh+fdXU=;
        b=OYHId0+Y7bK9Md/cgJBHRUYi2qFkXBRy3JYr6RqudauByRw65HnZH8NexfsfkIdgJh
         2d6J7eOSE+eokOf/mU1Hf55+JxmkM170uyIq165889RigAubH9q7ToF4G+fIXTPdiAei
         MX+4FcihF5fqPYgTZ5ZWfmx4VZTUw/G0dclUu0EEBCrDR76W89AP7SBWSyxi0S++24ir
         SIhgxYgBc1T1P+QuRbK9BrqCy/OiKZKscKEaveD3qGyAqzzInz4rJ3LuMDGisZwP2OtA
         28S+v2pK6+FfjrMnBG4UoYmb7ZHwEfxHQhq7JHsWelH7Dssd4+ornN7Qnm+dEZSHdbzM
         yM7w==
X-Gm-Message-State: AOAM530+9j5FUv5gPmNnztXrenIiqE9vhuPrQMn5KqC/keV7MY/dBhAq
        UBBe4IhrjjdnEOV3Zt35TZjZig==
X-Google-Smtp-Source: ABdhPJwvGwnu28Yxhi9JYvTJuWh4zWApwY7POT06KgJFOvHrCIaeQyLPsynu6dWzzbF1+i019tB/Jw==
X-Received: by 2002:a05:620a:146a:: with SMTP id j10mr16894194qkl.166.1612200777306;
        Mon, 01 Feb 2021 09:32:57 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:8bd2:a84b:ef4c:2356])
        by smtp.gmail.com with ESMTPSA id u126sm3930972qkc.107.2021.02.01.09.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 09:32:56 -0800 (PST)
Date:   Mon, 1 Feb 2021 12:32:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        gister@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/5] commit-graph: use repo_parse_commit
Message-ID: <YBg7RAhkvoe/iV1q@nand.local>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <9c605c99f66cae3c66bcdd4cbeefbfa1ec2be192.1612199707.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c605c99f66cae3c66bcdd4cbeefbfa1ec2be192.1612199707.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 05:15:03PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The write_commit_graph_context has a repository pointer, so use it.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Everything here looks good to me, but...

> ---
>  commit-graph.c | 10 +++++-----
>  commit.h       |  5 +++--
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index f3bde2ad95a..03e5a987968 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1098,7 +1098,7 @@ static int write_graph_chunk_data(struct hashfile *f,
>  		uint32_t packedDate[2];
>  		display_progress(ctx->progress, ++ctx->progress_cnt);
>
> -		if (parse_commit_no_graph(*list))
> +		if (repo_parse_commit_no_graph(ctx->r, *list))
>  			die(_("unable to parse commit %s"),
>  				oid_to_hex(&(*list)->object.oid));
>  		tree = get_commit_tree_oid(*list);
> @@ -1411,11 +1411,11 @@ static void close_reachable(struct write_commit_graph_context *ctx)
>  		if (!commit)
>  			continue;
>  		if (ctx->split) {
> -			if ((!parse_commit(commit) &&
> +			if ((!repo_parse_commit(ctx->r, commit) &&

I know that this has nothing to do with your patch, but it really would
be nice to unify all of these parse_commit() vs parse_commit_no_graph()
calls.

As I recall this dates back to 43d3561805 (commit-graph write: don't die
if the existing graph is corrupt, 2019-03-25), and there was some
discussion on the list at the time about revisiting this if we ever were
able to write incremental commit graphs:

  https://lore.kernel.org/git/20190221223753.20070-8-avarab@gmail.com/

Now may be a good time to revisit that, although I don't want to detract
from another fix (that we really do need to land before v2.31.0).

Thanks,
Taylor
