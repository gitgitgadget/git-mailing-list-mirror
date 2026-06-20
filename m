Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F9175A8A
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781965666; cv=none; b=hI5hHA76ezanI9iMkz+cPyHv3efdeZsFnn1YywducvE7u1zZw2VryMNPzYKit8SArrwvDy7Sfz0yhSkX2vJbyaQipJJO503iM8eCJw6qGrw84Ugj2znMJFN4tpjI1Pbcz8YWmPBEQxFphynM9fWNa47pijsEfC2fAnNkPzsUn+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781965666; c=relaxed/simple;
	bh=nXWIgRvbFABg+nRnRMSZLHg8K1Hjr8vff4PI/B6YWRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G93/nESRFU3/vVQaWS9GXYzA9UUHpDH8bVcxRxNB5nfKIZv+gP5ucrSlXrpBE9SBAtwtGGByoDZX2iMPSwXnKvCy8Wv9IPxFEb/DdKFVwTxVrR8YfP/JS2+curTTLBQr0k1I8FHCfRmZBzq3l+gzyuJWirIZ7vWbpwinjA2DYt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hk9Jo4pM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZFojHZS7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hk9Jo4pM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFojHZS7"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30F251400077;
	Sat, 20 Jun 2026 10:27:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 20 Jun 2026 10:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781965664; x=1782052064; bh=FLmzLh7Yys
	MjP78OlLaATg9AE2hRzECGqj/e3cOkAJM=; b=Hk9Jo4pM8Mb8SrvheqrwZ37lKQ
	fMuMGTETw+9DEad290lxtF/x2Je6dZS6OWhNnI8hiBSvCJQMdb2AI4Ub76n4QIPO
	DNk1f4S1wlh6O5MoS7Lbgmwwpn1g+84ZNdvlm/89h6IpW58GiBpiuoLBNUSS4r37
	iEq53Js6PkyQ1BcvOzES2U73+NdoWlyJwW75SgzsnSbzpEh93yhIXZIJekgXH39R
	vrjdw+tTvDZJFKCluWYjY8A9FhznsB+wa25Mxw29bYSp0osXAlKAYljiJdDIxUwa
	lyTRECdJJPWymGnWBOtsxhVUcc17Y8ErOBDMgl6JUucP8Vrwb3bvw9DnvUGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781965664; x=1782052064; bh=FLmzLh7YysMjP78OlLaATg9AE2hRzECGqj/
	e3cOkAJM=; b=ZFojHZS74zBtCB55cJjzcv3+xs1LkzhW92gcoGusF5kSIvNOQPB
	1aXY21tdeBORxD/vLEcnJYzI3dcFsSZe95Gp9kdZNVOVShT4ieFFdULx5cz35BQL
	D0VRCcOQtjqZ1820z4C1AMZY+JgquebibZeml7E679Bu8B3YKQIFElwt/cyvnRvU
	n9btfKDLa58DfaAEsRbH5vXPLplY8Jf1kKXsYPuSXhIjPSeUoBTnS/5gKFEQC+Df
	j1cKmerxu8EzEZcXnQhkZukcLVrSid8YrK8aeZh7Phd09CZVpXiGWYoM/QtNFhrg
	49VPfEs+Lwt4TElqF1eCZksJXHacdw7cOQA==
X-ME-Sender: <xms:X6M2agLTlKCOLSPuzSMUodSzaVQ3LG5um-ZM0d5uM_dj3Mg1F1SNAg>
    <xme:X6M2ajOlPocMpf2l6ChAW7BcCbecZMiKvcWeofZw7Z3TT5CkqfpxUlUJ4WlHGzsbD
    mCOzVVrKTVGVjpUenHQY5UJLkF-WKe90cCkKE133nWVkfojUmMXbec>
X-ME-Received: <xmr:X6M2arUAOr87eOuj15TMHzTJtgy0N2We1RAxmGA2vfiLPaYQ-QAwgEwf4mkqfQiv95apf5aqCI8ynVQe55foKG4eYjpul7LnKMnNrr8>
X-ME-Proxy-Cause: dmFkZTFz9f/iN8vM0VHhDicC4kND+eykdY5tyskqP7GdYy4VKYr4wsL+2eJBUytL7uPB0e
    gcjCI4Arg5JWdDucfn0sXhS1EHhDQpIRKE3gGGQIqKdwTs98tNYPN5fqiZxlDFkyvAXpSH
    cpJbcCUIcHJciDKEIeZpOHeXFRaOc8ULVZG3SZ7hyuiTyoyyskbq5uAiIgK2cUfSwwno9J
    hTV9S08TqGJQ3nFzqHkiJCbzBZSjFMPsk2gIr3YXwG6RcJ8MaEBP9KzWLg+rOgxIRkoeAM
    NdgQCH8YguufK1FMBhKwStiB34wN7YzfTsC6Zb4avetRN2JOtlaSmYJjDJM6Lqgr0zlGZT
    4DLa3IveOnq7AG7ie8+w59/b5agtR2l/vla5wIyVoS9qoOHJphdsuN86vVCAcA21A4jSPu
    biAdGBVNmmW5HrDrWf9bsjrrBWLrlrDjmoXOxEEvjjOoY+fe78bEfuDmOpNdON2da7JmnB
    MP+Al50rdvOepA64McprzhIBmfSmW8v2UlTRym/KIzI+bLUk9Xv0IDFKqnbfQMhMq4shhm
    im+agewS0qJ8dHQQgeziNfWK+UOjSgaJWOWQUriL7M8e1KxSlmU2o+aWIDufUYVZVAb10y
    qsuIoUjkE1LX1hwuU/A2aOW9/IHKS+qzOjdZti3nl8l8xFPK9MimagNbprew
X-ME-Proxy: <xmx:X6M2apliM_6XATqyW1PdVwCVAG3YYJZioueywWuI68A6vbhgeAaPCQ>
    <xmx:X6M2aiPaQo1bngfAjZtpmULXqo0HD5RVYs2Tj2sUnwcjgJHwUoRLgA>
    <xmx:X6M2apJjKGrUh2nDlSxmU7UNjnwmpEYES98v8kqNK5m8q2MJoo_6zg>
    <xmx:X6M2ak1TumycaJtm0sDn6vvw_cVtgVTdw3a0u82zXQsufX_L-Vck4w>
    <xmx:YKM2asFMUmnYyhdCJn0pDDebIGccfPNn32Z7MOtNdN6VS0vggheahr0C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jun 2026 10:27:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  lucasseikioshiro@gmail.com,
  phillip.wood@dunelm.org.uk,  sandals@crustytoothpaste.net,
  kumarayushjha123@gmail.com,  a3205153416@gmail.com,
  kristofferhaugsbakk@fastmail.com
Subject: Re: [GSoC Patch v6 1/4] path: introduce append_formatted_path() for
 shared path formatting
In-Reply-To: <20260620031644.353772-2-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sat, 20 Jun 2026 08:46:41 +0530")
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
	<20260620031644.353772-1-jayatheerthkulkarni2005@gmail.com>
	<20260620031644.353772-2-jayatheerthkulkarni2005@gmail.com>
Date: Sat, 20 Jun 2026 07:27:41 -0700
Message-ID: <xmqqbjd5guci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> The path-formatting logic in builtin/rev-parse.c is tightly coupled
> to that command and writes directly to stdout, making it impossible
> for other builtins to reuse.
>
> Extract the core algorithm into append_formatted_path() in path.c
> and expose a path_format enum in path.h so that any builtin can
> format paths consistently without duplicating logic.
>
> Mentored-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  path.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  path.h | 30 +++++++++++++++++++++++++
>  2 files changed, 99 insertions(+)

It often, even though not always, is a sign of a bad topic structure
to have an insertion-only patch without any removal of existing
code, that adds totally unused code.

If the step is to "extract the core algorithm", shouldn't it be able
to replace existing code already?

We may want to add new features to this helper function near the end
of the topic, but wouldn't it make sense for the topic to first
consolidate various path formatting logic already present in the
existing code into a single helper for ease of extending it (which
means replacing open-coded logic in existing code paths with a call
to the new helper, which would have a code that may look very
similar to the original code that was replaced with a single call to
the helper function), and then expose the helper for use by new
callers, and finally further add new features that existing code
paths wouldn't have needed but the new callers would want?

How else can we make sure this new implementation added by the first
step in the series is (1) capable enough to reproduce what we
already have in different parts of the system, (2) does not bring in
what the current codebase does not need, and (3) bug-to-bug
compatible with the existing code paths?

> diff --git a/path.c b/path.c
> index d7e17bf174..6d8e892ada 100644
> --- a/path.c
> +++ b/path.c
> @@ -1579,6 +1579,75 @@ char *xdg_cache_home(const char *filename)
>  	return NULL;
>  }
>  
> +void append_formatted_path(struct strbuf *dest, const char *path,
> +			   const char *prefix, enum path_format format)
> +{
> +	switch (format) {
> +	case PATH_FORMAT_UNMODIFIED:
> +		strbuf_addstr(dest, path);
> +		break;
> +
> +	case PATH_FORMAT_RELATIVE: {
> +		struct strbuf relative_buf = STRBUF_INIT;
> +		struct strbuf real_path = STRBUF_INIT;
> +		struct strbuf real_prefix = STRBUF_INIT;
> +		char *cwd = NULL;
> +
> +		/*
> +		 * We don't ever produce a relative path if prefix is NULL,
> +		 * so set the prefix to the current directory so that we can
> +		 * produce a relative path whenever possible.
> +		 */
> +		if (!prefix)
> +			prefix = cwd = xgetcwd();
> +
> +		if (!is_absolute_path(path)) {
> +			strbuf_realpath_forgiving(&real_path, path, 1);
> +			path = real_path.buf;
> +		}
> +		if (!is_absolute_path(prefix)) {
> +			strbuf_realpath_forgiving(&real_prefix, prefix, 1);
> +			prefix = real_prefix.buf;
> +		}
> +
> +		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
> +
> +		strbuf_release(&relative_buf);
> +		strbuf_release(&real_path);
> +		strbuf_release(&real_prefix);
> +		free(cwd);
> +		break;
> +	}
> +
> +	case PATH_FORMAT_RELATIVE_IF_SHARED: {
> +		struct strbuf relative_buf = STRBUF_INIT;
> +
> +		/*
> +		 * If we're using RELATIVE_IF_SHARED mode, then we want an
> +		 * absolute path unless the two share a common prefix, so don't
> +		 * default the prefix to the current working directory. Doing so
> +		 * would cause a relative path to always be produced if possible.
> +		 */
> +		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
> +		strbuf_release(&relative_buf);
> +		break;
> +	}
> +
> +	case PATH_FORMAT_CANONICAL: {
> +		struct strbuf canonical_buf = STRBUF_INIT;
> +
> +		strbuf_realpath_forgiving(&canonical_buf, path, 1);
> +		strbuf_addbuf(dest, &canonical_buf);
> +
> +		strbuf_release(&canonical_buf);
> +		break;
> +	}
> +
> +	default:
> +		BUG("unknown path_format value %d", format);
> +	}
> +}
> +
>  REPO_GIT_PATH_FUNC(squash_msg, "SQUASH_MSG")
>  REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
>  REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
> diff --git a/path.h b/path.h
> index 4c2958a903..4d982a2c8e 100644
> --- a/path.h
> +++ b/path.h
> @@ -262,6 +262,36 @@ enum scld_error safe_create_leading_directories_no_share(char *path);
>  int safe_create_file_with_leading_directories(struct repository *repo,
>  					      const char *path);
>  
> +/**
> + * The formatting strategy to apply when writing a path into a buffer.
> + */
> +enum path_format {
> +	/* Output the path exactly as-is without any modifications. */
> +	PATH_FORMAT_UNMODIFIED,
> +
> +	/* Output a path relative to the provided directory prefix. */
> +	PATH_FORMAT_RELATIVE,
> +
> +	/* Output a relative path only if the path shares a root with the prefix. */
> +	PATH_FORMAT_RELATIVE_IF_SHARED,
> +
> +	/* Output a fully resolved, absolute canonical path. */
> +	PATH_FORMAT_CANONICAL
> +};
> +
> +/**
> + * Format a path according to the specified formatting strategy and append
> + * the result to the given strbuf.
> + *
> + * `dest`   : The string buffer to append the formatted path to.
> + * `path`   : The path string that needs to be formatted.
> + * `prefix` : The directory prefix to calculate relative offsets against.
> + * Pass NULL to default to the current working directory where applicable.
> + * `format` : The formatting behavior rule to execute.
> + */
> +void append_formatted_path(struct strbuf *dest, const char *path,
> +			   const char *prefix, enum path_format format);
> +
>  # ifdef USE_THE_REPOSITORY_VARIABLE
>  #  include "strbuf.h"
>  #  include "repository.h"
