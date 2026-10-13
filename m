Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585523ACF14
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929132; cv=none; b=AAWLLORQMBMqejYtrSStUPyEkQ7C4/WZaaCyDhx8zxQnuJ3MHY/gkqrGxHCB2KlhtyCMBs98asfK4F9F4vVJzeAcJikJetloL9/vvglqR2toG3aPxfjxlOdzqh2MyuznJWrNUeJ4DQ1GDe6Py0dlvg4DDVH4JGn3EhNoQ3fgHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929132; c=relaxed/simple;
	bh=Rc+xsyHAucL96le5sDYCZyKfb0koAcTh/bFu8S9zjYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GIN++WNON4kTTNBVAhQbDRLAhPCrngRMWgAxuINHs8i+jJKia/4VllrukyAren6mbmwQdvlBAGxrP0gM3jRY8wmOyYlEFywpUuG/Sp7+ESVG0sHihdaDE73sRX+wCik0B9jdhzkOr0HTfmyrG4EV63RQfgQMlkkIxoCuJgTXqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JlzqU1gZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r9GyJZqv; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JlzqU1gZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r9GyJZqv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 85E7B1D00209
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 18:05:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 13 Oct 2026 18:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791929129; x=1792015529; bh=/lnHVSPQR1
	R1t4PZKajGGwVFYH6T9EjvtOJZ4QmEy2g=; b=JlzqU1gZQKPOf+QWlemG0ieujd
	ZhrMAv0Owlj0IdA2RLMY078WF/S7fzwHwP7bQTFdZuqtDjq0G6JiOHCfavjQcsXa
	BtmsXVX76ca85RDWoonp4SqZeC1uyt+M2WMT/xpvIKpCTjTmMgxqej90HhI1QYxS
	oCsRw0WRkTBhEc4/K/HeNJ79LcBl53Nz+eMLJOf+4iB0SUfYuwECUg0BxDQ4rdhL
	Om3JrWRFqsdDdPpWlZyqmJULFwbXBEwbowRHusAorcsLy8kg+2XYwjOQEifh3Saf
	0vgu/VaQVMRWYqrFjT9RQBlGpmRimNwyGcCUZJTMck+WX4FLdRPSB3cCRliw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791929129; x=1792015529; bh=/lnHVSPQR1R1t4PZKajGGwVFYH6T9EjvtOJ
	Z4QmEy2g=; b=r9GyJZqvd2e5Ml7yCwdKb4znJ+7Xp9i7BWPbAdtwAxXCfiuZ7dq
	6fUvnVjgKSA/HrfHCnYmsfN7Mu4GU2CDckQLd1mD8p3uiWz4DtO3p/v1lO6Gii+F
	vp9lVXgC761EJvMoSyKZVCcCGi7JvCLy67qrZ6aSiGko7fUmPrDsE8NJ0zRMxMlH
	mz4IPmnFBuDRVsJjoVfABrR0uXBcGfToea8xWDSUTbNv38LqWA4Wx6lezAyEHjPs
	IN9HmuR8gHwoWKZutfiaGpoeUPMyPy64p5FkBEJksplKgCXncYqPT5hxwNBfFahc
	8My63nU4kTauenO6TDO9ZEde5qL08Ta1TQQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791929129; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:c1DSrlUxNnJCLQAe5BAvyAHgGgUwup/fMafjjdjD3ht8+qt
	W84HAoMk3cnKxESPpjYge88wghNxWOyfWa9s0iW8yt5AzBKBUzHgPGCP+E3C/mEl
	hSobeRC3Nsv58olnbv/bZUSlB0yxAO/d+6AiL8f7RcFFQfWbqLGjQOrLeOtYqh8w
	Mvk+xp/gTpCiVJ4QcFFIv67/5S15FtEizMtLMrGTFbx/Lr+niPS7ynIAYn7OQtv9
	Bp2LpTC1bRhojoMZEHKwQZcxUIc5FGH0BNzKy/pBwYU7myWe5qtGYifTR0nJgc9w
	I0eG0ccbiWnzBltACTSpRGbEvO5i5HwDVMkZFiw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mLPefZ6ky0gqrTdI+XZ1r4t+Nnicieuw1xvUJVjbmws=:Rc+xsyHAucL96le5sDYCZyKfb0koAcTh/bFu8S9zjYM=;
X-ME-Sender: <xms:KKvOaiKYJVfK1RU75ijlvAwud60F5Az8W76UxuJDAEedC1RPe-r_Rg>
    <xme:KKvOat2TeZRzqeJuxDUS2_XAHYm7FzEvg0W3bqtfBNErgZUwHby-DR3_wRwxw9ywf
    vXIdhvSdgOF9xftG8jI9KHcpxjs4bGMIiAeDxwOjpF1wIas6A40Fw>
X-ME-Received: <xmr:KKvOasjdG7Fyz6sMK-iakeFbnVWvOXdq-U0jUI4V-fAO2yJLyDJi29TlivyGHVXPRMCUOG6puc_BAWFqH8EQf66D0UtqM-Y5tMtC>
X-ME-Proxy-Cause: dmFkZTE5exZoNbQhmG96uZOYesndBhGJEjpdvMBwEZASIPH8zIRDuYRLY80XEQLHNKw07P
    TrF07DvsCL1cVpNao33Zjnhd/pnoieRp2EABIwm56sCCCJQZUx8sgepzk44VUr/Q+c1LoO
    /xz1cdR95mjCy0egyrw/jXnAT9Z+96ILIzL6G4pT+MTMgqrGE5WuPgG9x6pWOBK/6GRK+e
    x0ghM9II/Hi2SfOTRCHYYBdyd6ioaL3NGUwjmc7mE77gwr2Th1RT/5RzhfeK3Genpx/XoT
    NGsBmmquJpJZiSOUQ0UQL4GGHsWYiQ6n1P0+34yLcTdTkEV21fPbzMFK/jVTas4U6apDUk
    aHRXjCZdyQYvTYgfhyMl4K6jHEqEklnK6ipFI06yleRNsiLyepZSVOP+RBZcvJvLIn/7SW
    3QUn44KjvEnPQIZKgD43vTPK6dCs9P4iOsXF286AK3x23jyUNLoujznhfJoUXEhRK4zFsX
    OXJmwULamHIfKP0bw33w91oqjIXRB1z5nwZaEAnwowaYjxTktwH/E0TNPHSyU6UPN9zS/V
    J+DK+zd8q31szKrUS/pAMKuIbPJ10ud0TLpCAU2ndxpCCp6HROcr1iWhiAmtPOVOz6IWyc
    T1BUWJhled2eXHXYZqRqjaogstmy5Ds68jq5zJ9tJ9J1FB+7C0LaSNwlsxJQ
X-ME-Proxy: <xmx:KavOauWNbDqRJRbDFCo7AxOmod6oMz2d8Oh1G28mmpkA6N_rEwUaRQ>
    <xmx:KavOarX3RTNu0bhAm-_sToTnhZsAcew4bxpJTHBHePfSxfJOJtmN5w>
    <xmx:KavOaug0Y5HdlRJZWuyW0VnnsjmhIebMUbIeMerEEWbPJDXSRqv2MA>
    <xmx:KavOamZtrgxVYINDBPtHu8nMLUUGW9nm1gXnjVrcLv1JhEeZzB3HkA>
    <xmx:KavOaitNhbWw3r57t0gk1C0EXRbdH6ZfQ_Z8ND6r-DymP7CTS6j8maIJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 18:05:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jun Wu <quark.zju@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  ps@pks.im,  Jun Wu <quark@meta.com>
Subject: Re: [PATCH 0/2] Add a way to wait for index lock
In-Reply-To: <20261013172315.2997446-1-quark.zju@gmail.com> (Jun Wu's message
	of "Tue, 13 Oct 2026 10:23:13 -0700")
References: <20261013172315.2997446-1-quark.zju@gmail.com>
Date: Tue, 13 Oct 2026 15:05:27 -0700
Message-ID: <xmqqh5ipuuhk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jun Wu <quark.zju@gmail.com> writes:

> From: Jun Wu <quark@meta.com>
>
> An IDE that runs `git status` periodically in the background has 2
> choices. Both are suboptimal:
> - with `--no-optional-locks`: `status` becomes slower over time.
> - without `--no-optional-locks`: conflicts with other commands like
>   `add`, `commit`, often run by a user from the IDE terminal.

It is unfair to expect that the readers would guess what you left
unsaid here, which probably is "we will introduce the third choice,
which does such and such things, and it improves the situation in
such and such ways because ...", before listing ...

> Patch 1 adds index lock timeout so `add` can wait instead of fail.
> Patch 2 adjusts the read/lock order so `commit` can also wait.

... these.

> To minimize write race, if the index is read before locking, the
> wait will be skipped, as if timeout is 0. Depending on the read/lock
> order, some commands (e.g. add, rm, mv, checkout, restore, read-tree,
> apply, update-index) respect the timeout. Some (e.g. reset, stash,
> merge, rebase, cherry-pick, am) do not. I started with the simple and
> common commands. If there is interest in other commands I can take a
> look too.

Is the above supposed to be the description of the proposed solution?

There are multiple parties (i.e., `git status` that needed to
discard the result with "--no-optional-locks" and other end-user
actions that do need to safely update the index) involved, and it is
unclear whose actions many of verbs in your writing refer to in the
above.  E.g., "if the index is read before locking, the wait will be
skipped" for whom?  "git status" that wants to opportunistically
write out the result of refreshing?  End-user actions like "git add"
that wanted to register new contents to the index?  Both?

> The default timeout is 1s (reasoning in patch 1). I'm happy to change it
> to 0 if people prefer no behavior change.
>
> Related context:
> - (2017-9-22) https://lore.kernel.org/git/20170923033425.6ilykxl5pi7unlj6@sigill.intra.peff.net/
>   proposed index lock timeout.
> - (2017-9-27) Commit 27344d6a6c (git: add --no-optional-locks option, 2017-09-27)
>   introduces `--no-optional-locks` for the same issue.
> - (2019-5-3) https://lore.kernel.org/git/CACsJy8BcBk6Fsfy7o1aBTQAPeH-w+rBwLZrzw4jJ-OM_jhkxMQ@mail.gmail.com/
>   mentioned `update_if_able` and "gap" between read and lock, mitigated
>   in patch 1 with the `index->initialized` check.
>
> Jun Wu (2):
>   repository: add core.indexLockTimeout
>   commit: lock index before reading
>
>  Documentation/config/core.adoc |  6 ++++++
>  builtin/commit.c               |  9 ++-------
>  repository.c                   | 17 +++++++++++++++-
>  t/meson.build                  |  1 +
>  t/t0031-lockfile-pid.sh        |  4 ++++
>  t/t0032-index-lock-timeout.sh  | 37 ++++++++++++++++++++++++++++++++++
>  t/t7400-submodule-basic.sh     |  1 +
>  7 files changed, 67 insertions(+), 8 deletions(-)
>  create mode 100755 t/t0032-index-lock-timeout.sh
>
>
> base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
