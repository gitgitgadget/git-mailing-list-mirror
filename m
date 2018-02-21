Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9F01F404
	for <e@80x24.org>; Wed, 21 Feb 2018 19:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751633AbeBUTZo (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 14:25:44 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38273 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbeBUTZl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 14:25:41 -0500
Received: by mail-wr0-f195.google.com with SMTP id n7so7640502wrn.5
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 11:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XnauEjY4NqO893LT94Cqr5vwKn4ePDdYCtOWlqGwpz0=;
        b=PLlT4t2M7e2xCseWXh4r2ZMJwc1lFr5b6b9jFaoOmnvopBcAz1B5h+J4BjNHWt8Err
         eF3OstUm4r2dE8h23rXEc/94pa5gc0ZhbU2ZAUT2PNI44rKUV1xJoYFtTSOG56A9/8RJ
         02uxlznSJCTdxfOxftJuaj73IDI3Taf0qAlWCfiOtcye+SswAIjXPMnK3m2Ygn5nXJs8
         JDq7+gH6WXFdidjgmNg0sYgKCE5J5W7NEbX0FQ2/MPyqLMQcmrpuiEjiBsBFzC7BOcIO
         kVtrHNu4on1oyunMJ8DgIFcZryQCSVmw8hya9k29AIupT0/6csKWdlL7G34ibpytVWnM
         sMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XnauEjY4NqO893LT94Cqr5vwKn4ePDdYCtOWlqGwpz0=;
        b=t5mMWKPBEM6bN0moTlXx6mRBlpsd8Ua4GcWLqZ9iJsNdcQOem1ZJEX45HMWnDWnZuL
         LCsV86g/CnxO793OB3xipEAK4HOCIVy/yQVYay/CkxIdlw6lqscyzk4uJUGD0QDz9hPt
         rWLrW3XXTGv8T+8+3b7qr4Kc7v+Fa5Mopd9uvKunumi0X2VrdZ4CXKhz3seKnWNpp/WQ
         UdDGfrMQR2WlZ09ZUCnqqWiHE94jdsN5HIYy/Y2gfCub10Y2x/MoPamD6zsFogkL5SIr
         7JD8otFLQVa2VNnLSIkbtp4NgCYAVmmlDIblAvMpjEGIksKvM5g50V7kuNZ+jxiqLxOM
         YeAw==
X-Gm-Message-State: APf1xPAekNL2H284aF5BUSfHLc1zzIUQ2HYYG4lGun/8+Jznc+QsvfVG
        rDZkd4xxyePscPucWRK1S1M=
X-Google-Smtp-Source: AH8x225GRn81IU5BgssLn+ohv5IgslifThoCMWcJ0wNczv8j8fTV4NAATg83Pp8vCVtSo6NYKu/arg==
X-Received: by 10.28.230.87 with SMTP id d84mr3043848wmh.133.1519241139113;
        Wed, 21 Feb 2018 11:25:39 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p29sm12669307wmf.3.2018.02.21.11.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 11:25:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 05/13] commit-graph: implement 'git-commit-graph write'
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-6-git-send-email-dstolee@microsoft.com>
Date:   Wed, 21 Feb 2018 11:25:37 -0800
In-Reply-To: <1519066406-81663-6-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Mon, 19 Feb 2018 13:53:18 -0500")
Message-ID: <xmqq8tbmywjy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +static int graph_write(int argc, const char **argv)
> +{
> + ...
> +	graph_name = write_commit_graph(opts.obj_dir);
> +
> +	if (graph_name) {
> +		printf("%s\n", graph_name);
> +		FREE_AND_NULL(graph_name);
> +	}
> +
> +	return 0;
> +}

After successfully writing a graph file out, write_commit_graph()
signals that fact by returning a non-NULL pointer, so that this
caller can report the filename to the end user.  This caller
protects itself from a NULL return, presumably because the callee
uses it to signal an error when writing the graph file out?  

Is it OK to lose that 1-bit of information, or should we have more like

	if (graph_name) {
		printf;
		return 0;
	} else {
		return -1;
	}

>  int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  {
>  	static struct option builtin_commit_graph_options[] = {
> -		{ OPTION_STRING, 'p', "object-dir", &opts.obj_dir,
> +		{ OPTION_STRING, 'o', "object-dir", &opts.obj_dir,
>  			N_("dir"),
>  			N_("The object directory to store the graph") },
>  		OPT_END(),

The same comment for a no-op patch from an earlier step applies
here, and we have another one that we saw above in graph_write().

> @@ -31,6 +67,11 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  			     builtin_commit_graph_usage,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>  
> +	if (argc > 0) {
> +		if (!strcmp(argv[0], "write"))
> +			return graph_write(argc, argv);

And if we fix "graph_write" to report an error with negative return,
this needs to become something like

		return !!graph_write(argc, argv);

as we do not want to return a negative value to be passed via
run_builtin() to exit(3) in handle_builtin().

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> new file mode 100755
> index 0000000..6a5e93c
> --- /dev/null
> +++ b/t/t5318-commit-graph.sh
> @@ -0,0 +1,119 @@
> +#!/bin/sh
> +
> +test_description='commit graph'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup full repo' '
> +	rm -rf .git &&

I am perfectly OK with creating a separate subdirectory called
'full' in the trash directory given by the test framework, but
unless absolutely necessary I'd rather not to see "rm -rf", 
especially on ".git", in our test scripts.  People can screw up
doing various things (like copying and pasting).

> +	mkdir full &&
> +	cd full &&
> +	git init &&
> +	objdir=".git/objects"
> +'

And I absolutely do not want to see "cd full" that leaves and stays
in the subdirectory after this step is done.  

Imagine what happens if any earlier step fails before doing "cd
full", causing this "setup full" step to report failure, and then
the test goes on to the next step?  We will not be in "full" and
worse yet because we do not have "$TRASH_DIRECTORY/.git" (you
removed it), the "git commit-graph write --object-dir" command we
end up doing next will see the git source repository as the
repository it is working on.  Never risk trashing our source
repository with your test.  That is why we give you $TRASH_DIRECTORY
to play in.  Make use of it when you can.

I'd make this step just a single

	git init full

and then the next one

	git -C full commit-graph write --object-dir .

In later tests that have multi-step things, I'd instead make them

	(
		cd full &&
		... whatever you do  &&
		... in that separate  &&
		... 'full' repository
	)

if I were writing this test *and* if I really wanted to do things
inside $TRASH_DIRECTORY/full/.git repository.  I am not convinced
yet about the latter.  I know that it will make certain things
simpler to use a separate /full hierarchy (e.g. cleaning up, having
another unrelated test repository, etc.) while making other things
more cumbersome (e.g. you need to be careful when you "cd" and the
easiest way to do so is to ( do things in a subshell )).  I just do
not know what the trade-off would look like in this particular case.

A simple rule of thumb I try to follow is not to change $(pwd) for
the process that runs these test_expect_success shell functions.

> +
> +test_expect_success 'write graph with no packs' '
> +	git commit-graph write --object-dir .
> +'
> +
> +test_expect_success 'create commits and repack' '
> +	for i in $(test_seq 3)
> +	do
> +		test_commit $i &&
> +		git branch commits/$i
> +	done &&
> +	git repack
> +'
