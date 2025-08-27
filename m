Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D33273D68
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315851; cv=none; b=iEASlkjbx5B97Rcgy5dS+J/NCN4KGSaR4sKsAsEPmvDEXZvG/H8GaXiSq6LLjdfHi9DnedNoyXicUHfZxxMMbG+pb3oY+khcBSh+x/cjw7uzYbKC0h/VCk8gECG8HqDUEDKJGYzXa+qpvlF9O2t2RuqtTI3E4FFOOHp2lGt/HvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315851; c=relaxed/simple;
	bh=Ey/fPxZ1lDt4dgIuGbHAgxOnN36FscxGicN3r7Jge0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vh8G7UxVR4oW/nfo3N2V6lqo7RDV+2OK6wiJPMLcaDGOKs0gJeEEzZPqK0Qv7YDuu+sQmSAnRj+Fofy94buBFUS0XLFpWgtHJZi6CluY+3GPNyje+LvzSYumXGN/1R4m+v8A63QXl/y+hh0YxwJ7PnqHiZlhrZP9arAg57Eiz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yn9DdMst; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CC6Qfhgd; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yn9DdMst";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CC6Qfhgd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3BAB81400066;
	Wed, 27 Aug 2025 13:30:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 27 Aug 2025 13:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756315848; x=1756402248; bh=xdaRn3IRvH
	cqdFJ4JqJiiTLmTAMDR/SFBeUXQ2f0mlE=; b=yn9DdMsthJaUfXPGz9vWUp90KZ
	Jgxefm5rieeF3dhYbGjqChH8KRgLPAqGB7WHgoygR7xFY3HD29MDzL1FBAVism7I
	yAeP82dG+rCepxTl2ub2Ejfnzl1H+fVgrVT3yXK/L01YcGnf5FAuMuL0jMnsr7T0
	PGK3xI3NAAwU4yxv5nx14hGXYq+/XmGvEgN55czxWRnAoLy9YS1EGuOyRCSOljrf
	cz40A9BoWo/Cj9BEMRbko8MZdQEvz7ujlnRCRG3YaCgQH7RdWNA3bZzg1erxunIY
	xDatqKijDcbab6Qy62IJzcyFGeFcvNZSp/B7FjMXQdWrOJLSurLYX+gNCZQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756315848; x=1756402248; bh=xdaRn3IRvHcqdFJ4JqJiiTLmTAMDR/SFBeU
	XQ2f0mlE=; b=CC6Qfhgdce2IKudue1TENCF0r8CyRxD/VsbzyalbF0vEKYKO1lY
	DGF9sP78RgKG1S5bsCXmK8ptLmrKmT2ybAawEBdUjUNl1mW1hn0TBr8mqIRqOnbK
	b3XUUTqZWb+yaG31BQvEq06K7tTSN4uRMNhcNyHt63pgc7GCgH49jYfvSiS2tYEa
	YaNz1n80FqA66MYQeEP2v7rQqz7SUILuGcD/6FVYZ4Sa2zDMuumNGgFG0LKVRKv/
	NIld8gwHV05yTRFFaBfCfQKTNSXiCAfypGv8Ijk6UMOYFdZqA04PTz/nMfmQ2ovO
	GtMiPjTeW604oXJ4d3b+r6gVgtL3UMnlf7A==
X-ME-Sender: <xms:x0CvaHZptRkIwCz2CF0olz1KZqm0eHmMXT0mdyRJqdVZhSvKbXuDBQ>
    <xme:x0CvaO1FicR48EMBlD3B-IblmES8Sj0nGkiBVKHqibTaZPywGVDfaropm4BFuODlD
    YoqhtR1uO8jPrqJaA>
X-ME-Received: <xmr:x0CvaKYjr-N9jJhe5Qjfgh0Zn1C-rlel2qH5pqhI1dXDtdQawcAs5PjCspr68SeCJ3hhGgW5jpaQ-7qS5AIoXjtzbiVr-zok1nuVyjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinh
    guvghlihhnsehgmhigrdguvgdprhgtphhtthhopehhuhgrnhhgshgvnhefieehsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yECvaOIgF4NsqCiY_ZcadGoNfCzPt2l4F3a1p-Pf2bjAyuZYMmOqTA>
    <xmx:yECvaBEr7HPiDt7gIl4wo8xpIGDgHuX3hEioafLfPq6X6H83DQd5Dg>
    <xmx:yECvaNsS9AlFXljxdKZjXfinr556vrz5aK3AcYHaEXV_VP83uiCX3g>
    <xmx:yECvaIvNjtCPjKSxurQ6ICkkeJU3bI2NAMp7i_XI53fFBVrrr39qGg>
    <xmx:yECvaO5sP4igvuxStJizg0s9PpgV3RGDEPAVtuIXR4prEG0YhnXY2Wvu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 13:30:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>
Subject: Re: [PATCH 4/6] t0613: stop setting default initial branch
In-Reply-To: <bbf79dd64fef485b75bf0fbb37322a6cff7df7f8.1756308283.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Wed, 27 Aug 2025 16:24:48 +0100")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<bbf79dd64fef485b75bf0fbb37322a6cff7df7f8.1756308283.git.phillip.wood@dunelm.org.uk>
Date: Wed, 27 Aug 2025 10:30:46 -0700
Message-ID: <xmqqwm6ozn7d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> As the tests are all run in separate repositories, set the branch
> name to "master" when creating the repository for the tests where
> the result depends on the branch name. This is in preparation for
> removing GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME in Git 3.0.

I do not agree with the statement that Git 3.0 should remove support
for GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME facility in its test suite,
so it is somewhat moot for me to review almost all the patches in
this series, but this caught my attention.  As this one needs to fix
the initial branch name to a fixed string, no matter the hardcoded
initial branch name of the time is (even after we rename again from
'main' to something else), I do think this change is VERY MUCH a
good thing to do.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t0613-reftable-write-options.sh | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
> index d77e601111f..b547e12d66d 100755
> --- a/t/t0613-reftable-write-options.sh
> +++ b/t/t0613-reftable-write-options.sh
> @@ -11,16 +11,12 @@ export GIT_TEST_REFTABLE_AUTOCOMPACTION
>  # Block sizes depend on the hash function, so we force SHA1 here.
>  GIT_TEST_DEFAULT_HASH=sha1
>  export GIT_TEST_DEFAULT_HASH
> -# Block sizes also depend on the actual refs we write, so we force "master" to
> -# be the default initial branch name.

We may however need to keep this comment somewhere in this file, to
warn against future developers that all "git init" invocations must
use 'master' (by the way, would any 6-byte name do?  I dunno) as the
initial branch name.

> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
>  
>  test_expect_success 'default write options' '
>  	test_when_finished "rm -rf repo" &&
> -	git init repo &&
> +	git init --initial-branch master repo &&

And being explict like this is a good idea.

I am curious how the CC: list was formulated, though, as neither
name comes up in "git shortlog t/t0613-reftable-write-options.sh".

I've added Patrick for comment (primarily to pick his brain for the
6-byte thing).

Thanks.
