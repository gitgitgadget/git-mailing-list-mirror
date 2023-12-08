Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5612B6C
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RVQuNTic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7496EC433C8;
	Fri,  8 Dec 2023 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702061352;
	bh=J9nx8iyItyJRx7or5t0h4UjJCZ2K/6ZfAgtAmK+bZpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVQuNTicdIbssJYAj/mgxCxXDqJKiOVj5vtah+aMlYKN/6Ct5CgaDwpHOxZkpFwMg
	 perf+fS+gbYBe/9Qabw3PIOd3FdYsIElKhlRx69eFiORePUC8vCA46OIUSGxb6WWmB
	 axRJ4lnZnqkJR5wM73oVkrHWXfkh8GrpqZumRfJE=
Date: Fri, 8 Dec 2023 13:49:11 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Sandra Snan <sandra.snan@idiomdrottning.org>
Cc: git@vger.kernel.org
Subject: Re: getting git send-email patches from someone who is behind
Message-ID: <20231208-amusing-vengeful-raptor-e71a8b@meerkat>
References: <87h6ksk2hk.fsf@ellen.idiomdrottning.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6ksk2hk.fsf@ellen.idiomdrottning.org>

On Fri, Dec 08, 2023 at 06:50:31PM +0100, Sandra Snan wrote:
> I have a li'l git send-email question. Someone sent me a patch set of six
> patches today but they were not on most current main. I had to guess what
> version they were sending to so I could git am when I was on that particular
> version. I managed to sort it all out so this question is more for future
> reference.
> 
> Isn't there a way inside of the emails that it can show what version to
> apply the patches to?
> 
> Because now I was like "OK, I remember talking to them the other day and
> that means they probably are on what for me is HEAD^^" and that turned out
> to be correct, and sorting out the conflicts was also easy enough,
> but if I hadn't talked to them beforehand I would've been completely lost.
> 
> I asked another friend about it and he said:
> 
> > it's possible to record the base commit:
> > https://git-scm.com/docs/git-format-patch#_base_tree_information
> > however, it's a bit finicky to do with git-send-email
> 
> I dunno.
> 
> I get that one of the fun parts about using patches instead of PRs is
> that you can be a li'l more loosey goosey about exactly what commit
> something is supposed to belong to but here I would've been completely
> lost because the patchset just borked horribly right from the first patch.
> 
> If others have run into this, what's the solution?

Yes, setting base-commit is the right solution here -- it will tell you
exactly where in the tree it belongs. In its absence, tools like b4 will also
try to guess where the series might belong by comparing the file index
information mentioned in the patches. It's a clever, but not exact process,
because the patch may depend on changes in the files that aren't being
modified.

In general, having a base-commit: line in the cover letter or first patch is
absolutely the right way to go.

-K
