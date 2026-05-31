Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA471A9FBC
	for <git@vger.kernel.org>; Sun, 31 May 2026 00:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780188400; cv=none; b=rZF3jMzoqx2apG10SKkWNvi2AW+WvBxhPCSUvmvpQ67Y77pNr8JE+ZIJxP4lfK6TWEYZbAL+l8nNBrdPMFVm2sfG4Zk2L0eYDorWJiRPnHcTT5lSrStQwB7xxbfJp3yUums4cQqVnwoRnpCmH3V/FjMhNZI+mfCDOovHGaxC5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780188400; c=relaxed/simple;
	bh=d0Pb1DK72qxMlo4qJtU46UW8u2q1auEYjDhgxvxF240=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OW6slSPXDAXsiPqY1SJMlzeaNUfS5JB81dtkm56Mu+fYLnkItPdDswMaXwgxOrygTt4/o973NJl28HJhkerkh1wOE2eJqYcfr2W1ouh95H0rKnCy7YEb5XV13sda0PAEPJA912djxSTDjXe8Vp83hHr2upcgDqTIQ/XPaXJVTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LEiLkljt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L8BrzvIE; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LEiLkljt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L8BrzvIE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 13FFA7A0065;
	Sat, 30 May 2026 20:46:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 30 May 2026 20:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780188396; x=1780274796; bh=XptlJL1TqY
	S6jGZaTHXH/b9pOb7PBQT+jqTbAjWi9tU=; b=LEiLkljtRfgQT6iQXRdmolOKO4
	6Ax4UGdkEuxtwohZ1syWWDIR7oBvxYa7TB+HsF+SjuxftC54rykWV9mhyXOOb+Oq
	xAhb2QwE8Tl4608KbYVqYkxWoNfptLpQC5GsLrYCdxjvJ2X9b/cJdEDbsrFlQfty
	8o/qE/m04Y7OGxJYcnAhjLzwJJ2HGvMHQUBw94J/P0bjAMFcGjI7GezMFvUnoDje
	arCvhTYYWFQNqPrjEvFInyS0LjbUNND8wH+2lqTdUOosnGhbzUnBk3vLisgrm2yC
	XREZb3nxLteW/PTAzarBqr5VOwIzWAz25A4Ax84Q4RdSO78sidcv9abBWe+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780188396; x=1780274796; bh=XptlJL1TqYS6jGZaTHXH/b9pOb7PBQT+jqT
	bAjWi9tU=; b=L8BrzvIE+AAPZioSoyOUMIMC44KHTVqQJFciOlSKIG9dlKP52Re
	Z8kvNC7/Lty3OnMhinxoHBK1IxGJTFGBfu1zWPRqzhHEE/HTt6pa3QsmKGYSwh4A
	qDvQz6iObjhIMxVB0PQ/7glmihqYVZwwFNZFxzgiCHw/tQWQLUKRmDR2ApG6ZK45
	yuLSWBxjvcT/jvoB/C+CdkRHmXxxi71imusFSHKBgpeu435WofXiKSc4LzH8IU+p
	Lpqfu8TeGRibKqrjWesGfr4xmnnzOkF6pzh/QMPzu+JYl/Z8ru5u6BLzIsh/nFkD
	10LmCLkhoO0HTDmy1zvG8EOxk7dcBaL4Edw==
X-ME-Sender: <xms:7IQbamck4a9FHUFvXFHX5mg2hMSW7dMfkblvj5KYJSeab_9AOe0m4Q>
    <xme:7IQbanHwsSVzRu0c_J2GKj6nWUlezf6KW6ChCcy-61ogUxinfEznALE-MEe_uzsZy
    Dv0DhLiBJC635vnXqUfROuFYS2h9i3lJUsOU2uYuXajm5Y5xxfXfA>
X-ME-Received: <xmr:7IQbav14BzQLquap6J4GMK7m7u0qFdKNa8PTgFqBSxMt5zcjSS40LlKC9kj4kEBst7EeCPd5nqfOSK-51Oi8Xb2vXFyStyvsppIk>
X-ME-Proxy-Cause: dmFkZTEU0ZzRAJ0FxF4Ety1I/vSd8OHLIGA4ep1aiLZCoSDkBdRXznnB62J5l9Ufz6wsrI
    +IBatqN5kkXeYCHJ9xKAoJXelIMNRF59HnutzLzXd36j+iLJTCtz35OITsEKg67wX9it8h
    ktVN5P86TTzjrSadPnZpNfz5vpYtTackPomUxED6jH9HVJffbx7bWsv9PmwA7QtnoLQclC
    DEi69gME1pDTBr8WgRULl8FCR5hK0Jqy3YwWPhvPJQpcZAZT2pUa9VYUPKkrw4x2SOve+5
    /YttnkIHJ339i2PFSA25P+CnyXWZ5xm2aQsoSwvSLC7h5dmRjlaFyB9DT5waTcnqA2nFDg
    0htIE+jeJ5FSZK8f6EuPPX4rWgZsp9rAJdoznMX1rfZRZdMnXVzld70AN+i0es0nEsgBkw
    3DXSp2OFC1LwBLvgt0HI6vJF0Rdgcrf7zil/ighfvcke6qn2f6iFRe+4tFQCMJnke+L+im
    8jdguZlkV46xG9wZvRBMxfAbc/x2T029di9GSkchI3XzsDlaG50M+XuiwpavV0ee+/7RUD
    x3DvqVd7MZSiJM1yWb3Ygar4A79iFPKAt7I3ZUx46h38whtfom+wY6NIt6kwvvzEJbSluv
    vOo7pZ7ZZv7yGTbpeFHsSI67t7pO/mPhaa6AbdLsu0x3cil4SDQGue3ADMmw
X-ME-Proxy: <xmx:7IQbavn7vlITxOIG-lSGL991XSv87CLFlp3z6KG0g1NdQfyCLWUlPg>
    <xmx:7IQbav-7VD7XXfxljSYrsb5ux_Yj7aLWfNSfxK7MnQwEcKGPOp2W1g>
    <xmx:7IQbakp_CyCBFfsCkJXW3bFRd2QuDf7ZtuWDVtqanwJQip6q6JyteQ>
    <xmx:7IQbaon2stPjYdDF6kGXOPxbklPgQ357haVAOCfnvbZBCzPqGQH9iA>
    <xmx:7IQbam2vWYr_XRmFQuJtL-qgBLXWmcOfr5Rmfl5Rf3pNtYPq5nwBqu07>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 May 2026 20:46:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/2] status: improve rebase todo list parsing
In-Reply-To: <b80bc1e0a298e2773a2fdab3e73651d59b8d39b7.1777648598.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 1 May 2026 16:16:39 +0100")
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
	<cover.1777648598.git.phillip.wood@dunelm.org.uk>
	<b80bc1e0a298e2773a2fdab3e73651d59b8d39b7.1777648598.git.phillip.wood@dunelm.org.uk>
Date: Sun, 31 May 2026 09:46:35 +0900
Message-ID: <xmqqbjdwcsno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> +static void abbrev_oid_in_line(struct repository *r,
> +			       struct strbuf *line, char **pp)
> +{
> ...
> +	have_oid = !repo_get_oid(r, p, &oid);
> +	*end_of_object_name = saved;
> +	if (!have_oid)
> +		goto out; /* object name was a label */

Can there be a label "deadbeef123" that is unrelated to an object whose
object name happens to abbreviate to "deadbeef123"?

> +	case TODO_MERGE:
> +		skip_dash_c(&p);
> +		while (true) {
> +			p += strspn(p, " \t");
> +			if (!p[0] || (p[0] == '#' && (!p[1] || isspace(p[1]))))
> +				break;
> +			abbrev_oid_in_line(r, line, &p);
> +		}
> +		break;

What does this loop do?  A "merge" command may look like "merge
[[-C|-c] <commit>] <label>", and we give each whitespace-separated
token to abbrev_oid_in_line()?  Would "<label>" that is ambiguous
cause an issue?  You may want to limit the scope of what the loop
does a bit, e.g., massage only the token after -C/-c, or something?

> +	case TODO_FIXUP:
> +		skip_dash_c(&p);
> +		/* fallthrough */
> +	case TODO_DROP:
> +	case TODO_EDIT:
> +	case TODO_PICK:
> +	case TODO_RESET:

Doesn't RESET also take a <label>?  And if it happens to be the same
as an abbreviated object name, e.g., "deadbeef123", of an unrelated
object, would wt-status say "reset deadbeef1", causing a mismatch?
If this is indeed an issue, would moving this to the "no-op" section
below, next to TODO_LABEL, solve it?

> +	case TODO_REVERT:
> +	case TODO_REWORD:
> +	case TODO_SQUASH:
> +		abbrev_oid_in_line(r, line, &p);
> +		break;
> +
> +	/*
> +	 * Avoid "default" and instead list all the other commands so
> +	 * that -Wswitch (which is included in -Wall) warns if a new
> +	 * command is added without handling it in this function.
> +	 */
> +	case TODO_BREAK:
> +	case TODO_EXEC:
> +	case TODO_LABEL:
> +	case TODO_NOOP:
> +	case TODO_UPDATE_REF:
> +		break;
>  	}
> -	string_list_clear(&split, 0);
> +
> +	return true;
>  }
