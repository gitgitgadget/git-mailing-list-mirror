Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE28224F3
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770839249; cv=none; b=LIM1FDOmJKH1BqfgVKBy9sod2+1MAQEVbTv7E5FmU3vz+2tSEJnN0dwBDNlR9FCJnhI62vA1UI9j0xElY2TBuAG9LpYX06zjr2Qdy5/rLIGPy4xpDoH6SHzp48y5bP5LUnE6ZRczVOVR3vK1ulkVAx7A8X1Jzb36+H57nR1Yt7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770839249; c=relaxed/simple;
	bh=v0zG3gIiimY59osL42D/GsvRGqd7kmVHesg0dsx+6Lg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DO+WdZIox8JIq9mI9YTQkYTCrtH5hHKa1aeNi3E5wxpL4og+wphQLNF32Zmd27TILvp3BdS2dlHaTpu0iIOlPrb9yv2LWWzzro/MAGHaT0EHuiWAmOGkK5VCzpGguq/q9rCViaXQp3KkRsiWvhhiKCTpJUB/cCKX2kMDHNBs12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IYl2ZmxN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gQ+K7Mc1; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IYl2ZmxN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gQ+K7Mc1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D8D841D000C4;
	Wed, 11 Feb 2026 14:47:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 11 Feb 2026 14:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770839246; x=1770925646; bh=6YArrEbrdT
	2sJTGKYmZr3ADypw4pfasi+Mf9VzK9Yd8=; b=IYl2ZmxN1teawBZ0Ly/Jl8x1uL
	5h67bukDjHRleBgH5w5NF7S0PzsIktyFihxkmGbN8ygEBmIQnX9Xicl34m7yFimX
	kn0Mh0G1hI3dAdMqgvDGXkwfeIE0zO36hnmUd1AYVeP2Dh05qXezWPiJMDHU1jDj
	q2J/hIfSbaQ38opHVK5cOL9qwteJmp5X6/miaBTgrmqLeOwDON6kc6wb3v+F842s
	beUH9BeeP3/pKqKvN6M5l14c0imarpzXdM3kqiM6J6VzVT9o14LiNiNh18+l+Wic
	wYjFLZAHz3G9zGpNIsy+dFQdBOQ1vhhOfH8enfxwoT7vr/omhtpKlMIFBYzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770839246; x=1770925646; bh=6YArrEbrdT2sJTGKYmZr3ADypw4pfasi+Mf
	9VzK9Yd8=; b=gQ+K7Mc1OuhEktwnM0ygG5ppfe3+F/yc+JJnNv/JgxR0Wa8SeW6
	hNopKjKgJ/UUbo+JAuni3rdugPa6Euf7RK4SdU0rZb2mAtVdD82YCDxvLRdaM/6T
	V5LdSFsfvI137P4VmNtVNAPZJzduiu/l2nWLLkKT7KUwYmWzDm+g1aJhUM4PKZoz
	a44+qtz6/i6EzvHM6GcX12ldgkQT1WbzpS/3lWej1UtMtr6dh3PKpA0WIYa2BwQi
	djjS06kVCP6BfzIkAJzZqQsCxycz8Xkg8ws/MRbEigNMECVgxR4yJabJIxmlToAC
	Iqw/bJDqWWiDVz/9o6gx4Wv+eSdsve6Jzvg==
X-ME-Sender: <xms:ztyMabr3sy6U3qek-7RBoIRVGC6YtnUVF9aWEMPPf7SdpM5Dt5Fiuw>
    <xme:ztyMadGNe_AwDfntT0bIwsSSVUKu3sEvrx9qrlygAfStCPhKIb1A2JM50G4H8bRPz
    9RXmYbR4QhxwSzGkq9GE8drFbCt9jdBva87WJfTRhUPLu4kH6yt3w>
X-ME-Received: <xmr:ztyMaVkwL5X6daLD2yL0qc9LHzDDuCWwKTxGtvpMWYBPpf32s-b7sQr0Y8gvRXK_CR-h3Gnu8jWEV_uOhueyNhu5T38ayp2vLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ztyMaYkPXpNOyzvdH2pbTAknamyqxQ8rItw0wE5s5-9zwuk4KBt28g>
    <xmx:ztyMaesur8uqwIr2GIa2vqM4P_MfeV2k-20SVrgbZQweEtV02qKqGQ>
    <xmx:ztyMaTmd8zJNZbycJdMGBEFA6vAAPCvJHBodMf8gBzi06hTaczZN0Q>
    <xmx:ztyMaRsxWl0XjHk9Xb7uYzpz0ZxnQC4vbij46tRvhbVc1e0PG7lmvA>
    <xmx:ztyMaVFHBakkvgv3FusybC22H6grfRhqeTB8HrSTIqIRb9FV6NE7W-JK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 14:47:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] setup: fail if .git is not a file or directory
In-Reply-To: <20260211182122.35352-1-a3205153416@gmail.com> (Tian Yuchen's
	message of "Thu, 12 Feb 2026 02:21:22 +0800")
References: <20260211182122.35352-1-a3205153416@gmail.com>
Date: Wed, 11 Feb 2026 11:47:24 -0800
Message-ID: <xmqq3437t643.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> Currently, `setup_git_directory_gently_1()` checks if `.git` is a
> regular file (handling submodules/worktrees) or a directory. If it is
> neither (e.g., a FIFO), the code hits a NEEDSWORK comment and simply
> ignores the entity, continuing the discovery process in the parent
> directory.

Thanks for noticing the needswork comment.

> This behavior can be very dangerous. If a user is inside a subdirectory
> containing a melformed/broken `.git` entity, the Git will traverse up,
> attach to a parent repository and might execute destructive commands.

Is it?  If a malicious party can replace your .git file in your
submodule with a device node or a fifo, it means they can write into
your working tree of your top level superproject, so they have other
and better things to use to attack you if they wanted to.  I would
say 'very dangerous' is an overstatement.  If "git add" in a place
you thought was in your submodule ends up adding the file to the
superproject because of filesystem corruption making ".git" in your
submodule to something strange, you'd have larger problem anyway---
would you trust your commits and trees recorded in such a corrupt
filesystem?

Having said all that.

Failing instead of ignoring may make it easier for the end-users to
notice anomalies and take corrective action, if this non-file
non-directory filesystem entity was created by mistake or by
file-system corruption.  It would be an unnecessary breakage to
those who deliberately named a fifo they use ".git", fully knowing
well that it is a reserved name that "git add" and friends happily
ignore, but I somehow find it unlikely.

> But I still have questions:
> 1. Is failing hard the desired behavior here? Should skipping it and
>    continuing discovery be an option for the user, which might seem
>    more fault-tolerant?
> 2. Should we die() immediately here, or return GIT_DIR_INVALID_GITFILE
>    and let the caller decide?

Determining if it makes sense to do so is 80% of the work needed to
resolve a NEEDSWORK comment.  The actual implementation is often
much simpler than the work needed for it.  ;-)

> Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
> ---
>  setup.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/setup.c b/setup.c
> index 3a6a048620..a1b56de67a 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1581,7 +1581,17 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  		if (!gitdirenv) {
>  			if (die_on_error ||
>  			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
> -				/* NEEDSWORK: fail if .git is not file nor dir */
> +				struct stat st;
> +				if (!lstat(dir->buf, &st) &&
> +					!S_ISREG(st.st_mode) &&
> +					!S_ISDIR(st.st_mode)){
> +
> +					if (die_on_error)
> +						die(_("Invalid %s: not a regular file or directory"), dir->buf);
> +					else
> +						return GIT_DIR_INVALID_GITFILE;
> +				}

I would have expected that the new code would come after the
existing "if the thing is a .git directory, it is a happy outcome"
code.  In this code path, where we found ".git" that is not a file,
the most likely reason is because we found a healthy git directory,
so it is a sane thing to avoid extra lstat() in that normal
codepath.  Only after we see that the ".git" we have is neither a
"gitdir:" file nor a git directory, we know we are dealing with a
rare anomaly that we can afford to waste extra cycles.

>  				if (is_git_directory(dir->buf)) {
>  					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
>  					gitdir_path = xstrdup(dir->buf);
