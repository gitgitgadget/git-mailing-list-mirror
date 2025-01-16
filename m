Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3122ACEB
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035863; cv=none; b=XaXy0BKfwPBxztdCMmvLDJlZJ3G8QoXt25OHO5QFFHeBDW0INpfDvvxfXESM+OHSs1WAC4uw9JmOa/fAMW7bxAzG4PwUveDyKjkX+sfft0GyfbfLFfLnbMJ8NMEeLBZ/Tej92XkyMu+K/Eu6xa0WcDt7NCf13LI+w9hTRena8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035863; c=relaxed/simple;
	bh=q9gSRlHjhtaDgdflv9eUV00IVpQcny98TKguKqpufqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uThfoFdB6CZNtqND2/wVmqcRT/LjAq1shQ//tARGQ+jCm944ovkF/ZLH47WJfSPtj5KMdA6o6+lLilLuhuMs5W2T0qMtaIkPHp0TLh9CliqmX/Njv2C1zPlmUZwMJCR4dk8LHXFCHAy3M+NolnkabuTcUKRdjL3aXFoNorqkDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XcBApXB3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=njfrkLe4; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XcBApXB3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="njfrkLe4"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7565B1140158;
	Thu, 16 Jan 2025 08:57:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jan 2025 08:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737035860; x=1737122260; bh=4KAGnNfeC5
	G2SffKLvJxyXtj6yDga0wiefgof02BdYY=; b=XcBApXB3/eW7Hp/0REHDS/IL7m
	yqNom2Q+6U+he/VRz0+PqTadGix30nga43QExgq+SwDkqCFARXS4VhLhot5xhdbl
	XJkw5Odnz+XEunhc5W97mXSA4U7S738xn1HaRdqk0EqGAu/xPnaaYuqRL9gpS0bw
	9tWgVzTqNubc8EM0hHlbdrcgJI8wTaEwSjYA/c8laT21hiTdgfKmBJIUrtCDy+do
	UGi0Nofsu5tW7Z5yfGokaJneqjHIdw9mibBEyV1KxF+Tb12kTLYJVdOoi1hX1EiD
	dzyNXqz1ZTkkn0I2Tq0YKeEZPR1IaBzglSKEQsJ/o/YW08p7qXYU0G9DU+tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737035860; x=1737122260; bh=4KAGnNfeC5G2SffKLvJxyXtj6yDga0wiefg
	of02BdYY=; b=njfrkLe4qLo65HO8A0rtAQ+Iwp54iYjxEU3zrkqyYZA85KnhTZ1
	IDwT96/2qqC2ZZJWpurRnkfUnAp0Wnw7Se2brECqetCQ4pnElSa2aVzCeFx5aocX
	UquRgoMW2LBKFIXd3omrhu6f+aK5f1PBpMsN81t+OKqF1qcLrDaIMH4dcy50fBnm
	nntbURLBRe5kp+Xaa8OK96vkztJ6L9G5Ua1FnHPvJIlUMXEST67JNCgmt4AWAk/j
	vJ55MFt0c5I3uHv29OPfnl49RRNRPlMbxClFNqcM2YxT70M+CxFI45aHP3jmjtFw
	HAc/LDtvYdqJZnp2QN5oPc6pfLTJHih4YWA==
X-ME-Sender: <xms:VBCJZ1bXXeIQYj-fhhxwfVFjD81O8izO6mOAAqDWMZgSuBYWjvapBA>
    <xme:VBCJZ8YPqhAGZGmVkIt_bllKXVPtwMBhHbZiocL9AGdGNYBIux4sOkLIA3jfSqoXl
    1pcs0Fv_TgN7u-N0A>
X-ME-Received: <xmr:VBCJZ3_zfBhMboCUwT6IQire7o8Kkp6jVWWAy8TRrNWYIzesSN1NcPcAYlMH9mJK0LsPSJO5YR7MniuM9AoIghW8iXnW45Cl2kNwuEHFK8e8hBFWXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdrvgguuhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:VBCJZzoz7494Wa7sV3tLlEgc5wQ2x-gL_83aedIOoBy4Ep3Llb65ug>
    <xmx:VBCJZwqwmvLQ6k_JeNtJef2ObeJ_yD8XFGS7ghtSTvqnhgellO225g>
    <xmx:VBCJZ5SMJLwt7ehSVnUxbYfMZg9kRCjdkAqlyEHKh9cUpDlGNEtunA>
    <xmx:VBCJZ4pk6lSqn-1RhLV-LyQYRj08BDjwnkukMQiDyMJea2PKYfE8qQ>
    <xmx:VBCJZ1Bfr8TktrcStL3BjJ7OPKi0-pzHOMdPLZWcVNnzEmay4p26t5t0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 08:57:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 52103873 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 13:57:38 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:57:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/10] packed-backend: add "packed-refs" header
 consistency check
Message-ID: <Z4kQUb7og2Ce1iCo@pks.im>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN8U2VbZBnUSWj@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qN8U2VbZBnUSWj@ArchLinux>

On Sun, Jan 05, 2025 at 09:49:37PM +0800, shejialuo wrote:
> Add a new flag "safe_object_check" in "fsck_options", when there is
> anything wrong with the parsing process, set this flag to 0 to avoid
> checking objects in the later checks.

Okay, I understand the motivation: a corrupted refdb may be completely
bogus, so checking its objects may not be sensible.

For one of the preceding commits I made the suggestion to split out the
object checks into a generic part instead, as they aren't specific to
the backend. With such a scheme we could adapt the logic to first do the
backend-specific checks for the format, and only in case the backend
looks sane to us we'd execute those generic checks for that specific
backend. That'd allow us to get rid of the "safe object check" flag.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index d9eb2f8b71..3b11abe5f8 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1748,12 +1748,100 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
>  	return empty_ref_iterator_begin();
>  }
>  
> +static int packed_fsck_ref_next_line(struct fsck_options *o,
> +				     int line_number, const char *start,
> +				     const char *eof, const char **eol)
> +{
> +	int ret = 0;
> +
> +	*eol = memchr(start, '\n', eof - start);
> +	if (!*eol) {
> +		struct strbuf packed_entry = STRBUF_INIT;
> +		struct fsck_ref_report report = { 0 };
> +
> +		strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
> +		report.path = packed_entry.buf;
> +		ret = fsck_report_ref(o, &report,
> +				      FSCK_MSG_PACKED_REF_ENTRY_NOT_TERMINATED,
> +				      "'%.*s' is not terminated with a newline",
> +				      (int)(eof - start), start);
> +
> +		/*
> +		 * There is no newline but we still want to parse it to the end of
> +		 * the buffer.
> +		 */
> +		*eol = eof;

I don't quite understand. We've figured out that there isn't a newline,
so wouldn't that mean that we _are_ at the end of the buffer already?

> +		strbuf_release(&packed_entry);
> +	}
> +
> +	return ret;
> +}
> +
> +static int packed_fsck_ref_header(struct fsck_options *o, const char *start, const char *eol)
> +{
> +	const char *err_fmt = NULL;
> +	int fsck_msg_id = -1;
> +
> +	if (!starts_with(start, "# pack-refs with:")) {
> +		err_fmt = "'%.*s' does not start with '# pack-refs with:'";
> +		fsck_msg_id = FSCK_MSG_BAD_PACKED_REF_HEADER;
> +	} else if (strncmp(start, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER))) {
> +		err_fmt = "'%.*s' is not the official packed-refs header";

I wouldn't say "official", because it could totally be that whatever is
official changes in the future, e.g. when a new format is introduced.
Unlikely to happen, but saying "unknown packed-refs header" might be a
bit more future proof.

> +		fsck_msg_id = FSCK_MSG_UNKNOWN_PACKED_REF_HEADER;
> +	}
> +
> +	if (err_fmt && fsck_msg_id >= 0) {
> +		struct fsck_ref_report report = { 0 };
> +		report.path = "packed-refs.header";
> +
> +		return fsck_report_ref(o, &report, fsck_msg_id, err_fmt,
> +				       (int)(eol - start), start);
> +
> +	}
> +
> +	return 0;
> +}
> +
> +static int packed_fsck_ref_content(struct fsck_options *o,
> +				   const char *start, const char *eof)
> +{
> +	int line_number = 1;
> +	const char *eol;
> +	int ret = 0;
> +
> +	ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
> +	if (*start == '#') {
> +		ret |= packed_fsck_ref_header(o, start, eol);
> +
> +		start = eol + 1;
> +		line_number++;

The header can only appear at the beginning of the file, can't it? But
we accept it in every line here. We should likely verify that it's
actually a header and not a line at some random place.

> +	} else {
> +		struct fsck_ref_report report = { 0 };
> +		report.path = "packed-refs";
> +
> +		ret |= fsck_report_ref(o, &report,
> +				       FSCK_MSG_PACKED_REF_MISSING_HEADER,
> +				       "missing header line");
> +	}
> +
> +	/*
> +	 * If there is anything wrong during the parsing of the "packed-refs"
> +	 * file, we should not check the object of the refs.
> +	 */
> +	if (ret)
> +		o->safe_object_check = 0;
> +
> +
> +	return ret;
> +}
> +
>  static int packed_fsck(struct ref_store *ref_store,
>  		       struct fsck_options *o,
>  		       struct worktree *wt)
>  {
>  	struct packed_ref_store *refs = packed_downcast(ref_store,
>  							REF_STORE_READ, "fsck");
> +	struct strbuf packed_ref_content = STRBUF_INIT;
>  	struct stat st;
>  	int ret = 0;
>  
> @@ -1779,7 +1867,24 @@ static int packed_fsck(struct ref_store *ref_store,
>  		goto cleanup;
>  	}
>  
> +	if (strbuf_read_file(&packed_ref_content, refs->path, 0) < 0) {
> +		/*
> +		 * Although we have checked that the file exists, there is a possibility
> +		 * that it has been removed between the lstat() and the read attempt by
> +		 * another process. In that case, we should not report an error.
> +		 */
> +		if (errno == ENOENT)
> +			goto cleanup;

Unlikely, but good to guard us against that condition regardless. It's
still not entirely race-free though because the file could meanwhile
have changed into a symlink, and we wouldn't notice now. We could fix
that by using open(O_NOFOLLOW), fstat the returne file descriptor and
then use `strbuf_read()` to slurp in the file.

> +		ret = error_errno("could not read %s", refs->path);
> +		goto cleanup;
> +	}
> +
> +	ret = packed_fsck_ref_content(o, packed_ref_content.buf,
> +				      packed_ref_content.buf + packed_ref_content.len);
> +
>  cleanup:
> +	strbuf_release(&packed_ref_content);
>  	return ret;
>  }
>  
> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index 307f94a3ca..6c729e749a 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -646,4 +646,48 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
>  	test_cmp expect err
>  '
>  
> +test_expect_success 'packed-refs header should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	cd repo &&

The same comment applies here as on a preceding test: cd should be
executed in a subshell.

Patrick
