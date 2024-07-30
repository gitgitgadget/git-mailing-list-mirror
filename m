Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858EE1BC088
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355153; cv=none; b=s1SMT6FZh9xoGz8cLeew2MbHHJrTY6iYsIg4Pm/JqhUf2htWQMXxZBiiNPeLuvDMtGacfkJTKRELxfo6FKEUHPNAM7qkpyQ40GnmsgXhe6SbcpiVisii0U2BpfAHqH1anzLfGnz0n/vwKJv2j1ZkLFTw9ULDEfsicjWN2sk/b/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355153; c=relaxed/simple;
	bh=sY3oLY5VtQ19fqIjq22S+bavpY/x8T9hG1gz+tWB3VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmL1PF633yxwGZdzaihQLfuCkCl1ZMuQZMUbCzZGW2X3H938rJiSf+D2ab8dGg0esWY/M8Tz7sAo8U/xIdHhAC/EjCE82brsMFpC0HaKjsV1HC6GN0EIBN+ImLf25lxcvXP6W1qs8c+WV/TAasT6GgA3OSbf/FpPgnOsWE//y8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzPpOfqn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzPpOfqn"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso3970734b3a.3
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722355151; x=1722959951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a6MOTu1L5pL3usdLL1x3Ah6oJN8NQkZGgaIZlBd9eGM=;
        b=IzPpOfqnnz/IY6RRpdwJrYNNjDl00YBCAeTUAldHZ3oH+014VNsawCcpwcPkz4mk1N
         noqK0BeDx9OPqqjyfzPT3cxZzcmkX+sQD03MKxpvcDIMhF2p94vZQnoz+3JYbuL8V9Vh
         FOiWeSJvHJuHTvUPAFcK7ygSImy+FWYB/kBy14xNsn4pLX0Y58FxZ3Jc0j8VwMDV88kr
         6KXexMmnNH+8wEUcHQiQaMsVj7n0HPGEtK7NxwsZxQIHqtTSY2iFYd5VdwVvtCgpyQmV
         UgduM/ua5Q/RvYk1HJwNzTwmoE2esCStO4gSSQozPWYYLMLQw/IfTBzfclE+CKHUIkse
         cMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722355151; x=1722959951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6MOTu1L5pL3usdLL1x3Ah6oJN8NQkZGgaIZlBd9eGM=;
        b=uAGQgzdbuPuv7d3a5sq+1OCe6GiBs2gMgL1BztrYjiR6l+8B11P51verwWQE0vSDnG
         BeGqp7KSEGJVRbyZjt+stcFth5NOMo8mcvxvNjEw8/xzUS4BcpJmjp3aUeLzm+Jj+vMN
         ood+MK0EPpP1Jh1kH8Lzm+3RcVPpRm/Ob7YUTjtSV92JB1IDA1mM0i8DygX+NzHZEUjU
         T7WTsKznWVDd/36dcXzTfY2xZjSL0F/8g5oqVnJHV+vMIQGoO2idVGLdGAqD3pmE0ond
         rumPfYQ9GUS5SnAbdb7uibsjtziNFWjrqCHVFi1QQnL2YYDeUpI3bNh3dNDV+E4BCxXW
         CWug==
X-Gm-Message-State: AOJu0YzuKI3dRTrTcviqWWvRcNt9HoblZtEVGb5ZPqDBhN8/QWCxMCil
	toEjUTYhT20EDIXhp+6gSvJ0yONyULoDrmzatY4advm2RlhOjdgi
X-Google-Smtp-Source: AGHT+IFSAAFNf5R/lbBl7kKPWOuC5dqcojlXRgh8oxGv8Ev50hbWqW8aEQqixFLB9m3XYCmUKeCkGA==
X-Received: by 2002:a05:6a20:6a08:b0:1c3:b16d:9ebf with SMTP id adf61e73a8af0-1c4a12a5efcmr15775652637.15.1722355150559;
        Tue, 30 Jul 2024 08:59:10 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a48aasm8574398b3a.196.2024.07.30.08.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:59:10 -0700 (PDT)
Date: Tue, 30 Jul 2024 23:59:31 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 06/10] git refs: add verify subcommand
Message-ID: <ZqkN4wNK0PIRyNky@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeYsNtl90N1fVDy@ArchLinux>
 <Zqik6cgm_6HYVUKy@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqik6cgm_6HYVUKy@tanuki>

On Tue, Jul 30, 2024 at 10:31:37AM +0200, Patrick Steinhardt wrote:
> On Mon, Jul 29, 2024 at 09:27:12PM +0800, shejialuo wrote:
> 
> The subject should probably start with "builtin/refs", not "git refs".
> 

Yes, I will improve this in the next version.

> > @@ -39,6 +43,15 @@ include::ref-storage-format.txt[]
> >  	can be used to double check that the migration works as expected before
> >  	performing the actual migration.
> >  
> > +The following options are specific to 'git refs verify':
> > +
> > +--strict::
> > +	Enable more strict checking, every WARN severity for the `Fsck Messages`
> > +	be seen as ERROR. See linkgit:git-fsck[1].
> 
> How about:
> 
>     "Enable stricter error checking. This will cause warnings to be
>     reported as errors. See linkgit:git-fsck[1]."
> 

Yes, it is much more clear. Actually, I really feel hard to write a good
document.

> > +--verbose::
> > +	When verifying the reference database consistency, be chatty.
> 
> I wonder whether this really helps all that much. It doesn't really say
> what it adds on top of the default mode. So unless we document what
> exactly this changes, I rather think we can just leave it aways as
> basically everyone knows what a "--verbose" flag does.
> 

Yes, I think so. `--verbose` is a common flag. However, we have already
added this, so we may just leave it here. It's not bad to add more
information.

> > +static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
> > +{
> > +	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
> 
> So we don't ever end up using `FSCK_REFS_OPTIONS_STRICT`? If so, I think
> we should just drop that declaration in the preceding patch.
> 

I agree here. I will delete `FSCK_REFS_OPTIONS_STRICT`.

> > +	const char * const verify_usage[] = {
> > +		REFS_VERIFY_USAGE,
> > +		NULL,
> > +	};
> > +	unsigned int verbose = 0, strict = 0;
> > +	struct option options[] = {
> > +		OPT__VERBOSE(&verbose, N_("be verbose")),
> > +		OPT_BOOL(0, "strict", &strict, N_("enable strict checking")),
> > +		OPT_END(),
> > +	};
> > +	int ret;
> > +
> > +	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
> > +	if (argc)
> > +		usage(_("'git refs verify' takes no arguments"));
> > +
> > +	if (verbose)
> > +		fsck_refs_options.verbose = 1;
> > +	if (strict)
> > +		fsck_refs_options.strict = 1;
> 
> Instead of manually setting those variables, we can pass pointers to
> those member variables in the `struct option`s directly.
> 

Yes, but I have tried but found that the types are mismatching, I will
find a way to do this.

> > +	git_config(git_fsck_config, &fsck_refs_options);
> > +	prepare_repo_settings(the_repository);
> > +
> > +	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
> > +
> > +	/*
> > +	 * Explicitly free the allocated array and "skip_oids" set
> > +	 */
> > +	free(fsck_refs_options.msg_type);
> > +	oidset_clear(&fsck_refs_options.skip_oids);
> 
> Should we provide a `fsck_options_clear()` function that does this for
> us? Otherwise we'll have to adapt callsites of `refs_fsck` whenever
> internal implementation details of the subsystem add newly allocated
> members.
> 

Yes, I agree with this. I wanna talk more on this. In the first time, I
did not call `oidset_clear` and I failed the CI tests. It made me
confused. Because we never use "skip_oids" in the ref check, why the
tests said that "fsck_refs.options.skip_oids" was not freed.

This is because when executing the command "git -c fsck.skipList=.. fsck",
in the subprocess `git refs verify`, the code will still setup the
"skip_oids" by the config. So we should explicitly free the "skip_oids".

But how does "fsck.c" free "skip_oids", actually "fsck.c" never frees
"skip_oids". This is because "git-fsck(1)" defines the following:

  static struct fsck_options fsck_walk_options = FSCK_OPTIONS_DEFAULT;
  static struct fsck_options fsck_obj_options = FSCK_OPTIONS_DEFAULT;

Because these two options are "static", so there is no memory leak. We
leave it to the operating system. So maybe a more simple way is just to
add "static" identifier in "cmd_refs_verify" which means:

  - struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
  + static struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;

But I don't think we should use `static`, because Eric has told me that
making a variable "static" will make the code harder to "libfy". So
let's use "fsck_options_clear" function instead.

