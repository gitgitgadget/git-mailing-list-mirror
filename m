Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F41E32A2
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764336903; cv=none; b=SGggwJlIX7doilDQAXw49Ce1kYMHvGD7m1qyISh9aMXu/4vLg1R5o1Zym0Ot41ZiIA42Jo+Kdf4qo9BN4rymtChGo5/p9mwcGEs+rBpI8DY17UepRiC2eDlYiR1GDjuo3DCn1KQj3ZoLpdJp9LHu6ylHrV4N7FdWrFSJNaSoFx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764336903; c=relaxed/simple;
	bh=FKoXe84dBF5zh2o6xrqgoKbGm1D3MqgQblsFSQqxxGY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mKIAEiOLq8jQzFhPKnNOTxhHYVIRBRU4kn3NA8xJzOGjtRlftGREFcbDGX1qpoLf4X9oVYLO5wauygp6fU3UkQ5HSyPeB1ESDcrXm3s5FuHbrx34vYQQyLGGZG/DP6Sobq7SMi4Ourh969iEWxvD8J6pJqULvX7b0VeAX9xqK5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bC+wI7Nn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UW8Wk300; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bC+wI7Nn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UW8Wk300"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D1F917A0569;
	Fri, 28 Nov 2025 08:35:00 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 28 Nov 2025 08:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764336900;
	 x=1764423300; bh=osZiPv5yocU6h/Up5TlELxiEcdq1k1wzebCAUhsQs0Y=; b=
	bC+wI7NnmXDbycCFtdAyfag3fZ/fo/zOamgtPkmlLWQqrQRQe6EVVPSkfO29jKVO
	AF3ZGRcrOmWfrPEZcwBdkoV3wOD/TQnaIEoaz5EFv909LwusfNhyrL5nI48ulBCs
	gwgVf46ipDkKFiVGu3C/Dz15JgzQC/RgEFP55YYy53PfUTBlGyotFBN/wiS9mr5l
	AMiVLjJDBWZKhtJBspo2QOpmXrNbE4/Ui98iWppVsObF4uYbjZ9DEDi4aZT38A0f
	1xrTgAa+VaMrQUg5GrHXekBWMzKUyg0YoPwCymcFXs6vmRT8lnBMwDvBskQmUt8S
	+xCT6PJhs2fIInUnxTVjbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764336900; x=
	1764423300; bh=osZiPv5yocU6h/Up5TlELxiEcdq1k1wzebCAUhsQs0Y=; b=U
	W8Wk300GFDMzBDVx3/0WsLMMZCB9GTYcyl+L1AqJzGEtzsyRV2aSAh4OZVnKCmtg
	M06v8/FT9ovsE5/o+7N4zNre/IodnyD5yauRKysy8ayTTSdEx5Rnl4I4TEzHzMh1
	nM1++6vzteH2iu2lqMnpIarizLgDMIrfTTqsGcjsvNTHAzrBrDoQvLOw3EXVxQSy
	yUeqUpxumdHeahJx5orksdMD16i5gRWTqs9YXv/YOH3WAghYXhC4k1f2JHPN8YR7
	sQVnpgFATlSA1hFVKmm2z0U8ceT+b8GrkA79BnkJ2DaQeEhBAhUTFDCk6Yh+MI/D
	jv7mrw6lUkBbaYyqh8EnA==
X-ME-Sender: <xms:BKUpacWsrUWFkkszPlnNO9Jr4GRSTkREi3WLOdQVvRlV7vDPt-PTexU>
    <xme:BKUpabZhVqs6dp1QlUh8z_x0DAQppSmIP6R52fsjd7MrMt24O-AaxCuImR00wgLCX
    d558j8g4ufLrlJEi7RumX2Qb6aqGOFVZXky-2IVvyAkgLY0Jy_7kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedttdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepleefjedujeff
    gfeludehgeehueeffeeftdfgfeefveduueelffegkedtleeukeeinecuffhomhgrihhnpe
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvg
    hfrghnrhhivggthhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BKUpaTTdFwJEJ8ey5ynDt2EaeYAxBY0qvQE2V2ZCKGt_QK0KNUFMUg>
    <xmx:BKUpachqoEG_zT0B9hj-v53H6FUoohtg7GWo-y9TDUM2bk9C1lh2Hg>
    <xmx:BKUpab6i_luCFa2tPaOZaRyK8-r3hG1plKg5Xth2yBdLDXXWlwGplQ>
    <xmx:BKUpaRCAW8erAZaCs4aiOmzVyVJ4waYB1EOgTnA4OrOw7JLuDVAkPg>
    <xmx:BKUpaRRZunNZe7RJKeEm_hnpmzcF5WXzqJmWeSvuLahpgFKyzUGni3gM>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5ED651EA0068; Fri, 28 Nov 2025 08:35:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AB3l5Xj7q0AR
Date: Fri, 28 Nov 2025 14:34:39 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Stefan Rieche" <stefanrieche@gmail.com>
Message-Id: <f66c3b5a-6126-4fec-9c13-e4cdd3043fa0@app.fastmail.com>
In-Reply-To: <pull.2111.git.git.1764335780515.gitgitgadget@gmail.com>
References: <pull.2111.git.git.1764335780515.gitgitgadget@gmail.com>
Subject: Re: [PATCH] docs(git-pull.adoc): fix man page typo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nice fix.

> docs(git-pull.adoc): fix man page typo

Correct, you need an =E2=80=9Carea=E2=80=9D in front of the message. But=
 if you want
something like =E2=80=9Cdocs=E2=80=9D it would be more typical/conventio=
nal with
something like this:

    doc: pull:

or:

    doc: git-pull:

And then for the rest you don=E2=80=99t need =E2=80=9Cman page typo=E2=80=
=9D since we know that
this is a doc already. And =E2=80=9Cman page=E2=80=9D is too specific si=
nce you can make
HTML as well. Maybe:

    fix typo in command

On Fri, Nov 28, 2025, at 14:16, Stefan Rieche via GitGitGadget wrote:
> From: snowdroppe <stefanrieche@gmail.com>
>
> Fix typo in man page from "git --rebase abort"
> to "git rebase --abort"
>
> Signed-off-by: Stefan Rieche <stefanrieche@gmail.com>

The `From:` (author) and signoff line should match. See `real-name` in
`Documentation/SubmittingPatches`. Either a pseudonym or real/preferred
name. But it looks like you want to use your real name.

I see on the PR that you have used `snowdroppe <stefanrieche@gmail.com>`
as the author on the commit. You can change your config for the project
to use the same name and email as the signoff line. Then

    git commit --amend --reset-author

And force push to the branch on the remote.

> ---
>     docs(git-pull.adoc): fix man page typo
>
> Published-As:
> https://github.com/gitgitgadget/git/releases/tag/pr-git-2111%2Fsnowdro=
ppe%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
> pr-git-2111/snowdroppe/master-v1
> Pull-Request: https://github.com/git/git/pull/2111
>
>  Documentation/git-pull.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
> index cd3bbc90e3..d3006359ed 100644
> --- a/Documentation/git-pull.adoc
> +++ b/Documentation/git-pull.adoc
> @@ -38,7 +38,7 @@ or `pull.ff` with your preferred behaviour.
>
>  If there's a merge conflict during the merge or rebase that you don't
>  want to handle, you can safely abort it with `git merge --abort` or `=
git
> ---rebase abort`.
> +rebase --abort`.
>
>  OPTIONS
>  -------
>
> base-commit: b31ab939fe8e3cbe8be48dddd1c6ac0265991f45
> --
> gitgitgadget
