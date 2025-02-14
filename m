Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC618188704
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739529049; cv=none; b=qwGbckCwKQSkryZboqVcZrPF1KrG4ivBC6BNEfR0wMW2o1ZaxdeoQwAj4GD/TwTfwM13sxHJ7fD0SF5NDZYWJ3R/dP7JW4kN5YPCAsTRD31CQbFHUksS2jD48uGsMbPwK3anzSUEw+88dINck67tY8HUm7DwV6+4f4Q1DvjtP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739529049; c=relaxed/simple;
	bh=QhBAspEh54GL0/mRNLv/3rtczgckSsx8rbN8FH/BaN4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FL67GK9YMgZUR6gGqJU6/iz2q8DbtMYRT1BWAnCOMgKnCXuWsmYh+fiKaLQDC6yRmzlJGJ0VRGRs8y9zqfQ8X48KnSAWsBsAGS12H8MrWImAmtm/OPNs+zI63fzstyyl+GS/DdV072RAU/YTPCv03h3qqYMa/2sOiBnw1oir+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJPA8sUp; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJPA8sUp"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4bbb56bbbd4so1809390137.1
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 02:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739529047; x=1740133847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RRpo+cJbdpgrt3eHb1gJZqMLd/xYehzIhs2OeqXb12U=;
        b=TJPA8sUpZ82ti8fEzumC9kP2sA512QhwKIK8CVTqbV1j+qgTLV3jPQAw2eu1lijkN5
         AlYVk/XuHDJ/fsX6EP1AjdO9icPrxeAVOy64QE+IpsaOChoaXIP86zdQu6zXx4AHx/DL
         QIr0U2/4sg6s2QmzVJ46JSiwQO2ai2eFwxZ1nQBQGeuh0J/CqZWStYQmcnvX4MsSXlTH
         mkWUyUx3CmJ3CHxbr/QKX75Vma6zHcmabJaMIxvcFRVmpbPQ6jCiehW30ikmtN5R2+zH
         JInIid1WShe4mcylDkN6MTpncrb/STis8BxdEwnyPPce6ZQAmvVkYmSq/LDZmV6IisdC
         Pagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739529047; x=1740133847;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRpo+cJbdpgrt3eHb1gJZqMLd/xYehzIhs2OeqXb12U=;
        b=tUE31MD0svTOjsPtcGQ+yERAG5I2N44Oh75GhR2Db1EaFOWiq/1HwQnBq25Z63o1MR
         JSbHC5MSVfHLQszMZE8XSYI20RjpYjRsJjE1TfzlYJMjqkWyYF0HZ7Kl1LR/CZvu1S7I
         fPCLCUEv3twnhRKdOQHfWTKSbGA7xnqWVe72DWDX9GBwKWtKll0rAh8jlCAHoxe816Qd
         Lxa7nGfUEDZ9tYqIPxY1GWuJGtIuElWhC6l045rJ0pHJhmwDANd50zGI4+ubIEyZgZ5E
         5BKhrCtlvOrxcSUfOsmQK924eb9LOMNTvsaPW3wcJukFMN6X8JI4NP1NfZDxCX45Iss5
         t5NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSciiIvwHvES7A97MdRWnctAxlah4O4RminWHCcw8o0LU+vTVllPwwYHnJ8KdPtBx+TX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlk7WEa6Gsp1nC+AeN9hGPiSxzqFFYwYCcAWHKEetXX5rzkMGx
	gGrHl4MopYSWHf7iyji9ifPqN8p/f5oUyhipZG950aoAxRtuEEWN/O1rLL6UO2oJw1jpfXXwwID
	0aZd9F0udejHhPNcCiff7R5BrQL0=
X-Gm-Gg: ASbGncu1EsAxzO8FeEwHmIMWizMloKFkUZaG1EOz8RSa9nbTvUnN2D1ZFNARN9SO8XP
	LXgb0DIKzJTWpVs3J11TMpLnzmP+qtCFtXqa8JbnuqSIFbxOjPyQrp20z1KptA3x+BOJvxYcewA
	==
X-Google-Smtp-Source: AGHT+IH0BeEkKASJITt7urGAm9S9MuI4b2eVrcmT36axQ+rmAMeJt349b9TvSTygtwDqU/VJCBvxPvPGHn7U5NQa+cY=
X-Received: by 2002:a05:6102:38ce:b0:4bb:c24b:b615 with SMTP id
 ada2fe7eead31-4bc054ffc7fmr4139572137.12.1739529046508; Fri, 14 Feb 2025
 02:30:46 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Feb 2025 02:30:45 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z67MG8utrQfUrakz@ArchLinux>
References: <Z67LkxAFIAeaYr0U@ArchLinux> <Z67MG8utrQfUrakz@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 02:30:45 -0800
X-Gm-Features: AWEUYZnSJZQwQUAN96vQpj-maR5w4lDrumhO91Axd4xB_TEWfjSxxwTCaDzdRiQ
Message-ID: <CAOLa=ZQTJhs+s+4y1DUpGDn7CnM5qwAgicgkcjA6ngmkbhwZyA@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] packed-backend: add "packed-refs" header
 consistency check
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: multipart/mixed; boundary="000000000000e4e727062e17aaaf"

--000000000000e4e727062e17aaaf
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> In "packed-backend.c::create_snapshot", if there is a header (the line
> which starts with '#'), we will check whether the line starts with "#
> pack-refs with:". Before we port this check into "packed_fsck", let's
> fix "create_snapshot" to check the prefix "# packed-ref with: " instead
> of "# packed-ref with:" due to that we will always write a single
> trailing space after the colon.
>

Okay. So we're extending the check to also include the trailing space.

>
> However, we need to consider other situations and discuss whether we
> need to add checks.
>
> 1. If the header does not exist, we should not report an error to the
>    user. This is because in older Git version, we never write header in
>    the "packed-refs" file. Also, we do allow no header in "packed-refs"
>    in runtime.

Makes sense.

> 2. If the header content does not start with "# packed-ref with: ", we
>    should report an error just like what "create_snapshot" does. So,
>    create a new fsck message "badPackedRefHeader(ERROR)" for this.
> 3. If the header content is not the same as the constant string
>    "PACKED_REFS_HEADER". This is expected because we make it extensible
>    intentionally. So, there is no need to report.

Do you think it's worthwhile adding a warning/info here? This would
allow users to re-run 'git pack-refs' to ensure that they have a more
up-to date version of 'packed-refs'.

>
> As we have analyzed, we only need to check the case 2 in the above. In
> order to do this, read the "packed-refs" file via "strbuf_read". Like
> what "create_snapshot" and other functions do, we could split the line
> by finding the next newline in the buffer. When we cannot find a
> newline, we could report an error.
>
> So, create a function "packed_fsck_ref_next_line" to find the next
> newline and if there is no such newline, use
> "packedRefEntryNotTerminated(ERROR)" to report an error to the user.
>
> Then, parse the first line to apply the checks. Update the test to
> exercise the code.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  Documentation/fsck-msgids.txt |  8 ++++
>  fsck.h                        |  2 +
>  refs/packed-backend.c         | 75 ++++++++++++++++++++++++++++++++++-
>  t/t0602-reffiles-fsck.sh      | 52 ++++++++++++++++++++++++
>  4 files changed, 136 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> index b14bc44ca4..11906f90fd 100644
> --- a/Documentation/fsck-msgids.txt
> +++ b/Documentation/fsck-msgids.txt
> @@ -16,6 +16,10 @@
>  `badObjectSha1`::
>  	(ERROR) An object has a bad sha1.
>
> +`badPackedRefHeader`::
> +	(ERROR) The "packed-refs" file contains an invalid
> +	header.
> +
>  `badParentSha1`::
>  	(ERROR) A commit object has a bad parent sha1.
>
> @@ -176,6 +180,10 @@
>  `nullSha1`::
>  	(WARN) Tree contains entries pointing to a null sha1.
>
> +`packedRefEntryNotTerminated`::
> +	(ERROR) The "packed-refs" file contains an entry that is
> +	not terminated by a newline.
> +
>  `refMissingNewline`::
>  	(INFO) A loose ref that does not end with newline(LF). As
>  	valid implementations of Git never created such a loose ref
> diff --git a/fsck.h b/fsck.h
> index a44c231a5f..67e3c97bc0 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -30,6 +30,7 @@ enum fsck_msg_type {
>  	FUNC(BAD_EMAIL, ERROR) \
>  	FUNC(BAD_NAME, ERROR) \
>  	FUNC(BAD_OBJECT_SHA1, ERROR) \
> +	FUNC(BAD_PACKED_REF_HEADER, ERROR) \
>  	FUNC(BAD_PARENT_SHA1, ERROR) \
>  	FUNC(BAD_REF_CONTENT, ERROR) \
>  	FUNC(BAD_REF_FILETYPE, ERROR) \
> @@ -53,6 +54,7 @@ enum fsck_msg_type {
>  	FUNC(MISSING_TYPE, ERROR) \
>  	FUNC(MISSING_TYPE_ENTRY, ERROR) \
>  	FUNC(MULTIPLE_AUTHORS, ERROR) \
> +	FUNC(PACKED_REF_ENTRY_NOT_TERMINATED, ERROR) \
>  	FUNC(TREE_NOT_SORTED, ERROR) \
>  	FUNC(UNKNOWN_TYPE, ERROR) \
>  	FUNC(ZERO_PADDED_DATE, ERROR) \
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 6401cecd5f..ff74ab915e 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -694,7 +694,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
>
>  		tmp = xmemdupz(snapshot->buf, eol - snapshot->buf);
>
> -		if (!skip_prefix(tmp, "# pack-refs with:", (const char **)&p))
> +		if (!skip_prefix(tmp, "# pack-refs with: ", (const char **)&p))
>  			die_invalid_line(refs->path,
>  					 snapshot->buf,
>  					 snapshot->eof - snapshot->buf);
> @@ -1749,12 +1749,76 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
>  	return empty_ref_iterator_begin();
>  }
>
> +static int packed_fsck_ref_next_line(struct fsck_options *o,
> +				     unsigned long line_number, const char *start,
> +				     const char *eof, const char **eol)
> +{
> +	int ret = 0;
> +
> +	*eol = memchr(start, '\n', eof - start);
> +	if (!*eol) {
> +		struct strbuf packed_entry = STRBUF_INIT;
> +		struct fsck_ref_report report = { 0 };
> +
> +		strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
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
> +		strbuf_release(&packed_entry);
> +	}
> +
> +	return ret;
> +}
> +
> +static int packed_fsck_ref_header(struct fsck_options *o,
> +				  const char *start, const char *eol)
> +{
> +	if (!starts_with(start, "# pack-refs with: ")) {
> +		struct fsck_ref_report report = { 0 };
> +		report.path = "packed-refs.header";
> +
> +		return fsck_report_ref(o, &report,
> +				       FSCK_MSG_BAD_PACKED_REF_HEADER,
> +				       "'%.*s' does not start with '# pack-refs with: '",
> +				       (int)(eol - start), start);
> +	}
> +
> +	return 0;
> +}
> +
> +static int packed_fsck_ref_content(struct fsck_options *o,
> +				   const char *start, const char *eof)
> +{
> +	unsigned long line_number = 1;
> +	const char *eol;
> +	int ret = 0;
> +
> +	ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
> +	if (*start == '#') {
> +		ret |= packed_fsck_ref_header(o, start, eol);
> +
> +		start = eol + 1;
> +		line_number++;

Why do we increment `line_number` here? There is no usage beyond this.

> +	}
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
>  	int ret = 0;
>  	int fd;
>
> @@ -1786,7 +1850,16 @@ static int packed_fsck(struct ref_store *ref_store,
>  		goto cleanup;
>  	}
>
> +	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
> +		ret = error_errno(_("unable to read %s"), refs->path);
> +		goto cleanup;
> +	}
> +

So we want to parse the whole ref content to a buffer, wonder if it
makes more sense to use `strbuf_read_line()` here instead. But let's
carry on.

> +	ret = packed_fsck_ref_content(o, packed_ref_content.buf,
> +				      packed_ref_content.buf + packed_ref_content.len);
> +

We pass the entire content and the EOF to the function.

>  cleanup:
> +	strbuf_release(&packed_ref_content);
>  	return ret;
>  }
>
> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index 42c8d4ca1e..30be1982df 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -639,4 +639,56 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
>  	)
>  '
>
> +test_expect_success 'packed-refs header should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit default &&
> +
> +		git refs verify 2>err &&
> +		test_must_be_empty err &&
> +
> +		for bad_header in "# pack-refs wit: peeled fully-peeled sorted " \
> +				  "# pack-refs with traits: peeled fully-peeled sorted " \
> +				  "# pack-refs with a: peeled fully-peeled" \
> +				  "# pack-refs with:peeled fully-peeled sorted"
> +		do
> +			printf "%s\n" "$bad_header" >.git/packed-refs &&
> +			test_must_fail git refs verify 2>err &&
> +			cat >expect <<-EOF &&
> +			error: packed-refs.header: badPackedRefHeader: '\''$bad_header'\'' does not start with '\''# pack-refs with: '\''
> +			EOF
> +			rm .git/packed-refs &&
> +			test_cmp expect err || return 1
> +		done
> +	)
> +'
> +
> +test_expect_success 'packed-refs missing header should not be reported' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit default &&
> +
> +		printf "$(git rev-parse HEAD) refs/heads/main\n" >.git/packed-refs &&
> +		git refs verify 2>err &&
> +		test_must_be_empty err
> +	)
> +'
> +
> +test_expect_success 'packed-refs unknown traits should not be reported' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit default &&
> +
> +		printf "# pack-refs with: peeled fully-peeled sorted foo\n" >.git/packed-refs &&
> +		git refs verify 2>err &&
> +		test_must_be_empty err
> +	)
> +'
> +
>  test_done
> --
> 2.48.1

--000000000000e4e727062e17aaaf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6a85bd80b2373203_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ldkcxUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMTFDQy85YkpZRkNRMXBTcFhHLzhUZGoxMGhZNTdzcAp0YkZ6bHZFT1k2
TUIrWDVCenJSRnduUEVQN2VQQ1orY3Zzc2NBNGFKSDRmeksrbWl3c0dwOXY5bXhaT3pXSktMCmN2
RnI0Tm5TckQxd0U2UC9EbWZFWm1CVWFueTJqaHdXZEFCaklwcThnN2g0ZWVEd0hPbHVudnFhR3dO
bVp3VWEKZ2o5bGtvWWZQNkVIQ3RnZUtGTEhVc2lqVGoxNENseGtIU25hVTR1T2RkSXQwZmJiZlh1
a0RFZnJvUVVCbmlldwpEZzM3RE5jVWFGeHYvZ3BNL0xsc2lFWVQ2M0JnNno3bXJXL2VGU3BiYmUw
anBKLysydXEvd0kwQnRKSEFnWGl3Ci91YlA5dmdXVnJPOGp0V01HME5SK1JweWF1UVlSTUpNLzV3
VWM5QkhsVlF5WmZKalB6MVV6Y2YvU1hQc2ZWbWUKejJOQ2hsaW53djFrRGhibytMbEJEL2VaVzVI
bHhDSEw4WDU3bzc4QTlwbHQ2czl5YWN0Q0VQWDdmcGNXcVM3UwpCWDhQOHdyYnE3QUZEWDZIWkpD
Nk1ieHRNSlNxOFNoa2oxbk9qZWFSZkRYVVpCVk9DVllCbHdGb2FRc3gydjlxCmJPMndLVHREaDNW
Yy9Xb2MrSCs0czhUTit2NlpxOHRvV3N2LytzOD0KPWxScy8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e4e727062e17aaaf--
