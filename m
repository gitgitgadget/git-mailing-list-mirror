Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8027703D
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428423; cv=none; b=LiM3xymJDrOzBgn1oo2IxgWY91295mQ9y/rgX+2t6qGd+H7L32+UlLa0sG1h2fEuccZZ+fU9HTRq6ncpzn3VSWOR4LCvHfMPrYdMjjvAC9by2iWn5azucADQpj5eDMJr2EY9wQvqH1SBn+m9g5cN26mtZews1PBYk4mBlYipy24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428423; c=relaxed/simple;
	bh=+ioz7jSIQeLZ3K9ZfRUGGsoXh15zEBCklQJrEjz6UVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YoxJbvMxXDg+2AqNPoIGsp0AderSA7E5BBrP1JkDbnWlg2psUy0VL7bdsc0HYboeNpXldjhaRcE1/LzCepkoWeYAkQUAtd6DJn5Zr/RmGjaJ/VTwUNpRnY1vHEzpfM+eFC6JiUHzeB+izOhi9I3n4b06hwp2NDpjs7XqGqOOAkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DGCBl2AV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qngQCH7B; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DGCBl2AV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qngQCH7B"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id F3D0B1D00109;
	Thu,  2 Oct 2025 14:07:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 02 Oct 2025 14:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759428420; x=1759514820; bh=/91Gja7Fzr
	KYHXJUM+LbdKTJluxlSRennkAUywtN2v8=; b=DGCBl2AVB6tAxQMN/EF8GYApyL
	3/2pN0oEje6aGkv+vhZR9bOGHh/8gO95lxkobDQTkn/B2iCqnYVdpnHdAakX73mg
	7UdOzPWjtiYPfu5x7tQcJr+HpmnE7i9gzDgDt9oxXWO1Aosnibn+Ieg3I92AwmXB
	vBNsJAc2QSENEHdJqor7coU7e868GxRNg4LTvM7xeZwtnQ7jnDdY7fRfLWwgusN5
	2IqbbhEhqRnfqEoweMn6Dsxx+cvurjHmMYhBOqAwB0R+9sIrqo0nMHHWe2MYLYjc
	z9l/nlLaJegI+TMVZr148xLGzmKI/0Ww3y1zNc6eFb/gxBLuEOGI6HBP1CGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759428420; x=1759514820; bh=/91Gja7FzrKYHXJUM+LbdKTJluxlSRennkA
	UywtN2v8=; b=qngQCH7Bnit7YOAJgsbt39XBBYzxxj4UVEoRWoZQS8+NczTc2L6
	TyQ4GvizlhinIOFPNjrQJRrG6BvFNkvA9ZUzjOI7maBsrVYDDbbOD+tMcUA1bX/v
	RSJSMjVa0kOT/mw4srzVaIcQN7sHyULrC+Y64OF64WbyyqRR+doGyUmesxm5Ljpu
	4q9ivy4V/CpJJJI34pg80JeVl6UT3XvTkIL3rdpEYHm03TB5mlp7tMsABBMmvXXT
	VwHKUXN7pGlMhgPMgPNICx7biHYnUIvv8L8iNTj7WuJU6rMYQKOwDKNeeIkH5kJa
	OsydMTBsNBTjJGZSESwPAQwUWtxO4eVnxag==
X-ME-Sender: <xms:RL_eaMfLY9OPedU8dqlR96v5W0T8hQqj3X0Lux_RpiAK4fCTQNmo6g>
    <xme:RL_eaNSIb6YBB0oIXeGQOtnt4HSZRZILnLw4B13ZZFls3seRLirHGmNvpmcL2RtWN
    xu6UghM2OThVgS3oNItAAsfH1-ESSMHzcS86WvalrfPOHzHr45v1f8>
X-ME-Received: <xmr:RL_eaDt4aKFBcp2lqs_PbDPVztTRy57qSkIG633hLr9Cs0BffYmx7-5VtMlTZ4JqRn2Z-r0M2GMU6zsM2PfbA99khbjd5EU0fA2u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmshhutghhrghnvghksehsuhhsvgdruggvpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhh
    ihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepshhorhhgrghnohhvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjhgrshhonhduudgthhhotggrsehprhhothhonhdrmhgvpdhrtg
    hpthhtohepjhgtuhgsihgtsehjtghusghitgdrphhlpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RL_eaOdQzQqWKkyG8GP_ZE5YStK_hBkJrrD81K_jkf80or3g74UHRA>
    <xmx:RL_eaNaKTR9hxDpdCzJiyOLtMrlsQeI5HBZF_0hxMT76Ex2uHQRn2A>
    <xmx:RL_eaAZfwHDJpHC5NefpzXEd1eo2NX87PVNFesdWQuX1Goyaczf2aA>
    <xmx:RL_eaCIqkyft-QAH0avNhfQAq8QOGmxPKKkxQQZiJNIig7Ltojs7ZQ>
    <xmx:RL_eaI0c7XbYn3kgfb9L7WhtqUqacVvxav9iNzCegF8mgr7_f92Ovlcd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 14:06:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michal Suchanek <msuchanek@suse.de>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Sergey
 Organov <sorganov@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Jason
 Cho <jason11choca@proton.me>,  "Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: Re: [PATCH 2/2] doc: git-worktree: Add side by side branch checkout
 example
In-Reply-To: <1d5b41562937d83be261d054989b04db6cb94a86.1759420102.git.msuchanek@suse.de>
	(Michal Suchanek's message of "Thu, 2 Oct 2025 17:51:35 +0200")
References: <xmqqseg1xwc1.fsf@gitster.g>
	<1d5b41562937d83be261d054989b04db6cb94a86.1759420102.git.msuchanek@suse.de>
Date: Thu, 02 Oct 2025 11:06:58 -0700
Message-ID: <xmqqcy75w531.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michal Suchanek <msuchanek@suse.de> writes:

> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  Documentation/git-worktree.adoc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
> index ec31863aec..122b191ff9 100644
> --- a/Documentation/git-worktree.adoc
> +++ b/Documentation/git-worktree.adoc
> @@ -525,6 +525,16 @@ $ popd
>  $ git worktree remove ../temp
>  ------------
>  
> +Side by side branch checkouts for a repository using multiple worktrees
> +
> +------------
> +mkdir some-repository
> +cd some-repository
> +git clone --bare gitforge@someforge.example.com:some-org/some-repository .git
> +git --git-dir=.git worktree add some-branch
> +git --git-dir=.git worktree add another-branch
> +------------

It is a good example to have a bare clone and get worktrees attached
to it, but I do not think that it is a great idea to call that bare
clone ".git".  It makes it confusing if that some-repository/
directory that has a ".git" directory is a non-bare clone with no
working tree files, or if it is a directory that Git has no
knowledge about, that happens to have a single bare repository plus
worktrees.  The answer is the latter, but I suspect that Git itself
would probably be confused (i.e. "cd some-repository && git status"
---if you try it, what does it say?).

Naming it after the project may make it more apparent what is going
on when the user goes into that top-level shell directory, perhaps
like this, if we were working with a "bunny" project:

    mkdir bunny
    cd bunny
    git clone --bare gitforge@someforge.example.com:some-org/bunny bunny.git
    git --git-dir=bunny.git worktree add some-branch
    git --git-dir=bunny.git worktree add another-branch

Then when you "cd bunny && ls", you'd see the bare repository
bunny.git with two checkouts.

Having said all that.

I know some folks like such a layout for some (perhaps ideological)
reason (i.e. no checkout is more special than others, everybody is
equal), but I am not absolutely sure if it works better in a larger
workflow in practice than having a primary worktree that is not a
bare repository.  If you do the above with a non-bare repository in
the center, it would look like this:

    mkdir bunny-project
    cd bunny-project
    git clone gitforge@someforge.example.com:some-org/bunny main
    cd main
    git worktree add ../my-topic-1
    git worktree add ../my-topic-2

and have my interaction with the upstream project only from inside
the primary worktree, i.e., "main".  Additional worktrees are more
or less ephemeral, and can go away.

> +
>  BUGS
>  ----
>  Multiple checkout in general is still experimental, and the support
