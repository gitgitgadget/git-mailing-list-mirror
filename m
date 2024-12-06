Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE78146426
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484070; cv=none; b=B416yqBeGpymggOuDUfcMvcf1cvJsq0ZoEKjcwrNqYYuKlVso57sUQq2oYu/P9h/oi69Mg8zGGbVRiOHOUeZXtFlse/hfj30tinkl3L1Wdl2LSp0BMFFaGxEEDYC9UejvOF7u+L0RKTB/vgzBtVFMBSeOnWxXQgmAGF+TGxqBBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484070; c=relaxed/simple;
	bh=oAUQWy6AJBJL1AKTTwC6d855dms8KjIGYBE/krBiYY8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rYtycYyfyLbOOlpjCJ5kW2r6I323cgRImlyChKrDl20kJJG3vSkjAyQkm+QbXQfPY1nunj0RQrx/9ieIVNYj3y5bEXOKZw6sGRqK4v42Sz0x8blVpvmHDOl8TIXoO5nAz7xQ76D5M0A7t4wUKnBwGjQ61osJlvQ5NbnWMDEkH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IoYHE7uR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5SWFsdhz; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IoYHE7uR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5SWFsdhz"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DED05114018D;
	Fri,  6 Dec 2024 06:21:06 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 06:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733484066;
	 x=1733570466; bh=W9wdLPGEv9VOr7qrmh8pSAQS/rx0+T6HhsoES8RXr3w=; b=
	IoYHE7uRHAXUIWyHaB5TbWFKx3FWPAVNj2IiqVEAkbdzm51cfMZAt4CS6mZdKuBU
	WbrmtYZtXeN66kpYGtCEy3kJVtl9XV1KiimVDijJ61ws/uLLMN1pvP10ZvNolicR
	WmUtmTtMDl8o063g2//9MmkqFQLFJgA2V60mEbmtTtUdCxto90TUyR8onwG/6dyi
	28MUrGn7R8Aa++7Lmd+Tffh3a8Zn6wR71QhzGzFVdmGie6LIAyOeK3C6dh3jVpdc
	2G/A8uL0bj2SdzIN+L/6NMs3KK7YC1YeD1b5C5UvMEieZeRIEjaWBHiH2KBwdW9A
	KStV8fP7H5tGU6/LQEg1/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733484066; x=
	1733570466; bh=W9wdLPGEv9VOr7qrmh8pSAQS/rx0+T6HhsoES8RXr3w=; b=5
	SWFsdhz/P5yP816UdSX2r+9821jA5n2WyYuS4enHme10RLXsHNXAmM6uDzV5Knrt
	/Xq+dt/HhSt/wtCrowvV4tSAU5TgjoxmWK/rG+yLhyo5MpMH3P5iI2JhkDLea/Ck
	khFTIg27JeLS46LCZudTHQL9R8wG4nc9yIZIklCk+9dXU4+lnr0MU87CLsu8cVQJ
	BBLfD4+yvJ98uGlvxQ7ik21e4R8G2ftDQJ434m3gqZQ90yNzQJoyDgCz5Y4VMzO3
	KV4pdbcZzcHoS+8eqPGrKwpvbdpqu8xgXEn1YpHoaOSzkMPNP1hHlZSYAmBs6lhA
	GVM3ETf+M1qglzWC3xR2A==
X-ME-Sender: <xms:It5SZw0MX7QKFrKXRA6gsrPRfO-E_Nh9WqCtyZ_CvGwMn1rFwoF_tBw>
    <xme:It5SZ7HrPdvL7rFY9X0bUmS8uRmE8NNJspCeiwVbl6KsZ3cwAv2mx2g-357_Adlo8
    8MKCnkQwlnbW3GkIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeehudfgvefgfefgffdvhfffvdevveegheehudetvdfgueffjeevjedugeevfe
    dvfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopegrrghrnhhisehvrghlohhhrghirdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:It5SZ464qrdtTSjyDxhgy_VqPue5vsb0jamhCYTpZb7qzwTp_m9YIw>
    <xmx:It5SZ52USyE06FjfaXn2hRjEB_dkeD7SmaJlk3VJ-krTAyggVII6eQ>
    <xmx:It5SZzEZs3f72ccskmUroyDMlYq9C-iqLXBsW8O4Yaa_mItR74JiBA>
    <xmx:It5SZy9c9hfkomBmp7bcup8-u2wcm3w93FVtmDU-mPxRPxfBThgsQg>
    <xmx:It5SZ7B4doPGeeZCdGyrVyQXZKSu-itQqlPHkkSRgRMqlRySVpfzkh3v>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 791EB780068; Fri,  6 Dec 2024 06:21:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 12:20:45 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Aarni Koskela" <aarni@valohai.com>, "Jeff King" <peff@peff.net>
Message-Id: <9c7b9090-8cf2-4095-8e86-2c85b6fe407f@app.fastmail.com>
In-Reply-To: 
 <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
References: 
 <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
Subject: Re: [PATCH] object-name: fix reversed ordering with magic pathspecs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Dec 6, 2024, at 10:51, Patrick Steinhardt wrote:
> It was reported

It would be nice with a hyperlink since this email is not part of the
email thread for the report.

https://lore.kernel.org/git/Z1LJSADiStlFicTL@pks.im/T/#mae906ec74d5657e7=
02165e29b90927f730280c29

> It was reported that magic pathspecs started to return results in

I=E2=80=99m not used to this being called =E2=80=9Cmagic pathspecs=E2=80=
=9D as a user.
gitglossary(7) talks about (magic) pathspecs as filepaths.

(c.f. gitrevisions(7) where this revision selection syntax
is discussed.)

> reverse recency order starting with Git v2.47.0. This behaviour bisects
> to 57fb139b5e (object-name: fix leaking commit list items, 2024-08-01),

Nit: Can it be simply be asserted that it is caused by that commit?
Because that would make for a simpler/more assertive narrative.

=E2=80=9CThis bisects to=E2=80=9D can be a nice phrase when it is follow=
ed by a =E2=80=9Cbut=E2=80=9D
subclause,[1] i.e. when the straightforward troubleshooting can turn up
misleading leads.

=E2=80=A0 1: 615d2de3b45 (config.c: avoid segfault with --fixed-value an=
d valueless
    config, 2024-08-01)

> which has refactored `get_oid_oneline()` to plug a couple of memory
> leaks.
>
> As part of that refactoring we have started to create a copy of the
> passed-in list of commits and work on that list instead. The intent of
> this was to stop modifying the caller-provided commit list such that t=
he

Nit: s/The intent of this was/The intent was/

> caller can properly free all commit list items, including those that we
> might potentially drop.
>
> We already knew to create such a copy beforehand with the `backup` lis=
t,
> which was used to clear the `ONELINE_SEEN` commit mark after we were
> done. So the refactoring simply renamed that list to `copy` and started
> to operate on that list instead. There is a gotcha though: the backup
> list, and thus now also the copied list, is always being prepended to,
> so the resulting list is in reverse order! The end result is that we
> pop commits from the wrong end of the commit list, returning commits in
> reverse recency order.

Nice explanation.

>
> Fix the bug by appending to the list instead.
>
> Reported-by: Aarni Koskela <aarni@valohai.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> [snip]
> diff --git a/t/t4208-log-magic-pathspec.sh
> b/t/t4208-log-magic-pathspec.sh

Yes, so here is that magic pathspec name.  But this test file has a lot
of tests that test positional argument ambiguity.  Which seems very
relevant to pathspecs in particular.  And revision selection syntax
seems to be used to test how things are interpreted.  Not really how
things are ultimately processed (that seems secondary).

The tests involving `:/` in particular seem to only be about
ambiguity testing.

Is this the correct test file?

> index
> 2a46eb6bedbe283a08fd77917b7fb17da155b027..2d80b9044bcf9ec8e2f11b6afd2b=
0fe8e2fcabfd
> 100755
> --- a/t/t4208-log-magic-pathspec.sh
> +++ b/t/t4208-log-magic-pathspec.sh
> @@ -58,6 +58,19 @@ test_expect_success '"git log :/any/path/" should
> not segfault' '
>  	test_must_fail git log :/any/path/
>  '
>
> +test_expect_success ':/ favors more recent matching commits' '

This wasn=E2=80=99t mentioned in the report but `HEAD^{/}` is a similar =
syntax.
That one is more controllable since you provide a ref yourself
(`:/` returns the youngest commit from any ref).

I have indeed noticed that `HEAD^{/}` returns a sensible thing while
`:/` does something strange like finding the root commit.  (Then I
shrugged and half-assumed that I hadn=E2=80=99t read some fine print)

gitrevisions(7) calls out the relation between these two. It could be
nice for a regression test to assert that these two syntaxes return the
same commit. I.e. when you have just made a commit, `:/<search>` and
`HEAD^{/<search>}` return the same commit, and that commit is
the youngest.

> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit common-old &&
> +		test_commit --no-tag common-new &&
> +		git rev-parse HEAD >expect &&
> +		git rev-parse :/common >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  # This differs from the ":/a" check above in that :/in looks like a p=
athspec,
>  # but doesn't match an actual file.
>  test_expect_success '"git log :/in" should not be ambiguous' '
>
> ---
> base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
> change-id: 20241206-pks-rev-parse-fix-reversed-list-0f94a20a6165
