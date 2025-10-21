Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC3526FA60
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079728; cv=none; b=W2+t6ue/Pt3gd98zgBvQAkM4E16ss6y2HgWKNibfSWg32mU4mZ84jeWyMoycCjw8eJ+Mf7e9XRQMRJDidaCiA1zrYXbG3Ea39wqziKqNzaw8RHXyzqHm7IvqNGZFOa9pQOAmIzlnqGm93Bp4d1loTZUTWn/Niu3vhTr19kHhHM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079728; c=relaxed/simple;
	bh=b8ZlhPKNRg6b4z5hrHlOERAcDIuNz8C44Q2uBSKDyII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JeyYUdhDo738r2emBVkoIsCpXRh7ZmQrQzKUwBPPcYDGu52yYPKQDnQNPDXwhyBMxahsgqtDGgyK1/CUHrRI+MW/iWWFjEXC3jHTDWGCG/bP9S2lKRfbM0OiKsDnhhW7hMNu+Cj2I5cepPdPjNi/ttNFx5TBW0yM7CLh8Onp1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LTwbWtHt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kzr4SX5G; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LTwbWtHt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kzr4SX5G"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D06B1D000BF;
	Tue, 21 Oct 2025 16:48:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 16:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761079725; x=1761166125; bh=gyYpGsuJ88
	+RSgivpx7LAjWe9WmfacMR1GR3NBT3cJ0=; b=LTwbWtHtNWnl6UxwxtXjGDR4W0
	CxCZfSQ+0YrXRFydQ4GC9XEjrDOqVyxQslEIcmi00HBoJP1lbNz/bZGAenvdg+99
	c3mG+tUgOav6doMUZJvUwbNbHxd+evsAzW7j2FZJzpmBcEGi2gRio0ot6ZOY52tm
	sQ1PDJsYsRT0fItYQSibtRfU9fbhnPyNZfiZZfHUY0y72zXWCoqlF8vwYXfGp9/e
	68sAk51i41kZzI/9Ek1lI59Da8qUbaPX4RaEbevR/baRawZh+vnKK2SRjbzymhB6
	XspFHOF5eJXpAzcn63rTlFqxA36Fsdt7+oOgVd7mTiffWaqKXY9uDLJZncZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761079725; x=1761166125; bh=gyYpGsuJ88+RSgivpx7LAjWe9WmfacMR1GR
	3NBT3cJ0=; b=Kzr4SX5Gw+uY8lhVVELdQvXgCie4KGWVDxcNasaov94CGv4z1ai
	3Mip1R/OEeKaApkkAcYNPGorjCTJhQDWsw3wFmnVmAybBv/GRH+9aEqgv44WoFGf
	uxKCZMLP4FFkIywqsoC+tqMrm9eNxPxWl1ILBKcOq5NkjyJoG7Hav2dFPXajTtho
	UAlmp4ErN+3xEboqg7pEjZk1jb/XRggYp6nSs8PblWksqA/nDlvn2LbuRboOEyOS
	HkERFp8YYwS3/EQrkT5KYtXVvaZdajGuZ5DbGKafbjYnzt6GiorU6cwGZsowdtYm
	EV10xkrHqfk//SUPlcUGLS9Wztkr214ArvQ==
X-ME-Sender: <xms:rPH3aGPSmhY6p9RufH03O8GHwSpQhWEsEzZouo6o7NZ4F1Nlp5yTuA>
    <xme:rPH3aBhtAP4dTcopAkW7HJJBilnUcv78micSt1iULmK5ZqTgROeSf74qBBsPjCUl6
    -ZoYZT7bLFKFGoXeiYgXl0poQJKmN6s57XfWeF7gcexYiJDmMdCZw>
X-ME-Received: <xmr:rPH3aBs8-F1I4wayb-PlEwcd1USpDUrBV9UG3nI0NW6LtnUUHS9blx7nJ2hWOeop-t-7x3Yp5FSTYKN70Ja1YSZKgfCSMB_XiKQd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehmrghr
    thhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:rPH3aNjaCgxTdDiwgr2paOSrA2zpiEjL1-bfvLMaFTmCRgY_c__QcA>
    <xmx:rPH3aPYVe0ySVVaTrAbW1TM7KEzZk5txkaZMX44a1tFP_OwZzcnEzA>
    <xmx:rPH3aEbV7ZG8EyR-DUptz0XOUGIBUnIv3OSQuwO4-w-wDZUBsGzuAA>
    <xmx:rPH3aMwbKbRy-ppK3_M12UP7fYGGMXFouEb2vEgXF6u8yo0jbhMFoA>
    <xmx:rfH3aJc3s_tr6chkj3Sg1gx6ErbVC0CNnuLp-ywnXmFPYzvOSkgiTvrE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 16:48:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Elijah Newren <newren@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 03/12] replay: stop using `the_repository`
In-Reply-To: <20251021-b4-pks-history-builtin-v5-3-78d23f578fe6@pks.im>
	(Patrick Steinhardt's message of "Tue, 21 Oct 2025 16:15:51 +0200")
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
	<20251021-b4-pks-history-builtin-v5-3-78d23f578fe6@pks.im>
Date: Tue, 21 Oct 2025 13:48:43 -0700
Message-ID: <xmqqzf9kt1zo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In `create_commit()` we're using `the_repository` even though we already
> have a repository passed to use as an argument. Fix this.
>
> Note that we still cannot get rid of `USE_THE_REPOSITORY_VARIABLE`. This
> is because we use `DEFAULT_ABBREV and `get_commit_output_encoding()`,
> both of which are stored as global variables that can be modified via
> the Git configuration.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  replay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Obviously correct.

>
> diff --git a/replay.c b/replay.c
> index e22ce399406..13d75d80543 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -62,7 +62,7 @@ static struct commit *create_commit(struct repository *repo,
>  	obj = parse_object(repo, &ret);
>  
>  out:
> -	repo_unuse_commit_buffer(the_repository, based_on, message);
> +	repo_unuse_commit_buffer(repo, based_on, message);
>  	free_commit_extra_headers(extra);
>  	free_commit_list(parents);
>  	strbuf_release(&msg);
