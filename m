Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07330AD0F
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759252393; cv=none; b=TAqG3r/bsZArGTHOERWivV8/R2IQxSGtbqpgOIqtjJWN8GupmYRSgjbhx+Hi5pEhYrUmQMgErlEvKqu9Tk9IQhs0IiWT4thtEIBhe+8tYHBoms99lNo/p9lTG+PW72nX/vuVgH4gi6CfqZnEyuxO8BfQ227oQJYbiOBambSMi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759252393; c=relaxed/simple;
	bh=mIx96+anXl6risdpvxb9JQaLsi1EaZOTTeK48pS8UuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=grXBgJg2ePUvPb1gNWER7Wqoo1WGIgoTku7fQN/rlmSfmIglYn506J1mBCEWl7QhZZc/gb/SYaINtWHlg7hBzW6gRet2DNymSi8TFPElHyO3uWAy2aNMRWWdDSRiImRy7DGXzXt3MtwPUxy1J4t68LKbMnXXI4AvhyKomIetcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DHAZgyMd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yrD4uX6U; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DHAZgyMd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yrD4uX6U"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B202EC00D6;
	Tue, 30 Sep 2025 13:13:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 30 Sep 2025 13:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759252388; x=1759338788; bh=5HuJmyY/IO
	ImBJSJiY+mpWOK9Y7Radh3aY0S14kB0Og=; b=DHAZgyMdrE/9hYshs+SQgxr1v1
	IX/A2xYdHcm12vVxzNkpgPNrwGnEuGv/DYOdVbnntpVBJ9lN2CI3JYAmcHeeXgfp
	z60W0r0p2A6I1dHUZ3uhczZK1fivvU1icdODUOE/4lsAMPPkgyK6tCiRx9XUWazV
	L+rbqXS4D9lzVsdWOtdTemR3IMcN+n/Lnsl/uNpcxID9Lddh1Gv4shnSly0+3qQl
	ikUqj2ZTfCv2z1xzEDXnxIvuC12RxTZhbRoLwP3CCgDjtdFdLqcV5xqEVUBra5dJ
	UqZILmsyQqtmwYJ9a6M4wHn04gejfvGFW+YADMkwK/nJEDXChP1OFkGI1VyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759252388; x=1759338788; bh=5HuJmyY/IOImBJSJiY+mpWOK9Y7Radh3aY0
	S14kB0Og=; b=yrD4uX6UO8KN39WDoUBxgtoZ/gIHI6Oci9Sh4+hhB/iB0Wn+uHi
	0TWiKidGQyOo3iHBK1pD0mWSiMlqRQm+5BchjFFVl+TgRibw4HhHAhtIr1bCCZ5Q
	Dzl1+4P8R5SyDUQ4cldcE2iu5Ul//k7G4K7iRU6S9n39fbXBOedOedo/FdT5Ecpu
	JTcgN/VhdOAPcYi7IoRmKYo201sOOF5CpKFB2/ASuBVKLDE7t7yu6a57+SqgYeqD
	5Wg6JsgPBh48okr33KeAkHZp8Uf1bcmETic+4ElpNrR9OE1TRLEV6ZQlfz6U4XCr
	mSqaC77/xvqZvxqyTj8cMHmo5whQC3jMzVw==
X-ME-Sender: <xms:ow_caN3l0unCi7J-3KS51oay1hggahU9k-lEVDLJrxRCzqOkh1KE2Q>
    <xme:ow_caLEtO_pkr9C99R23evrZ2V_zIWOHBMefqnb0SeKOTuMydHopOHKQekldMwTfF
    IlxZQJvhfLdN9nVbYAwLZoJFPI1gOS6LebEGrYNKGe5vTbf0gPgig>
X-ME-Received: <xmr:ow_caC6IVcGP-Hb4Zo7UidwzPaP1WjFJeMx4PmJlQ46lma1eh9nt532rcHZZtye-5gNcc8CeGXrdDLEkBGXCuH8LqwBUKS6P1vhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhitheslhho
    hhhmrghnnhdrshhhpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:ow_caJtdTHGJrhs6HR8iB6gjazudbJ459f30tYNUcfdiuut6_nCjjw>
    <xmx:ow_caL5SwjuF2jplNEUtudgLA0Z0jfdC2t-rBubB_oRePO-leiZ-Cg>
    <xmx:ow_caMU80mE_slLE5beSUcS7o-22MWzelbiYnqPmx6f_9crkujcUiQ>
    <xmx:ow_caF_xo-wIv-Eje0Im2kKLdqzFccptaJHOpMyYUKz9rJGxn_VI9w>
    <xmx:pA_caL_33IWmpADno5Oy-zQKrODyTAs3rWW1E2CHjUqQD3d5R3K0X15O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 13:13:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@lohmann.sh
Cc: ps@pks.im,  git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/reflog: respect user config in "write"
 subcommand
In-Reply-To: <20250930143741.18331-1-git@lohmann.sh> (git@lohmann.sh's message
	of "Tue, 30 Sep 2025 16:37:41 +0200")
References: <aNu-cTrJwPdcW6hq@pks.im> <20250930143741.18331-1-git@lohmann.sh>
Date: Tue, 30 Sep 2025 10:13:05 -0700
Message-ID: <xmqqplb750f2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

git@lohmann.sh writes:

> From: Michael Lohmann <git@lohmann.sh>
>
> The reflog write recognizes only GIT_COMMITTER_NAME and
> GIT_COMMITTER_EMAIL environment variables, ignoring the user.name and
> user.email settings from the Git configuration.

Rephrasing ", ignoring" and everything after the sentence to
something like

    ..., but forgot to honor the user.name and user.email
    configuration variables, due to lack of repo_config() call to
    grab these values from the configuration files.

would make it more obvious to readers what the right correction
would be.

> The test suite sets these variables, so this behavior was unnoticed.
>
> Ensure that the reflog write also uses the values of user.name and
> user.email if set in the Git configuration.
>
> Co-authored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Michael Lohmann <git@lohmann.sh>

This is not in general the right place to make repo_config() call,
even though in the current shape of the program it happens to work.

This will start to matter once we start adding command line options
to the program.  We want the configured values read from the
configuration to populate the in-core variables first, and then call
parse_options() to allow command line arguments to override them.

In short, move the call above parse_options().

Another thing to consider is if we want to do this inside
cmd_reflog(), not here.  Once we add another subcommand that also
records who did what, other than "write", to the "reflog" command,
this starts to matter.

>  	ref = argv[0];
>  	if (!is_root_ref(ref) && check_refname_format(ref, 0))
>  		die(_("invalid reference name: %s"), ref);
> diff --git a/t/t1421-reflog-write.sh b/t/t1421-reflog-write.sh
> index 46df64c176..cf0e8608fe 100755
> --- a/t/t1421-reflog-write.sh
> +++ b/t/t1421-reflog-write.sh
> @@ -108,6 +108,25 @@ test_expect_success 'simple writes' '
>  	)
>  '
>  
> +test_expect_success 'uses user.name and user.email config' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit initial &&
> +		COMMIT_OID=$(git rev-parse HEAD) &&
> +
> +		sane_unset GIT_COMMITTER_NAME &&
> +		sane_unset GIT_COMMITTER_EMAIL &&
> +		git config --local user.name "Author" &&
> +		git config --local user.email "a@uth.or" &&
> +		git reflog write refs/heads/something $ZERO_OID $COMMIT_OID first &&

It certainly is good to test _without_ environment.  Shouldn't we
also make sure that _with_ environment variables, these configured
values are overriden with a separate test?

> +		test_reflog_matches . refs/heads/something <<-EOF
> +		$ZERO_OID $COMMIT_OID Author <a@uth.or> 1112911993 -0700	first

This timestamp is from the above "test_commit", presumably?  If we
later add more tests _before_ this step and they used test_commit,
would that screw this test up?  It may make sense to say
$GIT_COMMITTER_DATE instead of that timestamp here.

> +		EOF
> +	)
> +'
> +
>  test_expect_success 'can write to root ref' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
>
> base-commit: 821f583da6d30a84249f75f33501504d597bc16b

Thanks.
