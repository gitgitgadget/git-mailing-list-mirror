Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09CA378D96
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408623; cv=none; b=lxYzUVrtR2oyYf2nkCA3lxwfYTiCN8RiiuhGL+aKj9uMJzbXl2Abb8ely5PN79D0wNCkRbqmkWfNltNOUBYwGnOMt5ExXAvn7w2AzBU/mE+E/9DgPQL/C+81AdDwU0tHTbDh3gGV5MP3842iyVyKR1VzTg4SauJIlHdeJARxQyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408623; c=relaxed/simple;
	bh=rarWuSzh+kRjkTgmXR5Bv7L2nxt77B/jTCs8VW4LOZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bs+WpMsZ97Qxgr6kZnim/evIjWf6L21F5AlkdMn0gFjCg6vApsQ796Frio2vKqdnmS3O9KaIdtlYBJun2CAdGD7gq9e1cc5B+ZcmEuIq9hwh+kjbPjMrRXEyot3VQ9InG8NOwmr3uiNorB+jAhKlMGMdzbRiVTNuOF2lNSprCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=USdaTXak; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OcqJAGJW; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="USdaTXak";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OcqJAGJW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2490E7A0032;
	Tue,  2 Jun 2026 09:57:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 09:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780408622; x=1780495022; bh=EvVVeo/hIy
	1MrFMeAgilMtxIlzUQ8oHEXWA2+nIp7kk=; b=USdaTXakxezKjqxaEWtpT8V8u4
	TrVpqWgbySpR0Y8CQbvZZBG9bE2A1i22S7nrHzL9ie9Sy3QGaO3dE2gR0ckS2vd9
	k0IKifp5BjtNLbgihZxpeDbnSHrRc+d1J2LxrYuWuNIz38fGTwT791ptAXJ5v3ix
	ED3yLdC1tCPXySLblt8OLa7oxbLHaaP4MVhYHi6CUV519BXwJcZMbrn5tQs5REfp
	Rlot5FnIxXQOtka6e0WKLejOsig+9RY6t9n/hmIXELEk3uxLYje91zMoY4KH2js9
	VH56VLED5EfVFiDnp9bKgkk/4G78+mi+51oCBZ7RZ5Y8riZ9vmVCSJjiW+2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780408622; x=1780495022; bh=EvVVeo/hIy1MrFMeAgilMtxIlzUQ8oHEXWA
	2+nIp7kk=; b=OcqJAGJWXZt49YAVvz63N7ku/nKc2v00/0BY8zqDqyEf9n8M2sz
	aYjXiN9PbNn90QVALh7P24gI78bQ3zXOh/D8a8dYi9cFTtQCR4dU3Oy9lgw0LcAr
	ZgrSaFvhWXtHDO422Nh3hfLEYnMnATYvFIDTdPyKdRl6SUB9YxUfgrio7gOsUJxG
	k/bdSYv4B8VpRTy9xKb4df6nxw5y9wnB/GVozqx1ZpuzQgVXmKhpcSia5/L9PjpW
	jJXuCRp+EZYeT+x9hJJD8o6BP8DdswjGYZTnqMv/IJE0NZ1+XphXQc8sJpbXbi0G
	/kukK1P9aALs7wRDL1tZKCOSsbo4Haulvgg==
X-ME-Sender: <xms:LeEealsmdRBIzxXFDJ_Dck9vMLr1wk0dHMNnO_mSCnLnpvP9rJCkyQ>
    <xme:LeEeal4ODTpYQ7Eq0LsVyt6HBFBs3ehb-Qt6he2KIK18JNvuIfyziI45FuvgqSGZX
    2Z1SSBQ2PRMECIQU3M4FS6XAkUcATSb1KxPXMr9awZR-4Hww-htEyU>
X-ME-Received: <xmr:LeEeamKanWnN1vRHKc1X8JXNPr-SxY5PnvojC3M5N04NlZZ4OHcg983THSHKdkuy5QceIdHKAPE4zhIr9zOXSSKCqovLB-SP6aYc>
X-ME-Proxy-Cause: dmFkZTGkvze+Rou+Het1E/szF1BUU1cFA3nXYfijOlQtem2n32PBLbv2ATzVu4orKaiLPf
    wcvXNU2qGqds3Mo5hod06teoWLejVbwiagpcwPt1RgS6qfcV1hXmy9mMbcNo1yePT7kg7v
    9yUgiz9wAFxdd2VNRLgKCvcQcCCYzg71RUWbXSk1YR+lUEVf80SCks5GiKnqkxOqMBzQDf
    Pw9LLqLjQWNqJ3BXQPVz7XjNpKaGC+OteJ+VtLJ63q+cAb5kQQEmMpWDYGXeMIY/ROACXz
    zh2kYiX9QQb1B3FMiHx4G2ZeFC7BNSwPMpR/OumD7HKN51/J6LotwN1y99Pxhyxlh+dAlQ
    HzUSdfmN/FC1PTqHRpzOlrJvt3yyiG0fQqLSBA5cdminN/8gItOPano0B1R/27Aj9Ouacq
    fVMAGEK6zU2Qr+ntgCKg4A5XHe0SjVnYjLNIwVd3gNk52MMYUFMS+6Ve842CSS5IZpyfGt
    Ze94tm2dJhRBGb2XpnZbHn49BDB2IrlQodMmfS4etNywFRtsD+51DuVLy3M4beO/BqAC0E
    KOivlM21daUNVHPYbXbtg9sBMhxsnq+GJQ2xOvnUsXTulfl6pYAgJkxjmZ41FyV15sTC7r
    KtgfmpsSWtN4GMDWUuqrytxM9DW27hguyfxLL0p4e2NzJyGUYUgcnLhPCnhw
X-ME-Proxy: <xmx:LeEeal5L8cfJWT8qVpdnIY5byR2nH8EJQ9NpeXWUW2ECCeRJmKZ86A>
    <xmx:LeEeapwGfVTW6ty2zrsPlNoxUawUy26MIryHAJZNBupB-cI5f7yVOA>
    <xmx:LeEeapZ5jbdMCWCeRKbycg8t_boKw7v6fHNbqtT0yqvalLvK7UooNw>
    <xmx:LeEearSSlNpNPQtKfHUs177pJfhgqJgSthj719dKkvLbtHJ3ZccNEg>
    <xmx:LuEeah4amzQbZGnLfbYVcXLxfPU8AseTlDwRtDPfu-h9_lUgKPPtvFhO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 09:57:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] doc: fix typos via codespell
In-Reply-To: <20260602111552.6084-1-algonell@gmail.com> (Andrew Kreimer's
	message of "Tue, 2 Jun 2026 14:15:18 +0300")
References: <20260506101631.18127-1-algonell@gmail.com>
	<20260602111552.6084-1-algonell@gmail.com>
Date: Tue, 02 Jun 2026 22:57:00 +0900
Message-ID: <xmqqzf1dujtf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Kreimer <algonell@gmail.com> writes:

> There are some typos in the documentation, comments, etc.
> Fix them via codespell.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
> v3:
>   - Address test breaking changes (strings bounded by single quotes).
>   - Thank you for your patience (extreme noise/gain ratio).

Thanks, but this is wrong.
>
>  t/t1700-split-index.sh         | 2 +-
>  t/t3909-stash-pathspec-file.sh | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)


[v3] should not be "on top of" [v2], but the above shows that
apparently this is vastly different from [v2], which had

 Documentation/SubmittingPatches            |  2 +-
 Documentation/git-sparse-checkout.adoc     |  2 +-
 Documentation/technical/build-systems.adoc |  6 +++---
 builtin/pack-objects.c                     |  2 +-
 commit-graph.h                             |  2 +-
 compat/precompose_utf8.c                   |  2 +-
 hook.h                                     |  2 +-
 meson_options.txt                          |  2 +-
 midx-write.c                               |  2 +-
 odb/source.h                               |  2 +-
 packfile.h                                 |  2 +-
 path.h                                     |  2 +-
 reftable/system.h                          |  2 +-
 t/README                                   |  2 +-
 t/chainlint.pl                             |  2 +-
 t/chainlint/chain-break-false.expect       |  2 +-
 t/chainlint/chain-break-false.test         |  2 +-
 t/t1700-split-index.sh                     |  2 +-
 t/t3909-stash-pathspec-file.sh             |  6 +++---
 t/t4052-stat-output.sh                     |  2 +-
 t/t4067-diff-partial-clone.sh              |  2 +-
 t/t9150/svk-merge.dump                     | 10 +++++-----
 t/t9151/svn-mergeinfo.dump                 | 18 +++++++++---------
 t/unit-tests/clar/README.md                |  2 +-
 24 files changed, 40 insertions(+), 40 deletions(-)

Until the topic is merged to 'next', a new iteration of patch(es)
should cleanly apply to the base that [v2] was meant to apply, but
should pretend as if [v2] never existed.

> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index 869fb4a14e..887e72a5fa 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -502,7 +502,7 @@ test_expect_success 'do not refresh null base index' '
>  		git checkout main &&
>  		git update-index --split-index &&
>  		test_commit more &&
> -		# must not write a new shareindex, or we won't catch the problem
> +		# must not write a new shareindex, or we will not catch the problem

The committed code never had "we won't" (what was in 'seen' does not
count), and this patch clearly shows that this is to fix-up the
breakage the previous round caused.  We do not want that.

I'll squash the fix-up I already had into [v2] that I have queued,
which should be sufficient to get to the state this [v3] should have
been, I think.

Thanks.
