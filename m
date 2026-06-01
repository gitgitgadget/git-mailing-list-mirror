Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1C83672B1
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357522; cv=none; b=R2vVkSqdrYnoFwLYGDToFOFOqBTx3gRTnHNhFx+WTZwNzOYPN5p6UaMSWX0G/rM41yBx/odmQdTF1O3axWaMzlwAsNVsW5dHXAxW/AMYKpFB+GJMABRMEDDEbM+BiCCScqvkQbuxTIvGsbPuoHBbx9+bfcH9jdUjC/eNwvSWD7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357522; c=relaxed/simple;
	bh=A7ZNF5JS3LVkIlKtv9B1313/mquu2SJ1v9bn0Q4C/h4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EMxCA6S89tccaVA1ZFYz/0LkYEphpz2DqUrDYXq9dDb3eP6IXlKBawngmBy3E31W6JBxYGrvRIdH1GBqvH0KAauV01HG1OWJnXPikoZUnjYYOxU9Q8GYOS7bRK47YFnKRlKp9na85GW7p6eNznzm3LCGC+YTtBOfMh6RMU+R8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LGoUXuNB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cyXz9od1; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LGoUXuNB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cyXz9od1"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD1F87A010F;
	Mon,  1 Jun 2026 19:45:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 01 Jun 2026 19:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780357520; x=1780443920; bh=Dla/WpeQMu
	waqUd0VX2Krnf3XHgmtzrWjcdnqsSkC8w=; b=LGoUXuNBjZDbwMos5oHtsWdJeP
	vU8qRlqzXROuEHRcVYssm13++7oAU7kEQU8GpoOjheZPVGTxgXm+iyxaKNV97S6c
	zoYngzrsWDi6SNVZAH7iwshCtErAUV+lc2DqKVud85E3YVRZUhZsy+AL7wAaHjlF
	1Rh5rqsG6DZ0uWlVnVRVCzXvQZw1uW+OrMxfHjZ68siQSOVbkLNluJirpxxg60Yd
	tAqEKfUGMV7JM+mtVIn4ENhMGOQpBKRpL1X30fTH5sNnNiThGw5ck02948zz6+Nx
	9VrOKdilLgXMX+swDb5GbiyTrCp3mo1Si6cgQAm2KILzUj17R/ByQ4opIL8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780357520; x=1780443920; bh=Dla/WpeQMuwaqUd0VX2Krnf3XHgmtzrWjcd
	nqsSkC8w=; b=cyXz9od1kvXEivs8oHyOBgriN/SKlI2frAIHtcICAar2FmNLTDA
	dQp9JwTKKlTDxD49OfQ4qj+3Tgd1M9zfv5wFaFVTpf9cuXUMVG6HgPB5KawrOFVq
	ZeByTtjRqD62IxvMKhDKR6719K8j4+8OF2cix3HT8Pnx90QbXLAvUcUlWX16SmRA
	nAs/0U3wUXqpK8o6LQiClt3PirNQWaOehSb2lOkRp72ckIBCDZcmmSRSIuiIM7my
	e1AdDZjSIBDwQA0ai8FK98DM0yIreTza0iExSn/rp4V5+7YIryDzRbeOubEwuKws
	jB4zGdM6Tqq/ND8AYMZbbYaUmoUdcUza+EQ==
X-ME-Sender: <xms:kBkeatKssOGKY56jK3XN2aRCYyPF7IElc69M_OGsjUTAvcAIkxNF_w>
    <xme:kBkeagAoQ1ztKQ84FGe0kn8LnodozJyl5u30RsanVelVN3pSCMWia0MH6W5jVxDrm
    P_3R9aFyUhovW9wVn7VVIiPvWCdwuYj7suRtFtiwzJVByuc5uQC>
X-ME-Received: <xmr:kBkeauCamiEdWsZWh4B90J9MPQF1uPtJPxPM4sXNt_cw5d9ggLJJ3Dle_pUR4CdWIcRaImb_bseDyuw5gLNMG-zQq5OeuUzIYMNV>
X-ME-Proxy-Cause: dmFkZTGMX0DjqJn8Rvk636BTh2fHfrPsHP60i2R+Uzhcndwd9BhweGpHPEb/T4cAjovg95
    iNxBku02iEWie576EprXTfKIu1rjzerKFMuDdj3QxU7NIsq38WUTDOAM1DTkNuAN/s1zv0
    URhNk9KFuFhJcp395t6kgyXL1u71tEVmRR1kztm/FJj1pjArGZHMbVxjjnDx56EOIfZKew
    QzCLVXVHoZbH00AN2p0eUfZo9xZgKbAq33edFJj9gu/yz6PNbNjYGGx4cTFzh+oV6phAlI
    eaFTjeMaBJ/wBT9q1PdvAs397X0xCldsN9SHWyZZsQQt2Fn/lYpWsNlkgKvQ+A1KH0D8CI
    7DfhGX58jgwIj+RmlLBj9i6Ew0iA0La/Ww+PNSc5py54w7MltQcZ+TR+awn36XGyxnmdyx
    vibxrSZvoKOV5eTgsxqeQSTl8u5O6abx2bFeFaDvoy3uqrzA1ereLLfKMuv8G4u8kiHdrl
    wlZRyOEL2IsTBlXTvyRN1QoF3tLCa2M2DmAgpyDa6dnHaUssSQCvzQ450GsJQJa12oGk6N
    nZMcQF+Xdmjsf0EUFUiE0YBo8uNiu7OeL4C1QVBoSOWnPOBpyF7lAh/FDf5Hvj+tw3GPr0
    TSTH1M/i2PVUros8UlMQqnIcsZqcEspVN8RuWyr2T9Fwk06Y6n9gCQ8ZnqFg
X-ME-Proxy: <xmx:kBkeaqBbGsKUnheJsztn2FT2AiBhgQ7B4dZRy1Ol0VL4SPjgnesnWA>
    <xmx:kBkeahqAIMBzy3YMY0yFuoXwLjEgK2woYeLx2h8WQ8udM8RBbo_rVQ>
    <xmx:kBkeaslA4qgGAdd68vCbZzKzZUHXcDv3wFUE_9dyyGTGDht8tD6mYw>
    <xmx:kBkeapxzD4wJZmHXhoJw_WvCjPgLtCdrVPxvipVN9vxY6mELJc1Bhg>
    <xmx:kBkeatSFw2Ofrq3HcxTjXiVoXjhSpd1xMbdYBzK55XIALt8fKwu2qhw2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 19:45:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4] config: improve diagnostic for "set" with missing value
In-Reply-To: <pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 26 May 2026
	19:21:27 +0000")
References: <pull.2302.v3.git.git.1779697995418.gitgitgadget@gmail.com>
	<pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 02 Jun 2026 08:45:18 +0900
Message-ID: <xmqqa4td25bl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int is_valid_key(const char *key)
> +{
> +	const char *last_dot = strrchr(key, '.');
> +
> +	return last_dot && isalpha(last_dot[1]);
> +}

None of these are valid configuration variable names, but this
function would allow any of them, no?

    1foo.bar
    1foo.some.bar
    foo.b_r
    foo.some.b_r

or does the caller reject such "key" before calling us?

> +static NORETURN void die_missing_set_value(const char *arg)
> +{
> +	const char *last_dot = strrchr(arg, '.');
> +	const char *eq = last_dot ? strchr(last_dot + 1, '=') : NULL;

OK, the intention is to see "foo.bar=baz" and guess that assinging
to "foo.bar" might be what the user wanted.  eq here would point at
that '='.  And ...

> +	char *prefix = eq ? xstrndup(arg, eq - arg) : NULL;

... prefix is our own copy of "foo.bar".

> +	if (prefix && is_valid_key(prefix)) {
> +		error(_("missing value to set to the variable '%s'"), arg);
> +		advise(_("did you mean \"git config set %s %s\"?"),
> +		       prefix, eq + 1);

OK.  If is_valid_key() rejected invalid variable names correctly,
this would catch $A=$B where $A is a plausible-looking name.

> +	} else if (is_valid_key(arg)) {
> +		error(_("missing value to set to the variable '%s'"), arg);
> +	} else {
> +		error(_("missing value to set to a variable with an invalid name '%s'"),
> +		      arg);
> +	}

The distinction among these three messages does look reasonable,
provided if is_valid_key() gives the correct result.

I wonder if it is too hard to refactor existing logic (perhaps it is
used in git_config_parse_key(), no?) to give us a less noisy version
of it that we can use as is_valid_key() here?

Other than that, the remainder of the code changes looked reasonable
to me.  Thanks.
