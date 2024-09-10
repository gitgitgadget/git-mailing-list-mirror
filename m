Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411181A4B99
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006799; cv=none; b=OhTufXHCAyCTBcahqPNSDAeTDjjLK2TjIkCmYP1CfIQIrIY460A5Hc6ySbMvI5EGBQKlmWUkTXkzc2dqaOQKfJPSfsNVcgAtcJZjgSKh9kAmzI/c7mV8Mf7aO8N35fhYYgrVq+RPlNbPQHo8ewOr7gkSWOruRFkWNUb9Y4Mwr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006799; c=relaxed/simple;
	bh=+VqOHIJf7ybd1zZKyldxUZPeZW2QqMS9KJMP2gQMH2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tTsMedIm/ZkaJoTiKvaPQ+g4QCGRsWEdUSy+Oo12IK+mJvTz46hOB5ORQ6GPJ46HDsJ95kJxFPqDN5roCOAmgmm4D3Ds+FBqwV3qiFzP+GYBS6c0zYVmQQ61hb7Thrzqlopbj+0RRdAfyrTTd0RAmLlN63RWVnI3l22MhAFNg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oClZcE4M; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oClZcE4M"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 055A1367F1;
	Tue, 10 Sep 2024 18:19:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+VqOHIJf7ybd1zZKyldxUZPeZW2QqMS9KJMP2g
	QMH2Y=; b=oClZcE4MWDjJAjJ5Aa+m+9M8zYHpgquuK9HTKvic3e2yBTNAtWEVdK
	4rp6/OtZxYUagN1GjmdljW/NJxGrQHySVFucar02nqNSlBaUcwTajNmLhQjw6Ods
	7KVpBAa6cGjo1RDsaLSsX5b6XM5WGyLOk3sAVcuvlQ6VeTV2hatio=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF883367F0;
	Tue, 10 Sep 2024 18:19:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 60BAD367EF;
	Tue, 10 Sep 2024 18:19:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, 	Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt
 <ps@pks.im>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2 1/2] fetch: set-head with --set-head option
In-Reply-To: <20240910203835.2288291-2-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Tue, 10 Sep 2024 22:37:13 +0200")
References: <20240910203835.2288291-1-bence@ferdinandy.com>
	<20240910203835.2288291-2-bence@ferdinandy.com>
Date: Tue, 10 Sep 2024 15:19:54 -0700
Message-ID: <xmqqseu7cfsl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CEB5CA88-6FC2-11EF-B7B0-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Bence Ferdinandy <bence@ferdinandy.com> writes:

> When cloning a repository refs/remotes/origin/HEAD is set automatically.
> In contrast, when using init, remote add and fetch to set a remote, one
> needs to call remote set-head --auto to achieve the same result.

In other words, "clone" is roughly equivalent to "init && remote add
&& fetch && remote set-head".

I do not see a problem with it.  You'd do such a repository creation
task only once per repository anyway.

> Add a --set-head option to git fetch to automatically set heads on
> remotes.

This practically would help only those who want to blindly follow
what the remote considers their primary branch.  If the remote
flip-flops that every day betweein 'master' and 'main', you'd want
to either "fetch && remote set-head" or "fetch --set-head", but it
would be weird to flip-flop the HEAD every day to begin with.

And the feature does not help those who want to inspect and then
switch.  When they say "--set-head", they will unconditionally
switch whatever the remote uses and there is no opportunity for them
to check.

Ideally, because every "git fetch" you do will automatically learn
what their HEAD of the day points at, even without "--set-head", it
may be nice to let the user know when their HEAD changed, so that
the user can inspect the situation and decide.

If "fetch $repo", when it notices that refs/remotes/$repo/HEAD is
missing, always unconditionally stores where their HEAD points at
in refs/remotes/$repo/HEAD, and did nothing else, wouldn't that be
sufficient?

The users have "remote set-head" to do this when needed.  What is
the true motivation that "fetch" (which presumably happens a lot
more often) needs to be involved in this process?  The *only* upside
I can see with "fetch --set-head" to blindly follow every switch of
HEAD on the remote end is that you can keep up with the remote that
flips its HEAD very often, but is that really a realistic need?  If
we reject such a use case as invalid, I suspect that the end-user
experience would be simplified quite a lot.  Imagine that we teach
"git fetch $repo" to notice refs/remotes/$repo/HEAD is missing, and
create it from the remote HEAD information automatically.  And we do
NOTHING ELSE.  What would the end-user experience look like?

 * Usually, you start with "git clone" and 'origin' will know which
   branch 'origin/HEAD' points at.

 * You may run "git remote add -f $repo $URL" to add one.  Because
   this runs "git fetch $repo", the previous addition to the "git
   fetch" will make sure refs/remotes/$repo/HEAD would be there.

 * You may run "git remote add $repo $URL" to add one, and then
   separately "git fetch $repo" yourself.  The end result would be
   the same; refs/remotes/$repo/HEAD will be there.

Having said all that, the implementation here ...

> +static int run_set_head(const char *name)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	strvec_push(&cmd.args, "remote");
> +	strvec_push(&cmd.args, "set-head");
> +	strvec_push(&cmd.args, "--auto");
> +	strvec_push(&cmd.args, name);
> +	cmd.git_cmd = 1;
> +	return run_command(&cmd);
> +}

... does look quite straight-forward.

> +static int fetch_multiple(struct string_list *list, int max_children, int set_head,
> +			const struct fetch_config *config)
>  {
>  	int i, result = 0;
>  	struct strvec argv = STRVEC_INIT;
> @@ -2014,6 +2025,8 @@ static int fetch_multiple(struct string_list *list, int max_children,
>  				error(_("could not fetch %s"), name);
>  				result = 1;
>  			}
> +			if (set_head && run_set_head(name))
> +				result = 1;

This looked a bit questionable---I expected that we'd run the
subfetches with "--set-head" option, but this makes us do the
set-head step ourselves after the subfetches are done.  What are
pros-and-cons considered to reach the decision to do it this way?


Thanks.
