Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15A2E9743
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760890051; cv=none; b=VnBRJcI3pwJiZKcNPrHtnNAsMwZ/MXC85FWgKvJrVN+o2Vm1Pf4fFaMopR0mmR139bJ+paALhZ13xllO6oQyKktdX3eByDH7/Q1F6Cbj3BYzGMYfiwQSuR4YEU0b1juN1BvwFe9cY24W3QAMu0ebLcdV4ilyn6IT/ANY/TKvMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760890051; c=relaxed/simple;
	bh=rFgavlhdM9KhCb7jcePgeLdP1oKs3FzKqb1DtOeqXSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lgBqGQMrxgQAR0TlSNkJppOs68fXUl1Hap2Nq7aJ4Y5ysVRvfHhjzibzUe/ytKpG1/qZ+eeKBps+hlzofPHS1G08M98ib6el8AOB15/Y677qguh1fAsJAuWddxtqaV2raN3Ta4kDEm4C9fIAVZQIU1BylUmqSyf5IbY6bAPx79I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fWVxc8fE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pGamLcXR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fWVxc8fE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pGamLcXR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 065FC7A0112;
	Sun, 19 Oct 2025 12:07:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 19 Oct 2025 12:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760890047;
	 x=1760976447; bh=dIbdgD4vsgY7RTspsIF2u+yo9TucyDXB/Hzl6B3eU7U=; b=
	fWVxc8fEhuuJBQ+OFJaL7z4zV2h8gEqRvbAUKNPzM8Z7LnnMf0tIDyIv+Qk41oYE
	aWIr2K3fOWFvEtCrPeYrOFul2lyOzv4FRK8naxYqA1fFGM3w9w9caS0Va9AwdCMh
	rCj194qo2g+diklmOuwZWinnyYmNJ4u2PBSuz8iVKIglBeQEv/7O8Ni9SIok4paj
	8/7j0YLZroDijK0xF3R6TZXLzj5KAR4/eopwiIIfgVHNrqavNHkBw4r0Vu460yLA
	Jcn8jyRvfBfBLDJ1AVUXblQzDNCIkcnc55ECNzJCgZy3VZVM81GlCrxH+M27ZRGH
	Uj1cAh9JkXHiHE82VJh0zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760890047; x=
	1760976447; bh=dIbdgD4vsgY7RTspsIF2u+yo9TucyDXB/Hzl6B3eU7U=; b=p
	GamLcXR7RvyhTR4OWvFnPjcWq/EKYAJLl0ZZm3y8jjgB2cn7Rd94hlADsdwGPdic
	CUhL+Y8UwkTPN2xVUHe54m7KUjiCvxSgtWfcTXbXcvszlRjTa49lQsyUz3DkReh9
	UtIoMgVMuGL7usAgR+mCnLOh2UfxbRHEmu5svtoISnnYVOsPzdhCSPHoE2g3GwvE
	yVHR7v4OxUjmDlvEoZsvJlC17c6HYlxKNXDja6Aapwtb3ZJIhmL39YgJO5yQTK1S
	nl5apX6xBeyl7yS/Ihux/7n3eG2T5CarlDZ0yRSJkLAPutcb5fsjSHxZY0yn4nOT
	4dEuYTCxU1x7G4Uj1mZTw==
X-ME-Sender: <xms:vwz1aGg3QlYi1lEeI_0MBgHx0xuJi2rXLp5d4X_9w_SlEK2ZOyefTA>
    <xme:vwz1aJQLp3rcJhvlc1sYDCZkbtsuz9jMvVY93WA7cL3ZFu4NJeWkRAsHbvZsa-74N
    jH2ejQBA_evH6jHPLmOSaOn9iTlDFSyqO7LtWtk-bMz6ZOGne89>
X-ME-Received: <xmr:vwz1aAXCOj2zzdbMRU9F9GFhMghqahBeTM-lOM0ez-T2jCHbbi5dB5R40prSCgJZ_HqRwp_TA4WdWmC_3uoacAp_Wi8rBi_RKDpC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeehfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeggefhudefkeegueeigfejhfejvdejvedtheeguedukefgieelfeeuteej
    ieeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrvghvihdrvgifvghrsegvgigrmh
    hplhgvrdgtohhmpdhrtghpthhtohepihhllhdrthgrkhgrlhhoohhksegvgigrmhhplhgv
    rdhnvghtpdhrtghpthhtohepkhhihihothgrqdhfsegrshgrhhhirdgtohhmpdhrtghpth
    htoheprghimhhluhgtkhdrkhhihihothgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vwz1aFSIoJ1FJOGLpAUtWIVuNeAkCSD7Zv_nQEOZcYsEhiQ0S48Zcg>
    <xmx:vwz1aClY-iSUHiG2W6j1z7p9oLir_kIM47ifhIidaza81sKi8FdwCw>
    <xmx:vwz1aD6_5c-Uh-qOaAAVjVg5TH1a8FZhqonaJHlYYX6WahKPT2Pdgw>
    <xmx:vwz1aAh9pnOGBkSgg6k4lcDwaYQnzjGIur9qQ4Vh-r1TZwGFz5gA_A>
    <xmx:vwz1aPUU8OgXgQWBMka4DFfLFBx5Zt3nNiuMj_5eBF4TUjvLDuQoV2XR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 12:07:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "KIYOTA Fumiya via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Revi Ewer <revi.ewer@example.com>,  Ill Takalook
 <ill.takalook@example.net>,  KIYOTA Fumiya <kiyota-f@asahi.com>,  KIYOTA
 Fumiya <aimluck.kiyota@gmail.com>
Subject: Re: [PATCH] completion: complete some 'git log' options
In-Reply-To: <pull.2073.git.git.1760878666840.gitgitgadget@gmail.com> (KIYOTA
	Fumiya via GitGitGadget's message of "Sun, 19 Oct 2025 12:57:46
	+0000")
References: <pull.2073.git.git.1760878666840.gitgitgadget@gmail.com>
Date: Sun, 19 Oct 2025 09:07:25 -0700
Message-ID: <xmqqecqy3mf6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"KIYOTA Fumiya via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: KIYOTA Fumiya <aimluck.kiyota@gmail.com>
>
> 1. '--exclude=' option to 'git log' and 'git shortlog' are missing. Add the
> option to __git_log_shortlog_options.

Nice.

> 2. The `--committer` option in `git log` requires a pattern, such as
> `--committer=ba`, but in `git shortlog`, specifying a pattern results in
> an error: “error: option `committer' takes no value.” Therefore, I’ll
> handle them as separate options for completion rather than a shared one.

"Therefore, I'll h" -> "H" then the result matches the previous one
to describe the solution as if you are giving an order to somebody
sitting at the keyboard and making the changes for you, which is the
style this project uses.

Very good observation to notice the latter issue.  Has it been
raised as a bug that shortlog uses --committer in a way inconsistent
with the rest of the log family of commands?  Perhaps people often
do not limit shortlog by committers like they limit by authors, but
"group by committer" that is squatting on an option that users would
expect to be used for "limit to a given committer" does sound like a
small UI glitch to me.

Will queue.  Thanks.


> Signed-off-by: KIYOTA Fumiya <aimluck.kiyota@gmail.com>
> ---
>     completion: complete some 'git log' options
>     
>      1. '--exclude=' option to 'git log' and 'git shortlog' are missing. Add
>         the option to __git_log_shortlog_options.
>     
>      2. The --committer option in git log requires a pattern, such as
>         --committer=ba, but in git shortlog, specifying a pattern results in
>         an error: “error: option `committer' takes no value.” Therefore,
>         I’ll handle them as separate options for completion rather than a
>         shared one.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2073%2FFKbelm%2FlogCompletion-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2073/FKbelm/logCompletion-v1
> Pull-Request: https://github.com/git/git/pull/2073
>
>  contrib/completion/git-completion.bash | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index e3d88b0672..73abea31b4 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2218,7 +2218,7 @@ __git_log_gitk_options="
>  "
>  # Options that go well for log and shortlog (not gitk)
>  __git_log_shortlog_options="
> -	--author= --committer= --grep=
> +	--author= --grep= --exclude=
>  	--all-match --invert-grep
>  "
>  # Options accepted by log and show
> @@ -2296,6 +2296,7 @@ __git_complete_log_opts ()
>  			$__git_log_shortlog_options
>  			$__git_log_gitk_options
>  			$__git_log_show_options
> +			--committer=
>  			--root --topo-order --date-order --reverse
>  			--follow --full-diff
>  			--abbrev-commit --no-abbrev-commit --abbrev=
> @@ -3229,7 +3230,7 @@ _git_shortlog ()
>  		__gitcomp "
>  			$__git_log_common_options
>  			$__git_log_shortlog_options
> -			--numbered --summary --email
> +			--committer --numbered --summary --email
>  			"
>  		return
>  		;;
>
> base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
