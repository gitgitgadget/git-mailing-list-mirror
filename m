Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D7354BFA
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 05:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419021; cv=none; b=bxVwiePguX1sCM0eFq/C+hW9DCs7A6aom+0Rm/SUMUy+YyffOoKYNaIToFq+yUE+WR7HJNRA6OXbiO2k7oZ2SLPM6s4Ht850XsF8s8tcqqyhapGBPFeow4RsgsfLZqJAWmLTk0CWJXO0+No9ZDmqKjoX2rXgsY1NSgTWIwqCiO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419021; c=relaxed/simple;
	bh=SKrZKgu29iM3ciMZO8BVa3itCfD/Om/2ESoP1rsqrnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peTOyDhuvGP3+laYiH8a2TkTsH0rr/0SZQ/scnetgvOHti7V3zzghU3jS6fFU07Vki6pz4KX+8FA376zo51PG2FpcyvnrXOBlcxtBH0YT8NVIWr7gAGXq85aA/UwFNav8dfZ+Yn24Mtdt0iCGylhLXrASW+5YOWRlWaHdArEt7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nRjN+v+8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ABZ4xLBZ; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nRjN+v+8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ABZ4xLBZ"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id EFDA11C0013B;
	Thu, 18 Apr 2024 01:43:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 18 Apr 2024 01:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713419016; x=1713505416; bh=vT+wrrMhVh
	H054raNHeFz6BUTMDJEj7kExcB3jWvvsw=; b=nRjN+v+8ZUcsj4EYx6vfCHZWyw
	tSfKLCr98rl6u3HyXBOy2oSA3mMTLJIedpJSMD5X2BwpzmIQZVfXKaQONdo6xVUZ
	mpmz9qFAwMS62tvvORimShN6ajlU0HUGCxvQlwA7AIO4Pdf/jhBDGlknlj5gYChk
	6e+MfaKvNdUVx4THjL9qWPAvjJuwVL82j7/Jb6TcEBSdAwJRzXKltOfysOPhgWC8
	gn/m3pLRjUHUw7ovqyn1ikCKj+Hdx/1mT4FavfU2naykeZ4NPEIvl4E2Xf/sJpWu
	5ym7HDECw27Zqlq9dGkKJkQsHJNIE06VSTnHYdPmrkQl+FazdamGA8XhCmgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713419016; x=1713505416; bh=vT+wrrMhVhH054raNHeFz6BUTMDJ
	Ej7kExcB3jWvvsw=; b=ABZ4xLBZCve1EdYC1emfs70APKIfiGjVITM7AkwzbCtt
	0zR6EDu0YsupqetfRxwjJ80BkvH30hKjfI2xtei8C/whxhwNxVmLnVx/SrdSWCGc
	Vsb5RfpoYV4pD92gQlcn8+lkp8pvDrsHTmgNw7aJ0TpET4qHe1A/tofkjJZ8nCgY
	WwflxVek0DcKgPyIrpgJ/aW6is+UF0XtD1oeoDN4Vf+lgjIVGXV9DScuzM7fWUCt
	wO/CprFCHE+J44XBZzoHs7LWZrgKzgZq+h3tVBn9TY/bWeY4BB4F/coaTYarKRff
	tne0txjw4Ko/TMM7+K6jVmzXBJfie0s8iyoUDKtXKA==
X-ME-Sender: <xms:CLMgZnRRl9Pc19wBfrteStkElqvf9kgGXMYm6togXto9Iih8OVp0uw>
    <xme:CLMgZowCggFowjZcNJRz8ZjbgI0v4EzgFwQefE6gDE-UpOHp7vsvfHjGJ4yTspXLN
    __c1wQ9irIehfsvYQ>
X-ME-Received: <xmr:CLMgZs01FSsXQGOXQAJZYRpJu5UzRGnAB5mJlMzMEnMo7g0I4kb-exSSMcGdpCrp0ILG11QpxxKj7h-F0AY9LWVDgaqOUKuRTwsGdHV9Qbq4M3kHag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejledguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:CLMgZnCCPQpom9Kaq5Q47aa60ZtMh5AryF8COg6TspOqBHYn7nKS4g>
    <xmx:CLMgZgju5DrAakWZepbgCXxRWTlt8JsYgJrckq3xSPvxhVOf6xCklQ>
    <xmx:CLMgZrolm6EbvgSI16SD47vHbsO3zNhPPsE4emwRBBOqy2MQcCOL0g>
    <xmx:CLMgZri9Cbk_iSsD3SoB62GV2mYn6RXB7I8CSADhdNry9hkpPvQ73A>
    <xmx:CLMgZodLoO8HkkGkddLQa2G1AWgABZ-Nvoca0uKAISXaL3ZrzLuIuNcj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 01:43:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0202ede5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 05:43:08 +0000 (UTC)
Date: Thu, 18 Apr 2024 07:43:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/2] builtin/receive-pack: convert to use
 git-maintenance(1)
Message-ID: <ZiCzAodY-L0QvX8s@tanuki>
References: <cover.1713334241.git.ps@pks.im>
 <CAOLa=ZTRY6hmQqC2BozFkLmLQWnkQ4+sSug_8N1ZY9+aHNqCTg@mail.gmail.com>
 <xmqqwmow7wwp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fOMR2luYJVjr/LJx"
Content-Disposition: inline
In-Reply-To: <xmqqwmow7wwp.fsf@gitster.g>


--fOMR2luYJVjr/LJx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 09:53:58AM -0700, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>=20
> >> this small patch series adapts git-receive-pack(1) to spawn `git
> >> maintenance run --auto` instead of `git gc --auto` like all the other
> >> parts of our codebase do nowadays. This removes the last internal user
> >> of `git gc --auto`.
> >
> > I don't have enough context here, so why do this?

Fair enough, I was a bit lazy with the cover letter as I thought that
the second patch already explains it well enough. But true, I should've
set the stage a bit better.

> I think the intent of a95ce124 (maintenance: replace run_auto_gc(),
> 2020-09-17) was to update all codepaths that run "git gc --auto" to
> instead run "git maintenance --auto", but only updated the ones that
> used to call run_auto_gc().  The codepath Patrick found runs "git gc
> --auto" without using run_auto_gc() and was left behind when the
> others were converted.

Yup, that was triggered this patch series. I was puzzled that we still
run `git gc --auto` at all.

> So why do this?  I think "To follow through a95ce124 started" would
> probably be a good enough reason, if a reader is on board with what
> a95ce124 wanted to do.
>=20
> Do we have a handy reference that compares "gc --auto" and
> "maintenance --auto"?  Are they essentially the same thing these
> days?  What are the things that is done by one but not by the other?

git-maintenance(1) is a superset of what git-gc(1) does. It is
structured around different "tasks" that the user can enable or disable
at a whim. By default, only a single "gc" task is enabled, which makes
it a drop-in replacement for what we had before the conversion.

But users can ask git-maintenance(1) to perform housekeeping to their
will. Instead of running git-gc(1), they can configure indididual tasks
to repack objects via multi-pack indices, pack only loose objects,
update the commit-graph or repack references.

So overall, git-maintenance(1) is the modern and more flexible
replacement for git-gc(1) that gives more tuning knobs.

Patrick

--fOMR2luYJVjr/LJx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYgsv0ACgkQVbJhu7ck
PpTEuA//dqYdm9xo+YX1lgYsjenz7rD5ZE1FMyC6GMuVSwQVx4KqZhBgfPLaL6jZ
SqW+M6afeJmT8H62VTn+lMOF17xiiKXolFzUePrsX4Md2YVoXgDCJw14UU9uhB5i
SfYtGKjvRHEwRYTmEzUBvwRIcvfdzKPONpLfGJBCOYoupq/BJSECSFmdbFV7KM0C
vS6X/cFJSmlG1+++xq4F1t/iOWZUliiVN9ATrFpsMxxs8NMXZ27oOUfpdBjNJ9qu
nISnUHtLjJM0tB3Scb0Gfcp1vMo/yc4hSGxezXj0VOZQwSzf0xKK/msd/SHlIeiy
SM8+YBFi7wXsGI7yVBDwY6cM95VdyBg8Uhxg1skpuSas/Mn8yOv0xITMMbmGS1el
XkOP1UtaTozCvI6RS3UYo16XlvToQ+JEHKNc2hso2LfushWUs4+FCJpLXsK0v8ov
nLFoR82ITPW8cfX9LlsBPZeqBs6nkeG9RJvabChbrNiDwfeW8bArRHQO+/sSRgL8
sc+k4WlKXDy3V1Ym49Oq0qx2Q0ew0/PRo6s5mA2O9y2T532J8VYlH7p1pBsy9oXC
zy/xaSknm4bQUQDAclxUR1Pbg7Gpttd5XNA1GSw3EztT6BHnSlOFNfECl9VGL5t6
9ggYn7cG8mmuWSFFRe0bAVnkt4h2blhcFmCU8vaNXAXDMAZTRbE=
=Qh5A
-----END PGP SIGNATURE-----

--fOMR2luYJVjr/LJx--
