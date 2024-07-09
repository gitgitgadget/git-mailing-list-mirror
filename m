Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF3719E810
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542722; cv=none; b=kS6FQPxhjERVzyAbQKNvmjWKGCTGl6Ox7Q8mCTllmiAWSqEdXXe5xiZEH4Gtx2f0f4zNBFW8XSSwd0R2nX/TkW2P8oU35Yxn8NBtBs9NGR2LqcHLWEy9qO0lYC0pcD4bO7Wn9qvcfCVNRbDrwxy3SlQ6+BG5UNR50NOzhwrM3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542722; c=relaxed/simple;
	bh=KvyfMNANH/ZX5TLvlVKGaIkn79Nyfy9xV/ySbRFD+gA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r3Ynon39r4mRfQyjz+XR3ad1Z+KXCHSKM8K5YUj3DXfyjWObSuU4CBR4I1bwP5Fb5EHaps/i3d89rijw7a77iG7aX0TsvxNOmH+bFQfGTBRxUnzJajsHCPRUWrfXW1xk9lhD0ssgkXZpc1Nn0G+CsgYjR39hE2r3oWmU4z8sR0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=f0ZyjraZ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f0ZyjraZ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 97ECB3AAAB;
	Tue,  9 Jul 2024 12:31:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KvyfMNANH/ZX5TLvlVKGaIkn79Nyfy9xV/ySbR
	FD+gA=; b=f0ZyjraZzKOYBrQREFrTl5n+UA6PRXgo6TSkB0tcHCPSbYxr2Tkhdc
	oiUDX/DaYzrY8upEL8jOvhVy3uJo3C8IF3S/1fxG7q7blGXZ1n7m08l3zHRoaet0
	Q+wDL3G/EP9+6brEXBF0ODMurikyGHLk7dhC7lW85cZSL0isHrIxM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8FC0D3AAAA;
	Tue,  9 Jul 2024 12:31:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 149C63AAA4;
	Tue,  9 Jul 2024 12:31:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] var(win32): do report the GIT_SHELL_PATH that is
 actually used
In-Reply-To: <ZoyDlrcmyXUX_dki@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 9 Jul 2024 00:25:58 +0000")
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
	<xmqqed83g1e6.fsf@gitster.g>
	<Zox48sVp-PybvLxi@tapette.crustytoothpaste.net>
	<xmqqr0c3h21e.fsf@gitster.g>
	<ZoyDlrcmyXUX_dki@tapette.crustytoothpaste.net>
Date: Tue, 09 Jul 2024 09:31:48 -0700
Message-ID: <xmqqy16afrwr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BE11802A-3E10-11EF-98B1-C38742FD603B-77302942!pb-smtp20.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Why not add Perl or Wish or something else?  Because once you have the
> Git for Windows sh, you can use a fixed Unix path to look them up and
> get a canonical Windows path with cygpath -w.  Thus, this is just the
> minimal bootstrapping functionality to get that information.

Besides, perl and wish are not part of Git.  The same thing can be
said that shell is not part of Git.  

So stepping back and thinking why we have "git var GIT_SHELL_PATH",
what should it mean to begin with?  It is obviously not to tell
where we installed the thing as a part of "Git" suite, even though
Git for Windows installer may let users install the shell and other
stuff (similar to how "apt" lets users install package on Debian
derived systems).

Hence, I can accept that "git var GIT_SHELL_PATH" is not (and does
not have to be) about where we installed what we shipped.  It is
where we use the shell from (i.e., when we need "sh", we use that
shell).

   The documentation for GIT_SHELL_PATH is already good.  Sorry for
   my earlier confusion---I should have looked at it first.  It says
   it is not about what we ship, but what we use when we need to
   shell out.

I am OK with GIT_SHELL_PATH computed differently depending on the
platform, as different platform apparently use different mechanism
to decide which shell to spawn.  On POSIX systems, it is the one we
compiled to use, while on Windows it is the one that happens to be
on the end-user's PATH.

But then the comment I made in my earlier review still stands that
such a platform dependent logic should be implemented a bit more
cleanly than the posted patch.

"Which shell do we use at runtime" should influence a lot of what
the things in run-command.c do, so perhaps

 - we remove builtin/var.c:shell_path()

 - We create run-command.c:git_shell_path() immediately above
   run-command.c:prepare_shell_cmd().  We will add conditional
   compilation there (i.e. #ifdef GIT_WINDOWS_NATIVE).  The default
   implementation is to return SHELL_PATH, and on Windows it looks
   for "sh" on %PATH%.

 - The entry for GIT_SHELL_PATH in builtin/var.c:git_vars[] should
   be updated to point at git_shell_path() in run-command.c

 - Near the beginning of run-command.c:prepare_shell_cmd(), there is
   a conditional compilation.  If we can remove it by using
   git_shell_path(), that would be a nice bonus.

would give us a good approach for implementation?

Thanks.
