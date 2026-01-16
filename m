Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B338945B
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768565648; cv=none; b=o5nmOBCB/Drn3Q9Xq6Ge6gHHhctauCMAeSfEowYkjCA67XXAhy+ua+ULvCwmTiN8n9Q5b98v4fR5AiF1LaRKqpkbWkRTtZPU+RxGqsWwW9wF46aWGp8tE0QrKaK+t57AHWNA/pVbXisCGb9bU+Hsprptb/PU+19R2SBVmhqgN6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768565648; c=relaxed/simple;
	bh=lqM0IOBmSxOGu4BtwEy/PRdUupye9ffueXoEZ0uYSEM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CW9M2H1yLNI/HxS+3cCDRpG/vMwQKKued2pW6gI45h9CmpxBpTQ2cOWyr/TmqejlV8Q5IesTBDaN2TQ5zb2DPQzcqRfatJ7WOTh3IfQqGo2RkOubnVa06yqVXWa+H+XCHbTxSmUqgUSIinqv2fczU5GLbri57jc2dnkXGBICdTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=bMpc/L/c; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="bMpc/L/c"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768565639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4tJrmVob3ry2kwAmKMDJo5CWfsB7nKdj10R+r2xwtA=;
	b=bMpc/L/c+N8IbtGWInOvujapxfsBmUEiMkk4pyuo1855yEHiBN9NQ17NVYwaJdCD0TGFEf
	V4fj5A/WRLE1mXuZrp7Zyi2UyC5RY8qQRNGVPUsf/5quxx30k7MlDefHC7p06K5ZVUWXEK
	3KQqsBeiAnYXlS1x+dhfZ+fsIFipctI=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] last-modified: document option --max-depth
In-Reply-To: <CAOLa=ZSbV6SeJ9orOz0T+oh3PVhYhTsaxrsYVkr+5q7i_tsVCw@mail.gmail.com>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
 <20251126-toon-last-modified-zzzz-v1-2-608350df0caa@iotcl.com>
 <CAOLa=ZSbV6SeJ9orOz0T+oh3PVhYhTsaxrsYVkr+5q7i_tsVCw@mail.gmail.com>
Date: Fri, 16 Jan 2026 13:13:49 +0100
Message-ID: <87fr85kb5u.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> Option --max-depth is supported by git-last-modified(1), because it was
>> added to the diff machinery in a1dfa5448d (diff: teach tree-diff a
>> max-depth parameter, 2025-08-07).
>>
>
> At this point, does it make more sense to link the respective sections
> within 'Documentation/diff-options.adoc' as done by many other commands?
> This would ensure that we don't have to repeat the documentation.

Nah, there are way too many options that are not relevant for this
command in there. I agree, it's annoying to duplicate things. But I
don't know there's an easy way around that right now.

>> This option is useful for everyday use of the git-last-modified(1)
>> command, so document it's existence in the man page and `-h` output.
>>
>> Signed-off-by: Toon Claes <toon@iotcl.com>
>> ---
>>  Documentation/git-last-modified.adoc |  9 ++++++++-
>>  builtin/last-modified.c              | 12 +++++++++++-
>>  2 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
>> index cd4a5040b0..8409daebe9 100644
>> --- a/Documentation/git-last-modified.adoc
>> +++ b/Documentation/git-last-modified.adoc
>> @@ -9,7 +9,8 @@ git-last-modified - EXPERIMENTAL: Show when files were last modified
>>  SYNOPSIS
>>  --------
>>  [synopsis]
>> -git last-modified [--recursive] [--show-trees] [-z] [<revision-range>] [[--] <path>...]
>> +git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z]
>> +	[<revision-range>] [[--] <path>...]
>>
>>  DESCRIPTION
>>  -----------
>> @@ -32,6 +33,12 @@ OPTIONS
>>  	Show tree entries even when recursing into them. It has no effect
>>  	without `--recursive`.
>>
>> +`--max-depth=<depth>`::
>> +	For each pathspec given on the command line, descend at most `<depth>`
>> +	levels of directories. A negative value means no limit.
>> +	Setting a positive value implies `--recursive`.
>> +	Cannot be combined with wildcards in the pathspec.
>> +
>>  `-z`::
>>  	Terminate each line with a _NUL_ rather than a newline.
>>
>> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
>> index 9206bbdc1d..ccb7ff66d4 100644
>> --- a/builtin/last-modified.c
>> +++ b/builtin/last-modified.c
>> @@ -25,6 +25,7 @@
>>
>>  #define LAST_MODIFIED_INIT { \
>>  	.line_termination = '\n', \
>> +	.max_depth = -1, \
>>  }
>>
>>  struct last_modified_entry {
>> @@ -60,6 +61,7 @@ struct last_modified {
>>  	bool recursive;
>>  	bool show_trees;
>>  	int line_termination;
>> +	int max_depth;
>>
>
> Should this be signed?

Yes, a negative number is allowed to set an unlimited max depth.

>
>>  	const char **all_paths;
>>  	size_t all_paths_nr;
>> @@ -487,6 +489,12 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
>>  	lm->rev.diffopt.flags.recursive = lm->recursive;
>>  	lm->rev.diffopt.flags.tree_in_recursive = lm->show_trees;
>>
>> +	if (lm->max_depth >= 0) {
>> +		lm->rev.diffopt.flags.recursive = 1;
>> +		lm->rev.diffopt.max_depth = lm->max_depth;
>> +		lm->rev.diffopt.max_depth_valid = 1;
>> +	}
>> +
>
> Or if our goal is to actually handle them within the
> 'git-last-modified(1)' command, shouldn't we ensure we don't allow any
> additional flags from being parsed as diffopt?

Is that possible?

All the magic that happens in setup_revision() is a little bit of a pain
if you ask me. 

> Currently other diffopts flags such as '--no-prefix', '--cc' and so on,
> are parsed even if they don't affect the output of
> 'git-last-modified(1)'. Shouldn't we disallow such behavior?

I think this would require a revamp of setup_revision(). But I'm happy
to be proven otherwise.

>>  	argc = setup_revisions(argc, argv, &lm->rev, NULL);
>>  	if (argc > 1) {
>>  		error(_("unknown last-modified argument: %s"), argv[1]);
>> @@ -515,7 +523,7 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
>>  	struct last_modified lm = LAST_MODIFIED_INIT;
>>
>>  	const char * const last_modified_usage[] = {
>> -		N_("git last-modified [--recursive] [--show-trees] [-z] "
>> +		N_("git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z] "
>>  		   "[<revision-range>] [[--] <path>...]"),
>>  		NULL
>>  	};
>> @@ -525,6 +533,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
>>  			 N_("recurse into subtrees")),
>>  		OPT_BOOL('t', "show-trees", &lm.show_trees,
>>  			 N_("show tree entries when recursing into subtrees")),
>> +		OPT_INTEGER_F(0, "max-depth", &lm.max_depth,
>> +			N_("maximum tree depth to recurse"), PARSE_OPT_NONEG),
>>  		OPT_SET_INT('z', NULL, &lm.line_termination,
>>  			N_("lines are separated with NUL character"), '\0'),
>>  		OPT_END()
>>
>> --
>> 2.51.2

-- 
Cheers,
Toon
