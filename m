Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E02D27A925
	for <git@vger.kernel.org>; Fri,  9 May 2025 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792785; cv=none; b=FIc6JR5MYreJaeoFd3jEcysrDjm6XADK0Tr00OJ5+IJbbSyl9VeoVbQXlICHMeiLJfrAUPE5++lgZ2zakXdZBDpQgGAidjL7x2XJkva60V7mvy+pv5En/1IC3S1JPEtc2mzZYLPYSwvjTaxYyqlD+EbzrtVX7dtc5JbJmVUZVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792785; c=relaxed/simple;
	bh=45tr6tTUAxuU1e73feL3KuixZG1YaAKzKfxLslkFxes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZza9IANIBG1sIjbpXSruCPhwvqqR/6/FAKeJFq05/De/V1b48oF9yRMPJ6iHygpfsGUDSMCZrTqXKylNHGaciVeqzYPrFQTd3+gYx/Pfd0jWZ6bh4r6PER0t2SBCc6DXVsveFrr134PpGJqKmiQL7i5nVxhTISKn1UOcH3WBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=ccul8Ldn; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="ccul8Ldn"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 2D47013F88F;
	Fri,  9 May 2025 14:12:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1746792775;
	bh=45tr6tTUAxuU1e73feL3KuixZG1YaAKzKfxLslkFxes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccul8Ldnyh8GKQ0fHcuyrGDzIR7n2N5Z6NtYrF+9RYL2R2bCft5H0kNZDN7zGkypm
	 eVDdNkgG38haOoGMXZJOQ+kT+attCplP+2rHiu/Kapi7klknErLqCaUVCNqQYpvkCR
	 WnrJtcoVODeSHnbY3CzkqlAv5SYabXBFGF4+qvPdRr0IHu9iLkdqdejn8Fg9Inccat
	 REg+nrZdQV2w56lds2uRBEWGSFtzHm2iAVG66mPeKtLgARjtYb2S3AnoC+vpxcyWWN
	 IwNHi9hyuEzE77FgicQGqRWyLgFcRllPoHlzlkUM8pdbQps9ob3W8ASFQkWuPvE5Sk
	 QSTrDzThCMIbg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Additional changes
Date: Fri, 09 May 2025 14:12:53 +0200
Message-ID: <5040970.31r3eYUQgx@cayenne>
In-Reply-To: <xmqq1psz878f.fsf@gitster.g>
References:
 <20250503011537.3035416-1-gitster@pobox.com>
 <20250507210104.26709-2-jn.avila@free.fr> <xmqq1psz878f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, 8 May 2025 17:14:40 CEST Junio C Hamano wrote:
> Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:
> > ---
> >=20
> >  Documentation/git-daemon.adoc     | 60 +++++++++++++++----------------
> >  Documentation/git-var.adoc        | 40 ++++++++++-----------
> >  Documentation/git-verify-tag.adoc |  2 +-
> >  Documentation/git-write-tree.adoc |  2 +-
> >  4 files changed, 51 insertions(+), 53 deletions(-)
>=20
> I was somewhat confused where this patch is designed to apply, but I
> think I figured it out.  These are to further update on top of my
> synopsis related mark-up updates.
>=20
> Do you mean this as a set of review comment, i.e. I am expected to
> spilt them into parts and fold them into those three commits to
> produce an updated version of those three patches with "Helped-by:"
> attributing you?
>=20
> Or do you want this to sit on top of the 3-patch series separately
> as the 4th patch?  If the latter we'd need a log message plus
> sign-off.
>=20
> I'd assume it is the former (as the three-patch series hasn't hit
> 'next' yet) and start updating htese three patches.
>=20
> Thanks.

Sorry for not being clear. I was wary of what the provided patches did not=
=20
address, so I reviewed after applying your series and bundled it in another=
=20
patch, which was not signed off on purpose.

Of course, the proposed changes can be discussed. If you prefer, I can=20
dispatch them and propose a v3.


Thanks,

JN






