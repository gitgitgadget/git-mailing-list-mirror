Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194F1D8DE1
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750114936; cv=none; b=RvwlebouhMXev38bQgshqfGj9ZVnna2t6FyCiyIEVeefZZEx1loUPxAW2eE+yH7HuCRHrbRr2bTNiCt3SMAH0i5JLxUKR4gDAL96VP3bhZWrHZccXm76fGb8b+hsD3uE/aFq8PC7F1kkK8ZIF1B8pRbuxTZ8rWfgWxPEhwQJG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750114936; c=relaxed/simple;
	bh=WgWaOmPVVJ1RJYwqBPTDpbFDT1A5c3lN09COrrqW3fQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EVSw3l5oK4Uf2e329tJ0z85sK1QKJ84Ud2+UxGKBsH0ftP9F71bDTs4OWrboUZYs+Husxb7FD6cfG0NdXtfJveg43q56/S4VAVZ3vlseN6T10k3iV7iu/AruSQFOfnBpwUSZurYWClfaHc5bq1kqeVnvauUNb3z/iKpCjziGzd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e7SsE0wr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lYNHPkkW; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e7SsE0wr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lYNHPkkW"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 17C622540181;
	Mon, 16 Jun 2025 19:02:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 16 Jun 2025 19:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750114933;
	 x=1750201333; bh=AcRzmXTSYqxRYCRFKx0oNWzB38OjnZ+mmXc0zeZtUZk=; b=
	e7SsE0wrkINWp2Gk41UWbmX6dKrSK5r0RZciCIfpwlsLFFqYulh3MOgT70K7Bnqq
	6hm5Fk+kjqTHRbC7W2b/9500EjAvcQ/izxjGkJDqNB0n4JVG6fHLX8hukTQdVUXF
	QkwQWSMvdx8NbjC+CsuS5/dobnwS6yesrpCd/wuLfBl44IRzEL8E40K1/Ac3LIDI
	PjCwBHuPOqy8VNU7Xj3YbCuSBm8IfumFgO9rnTishtTb4zci/FLfVSoLISSTQegF
	dxkYnTqADIbnP32333MCgKkSIBtFfQEzQB2q67tZ/UbDAUvc8vPBSuzJxx0x9svQ
	cQBzzzEneFQGyAd2F0HxJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750114933; x=
	1750201333; bh=AcRzmXTSYqxRYCRFKx0oNWzB38OjnZ+mmXc0zeZtUZk=; b=l
	YNHPkkWffHxzWVEJowgndl5cri0nmYtjCnePGtLf36iDkc7aaeeEqaNZlBz83UiC
	bqedFM4glg7lVBszUx9FyY/01McmXHK7O2yDdAzswmxmuMVK8TQXju6VOPo1G3bT
	awucIQaLRGh3g+31Gf+MgOwPJYhebFTUu8sqgSfWO2Fj0HKeofwyFnvk/N1LfXIj
	qpbX6nMqiCYfzXfVOmV5w1AZ7BQodDaC/m2gwI2XE5RQnE517vtsV1WS0NBVL76I
	tGevg5w6yHWTYuvD0fg405SfNQA8UHBCMJDV/NSHUDCwo6ZdQjstMfghPZ5GETPd
	EFXigursKyC/+fQavcCqQ==
X-ME-Sender: <xms:daJQaJvO-YQCWR1AF0ntNFZwEExz0O7SXSjsXZnOvcwchg8liuPOOw>
    <xme:daJQaCdW1jb1AviLtAQpstfeAqGJA6G_jiTV4Gx_4Hpg2kwWb2Gaa-nxk90DPobCx
    pY4A4Do0KLwFeZwpA>
X-ME-Received: <xmr:daJQaMwQ_h8bTLPr63N3xDH9zMTOmU19zLhRRNRsrB4icrAOI3jmRTXXN9xBYYShMfMXtGCTDtqMHbWaPr5kwhb3N3HP8Tmm1_IO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvjeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:daJQaAPbN4tyvUQs7-3fqN0kyi4S0XE-iMuyJyrATmtHh_n3FvvUjA>
    <xmx:daJQaJ-2lDLMP2AFYjvX2aoEgpIABIl1EPCoDucS6odNfMSnstrQ_A>
    <xmx:daJQaAU43-JBnux0NY0awYJKe2nqaVxwmky9vklObMI-8tk0PU-IvA>
    <xmx:daJQaKfpmJKVzeNGR6MM8jT2owFFmf6m7yWax5V8N9VovlGH9g6dKg>
    <xmx:daJQaNi-IEtbxeAnoYFILaU7RKgNkDUPEgv5JzWMKopH9mJCIJBkkIM0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 19:02:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 1/9] doc: convert git-log to new documentation format
In-Reply-To: <1ce06a184817d0493f4e56725aeb8ed5ccae1ba4.1749373787.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Sun,
 08 Jun 2025
	09:09:38 +0000")
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
	<1ce06a184817d0493f4e56725aeb8ed5ccae1ba4.1749373787.git.gitgitgadget@gmail.com>
Date: Mon, 16 Jun 2025 16:02:11 -0700
Message-ID: <xmqq5xgvz3ws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>
> - Switch the synopsis to a synopsis block which will automatically
>   format placeholders in italics and keywords in monospace
> - Use _<placeholder>_ instead of <placeholder> in the description
> - Use `backticks` for keywords and more complex option
> descriptions. The new rendering engine will apply synopsis rules to
> these spans.
>
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  Documentation/git-log.adoc | 83 ++++++++++++++++++++------------------
>  1 file changed, 44 insertions(+), 39 deletions(-)

This hunk (lightly edited to shift contexts) ...

> ---no-decorate::
> ---decorate[=short|full|auto|no]::
> -	Print out the ref names of any commits that are shown. If 'short' is
> -	specified, the ref name prefixes 'refs/heads/', 'refs/tags/' and
> -	'refs/remotes/' will not be printed. If 'full' is specified, the
> -	full ref name (including prefix) will be printed. If 'auto' is
> -	specified, then if the output is going to a terminal, the ref names
> -	are shown as if 'short' were given, otherwise no ref names are
> -	shown. The option `--decorate` is short-hand for `--decorate=short`.
> -	Default to configuration value of `log.decorate` if configured,
> -	otherwise, `auto`.
> +`--no-decorate`::
> +`--decorate[=(short|full|auto|no)]`::
> +	Print out the ref names of any commits that are shown. Possible values
> +	are:
> ++
> +----
> +`short`;; the ref name prefixes `refs/heads/`, `refs/tags/` and
> +	`refs/remotes/` are not printed.
> +`full`;; the full ref name (including prefix) is printed.
> +`auto`:: if the output is going to a terminal, the ref names
> +	are shown as if `short` were given, otherwise no ref names are
> +	shown.
> +----
> ++
> +The option `--decorate` is short-hand for `--decorate=short`. Default to
> +configuration value of `log.decorate` if configured, otherwise, `auto`.

... does more than what the three-bullet list in the proposed log
message describes.  The result is certainly easier to follow and
more extensible to have these possible values in an enumerated list
than in a prose.

> +`--decorate-refs=<pattern>`::
> +`--decorate-refs-exclude=<pattern>`::
>  	For each candidate reference, do not use it for decoration if it
> -	matches any patterns given to `--decorate-refs-exclude` or if it
> -	doesn't match any of the patterns given to `--decorate-refs`. The
> +	matches any of _<pattern>_ given to `--decorate-refs-exclude` or if it
> +	doesn't match any of _<pattern>_ given to `--decorate-refs`. The

"any patterns" in the original may not be grammatical, but the
rewritten "any of _<pattern>_" does not sound grammatical, either.
"any of the _<pattern>_s"?  I dunno what the convention should be
when more than one <placeholder> instances have to be referenced.
