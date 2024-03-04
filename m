Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C405D2574F
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545895; cv=none; b=sxqFgh362CNc+rm6RHtE3WAQoNDibjjQB65BNFtnHB2pYI3k7tL8yL9Af21TVNJ0+7HXdJHDeA4jXZZzpaiKXaY/Oe2j5dTkQ/OyCnuEERUCQK9VLpObC7J1L2dLT/6tHS9SL6XST07J4PwHgtCPiFJW7YwUy0ZxKyIdP9SofjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545895; c=relaxed/simple;
	bh=LqUEDTeB7p2wNAklZ6geD4UNq2O9OUI8+/DAheot4Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huNK57nAx3USLxn2Mrf+sT9i3Xixb4FEDcjdcQkkISq9+Orcivkill7PWr8XLNgZY+7fTpF0VUglLPzrnqCo0iNs72CoyMRdBC7gTD9dwKLvYSXk8JKC4eTeR3akcko+BVEYEjJpP2S9eqjUqvm+QhFs1JZlSS1Tp76sW2qphzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BOI5rpZq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NCXzayey; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BOI5rpZq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NCXzayey"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id C7D961800082;
	Mon,  4 Mar 2024 04:51:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 04:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709545888; x=1709632288; bh=LqUEDTeB7p
	2wNAklZ6geD4UNq2O9OUI8+/DAheot4Lk=; b=BOI5rpZq1BXgvqjcXvcy2FhD3I
	5+jpgHAyN/OkkBevzD6Uzt4nseqgVNVan0Lq/rX4NycKJi1+SNcxaydnOWsGvd59
	zOBT0sr+6k7EU2EjSmSOlNJqn9bW2WKjjcvkyTagA1YgcKvfuaf32CHaxGD7+4Gv
	f2ysQnkz0IccR2xmMuT46YqpUKPM2eiIDc290lUnMthAHSGB9JkQ2jkykGBPBj9F
	MvfOYqMxvUtSNuGAOaZpyJj6Zk2IBn0BbkI3II84rA7BSLheb5BTXmfY4r8R7aMP
	0SeE1uZ490LwcF6auiI2+LYRiKHCKNvbF7NBXEEoLM/tAs0bNVPaL39yW/pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709545888; x=1709632288; bh=LqUEDTeB7p2wNAklZ6geD4UNq2O9
	OUI8+/DAheot4Lk=; b=NCXzayeyE62zN/GWLJpIrn6YnXrXJHSl1BWSquXewkXu
	gr/jRlQfJHgXDM2bjdgcNE4JIE63FDi+q6s+1kHkl8dyRJvrM8hUYb2Elo0uG1QJ
	ptkSki562qxq6TlxnE5tia5ifClCKMEUrJVqRhX4mogTBbJBsF9zFlgBrjCrIlwh
	q0jywUMarDX4B6lKZZXso5/5LdE7OPm/Svt4KGxpuTfb7mizih4w59Z8Yt0j8jN1
	S+T+YphY5I8fnY96K5HlhS/KRM7uGyAIgVVPK+9SLSppuAizpKOjxFOCyGc6r0Gq
	H5U/xYZXSyuLa5KurKvpJI0O2Rn+UnC2f+hnZxOh6A==
X-ME-Sender: <xms:oJnlZekMBM-v00ke48uYw9cUHzQMbsOwDFh-s24VmLatflyQuo5OkQ>
    <xme:oJnlZV3xFAVM-hA8kATqTot1jqrKgCP5IiRKqouWLC5m1qR4OT3ymIEwagrQWMzRv
    kdrp8FWDtm5djhdnQ>
X-ME-Received: <xmr:oJnlZcqq4BmaFD_IOi36I10elRb6L9aHX46ApBjJ4DWZurWvdD2XrqQyL5g9jo-oKjDhIVTC6-r2ALsUESg1FZfRpRozoL5MzqJGT4cecM7Oyyk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdekgeethfetuedthfelvdeufedvgfeile
    evhfdvvdehfeeffeeuvedutddtvedunecuffhomhgrihhnpegurhgrfhhtrdhmugenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:oJnlZSmgNcFyrf6PlY8hTo9hzgRHFZE8VgKX815EunUFDVTMJdjnAQ>
    <xmx:oJnlZc3LyeFXvE_bUFD7B90PVjVt6gM4U0uWuRjlnJXRm7WTC80UYw>
    <xmx:oJnlZZuQ6JeV-PK5pOq3ZDjleXP5EapyQCE5CXWHyq8P4rHXHQ2N-w>
    <xmx:oJnlZaClA_Ug35GJywAY8OmJKTfyz_SjQXDNri_aTkKgbdcHwu4cf6TLLHk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 04:51:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 038d89ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 09:47:00 +0000 (UTC)
Date: Mon, 4 Mar 2024 10:51:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Divyaditya Singh <divyadityasnaruka@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Query about gitignore
Message-ID: <ZeWZmyEcCTZ_u_tq@tanuki>
References: <B7F364DA-27E7-4BDC-93EE-32E6430B6ACE@gmail.com>
 <ZcMYiOxBA-N0NwWT@tanuki>
 <7CEEE27C-6B5D-4DC2-B9EA-549185D7AB5C@gmail.com>
 <A0502A2F-970B-46F3-B216-E82B2258DF3A@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IPXe8j75rh84sgek"
Content-Disposition: inline
In-Reply-To: <A0502A2F-970B-46F3-B216-E82B2258DF3A@gmail.com>


--IPXe8j75rh84sgek
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

adding the Git mailing list back to Cc.

On Thu, Feb 22, 2024 at 06:10:18PM +0530, Divyaditya Singh wrote:
> Hello there, I wish you a wonderful day. It=E2=80=99s been a while since I
> have written to you. I was curious if you had any suggestions or ideas
> for my particular need?=20
>=20
> Thank You
> Divyaditya

sorry for my late reply, but I've been in office only sporadically
during the last two weeks.

My original question for your actual usecase was written with the intent
to trigger other answers on the mailing list from potentially-interested
folks. So kind of trying to gather ideas or alternative solutions from
folks other than myself. Well, that didn't quite work out :)

> > On 07-Feb-2024, at 11:52=E2=80=AFAM, Divyaditya Singh
> > <divyadityasnaruka@gmail.com> wrote:
> >=20
> > Hello Patrick,
> >=20
> > Thank you so much for taking time to respond to my email.
> >=20
> > Yes, I basically want to ignore =E2=80=9Cdir/=E2=80=9C if and only if i=
f =E2=80=9Cdir/a=E2=80=9D
> > exists to match the pattern in the gitignore. I am not great at
> > explaining but I would try to explain my use case to the best of my
> > abilities.=20

Okay. That is not currently possible with gitignore patterns.

> > Some Context: I am a undergrad student and I am trying to currently
> > build my portfolio website and I have planned some interesting stuff
> > for the same and to showcase my abilities and working to potential
> > future employers I have made the repository public.
> >=20
> > Use Case: While I am working on it, I plan to write some blogs about
> > some interesting projects that I have been building along side that
> > I am passionate about for which I am using markdown files to
> > generate blog posts.=20
> >=20
> > Now, I set up my Next.js project such as the server scans the
> > =E2=80=9Cposts/=E2=80=9C directory which will contain all my posts. Eac=
h post is a
> > directory with the post slug as the directory=E2=80=99s name and each
> > directory contains the structure for my post with index.md as the
> > post text and along with other files related to the post. Now, I
> > don=E2=80=99t want to upload unfinished blogs to the github and want the
> > ability to work on different blogs simultaneously with the changes
> > reflecting on the local device while working on the portfolio
> > website itself.=20
> >=20
> > So, in my original approach I thought it would be really simple it I
> > could just name it as =E2=80=9Cindex.draft.md=E2=80=9D and the entire p=
ost it not
> > saved to git, instead of creating branches or work trees or creating
> > an gitignored directory to store all incomplete posts and moving
> > directories all the time.=20

Well, my first thought regarding your usecase is "branches". They seem
to fit the bill quite nicely: you have separate tracks of unfinished
work which you don't yet want to be part of your main branch. So if
every blog post lived on its own branch where you refine it until you
are happy with it, then you can merge them into the main branch once
done.

The huge downside of gitignore is that those not-yet-finished blog posts
would... well, be ignored. That is you cannot save intermediate state
that you have, you cannot see how those blog posts evolved over time,
you basically lose all that Git is designed to help you with.

So I'd really recommend to give them a second thought, but in any case
your mileage may vary.

> > I apologise again if my approach or way of thinking is stupid and
> > for bothering you with this long email.

No worries, neither your approach nor your way of thinking is stupid.
Everybody will have different workflows, and what works best for one
person may not work at all for a different one.

Patrick

> >=20
> > Thank You,
> > Divyaditya Singh
> >=20
> >=20
> >> On 07-Feb-2024, at 11:13=E2=80=AFAM, Patrick Steinhardt <ps@pks.im> wr=
ote:
> >>=20
> >> Hi Divyaditya,
> >>=20
> >> On Wed, Feb 07, 2024 at 01:56:34AM +0530, Divyaditya Singh wrote:
> >>> Hello there,
> >>>=20
> >>> I hope you are having a wonderful day.
> >>>=20
> >>> I apologize if this is inappropriate but I wanted to ask is there a
> >>> way that I can make my .gitignore such that it ignores the entire
> >>> parent directory of a matching file.
> >>=20
> >> Not inappropriate at all!
> >>=20
> >> Rephrasing what you say, you basically want to ignore "dir/" if and on=
ly
> >> if "dir/a" exists and matches a specific pattern in your gitignore,
> >> right? If so, this is not something that you can currently achieve with
> >> gitignores.
> >>=20
> >> Would you mind maybe explaining your particular usecase a bit more? Th=
is
> >> _could_ help to find a different solution for you. But even if there is
> >> none it might motivate others to think about possible ways to implement
> >> this in Git if there is interest.
> >>=20
> >> Patrick

--IPXe8j75rh84sgek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlmZoACgkQVbJhu7ck
PpSONA//T+mTId7eKbY1CbBGXQL9VvRztDmmnD2OyoHP1i/vls/VbpDGYCN8sahK
qSLwpDtLrsxX39vLm4lD+CdPB90KoaDICkwa1xs6T0jYt1c9U87kBPjPcFDKntJl
BmBQEtUlGXTPbPjZoYf58ED5GYDOw8i6peSvrtjkND65luWkHtWnhZ7Ga9tL6EMG
6cgD1iUwy4Ktk/PQHpo5uYUGyS+6HMJCwz+Wovhifp8eZocOJRHI9wFedtiuJSWS
7n5prDY/SHh6yil1F76Y2Xuv1+6Q0AlCvEtrHNXcNVMuYvS7o+W5lq3lNqgYQzcl
lVSHyaslkGsV61Sxbpsay+IVoZ5rKF0TyBvZSooF+xmj4YUye72ItxxnzfFmDTgW
tjv2f+1XmlCvfrbDOqLwBA/sSFNyjTrbvgDS+VPiEpufbvDmonwV4sLOX0Goqycs
uCaAiCzuGQes6ln9BApsOXWJYh1rq8EBvjDI2IBsAjWgcDmrRFXcGBlPHtuTuSyC
gUiNSyAxfTiq69nX+wnTvMsH7CwQsAcC4YLWialEWoWQWjgWOaqxvBjoEZK1R63g
u75VDg3W14yZjJWlOJnkehtvJQ192RV+WUzfu4+49JcUpdyvhBZf/hEVnzdDqcRL
2qUJVu6Pc4t+LOl1r6jodvzGOxWSPwqDRawio4h6yLHKHJbkaLw=
=Yxa+
-----END PGP SIGNATURE-----

--IPXe8j75rh84sgek--
