Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FABEA59
	for <git@vger.kernel.org>; Thu, 25 Dec 2025 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766620877; cv=none; b=nBoXnaIIiaKUQvRIg9gEnWWr7TkCzuSLtlaghkvtql4LQZqtMJ8q03hU1M/kQhXe4ED5IMOOJtkGtokIthttKy5OkpNUSbQ28HNJv3SClTPkvmKHFfWkYn5YkMGi0nmxjD7gPOGNAChniTon2vAEiy5JER2S2EKwJu0ZUwf/WQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766620877; c=relaxed/simple;
	bh=Lwv7Y8hrIU9V1LYzfz+L2iUn+Dvix6egecZk0QPS6jM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CxZZh5fDFqGir2hdmhy+MkAr3cxUjWRAgFaHCxp20lAHplHsWaIyI4xnc1wyMSUTZ/aPLuMr6ePjBEX0LBPJkm0mPWJguCblc0EITQ5FQV85LUqu0zIyYjhuNWRdcz76xRVZJoTj9oDxIZ+BxtfiUwdOsOPCkshTgoRETgEs4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aOFXrEUs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RD/gTRez; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aOFXrEUs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RD/gTRez"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2B3DE7A00CF;
	Wed, 24 Dec 2025 19:01:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 24 Dec 2025 19:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766620874; x=1766707274; bh=knkhpuupVS
	UARmjFZJ7prYj04uyYL+5h+QjEdG1roJo=; b=aOFXrEUs4a+d7gKqniEBD/HECx
	hpsz489PdODTJ2ljPd1c5MemYp370RD1bID3h/f38+/zHYuhtsvePqJPbPvQM5fQ
	u063eYy7E1LxeoMvoobSwQBpD6qTJi+KTO4mw2LVnr5k3U9VR9WgA66q2TGbLR2g
	AQ+w4EgwEYWiiLgC34P2gO32vCBfm21zVGQipEgEw+weGJxyuqRIbsRygj8sKkFC
	eAtG/dTsjNnQjeORkfskqA07fHcoTrLMh3YfYK9G9L/tNi6YPuwOILTDo3IibCqi
	cK8W6DkC8wIhmbaXaNGSLVW8aJ1QDWLqgOTAgFPai21tGQHM7r6gEJ8vAezw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766620874; x=1766707274; bh=knkhpuupVSUARmjFZJ7prYj04uyYL+5h+Qj
	EdG1roJo=; b=RD/gTRezAUWw1VDcJuWNdaRp/VQIIVtZFipjcgxKl1L/1qiFIqa
	4FcOAMXSL1NJx4j9LBP+NsGDCdVyqGOWzAAXvleaL5uC18QELV4ytfGy7E0v/i1L
	AnmMZPP1Ku2ntWLbWZIvzo/J/GZAuibf9b/x9Hu7d018u9/VbV70DMjTm0ZN3oId
	/7XbLTTySOsIp9AORc6S7yNJ0Ilcui1HSrvjVTRR8eA9v2klR8F5G7aqPMufzLc0
	H0Hd8aQTgecaPwaeO5Td81d8eqfunScrhyKwf7oC0fe+DUwr42s6bm9rBxZgYyyo
	VCTTHe0U/TXVOyf4ZnexEuDU6NLCYeA9sEA==
X-ME-Sender: <xms:yX5MadxIgRhU7-kCZOR4kiIy7abBZ3vV0iCahrvq6_3L5vJrGY2zgQ>
    <xme:yX5MaZ2UHQF-TewP7pKRI7zG5a4oa8OVydzD8nAp950YSKaQWvqebyjd0n9bgwvmM
    YQbTjFFkYRsFzHabuD06dNw_8GnDgYPFJ7k0csoJgDwdWI0A9k7RFo>
X-ME-Received: <xmr:yX5MabyNf6cLChru5u6BHvFGwDNdrKR5U9QQU5ta822l5gUcMMJjNoC5ncVfE_hhHKO7Gkuk2nmaB6DUS1EIAJ0-s9indWANcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeigedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphgruhhlohdrtggrshgrrh
    gvthhtohesshhhohhpihhfhidrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtohepphgtrghsrghrvghtthhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:yX5MaWVCa8znjmoOCh3OzVIT-Q7OmYwITFbTuWWPdD2Z0PcgVM5bDw>
    <xmx:yX5Maf_ai45F7qEdhNr_kxgEDuSmlRRK4NxZfyWkEwwGT90XM6YB_w>
    <xmx:yX5MaRvQYzaVfnGAPYTTIe4yZ4A114dNzHALcmCwMAwvDRRgyklwxg>
    <xmx:yX5MaX1GHKyOkr6b4TSa7PsQGnUYahy19xv_DrJFBl3mAMm11xk3Vg>
    <xmx:yn5MaXP1hYZx4q2JpuIoZgh6RHz_2uQ5ozIsl8bgCRKOZhTI3e2ENZbb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Dec 2025 19:01:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Jeff King
 <peff@peff.net>,  "Paulo Casaretto (Shopify)"
 <paulo.casaretto@shopify.com>,  Patrick Steinhardt <ps@pks.im>,  Paulo
 Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v3] lockfile: add PID file for debugging stale locks
In-Reply-To: <pull.2011.v3.git.1766579053136.gitgitgadget@gmail.com> (Paulo
	Casaretto via GitGitGadget's message of "Wed, 24 Dec 2025 12:24:13
	+0000")
References: <pull.2011.v2.git.1765997966593.gitgitgadget@gmail.com>
	<pull.2011.v3.git.1766579053136.gitgitgadget@gmail.com>
Date: Thu, 25 Dec 2025 09:01:11 +0900
Message-ID: <xmqqwm2bmnug.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com> writes:

> For a lock file "foo.lock", the PID file is named "foo~pid.lock". The
> tilde character is forbidden in refnames and allowed in Windows
> filenames, which guarantees no collision with the refs namespace
> (e.g., refs "foo" and "foo~pid" cannot both exist).

Lucky we had this wiggle room for us ;-)

> The file uses a
> simple key-value format ("pid <value>") following the same pattern as
> Git object headers, making it extensible for future metadata.

It may be just me, but "a Git object header" to me means the "<type>
<length> <NUL>".  I suspect that you modelled this more after
commit headers (in which case you may want to say "pid <value> LF"
to stress the fact that a record is newline terminated).

> +The PID file is named by inserting `.pid` before the `.lock` suffix.

Don't we use tilde somewhere???

> +For example, if the lock file is `index.lock`, the PID file will be
> +`index.pid.lock`. The file contains `pid <value>` on a single line,
> +following the same key-value format used by Git object headers.

Same comment as the one for the proposed log message applies here.

> diff --git a/apply.c b/apply.c
> index c9fb45247d..6d24f1d9f8 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4212,7 +4212,8 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
>  		}
>  	}
>  
> -	hold_lock_file_for_update(&lock, state->fake_ancestor, LOCK_DIE_ON_ERROR);
> +	hold_lock_file_for_update(&lock, state->fake_ancestor, LOCK_DIE_ON_ERROR,
> +				  LOCKFILE_PID_OTHER);

Hmph, I thought I suggested not to send this as a separate
parameter, and instead use a set of bits in an existing flag word
that currently carries only "what to do upon error" bits?

>  			hold_lock_file_for_update(&state->lock_file,
>  						  state->index_file,
> -						  LOCK_DIE_ON_ERROR);
> +						  LOCK_DIE_ON_ERROR,
> +						  LOCKFILE_PID_INDEX);

Ditto.

> +static const struct lockfile_pid_component_name {
> +	const char *name;
> +	enum lockfile_pid_component component_bits;
> +} lockfile_pid_component_names[] = {
> +	{ "index", LOCKFILE_PID_INDEX },
> +	{ "config", LOCKFILE_PID_CONFIG },
> +	{ "refs", LOCKFILE_PID_REFS },
> +	{ "commit-graph", LOCKFILE_PID_COMMIT_GRAPH },
> +	{ "midx", LOCKFILE_PID_MIDX },
> +	{ "shallow", LOCKFILE_PID_SHALLOW },
> +	{ "gc", LOCKFILE_PID_GC },
> +	{ "other", LOCKFILE_PID_OTHER },
> +	{ "all", LOCKFILE_PID_ALL },
> +};

I wonder if we want to sort the array entries here, even if we look
it up linearly (as the table is small enough)?

> +	strbuf_addf(&content, "pid %" PRIuMAX "\n", (uintmax_t)getpid());
> +	if (write_in_full(fd, content.buf, content.len) < 0) {
> +		warning_errno(_("could not write lock pid file '%s'"), pid_path);
> +		goto out;

The caller still will get a non-NULL pid_tempfile?  If you failed to
write the contents, wouldn't it allow the caller to handle the
failure more smoothly if you allowed the caller to know about the
failure, perhaps by removing the temporary file and returning NULL?

> +	}
> +
> +	close(fd);
> +	fd = -1;
> +	pid_tempfile = register_tempfile(pid_path);
> +
> +out:
> +	if (fd >= 0)
> +		close(fd);
> +	strbuf_release(&content);
> +	return pid_tempfile;
> +}

> +static int read_lock_pid(const char *pid_path, uintmax_t *pid_out)
> +{
> +	struct strbuf content = STRBUF_INIT;
> +	const char *val;
> +	int ret = -1;
> +
> +	if (strbuf_read_file(&content, pid_path, LOCK_PID_MAXLEN) <= 0)
> +		goto out;

Any and all failure to read the pid_path is a silent, including an
empty one?

I'll stop here for now.

Thanks.
