Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFABEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 13:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjFTNjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjFTNjd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 09:39:33 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959921713
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 06:39:11 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5702116762fso52774637b3.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1687268351; x=1689860351;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTjz3m7GOJWKIKRRMZytRCbOmb0afCJbbSG4PwnZxLY=;
        b=Vkm1bXAPwq+d+DzLud/9dedcpTsBRPU+ERd8PCNG7lDPXdSzV/P90J4q3bBEOVdlF5
         5hMMWtBmHbEiHCSbnPdDTCSlHsc/5Q4DoeZZzXoEpi8yAP5oUHYB73B3RRXIa2palqK5
         DS9CvevAk1Qzucn04+H/BoyT/e5v3QUbnNf7Kb0O2fpUijXd96+Tp/cSQXDuncon0UVu
         sq++EO1fWj/tr7IYkx3QxujN0s1YMAl7aIX78nhBlyEgHADURadWJ5wMKirZ/KIZAjrn
         h7/45fZLBniJPFv+xQ0i0ThfngYChF/mtn7B4+qLnIKC4vPTHQp9jfS10b0aud6ziLK5
         ZbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687268351; x=1689860351;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTjz3m7GOJWKIKRRMZytRCbOmb0afCJbbSG4PwnZxLY=;
        b=CY6Ql7L/eOGY0W/19Yp9cHIRI7IpHL016M2VBAQnD4Y60b2dAc2tC+0IeLyL6zBXZM
         maE/SqT2+MHL3htgdF3fW4xDag/U4YnXNZF7j2uW2pz5vbGkLJIiFSStMjAPM0yMpsWf
         luSCz6dQraBwvLX2X3g6uexwYKEjhleS11wevgGBDChirMXM3UgJMgV/uBUc8OjX4C2/
         L1LgTcrlt1OggOJ68+fhtaAzozvsbWVxcp3yWRsF0up5w0o3mk1HQTNCW120yuo8rus7
         jR3+o0oqcZyOJ7ZDBb9DlQ7wN9fjyoxVGuSuW7Wto5Gs5v1VUYbPlBQE+T5iDGPAKzaj
         sFjg==
X-Gm-Message-State: AC+VfDxb4XXWo5RdTx0KsrE0r1YlJu8rqtg3Gbw6PBYFJm4/PtrvVOV2
        kac9HDIyC+5F/aeflTPsibuZ
X-Google-Smtp-Source: ACHHUZ4y6NtlI1uqSub+sXk1y82su+EsBK7bttpKHmQhNuMe99jjOqP9dU0g6K+7fKYn5aIP4nLB8w==
X-Received: by 2002:a0d:cad1:0:b0:570:8e80:5572 with SMTP id m200-20020a0dcad1000000b005708e805572mr10366191ywd.34.1687268350609;
        Tue, 20 Jun 2023 06:39:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e8fd:3e8c:8558:4cd? ([2600:1700:e72:80a0:e8fd:3e8c:8558:4cd])
        by smtp.gmail.com with ESMTPSA id n66-20020a0dfd45000000b0056d5344b071sm490510ywf.84.2023.06.20.06.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:39:10 -0700 (PDT)
Message-ID: <4c5cadf2-bd70-c56e-3935-fb24b604f411@github.com>
Date:   Tue, 20 Jun 2023 09:39:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 4/4] commit-graph: new filter ver. that fixes murmur3
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1686677910.git.jonathantanmy@google.com>
 <5c65bf8a22d657c58b1109928b4298e95ccb56bf.1686677910.git.jonathantanmy@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <5c65bf8a22d657c58b1109928b4298e95ccb56bf.1686677910.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/13/2023 1:39 PM, Jonathan Tan wrote:

>  commitGraph.changedPathsVersion::
>  	Specifies the version of the changed-path Bloom filters that Git will read and
> -	write. May be 0 or 1. Any changed-path Bloom filters on disk that do not
> +	write. May be 0, 1, or 2. Any changed-path Bloom filters on disk that do not
>  	match the version set in this config variable will be ignored.
>  +
>  Defaults to 1.

Is this a good place to document the planned modification of this default in
future versions of Git?

> +static uint32_t murmur3_seeded_v1(uint32_t seed, const char *data, size_t len)
>  {
>  	const uint32_t c1 = 0xcc9e2d51;
>  	const uint32_t c2 = 0x1b873593;
> @@ -130,8 +187,10 @@ void fill_bloom_key(const char *data,
>  	int i;
>  	const uint32_t seed0 = 0x293ae76f;
>  	const uint32_t seed1 = 0x7e646e2c;
> -	const uint32_t hash0 = murmur3_seeded(seed0, data, len);
> -	const uint32_t hash1 = murmur3_seeded(seed1, data, len);
> +	const uint32_t hash0 = (settings->hash_version == 2
> +		? murmur3_seeded_v2 : murmur3_seeded_v1)(seed0, data, len);
> +	const uint32_t hash1 = (settings->hash_version == 2
> +		? murmur3_seeded_v2 : murmur3_seeded_v1)(seed1, data, len);

This is the critical step. I've not seen this ternary trick within
a function name choice, but it makes for a compact check. Nice.

However, I think the 'settings->hash_version' is the wrong place
to look for the condition. We should be getting this value from the
commit-graph we are reading. (More on this later.)

>  struct bloom_filter_settings {
>  	/*
>  	 * The version of the hashing technique being used.
> -	 * We currently only support version = 1 which is
> +	 * The newest version is 2, which is
>  	 * the seeded murmur3 hashing technique implemented
> -	 * in bloom.c.
> +	 * in bloom.c. Bloom filters of version 1 were created
> +	 * with prior versions of Git, which had a bug in the
> +	 * implementation of the hash function.

...

> +struct graph_read_bloom_data_data {
> +	struct commit_graph *g;
> +	int commit_graph_changed_paths_version;
> +};
> +
>  static int graph_read_bloom_data(const unsigned char *chunk_start,
>  				  size_t chunk_size, void *data)
>  {
> -	struct commit_graph *g = data;
> +	struct graph_read_bloom_data_data *d = data;
> +	struct commit_graph *g = d->g;
>  	uint32_t hash_version;
>  	g->chunk_bloom_data = chunk_start;
>  	hash_version = get_be32(chunk_start);
>  
> -	if (hash_version != 1)
> +	if (hash_version != d->commit_graph_changed_paths_version)
>  		return 0;

This makes it appear like we cannot read a commit-graph that has
a Bloom filter version that doesn't match the configured version.

This seems incorrect. If we want to configure to _write_ v2, we
should still be able to _read_ v1 concurrently until those v2
filters are written.

This check should be:

	if (hash_version <= 0 || hash_version > 2)
		return 0;

and then 

	g->filter_hash_version = hash_version;

to store this hash version somewhere in the graph. This way, we
can read any commit-graph file and will not suffer performance
problems in the time between setting the config value and writing
the new commit-graph file.

> -	if (s->commit_graph_changed_paths_version == 1) {
> +	if (s->commit_graph_changed_paths_version == 1
> +	    || s->commit_graph_changed_paths_version == 2) {

Perhaps this could just be

	if (s->commit_graph_changed_paths_version) {

to say "not zero means we still read the filters". Though, since
this config _should_ mean "which version do we _write_?" it might
be good to go back on the "unifying the two config options".

> +		struct graph_read_bloom_data_data data = {
> +			.g = graph,
> +			.commit_graph_changed_paths_version = s->commit_graph_changed_paths_version
> +		};
>  		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
>  			   &graph->chunk_bloom_indexes);
>  		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
> -			   graph_read_bloom_data, graph);
> +			   graph_read_bloom_data, &data);
>  	}

Much of this block will not be necessary as we don't need to
send the repo settings into the read_chunk() method.

> +	if (r->settings.commit_graph_changed_paths_version < 0
> +	    || r->settings.commit_graph_changed_paths_version > 2) {
> +		warning(_("attempting to write a commit-graph, but 'commitgraph.changedPathsVersion' (%d) is not supported"),
> +			r->settings.commit_graph_changed_paths_version);
> +		return 0;

I see the "< 0" means we aren't considering the case of disabling 
writes with the zero value. We should exit early if we see a zero
here, for extra safety.

> +	}
> +	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version == 2
> +		? 2 : 1;

Once we've checked that this value is not zero, we can do this:

	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version;


>  		/* We have changed-paths already. Keep them in the next graph */
> -		if (g && g->chunk_bloom_data) {
> +		if (g && g->bloom_filter_settings) {
>  			ctx->changed_paths = 1;
>  			ctx->bloom_settings = g->bloom_filter_settings;
>  		}


> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -450,4 +450,35 @@ test_expect_success 'version 1 changed-path used when version 1 requested' '
>  		test_bloom_filters_used "-- $CENT")
>  '
>  
> +test_expect_success 'version 1 changed-path not used when version 2 requested' '
> +	(cd highbit1 &&
> +		git config --add commitgraph.changedPathsVersion 2 &&
> +		test_bloom_filters_not_used "-- $CENT")
> +'

I think this test is the wrong behavior. We should be able to use version 1
when version 2 is requested.

Instead, start with version 1, and _upgrade_ to version 2 and then check
which version exists in the file.

We should only _not_ use the filters if the version is 0 (or
commitGraph.readChangedPaths=false). I think this might be a good enough reason
to 

> +
> +test_expect_success 'set up repo with high bit path, version 2 changed-path' '
> +	git init highbit2 &&
> +	git -C highbit2 config --add commitgraph.changedPathsVersion 2 &&
> +	test_commit -C highbit2 c2 "$CENT" &&
> +	git -C highbit2 commit-graph write --reachable --changed-paths
> +'
> +
> +test_expect_success 'check value of version 2 changed-path' '
> +	(cd highbit2 &&
> +		printf "c01f" >expect &&
> +		get_first_changed_path_filter >actual &&
> +		test_cmp expect actual)
> +'
> +
> +test_expect_success 'version 2 changed-path used when version 2 requested' '
> +	(cd highbit2 &&
> +		test_bloom_filters_used "-- $CENT")
> +'
> +
> +test_expect_success 'version 2 changed-path not used when version 1 requested' '
> +	(cd highbit2 &&
> +		git config --add commitgraph.changedPathsVersion 1 &&
> +		test_bloom_filters_not_used "-- $CENT")
> +'

Again, this is also the wrong situation.

Thanks,
-Stolee
