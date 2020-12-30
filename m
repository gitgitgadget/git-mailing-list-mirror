Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A98C433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 03:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC6C920782
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 03:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgL3DYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 22:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL3DYh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 22:24:37 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195BDC061799
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 19:23:56 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id az16so7244228qvb.5
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 19:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sIWLLZs+s4ivkmQxv9+r0EaO1hEjyS0/gxn8Wc+CYvs=;
        b=JC40wQ/CpJ9KZnFap6LyX27DIT2j7IR7187NS0MCiEjEKAs6xblPHGAhVgfn+n1CiH
         Fs55J5uzICfr6s3YgMEsOnjCqyHjCdTxBI2IeOnPC4wNHYrqAKTblJjkX3JexUBcxA6G
         g/LvRFL47LHPTl63oYJk77RHXFdlB+tZzwAgGENCoRZ28kKBdgcuB/hteICbQX2i/wBL
         +ja98+d39kZ5uVRyESDZ6E3pozZ+wgtLhSRtZxyapnp+qqsPv8C6v++bXOzUkTtrBefW
         n0ZvmbwkpX31KVqzVbtkgMRlxSEGGIZDTA51gtM9yF0fQWXQhbNlgA6g6Vtq4ofJw0jS
         2E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sIWLLZs+s4ivkmQxv9+r0EaO1hEjyS0/gxn8Wc+CYvs=;
        b=J2psxvN3nD8xacXGZOWTVt4H+41OTtzR7PA9tH6J+u+LB54LvcVPxvWwkyLmV0lHv1
         wOhEXlj/AmF61aOpZnuWBxdKBIroYp0XnZirz7hoLbGc0UxdcOepAJ+QkK24vAfDysn2
         9hNoqPZgb01p8t8p/LKBIRnnzDBTav0e/oIRMuDg9AuKO1ZdmYFnGDtKCRX9S/E+kysS
         ATPrpusiTISqnZ17sTJdqxjh0IOujy77slbZYqVLplNnAt49h/HJbFzj5KnqzG47KCzG
         jUg7fOfc9YMOz3tVLK2iDUz/h0SWuP47rel0tsnVaJzD2lNB1D0xvDGkdw1CBKukSaaz
         g6xg==
X-Gm-Message-State: AOAM531bbbQ8r+PU0pDjxVbBD5DHZr//CEcIgvniKmtBJm8VTm77SfzR
        xTtWSCogxjLpXWhoanwEIYs=
X-Google-Smtp-Source: ABdhPJyJXjHVPICp4QJztNi1yIaMjd0V2w0CnmO9Y6FOoSfHOhvqFEPv5bLqH5/d8OyORscnm3v49w==
X-Received: by 2002:a05:6214:c3:: with SMTP id f3mr55062017qvs.36.1609298636050;
        Tue, 29 Dec 2020 19:23:56 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id v4sm26658078qth.16.2020.12.29.19.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 19:23:55 -0800 (PST)
Subject: Re: [PATCH v5 09/11] commit-graph: use generation v2 only if entire
 chain does
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <a3a70a1edd0949ff3088fae625afa68fc61975df.1609154169.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2e89c6e1-e8e8-0d51-5670-038b4e296d93@gmail.com>
Date:   Tue, 29 Dec 2020 22:23:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <a3a70a1edd0949ff3088fae625afa68fc61975df.1609154169.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/28/2020 6:16 AM, Abhishek Kumar via GitGitGadget wrote:
> From: Abhishek Kumar <abhishekkumar8222@gmail.com>

...

> +static void validate_mixed_generation_chain(struct commit_graph *g)
> +{
> +	int read_generation_data;
> +
> +	if (!g)
> +		return;
> +
> +	read_generation_data = !!g->chunk_generation_data;
> +
> +	while (g) {
> +		g->read_generation_data = read_generation_data;
> +		g = g->base_graph;
> +	}
> +}
> +

This method exists to say "use generation v2 if the top layer has it"
and that helps with the future layer checks.

> @@ -2239,6 +2263,7 @@ int write_commit_graph(struct object_directory *odb,
>  		struct commit_graph *g = ctx->r->objects->commit_graph;
>  
>  		while (g) {
> +			g->read_generation_data = 1;
>  			g->topo_levels = &topo_levels;
>  			g = g->base_graph;
>  		}

However, here you just turn them on automatically.

I think the diff you want is here:

 		struct commit_graph *g = ctx->r->objects->commit_graph;
 
+ 		validate_mixed_generation_chain(g);
+ 
 		while (g) {
 			g->topo_levels = &topo_levels;
 			g = g->base_graph;
 		}

But maybe you have a good reason for what you already have.

I paid attention to this because I hit a problem in my local testing.
After trying to reproduce it, I think the root cause is that I had a
commit-graph that was written by an older version of your series, so
it caused an unexpected pairing of an "offset required" bit but no
offset chunk.

Perhaps this diff is required in the proper place to avoid the
segfault I hit, in the case of a malformed commit-graph file:

diff --git a/commit-graph.c b/commit-graph.c
index c8d7ed1330..d264c90868 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -822,6 +822,9 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 		offset = (timestamp_t)get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
 
 		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
+			if (!g->chunk_generation_data_overflow)
+				die(_("commit-graph requires overflow generation data but has none"));
+
 			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
 			graph_data->generation = get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
 		} else

Your tests in this patch seem very thorough, covering all the cases
I could think to create this strange situation. I even tried creating
cases where the overflow would be necessary. The following test actually
fails on the "graph_read_expect 6" due to the extra chunk, not the 'write'
process I was trying to trick into failure.

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 8e90f3423b..cfef8e52b9 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -453,6 +453,20 @@ test_expect_success 'prevent regression for duplicate commits across layers' '
        git -C dup commit-graph verify
 '
 
+test_expect_success 'upgrade to generation data succeeds when there was none' '
+	(
+		cd dup &&
+		rm -rf .git/objects/info/commit-graph* &&
+		GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph \
+			write --reachable &&
+		GIT_COMMITTER_DATE="1980-01-01 00:00" git commit --allow-empty -m one &&
+		GIT_COMMITTER_DATE="2090-01-01 00:00" git commit --allow-empty -m two &&
+		GIT_COMMITTER_DATE="2000-01-01 00:00" git commit --allow-empty -m three &&
+		git commit-graph write --reachable &&
+		graph_read_expect 6
+	)
+'
+
 NUM_FIRST_LAYER_COMMITS=64
 NUM_SECOND_LAYER_COMMITS=16
 NUM_THIRD_LAYER_COMMITS=7

Thanks,
-Stolee
