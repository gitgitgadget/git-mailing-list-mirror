Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3412E2F16
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946868; cv=none; b=Tq80RLeLLcCTFGEmCvgASn2OzLQM37JkCZlmDk15/i7Jvxh+sxIFmUkO4XSdtvbvy8Ds3tQ2dKR9b6d4Xp3qjbddaAp1DJ6ug6yTmLudiIp1qfbxIIgzCzyYI7kcYgD1cIewFEkKGOFI5p6zNSH9X5g2965xa544UYeCwBethPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946868; c=relaxed/simple;
	bh=Z2bkr5FWkSFVuv+MEF3hit1kdd/TCBVcHyl611MRaEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oEKY3zzRFKhVyN6Iq399cbWB+hALEPSJyi5/878GIxh5HUrDeLQzoons7DafUN+MVMepqTxk2FE8fzn5y0c1N0XVYskF49ax7ydg5/UJqcmse4x0XhpdhiiloeqQ0sr2nxZdRPCDyKldYNpRqQ6zDiLpqOG9dG+V1E7FYSwODNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y0eBLfn7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Orv0OudY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y0eBLfn7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Orv0OudY"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A6997140009C;
	Mon, 11 Aug 2025 17:14:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 11 Aug 2025 17:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754946865; x=1755033265; bh=y7uJ2wAH8I
	jM3PtJaT36sMR6+FceDNNsIbJMcZLJUC8=; b=Y0eBLfn7B0IMU4hUILhXlmF3Ju
	1v0czTdRyxnV3SO9T9LDt3vo7612K97c+5SfCGPT/lbeEOx4m6S+bIhoXKitscKi
	Ev/kRgM/gkhD/MGXzhwUxTatuyTkS6mG1BIGXD59ddKOIcWp9AeOBGH8FHV+bgqJ
	Gc7vJD75t7LQoUPMWVC1IuGRv7aoVUEK9pakJSqZS+DeGL6ZE7BmkT/O9RT/3TM4
	DRwBdTr6pZPxEPPewXj050nQvnwlSOHxedQMgz371LeFCbGfMic6vYoXlBRb7LxB
	4Qc+OEgPe88APyFIkisdQtuvkzuE/1SdHiIgT7s0NXAuU+rtGuKY0OEyi85w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754946865; x=1755033265; bh=y7uJ2wAH8IjM3PtJaT36sMR6+FceDNNsIbJ
	McZLJUC8=; b=Orv0OudYiyuys6qPm62vEWyU59TKzGovW3zuH4sDtb0VkMzRAEd
	MQkluwHbzy0xBZN+glQq1l0iz7nSO30Uq/xRucWlZNZgUKpfvU8+/fFi4ocsfucx
	iqzwQlOTibVAZZpOQRHPDVXub8YWv+hJUZ83HD2EmDGpgX8eKa783iYNW7qep4BM
	jZDqHp5c1oelfDvdutCVb+F4NtDeS+0JRptYOb1IB9Q+J+G4+ieVWS99WiM+xZVu
	2Mot85K9GEees1yO3LWwXrQXwcO8kSPLZoc53UUIAhJ/Pom6YR+Phea3mm5L+qXh
	Mu+EbqbU+eUgn3KG+b6Lhh+YvZxvlGq0NyQ==
X-ME-Sender: <xms:MV2aaP894aGHQrklXcLOaFNXGMZvvm9t-llqRq4GMykWUoQ77GCCNQ>
    <xme:MV2aaIo9OydrVZ0jvbQo-a1boZZWe_gTCg4rTKRO00F4yrAGbiTAVluwFhVEJFYQt
    XhKEBFwaOLcrLUAww>
X-ME-Received: <xmr:MV2aaIpNpMmaoJD82zXNLFWIioTpiN6aZS40TxghP9O7Aevh_yWieawiHbTPpDpty3bqcpVEWD9HUfdh0oGmiyCXAFE6bnDm4drIq6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeefhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:MV2aaD2OFciOnhdheMsvoKivkHiS6RphTj-qXLr_s9AKqaFZiIv_0A>
    <xmx:MV2aaOFb7HWI0Itk9YcV6LHBD2BSlAYIaLFLr-Eb7iNXyQWTJ5AIfQ>
    <xmx:MV2aaGGVXuRPtsVDLvR1UBjX6sRp5bZ9niN_RKuH4KcB5w_enk5UIQ>
    <xmx:MV2aaJ6gmjxrUwamF9w-mtZm-vb9dU2DlDedgApFf_AsxQWAgMDTIg>
    <xmx:MV2aaANlv1qmPWvfLaftBTzno1_rRecJazYpnFJMMJ9jHh1Ooq-x9LVB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 17:14:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Karthik Nayak <karthik.188@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v5 5/5] doc: git-rebase: update discussion of internals
In-Reply-To: <5ab235b067b40e468185ee905f735ff73ccc9552.1754943127.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Mon, 11 Aug 2025 20:12:07
	+0000")
References: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
	<pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
	<5ab235b067b40e468185ee905f735ff73ccc9552.1754943127.git.gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 14:14:23 -0700
Message-ID: <xmqq8qjp1ryo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> - make it clearer that we're talking about a multistep process
> - give a more technically accurate description how rebase works with the
>   merge backend.
> - condense the explanation of how git rebase skips commits with the same
>   textual changes into a single bullet point and remove the explanatory
>   diagram. Lots of things which are more complicated are already being
>   explained without a diagram.
> - remove the explanation of how exactly `--fork-point` and `--root`
>   work since that information is in the OPTIONS section
> - put all discussion of `ORIG_HEAD` inside the note
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-rebase.adoc | 66 ++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 43 deletions(-)
>
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 750f5e67e4c3..b4e5519d2839 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -68,51 +68,31 @@ linkgit:git-config[1] for details) and the `--fork-point` option is
>  assumed.  If you are currently not on any branch or if the current
>  branch does not have a configured upstream, the rebase will abort.
>  
> -All changes made by commits in the current branch but that are not
> -in `<upstream>` are saved to a temporary area.  This is the same set
> -of commits that would be shown by `git log <upstream>..HEAD`; or by
> -`git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
> -description on `--fork-point` below); or by `git log HEAD`, if the
> -`--root` option is specified.
> -
> -The current branch is reset to `<upstream>` or `<newbase>` if the
> -`--onto` option was supplied.  This has the exact same effect as
> -`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
> -to point at the tip of the branch before the reset.



> +Here is a more detailed description of what `git rebase <upstream>` does:

Were there a sketchy description given elsewhere already?  I
personally feel that giving too much details here would not
necessarily help readers' understanding.  I'd prefer to see an
introduction read more like "The command conceptually does these
things in the following order", and leave the level of description
also to match that introduction.  It may be just me, but when
somebody says "here is a detailed description", I would expect it to
contain little or no white lies mixed in, even for simplicity.

But of course others may have different opinions ;-)

> +1. Make a list of all commits in the current branch that are not in
> +   `<upstream>`. This is the same set of commits that would be shown by `git log
> +   <upstream>..HEAD`. You can use `--fork-point` or `--root` to change how this
> +   list of commits is constructed.

Didn't somebody mention "git log --cherry-pick <upstream>..HEAD"?
If omission of it is for simplicity, that is fine, but that is
another reason why we do not want to say "more detaild description".

Also, shouldn't there be step #0 that says "If the <branch> to rebase
is given, check out that branch and make it current", for the HEAD
in this description to work correctly?

> +2. Check whether any of those commits are duplicates of commits already
> +   in `<upstream>`, remove them from the list, and print out a warning about
> +   each removed commit. You can use `--reapply-cherry-picks` to include
> +   duplicate commits.

This is done as part of #1 above as part of a single invocation of
revision walk (i.e. a loop in sequencer.c:sequencer_make_script()
that calls get_revision() repeatedly).

> +3. Check out `<upstream>` (or `<newbase>` if the `--onto` option was
> +   supplied) with the equivalent of `git checkout --detach <upstream>`.
> +4. Replay the commits, one by one, in order. This is similar to running
> +   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
> +   are handled.
> +5. Update your branch to point to the final commit with the equivalent
> +   of `git switch -C <branch>`.

In step #3, you switched to <upstream> with "git checkout"; here you
use "git switch".  Uninitiated readers would wonder what criteria
were used to decide which one among these two different commands to
use in steps #3 and #5, even though either would work fine.  Because
this page is not where readers come to learn about the equivalence
of these two commands that are not essential to learning "git
rebase", it is better, so once you started with "git checkout", to
stick to it throughout to reduce the mental burden to first-time
learners.

Thanks.
