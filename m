Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C80C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 11:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BDEE206A4
	for <git@archiver.kernel.org>; Tue,  5 May 2020 11:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew/H+ta6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgEELux (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 07:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEELux (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 07:50:53 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E29C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 04:50:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c10so1902906qka.4
        for <git@vger.kernel.org>; Tue, 05 May 2020 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r0O/i7GBRkYD2r9cH8euqJ1S50QSDipDzNCJGTv7HMI=;
        b=ew/H+ta6G5yu81qV3eCzdABLRns5zkzteA5w+kmiWYXi92nks/Bk+vo0wmVjcaHWqc
         muATQexQiHx3DJnRMkNkz7mSG4OM9jMUpeQ9NXxWpITUBsSMjXD6EYOGUxQo0Oh7h4n1
         eQEoePE16O+y7Ix6DWVGlMnaXE3VJtpB6tKRqW9A64zoQC2QJXzXgnsy7BaNajnEofxp
         tJ5aIXioNyMRGKmoCD9T1HMpgenrXYJEAaovcKv5b7YK7R3bfLIZCP6Vc0If7/gf3FYr
         gk1PIp4uAEa50Lt/2RKhwWmvH/FZ8fnRPse/Bfbvx9LhBsK/2y9WDGPqPotE3UnwsKEU
         D4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r0O/i7GBRkYD2r9cH8euqJ1S50QSDipDzNCJGTv7HMI=;
        b=C4INzukUhmgRGQwq+DYyXKFKerS15WR1iODW0L5r4sas8inVue57Lq6YCdO2CV4IO2
         KvZJuk6+N3nVmA6tC+M+Y8WniolNZV0TK+ozs46sFs82vSdkXK0J1vt1ZBRZBRBaI5JJ
         MmdYsrJGOEOIRmslHuFNPRPLs1BCGVN3El3MPN7C7zR7sF7j4IE1lDjC+Lq/9sf/6CH+
         u3gwRiS/Q+8KoHuUt6gFoqYQ0mz1cjCH8goZ2Sc7QcNjO3qXSZOZ7CSTgw6rDhnhSw4G
         Tgk+xMPH2b7u0nQ6bsClYD9kdY4I0/QaFP13/G9oG80xScXarvClBeC9BcVLcjq5svTT
         DjLg==
X-Gm-Message-State: AGi0PuYh06RBCVBFroLT0YJl95g5CCwIqhhEVQ190Dfd1P0WG6fBpN3O
        1J1oCMhTXI6CxtgxZ7/3fvE=
X-Google-Smtp-Source: APiQypKVwKVHXC3G8gIs6Rf2rH0Mk4jYVw3HnOCy7Sx7NqZDZ5GwKjxW26Vt12kf4gvS/bNygSsJgA==
X-Received: by 2002:a05:620a:69a:: with SMTP id f26mr3108437qkh.430.1588679452036;
        Tue, 05 May 2020 04:50:52 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b42sm1599085qta.29.2020.05.05.04.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 04:50:51 -0700 (PDT)
Subject: Re: [PATCH 2/8] commit-graph.c: show progress of finding reachable
 commits
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
References: <cover.1588641176.git.me@ttaylorr.com>
 <5bdbeaf374b6050670f800fcdd3b54ddd0750754.1588641176.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b8f393fa-fec8-205e-0987-f4f6ff9b3531@gmail.com>
Date:   Tue, 5 May 2020 07:50:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <5bdbeaf374b6050670f800fcdd3b54ddd0750754.1588641176.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/4/2020 9:13 PM, Taylor Blau wrote:
> When 'git commit-graph write --reachable' is invoked, the commit-graph
> machinery calls 'for_each_ref()' to discover the set of reachable
> commits.
> 
> Right now the 'add_ref_to_set' callback is not doing anything other than
> adding an OID to the set of known-reachable OIDs. In a subsequent
> commit, 'add_ref_to_set' will presumptively peel references. This
> operation should be fast for repositories with an up-to-date
> '$GIT_DIR/packed-refs', but may be slow in the general case.
> 
> So that it doesn't appear that 'git commit-graph write' is idling with
> '--reachable' in the slow case, add a progress meter to provide some
> output in the meantime.
> 
> In general, we don't expect a progress meter to appear at all, since
> peeling references with a 'packed-refs' file is quick. If it's slow and
> we do show a progress meter, the subsequent 'fill_oids_from_commits()'
> will be fast, since all of the calls to
> 'lookup_commit_reference_gently()' will be no-ops.
> 
> Both progress meters are delayed, so it is unlikely that more than one
> will appear. In either case, this intermediate state will go away in a
> handful of patches, at which point there will be at most one progress
> meter.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  commit-graph.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 00da281f39..8f61256b0a 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1320,6 +1320,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>  
>  struct refs_cb_data {
>  	struct oidset *commits;
> +	struct progress *progress;
>  };
>  
>  static int add_ref_to_set(const char *refname,
> @@ -1328,6 +1329,8 @@ static int add_ref_to_set(const char *refname,
>  {
>  	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
>  
> +	display_progress(data->progress, oidset_size(data->commits) + 1);
> +
>  	oidset_insert(data->commits, oid);
>  	return 0;
>  }
> @@ -1342,12 +1345,17 @@ int write_commit_graph_reachable(struct object_directory *odb,
>  
>  	memset(&data, 0, sizeof(data));
>  	data.commits = &commits;
> +	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
> +		data.progress = start_delayed_progress(
> +			_("Finding reachable commits"), 0);

Is this the right phrase to use? This seems too close to the progress
indicator "Expanding reachable commits in commit graph" which is walking
commits.

An alternative could be: "Collecting referenced commits"

Outside of this string, I have no complaints. I also don't feel too
strongly about the string, either.

Thanks,
-Stolee

 

