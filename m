Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B9811F424
	for <e@80x24.org>; Fri, 20 Apr 2018 07:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbeDTH1V (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 03:27:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38534 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754049AbeDTH1T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 03:27:19 -0400
Received: by mail-wr0-f194.google.com with SMTP id h3-v6so20225489wrh.5
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 00:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mLTbbgy+H8jpTExtgP0/gbnAgkVWmkYI+5P30p9xwVQ=;
        b=U6HumYpd9Fy3kbyXQkE3qHxd1Lssjh2A0nhG7hjMCmWW03pNgEx1D11pN+KppeTuM2
         8D6iGEjzBWF/1EUXtNrAhv4FkyON0O47w57tFmmwVJDAZguE+0lVpqs7P47WsGihT3UK
         zoNVZTki4hDqoBdaVRwBXO5eNkk8gWt1CGN9JXHugK7ciY27VP+g6jTDSXF7m8p7Wauq
         LsIoaYsUBOCYyJaLo5auTfzPjWC9ZXuez8wU+euq4OthU3j04AVtbtzrY5Rd9GfJHTZw
         w3MA2BU8461ZR81BwOu2Yh3MKdBvlDJa7An5BRUoOz7CYjMMS4v+FV459vBvBfVVBRcD
         Vdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=mLTbbgy+H8jpTExtgP0/gbnAgkVWmkYI+5P30p9xwVQ=;
        b=XMogWEG3a3f2+evthCZxf6tVmSlUxKizZsoRFD2osV8Ah0H4EAffi7CNxfRSGi2LCv
         GcEiZrqmlIkCQFywUyuqarQ1pGnrSSFec1r5RRB3qRZ2DMmkX+1gaAnCO/fYVnpzEoAH
         PH+ITacbr12vnXIsiuZSW2Sw2XzJPVrPuI9dJ51UJXdosf5uq0IRnD2nY35JuIaRfMQd
         Yhs28ieES09usWD4HzDgZ7pQkSinMNkNNBAotNwdws0RhWvAUJzcejI1jMKmMlZLsi+0
         h3z79tG13ifCdkdz54O578jQZauz1kfu4tJ8Nk3bywOxesCxjIuhrJ48o5CqzyN2dh4w
         6ReQ==
X-Gm-Message-State: ALQs6tD2V4j+4WJ1X2v/2wfvUoRGllJBWsq7Bf8BfM4tpyFR+CfQd9bE
        eRMxjbn4kFkOkxwmDic7wXL+unJb
X-Google-Smtp-Source: AB8JxZoHKv0xzk5QLtEJTg459Nw3c5MbHdJFSqAoj7jFPPVAeiMqJC3Qzv/+R0iHT8ALfNABGmhhvw==
X-Received: by 10.28.193.11 with SMTP id r11mr1124126wmf.120.1524209237887;
        Fri, 20 Apr 2018 00:27:17 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id n64sm1044858wmd.11.2018.04.20.00.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 00:27:16 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 05/12] commit-graph: check fanout and lookup table
References: <20180417181028.198397-1-dstolee@microsoft.com>
        <20180417181028.198397-6-dstolee@microsoft.com>
Date:   Fri, 20 Apr 2018 09:27:15 +0200
In-Reply-To: <20180417181028.198397-6-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 18:10:41 +0000")
Message-ID: <864lk6fics.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> While running 'git commit-graph check', verify that the object IDs
> are listed in lexicographic order and that the fanout table correctly
> navigates into that list of object IDs.

All right.  I think we can also sanity check the fanout table (for
example that it has 256 elements), see below.

>
> In anticipation of checking the commits in the commit-graph file
> against the object database, parse the commits from that file in
> advance. We perform this parse now to ensure the object cache contains
> only commits from this commit-graph file.

I guess this part could be a separate commit (a separate patch), because
it is not connected to the earlier part.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

No tests that it detects broken commit-graph file (e.g. one that is
truncated)?

>
> diff --git a/commit-graph.c b/commit-graph.c
> index 6d0d303a7a..6e3c08cd5c 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -835,6 +835,9 @@ static int check_commit_graph_error;
>  
>  int check_commit_graph(struct commit_graph *g)
>  {
> +	uint32_t i, cur_fanout_pos = 0;
> +	struct object_id prev_oid, cur_oid;
> +
>  	if (!g) {
>  		graph_report(_("no commit-graph file loaded"));
>  		return 1;
> @@ -859,5 +862,36 @@ int check_commit_graph(struct commit_graph *g)
>  	if (g->hash_len != GRAPH_OID_LEN)
>  		graph_report(_("commit-graph has incorrect hash length: %d"), g->hash_len);
>  
> +	for (i = 0; i < g->num_commits; i++) {
> +		struct commit *graph_commit;
> +
> +		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
> +
> +		if (i > 0 && oidcmp(&prev_oid, &cur_oid) >= 0)
> +			graph_report(_("commit-graph has incorrect oid order: %s then %s"),

Good.  Reporting what problem is; we could have also reported the
position at which there is this problem.

> +
> +		oid_to_hex(&prev_oid),
> +		oid_to_hex(&cur_oid));
> +		oidcpy(&prev_oid, &cur_oid);
> +
> +		while (cur_oid.hash[0] > cur_fanout_pos) {
> +			uint32_t fanout_value = get_be32(g->chunk_oid_fanout + cur_fanout_pos);
> +			if (i != fanout_value)
> +				graph_report(_("commit-graph has incorrect fanout value: fanout[%d] = %u != %u"),

Good.  Reporting details of the problem.

> +					     cur_fanout_pos, fanout_value, i);
> +
> +			cur_fanout_pos++;
> +		}

One thing you don't check here is that fanout is closed, that is all the
rest of fanout data up to 256th element (if they are any) all points at
the same position past the last element of OID Lookup chunk.

> +
> +		graph_commit = lookup_commit(&cur_oid);
> +
> +		if (!parse_commit_in_graph_one(g, graph_commit))
> +			graph_report(_("failed to parse %s from commit-graph"), oid_to_hex(&cur_oid));

Doesn't whis check Commit Data (CDAT) chunk, and therefore should better
be in a separate commit?

> +
> +		if (graph_commit->graph_pos != i)
> +			graph_report(_("graph_pos for commit %s is %u != %u"), oid_to_hex(&cur_oid),
> +				     graph_commit->graph_pos, i);

Hmmm... it seems to me that the above does not check that commit-graph
file is correct, but that the parsing code is correct.

> +	}
> +
>  	return check_commit_graph_error;
>  }
