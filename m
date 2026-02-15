Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71828F48
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771144874; cv=none; b=MMwH0tWorORA/IZUM65FFbNZ5VWMbfB0ev/3fCrkWNRF72OAWcCkTuiSVnvqXCVb7iqWizf5tov5pJatvRg8Wbu4kjPL3doyqcuHrP23f5gWmrTXSFxV3kv9NfImAK3F0LFZPBvWerc1EL914+C0TjfSLg7z0fTWz1XRgKoRbxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771144874; c=relaxed/simple;
	bh=eK1wjrjxrVU0PRcWLyZVZegeTNFW3f6EXkKroFJ1I98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PfQKEVhTORUuSeUjsipazTeBZWK3SubiR/t6mOV3rMoUV0IpHb2rhqzBtWpYhddYubICB/Iv0FyiUal6gCdJXnqAo4xs8bBj1KbLemDxI2P9nGHvHkv7jSZsL/DxJ5b8R0mYi8kPPRG4NC6u0H+BFehgLeNsBDe3f/Pdi1hjqx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n+O37Sg9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iZx2tR7g; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n+O37Sg9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iZx2tR7g"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D36BD1D0013D;
	Sun, 15 Feb 2026 03:41:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 15 Feb 2026 03:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771144871; x=1771231271; bh=QL2iwUXaOg
	JwS10At213O0N2CKBZyl+opRj33x8DLCo=; b=n+O37Sg9/FG8Xa0ZMOxoUjkDdF
	weCLr1vRn+a7PXj55F4E0pRKQDgR1O+k1GHRbok45Ff647V8iTgcByMu8WqmTnu2
	oWJ0Zayw11vEJzAgLlFOJr1IeBmMSfjL6Oa0kkRs9TKAIiNoghbF8L/OZQ12p+xq
	iQwMYwjK/C8qxSLUbximMEU014cZcsbkqvj5Ez+kBdPnsim4xvNJmMcir4e9q5Lr
	UDqYyaxZLY+EJJe0TsNMeMYoRGi6ncsKJsE72YTIeRYiSQp7+xeZWAsoRps2bMhP
	RZ+AS0FeGbB8Egsx+qRIKAdl8aMmOCUxBX+Brxg7lauh46nm2df6foo6DYCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771144871; x=1771231271; bh=QL2iwUXaOgJwS10At213O0N2CKBZyl+opRj
	33x8DLCo=; b=iZx2tR7gUdUBbZlUvou9yqtUjxcfiyzyuyk59yBtT7w3X1p3Gop
	Z2TNY0KMTrzydEQbGMvMlyUvzzOzXcRm71leaK91Ein4JBN7w5JvcuBwl4jPuOf4
	hSxYvMgdArIQ9xLvBMw858Erk1tVsRAtyTHeO1B1y9DLVsP9QBDXBLtcmifasTNa
	2o76r8PU8vAed4atqXh3lm45HYxHsJAIyoG4hpqKl0jMeyihOIQmSy7GZNXcWhf/
	5dd+pbcRbjPneJSu8IRCJ697vFkf7qwgs2MkiH5Urns5cXal2WJel+ZxEx7nhOJF
	RaePoyOmqrKLe+61dks6UcEO2nbA0WzBYzQ==
X-ME-Sender: <xms:p4aRaa2GjOpFrPAeS092JZzBSqIjAuFuG0YyY4Pqf_0ObY06ascXlw>
    <xme:p4aRaUGGf6_MR0vc3yOzrqbtjpxGIuznYE6gZ-kV7NVMl4COrvl0FLXsaw8MPSeqc
    y0mzWgCGd4HP4FDy2ngamA2QaMWG7hJmBJ7oUVW78JB5cA0r_Tz>
X-ME-Received: <xmr:p4aRaX6dwNuZKso1W-zIrc-PAnKf7W2QvYJCP61XBoCma60fUMGUqdDGlJ1iiEnbUZpAv9sWCvvEQsRBuccsDz4FpXFqm-ESYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudefheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhh
    phgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:p4aRaatQyutR0r4tQ8kPaz2aHEAX_9KTadKoWg1T5quMI5bPtDKJ9g>
    <xmx:p4aRaY4wg35N0skwBPJygubpvI3Y0GlTOVyoGVcCVWCsd7vSZA_irQ>
    <xmx:p4aRaVWO-fDQxaG0LzdsnIW6hMMFfHoOMZvOB9TAA95EgjKjNH9wmA>
    <xmx:p4aRaa8LaUROLZL4eLMScq1BTkos9OY51SNmlrYSDF8KmytrDz-O_Q>
    <xmx:p4aRaUq_n6uAzuVW5KHvWkdLf5NL0oYAQQ46X0wTyASFl3-lm6V5rxy8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Feb 2026 03:41:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] setup: fail if .git is not a file or directory
In-Reply-To: <20260214045247.118013-1-a3205153416@gmail.com> (Tian Yuchen's
	message of "Sat, 14 Feb 2026 12:52:47 +0800")
References: <20260212172405.48614-1-a3205153416@gmail.com>
	<20260214045247.118013-1-a3205153416@gmail.com>
Date: Sun, 15 Feb 2026 00:41:09 -0800
Message-ID: <xmqqfr72flga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> Currently, `setup_git_directory_gently_1()` checks if `.git` is a
> regular file (handling submodules/worktrees) or a directory. If it is
> neither (e.g., a FIFO), the code hits a NEEDSWORK comment and simply
> ignores the entity, continuing the discovery process in the parent
> directory.
>
> Failing instead of ignoring here makes it easier for the users to notice
> anomalies and take action, particularly if this non-file non-directory
> entity was created by mistake or by file system corruption.

OK.

> However, strictly enforcing 'lstat()' and 'S_ISREG()' breaks valid
> workflows where '.git' is a symlink pointing to a real git directory
> (e.g. created via 'ln -s').

This is true, but it is more or less irrelevant, isn't it?

The existing check to see .git is a regular file or a directory
already uses stat() and has no such problem.  A mistaken use of
lstat() will only become relevant if we were to add an extra lstat()
call on top of what we already have, but that is not what we are
doing here, right?

> To ensure safety and correctness:
>
> 1. Differentiate between "missing file" and "is a directory". This
>    removes the long standing NEEDSWORK comment in 'read_gitfile_gently()'.

This is more about telling "not a file" and "is a directory" apart,
isn't it?  Missing file (STAT_FAILED) is distinct from NOT_A_FILE
and we check if it is a git directory only when we get the latter,
and ignore if the thing that is not a file is not a git directory.

> 2. Explicitly check 'st_mode' after 'stat()'. If the path resolves to a
>    directory, return 'READ_GITFILE_ERR_IS_A_DIR' so the caller can try
>    to handle it as a directory.

This lets us tell "not a file" and "is a directory" apart, which is
duplicate of the above #1, isn't it?

> 3. If the path exists but is neither a regular file nor a directory,
>    return 'READ_GITFILE_ERR_NOT_A_FILE'.

Again, the same thing.  I _think_ what we discussed as the
motivation behind introducing new error classes are:

 * We are assuming "not a file" is more or less synonymous to "is a
   directory", and ignoring a path that is neither a file nor a git
   directory, which is what the NEEDSWORK comment in
   setup_git_directory_gently_1() is about.

 * We are assuing failure from stat(2) is more or less synonymous to
   "nothing there", and blindly go uplevel, which is what the
   NEEDSWORK comment in read_gitfile_error_die() is about.

So, we introduce IS_A_DIR (which is *not* an error) and together
with NOT_A_FILE (which was not an error, but now is an error), we
can tell "whoa, there is .git that is not a file or a directory"
reliably, to solve the first NEEDSWORK.  We also introduce
STAT_ENOENT (which is *not* an error) and together with STAT_FAILED,
we can tell "ok, there is nothing there, so we go up one level and
try to see if there is .git there" (i.e., happy normal case) and
"whoa, there is .git we cannot tell what it is" case apart, which is
about the second NEEDSWORK.

> I have verified this with a test script covering:
> 1. Normal .git file
> 2. .git as a symlink to a directory
> 3. .git as a FIFO
> 4. .git as a symlink to a FIFO
> 5. .git with garbage content
>
>  setup.c | 39 +++++++++++++++++++++++++++++----------
>  setup.h |  3 +++
>  2 files changed, 32 insertions(+), 10 deletions(-)

There is no test addition here, though?  What am I missing?

> diff --git a/setup.c b/setup.c
> index 3a6a048620..8681a8a9d1 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -911,6 +911,10 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
>  		die(_("no path in gitfile: %s"), path);
>  	case READ_GITFILE_ERR_NOT_A_REPO:
>  		die(_("not a git repository: %s"), dir);
> +	case READ_GITFILE_ERR_STAT_ENOENT:
> +		die(_("Not a git repository: %s"), path);
> +	case READ_GITFILE_ERR_IS_A_DIR:
> +		die(_("Not a git file (is a directory): %s"), path);

Hmph, isn't this backwards?

We used to treat STAT_FAILED as OK without dying in this function,
because we conflated "there is nothing there, so you should go one
level up and try again" happy case with all other stat(2) failure,
and that is why we introduced STAT_ENOENT here.  ENOENT is the
*only* case among what used to be STAT_FAILED that we do *not* want
to die in this function.  The same thing with NOT_A_FILE vs
IS_A_DIR.  We used to treat the former as OK but the only case we
wanted to treat as OK was IS_A_DIR and all other cases, like FIFO,
we wanted to complain, no?

That is why the caller in read_gitfile_gently() before this patch
used to call this function regardless of what the error_code is.
Because the function above was updated to die in these two happy
cases, the caller (below, hunk at around line 1000) excludes these
two happy error codes, which it should not have to do.

> @@ -939,8 +943,14 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
>  	static struct strbuf realpath = STRBUF_INIT;
>  
>  	if (stat(path, &st)) {
> -		/* NEEDSWORK: discern between ENOENT vs other errors */
> -		error_code = READ_GITFILE_ERR_STAT_FAILED;
> +		if (errno == ENOENT)
> +			error_code = READ_GITFILE_ERR_STAT_ENOENT;
> +		else
> +			error_code = READ_GITFILE_ERR_STAT_FAILED;
> +		goto cleanup_return;

OK.  We used to bundle any stat failure into STAT_FAILED, and
treated it as a single happy case, but by extracting STAT_ENOENT out
of various reasons stat(2) failed, we can single out ENOENT as the
only happy case and treat all other stat(2) failure as errors.

> +	}
> +	if (S_ISDIR(st.st_mode)) {
> +		error_code = READ_GITFILE_ERR_IS_A_DIR;
>  		goto cleanup_return;
>  	}
>  	if (!S_ISREG(st.st_mode)) {

And we used to bundle anything other than S_ISREG() as a single
NOT_A_FILE class, and assumed that would be a directory and treated
it as a non-error.  We now explicitly return IS_A_DIR so that the
caller can treat that as the only happy case among other NOT_A_FILE
cases that are suspicious.

> @@ -994,7 +1004,9 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
>  cleanup_return:
>  	if (return_error_code)
>  		*return_error_code = error_code;
> -	else if (error_code)
> +	else if (error_code &&
> +		error_code != READ_GITFILE_ERR_STAT_ENOENT &&
> +		error_code != READ_GITFILE_ERR_IS_A_DIR)
>  		read_gitfile_error_die(error_code, path, dir);

This looks seriously wrong, and it is because it is trying to paper
over the misdesign of the updates made to read_gitfile_error_die(),
isn't it?

> @@ -1576,18 +1588,25 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  		if (offset > min_offset)
>  			strbuf_addch(dir, '/');
>  		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
> -		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
> -						NULL : &error_code);
> +		gitdirenv = read_gitfile_gently(dir->buf, &error_code);
>  		if (!gitdirenv) {
> -			if (die_on_error ||
> -			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
> -				/* NEEDSWORK: fail if .git is not file nor dir */

> +			if (error_code == READ_GITFILE_ERR_STAT_ENOENT ||
> +				error_code == READ_GITFILE_ERR_IS_A_DIR) {

This smells seriously wrong.

IS_A_DIR leading to a call to is_git_directory() check makes sense,
but if we got STAT_ENOENT, what would we expect to find there by
making an is_git_directory() call?

>  				if (is_git_directory(dir->buf)) {
>  					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
>  					gitdir_path = xstrdup(dir->buf);
>  				}
> +			} else if (error_code == READ_GITFILE_ERR_NOT_A_FILE) {
> +				if (die_on_error)
> +					die(_("Invalid %s: not a regular file or directory"), dir->buf);
> +				else
> +					return GIT_DIR_INVALID_GITFILE;
> +			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED) {

Do you mean "!=" here, not "=="???

> +				if (die_on_error)
> +					read_gitfile_error_die(error_code, dir->buf, NULL);
> +				else
> +					return GIT_DIR_INVALID_GITFILE;
> +			}

If we wanted to have an explicit STAT_NOENT check, it would make
sense to add it as the last "else if" arm here, with an empty body,
i.e.

			} else if (error_code == READ_GITFILE_STAT_ENOENT) {
				; /* nothing there, go up one level */
			}

