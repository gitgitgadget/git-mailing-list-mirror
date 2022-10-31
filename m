Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D360BC38A02
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 10:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJaKqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 06:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJaKqd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 06:46:33 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24D4DBE
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 03:46:32 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id hh9so7110951qtb.13
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 03:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6+lz14qWnxT9Ivz8hxPbl/s2O3CSb2HTrlhOTW83AQ=;
        b=QR7qZsCtWnLRL3UfAX3lo/5TEZ+t9KFShxy/XgE14FInbNZnihZ7S2pPM2ptuDEOaz
         57IqKx3mhS8pnL+Bpf0gw8OxVsFXnCJiEpLCwJaGMJGwcyBuYWlwXafwku96cN4v2AK9
         sVbXuIXzGyYAK32zUN7YGQZhSHFX7J005ejuwPgBpQPjeAIJwLo9kUghAtNDKpdEDl0l
         M+U02FbmwuOc46uHgIvqu1NSxIMLhUTnSyvkdkNiwQcMrGYEcwIxCkiMegmQTDtsDsdR
         +gui9WjuDEA5Ut9M8EmMUSS6vFaTLfH5rMo7oxLJ+BDmtAyqcN2esdR2iSqf5+dKtLbk
         cp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6+lz14qWnxT9Ivz8hxPbl/s2O3CSb2HTrlhOTW83AQ=;
        b=2eVayZDJ503IyIrEEYFG9yFNxrPT5jTsgMXcxjGPl2WAkutOaUfAifRsUuDLeRat0b
         0c0+oyLf6QTm0Tm6vUobaBIxGbJgBHnsNGs/5ZVmBwKqeL2aLX7kKSzdjWXRu8AZr94J
         E2SnOark8MosMNc4j4OoEEcUaHARrfulspU29VZt2SqcOq6iTXeKkHRuAR4MalTpCuHm
         PUvsdMymPIyty022dQg6LMQDhRhBO/Z3ldtbZAMnF7xChIMSK4FD1J3vbG3xbxNYvHGj
         ZTuELF8j3ybzNvPzXdnwWNrf0kM/lmbhx54aFFexJaJkxWbzk6cBm81FeNHsBPv3naSI
         zDyw==
X-Gm-Message-State: ACrzQf2qcQ/1g3fCmyAzGltKY7LbGZyudNLyJG9BJHcuahWu+2CHxtaP
        dBJd8c9lGhU9XpHcEuA0BbeE
X-Google-Smtp-Source: AMsMyM566FldLNZRguMjTDjMhaZarnlIYfjHGWJCw5H+FkEZGPSsg0wUHvnDoq1VbeH0BnFm5Wc+6g==
X-Received: by 2002:a05:622a:490:b0:39c:c82d:557c with SMTP id p16-20020a05622a049000b0039cc82d557cmr9855670qtx.463.1667213191761;
        Mon, 31 Oct 2022 03:46:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:69f9:125a:59f0:ff51? ([2600:1700:e72:80a0:69f9:125a:59f0:ff51])
        by smtp.gmail.com with ESMTPSA id r5-20020a05620a298500b006eeb25369e9sm273617qkp.25.2022.10.31.03.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 03:46:31 -0700 (PDT)
Message-ID: <fe5658f8-ac50-b328-f286-ef0971455046@github.com>
Date:   Mon, 31 Oct 2022 06:46:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v3 2/2] config: let feature.experimental imply
 gc.cruftPacks=true
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover.1666815209.git.me@ttaylorr.com>
 <cover.1666819953.git.me@ttaylorr.com>
 <13a25a425bc0901ee38760095eb1bcf314c00da2.1666819953.git.me@ttaylorr.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <13a25a425bc0901ee38760095eb1bcf314c00da2.1666819953.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/26/22 5:32 PM, Taylor Blau wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
> 
> We are interested in exploring whether gc.cruftPacks=true should become
> the default value.
> 
> To determine whether it is safe to do so, let's encourage more users to
> try it out.
> 
> Users who have set feature.experimental=true have already volunteered to
> try new and possibly-breaking config changes, so let's try this new
> default with that set of users.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/config/feature.txt |  3 ++
>  builtin/gc.c                     |  7 +++--
>  repo-settings.c                  |  1 +
>  repository.h                     |  1 +
>  t/t6500-gc.sh                    | 53 ++++++++++++++++++++++++++++++++
>  5 files changed, 63 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
> index cdecd04e5b..95975e5091 100644
> --- a/Documentation/config/feat



> +	prepare_repo_settings(the_repository);
> +	if (cruft_packs < 0)
> +		cruft_packs = the_repository->settings.gc_cruft_packs;
> +

Here, we are checking if cruft_packs hasn't been set by the
command-line arguments _or_ the gc.cruftPacks config option
(as checked in gc_config()). However, we now have another
parameter saying "enable it by the experimental flag".

You are applying things in the correct order here, but I
wanted to point out...

> @@ -43,6 +43,7 @@ void prepare_repo_settings(struct repository *r)
>  	/* Defaults modified by feature.* */
>  	if (experimental) {
>  		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
> +		r->settings.gc_cruft_packs = 1;
>  	}
>  	if (manyfiles) {
>  		r->settings.index_version = 4;

That later in prepare_repo_settings(), we check the exact
config values so that the repo_settings reflects the full
implications from config:

	/* Commit graph config or default, does not cascade (simple) */
	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_graph_generation_version, 2);
	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);

	/* Boolean config or default, does not cascade (simple)  */
	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);

This allows us to use the_repository->settings.* members
as placeholders for the full implications from config.

So this implementation has some slight differences from
other repo_settings implementations. It's correct, and the
use of gc.cruftPacks is pretty isolated, but I wonder if
we should be sticklers about this pattern in repo_settings.

Thanks,
-Stolee

P.S. I found this draft open on my laptop when I opened it
this morning. Hopefully it's not too late.
