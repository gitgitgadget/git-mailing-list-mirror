Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1EFC47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 12:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2DD8206B9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 12:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzaxW0g+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgEEMKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 08:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728489AbgEEMKn (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 08:10:43 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26879C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 05:10:43 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id p13so816799qvt.12
        for <git@vger.kernel.org>; Tue, 05 May 2020 05:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aE+IEYN3Lw45T3pqqTSmQ4ROADcpX+dt8wjEmzEB78M=;
        b=UzaxW0g+Ii7TKzH/j0Dm6LVYo3Zg8OsJ73tHedLfZ+WpjXUMlBVq3MqI9Ko4jGJAa6
         lS/4KLdxwaa28VwfPWMkZHClneY+uf4ND4+zHHg2VoreXAm6UfbJzk0s58i+YhMMWyIF
         2I4KpcDEW0MvTeT61R1r3Wt7R9cDbJdl0C9n60kuqGXpTcWoRAk9Re3FC0gC/TpVmehj
         LJSqTXxXmWe9zWGdlJjA1kjz9K5/RFcwozhaAgKDW02QYPLZooWx0XWmPK8C0X3STl33
         9gPIP1ASSVfK8JLdbHiYLDkjrDNqbOX69bNd772i0JnFKtISJaXqQMktMFnm1iUzO9FW
         7uUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aE+IEYN3Lw45T3pqqTSmQ4ROADcpX+dt8wjEmzEB78M=;
        b=hzQ5fB+NHSBMyVG6HSgqfpBW0z6v1ZXmKmZjobtsTXkNUxNwcWDPO2wpuU1OdVuZel
         oOxXNetA94XjsW35XGtnoV8E/c5++rdvEaQxbM8dcOPoenzLaED+r6C6Y7hMAzME5Tm9
         LCb3QTedv/qenG7NXUZP3mQA4MWelC5WEVNexGcTDnUfd8kFeR7Bnd9xm8G0KaDNIdX8
         JZyqz3Mi0/U/eRPsMRmWADEJGdlzw8pyvIVqfeLWKZBf6iH+1pUtuzPk6Tok43UIoQyq
         nlmei39yJDO4POZsNMuN/8XvxkrPw3HvTJ1W4r86lVrn1VcFiPN4nZM+c+lafXlB1ltK
         kbzw==
X-Gm-Message-State: AGi0PuZhhaGPXVtvPPjSqdMOBv30+vqjAXvAAT+urYpOtZQ+/jBC9oy+
        TMAitrwJ3zzlnsckk6fo7Tc=
X-Google-Smtp-Source: APiQypL9sq7V7s/giLbzXcaHrtPv4b7SsH4445lQhxiH6uCyQXRrnzoPzwcFsBShQzRSw3ecC6swhA==
X-Received: by 2002:a0c:e305:: with SMTP id s5mr2425904qvl.234.1588680642227;
        Tue, 05 May 2020 05:10:42 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n206sm956394qke.20.2020.05.05.05.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 05:10:41 -0700 (PDT)
Subject: Re: [PATCH 8/8] commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
References: <cover.1588641176.git.me@ttaylorr.com>
 <6c2d130b0cd4b6a8a541b362ae7dd44d4c282e3f.1588641176.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <81fb0f5e-e7e1-7541-d6c7-36828190c95b@gmail.com>
Date:   Tue, 5 May 2020 08:10:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <6c2d130b0cd4b6a8a541b362ae7dd44d4c282e3f.1588641176.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/4/2020 9:14 PM, Taylor Blau wrote:
> Since 7c5c9b9c57 (commit-graph: error out on invalid commit oids in
> 'write --stdin-commits', 2019-08-05), the commit-graph builtin dies on
> receiving non-commit OIDs as input to '--stdin-commits'.
> 
> This behavior can be cumbersome to work around in, say, the case of
> piping 'git for-each-ref' to 'git commit-graph write --stdin-commits' if
> the caller does not want to cull out non-commits themselves. In this
> situation, it would be ideal if 'git commit-graph write' wrote the graph
> containing the inputs that did pertain to commits, and silently ignored
> the remainder of the input.
> 
> Some options have been proposed to the effect of '--[no-]check-oids'
> which would allow callers to have the commit-graph builtin do just that.
> After some discussion, it is difficult to imagine a caller who wouldn't
> want to pass '--no-check-oids', suggesting that we should get rid of the
> behavior of complaining about non-commit inputs altogether.
> 
> If callers do wish to retain this behavior, they can easily work around
> this change by doing the following:
> 
>     git for-each-ref --format='%(objectname) %(objecttype) %(*objecttype)' |
>     awk '/commit/ { print $1 }' |
>     git commit-graph write --stdin-commits

I appreciate that you included the workaround here for posterity. That
allows anyone complaining to bisect to these instructions.

> To make it so that valid OIDs that refer to non-existent objects are
> indeed an error after loosening the error handling, perform an extra
> lookup to make sure that object indeed exists before sending it to the
> commit-graph internals.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-commit-graph.txt |  6 ++++--
>  builtin/commit-graph.c             | 10 +++++-----
>  commit-graph.c                     |  2 --
>  commit-graph.h                     | 10 ++++------
>  t/t5318-commit-graph.sh            | 15 +++++++++++----
>  5 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 53a650225a..fcac7d12e1 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -47,8 +47,10 @@ with `--stdin-commits` or `--reachable`.)
>  +
>  With the `--stdin-commits` option, generate the new commit graph by
>  walking commits starting at the commits specified in stdin as a list
> -of OIDs in hex, one OID per line. (Cannot be combined with
> -`--stdin-packs` or `--reachable`.)
> +of OIDs in hex, one OID per line. OIDs that resolve to non-commits
> +(either directly, or by peeling tags) are silently ignored. OIDs that
> +are malformed, or do not exist generate an error. (Cannot be combined
> +with `--stdin-packs` or `--reachable`.)
>  +
>  With the `--reachable` option, generate the new commit graph by walking
>  commits starting at all refs. (Cannot be combined with `--stdin-commits`
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 9eec68572f..3637d079fb 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -153,13 +153,14 @@ static int read_one_commit(struct oidset *commits, struct progress *progress,
>  
>  	display_progress(progress, oidset_size(commits) + 1);
>  
> +	if (oid_object_info(the_repository, &oid, NULL) < 0) {
> +		error(_("object %s does not exist"), hash);
> +		return 1;
> +	}
> +

If we get a non-existent object, then this will cause us to fail
the command, right?

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 89020d3d44..74f93f0a17 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -84,11 +84,18 @@ graph_read_expect() {
>  
>  test_expect_success 'exit with correct error on bad input to --stdin-commits' '
>  	cd "$TRASH_DIRECTORY/full" &&
> -	echo HEAD | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
> +	# invalid, non-hex OID
> +	echo HEAD >in &&
> +	test_expect_code 1 git commit-graph write --stdin-commits <in 2>stderr &&
>  	test_i18ngrep "unexpected non-hex object ID: HEAD" stderr &&
> -	# valid tree OID, but not a commit OID
> -	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
> -	test_i18ngrep "invalid commit object id" stderr
> +	# non-existent OID
> +	echo $ZERO_OID >in &&
> +	test_expect_code 1 git commit-graph write --stdin-commits <in 2>stderr &&
> +	test_i18ngrep "does not exist" stderr &&

And here you verify that it fails at that point. Excellent!

> +	# valid commit and tree OID
> +	git rev-parse HEAD HEAD^{tree} >in &&
> +	git commit-graph write --stdin-commits <in &&
> +	graph_read_expect 3
>  '

This is an excellent series! Thanks.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>



