Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F9417736
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712208868; cv=none; b=qCdyBf1S3PBKqnzaeSgRPcRh8VbklkG0ubWFVKTqBOYMaBgkk3jKvFJaYOnaVN4+VvK1rW9F9w71EMqGELKb0yarSHrXDY9kSOBHNCXIyHBRU5MJBbjf+LPzlF+CAMtvJt+swAQ46exRA7fMRdK+49Wvyh3gKx9R0LTg4CkOvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712208868; c=relaxed/simple;
	bh=QnkOQtv3buPlF5KFvB5WcSoXDbMKM3jto1Py1pscXLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMSm3aa1dIn74iZg0z2FKjhQUW6C7KuASVtpekbgXzh6ytUnsSb4m3OzmSmBjZJdJVBM6GO5jRbbNilBdy2DYAV7BpgXv6ySnRkjvgpP9WKQKsQ8odjbSntuJ+M/ZSU8Hn1KCd4WID37yEeRU5hu3fuH89RgGZ0V1w110NPwy4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZkhCU/29; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UyZbBnYL; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZkhCU/29";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UyZbBnYL"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6C1091380154;
	Thu,  4 Apr 2024 01:34:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 04 Apr 2024 01:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712208864; x=1712295264; bh=CyWCT4hsn4
	dZoETKjnqn/lJD4HjNc7g6REYVNuuQTRs=; b=ZkhCU/29LJnufZV0Hv8hswdMtY
	7n9Bhkd5b7okx82fz8CNjkBELHj7woN0nI7St3YRG0jgUIKEilF334d8w71/EO2o
	S2YV5bUS5tSFQLw9aB33637akWsV85fOMiymJe+dby4ImMZyrCtFyh12cjS9wqS3
	w9DcyTaOUHaNjHhUpEdr7YeS0yQh3a5PaWOUQCs9jnj7/6dWgk/7g2lbs2jqTzJt
	DX9EPXA6hAWuevZLF7WG39Ye7siq5Squ5wnwpGB8tW+tbFNqLb8vYkt6EGgNuaTE
	2isxQYJClAKYpwSOWbtSL7XjsY9t81AhlJCoFbcFiVaiI4k3sXmEvpcjrJIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712208864; x=1712295264; bh=CyWCT4hsn4dZoETKjnqn/lJD4HjN
	c7g6REYVNuuQTRs=; b=UyZbBnYLkEj8v03b1u5t3sjq+fUImcWrZa00MSj6E1di
	2QnqaKek8VTrUrTP5xLzo9VA2DVbvwsGhupDHhz9PwmNaoODtaZZYnAqU8+haK+D
	2XfzNlu+bdajefIcDnaVhiSZjVJ0q/6HkROl+Fyl8Akt8T5TeaXBu5oWD1O33HQx
	1BQ7kDnewBDsGmFUxlfdL/uY3dV3+ft/xnb/VelcEhszcuCSSgRav/AwYHv1TSb9
	3irE41iKYPproCZQ/eihVjfxnRPSvKt8r9ae573ESxlNdqLHrf9q1ngO3zTyNXOl
	brmSCPoNHA8ly1pz4qzYrB3JE8t5GDavPcbMo+wGOA==
X-ME-Sender: <xms:4DsOZtDlDwnV47d2n9aIpLwR9ZrqPfFp_6Yc4ScMwlHQBdgMia-PJQ>
    <xme:4DsOZrjV86cwc2XjPUEFXNKCsGxr48o8ZpyhPdfvyoXupr1vWE7MYI4X3YQo8I0Tk
    h6BaJw-TW04K2i3bw>
X-ME-Received: <xmr:4DsOZomn1SF7cIvSTFo5GQO6AhlZEK5kn5io-HPsNt5V2nK-liBq30JQW_-jtaSeG6f-BwFY4WKiXrcxeHoU0J4PoaS71TNHXBjiTsMCbxjbiuOH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:4DsOZnzXrOGeM4WArIieiB0iAZJ8eptfNz3sp6hBa4G3nIP6kq-eJw>
    <xmx:4DsOZiTsxMoi4wmjEWDCmiIS-fobKYJG8cFvJNVclvdWRv7YeYL_3w>
    <xmx:4DsOZqZ_F6xVFwxNjjgCHS5V8uw49a9SMCSZLuvfu1Uay-2IiZwqDQ>
    <xmx:4DsOZjQPVnYGUtRN3B-LdwBp13mCmMon6PgyyWH6LjQOtmww6pY50A>
    <xmx:4DsOZvJv4d0V8__iLb2Q2Wk_K7uUTR8MPs5IuFqF5BFac7yDhFuXXHSX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:34:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4c184bea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:34:18 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:34:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/3] reftable/stack: use geometric table compaction
Message-ID: <Zg472uByuW6domfh@tanuki>
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
 <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
 <xmqq5xwy6z1b.fsf@gitster.g>
 <Zg2uS5JXjQZsVZhJ@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DkPkF2IoqoCjUA9U"
Content-Disposition: inline
In-Reply-To: <Zg2uS5JXjQZsVZhJ@framework>


--DkPkF2IoqoCjUA9U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 09:30:19PM +0200, Patrick Steinhardt wrote:
> On Wed, Apr 03, 2024 at 12:12:32PM -0700, Junio C Hamano wrote:
> > "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >=20
> > > This is the second version my patch series that refactors the reftable
> > > compaction strategy to instead follow a geometric sequence. Changes c=
ompared
> > > to v1:
> > >
> > >  * Added GIT_TEST_REFTABLE_NO_AUTOCOMPACTION environment variable to =
disable
> > >    reftable compaction when testing.
> > >  * Refactored worktree tests in t0610-reftable-basics.sh to properly =
assert
> > >    git-pack-refs(1) works as expected.
> > >  * Added test to validate that alternating table sizes are compacted.
> > >  * Added benchmark to compare compaction strategies.
> > >  * Moved change that made compaction segment end inclusive to its own
> > >    commit.
> > >  * Added additional explanation in commits and comments and fixed typ=
os.
> >=20
> > Has anybody took a look at recent failures with this series present
> > in 'seen' [*1*] and without [*2*] in osx-reftable jobs for t0610?
> >=20
> > *1* https://github.com/git/git/actions/runs/8543205866/job/23406512990
> > *2* https://github.com/git/git/actions/runs/8543840764/job/23408543876
>=20
> I noticed that both `seen` and `next` started to fail in the GitLab
> mirror today. Unless somebody else beats me to it I'll investigate
> tomorrow what causes these.

Things work on GitLab CI again, all pipelines are green there now. Which
probably also is because you have evicted this series from "seen". On
GitHub most of the failures I see are still related to the regression in
libcurl.

But your first link definitely is specific to the changes in this patch
series and comes from a bad interaction with "ps/pack-refs-auto". That
series added a few tests where the exact number of tables that exist is
now different.

Justin wanted to make that series a dependency anyway, so I assume that
he'll then address those issues.

Patrick

--DkPkF2IoqoCjUA9U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOO9kACgkQVbJhu7ck
PpQDIg/+M9iyREJVssFvivABWrGchy74jHHX/YqbpLzttVhaN2Q+2YxeaKF+Rbri
WCsaoEEkHYIu0GPQag1eUSkWahEqVuqqg0RhtJ7nUFPtnub4sRho3TE+xzeYdeAB
yHacl2ndF5i37vZo4GbRcyokLkIqwWLyP9g15PqoqEOeXE38DMijok6E2jKc6jHJ
TXamcCM6biCGNSx88b6/TFBxomxwf8aExyyihAllNKwQbvrazV486q/gVDxVKhW4
QoWql4+AVV8nlBI4m1OrT6tgIK8AaIHMUxdeXNAO3Lt40EuOQpF34WWO/BkYkKDZ
3vcX89UY786OmQmnVBkdqspzlEIp4CHRG83X8qHf7sx2lU21qju3gI5r8SlDcgJ3
ejGsZOB6bR677O24E2ZOgzY+5M4kUlzSp+RamnexTL8Ba+vTRwNALOzrmN0m/6w1
2GUNYMwwcxQzBcqegHvoDzaAUxv2rQxw6QLNForxYBRAkqhTtSWQ8v3RTMJGFAnq
QihbC2ba1WE5+X2DcUTCBM783+Y2VNAQDM/3ibpkyW7vkw3hdzhUxQDMqVy6gdp6
nZgRn4XdwgFxBbfEwq4Gz9C5KVHDEmohm3/2mdUp/fJVQl1Q959prQyeNhe24358
KLByGQT0kspnL4AiNfom9lQPEHwokkemQsELvcaUsVvhwocAhjo=
=dxcA
-----END PGP SIGNATURE-----

--DkPkF2IoqoCjUA9U--
