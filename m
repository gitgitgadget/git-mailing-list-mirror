Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1473EFFCC
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197094; cv=none; b=raAF+lXDG/svq9G3MtPjWf73F3ucKq69XVr8AtiRc5H2K7fAygUX4EnFqIoPriC15DQOL02Y17cioZkR5Rvm1cBOS/XPo0TBUkOZ2L1jEi0/AIM5fQzNn0XMC8V06jtM++TQiEh+aFmP5DthDcDGs7UwpCExSq56Eex0BSs0Nhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197094; c=relaxed/simple;
	bh=Sr8y5Mhp2yaG4H8GvjTj5L+2Lzj8kqfkwVjgLT7eZXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0EAAqga8LWpfTR+UWtCKkj8dsqTDyJ2q2spGJ+f8Bdk/MP5up64q0jIHRXVRPbhVXtbUSPWYa81MBi1KyqTNVTRpPQTYhW1XjaJs0irYzQkx9m7xNXbfMtZ3QefBluuaWnuide3/xPkwq6o5Ej0768tVmLmZtxJbf//HS/0poI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Aw6T9wLx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V7ZCVv4L; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Aw6T9wLx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V7ZCVv4L"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7AC8A1D000CA;
	Thu, 16 Jul 2026 06:18:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 06:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784197092; x=1784283492; bh=goNMP2TvCi
	koM2NAL/9SbiEBmuZlo1D/0pFKod5Mp+A=; b=Aw6T9wLxf6Xrcx4B9/tgemF9Sk
	zoq5+aB5VaGQlbRgKYccskZcxEnZk0Z4puum/yf8Hx2taqTdXKChwshRQ8TpDPhK
	IJEO719spnDwi72r8wNQTAALu7OD9i2zxJ3vM/B0t3QsraaRpJ9smDxUZHgfuWj8
	30rqHl7cc1FV9MEd4m3sbHiTkIA5cNn0czcvPYXxTP0foWp+Vm9Clq3kryCfuHJG
	rSmSRcODXHAn486sj9Hct+TuMBLZFmAO/yKlx5+0UYIHQO+sCsA6m861QKV6sEls
	BWl9U+tPDqxpLQ5MfFxS0B7HS9VVotkCeA0LaY/nHmC1nIDuexNVjfR9PCCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784197092; x=1784283492; bh=goNMP2TvCikoM2NAL/9SbiEBmuZlo1D/0pF
	Kod5Mp+A=; b=V7ZCVv4LTySPw5p9uN3R3oa4FLItHkSe4ZpfSrcaBYhfxYM6QA6
	kiFwfu42xn5vLq7wZ2LDCHIv/NYVu0+vslWfrdV2v3zAeBPUsFVul3R0Ok7ZclIC
	7acSnZWjc5s8BqyCgOJPJjYOBgSie5x5fuwd2JTVyYm66TLwJXoWRXrzD5qXNeaG
	VG5SyXT13YC3yiETn6NOnU+1RLBE5EhlGcFbrI7yxSZNf7eXBmZeR6ys57I3jqWa
	cYE/Xzd6OXyTCFc4wE092aSiFnqV8jwje72pjL7Eh2n0rk1NqSnMVQOs1Z917YHR
	5wAk6Ja6VBquGAgxjFcIdKyqS+MV2l/T0vw==
X-ME-Sender: <xms:5K9YavCGRSf62AiPaKhsdFFyUDBcKBo6fXEL2KxiXDK79D7dkWT7jQ>
    <xme:5K9Yas8L6GbaYMfkoYMosJgfrAcQT7s2rqpUZuZ78q8_D_FLnv0zqDXeDqD795CQo
    Gf_tsMiia2KuJtEmtmPcWdzsi6_ikEWT4JgknF0s8KKJ97xL6NfUA>
X-ME-Received: <xmr:5K9Yan8Ju-RMFvlbXoldgTnJ8umb5eG0mash_pm4K8DaoPU55OLt8tzVsh5CeTD50kfUPGmqgPMTBu3TM7QH7sxUtlo-0XSYxAEZEtBF>
X-ME-Proxy-Cause: dmFkZTGOj33ASRUaaeBXmo/HnYw+eUGp6Ktb1A9HvGT6CpY+ThB+s5JaSIgjiHHzcx5VtK
    lbAj2XirnfITzUuU9dh6UHXRgQIspzgtNBdLMnuqroJsWLpNaJw+CfwtufJSXkih8Mk4gN
    1n3yFfFgllD3GypCbQedIhTyCahmGnQxG2PZjgPg5CM20z4AnSNufB4cNTSzm62uQ2mAhX
    sZdBLt/scLWPQeUDopwGA1S5Lto2X2ex5gJbw4MmKKnxFaMTaWB/d4EQPPl0QJ+XW4yog2
    /FgJ3ft9BUMKWZAYzwsC53xzA/7OY852u86A17NoCqssLKJniIAJ0PyNp1Q5TFIT/roEmX
    JIJDjmV3tnueCr0bUh0MzIOdw7zcL757HVDN3reVuSMb7W9WixAJEkqAEQypoA4inlO1ng
    IbPhr6/L8ewzH3JZUadmTWAVSu/8voVzggpoVhfY7NqIYDo1xPe5q6mfvdlNK/PkVT66u3
    ZPTe9mU7uAqUths9hf8/pN4400zIi45ZlX5NGT8/NUWGAqBTdau7XyoE8Uc8Zvn2RDwUtD
    ZVRdOISm2oNf9XW7kN8lnzUEFAiPmF/A3qjz4au7hAJ6zu7bMu1iGKJC6ZEO6uPgzJCAuP
    y0YE2J8gQAU+G/Remhz8c0jJqubpmQUdzRL/RixTEvzrm5aE887aPsjzTdqQ
X-ME-Proxy: <xmx:5K9YareoCTr4HcENvAO1IK0qNnwLZV-7VsyP7Dy4ZtvkLJ5raSxDTQ>
    <xmx:5K9YaoG7xggrbom7OIyJKyrFBwm8HdoiCtr1BHFW3SX0sRXGD0gWxg>
    <xmx:5K9Yahc9kQy-ntuyPEVhmsdazPeQb4XE4Tk1KEgfzZ3OYEQ-DJBvQA>
    <xmx:5K9YaqG2wIfhQlAN9TaW7GR0SGEbo7SXLCKE3wRCgmM_e8Swi-ddJQ>
    <xmx:5K9YalGNuOR_oJt6rIaIpLfor82OONC5msp8--DxOzj4eDBu6LSyFnWM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:18:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 726151bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 10:18:10 +0000 (UTC)
Date: Thu, 16 Jul 2026 12:18:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Souma <git@5ouma.me>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/3] builtin/history: sign rewritten commits
Message-ID: <aliv3zgfDvY3JoB9@pks.im>
References: <20260703145037.69832-1-git@5ouma.me>
 <20260703145037.69832-2-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703145037.69832-2-git@5ouma.me>

On Fri, Jul 03, 2026 at 11:50:35PM +0900, Souma wrote:
> diff --git a/builtin/history.c b/builtin/history.c
> index 091465a59e..8d669cf539 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -98,6 +98,30 @@ enum commit_tree_flags {
>  	COMMIT_TREE_EDIT_MESSAGE = (1 << 0),
>  };
>  
> +static int history_config(const char *var, const char *value,
> +			  const struct config_context *ctx, void *data)
> +{
> +	const char **sign_commit = data;
> +
> +	if (!strcmp(var, "commit.gpgsign")) {
> +		*sign_commit = git_config_bool(var, value) ? "" : NULL;
> +		return 0;
> +	}
> +
> +	return git_default_config(var, value, ctx, data);

Shouldn't we rather pass `NULL` instead of `data`? It works, sure, but
only because `git_default_config()` doesn't use `data` at all.

> @@ -160,7 +185,8 @@ static int commit_tree_ext(struct repository *repo,
>  static int commit_tree_with_edited_message(struct repository *repo,
>  					   const char *action,
>  					   struct commit *original,
> -					   struct commit **out)
> +					   struct commit **out,
> +					   const char *sign_commit)

Nit: the `out` parameter should continue to be the last one.

> @@ -515,12 +546,13 @@ static int cmd_history_fixup(int argc,
>  	bool skip_commit = false;
>  	int ret;
>  
> +	repo_config(repo, history_config, &sign_commit);
> +
>  	argc = parse_options(argc, argv, prefix, options, usage, 0);
>  	if (argc != 1) {
>  		ret = error(_("command expects a single revision"));
>  		goto out;
>  	}
> -	repo_config(repo, git_default_config, NULL);
>  
>  	if (action == REF_ACTION_DEFAULT)
>  		action = REF_ACTION_BRANCHES;

It might make sense to document in the commit message why we have to
change the order. I guess it's because of precedence, but not everyone
might realize that immediately.

> @@ -785,7 +822,8 @@ static int write_ondisk_index(struct repository *repo,
>  static int split_commit(struct repository *repo,
>  			struct commit *original,
>  			struct pathspec *pathspec,
> -			struct commit **out)
> +			struct commit **out,
> +			const char *sign_commit)
>  {
>  	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
>  	struct strbuf index_file = STRBUF_INIT;

Likewise, let's ensure that the `out` parameter remains last.

> diff --git a/replay.c b/replay.c
> index da531d5bc6..683c384ef8 100644
> --- a/replay.c
> +++ b/replay.c

It might make sense to split out the changes to "replay.c" into a
preparatory commit.

One interesting question is whether it really makes sense to sign _all_
commits. It's rather likely that the history will contain commits that
aren't even owned by you, so signing them with your signature might be a
bit of a weird choice. I guess that might be okay-ish, but it's
certainly something that's worth a discussion as part of the commit
message.

Thanks!

Patrick
