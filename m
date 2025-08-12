Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13F27FB27
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012666; cv=none; b=dKaAK584tnAm6NFCwCZgwyOD0Ixwf9sS+f4DdM/U9dwvbRMw4RiAHOh/dHh6AAHFcReqkJ+B/DGAY4oXSHwF1eDc6MCOyExHAf3QlNV2UvHKMiF1Vjj1WNTaMYiw103zz6UfoLoxzHZ9huBp6G2A7e5mDHHW1l2MuWeoiyX3q5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012666; c=relaxed/simple;
	bh=9ZJ6PmIPuE/OEoWdgyGLQTt09Ft5akmP/GDJUqbYpSg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQK0ymptEJB3kz/5WJY/UgLMr21u359EO1e0VZu0y/bcPhXmM6sapBsjYqZj8HjvPbZKfy4NSskSv48UJ3Iju/Bt7g1HkJr9/skYEPloosChZhWs1qqvcGrwfRB4Aier5DNXE+Nu4DvB/NDMzA+huCwJnl5atpk3qnAAOU3CSac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=n5/Nt5xh; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="n5/Nt5xh"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 529A74C9A8
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 17:24:25 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:77b6:e827:4bb:cf69])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id CCD58780371;
	Tue, 12 Aug 2025 17:24:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1755012257;
	bh=9ZJ6PmIPuE/OEoWdgyGLQTt09Ft5akmP/GDJUqbYpSg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n5/Nt5xhrd+8BUDJXsP6xwcriGmWGgoEdrVU/II3kxQLjaSRdqGLBEWJsF+GEEVJ2
	 9fJ3xYE2BJuNVs8Xrs5PH+01irJ9Z9Xw4qWCymPaOqjkhDtB2vJtZ4kEILnYFvC4wg
	 PsMf+FiwujNnnPkSlYabR/x8L+swcPhxWj/ptZqPGtuNH4uVDTAP3uwCmMG/jMjZCe
	 n43w0fhhUVEUengfJ8D6Hw3KvM5AEa2jfE6ezlG1O/F3mtsXPtWDcMiowPaR6smpLO
	 g1f9Oq9vWU1bugq1q3Thr7HfDZGoyZ3iD8/5TB6xI6ffGr/7Ng/N6JtH7XRMp0ZDQS
	 MzM5GwOctUFuA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2025, #05; Mon, 11)
Date: Tue, 12 Aug 2025 17:24:16 +0200
Message-ID: <5032416.31r3eYUQgx@cayenne>
In-Reply-To: <xmqqwm79x7ra.fsf@gitster.g>
References: <xmqqwm79x7ra.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 12 August 2025 10:29:45 CEST Junio C Hamano wrote:
> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a
> future release).  Commits prefixed with '-' are only in 'seen', and
> aren't considered "accepted" at all and may be annotated with an URL
> to a message that raises issues but they are no means exhaustive.  A
> topic without enough support may be discarded after a long period of
> no activity (of course they can be resubmit when new interests
> arise).
>=20
> Copies of the source code to Git live in many repositories, and the
> following is a list of the ones I push into or their mirrors.  Some
> repositories have only a subset of branches.
>=20
> * ja/doc-lint-sections-and-synopsis (2025-08-11) 6 commits
>  - doc lint: check that synopsis manpages have synopsis inlines
>  - doc:git-for-each-ref: fix styling and typos
>  - doc: check for absence of the form --[no-]parameter
>  - doc: check for absence of multiple terms in each entry of desc list
>  - doc: check well-formedness of delimited sections
>  - doc: test linkgit macros for well-formedness
>=20
>  Doc lint updates to encourage the newer and easier-to-use
>  `synopsis` format, with fixes to a handful of existing uses.
>=20
>  Will merge to 'next'?
>  source: <pull.1945.v3.git.1754945600.gitgitgadget@gmail.com>
>=20
>=20

These patches are designed to not raise false positives, trading it for=20
letting true positives pass through. For instance, the "synopsis" patch can=
not=20
catch keywords which are just one word.

 If possible, I'd like to see how they behave against upcoming documentatio=
n=20
changes described in this "cooking". This is in order to not have to revert=
=20
them at some point.

Jean-No=C3=ABl


