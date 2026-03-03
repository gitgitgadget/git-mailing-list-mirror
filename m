Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43656391826
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563226; cv=none; b=nbf/l1e+nCfssZVDuOoJqq2kd/U6X2n8W5ZHqwva4gacr8r/e4PPJwMKfYoDtWtfstVDPw3/kpIRF4wkK5q+m+mZaPQxdl4oZrkAvSQ8yi/WScIJqVj6TLWl8WVTmYw9g+ioQapJ4A+ZNoiXMPM0CAQu/8xGVn0hya+NdexbdTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563226; c=relaxed/simple;
	bh=UQnu6d+lvMjKews/frb9GFrXMCd9HB71stIZfi9KNvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tj8KnlQQZDsj3tU+2YqXNjxckCnrPZhL3IAox/dpt8GocvtpkGjBtIbhplBM9DKp/z+Ewv9trF4b8mwsWOLqI4MiGPizEu1wNJVWI2jFpOsipRDFmyjyqDFiBjSC8tMoC6NOAFiWLl/FcHeW26xLXIinWVskOsUHYHrqyim6FPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kRu9Xo63; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oLmyPM1D; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kRu9Xo63";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oLmyPM1D"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 79944EC0181;
	Tue,  3 Mar 2026 13:40:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 03 Mar 2026 13:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772563224; x=1772649624; bh=Dcjth2iN2v
	SNdOam3EwW3EcK6Dr1zWhZnYGTHKPMpAU=; b=kRu9Xo63woL4I8GJfbWiJ+Ej5L
	i6qXebWSy/eaF9vZ+7/2IGy7FUc3qHrtoa6HT0V5g1VtlO7wQGWIbEih02VsrjX4
	jjRsmj3+4cJ0PPyhDGgc860Z1Occb2osEwopVlxyDuNZR7+gj8ig1JewYBvBAzgj
	Gp+CJn7KmEHnFh6yPrTFh6pZNuIs3k7yg4tdXA/Q/oPyii4djo+jtIxsTgsxh1z7
	4mq1v/LT6rrR/BCL3G8uvWtSPZhMTfQyyocwyzGUlNoleL2JmaKePeipXGnbxGZS
	KsQ0eK5EUVjfAKaxvChjE5viZ3WlG6c3Wraizdzg5cVQeY2fQovyuP5Q/hIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772563224; x=1772649624; bh=Dcjth2iN2vSNdOam3EwW3EcK6Dr1zWhZnYG
	THKPMpAU=; b=oLmyPM1DgLnEgPfGod3Tovh6JVHYsucW44VBQl5gwBKHHsmX7+s
	/n2LzBLNdrc0W5XqS4EAoCaqFVxH8VokUv58a1ZinJdqPKBthlkVIqosnfR2Ix6m
	O/1tV9CVxAV1mIqynDuvMl4XJ0Vo/mmn64Ay/mVZNPM1so7YoYYaBxvqhIS9fY1i
	Hb64cvqbcYomHkT1uRG5L2u1F6Fh5G3E9QXWAxOZxa4NZRdxl63KZFddXaZ/0e9e
	OksHOSRYafwV6Mk3oqRQJL6Dmmijp+SrMi1HW26yi394FTucdFX4RPUTY4O4tFp0
	dg3fGEhSkI3AzVSmd3ZOo4YZL9ljplnbTrg==
X-ME-Sender: <xms:GCunaY7Mws-LriftVGCTRPDKK_GE_3qr1LUfvGAOnDgCEh29dDz3GQ>
    <xme:GCunaQ5tz5NLxviHnAX6pr-jr-kkqyzgh6uiU6Fx-PNX_4d7TENlo0iLKCmmVcuRc
    rhD6FaS3s6HphgwTokvz2eX0XqmiI4dYMuzHbIhD_fyY5ZcfbT8wg>
X-ME-Received: <xmr:GCunaccQHmZNtSC56koKiRMgdZ9tq9EQGZ7UrKUb_uuG4u3UGd2AzKALbPPui4OR1UnrSaOQTFrcOmT8vj_r4I-gy138ZpB4nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehomhhrihdrshgrrhhighdufeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GCunacD8c2DaSSDdKvacQ7qhiO4B8QEGiBXczhNUbP9jyujtdK46EA>
    <xmx:GCunaX9TuHS9shFQLbhputI6KZtmtoDQDiCGG2A8DWoIenJ8gn_Z6A>
    <xmx:GCunafL0KbeJIkco-EPqTaq7zlUyKF--zqfxmH3k3qgbZdn6PIIpyw>
    <xmx:GCunaYjK8eHnmwuGESmk3hOlbt4ARvW9NMf1nggvpwIXurZCx5z4xQ>
    <xmx:GCunab9VjJFVFixO5FntAUcU-jfGuqumNPunPFfEC-w9kUYA1gDSaHgh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 13:40:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Omri Sarig via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Omri Sarig <omri.sarig13@gmail.com>
Subject: Re: [PATCH v3] doc: add information regarding external commands
In-Reply-To: <pull.2220.v3.git.git.1772559813151.gitgitgadget@gmail.com> (Omri
	Sarig via GitGitGadget's message of "Tue, 03 Mar 2026 17:43:33 +0000")
References: <pull.2220.v2.git.git.1772557925670.gitgitgadget@gmail.com>
	<pull.2220.v3.git.git.1772559813151.gitgitgadget@gmail.com>
Date: Tue, 03 Mar 2026 10:40:22 -0800
Message-ID: <xmqqh5qwdaeh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Omri Sarig via GitGitGadget" <gitgitgadget@gmail.com> writes:

Thanks.  Almost there.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

in this order.

> From: Omri Sarig <omri.sarig13@gmail.com>
>
> Git supports running external commands in the user's PATH as if they
> were built-in commands (see execv_dashed_external in git.c).
>
> This feature was not fully documented in Git's user-facing
> documentation.

Your description of the problem above is excellent.

> This commit adds a short documentation of this feature, making it easier
> for users to discover and use.

There is nothing incorrect in the above, but we would write it more
like

    Add a short documentation to describe how PATH is used to find a
    custom subcommand.

> Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>

> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
> index ce099e78b8..903d11c530 100644
> --- a/Documentation/git.adoc
> +++ b/Documentation/git.adoc
> @@ -487,6 +487,13 @@ System
>  	`$HOMEDRIVE$HOMEPATH` if both `$HOMEDRIVE` and `$HOMEPATH` exist;
>  	otherwise `$USERPROFILE` if `$USERPROFILE` exists.
>  
> +`PATH`::
> +	When a user runs 'git <command>' that is not part of the core Git programs
> +	(installed in GIT_EXEC_PATH), 'git-<command>' that is runnable by the user
> +	in a directory on `$PATH` is invoked. Argument passed after the command

OK.

> +	name are passed as-is to the runnable program. These commands precedes
> +	alias expansion.

We are not going to try running a program that is not runnable
anyway, so "the runnable program" -> "the program", probably?

I am not sure what the last sentence wants to say, especially the
"alias expansion" part.  Do you mean that your "git foo" alias (not
just its expansion but its presence as a whole) is ignored if you
have a "git-foo" program on your $PATH?

Speaking of "alias", I have always felt that it was suboptimal to
make users refer to "git help config" to find out about it.  I
wonder if "git help git" should be the first place users would look
for a help about them?

We have "GIT COMMANDS" section in "git help git" that says "We
divide GIt into porcelain and plumbing" and then have two
subsections there that list commands that belong to these two
categories.  Perhaps leaving some breadcrumbs to redirect them would
be a good start, something like this?

 Documentation/git.adoc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git c/Documentation/git.adoc w/Documentation/git.adoc
index ce099e78b8..fb5b477eda 100644
--- c/Documentation/git.adoc
+++ w/Documentation/git.adoc
@@ -235,7 +235,10 @@ GIT COMMANDS
 ------------
 
 We divide Git into high level ("porcelain") commands and low level
-("plumbing") commands.
+("plumbing") commands.  For defining command aliases, see
+linkgit:gitconfig[1] and look for descriptions of `alias.*`.
+For installing custom "git" subcommands, see the description for
+the 'PATH' environment variable in this manual.
 
 High-level commands (porcelain)
 -------------------------------
