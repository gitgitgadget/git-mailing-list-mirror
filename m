Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC13EBF3A
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769309050; cv=none; b=fZrLCcGMVGNJQ0L43pTow4kr6p+AwC8ielWAqk+JBRjvlzEM9b/AGjEpxXqZV/Y5tyU5P7cJd9DZ39JVfjxQtrxuoDr3TYbMdK4QgFER7QvEjWHOHc9J/B8sW9N80ichHkv4FYMSDEfbGvhlIqqbU2GAIRXpCmAWwRZJ4/pzVAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769309050; c=relaxed/simple;
	bh=AVu4iCoz3q2dfmRBGSvbH5dz4QFhRV7FNF8An1uXeCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qOnrC8ETvd3nSeaWJrir8C3Lt9t3ZsmZ5ZEEkLMKhE0SJq24hX99SYpFoPHFsYnbHGY0pApX1b29c3nKbzahLL03ryEq/UIythkwDcVnGySY9dFUb+ozumC3umIQeWWdOoEKZpX8QZBGTEGOTPT9tltXcYXJyg63ibihKR9qi98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XguCIA8d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t6RHdiu3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XguCIA8d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t6RHdiu3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA7701400049;
	Sat, 24 Jan 2026 21:44:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 24 Jan 2026 21:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769309047; x=1769395447; bh=ria/AN7trc
	/2fgAKXUbsm6xQk0DDoblfiXtpJm1X7fg=; b=XguCIA8dwJwVQTYCZ+SOoL4Bmd
	6URpeOHUVugR1+S9iWJkPQqN5yBSpLCx6vquNRGtS0XEeA/7zSiAO6i9DRiDugLs
	6qQ/sPJBUyORWJW7UgKAd6uoMm9KFme6Pdktue9mfzeuD5Dy3X/+jGJZmF1/k8oe
	PiCjGqDhpWRy0mvK3f4sBJ2xDQ5S0IK/akKwCXesTO0GVApN7MchwyarZtMM2aJV
	d3QY/UYMl5GEeyKLMI3rCEBRCTppeelV6fIDXBtupO6dnKjbgz1jjEQyiVunXI78
	hY542OpGjvtlSXsqS2V3aSd2CaDDDvQ8kPWpY7s3P1dqK3S32WLiEu0ZotQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769309047; x=1769395447; bh=ria/AN7trc/2fgAKXUbsm6xQk0DDoblfiXt
	pJm1X7fg=; b=t6RHdiu3Z+BvIslDRpbyajjC2FJPbD453ifAB/IBEbF7Dyruk6n
	ULUKnUpC1N/SLS47Q3Ln8Ik/Yw0WQPtR2di3rxmN8ZEWuEl1sDY4fnK6nNY+61Sr
	hDjdR63yeKufKVZaA66clOFqs3uA51IPQOy54XhXCuQvd93CjP6DPOnmmahsq66V
	Yf1enZzG9LyOXMqb+RcdYRyXaloJugTRCq0RM2EBsn5AQt8NBWoSixusozIX1UGc
	yHA6JXynUvsRUXzYN4FSfOFx0JrRd28IGTk4N47TATe/4DHqrkBeS8xuL4Twrgqw
	T7TWXTw/umUnWCmoMJcGXqD9t85oMwuvjUA==
X-ME-Sender: <xms:d4N1af2gqHgEjLq6WhjBenxA-scv1X_p2w5R7Ig1AUd6rIbZJCzlPA>
    <xme:d4N1aZlsvlJboSsmbgorqvI7GRPHsRv3fK-SZxRJMx6yvFEaimWz8vJ0kd5Rx6j0m
    65raC4x2wAAF0SjfrT7EJ82iSDgrxvNW1iYAxliiGIFcrJbhtff>
X-ME-Received: <xmr:d4N1aWXdUqESSJG4cQzfdERMTDcAXCO7PNiW8UQCvKkbaok3fpD2SpzYIM_M7sVgyZyz0MzICTttCtsrkoNbQ0OCMidOGvpbnHJctlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheefieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepheevgeefleeuudefudduieduteefvdelgeelvdeihfegvdfgffffhefhffek
    jeelnecuffhomhgrihhnpehgihhthhhusgdrtghomhdprghrtghhlhhinhhugidrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegthhhrihhsthhirghnsehhvghushgvlhdrvghupdhrtghp
    thhtoheprghskhdoghhitheshhhofiguohhirdhlrghnugdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhishhtsegvfihorhhmrdgu
    vgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:d4N1afu-Ygdhx7r-n_gm605YiFCNlTAdVGaGzS2SO24exXnHsm3ukA>
    <xmx:d4N1aZYsAZoAiidrmK6B_R76rYduiyV7Iqz83fec9Nnx3CxqqAoYYA>
    <xmx:d4N1aeUHECXB8Wg9Uu4DY0_xMbjwswRSVmcENdxc3koy_BWutmqqlQ>
    <xmx:d4N1aeRbeAOLy5ZO1nqyhHy6Yo_KF9Ts_Ydx4nipSNsLDIQR15bapw>
    <xmx:d4N1aew71tlY3-sGaaFEMfYUIMQKkgMS2tkSfyO6Uqkpo-z61E1sqJJB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jan 2026 21:44:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Heusel <christian@heusel.eu>
Cc: Colin Stagner <ask+git@howdoi.land>,  git@vger.kernel.org,  Christian
 Hesse <list@eworm.de>
Subject: Re: [regression][bisected] git-subtree remote desynchronization
In-Reply-To: <755578cb-07e0-4b40-aa90-aacf4d45ccaa@heusel.eu> (Christian
	Heusel's message of "Sat, 24 Jan 2026 12:43:42 +0100")
References: <755578cb-07e0-4b40-aa90-aacf4d45ccaa@heusel.eu>
Date: Sat, 24 Jan 2026 18:44:05 -0800
Message-ID: <xmqqikcql8cq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Heusel <christian@heusel.eu> writes:


> What did you do before the bug happened? (Steps to reproduce your issue)
>
> I have upgraded my local git installation from v2.53.0-rc0 to 2.53.0-rc1 and
> noticed that I can not use my local packaging repository monorepo (via
> aurpublish) anymore.
>
> The steps for reproduction are the following:
>
> 1. Update to the 2.53.0-rc1 git release candidate
> 2. Clone my monorepo for packages in the Arch User Repository:
>    ```
>    git clone https://github.com/christian-heusel/aur.git && cd aur
>    ```
> 3. Push changes to one of the contained subtree remotes (this would normally be
>    done via `aurpublish google-chrome`):
>    ```
>    git subtree push -P "google-chrome" ssh://aur.archlinux.org/google-chrome.git master
>    ```

Thanks for noticing and reporting a regression before the change got
released in an official release.

If a fix materializes and gets verified before -rc2 (scheduled for
coming Tuesday), we should revert the merge of the problematic
topic.

> What did you expect to happen? (Expected behavior)
>
> There are no changes expected since the repositories are synced after each
> modification to publish the updates to the AUR:
> ```
> $ git subtree push -P "google-chrome" ssh://aur.archlinux.org/google-chrome.git master
> git push using:  ssh://aur.archlinux.org/google-chrome.git master
> Everything up-to-date
> ```
>
> What happened instead? (Actual behavior)
>
> ```
> $ git subtree push -P "google-chrome" ssh://aur.archlinux.org/google-chrome.git master
> git push using:  ssh://aur.archlinux.org/google-chrome.git master
> To ssh://aur.archlinux.org/google-chrome.git
>  ! [rejected]          70b3d81e370936e96f98d0aba357490b75ade7a9 -> master (non-fast-forward)
> error: failed to push some refs to 'ssh://aur.archlinux.org/google-chrome.git'
> hint: Updates were rejected because a pushed branch tip is behind its remote
> hint: counterpart. If you want to integrate the remote changes, use 'git pull'
> hint: before pushing again.
> hint: See the 'Note about fast-forwards' in 'git push --help' for details.
> ```
>
> What's different between what you expected and what actually happened?
>
> I would expect the `git subtree push` command to stay functionally equivalent
> and the change mentioned above regresses my workflow. This tool and setup is
> also not really special as a lot of users within the Arch Linux packaging
> ecosystem are relying on this workflow.
>
> Anything else you want to add:
>
> I have bisected the issue to the following commit:
>
>     28a7e27cff ("contrib/subtree: detect rewritten subtree commits")
>
> This is my bisection log:
> ```
> $ git bisect start
> # status: waiting for both good and bad commits
> # good: [7264e61d87e58b9d0f5e6424c47c11e9657dfb75] Git 2.53-rc0
> git bisect good 7264e61d87e58b9d0f5e6424c47c11e9657dfb75
> # status: waiting for bad commit, 1 good commit known
> # bad: [83a69f19359e6d9bc980563caca38b2b5729808c] Git 2.53-rc1
> git bisect bad 83a69f19359e6d9bc980563caca38b2b5729808c
> # bad: [0a5dcc1259fa0c8f5c21352c90b3cd3d43273345] Merge branch 'tb/macos-iconv-workarounds'
> git bisect bad 0a5dcc1259fa0c8f5c21352c90b3cd3d43273345
> # good: [ffae4da0128e035acd1887654c98b4f02785adec] Merge branch 'kh/doc-patch-id'
> git bisect good ffae4da0128e035acd1887654c98b4f02785adec
> # good: [6edbb7b1d0b50c70e2af0b5f68b7db0984b10be2] Merge branch 'en/fsck-snapshot-ref-state'
> git bisect good 6edbb7b1d0b50c70e2af0b5f68b7db0984b10be2
> # good: [9813aace1e52765e01e688672cdcdcbe25336ec7] Merge branch 'je/doc-reset'
> git bisect good 9813aace1e52765e01e688672cdcdcbe25336ec7
> # good: [d28124151851e42a3bb92963f5b747ad843f33e0] utf8.c: enable workaround for iconv under macOS 14/15
> git bisect good d28124151851e42a3bb92963f5b747ad843f33e0
> # bad: [79e3055baba32e2952e6e8994cdcd4fc145ba7f0] Merge branch 'cs/rebased-subtree-split'
> git bisect bad 79e3055baba32e2952e6e8994cdcd4fc145ba7f0
> # bad: [28a7e27cff717e5ef91f7445e6a418068608082d] contrib/subtree: detect rewritten subtree commits
> git bisect bad 28a7e27cff717e5ef91f7445e6a418068608082d
> # first bad commit: [28a7e27cff717e5ef91f7445e6a418068608082d] contrib/subtree: detect rewritten subtree commits
> ```
