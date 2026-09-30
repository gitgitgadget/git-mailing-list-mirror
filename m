Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA4650E59D
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786573; cv=none; b=Vc5gMfbQMEWZKwDB187gMg6vz+OMDKOK0bb6M3kKX+Rzajr/YmWX6L2uXuA38fOsOXin0nvEtlN+vt04inJKJlg3mCQwvuTH9bG/BS+VcK+FRSHcvDK0CyjcS47dU0H/sQBmQheIWyIwpb+ivhBArf7lZ5glfE96kOMuzMu/D2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786573; c=relaxed/simple;
	bh=ltzswyIXxsdw4VwwWuuLp9+qR05jjDDj58Zqea7rtP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pQVHG/uh8A2p2b3geBYmSPgqFaRsOhQb6KtkeR256R8X4jTC0M4V6cHmOWTiA9C3W6zZs737Lv39ou9fWilyKwINrEZhYTMXI4DNzTHvX3xtxYlt7JT1d40V8G3YRX22AP5gbh2R3dGGd+t3BAUsSMj5LIxr5hBN/P1WGh64RL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WOhqnvlw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oLn+Yc3R; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WOhqnvlw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oLn+Yc3R"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1793914001FF;
	Wed, 30 Sep 2026 12:42:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 12:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790786570; x=1790872970; bh=WIpkONaYEA
	vbYpitY6kuXRvaJ9EbotUmwKsYuQjtiKo=; b=WOhqnvlw/rI59a+G5TPt86KEb6
	fFhu/Jt9w/VAPVkKib7jz18ARPSdaZuYwI+jcQmOV1HJNW+EjmMcH8aHiex7iY0X
	43ekqd3kzwVYC40edM8jWs5AR4alnge8JthCK1AspLllxnVINp+Atd3F2/0m9zdk
	Dyc+mCCdcI5jH1T02MyawHWVdq+uS4kumAR3T6zEjKBmznwNSteg1oDHGmyfxb7w
	FmP1AzgLr37U4D+i2MFXPyjcuiOqng1tF6EbTyQRw3UwHAU4RySdazyhS9Ysvr9T
	BcBCYB9msgMNlD29wJyAUbNcdkW5Kf1b9dJpibz/imfv7zsFs3sKi5+Cn3bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790786570; x=1790872970; bh=WIpkONaYEAvbYpitY6kuXRvaJ9EbotUmwKs
	YuQjtiKo=; b=oLn+Yc3R68k/62URdj/2Mit2JWEB7Nis9GBrffCDOCXE0rcQprO
	uqUnSWvWNFN5r3eGa6N0HgGVXWw0rkl+9vrcjKq9nL39mpcr/gQW2K4gewzOZ9BA
	rkewiEa5DomLofa2jp29xvqyTt7pne29yrvxDc0mf1P8BPZvZu1slIQKUeh+sMGJ
	dR4JtLofXxMexRNprpmOTg8E5PIMkIdTgp2Ic8ndrW1I3qz000SpncSfSimMm203
	d+iyLO1bTFZd5LobcCcQ1dEVk/ro0hwpPcsL87FAtyrT7G+Z8ElOUtvQ7+HuO0tn
	G9cCHgULXOuXLBw4gnYSFZgpU7LjPAfbzpA==
X-ME-Sender: <xms:Cjy9aps8qJIEh3hgtEbXK1kTxEc4b0tIzdTAmLoTUyDsyEXgkK6KCQ>
    <xme:Cjy9apfQJ0R2uSWu6IVl6g03Igq9RugquKoIuMrqPSqcrmNCNQODIukej0pjMDUJR
    RpMC6XJ32Y_HxMwIyJygi6wSPBVROjMh7VPSlOH_ScswxnTTGJvrwY>
X-ME-Received: <xmr:Cjy9ahyIeXVrCdnIyEQgGTWHd2NkxXmTlS05FJq-Q-u-nFm915qWmR6Jxc97lfZGqcabfc5WEcIpj0urUcQ8Nz3pywyEzMfW-pA->
X-ME-Proxy-Cause: dmFkZTFaRhR9oRfVDhdAwoxOK4Id7g6VfahyNXb31ZMnuDzeMEksS72EZb2AyjiNJUwj3x
    2zBAsw6/FUWf5H53+oRBT2f+3gDdZsVPsQhVXEst2tTVbGFGcDRVf1t/h67BzTwQZTVuJD
    1uLVkytD5BiAErW1lbXlq/d31KQQjcdo+wfz1fhMzAQJ44c76LHA0jCSCU7Hd3Bj0zRVEO
    pUgfDziU2F2Vz4StmudKxnPtSiaymnGynmveNkdjhdKFmqsp3O1KSuNPjEUK15p3XsKLIN
    Cu/uOBgd0CvtFWLomUfg29cmxQL8SMETH8fCutmtD7VIK7qJd6X11ChMJva2U1xzz6ScBe
    kW0mW/JXg+lvZg/YMVtoYk7gVAFC03NywahETve9DbgvHmYl3fwjjMdrpcQoB+6mfi9h39
    Kl9fssuMPTsFAvdWJNojAH5cGNnr6hEEmtMoK36xPd3RI/jHhKAyLggZOTCjPFjEH3hD6T
    uN6z0vuvj6hklc2Za0vL++XM9l0LEno/p0QIhnkQVSeP4mmy+a68zzSUwpw0+KKjgTelU4
    Ob+JioiKjAWpvZVTkn5JnsPTy0wPUQNxr+fvo+I/esavX+v609b8rSYU8AuH24f+AniFms
    Hnu75R8VSvFfa2mfXVg1tpaVTqDKb5flx9g2zfzdGU6tN1C+XXB5UVY+MObw
X-ME-Proxy: <xmx:Cjy9avEp-M9d9M6UkY3sDXZbwyVO7muy8Hw_kfO6bW8ZWR7OBh0JJQ>
    <xmx:Cjy9alyXxdeGJmABSVJef32a5GVzpqphXge10vaJmfzcynU-LjoeZA>
    <xmx:Cjy9agtohARfGYMm8Y0KMJHh8ehbJQCcJ_ho1M6FgQnmosTDTMoXvw>
    <xmx:Cjy9ai1C6d1oEm_rtu1QnEOYu50wjeUNrQb6GS6WnJEVX5D03NhwvA>
    <xmx:Cjy9alRpsYJ9hTh7TZqR_BI7lokRfIuaT0Q-hgGvzqfaBsGhqZ27SGYU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 12:42:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] merge: remember conflict labels
In-Reply-To: <fdaf3da993366878b51bd0b2a950888710cafb8a.1790761727.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Wed, 30 Sep 2026 10:48:49 +0100")
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
	<fdaf3da993366878b51bd0b2a950888710cafb8a.1790761727.git.phillip.wood@dunelm.org.uk>
Date: Wed, 30 Sep 2026 09:42:48 -0700
Message-ID: <xmqq1paad71z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When recreating merge conflicts with "git checkout -m <path>" the
> original conflict labels are lost. For commands like "git merge" and
> "git cherry-pick" we could use the presence of the related root
> ref (MERGE_HEAD and CHERRY_PICK_HEAD respectively) to recreate the
> labels. However, if the conflicts are from "git stash pop" or "git
> checkout -m <branch>", then there is no ref to deduce the labels from. To
> ensure the labels are always available, the merge machinery is updated to
> write ".git/MERGE_LABELS" when it updates the worktree and
> there are conflicts. The labels are then read from that file by "git
> checkout -m <path>" when recreating the conflicts.
>
> As "git checkout -m <branch>" calls remove_branch_state() which
> ordinarily removes the labels file, we need to pass a flag down
> to optionally prevent that so that the labels are available for any
> subsequent "git checkout -m <path>". Note that merge_switch_to_result()
> we assign "result->priv" to "opt->priv" and later clear "opt->priv" in
> order to get a pointer to the private struct as result->priv is void*.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  branch.c           | 11 ++++++--
>  branch.h           |  1 +
>  builtin/checkout.c | 24 +++++++++++++++---
>  builtin/commit.c   |  1 +
>  merge-ort.c        | 19 ++++++++++++++
>  merge.c            | 63 ++++++++++++++++++++++++++++++++++++++++++++++
>  merge.h            |  4 +++
>  path.c             |  1 +
>  path.h             |  1 +
>  repository.c       |  1 +
>  repository.h       |  1 +
>  sequencer.c        |  1 +
>  t/t7201-co.sh      | 21 ++++++++++++++++
>  13 files changed, 143 insertions(+), 6 deletions(-)

Where do we talk about MERGE_HEAD and CHERRY_PICK_HEAD in the
current documentation set?  Do we want to mention MERGE_LABELS
alongside them?

> +
> +int write_merge_labels(struct repository *r, const char *base,
> +			  const char *ours, const char *theirs)
> +{
> +	FILE *f = fopen_or_warn(git_path_merge_labels(r), "w");
> +
> +	if (!f)
> +		return -1;
> +
> +	fprintf(f, "%s\n%s\n%s\n", base, ours, theirs);
> +	if (fclose(f))
> +		return error_errno("could not write '%s'",
> +				   git_path_merge_labels(r));
> +
> +	return 0;
> +}
> +

We write three items, one per line, delimited by LF.  As this goes
through stdio, wouldn't Windows write CRLF-delimited lines?  I guess
if we read this back through stdio, that will cancel out and we get
the LF-delimited lines back?

Wait.  Do we want to read this file via stdio, one line at a time,
using three calls to fgets()?  No, we do not give a strict upper
limit to the length of these labels.  So if we read with
strbuf_read_line() or something, we would be safe, I guess, but alas
there is no such helper function X-<.

> +static int parse_merge_label_line(const char **p, char **line)
> +{
> +	const char *eol = strchr(*p, '\n');
> +
> +	if (!eol)
> +		return -1;
> +
> +	*line = xmemdupz(*p, eol - *p);
> +	*p = eol + 1;
> +
> +	return 0;
> +}


OK, this reads one line at a time from the file contents already
fully read by strbuf_read_file(), as seen below.

Which means that the CRLF fprintf() may have written in
write_merge_labels() will come back to this function, and our 'ours'
may become 'ours\015' after stripping only the LF at the end?

> +int read_merge_labels(struct repository *r,
> +		      char **pbase, char** pours, char** ptheirs)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *p;
> +	char *base = NULL, *ours = NULL, *theirs = NULL;
> +	int ret = -1;
> +
> +	if (strbuf_read_file(&buf, git_path_merge_labels(r), 0) < 0)
> +		return -1;

Can strbuf_read_file() fill '.buf' halfway and return a failure, or
does it ensure that it frees '.buf' before returning failure?  Just
double-checking.

    ... goes and checks ...

strbuf_read_file() calls strbuf_read(), which calls read_in_full() to
fill a sufficiently large buffer, and a failure from there results in
strbuf_release() or strbuf_setlen() resetting back to the '.len'
before strbuf_read() was called (i.e., 0 in this case), so we do not
leak anything on the error path and this code is safe, I think.

> +
> +	p = buf.buf;
> +	if (parse_merge_label_line(&p, &base))
> +		goto out;
> +	if (parse_merge_label_line(&p, &ours))
> +		goto out;
> +	if (parse_merge_label_line(&p, &theirs))
> +		goto out;

OK, we read three things.

> +	ret = 0;
> +	*pbase = base;
> +	*pours = ours;
> +	*ptheirs = theirs;
> +out:
> +	if (ret) {
> +		free(base);
> +		free(ours);
> +		free(theirs);
> +	}
> +	strbuf_release(&buf);


OK, so the contract is that we will not touch p{base,ours,theirs}
if we return failure, and we will not leak anything when doing so.

Which is very sensible.

> +	return ret;
> +}

Looking good so far, modulo a small worry about writing via stdio
and reading back while bypassing stdio.  But perhaps CRLF is so
annoying that the compat/mingw layer takes care of all of the above
worries by passing the 'binary' bit down to the msvcrt/ucrt layer,
in which case we should not have to worry about it.  I dunno.

Thanks for working on these patches.
