Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169B29D294
	for <git@vger.kernel.org>; Thu, 21 May 2026 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370169; cv=none; b=EIdZOJTDa5UnhUlFH0+GWJpMsCoPBV3AqFOPGRZKYEh4EPqxFrF0Qq6tFDd5zb4d88QpNf+tjo+qqB2tqyU5aGaxcYXkwnLNQ/15UBaJIWxERo5mcqdbH7EQC+avhXJZsBgvrR00GBmglV9M2vKgKm9ZS1WXIqkNO53DrdjSuX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370169; c=relaxed/simple;
	bh=e58aJrS6teugOr4rvDURzwvQtyw1ACpEdwwiR3FdNHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OdbU91TXf+ZmhAm0U7EWRaSCtDcDXGGy5nWQEhOr1VTGgodTgad0kB+DPkoldAyHg085zOTB7TcaAiS3f4/CVspG+fOM7IqcizFYoCP4Wv1AaRBkhnQxJf5Cm77/lpsoZpWU8gf5sjlQWepZyLW0dThWbhCNEPTSYGD8/r4tH9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VNLK8pNP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pEplWLlk; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VNLK8pNP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pEplWLlk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED42D7A0146;
	Thu, 21 May 2026 09:29:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 09:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779370166; x=1779456566; bh=J3NKIjVp6c
	fCV6t1XlcRFR7rgfWI1ipqSVdY1yJug+M=; b=VNLK8pNPZwt13NlE5P+LMohhJj
	oszFC7KAKBsXohmhp6li288/DpWVQ74c9SHravaeI65kZfLJ95/dScVeGHuEB5xY
	jbOP4OwkRwHt1SCUXRPiwshzeV57oNa0vkQJJSJhCCwlytx2YnRa4SMisD+wgpdz
	FYBOKB46RLLx5bI7n4yNSVNLJRB9DWCDGZblkd8FElUIVp/DQis5J5HorMoZx+uO
	X80C2Mea2Jg2FxbSWr5VCkRJOGwU+gaQtWVW6KEbUeqVkB84oKL2sGjAmOCC7UAm
	SvOCd70Shh74liyKzQSlHlavIniUNRtAZyAdLlNDF54db7jL+m8X7Bwu+MMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779370166; x=1779456566; bh=J3NKIjVp6cfCV6t1XlcRFR7rgfWI1ipqSVd
	Y1yJug+M=; b=pEplWLlkOI+jrZosIcu2k4the8IHnDXf2Z4X8kLEu/gnuQr9Wd8
	3J8Th4gRj5t6o+gypjhvH5c49DlFt85BtUrxLMunTNFkm7VaFP75cumOM0Hi8VHp
	28F2iJ7nOTsLBn+VKyAepFyEvAbQbkzvfxXNJUjajuIAExir/Z7yUYJy6w0vAFLX
	HqKtXrr2bU+G5zHqgVofP1+CiYxtAUEKs8cPQODbfEhqQCv8xKrsdUSP43ZGdfHQ
	9m6o8XFifQsSAQEg11tbn7g4vPCwOVbVj6k9WBRQJIWu4RH+QlCdMRWOKRzDNGwF
	hwtAmv+yHJa5n3uC/ieNM/NzUCTcJgc9GaA==
X-ME-Sender: <xms:tggPaiar3BM_TJVn0tH4M8QLR38-swQFcpS-stNAbcOUjlwJwjo6hA>
    <xme:tggPanoHj3CbCyXClswXr-C0Il2wnujO-FObgrmpKhmchB-XXXs5N6dDYzX65ytK1
    4dEoqDtgktl2QxyAorSNSd3HndiMvziC_JI-PeLs09pn4UX9_ZDnQ>
X-ME-Received: <xmr:tggPavOmWQlAvq_6ZIIN0zTA_ST0flzTNLrHBaXsLap9sA7AP9_X_EfDlCxgSc2iARFDNAdNyngyH7dLsrPf0fxPB3qMuTMTfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohephhgrrhgrlhgunhhorhgugh
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:tggPaqrV3bfMLitL3hLf3a4OdSRzO4NujP2o4rl7fePxVCt9py6SfA>
    <xmx:tggPaseJ10NiG8BK3vftEW0DVwiN_xQH4LHR4lea4aZ_Nd2Nv1yqnQ>
    <xmx:tggPaoTTT3DGfCpCP2pcqsv4ODQJJwahRLk1hFjg_ZyaZag32JPW1w>
    <xmx:tggPatYCkHO0tPML0qoobjh3Vch6dqRG7kjNCGvr0j5SEtusuV7vUw>
    <xmx:tggPaiXh1_RJGkgudWpmazblCpI_QNRv8nuER-ybxTHmiO0fRHUeSd4Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 09:29:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v9 3/5] branch: add --prune-merged <remote>
In-Reply-To: <6501a3d5-a5ec-421b-8526-ee7d4ae5ea98@gmail.com> (Phillip Wood's
	message of "Mon, 18 May 2026 16:27:01 +0100")
References: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
	<pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
	<f87e96e99d64c48bd92afecf3a6a819d36e56f6c.1778700883.git.gitgitgadget@gmail.com>
	<6501a3d5-a5ec-421b-8526-ee7d4ae5ea98@gmail.com>
Date: Thu, 21 May 2026 22:29:25 +0900
Message-ID: <xmqqmrxs28ne.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think being able to prune branches that have been merged into their 
> upstream is a good idea. However, I find the focus on remotes rather 
> than upstream branches in the UI a bit confusing. While the upstream of 
> a branch is often a remote tracking branch it doesn't have to be. For my 
> personal projects I often do
>
> 	git checkout -b topic master
>
> and it would be nice to be able to run
>
> 	git branch --prune-merged master
>
> to clean up those topics that have been merged.

Excellent suggestion.

The task at hand is to make a list of things that "track" (in the
"checkout -t" sense) something, see which one in that list are
descendant of that something, and removing those that have already
been merged into that something.  There is nothing that requires
that something to be a remote-tracking branch at all.

If

    git branch --forked master

(i.e., "who tracks 'master' in the 'checkout -t' sense") were
available, then

    git branch --merged master | sort >1
    git branch --forked master | sort >2
    comm -12 1 2

would give us the list of branches that forked from 'master' and
have already been merged, i.e., candidate to be removed via the
"prune-merged" mechanism.  With the built-in "git branch -d"
protection to require capital "-D" to force removal of a new work
that is not merged to tracked, we actually need only 

    git branch --forked master |
    xargs git branch -d

to do so.  We may want to give --dry-run to "git branch -d" so that
you can say

    git branch --forked master |
    xargs git branch -d --dry-run

to see what would be removed.

And again, there is no strong reason why "--forked" has to work only
with remote-tracking branches.

> Similarly I think it is 
> confusing that
>
> 	git checkout -b topic origin
>
> starts a branch from the default branch on origin, but if I run
>
> 	git branch --prune-merged origin

Sorry, this was my bad.  I agree that it is not a useful thing for
"origin" to mean "origin/*" here when it is established that
"origin" to mean "origin/HEAD".
