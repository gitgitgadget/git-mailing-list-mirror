Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB268325497
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770146792; cv=none; b=LM5uV0mFuPsUjQg9dwIUOMjdVVkw/B8ouOF+TJm4Iae7eQPN/mHOGKBRhmxNzARSLXo+Fe/lsPSjeZuAcS/GcsGwM8TY+u30l3dlK9KX8/57MIjHFuzBw8zgwKCBNLLGygHXQ7AuUNWZmOtSDSyKkSLNzUsyIEmtJLLG0qfVHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770146792; c=relaxed/simple;
	bh=zXV8mEUrIu1qOyOT6iQ4HF3XMSeynh4KEbUI1HWOCCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jQZYjXS3ugYrrClKc5U6N8btbxqYcJ/6SCcLlOozjFmCk99SIJSuFkYouiWksD6qkatI8cAnVDEjxi4uRH5DOkxO1ge1i5k6WGImL9VUYOP+vKkdKIpZ25SjmTk+95XhTgWVg2DPOJmbxL0NcVh59JWjPs5+2HvAx9rHkRKP3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c/EAS5fj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qxvFXFMm; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c/EAS5fj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qxvFXFMm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 32EC57A00AB;
	Tue,  3 Feb 2026 14:26:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 03 Feb 2026 14:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770146790; x=1770233190; bh=SvSHgF+Aeq
	tlsuRjVgdnAJnVZYW/cnItxiEEtZOA8xs=; b=c/EAS5fjPqQXsHKbe9SyXSxPxD
	nC2Ge15I3p7FDTmrTtcJkgLtwpo37WnDCnvSU2gRMExkfmTT4Fc3KEx+WbyI49/N
	vk5kR2hYApglP7iHEKKkKn5T98AMAb6Zz2x6OoduqctB46LTbSpCULOUi3XemB58
	/T/S7OK66hh6MnQn2++HjAeNegVmF2Ra23SzBAG1CLwaTrYfgWNGeHtC+eZgj4Kz
	sbkrUF2yRysihutTt1N0h9p7wxXE4h503++NQ2Oa+8Ult1tEsFLPGqCnhhEpoB+3
	3yYjoeNcHx/p5dQAUX0ffGnQvUCJ67FY7CQfUcXRkgq80TGOKn5T6+pDE+SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770146790; x=1770233190; bh=SvSHgF+AeqtlsuRjVgdnAJnVZYW/cnItxiE
	EtZOA8xs=; b=qxvFXFMmTESfFOzjmO+BRjMa4wllZWfH5iSN4VYUeoxVsgQDAG5
	MKu0VTt7m04/ZftKtE6xjvEp66oXy/DUo+9LS7yDBV/TloH1jzzazRaf1CDzAIFZ
	eV2ipKgEl/sRv6okO4pBpRtaRAaW2YV/v4oPIlSAyxQvDw+kP8W+FBQ2jOs2poyW
	AvCW2T0wJsh4D5ZwANi2oRkMot9RQ4sVN/ic+QfiJg/w3tSVzm7L+HFO1Vq2I8b8
	vxdb+jp2aGRCo8K8PflLkliSrbcKhg24bZ6QaQy7+XndFX0+Xg7tf3uvwwC+mqA3
	Nw55kOgX8mHiU+xEmsjFKTZ6fvR36pQO3bQ==
X-ME-Sender: <xms:5UuCaeiWs8qOY-NHRYWy-E79LALgjpZMOBxhCjlsa7By6NdePdsZ0w>
    <xme:5UuCaWBxGlmIPTKEwsVjq9cBayI29v-7piVX__EhbOp-HZwEJd49TESg_venvZS4N
    p_HvAzvltOGy569mlAw720GuOZEyrA6q6BDCkbD_tuHJ9-URx2DIfo>
X-ME-Received: <xmr:5UuCabGTiOTt7SXxy3HijQi-hkdfgdNlgsfDrRE3vhslYend6nGY8jW8lwcm_HWQvgwciJyKypslf67oZoEBdq_NTawRe8d6mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjrgihtggvtggrohehvddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5UuCaWL2I4G5q5K34SLj-MxoxklZByOB5dHy_zZMvpECOY3TEJ_FSA>
    <xmx:5UuCaXkpRRcW72YCBd4ku8AA7ZLP-UXOwppH8srZQC4yJD_TeUk4vQ>
    <xmx:5UuCaWSs14PLf_mhlRLimkQk0jqrfxKStA22ohdxk_RFKcMEQwGQDg>
    <xmx:5UuCaRJS0RNP0u1a2dDpFqaStAHW_OmmKtYSQlPAov2CpwIp6Pfvag>
    <xmx:5kuCaVBXfC_QIGBvlyh8IhUzN-YHPPBKdyyVFnrXCkqk7ASSwx1r26xg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 14:26:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "NitroCao via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  NitroCao <jaycecao520@gmail.com>
Subject: Re: [PATCH v2] clone: fix segfault when using --revision and v0/v1
 protocol
In-Reply-To: <pull.2185.v2.git.git.1770119773541.gitgitgadget@gmail.com>
	(NitroCao via GitGitGadget's message of "Tue, 03 Feb 2026 11:56:13
	+0000")
References: <pull.2185.git.git.1769937818682.gitgitgadget@gmail.com>
	<pull.2185.v2.git.git.1770119773541.gitgitgadget@gmail.com>
Date: Tue, 03 Feb 2026 11:26:28 -0800
Message-ID: <xmqqfr7hsk63.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"NitroCao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nitro Cao <jaycecao520@gmail.com>
>
> When `git clone` is used with `--revision` and the protocol version is
> v0 or v1, the client segfaults if the revision does not specify a peer
> reference (e.g. `--revision master` instead of
> `--revision refs/heads/master:master`).
>
> This occurs because `update_remote_refs()` assumes that if
> `remote_head_points_at` is set, `remote_head_points_at->peer_ref` is
> also valid. However, for v0/v1 protocols, all references are fetched
> without filtering, and if the revision lacks a peer reference,
> `peer_ref` remains NULL.
>
> Add a check for `remote_head_points_at->peer_ref` before dereferencing
> it to prevent the segmentation fault.

Hmph.

While your change may skip the code that segfaults, wouldn't it also
stop noticing a broken case where .peer_ref should have been set but
didn't, even when --revision=<rev> parameter is not used in the
command invocation?  IOW, it is better to segfault and draw attention
by Git developers when a valid input is given by the end user and our
code misbehaves (e.g., and fails to to set .peer_ref as it should).

Stepping back a bit, "git clone --help" says the following on
"--revision=<rev>":

    `--revision=<rev>`::
            Create a new repository, and fetch the history leading
            to the given revision _<rev>_ (and nothing else),
            without making any remote-tracking branch, and without
            making any local branch, and detach `HEAD` to
            _<rev>_. The argument can be a ref name
            (e.g. `refs/heads/main` or `refs/tags/v1.0`) that peels
            down to a commit, or a hexadecimal object name.  This
            option is incompatible with `--branch` and `--mirror`.

The intent of running the command with this option seems to me that
we do not want to create any branches, neither remote-tracking nor
local.  Looking at what is done in update_remote_refs(), I think we
still want to honor check_connectivity even when we are in this
"single revision only, detach the HEAD at that commit" mode in order
to ensure the integrity of the data, but we cetainly do not want to
call the write_remote_refs() and the write_followtags() helpers.

Wouldn't the correct fix be more like the following?

 - split out parts from update_remote_refs() that are needed even in
   option_rev mode into a separate helper function, and call that
   from cmd_clone().

 - make the call to update_remote_refs() conditional---specifically,
   we shouldn't be calling it when option_rev is in effect.

>  builtin/clone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Also, isn't this something we can specify the expected behaviour in
tests?  Not only we want to ensure that nothing segfaults, we would
want to make sure that the resulting repository has no refs and HEAD
is detached at the specified revision.

Thanks.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index b40cee5968..ba8de92563 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -558,7 +558,7 @@ static void update_remote_refs(const struct ref *refs,
>  			write_followtags(refs, msg);
>  	}
>  
> -	if (remote_head_points_at && !option_bare) {
> +	if (remote_head_points_at && remote_head_points_at->peer_ref && !option_bare) {
>  		struct strbuf head_ref = STRBUF_INIT;
>  		strbuf_addstr(&head_ref, branch_top);
>  		strbuf_addstr(&head_ref, "HEAD");
>
> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
