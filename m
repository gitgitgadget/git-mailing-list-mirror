Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3363C3D9DCE
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515780; cv=none; b=moYxWMQecKQWPAvk0aE3aS3ddqKdRh7GPAvmgeL+ldW/yX/d8vPcto0w43hmppy7kjI5PTwu7v3p1VDLrzSyf70dlYZdktLnzz4SKEsOFLY+ZSZWaVb0Xiwwmv8KrVL3mxRqI3hQzIPrLeAV5tmbY4beFrKQlN+MX6+o5cWPu7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515780; c=relaxed/simple;
	bh=9uGkscyAwxPEylgVBhc0WmFij7GtnfI1ba9MLcOueFg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fOmrqs2PDECsxAnaGmJ9gwfhYtKRGo2m3ItH+vhfH6ATilhLSDuLTyINeawS3h5wN68qTc0ETljXbbFhMiX53WguFg+hi0r0jhcIznod5No4kKgmegmtlt3kbPhXlouJoYgbJYk1wCVwn7bl++bztShVF1ZAC2HtYBMmutY5c7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=I2/gA/XG; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="I2/gA/XG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781515773; x=1782120573;
	i=johannes.schindelin@gmx.de;
	bh=VJ0CVwxh7j3J9QlvuG0f23/Q0Wk9gcpLKK061yC3u8Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=I2/gA/XGgt7kYRGw91zBRAWQwzGY2rA+cUIhGSNwruE8+t/vsA9BAMeRHqsciyX4
	 ksRlL042CCsWQLCCT61NHYCx+gVEVvGmEUZ8XM0JDstzxaLvTHDA6rZOLj9bhIG83
	 zf2rL3irNDrqEGr3iPgvY2ji8KuPlmu78TX0fZeNmBltfWZhZF1uRWdEXyAJSwDR0
	 3RUNtnv/Koh4pBkeMBXYaWPR+xn3232dhdz0zeTgbV9hinLFEn2xEwX8vmj7jgHTC
	 fdFqoHlvOYJ7RJAewS48h+lNIzHXlnsv+7caFo/MXKh3snlJd4xtiNP2uGykFkcue
	 kQx9LTvPps79oOoNNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7Jza-1waB9d1g68-004Zkx; Mon, 15
 Jun 2026 11:29:33 +0200
Date: Mon, 15 Jun 2026 11:29:32 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 2/7] patch-delta: use size_t for sizes
In-Reply-To: <aibJTHKsmqe_EJHc@pks.im>
Message-ID: <03cc2127-7686-5d71-0e8e-aa2fccb78820@gmx.de>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com> <1fd7646ca14f7ec392c85fab10255f08d0d79368.1780570273.git.gitgitgadget@gmail.com> <aibJTHKsmqe_EJHc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:ot6GH7wQ0bBDnc1e95BqCSrM8EUXMENtm6hQBoUAT94EkLF9jdE
 kS1K+OkbctvMPcsu4nnlNooIU6BqSSeGtJAncENM0wL98pRDKFN3YhBNE2pAbSsjSPk+1Iw
 mgKw7pp3C5SEl7ObohVtBBMSNmBZe+6YML/C51PXtDU+5Tf5eNDZtxrVOLYgzCHpQCF1+65
 oPqncCnpb81cvsx15p8kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zL8ZQMuv3RE=;vQolNPSpuImk1Nec5oo2tGs3665
 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
 mgefwU8ZcE8aREa9nM=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 15 Jun 2026, Patrick Steinhardt wrote:

> On Thu, Jun 04, 2026 at 10:51:07AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > `patch_delta()` takes the source and delta sizes by value and writes
> > back the reconstructed target size through an `unsigned long *`.  That
> > datatype cannot represent a value that exceeds 4 GiB on systems where
> > `unsigned long` is 32-bit (notably 64-bit Windows builds), though, eve=
n
> > though the delta encoding itself, the on-disk layout, and the in-memor=
y
> > buffers happily carry such sizes. A `size_t` companion to
> > `get_delta_hdr_size()`, `get_delta_hdr_size_sz()`, was introduced in
> > 17fa077596 (delta, packfile: use size_t for delta header sizes,
> > 2026-05-08) precisely so that `patch_delta()` could be widened without
> > changing the on-the-wire decoding helper's signature.
> >=20
> > Widen `patch_delta()`'s three size parameters to `size_t` and switch
> > its internal use of `get_delta_hdr_size()` to the `_sz` variant.
> > Then propagate the wider type through the callers.
>=20
> Does `get_delta_hdr_size()` have any remaining callers after this patch
> series? I currently only spot two such callers, and you convert both of
> them in this patch.

As you noticed later on in the review: No, there are no such callers left,
and the `_sz` variant gets renamed, concluding the incremental migration
of that function from `unsigned long` to `size_t`.

> And can we reasonably add a test case that exercises this change?

Not reasonably, no. This would require constructing another artificial
_large_ object, this time with an unpacked Git object with a size >=3D4GB
that needs to be transmogrified into a different object.

Better leave the verification of this patch to static analysis (GCC or
Clang have become quite good at spotting things like this; Coverity would
be, too, if it ever comes back up from its "upgrades to the Scan servers",
https://web.archive.org/web/20260516152422/https://scan.coverity.com/
seems to be the start date of this update).

>=20
> > diff --git a/packfile.c b/packfile.c
> > index 89366abfe3..e202f48837 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -1964,10 +1964,8 @@ void *unpack_entry(struct repository *r, struct=
 packed_git *p, off_t obj_offset,
> >  			      (uintmax_t)curpos, p->pack_name);
> >  			data =3D NULL;
> >  		} else {
> > -			unsigned long sz;
> >  			data =3D patch_delta(base, base_size, delta_data,
> > -					   delta_size, &sz);
> > -			size =3D sz;
> > +					   delta_size, &size);
>=20
> Nice that we get rid of this awkward construct.

Awkward, but necessary to allow for an incremental, reviewable conversion
;-)

Ciao,
Johannes
