Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6519EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 13:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjFTN2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjFTN2k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 09:28:40 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0386C1730
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 06:28:09 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bc492cb6475so3690404276.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 06:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1687267684; x=1689859684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBxSaINq5Ce32jmJ0oP1/2Bo7rE1MTM4/zDlqiYX8ak=;
        b=G2osedYIJ8nh2CGxcVhMLegAsp2bgCDKcmbX8tDLIPE/TBtEZyJhec9uIAv4LvVSTc
         p50IEbmQJmne4gntalMQci24wg2b7RjXlaQf7jaYSP6wPw6nOGuFryhmdJ377gNU7+KT
         mGlSKt6Zh+ntZIDK9xmnF+/Kx7wEwpuuB5bMLqS0e2uKN0l4hHsbXHskO3Ti2DluOn+O
         EJsg2Y6muM0h4MfQMB92YCSpIDuPAaEoK8yhHKUeBqm/V4AAkLZXdmKiE+rAZCuNBpye
         cxNgg17proQ6ZOagt2KXfKsI99v8LZh1c4ChaIkmC79odcjpCqeuIpcR1uejVX74Cz3l
         WOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267684; x=1689859684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBxSaINq5Ce32jmJ0oP1/2Bo7rE1MTM4/zDlqiYX8ak=;
        b=RU7Cf3Hs3ViLk9GTHHtKraGPA1VkqRBtXrwGjYCoj0EWcSnKj84I4K+YkAGJBYFgWp
         dcOm01NGqJ5awTdzwBNn5Enz93H+yLlK2xtXBimR6IoX0VksfECUmR+z70OfZu4bFUWm
         A6Md0gmqwKz7kQe9bPa88r/Krv10jAahT1pVenCoowo5fbpWTh2E0HoD3DxvzNkyRleV
         kaR6HjqtnCRspyhtA0VYt4qvA+kfn1t02WiWZlIgro8yvNc1828tm0+ABZarAnp2glZT
         AKWS754uKq7ZUVaAQCmlsKjQE7EAShz+62uu/MSh9SdX8AJos+p+f7amrVL6cE84spXK
         stXg==
X-Gm-Message-State: AC+VfDwGnRrYnPR0C4x/fA2T6/cUxMmVRFKGK95opzXfhu96JA61nVWg
        KRwGFRFzZl17qjq22yrhOHAY
X-Google-Smtp-Source: ACHHUZ6JCKhvlVuYAbgAdAuRAB7cnRD8sPtZknGRvA3XZt9kP55NHGtuzZBZ0cJm7pGyVH7OcdqmBg==
X-Received: by 2002:a25:addb:0:b0:bba:9296:891f with SMTP id d27-20020a25addb000000b00bba9296891fmr6706626ybe.9.1687267684440;
        Tue, 20 Jun 2023 06:28:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e8fd:3e8c:8558:4cd? ([2600:1700:e72:80a0:e8fd:3e8c:8558:4cd])
        by smtp.gmail.com with ESMTPSA id b16-20020a25ae90000000b00bb0a8342723sm361499ybj.50.2023.06.20.06.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:28:03 -0700 (PDT)
Message-ID: <ceb8eb58-6cbe-1846-14e4-33c4967e3024@github.com>
Date:   Tue, 20 Jun 2023 09:28:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/4] repo-settings: introduce
 commitgraph.changedPathsVersion
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1686677910.git.jonathantanmy@google.com>
 <6adfa53dafc8c34f94a017fdc08460911f53d310.1686677910.git.jonathantanmy@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <6adfa53dafc8c34f94a017fdc08460911f53d310.1686677910.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/13/2023 1:39 PM, Jonathan Tan wrote:
> A subsequent commit will introduce another version of the changed-path
> filter in the commit graph file. In order to control which version is
> to be accepted when read (and which version to write), a config variable
> is needed.
> 
> Therefore, introduce this config variable. For forwards compatibility,
> teach Git to not read commit graphs when the config variable
> is set to an unsupported version. Because we teach Git this,
> commitgraph.readChangedPaths is now redundant, so deprecate it and
> define its behavior in terms of the config variable we introduce.

I'm late to the party, but I support this change. The safety valve
of "I want to turn this off if something goes wrong" is long overdue
for deletion (it would help someone in this high-bit situation).

Having a new replacement is a good way to preserve the safety valve
behavior while also promoting the new versioning scheme.
 
> This commit does not change the behavior of writing (Git writes changed
> path filters when explicitly instructed regardless of any config
> variable), but a subsequent commit will restrict Git such that it will
> only write when commitgraph.changedPathsVersion is 0, 1, or 2.

>  commitGraph.readChangedPaths::
> -	If true, then git will use the changed-path Bloom filters in the
> -	commit-graph file (if it exists, and they are present). Defaults to
> -	true. See linkgit:git-commit-graph[1] for more information.
> +	Deprecated. Equivalent to changedPathsVersion=1 if true, and
> +	changedPathsVersion=0 if false.

This defaulted to true before...

> +commitGraph.changedPathsVersion::
> +	Specifies the version of the changed-path Bloom filters that Git will read and
> +	write. May be 0 or 1. Any changed-path Bloom filters on disk that do not
> +	match the version set in this config variable will be ignored.
> ++
> +Defaults to 1.

So this version defaults to 1. Good.

> ++
> +If 0, git will write version 1 Bloom filters when instructed to write.

> -	if (s->commit_graph_read_changed_paths) {
> +	if (s->commit_graph_changed_paths_version == 1) {
>  		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
>  			   &graph->chunk_bloom_indexes);
>  		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,


>  	/* Commit graph config or default, does not cascade (simple) */
>  	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
>  	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_graph_generation_version, 2);
> -	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
> +	repo_cfg_bool(r, "commitgraph.readchangedpaths", &readChangedPaths, 1);
> +	repo_cfg_int(r, "commitgraph.changedpathsversion",
> +		     &r->settings.commit_graph_changed_paths_version,
> +		     readChangedPaths ? 1 : 0);

And here we default to 'true' and '1', respectively. This allows 
'commitGraph.readChangedPaths=false' to override
'commitGraph.changedPathsVersion=1'. Should that implication be
documented?

Thanks,
-Stolee
