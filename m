Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1E4A0918
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594810; cv=none; b=LTRBr0BYPqGngrV7MNfFO9jMNb04uwKBS0prS6dJNHwtc1jxSzwo3+hWDIZ38E8F0/ftlWMezaJZVOcDM8k9mgt1fh7FBDuAQjBDSS44X/6c0nLhE1h0LacGnsiIeyM2agLaOn6vQT5jEU3exRXisl/RpijnAc40AXSXcO/RfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594810; c=relaxed/simple;
	bh=EQbKPljvrEE83xWx8OjlNvAQSOcKn2CLdRq7iZbraPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NFE6xF3LzAfkEDhOrBv8Y6GKGlyMKI/+BcJ7tidiEfWj36INEkXjyePmtWJAF27uLNNFU4JCUzruoL2eJGp/t8ud9mEL1dWcTyFI7/yQlg4U9iCLum2/b8UNKETxNn3fcfRDmV5dujB4IW6IwDmMFCprjhdx2xOrWCTiwoTWvVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YSo72ZVD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rkArc50X; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YSo72ZVD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rkArc50X"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D0DA07A00FA;
	Wed, 16 Sep 2026 17:39:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 16 Sep 2026 17:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789594790; x=1789681190; bh=Y4i4qI4T4a
	4Iz1hzg2qXMKr0GoLC5M318NM1FG6mGnA=; b=YSo72ZVDNjiqs1Xgtcd5lCA0X0
	LjoA2Gl1Ys4IRBWkvfvIssHvA/Fu9PmErzg8rckD9dEJvTqMzs9tw/TMyxlCdIT9
	PaD+o9rv+G39mAA5oiJf2BXoviFnBe1NJA/ejUbHEE0KWFfvlUO9dmxZeUuD3YZC
	QjmYBc+e71FeFKHaZcbM9+JG7yKs5CcejC093yJS5JurBobfxJpbVcKiQ5EPRhoq
	QfIPUtZjwEQv0vHiYArhEZ2jWBcGPL0/c/+wO+u4zJZ+YwKLaVlA6rbux6eJoa46
	ZikozlcTgnUVmcxobGfKaei8wwssNZQ2QnZ5HmpuoBAbfhrm7sPq5vFewlzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789594790; x=1789681190; bh=Y4i4qI4T4a4Iz1hzg2qXMKr0GoLC5M318NM
	1FG6mGnA=; b=rkArc50X27WAdUm8J8HO/lFuhvb+sIL37rB3nAybgzOGZ4JXaH4
	t5FDi+aLqww52oLAYIEXmH1LHorYeA8oTRqIW6pXRCelvx5MsXk2tAP2SGduNvAb
	ewmJhfSwXTCgJHbPx+KYO0zT57rJ+U7DTgQa4nqk31VLWGejJF2P4uHRJcf1MtsS
	ijFS7+VLVJfWoahWbP77nLdvGVWL0kFRAaOFK0Yj88RD6tMnPkhGiMPeH4SMSsxN
	XoLXq0Ua/lFBU0xazBgQ4QxO1TKvAkChOJ0PwF/Y0iYTDcrSmSrb3sDQm3iYQfTi
	p2KfNl8OlLtKjjNy0LjJbS/uKpcBBe0UfTQ==
X-ME-Sender: <xms:pgyralioW8-aWw02qZ_tIXPdKnMK46oRnKN1TVUKnvunppkWrcrtrQ>
    <xme:pgyrahxBMA00xym4hagVGuZwtsDvZf33L_Fp_yTNFT6XpnDBWfew4RoEKe033usCv
    hwOfpn0Aljh9ILSOftNzTTcu2wY7_VLNSEwP0u__-vY7HPDeSsm-g>
X-ME-Received: <xmr:pgyraoJcPLBVYrs4P0PQi3NK0b3366MQgonBS6iN-wNTi9u5JQzBQOSKN7Qj0i7OYpvb6eFJMb48WqAfNVtud0YCp1uQr9J9edLb>
X-ME-Proxy-Cause: dmFkZTEFbo4VnT0lXwJw6FlVNscj63NFGcKI5ev0ETGDeRzQdOjfNElqnll9q/FiPHRUJA
    9WfbpksmVu8CUZUC1IwWCxfaPqz+xNB38NMSUFFKmmgBKw1GW15iFTadVkyrcVpDWjlJlI
    s+EFkKJ1/etrsd78DadpkNAz7mHlt0ySug8tZpvQYu+2Xud+mm3GvGQva8ANbCB5iKQ65M
    11HO2HhRwFhSjTJy7bROXwv/pVTs7iE6G7vLH7yE7w3CEBEHKuLvrYl/WBvNqDsN4bU0VN
    snBndyDK9T2kDd6j2StB3yTQwT6B95xZBFLSfMD27lXz9eueXuhJ2+YlqBK5fN59jGD0s7
    4Iv3YqxDH5R4WvA5EQdusF69fTAXmmZIX1CVcr/nsTvTW10CwXsEAQjmzpC46HA1Ofes52
    hj6cL8FCodpdEB2OIFPeMyxSZvCXvvt03CeHZb3WMhv9AS+MseAjRdAJzPYvKNXjKzgBqQ
    be8NkS3Kj7+sJWg0D/JhnYJZ0qVR/kpyOFzPCh7fs/ZroDLF6NkQf363Ot0RKsI1PZMonQ
    nqVY1DmDVN8hUUYcObun7cgfxszQvQPTrXvJud48Xcbe+ZFJ/6iP0hw5WiPAKj/2+fHYw+
    2OaKtKjvjWfv6fWT6MjbhBEsiT9cfhKLIXwO/T3v2LcCjKxL5dFCDeHh4aYw
X-ME-Proxy: <xmx:pgyraoSwOVPSYCaHXhMdP7XS3-szOpRIjf20W5LM-QpBam9xt7Lcjg>
    <xmx:pgyragrKqePU8cCuH4NrntIy4Xps2YfcA63yXm-qYsZGROVsd8jtCQ>
    <xmx:pgyratrCNsvG8DMLLGNXPeoVZXvAfmmdNz7VCsSkQtWa1Z9di0_f1Q>
    <xmx:pgyraqPgQtTr1DJ-yMFz3-D2qN_BcmsGGOF9RkPigP43GgOv6CEEJw>
    <xmx:pgyraqy4RehaEwY5yB8H0z8z-KCfzZRE-Uy6wKaCheEHlg5fC_y4AAxd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 17:39:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phil Sainty <psainty@orcon.net.nz>
Cc: git@vger.kernel.org
Subject: Re: GIT_WORK_TREE is not exported for post-checkout-hook
In-Reply-To: <17f331aef833b34fbddbefd66c330465@orcon.net.nz> (Phil Sainty's
	message of "Tue, 15 Sep 2026 20:24:31 +1200")
References: <17f331aef833b34fbddbefd66c330465@orcon.net.nz>
Date: Wed, 16 Sep 2026 14:39:49 -0700
Message-ID: <xmqqqzisvpsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phil Sainty <psainty@orcon.net.nz> writes:

> I have a post-checkout-hook shell script which indirectly calls
> "git rev-parse --show-toplevel", and I've found that when that hook
> runs for a checkout within a worktree directory, GIT_DIR is set but
> GIT_WORK_TREE is not set, which leads to the CWD being returned
> instead of the genuine toplevel value.
>
> The script is seeing a GIT_DIR value like this:
>
>      GIT_DIR=/path/to/repo/.git/worktrees/name
>
> The only other git variables in the environment are GIT_EXEC_PATH
> and GIT_PREFIX.
>
> The outcome I'm seeing is explained by
> https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables#_repository_locations
> which says:
>
>      "If --git-dir or GIT_DIR is specified but none of --work-tree,
>      GIT_WORK_TREE or core.worktree is specified, the current working
>      directory is regarded as the top level of your working tree."
>
> The current githooks(5) man page talks about this somewhat:
>
>      "Environment variables, such as GIT_DIR, GIT_WORK_TREE, etc., are
>      exported so that Git commands run by the hook can correctly locate
>      the repository.  If your hook needs to invoke Git commands in a
>      foreign repository or in a different working tree of the same
>      repository, then it should clear these environment variables so
>      they do not interfere with Git operations at the foreign
>      location."
>
> Unsetting GIT_DIR certainly fixes the problem, but I don't think that
> ought to be necessary in my case, as my hook script is calling git in
> the *same* working copy where the checkout happens.  It is not dealing
> with "a foreign" repository [or] a different working tree".
>
> My impression is that GIT_WORK_TREE should also be set for this hook
> when dealing with a worktree.  I have tested this in git version 2.34
> and 2.55 (maint) and also 2.56.0.rc0.355.g945ea7012d (next).

That certainly would be a possible workaround.  I do not know why we
need to export GIT_DIR in the first place, though.

The attached patch would export GIT_WORK_TREE when worktree exists
and GIT_DIR would also be exported, but there is a large NEEDSWORK
comment in the precontext of the hunk, which merits consideration
before moving forward.

 setup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git c/setup.c w/setup.c
index 0d157ac254..d0c0b2f68a 100644
--- c/setup.c
+++ w/setup.c
@@ -2064,8 +2064,11 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	    startup_info->have_repository ||
 	    /* GIT_DIR_EXPLICIT */
 	    getenv(GIT_DIR_ENVIRONMENT)) {
-		if (discovery.worktree)
+		if (discovery.worktree) {
 			set_git_work_tree(repo, discovery.worktree);
+			if (discovery.gitdir || getenv(GIT_DIR_ENVIRONMENT))
+				xsetenv(GIT_WORK_TREE_ENVIRONMENT, discovery.worktree, 1);
+		}
 
 		if (discovery.gitdir) {
 			apply_and_export_relative_gitdir(repo, discovery.gitdir, 0);
