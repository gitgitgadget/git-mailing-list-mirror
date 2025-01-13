Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E914F9F4
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787374; cv=none; b=XcpUIdrJs55j6BcLSrUb2a/g6ZtEbdWXdq5KIkFf6TQanE7KYmhzE2/FQI8VetqzIk4JcfDxj3d91DkqBgpHL5zJ+oRUCxRjyUflDQQ8Xj+b14KVd6m4AFn2noBtB8UBDzZTbrnp4G7sEknt1eOP5F1xuHnW/L/QH8cAwelsEao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787374; c=relaxed/simple;
	bh=WRwScYYRBN+RyAlrH7AzLCLIZEfqgf91tN/fuSbzeIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GQWCG45I5LMXYH0EQSMwCIR4ycH3hPfPdroUEWjaFuL2IIms/SilOwECmbvOr4DVsZVQtDY4I9qoCdkpqNCVdJ5yYhqLFZ3zpUAy0gs8AWObq9odCkCsD1m1h5lW9W77tYGSwwWIvVkrPzG3v6bTzSy2IiCqVrZBz4X99YKmQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tjGSwt4a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tYE9bJqz; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tjGSwt4a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tYE9bJqz"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id C54661140176;
	Mon, 13 Jan 2025 11:56:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 13 Jan 2025 11:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736787371;
	 x=1736873771; bh=n/r7LiNM2ndUY3DAZSDDt7FYnnbcyyvrpUmQKzdJt6E=; b=
	tjGSwt4a4cA+1ttBnMEl7zodeEfgc92V7NTOdzzRti6LaMiFXpwJnYqzrYF9zM9g
	gNofGqfGnlc7EHRDhP0WRaT+Wmus1CJfUm3Qn1U/YADy1doyehGgSvgMO90Ritf2
	5Bl8BCShSKRPBROIYsjaFyDb7atv8Lo+x0TaVL+gnQVACeMKtqpRXMv0ywn2tgbE
	Nthwvee8aYdi+hQajW5tXyYCuAMuTsq/pM2RaX2lE9vTFu698jZ156Dj95pOMvK0
	pQimK7ELjZc7B4C1Ksb+DCtfH6ChaeiahecG+qfNa/AFYxvW7AyLDzvvJe2pg13c
	o/m0AByOWTRVHOPCBKdk1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736787371; x=
	1736873771; bh=n/r7LiNM2ndUY3DAZSDDt7FYnnbcyyvrpUmQKzdJt6E=; b=t
	YE9bJqzjVZNA6tAzYsvG7hXyk9n0TqbZnh96hy1KEdbh2dLwA9qJZf9Siq14LW9a
	vCrRvgweIdMbWE4sMjiDOQAgvFPfV2P0LQQfq0s4f1V6rP+BtssIfOO7KF6Xd1ss
	S2Y0wemAoi8QZxTLdEIc8LFUE4GTJp6yOwRne1pXLBZQo/yQ34k+F+cktYCrICx6
	D9u2gXRYq9v3yxKR5y+ogTkGDPC6Uv+9qUvQ7CYGVsaOkK+fz8RUy1r74KsFClYm
	rQ6CeuGM7BWK6AAkIx3zCISZsr5xw7k7Z6cdhAA6mAS+i57PHoLtwnD4Fh2wiNpb
	lIUpFL9955okX6hKihsCQ==
X-ME-Sender: <xms:q0WFZ2blWIl2oGVb8kk_hQXITo-L4qSeA1LCUN6UzQezPQIyGQAqIg>
    <xme:q0WFZ5Zs8Y7yAMNu3x8altY3_0zsR4CLI1DXZIWIo5WiCCCjySapJKCII6oUXp-HC
    SAsn1q_Y_g3HThDVw>
X-ME-Received: <xmr:q0WFZw9YAuq3QP-lD7DIBikyz-epWtOVsqLubaA0zaktrshyKPf9p_QPstxYbH4oy6GYIiMBN0oRL1SmKMQkZ3UvW_1aOpRj7VeL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptd
    ffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:q0WFZ4pk1DKT924ZwWk7l9AV8BrouV-9WyYLHKoQnFpMJc_S6ECItA>
    <xmx:q0WFZxqPPg4v9AR7g1olOwuYNwbixV7Zv721VDDHW7YeZok8Sl80jw>
    <xmx:q0WFZ2TmEj4BqVA2ll_LX3MZegH9RSgOJhFdMJBO5vrXfUj1lrisAA>
    <xmx:q0WFZxqC1_ctYzNFIHw9aeb5gXn5crKupC6QGdhRFa2w6nacOrpQRg>
    <xmx:q0WFZyl6SRU-7y9PSvQzn1v3a1o9gfTjMFgBkp1T71OWsN2kzKz9oL_1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 11:56:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] Revert "doc: move git-cherry to plumbing"
In-Reply-To: <e5b20f9ceb437a82c422136cb81b05a0521cab07.1736682716.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Sun, 12 Jan 2025
	12:54:28 +0100")
References: <e5b20f9ceb437a82c422136cb81b05a0521cab07.1736682716.git.code@khaugsbakk.name>
Date: Mon, 13 Jan 2025 08:56:09 -0800
Message-ID: <xmqqv7uiac0m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> This reverts commit 61018fe9e005a54e18184481927519d64035220a.
>
> git-cherry(1) is a high level command for checking what commits have and
> have not been applied to some other branch.  Or at least as high level
> as the git(1) suite offers.  In other words:
>
> • it is a useful interrogator for a particular workflow; and
> • there are no higher level commands on offer.
>
> By contrast its use for scripting is somewhat narrow since it only
> prints the patch application status and the hashes of the downstream
> branch (not also the upstream branch equivalents).  git-patch-id(1)
> gives a fuller picture by printing each hash and its corresponding
> patch id.
>
> Now this command is not nearly as convenient for the purpose of deleting
> a *merged* branch as:
>
>     git branch -d <branch>
>
> Since that command will refuse to delete the branch if the commits are
> not in the configured upstream ref.  But again it is the most convenient
> command for the patch workflow.
>
> This command might only be considered plumbing by way of the plumbing
> contract that says that plumbing commands have stable output.  But
> hopefully listing this command as Porcelain does not give the impression
> that the output is not stable.  Output stability was in any case not the
> motivation for moving this command to plumbing.

I do not follow the above reasoning at all.

It is not like it is a crime to intarctively make use of a plumbing
command, or we intentionally try to hide plumbing command from them
by making it deliberately less accessible.  "git cat-file commit X"
may be handier than "git show -s X" for some people and that is not
to be frowned upon.

And what you call "might only be" is really the crucial thing to
consider.  If we want to keep a tool's output stable and machine
readable, we need to mark it as "meant for Porcelain writers", and
classifying the tool as plumbing is a pretty much established way to
do so.
