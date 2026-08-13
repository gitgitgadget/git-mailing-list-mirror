Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7533D170E
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613675; cv=none; b=LzMxqjiCHykO4KrlJeZzJXIq+InB/5Y55kytqWiKD20ivsmw0cPZ4RcGifJeVIJAXVeU/taiVVTR69xCJ/pjPraH8c8hrXbghmWENS47DKpoqDwMpJCy32jVvRGmbNmtF9fNRXve4ZvvpGWM2117F+16D3OfJh7pCdsoTqHLXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613675; c=relaxed/simple;
	bh=E03wtcGxnZsy0j7W/ApBsOHPJX773RB3476diRcr9dM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a/8d+1vlZ4d0Zu03go4mw2nIXVmqDFkLueOBz3LbNKf7kGDKCjEiM4OqCXMfYZqEsA9mlHGl07k+KbqhSWyeupIJBlaYJLtCAhYsGUG3e6KBBbWKwFXksvhbW9TWMNX55P1/9XA89H43bAyGMwYSvd2XDqXt5I+KAl7HKvxbTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=mlZLcYnA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="mlZLcYnA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786613660; x=1787218460;
	i=johannes.schindelin@gmx.de;
	bh=A9uwq0CxWurdx7LM3TIKEj0gxI9j+aRknofsVNW7pv0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mlZLcYnABllcIHGUUJ0eZCGCfwVZnfL6UPjQS8t2QF4BMYtyNlMwCah8dv9c6XGK
	 pY/kVX2nSv4YvIV/QnKfiwZ6/bVIm+1lNoSyxQ8wmKOMh+c4GX9I5gIsULllj9U46
	 ucHhSZDNGzkIVA9SC+bpXN+TIrXsIlcGdOZ1pwX9CvXPUKZdrtiFreGIU0hWDIdaT
	 hKEWuHKQxcCXvfB02bnuH6iMebeii06CBmw/vOz9LtddvsKDV/ke0v9W61WfApy2I
	 y6StV8AIi6YXPeDJBpCuVqfobgK3/xdT6SO0VT0vVZzoSzRdbuKLhkGuuPkftiFKn
	 ABIu3aOVIpR2790ibw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpOT-1xMdld0fSj-00jFIK; Thu, 13
 Aug 2026 11:34:20 +0200
Date: Thu, 13 Aug 2026 11:34:18 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Junio C Hamano <gitster@pobox.com>, 
    =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, git@vger.kernel.org, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
    Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/"
 directory
In-Reply-To: <antWRHPHHES4a1KT@pks.im>
Message-ID: <693a61b6-e762-d864-d25b-348485ec039e@gmx.de>
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im> <20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im> <alR9GDNTbdjWB4dq@szeder.dev> <2d455ecf-972e-e3ce-54bc-683050c04282@gmx.de> <xmqqjyqpb96n.fsf@gitster.g> <ansSg4qsPwh5FcR9@pks.im>
 <xmqqpkzo39d2.fsf@gitster.g> <antWRHPHHES4a1KT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:VpDIZpKhKCfM0B3KubqnEuiuD6r6yVzjTL0HqaIhYbkBASxCA/S
 dSmcyDlSl4DDnBbiSUk1uYcWt1SoXVWHzB1FJUdlRv+uWWbK7oWKQDYQc6QcJrEXBFp7Fty
 fwkR83onXia+rCXbCH5DYr79PSwb086ImR1IlIHUFSnvrXRq0V3f9rE939pDUOGKxEH9mkf
 SmjpiF2cFRjdNyVjQwahQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MFxG/vmDX5c=;KfcS5DBuDnh+LxcPKrR+4qy9kGE
 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
 ozs0pH04O/ieg+Wg==
Content-Transfer-Encoding: quoted-printable

Hi Patrick & Junio,

On Tue, 11 Aug 2026, Patrick Steinhardt wrote:

> On Tue, Aug 11, 2026 at 09:33:29AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > >> ... built-in commands in 'builtin', with subsystems like 'refs' and
> > >> 'odb' in their own directories, and everything else at the root
> > >> level, I would prefer to keep that organization until a substantial
> > >> subsystem update wants to carve out a new location for itself, just
> > >> as past updates to create 'builtin', 'refs', and 'odb' did.
> > >>=20
> > >> Compared to those past moves, the proposed change looks more like
> > >> churn for the sake of moving things around, without achieving any
> > >> real organizational improvement.
> > >>=20
> > >> I must say that I, too, remain skeptical.
> > >
> > > My main motivation isn't prettiness though, it's newcomers to the
> > > project. Git is not an easy project to get started in, and the root
> > > cause of that of course isn't our file layout but probably rather th=
at
> > > Git has been growing organically for 20 years. But the file layout
> > > definitely doesn't help newcomers to find their way around in the
> > > product.
> >=20
> > What I gave as good examples were not motivated by prettiness,
> > either.  Moving things around to lib/ as a whole ball of wax without
> > further classification would mean readers, whether new or old, would
> > not benefit from neatly classified set of files that gives readers a
> > concise and easy to understand rules like "you can visit builtin to
> > learn about individual command implementations".  To achieve a layout
> > that makes it easier to find our way around, you'd need to move
> > things again after moving everything into lib/.  Moving to lib/ by
> > itself does not add much value, if any.  It certainly does not add
> > any discoverability.
>=20
> I think that a cleaned up root directory is by itself already adding a
> lot of value

For what it's worth, the cleaned up root directory was the benefit I
immediately spotted, too.

Of course, it would be even nicer if `lib/` was split up further, but
then:

1) You've got to start _somewhere_. As we saw with so many things on this
   list, they never materialized because reviewers asked for too much and
   weren't happy to get incremental improvements first.

2) Naming is hard. As we saw with _many_ refactorings (I am thinking about
   the low-level merge stuff as well as the ODB stuff, for example), it is
   unlikely to get the origanization right the first time. So I'd think
   that first moving the bulk of the library code to lib/ is a good start,
   and worth merging, leaving later contributions to chop off further
   parts into subdirectories of lib/.

3) The continuing maintenance pain that is felt with having to integrate
   this lib/ movement with other in-flight patch series in `seen` is the
   _exact same_ pain that many other maintainers (myself included) feel
   continuously. I think it is a good thing that this gap in Git's
   functionality is now so clearly visible that next time e.g. something
   like non-automatic rename detection is discussed, it won't be dismissed
   so easily.

> because it makes the entry points into the Git codebase more explicit.
> As I said elsewhere, the value is not in making the code that is part of
> "lib/" itself more discoverable. The value is in making everything else
> more discoverable.

:+1:

How many casual readers do you think have discovered the top-level
`RelNotes` symlink, for example?

Ciao,
Johannes

>=20
> Ultimately though it's a subjective change, so it's hard to argue about
> that as I cannot present any hard facts.
>=20
> Thanks!
>=20
> Patrick
>=20
