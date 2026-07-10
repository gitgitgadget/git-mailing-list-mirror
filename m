Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DF5425CD2
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686046; cv=none; b=PZVg88a0VdQyLtaQosnjimDpn9fHN5ic5Z9kvN+QbvS7E+HSJcz7SCgMKWakWyh60JPqfNxiwmX8hNdPuwAyM1uVQfJ0Zj3qz1jW8bb0CwGi7kyfw+b1dv7A/owsTfLKvYSnX0iHM5tuwMjX1lFKNXtEryf2pvACHi9WuJNGY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686046; c=relaxed/simple;
	bh=DOP5moCq4tzZI+1uiVnlopNnDFt6i7XOfNLbqeLkfxs=;
	h=From:MIME-Version:Content-Type:Message-ID:Date:To:Cc:Subject:
	 In-Reply-To:References; b=Qe+9F8ALEcsnftLX33CPO8TL1HuzQ9YtF/TExz/WUdGYbzU7RT16V1TUfrafBFqYywSH12VkA86VaxfZAK0FWMDKOi+w+/wi/cHsnVyd3J8GMdPjkFEUb+dCbXH+NjbBJ84V2PTR66vopGkIfcOZZrWZm8Q1vU8gcGPJ8S+34+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=iadtJFoZ; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="iadtJFoZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=d.chiark; h=DKIM-Signature-Warning:References:
	In-Reply-To:Subject:Cc:To:Date:Message-ID:Content-Transfer-Encoding:
	Content-Type:MIME-Version:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=ltTf/LwnPs5XvWvEUaRGzBYs4a5c1CW3e457Mee/Kt4=; b=iadtJFoZcnbd
	Q0EQ0pIejjucQcNK6LEaRH0qvu5JVzmC2DKYjM2R8/6F7g52+AlFVklksVb/PEETL4WpmWeaZvFj9
	EdXD77HLLq9kjAuoqfEcy84fzV7sXx4di4OY3XvC4s1XxDUDoUAcadb6pfbe74mwC/qdAzKHhZIke
	+qYEo4FsDm8NhCNQdNTJtBYYk0pJfNcc1gsi27FjKHJc16Hfb08CcH0/cVOi8Sdg+5oO5jmramT1E
	7TRSdcET5ZHNbH0qE6lZ/iIkjODS1P++HHKtEiNSD+O3MB52UgfAODW2PHdrb80C11rbSIrzEPt/0
	nfwW01HxWtAo/YBSWUwZnw==;
Received: by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1wiADb-0004wD-RS; Fri, 10 Jul 2026 13:20:35 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <27216.58259.815175.923629@chiark.greenend.org.uk>
Date: Fri, 10 Jul 2026 13:20:35 +0100
To: Colin Stagner <ask+git@howdoi.land>
Cc: git@vger.kernel.org,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite [and 1 more messages]
In-Reply-To: <c8b81987-ab56-4d6b-a650-879b84597a17@howdoi.land>
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
	<20260706115816.20267-3-ijackson@chiark.greenend.org.uk>
	<9ef8cfcc-ab47-479b-9f23-71ba99e1e56b@howdoi.land>
	<20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
	<f557bfcf-ffd2-4903-8015-97fff97dbe09@howdoi.land>
	<27215.27575.968985.583226@chiark.greenend.org.uk>
	<c8b81987-ab56-4d6b-a650-879b84597a17@howdoi.land>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/96/9679f38b4e3b38fb6c06c1224458c133.pem

Colin Stagner writes ("Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust rewrite [and 1 more messages]"):
> In retrospect, "top-level" is ambiguous. "Upstream" and "downstream" may 
> be as well. Within git-branch(1), the phrase "upstream" refers to the 
> remote tracking branch set by

Upstream and downstream are of course relative terms.  I think the
git usage you cite isn't quite central.

> git-subtree.sh doesn't really deal in "upstreams" in the git-branch or 
> git-merge sense.

I'm using "upstream" in the wider sense; here, when you import a
depedency you're downstream of it.

I'm open to better terminology and now is a good time to be debating
this, but I don't like the other suggestions so far.

I want a term that talks about the logical (even, social) relationship
between the two projects; and it should be one that makes sense from
the point of view of the upstream.  Talking about the file position
within the downstream tree doesn't make sense from the upstream's
point of view.

> Both of these deliberately ignore the dependency relationship between 
> the various projects and branches in question, which can potentially get 
> messy.

I think the dependency relationship is inherent in git-subtree's usual
use cases: suppose a project A gets merged with git-subtree into a
subdirectory S of project B, so that B.git:/S/ is a copy of A.git:/

Then I think almost invariably, this is because A has B as a
dependency.  And A has B as an upstream:

Code that's part of B flows from B to A, and can be edited in A, but
the canonical version is that in B itself.  If there are multiple As
incorporating the same B, they share via "split", which produces
history "within" B.  Thios seems a classic upstream/downstream
relationship.

As I say, I'm open to other terminology but I don't think "root tree"
and "subtree" are the general terms I need to describe the
relationship.  In particular, from the point of view of the upstream
project, it is its own root tree.

> Very well-reasoned; I like it.
> 
> Let me ask this question in a slightly different way: does RIIR subtree 
> honor config files in locations other than the one you test for above? 
> That's
> 
>      ${rev}:.git-subtree/config

Yes, but not relevantly.  Different information is taken from
different places (the design gets a little complex to make sure
everything works in all the use cases).

> > Combining manual -X subtree merges with git-subtree --squash merges
> > could easily produce quite weird and wrong results in the tree
> 
> I haven't tried it, but I think if --squash is in use, then attempting 
> an unmarked subtree merge will probably die with "unrelated history" 
> warnings.

I think that's not guaranteed if squash merges and non-squash merges
are interleaved.

> Looking forward to v2,

Thanks for your support, and your critical consideration of the design
questions.

Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.  

Pronouns: they/he.  If I emailed you from @fyvzl.net or @evade.org.uk,
that is a private address which bypasses my fierce spamfilter.
