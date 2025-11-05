Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140321FDE31
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383789; cv=none; b=ApM0GqCINHy9Pst9QrdyXiLzzwvVzh9ocLIm8hT2KZysKS8wIjefDProBcmXCMmTlkEAox9KPOLJqbdFMTvmNXv5xjnDjps/vvvZB9JPkKBsjJ7oGt+MXfXe9T9PdlI9owl5g6KYBG6B2u5bzbBVMa9dR57h9Gh4TBZcU85uiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383789; c=relaxed/simple;
	bh=yja0dTqKJ8gB1ndXeU3u0HAKfuo1JcmSBDq0b6xSCME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AHZ1odM+TF92sP32yPSh2y0RQS/v0bMSW44mLyuk0WsT3RaiV+XszNy/8XeEIFS4rLiyGXepX+Iwal+rpG9C9Fc+mh9xP6oB2qDKw9T6jbTl4XHBd3hnXWXjtlmf9Qhk6R2Ym/1heMzgkaaryQfMUnX8+A8FhbzSNd+bdQum6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jsLT9zi0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WLbuwS8A; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jsLT9zi0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WLbuwS8A"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 16D671D001AB;
	Wed,  5 Nov 2025 18:03:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 05 Nov 2025 18:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762383785; x=1762470185; bh=RAlF0a3+RS
	94ODZbUvI+wFMVulfomEGCkDmqJCBuRks=; b=jsLT9zi0NjJFJEOtV6CyATTX8x
	6fVqkmLBwRCnLVgO2Kn30nl4jbKNhOQjxeQhCA4gb4bwOKBcWY8sV0TiWNFtniN1
	WadCIc0pA5szj1A/+uWo1AJsSgf8z+cefDb/vbtpYav3Ta1vd640wxywl1cgQJAI
	86a5lTrFHW/ZP9n4omsniILBw33lMYpGHkVA/nsWmvQ4yLfPl7D9RuBlEjrMf7uu
	RgYtgiebNh0mmUjzwvWntgoSiqhNeNoqJ7ziwMpoeVMO8nxWXSZ4Pte/lYhV7tgG
	EaEL73VKm34odkkkT7X8j1nr0ddMLPjO3ItR5O9QtLqEdqDFBZVoLecY5Q6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762383785; x=1762470185; bh=RAlF0a3+RS94ODZbUvI+wFMVulfomEGCkDm
	qJCBuRks=; b=WLbuwS8ARrAqcF9uMLcWSR5q5qCRey8Kqso5MLXiOFm8MymhPkk
	5Enz4QC7s9jxyybVeesjzF6r/j0mRV6KnPQ6qYkzphF8M5p6CpLmNIFC36Pal9YB
	QwDgNe3ZLWmy+BA/Y5iuHMVV3el196wKxmrDocNIa24UfMvRh3WDTlVDA675+BSa
	+rMM0tPlppFAyKzqxKEcz+JLVqg/myfuyoPH0ZabAaBH0WauWo+b+dzCWPW4l1d8
	5ElmPTj20ivv5+ykOh3tIY6aXw/2q8QlOf921mYjJ/gJuElqfHyn2dHGiIO5OmsV
	Sk99IOwIvvGq5KeUDjo3kUOqjP+olLFDd7A==
X-ME-Sender: <xms:qdcLabgQITSUCGhXtglOGCyQachAOJC-VsvKxPPsieQhhP7rtzUevQ>
    <xme:qdcLafzxg8no6jdBg4GkgtUlrv-WMYdSNWJPk-u10GK01MUN7sb99mRsRrHSeYvT5
    yV0H4tVGCCLM53n7KqJ3naO6zso5qveqRwpP0BsLYDaoZbvLnxYmwE>
X-ME-Received: <xmr:qdcLaeLrR19UvJj7og04K1M1nS0BKICeUN0mZH2AjcZ7pocoHl5P_7eujgKrZbuUMusm7xyea-VxHjGzCuRH4FvOO6H2-_BrAEfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvthgvrhesshhofhhtfiholhhvvghsrdhpphdrsh
    gvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qdcLaWT8dapekg__bqD0R9qwaXj30oRUTCmvRM86NvJnAdUIwHlJ0w>
    <xmx:qdcLaWpYAWfYvg-4pdNuu5KaoqlnDEKbOI9RVPIf7LPHPCDdp4Iumw>
    <xmx:qdcLabqh6OFB0l8JrRdEcdjL9xPljmBgxm2fPrth7frj0YBNIdCGTw>
    <xmx:qdcLaQMGvALVjcGzlcxVwLTpYqWEv8msSbcLxz9_Ll0_Z1cvQ8f_Ow>
    <xmx:qdcLaRj06cOEWEotfyJxcPqd6L6Clxd1dRazUohdQTICzNoUa_T4EkQ0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 18:03:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Peter Krefting <peter@softwolves.pp.se>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] refs: Add missing space in message
In-Reply-To: <a8220721-3260-15cb-6960-ca8b6433d7b5@softwolves.pp.se> (Peter
	Krefting's message of "Wed, 5 Nov 2025 22:47:17 +0100 (CET)")
References: <a8220721-3260-15cb-6960-ca8b6433d7b5@softwolves.pp.se>
Date: Wed, 05 Nov 2025 15:03:03 -0800
Message-ID: <xmqqikfokrq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Peter Krefting <peter@softwolves.pp.se> writes:

> Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
> ---
>  refs/files-backend.c    | 2 +-
>  refs/reftable-backend.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Good eyes.  Both of these came from 465eff81 (refs: fix invalid old
object IDs when migrating reflogs, 2025-08-06), which appeared in
Git 2.51.1 already.  Let's merge it before the upcoming release.

Thanks.


> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 054cf42f4e..1adc4b5182 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3124,7 +3124,7 @@ static int parse_and_write_reflog(struct files_ref_store *refs,
>  		if (!(update->flags & REF_HAVE_OLD) ||
>  		    !(update->flags & REF_HAVE_NEW) ||
>  		    !(update->flags & REF_LOG_ONLY)) {
> -			strbuf_addf(err, _("trying to write reflog for '%s'"
> +			strbuf_addf(err, _("trying to write reflog for '%s' "
>  					   "with incomplete values"), update->refname);
>  			return REF_TRANSACTION_ERROR_GENERIC;
>  		}
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index d4b7928620..eeec64798f 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1103,7 +1103,7 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
>  		if (!(u->flags & REF_HAVE_OLD) ||
>  		    !(u->flags & REF_HAVE_NEW) ||
>  		    !(u->flags & REF_LOG_ONLY)) {
> -			strbuf_addf(err, _("trying to write reflog for '%s'"
> +			strbuf_addf(err, _("trying to write reflog for '%s' "
>  					   "with incomplete values"), u->refname);
>  			return REF_TRANSACTION_ERROR_GENERIC;
>  		}
