Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9440A283CBF
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590759; cv=none; b=P+n5NgIFt5QvqGAyejWSyWWGZPa76b5bZvkPGb746xbAHM4fa/B32iG5mzMWBhwq+VfFPXMJBFSJVFh4fj10IDt+FepRZfLFnAZPZX/U30FvUSzsizTlRBVYh3NzSG21vZPuICdftvnA4VpHwoMBpT72Br1dhNe6tKvpWWJexO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590759; c=relaxed/simple;
	bh=4Gf/mvbEO6eL5qw6GrrLbd1iNYkYIMaJPwEeEB8bWBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uj9PgsVJrdloDQe5Twt9EJ5M6r18Gq5SD7S5+omH6HQU3DGn95h6NmTaFJKd02WAN6TOHAhL9fd4bapbGlk4kXUM9dBBZEFm/dZuLK0UVSgIvZKzs0UOI/4g7NVWV93rhjD4AJb/OAoXeZ7VTwD9cVF+UP5oF2zuTteiBOMXa0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ewNWpcPI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h1A3ZCJg; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ewNWpcPI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h1A3ZCJg"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C7DFA1380388;
	Tue, 10 Jun 2025 17:25:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 10 Jun 2025 17:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749590755; x=1749677155; bh=pv9/TDSL6A
	643cRzwhE51xR+BZx+55SvQxo+MgMTxnA=; b=ewNWpcPIDCJJL5lf9tbI7M9S4u
	HkWDL3g4NPwEUCfs5dSgOn/09dVSp8bmdKyPq9UivYiVKSJxJnhpCEZrJa87Jz5o
	lzg5hvQY5wUuWEpbeqOBssSZAFxBcocnX34m8iE9cbF+m8JpCusDsD6RmqAM/ZdO
	cyXMTttQh9HMUJqg7Z6OKjl8dAXI+Cr9fH9s9jB8lpRPfCvi/tHJkcOVh8yhtv8K
	sX+gTe5vvkiMQeH6AUFXo9b1+zdOm/AYl55VECe56FdNwkjfac2b6hTW3Sc48Ur7
	5oXy93b3PY/vUOrWohCjiEJzbruC+oGZoDAeVA3hkgRNKKd8GUGiCR6Z2/QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749590755; x=1749677155; bh=pv9/TDSL6A643cRzwhE51xR+BZx+55SvQxo
	+MgMTxnA=; b=h1A3ZCJgIqwUOTIEMuSWMDJF12tNpEPL2b9sLHmWGhGjV/srRuv
	Fy+vuJ7RMeS4zNzegXB86vMd1qYd4y7JLNQVXIL3Jkxh+IUgimUJOZh19CJjFl2D
	4D0yZESKQsg31RvWtNaL7Cb04txueLImmluKLYY/hgALQlPaFnoHeIFBxz7sCPta
	QsWOADlWo+kv3FFNLbr9D3dVdJaGHGXBpqn46s81qKrPx87kd8H2hyXydO/Dqcpp
	mDK7dwDUeqYwizgbwWsIQZe/9T32w8iTIReI6l5HnDi5C+MHVazIbmbEjorrvf6i
	Q3Kj+FrfdWqHfH9ejP9AZ+S+JMT57XSuQTw==
X-ME-Sender: <xms:46JIaH9VDAfBnk56Prw1G5tenaFpLbY9oGzJgd-o05ZJQ-siLmF2dg>
    <xme:46JIaDudGlDIRfyVpdx_2qtSwFK81Dd9dFRMJ_k37bmnMQQG7E6nNm8wS4-v3r5LF
    K2w6k-vABGVdXPIrA>
X-ME-Received: <xmr:46JIaFBMXBh1Gqj7ykedopcO1Si45d7pHiIaSN7lRPF2I50o3tKVR-czh4SzsSlIrnR6dm2kUL0_w6UkUc3nE6Gj_qEPgmVtPfm8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghnughrvggrshhtrggttghhihhothhtihesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:46JIaDfKf0qTv1zl_h8-yLlxW_X2ztISjrcGCWcpLkz5B9UMK5Frzw>
    <xmx:46JIaMNHDuHN6Z7wTO1-8zKw4WdsmVuOICFx9j4NWlE2geIPuEcGlw>
    <xmx:46JIaFlcOGrEmkWR2H4GqjXpwd_FNUeE-uOW_bPFtmeXIc5cV_6vKw>
    <xmx:46JIaGvZoJ8VpHn8vxlAwg4S-l-zWexJetrAmW-6t8bVMjho6Hmv9A>
    <xmx:46JIaA4xpITComNL4G8zDprqgHOxqeDEVQY42K5Ed7wlD5061uHVW2Sd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 17:25:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Andrea Stacchiotti via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Andrea Stacchiotti <andreastacchiotti@gmail.com>
Subject: Re: [PATCH] branch: move multiple branches in a single --force
In-Reply-To: <pull.1992.git.git.1749546464346.gitgitgadget@gmail.com> (Andrea
	Stacchiotti via GitGitGadget's message of "Tue, 10 Jun 2025 09:07:44
	+0000")
References: <pull.1992.git.git.1749546464346.gitgitgadget@gmail.com>
Date: Tue, 10 Jun 2025 14:25:53 -0700
Message-ID: <xmqq7c1jmgpq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andrea Stacchiotti via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Andrea Stacchiotti <andreastacchiotti@gmail.com>
>
> Using either the 1-arg or 2-args form of --force
> it is possible to only move one branch at a time,
> to HEAD and <arg2> respectively.

If you are renaming (or "moving") a branch that is not checked out
anywhere to a new name that is not in use, you do not even need to
force.  You can just do:

    git branch -m old new

You are not moving branches without "-m".

What you are doing is to point a branch A to point at a commit X
with

    git branch A X

Your proposed log message talks about "--force" too much; if you are
creating a branch, you need "--force" only when the name you want to
use is already taken.  Pointing the branch tip to a commit is not
inherently tied to "--force", but your description gives a false
impression that you are adding a special feature when "--force" is
used.  The proposed log message needs rewritten.

If there is not yet a branch A, you do not even need "--force" on
this command line.  Also take a special note that "X" does not have
to be a branch name.  It only has to resolve to a commit, so this is
also valid:

    git branch [--force] A X~4

I can understand that it may appear to be handy to be able to set
multiple branches at the same time with

    git branch A X~4 B X~3 C X~2		(* does not exist *)

with or without "--force".  If none of A, B, or C exist, they can be
created from these three comits X~4, X~3, and X~2.

Or you could propose a different syntax to create branches pointing
at the same commit

    git branch A B C origin/master		(* does not exist *)

But either syntax to create multiple branches feel somewhat
inadequate.  What should happen to their associated configuration
data like branch.A.remote and branch.B.merge?  Should they all point
at the same remote & a branch at the remote?  How would that make
having multiple of them useful?

