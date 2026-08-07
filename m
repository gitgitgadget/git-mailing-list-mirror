Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777F38A299
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086235; cv=none; b=TnfJAGwrWdmmqO0AzqYNDmONpIYwD0aukOrKjF7faSnOC0Dhyr+0vuvKjry14Hfr9yYhdHyVLDtklyR6J6K0gGAWWtHInqyPmquGe9XbtKu/tbfuyx7NH8E/4mzLJFd8hrCGyN19VTMxj8BUrAACI8ystETK+iohIgpDHP8l07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086235; c=relaxed/simple;
	bh=rvhXe5vsawBr18+EcJCOoiIHK3FY82xVB7YrP88zrtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik09z7RdA3+VVJJosWQGLp1aM43dD/mH5SlVJpVwqS/NOBJpqZwAqYHeID31WFlKgEklbRGzLju2erjA4zbCnZhYDDQc9RNNnF2Eqakae58DtruhMMmVEWjqTfmnwLiqsY73PZH8ToCRagXCLba/87tEjn4ycVW6UyL8xjnUDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ftXrDFIt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KbUVuc+h; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ftXrDFIt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KbUVuc+h"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EC591EC01C5;
	Fri,  7 Aug 2026 03:03:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 07 Aug 2026 03:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786086231; x=1786172631; bh=m304cQmvDI
	sSXeseEoSPUy8MsCnYfwF5lkr4qvD8sWs=; b=ftXrDFItX52t8VYFXh6yjd7MMo
	tOKYae8xbFo6upovyCctaOVodIpRmUV3qfovTgFrvOGZg6ZhfiCWTi24reHP+EsG
	ObJZEZYoNQDUOmnG09+dWKTEE2bf+rAeHtsS5ls2U+SGS7kp/di7ik3tb4pXn7ga
	3bwhjve9eUbocs6W/L6nj0Wr1V9w0FTDxjUbEk02WTxapf0RrtgJFk6LtAREy0Pq
	gPb4xi5Inbbiwn1Un8PNIKzzDlp9NwOI1G9wTfdoOX0RpDdOAwOoKnX4F0wuo22F
	FDNvK+QNEcKc0rjNGC6Z3AmBwW15cg8XXlPLW5GfBh9pPam4I6igsVMKxFaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786086231; x=1786172631; bh=m304cQmvDIsSXeseEoSPUy8MsCnYfwF5lkr
	4qvD8sWs=; b=KbUVuc+hLGLqbG4k5NZrc9NlutHFh/tJHP2Aqt7inwDts5cxFtf
	W8T77NFfG2whnF1h46dKiv7s/g4cU7p4qVZo1xxEqchHnjMJUtxxwAgNDBl4sdVU
	U4000U8TganmB+8qEMOfkJNUf4olfEO/U8cCVqWu1G1Q92I30T+q4zpDRJ0DJoFv
	I78rA8wU6XBrd60tDNpGs8ujG3DQQd7pyBsplTejR0vsh8VsHfK13PUCRPDYKJSh
	4sJT8DzgiXQYZzFy6t2f17rapylUMKja8PTSbQm6C4YLNpsOHGAnS7dvvgAJNQlK
	azbOScThp/EuYEeShm3E9ovi5qreD6Y5LrQ==
X-ME-Sender: <xms:V4N1alF67KaVqPLlNVja49oYjxFFVv8bJLrJghFq8X6yF1vyL-d2iw>
    <xme:V4N1agV61GF1kAE7L-jy5vV4H20cmTQpmol7lN8Rbh6rs4za_-h5o5nQmn9kXoUaA
    uIsAAmiB3HqJLCtmYHsj8LrqKUC9Tis45dkbWdIEU3FluOtbdeK580>
X-ME-Received: <xmr:V4N1akxo_ZNhDSEiBG4ESo1V4TgDVR9Ue1SMyzN1vWXuXvp7udPB35sLx0hmTBPhIpMfQ8JBUvfT7-hkYwGdhj5Ar7YQ2_Z08w3Toe8sMEbWSA>
X-ME-Proxy-Cause: dmFkZTE26y9njCNpXPcmZxYe4ifaNpV+sYlC5mYRUIr+ln+pB38Sh4kjo5WX0zU5LY8sit
    +oeUUeuwuVDmjatud2iyJtMdnBGrHtsLnRGmbTcsfv4XslNEpw1gmYRc4vkyxvvkVzb6bZ
    FW+Hc4Ewp0bN9yMqVLHrPU0VZXSxvfa2uONHO4C1LZMZN/4xo/SlyjWqoa1PpzuveaGMel
    tb8CZN49JwAhjMMI8vzeUDPe9GRJE1Pij+NlRwONiI8W2cbrpyJAIUbCY4UmewvnRVelNo
    mmLmZkIFSOfTf9/ExxwJZ9KjT4RrzlQa8TreUzcLYfr16STGdtDWK6anYTN5DZxvjKF6HH
    M+TiSrJ30uPaA+LI/bbjM+6pk60lH86yLFyUgzdXt/twzyoV1k1JYx08BFhvvGYSucDT5U
    v3v+70dKnv8JgtFR78YVj70gel5L/ZBGTzJQwXgCxw5nJ7AjLzqXOdlmscoOtZJJUmuG7M
    zbDbgXaHP7P07SkdHGRZlOwiIXWCBWN8JVoCUSj0dv1fchnPHerDdcPDJtVszflkraJhTJ
    wZplT+Yt/JHkmfp4SSMooZn1eNJau0iiLHnEW1XqFcfwqAc8odAkgu2UJ7aEmnVMsc1XjZ
    4vNpdDO91vErz8J+eP97d415u3NLrO0yZjwYXN55L1BE4oq/TuvoQD+hauLg
X-ME-Proxy: <xmx:V4N1amP5g-Sz-iFn2efm6P7QHsK15SbEMDvJxiCSLAYJma-3Bmxr2w>
    <xmx:V4N1at6eSonuZY6avoygsJZu66i8zqEylIgiUIY23Gy4se0KReDamA>
    <xmx:V4N1avMDwRXJ8LKctdteKt7Eve7xozaRK3REDojd6MOBhzcptNrjkQ>
    <xmx:V4N1ajmzU-ZEMGW_RyINcAOStQY_n3RFQbiGQbq49lMt_pLuTyt1lw>
    <xmx:V4N1al3y3iWGyf0O5Fb1GnxFi26otek8LTE83HOwRAHP4Ia2_3tSPIvN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 03:03:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 519ead86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 07:03:51 +0000 (UTC)
Date: Fri, 7 Aug 2026 09:03:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] odb/transaction: add transaction interface to write
 packfiles
Message-ID: <anWDVFL6OjX2xdR-@pks.im>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260806213859.816157-7-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806213859.816157-7-jltobler@gmail.com>

On Thu, Aug 06, 2026 at 04:38:59PM -0500, Justin Tobler wrote:
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 743005f1f5..3069b53509 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
[snip]
>  static int unpack_with_sideband(struct odb_transaction *transaction,
>  				const char *shallow_file,
>  				struct strbuf *err_msg)
>  {
> -	struct unpack_opts opts = {
> +	struct odb_transaction_write_pack_opts opts = {
>  		.fsck_objects = (receive_fsck_objects >= 0
>  				 ? receive_fsck_objects
>  				 : transfer_fsck_objects >= 0
> @@ -2462,7 +2326,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
>  	int ret;
>  
>  	if (!use_sideband)
> -		return unpack(transaction, 0, err_msg, &opts);
> +		return odb_transaction_write_pack(transaction, 0, err_msg, &opts);
>  
>  	use_keepalive = KEEPALIVE_AFTER_NUL;
>  	memset(&muxer, 0, sizeof(muxer));
> @@ -2472,7 +2336,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
>  		return 0;
>  
>  	opts.err_fd = muxer.in;
> -	ret = unpack(transaction, 0, err_msg, &opts);
> +	ret = odb_transaction_write_pack(transaction, 0, err_msg, &opts);
>  
>  	finish_async(&muxer);
>  	return ret;

Nicely done. All we need to do now is to rename the structure and the
parameters, and everything else was already taken care of in the
preceding commits.

> diff --git a/object-file.c b/object-file.c
> index 30b4717d3e..ec3b9a185e 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1292,6 +1297,148 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
[snip]
> +static int odb_transaction_files_write_pack(struct odb_transaction *base,
> +					    int pack_fd, struct strbuf *err_msg,
> +					    const struct odb_transaction_write_pack_opts *opts)
> +{
> +	struct odb_transaction_files *transaction =
> +		container_of(base, struct odb_transaction_files, base);
> +	struct repository *repo = base->source->odb->repo;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	struct pack_header hdr;
> +	const char *hdr_err;
> +	int err_fd = opts->err_fd;
> +	int status;
> +
> +	hdr_err = parse_pack_header(&hdr, pack_fd);
> +	if (hdr_err) {
> +		if (err_fd > 0)
> +			close(err_fd);
> +		strbuf_addstr(err_msg, hdr_err);
> +		return -1;
> +	}
> +
> +	if (opts->shallow_file) {
> +		strvec_push(&child.args, "--shallow-file");
> +		strvec_push(&child.args, opts->shallow_file);
> +	}
> +
> +	odb_transaction_env(base, &child.env);
> +
> +	if (ntohl(hdr.hdr_entries) < (unsigned int)opts->unpack_limit) {
> +		strvec_push(&child.args, "unpack-objects");
> +		push_header_arg(&child.args, &hdr);
> +		if (opts->quiet)
> +			strvec_push(&child.args, "-q");
> +		if (opts->fsck_objects)
> +			strvec_pushf(&child.args, "--strict%s",
> +				     opts->fsck_msg_types);
> +		if (opts->max_input_size)
> +			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
> +				     (uintmax_t)opts->max_input_size);
> +		child.no_stdout = 1;
> +		child.in = pack_fd;
> +		child.err = err_fd;
> +		child.git_cmd = 1;
> +		status = run_command(&child);
> +		if (status) {
> +			strbuf_addstr(err_msg, "unpack-objects abnormal exit");
> +			return -1;
> +		}
> +	} else {
> +		char hostname[HOST_NAME_MAX + 1];
> +		char *lockfile;
> +
> +		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
> +		push_header_arg(&child.args, &hdr);
> +
> +		if (xgethostname(hostname, sizeof(hostname)))
> +			xsnprintf(hostname, sizeof(hostname), "localhost");
> +		strvec_pushf(&child.args,
> +			     "--keep=receive-pack %"PRIuMAX" on %s",
> +			     (uintmax_t)getpid(),
> +			     hostname);
> +
> +		if (!opts->quiet && err_fd)
> +			strvec_push(&child.args, "--show-resolving-progress");
> +		if (err_fd)
> +			strvec_push(&child.args, "--report-end-of-input");
> +		if (opts->fsck_objects)
> +			strvec_pushf(&child.args, "--strict%s",
> +				     opts->fsck_msg_types);
> +		if (!opts->reject_thin)
> +			strvec_push(&child.args, "--fix-thin");
> +		if (opts->max_input_size)
> +			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
> +				     (uintmax_t)opts->max_input_size);
> +		child.out = -1;
> +		child.in = pack_fd;
> +		child.err = err_fd;
> +		child.git_cmd = 1;
> +		status = start_command(&child);
> +		if (status) {
> +			strbuf_addstr(err_msg, "index-pack fork failed");
> +			return -1;
> +		}
> +
> +		lockfile = index_pack_lockfile(repo, child.out, NULL);
> +		if (lockfile) {
> +			ALLOC_GROW(transaction->pack_lockfiles,
> +				   transaction->pack_lockfiles_nr + 1,
> +				   transaction->pack_lockfiles_alloc);
> +			transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
> +				register_tempfile(lockfile);
> +			free(lockfile);
> +		}
> +		close(child.out);

A `git diff --color-moved` shows that almost all of the code was simply
moved around. The biggest change is this part here, where we now
register the packfiles as part of the transactions. Makes sense.

> +		status = finish_command(&child);
> +		if (status) {
> +			strbuf_addstr(err_msg, "index-pack abnormal exit");
> +			return -1;
> +		}
> +		odb_reprepare(repo->objects);

Now that this is part of the ODB transaction, do we really have to
reprepare the whole object database? Shouldn't it suffice to reprepare
just the one source that we've created the transaction for?

> diff --git a/odb/transaction.h b/odb/transaction.h
> index ec0b27c449..491026e815 100644
> --- a/odb/transaction.h
> +++ b/odb/transaction.h
> @@ -4,6 +4,51 @@
>  #include "gettext.h"
>  #include "odb.h"
>  
> +/*
> + * Options controlling how odb_transaction_write_pack() ingests a packfile.
> + */
> +struct odb_transaction_write_pack_opts {
> +	/*
> +	 * Optional fsck severity configuration to apply when incoming objects
> +	 * are verified.
> +	 */
> +	const char *fsck_msg_types;
> +	/*
> +	 * Path to an alternative shallow file describing the shallow boundaries
> +	 * to honor while ingesting the pack.
> +	 */
> +	const char *shallow_file;
> +	/*
> +	 * The max size in bytes of the incoming packfile allowed. No limit is
> +	 * enforced when set to 0.
> +	 */
> +	off_t max_input_size;
> +	/*
> +	 * Whether the validity of incoming objects should be verified.
> +	 */
> +	int fsck_objects;
> +	/*
> +	 * The threshold for the number of incoming objects required to store
> +	 * the objects in a packfile. This option may not be relevant to
> +	 * backends that do not store obejcts in loose/packed formats and can be
> +	 * ignored.
> +	 */
> +	int unpack_limit;

I wonder whether this option should rather be handled internal in the
backend itself, as it very likely doesn't apply to alternative backends
anyway. I don't think we allow command line options to override this, so
the backend could just read the configuration manually.

> +	/*
> +	 * Whether to reject an incoming packfile if it is "thin".
> +	 */
> +	int reject_thin;
> +	/*
> +	 * Optional file descriptor for reporting progress and errors. Set to 0
> +	 * for none.
> +	 */
> +	int err_fd;
> +	/*
> +	 * Suppresses progress reporting.
> +	 */
> +	int quiet;
> +};

Nit: I think having some spacing between the different options would
make this a bit easier to grok.

Patrick
