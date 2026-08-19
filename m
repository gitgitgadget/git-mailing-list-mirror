Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D447C394E8A
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125198; cv=none; b=f5i/B4ncRX0mng1E3ePbGAKtshuntZUy3OSCxGw5/6lLi6tRFpKAz3nVCxmBPWpNwjNzS1ryi4eAuwzLNs/XJIAWs6i+u7k3tt8GNbWFQ0LjV7PhACo5rbMGELK2oeatB1x6lw4WU/oD7gj598oPcg1E8Hj5EgavXj2gUrJxuy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125198; c=relaxed/simple;
	bh=0uCPil/WuiqUYzdDNFeDsJ6y61lzhG6a+wt6FH+VZ3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DadOQn9iJBJz7QEvgewAWxnqILwi4fv3Dn6mMIg2YQoP92W3xiTWO8YiHIn/XBfxRhmkB6rXTNwGe/XOTNP7enFA+Ve6IkFXKmhxh9zd31Bb6Jvb5WzJ8yZkY6GwpC/Yts1rDjMOhHL9JGbxoyrfiyvkSXH0ntfV1iDcQ/S+hSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i9tVw8kz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k5DRUD4k; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i9tVw8kz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k5DRUD4k"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 163B21D00058;
	Wed, 19 Aug 2026 03:39:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 19 Aug 2026 03:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787125195; x=1787211595; bh=4jJc/fM18v
	ywid7YVOrvqDYLLnLPMna8cT9pep5Pc6U=; b=i9tVw8kzVeMsV6aMYEDVIP8LLd
	xuHRPvBmSOuwrhUcwUnxa7SDzFMrrKk7ULULKdq8Mt1vwI9dRmk8syn6+i9o6WNE
	6PsTcwHX7F6vTovKlcOkT9X3AJq7D/1Zex2G7CI7QxMjZL0D/IACg8zGu7sdpi/E
	LpE05NfeTrcvSZFvSNFf31YEhzSdwLp/UQvAP9pknlHcuen8B1RMSuniNZ1HxVBz
	Hne41pGAsnjsmhyVYUoiuns1K7MDvu6rupLrVl/uKBa0UIkC7WWUPqF9Jxec8R7q
	MFghqfZ8B7M8MNxbww2fstaIX6ebsi24cA5J0jnryjoDGmOrEajG9A/Tz2Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787125195; x=1787211595; bh=4jJc/fM18vywid7YVOrvqDYLLnLPMna8cT9
	pep5Pc6U=; b=k5DRUD4kaw7+cesUuLMoCFHNrZ0N/ZmTcHJgd0PRzfAzRd3Ikc2
	RufiBvhmCyb/WZYFFzLyyQSxt4aRQrq1/jBM9roF0FmaaxBas5RjkmZeTYsl0erm
	q7J0FYg85/Kzsr83BCo9Ebr39Itpqqmb7cbKXKi5cYMw5x4i3PaDtyUd83+HA+8/
	mSZmwOI1WrEvfjgO2FuKKSIpa7bIhcv7c93ywVBEVXQgyWxzZFTat+vYGjHuBIVI
	op/ypzC9DkDZmnckBdeF+XZI+4HUDo6C7dYT5iz75Y8faoMlQjKHUbGaU+HtGhnP
	TC4KpET3Of4HE/2nRjD+eyEg3KT9DVvpPGA==
X-ME-Sender: <xms:y12FagnITAyBDg20q1DCDbzA1rZLs6_mQQ_tUs2RI6CDQJmLXYqujg>
    <xme:y12Fal3hSEfTQLChJ7RSLtSHvhcJUov9UA_CzQywval2wWdpPXEorf9bFx4aJKr6b
    e2eVUMJ975nYZWzSoewW8AIDzfaNAVry9wh-3Kb5CdgquTxVmygvQ>
X-ME-Received: <xmr:y12FasR4hnBFQuLRCmOMAhnta5Qs9qAl4p9AqXYru-wPjD3nx5l-V4-fouLWv0KvIF1FNfBbLEiUCtyeS9h2WKsa7f9UPwo9E57L3gNr>
X-ME-Proxy-Cause: dmFkZTEgiJspa/bAzcQKV4KxOnNK6Sc7yQjmsIjJtoMpyrWgoteFYugoyNFINGlmUQdoeR
    AwtetJUmYlWjdw79iyLv6S/ayP/R4keOOtKqDMHDAhYlY7zr/L5kwsJbl/FRYKM965ZyVz
    +iMHOF4MPIg7m7BlqhYCLlgRQzaDRJLhAI6XpvhcEYWUPkPtSZutdWqwpmaNNHQM4gtHoo
    UiAe6jBCKOPb7AjzaTURCs0Ebh79itMGTPXJUD/tCCCum+6J7bSSqb39jZlIQ14MoPBJw8
    F7wTXI1BFIK/E7czh5A3J+D8cQtWOErXS8ugxaU1L9fmPdSOXMr/+Q7MVtt0eUMa0ffDm8
    SKxtbcxu7ctw0usjWpa5q0J2wuVX0TqmakQwq+z7rkwtKRDxk3NQgvojOd11GE4olloibV
    J6MqXCcXhux6Ddo+G6BIoQuHa22nUoIs5yKvPTpqP+qeH1AZBxZVXk97PbMnNoLhLN2L4/
    uGqjf2FN2YXPbuXxcrwIvlmzJ7ZWjEWEz8XnlI0eJidXJhITe9iXp6TKYxefIXNvdrZ85r
    dXKyFHnKxfYEpFZCHtKH+xl6jVWEDKaOeICnznzgDm94iSbO3tMyyQYT+7UAleFTL6fO0m
    DM8KOHSHWygtk4Nch0n3qBpW/OFO7Qf8c4OUKqcxglC3Y9stxOH7LWCtvogw
X-ME-Proxy: <xmx:y12FanvMSy6WUNxH-8Rd3GFgYqAVuCujByZ8gTqOSXWiNZVGFBC9cg>
    <xmx:y12FahYQJ-WZuvELRYx42PhVsooJY9YCigPe27Eapp4Tm-1gQtcyFA>
    <xmx:y12FasuI9S_ax-sT_xkb-XIzYCyGo73TAx0ngIMV2ZAzmEQHkgsQDA>
    <xmx:y12FajFTKgU2OZp0mWei4OqnWLcdWJMH4ybUP0Q5rIIeKjrtSWCn9w>
    <xmx:y12FapVbu0Ww_Rh82-P9RDHyM_XiFjpKcNIrirEG4aoDShIyUOtVqBWf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 03:39:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 017d1984 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 07:39:52 +0000 (UTC)
Date: Wed, 19 Aug 2026 09:39:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] hook: introduce the report hook for git-receive-pack(1)
Message-ID: <aoVdlC7myRFenPfV@pks.im>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>

On Tue, Aug 18, 2026 at 09:55:55AM +0200, Karthik Nayak wrote:
> When running 'git-receive-pack(1)', there is currently no way for the
> server to intercept and modify the status report before it is sent back
> to the client. This is useful for servers with custom logic that need
> to transform or gate the report based on the outcome of external logic
> post reference updates.
> 
> Introduce a new 'report' hook which receives the pkt-line encoded
> status report on stdin and whose stdout replaces the report sent to the
> client. A non-zero exit status causes `receive-pack` to die and the
> client to treat the push as failed.

I think it would have been useful to add context why none of the
preexisting hooks work for us:

  - The pre-receive hook runs too early, as we haven't updated
    references at that point yet and we need to have the full view of
    all resulting updates (both objects and references).

  - The update hook is too inefficient as it runs once per reference,
    and we cannot trivially determine the last update.

  - The reference-transaction hook cannot be used by us because we care
    about the phase where it was committed already. And while the hook
    fires in that phase, it does not allow the caller to modify the
    result in any capacity.

  - The post-receive and post-update hooks cannot be used as they run
    too late, at the point where we have already reported success to the
    client.

> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
> index ed045940d1..7e6643ad89 100644
> --- a/Documentation/githooks.adoc
> +++ b/Documentation/githooks.adoc
> @@ -527,6 +527,29 @@ The exit status of the hook is ignored for any state except for the
>  status will cause the transaction to be aborted. The hook will not be
>  called with "aborted" state in that case.
>  
> +report
> +~~~~~~
> +
> +This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
> +`git push` and updates reference(s) in its repository. It executes on
> +the remote repository once after all refs have been updated, but before

I'd drop "remote" here -- from the point of view of git-receive-pack(1)
it really is the local repository.

> +the status report is sent back to the client.
> +
> +The hook receives the pkt-line encoded status report on standard input
> +and its standard output replaces the report sent to the client. Any
> +output written to standard error is forwarded to the client over the
> +sideband channel and will appear as `remote:` lines on the client's
> +terminal.

This assumes a bit too much about the implementation of the client, as
it may not even be git-push(1) in the first place. We could still
mention this, but we should say that this depends on the client.

> To reject individual ref updates, rewrite the corresponding
> +`ok` lines to `ng` lines in the output report (with an explanatory
> +error string) and exit zero; standard error can accompany this to
> +provide a human-readable explanation. A non-zero exit status causes
> +`receive-pack` to die.

We should probably document that we expect the hook to never return
non-zero, even if it rejects reference updates, and that doing so
indicates a bug. This is mostly because git-receive-pack(1) shouldn't
ever just die on the client without giving it a proper status.

> +Note that by the time this hook runs, all ref updates have already been
> +applied to the repository. A non-zero exit causes the client to see the
> +push as failed, but does *not* roll back any ref changes that were
> +already committed server-side.

Good thing to call out.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 86933d8d7e..bc22b3ec31 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1004,6 +1004,41 @@ static int run_update_hook(struct command *cmd)
>  	return code;
>  }
>  
> +static int run_report_hook(struct strbuf *report)
> +{
> +	struct child_process proc = CHILD_PROCESS_INIT;
> +	struct async sideband_async;
> +	int sideband_async_started = 0;
> +	int saved_stderr = -1;
> +	struct strbuf out = STRBUF_INIT;
> +	const char *hook_path;
> +	int code;

Nit: I think it's more commont to call this `ret` rather than `code`.

> diff --git a/t/t5412-report-hook.sh b/t/t5412-report-hook.sh
> new file mode 100755
> index 0000000000..47f20e8d67
> --- /dev/null
> +++ b/t/t5412-report-hook.sh
> @@ -0,0 +1,176 @@
> +#!/bin/sh
> +
> +test_description='test report hook'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/t5411/common-functions.sh
> +
> +URL_PREFIX="\.\."

I was about to say that this looks unused, but it's used by
"common-functions.sh".

[snip]
> +test_expect_success "hook stderr is relayed to client via sideband" '
> +	test_when_finished "rm -rf upstream" &&
> +	test_when_finished "git -C workbench remote remove origin" &&
> +
> +	git init --bare upstream &&
> +	git -C workbench remote add origin ../upstream &&
> +	git -C workbench push origin $A:refs/heads/main &&
> +
> +	test_hook -C upstream --setup report <<-\EOF &&
> +	echo "hook-stderr-message" >&2
> +	exit 1

Should we maybe not exit abnormally here to see that the push succeeds?

> +	EOF
> +
> +	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
> +	test_grep "hook-stderr-message" out
> +'

This should have the "remote: " prefix, right? If so, should we verify
that?

Patrick
