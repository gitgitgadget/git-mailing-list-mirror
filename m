Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B086128816
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360448; cv=none; b=coxaJ5pyaSG5+0+v8huARGbGKCQVzS4G+LJ4eErxcPuVFy2D0d+vZIX6Kd+q4c28nw9Qads1FtlAhfIhPBeg0v84uq8Wtx5R0IwiFZkfSN63FHCSIcimARVLkgZshPdhix0TYiNsJr15vGWDhRDJ3r2cPHKgSO+02PQL1OtnbPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360448; c=relaxed/simple;
	bh=tk2gPMBeJqwUQP400GfKLgEOqeqJpfd1p9YSX8CNlIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=keJ8hF+d4e3VN9DU22bE1pLYGQ/VgxAxvMd31kgvzMy0Y0n2q4wtHIy9p1sMqXWRg76wQZapsGkelwurnS9dYoW3T0QEO7ynzFE/HqXSznxXOlGiusqj6JqDzx/E3nOX5OXChFmsIc1gOXhPnQ1YHUZT0MfX3GpGGcnE/9BO0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L+cF5KhV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xa0ANYXo; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L+cF5KhV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xa0ANYXo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4AC361D002B2;
	Thu, 16 Apr 2026 13:27:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 16 Apr 2026 13:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776360446; x=1776446846; bh=RYJ1Ohjv5m
	G4044vva6F79jENKcSxkwMfc32GBDh/TM=; b=L+cF5KhVhlHvXLhqNLhG6cL6uu
	HZ9ZCjSDfDka0WV8UgAu7crjHPGRD27VG/HtAe1P62jdcorO4wXBpt1m0yg0/oRT
	glK63G+yP+CDM+F7hjxeGErriuYdOLGWgg42qROW5ralT/yDmPnPbSGLjU+Dsfcf
	oASr7mEEcNpxkJhuOG0qYcZKVpQH7W2p+gM8Gyvx2pkjcbGoxdYMle4xWIFFGTOF
	bHEpU6zM1ZHjtHzDrTSrONWc5dyMpSSEcNWNKYtp9N8tFD4KqYM/uTcno4HGp4iF
	gOQMwvhODX6CJTqvOCFREXPY3bVS/F0AI7sKCN7ZosnaPKQqb+0QOIPLSl5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776360446; x=1776446846; bh=RYJ1Ohjv5mG4044vva6F79jENKcSxkwMfc3
	2GBDh/TM=; b=Xa0ANYXoSu+SWGlMUVr0tAFVFH1lkv9O5l9PApyfj0TccsAWPIs
	llAKK/+ZDXRNf5FfN00BqvZhFwy87LtKGDMrLMq2ftL8tsQvzBP8jv0NViXvITPM
	YZ46buWfJosalkMj6ARYw1cRhH/WH7/1ngvu62DQM2dmFMoR7mrIxaullCzxv82i
	Zvl2CdHGmZe4xRfM31uFBl1wz/KDzIKUcRFuTUHh28y2+nQ2Ye8ZjsOKiIKoTYmq
	EBYmf3UhJQOkhdhHdxc6iTSzQRZ25gSjeKxlwrtdaLH403usP7x7aRDsZy5QbxnD
	gwQhFNLJM4Xyf+Z+VT22pgw5L66hwV8WQFA==
X-ME-Sender: <xms:_hvhaVxgsTj1dDRtjashx-VSh6AuqVnYYtb_Sc_JsAaQVp9x1sm18A>
    <xme:_hvhacumus7tGByntWwSIevDr_KgqnKKtOQNWw60H1LvB8XF_u9xQkCO4ReHLgsXD
    wInmF4zz4dsKBhx2dl9F_iwiBLEdAwQTN-33HaWRtpvPga9Z-dDYg>
X-ME-Received: <xmr:_hvhactu9bhfbkTo_k0dMjqrNnvRg2KKVEChfKKSdWFxuDRekCh8TDtVYKAnfRn7yWFgAsM2HamA1FGRkCyQFaB__o2BmlKEgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrrghtshgs
    ihhnohhvihhshhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_hvhaRMS-VcQrFDue9-D7qoz37AJvOy5uXVKRaTi6BzkqS89_HMiiQ>
    <xmx:_hvhaa0_L8mxfN9UzoOfUx8-f2F9mOEso2aVO6VlC_38ezlSiqzQ7Q>
    <xmx:_hvhadMLYeB4vQ3MII5tMJgADS80ZjmaYbcEgfoGUJk80WJyeikm-w>
    <xmx:_hvhaa2kSAijD5ZsV4jCjKJ-YG_YaQEK0wMJZjpQBaVaxMKfQmBHXg>
    <xmx:_hvhacuchboGz68OnbRmp5RacYMRoOPC5y55JJ9EdhPyadYrxJHt9gLZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 13:27:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jimmy Aguilar Mena <kratsbinovish@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] worktree: add --recurse-submodules flag to worktree
 add
In-Reply-To: <aeEPk7m5gwPnmMUZ@RTX> (Jimmy Aguilar Mena's message of "Thu, 16
	Apr 2026 18:35:36 +0200")
References: <aeEPk7m5gwPnmMUZ@RTX>
Date: Thu, 16 Apr 2026 10:27:24 -0700
Message-ID: <xmqqpl3y24ub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jimmy Aguilar Mena <kratsbinovish@gmail.com> writes:

> +	/*
> +	 * If we are populating a submodule in a linked worktree and the main
> +	 * worktree already has this submodule cloned, reuse its objects via a
> +	 * local clone (hardlinks) instead of fetching from the network.  The
> +	 * common-dir path "$GIT_COMMON_DIR/modules/<name>" is where the main
> +	 * worktree stores the submodule gitdir; the per-worktree path returned
> +	 * by submodule_name_to_gitdir() diverges from it only in linked
> +	 * worktrees.
> +	 */
> +	{

I think you identified the right place to hook into.  But instead of
"clone --local", shoudln't you be running "git worktree add" here?

"clone --local" means you have two logically separate repositories
for this single submodule that are used by two worktrees of the
superproject.  If you add a new commit to one, shouldn't that commit
become available in the other?  Two separate repositories created by
"clone --local" will not allow you to do so.

> +		struct strbuf common_sm_gitdir = STRBUF_INIT;
> +		strbuf_addf(&common_sm_gitdir, "%s/modules/%s",
> +			    the_repository->commondir, clone_data->name);
> +
> +		if (!file_exists(sm_gitdir) &&
> +		    strcmp(sm_gitdir, common_sm_gitdir.buf) &&
> +		    is_git_directory(common_sm_gitdir.buf)) {
> +			/*
> +			 * Main worktree has the submodule; reuse it locally.
> +			 * git clone --local creates hardlinks for pack files so
> +			 * no extra disk space is needed for existing objects.
> +			 */
> +			if (clone_data->require_init && !stat(clone_data_path, &st) &&
> +			    !is_empty_dir(clone_data_path))
> +				die(_("directory not empty: '%s'"), clone_data_path);
> +
> +			if (safe_create_leading_directories_const(the_repository, sm_gitdir) < 0)
> +				die(_("could not create directory '%s'"), sm_gitdir);
> +
> +			strvec_push(&cp.args, "clone");
> +			strvec_push(&cp.args, "--local");
> +			strvec_push(&cp.args, "--no-checkout");
> +			if (clone_data->quiet)
> +				strvec_push(&cp.args, "--quiet");
> +			strvec_pushl(&cp.args, "--separate-git-dir", sm_gitdir, NULL);
> +			strvec_push(&cp.args, "--");
> +			strvec_push(&cp.args, common_sm_gitdir.buf);
> +			strvec_push(&cp.args, clone_data_path);
> +
> +			cp.git_cmd = 1;
> +			prepare_submodule_repo_env(&cp.env);
> +			cp.no_stdin = 1;
> +
> +			if (run_command(&cp))
> +				die(_("local clone of '%s' into submodule path '%s' failed"),
> +				    common_sm_gitdir.buf, clone_data_path);
> +
> +			strbuf_release(&common_sm_gitdir);
> +			goto connect_wt;
> +		}
> +		strbuf_release(&common_sm_gitdir);
> +	}
> +
>   	if (!file_exists(sm_gitdir)) {
>   		if (clone_data->require_init && !stat(clone_data_path, &st) &&
>   		    !is_empty_dir(clone_data_path))
> @@ -2005,6 +2058,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
>   		    sm_gitdir);
>   	}
>   
> +connect_wt:
>   	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
>   
>   	p = repo_submodule_path(the_repository, clone_data_path, "config");
