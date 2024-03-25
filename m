Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1221174EC6
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357857; cv=none; b=dI1Me6il2Lb42TPRhe7m62YwMfRLvq1QGrQL10W+R2D8Tkjv43CkioWAtAuVqtDx40MDmvwkIAjXekklNtdZTPJxLmaGAOx4pOzgvnPbfqHyIzWKjRJEu1O1XU4XBZYD0IN7SGyqQiMvo6Yy5KyFqQdTUZiRVKnpQ4YeXi4SxAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357857; c=relaxed/simple;
	bh=Ke0R9R7Ad9cAkIN0FGDZlJHW9hZlLGCJoADSmYJvCzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcsZotNZRen510H4srXdWjD1t0R9vi7a2V8KqPMOz9Hn7CBeEhRkW1iRXiNc3bK6j0zxZ5pDqwczC35sCSRt0SrOInZ2bSKU47i66ysyUvTHZBuY12o6aBX8ha0LAF2VUIsJLDG/ZrVGrptwRz/Xdv8mE0WmzRBBN3PzCsEH+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HA/IcRTH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fDQgV/sD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HA/IcRTH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fDQgV/sD"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id C3721138011A;
	Mon, 25 Mar 2024 05:10:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 25 Mar 2024 05:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711357854; x=1711444254; bh=Ke0R9R7Ad9
	cAkIN0FGDZlJHW9hZlLGCJoADSmYJvCzc=; b=HA/IcRTH5NLWWmXTlBVcRcHr8d
	UeQcF7QyXxQAac2xB2gzr7A2IcInn8zCNSbbW7DBpi/CGRVT6PHcziDQqz897kF7
	zk9D6KZszwscC8iz/u4NBlmlXfQYwK53OJZbc7tBI1spaIFo42by8biTmJzV9wN0
	B8m/7mbL0iJYf8sggkhwOG1WQBt43xRxEGrzUmaUf+blv/MiO21OoAgjBmm0ZPfm
	azlCi2bmUNjcYfKO4ezdBfmmvBzok+b6sivSTsRnP4kqSnmKvhwqJn0CJ1ysqwbT
	d2Dx5WmqBs0aGU5xLBl5UQLCgPQDytNiM6bo2P5v1mZIs6vLtH89ODPD21SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711357854; x=1711444254; bh=Ke0R9R7Ad9cAkIN0FGDZlJHW9hZl
	LGCJoADSmYJvCzc=; b=fDQgV/sDlAyC2vHT2a0KncMvs/RJu1gdrji4J+2wOZPO
	nbTMenCA8uTMZWBIbliSb94zDjrXpd0b6aT9aBeWimdxNdCxOLebldSXhBRlW8Z9
	MINcd2eD74SFVgm/k4st2cyBIKKRYjp5H2m2p5BPvS7Pt8K2ltR30J4rvrqotAbr
	IIYWxVNiUBfj8sBqhIgoRE+RjjyoEXKkyCjDKflWjGFZFgYcOhmyxtyn/PAI3pbL
	Ui8+XvA1pYU94D2s1OXJsv1F+kLlaMbyY57j/lX5ayRgRZyjRysz1EiQIOVRZtI/
	CWb2DlqKDIfTU3+DWZSPEYhmuQEYJIILTj9CGcTegg==
X-ME-Sender: <xms:nj8BZsWDICsPaOGJr-o9EfLU5QS10abSB5w_evMuG16u34x-xdU3VQ>
    <xme:nj8BZgk1zSrm5WQNjgFoXQR1OV7W8VLR_8wugYe4fgavBMD9OBqSbya2tLB1WhFC5
    BzQDpoFIc0HSa5eWQ>
X-ME-Received: <xmr:nj8BZgYDskBi2uuWgbrebqb5_78HrB0xiZD2D4zFF7xgrP4JgBBEoG4XasqeHAfryrBg8NFnmSebYDGZbP12BQbxN7lW0CyaLmMxGxu_gOLIHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:nj8BZrUZ7rxLVgYlfLW8qY9BV5RmYy9NBev2IlRJSJi4hPti_eYmVA>
    <xmx:nj8BZmlUmUFeOSpgLIMxtDl5au1kTM5Xb1cqnfQPCPmdE3V7rc5XIg>
    <xmx:nj8BZgfj0Q8lnWxjJNh2Y7Pumj8Om5lhTSBG9OEMMmumahKBEigG8g>
    <xmx:nj8BZoGFZx3ECxRTkzeQbYposqRlKfRpKIGU8OrBlwdRQUSYLz3_1A>
    <xmx:nj8BZnDj2dUDF3rYSOzY0KEzrTICvjFgdIqebKhnnTa5w92RoK4XTQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 05:10:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9006ee98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 09:10:43 +0000 (UTC)
Date: Mon, 25 Mar 2024 10:10:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 14/15] builtin/gc: forward git-gc(1)'s `--auto` flag when
 packing refs
Message-ID: <ZgE_m8qP8Ng7omhR@tanuki>
References: <cover.1710706118.git.ps@pks.im>
 <474cf66b26f5e459dccd60a2dcd1a09eff86178c.1710706119.git.ps@pks.im>
 <CAOLa=ZTWvLkzdJMOS4nU=zGhmXS2nSEXzK3Wo2+=jRgV56atrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IqMlqqb2dlMGNtvo"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTWvLkzdJMOS4nU=zGhmXS2nSEXzK3Wo2+=jRgV56atrA@mail.gmail.com>


--IqMlqqb2dlMGNtvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 04:56:31PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Forward the `--auto` flag to git-pack-refs(1) when it has been invoked
> > with this flag itself. This does not change anything for the "files"
> > backend, which will continue to eagerly pack refs. But it does ensure
> > that the "reftable" backend only compacts refs as required.
> >
> > This change does not impact git-maintenance(1) as it won't ever end up
> > executing the pack-refs task when run with `--auto`.
> >
>=20
> I'm not sure I follow this one, the man page for git-maintenance(1)
> doesn't mention anything about not running pack-refs when `--auto` is
> used.

I'm clarifying this further in patch 15. It's quite confusing in the
first place that git-maintenance(1) doesn't ever pack refs at all when
using `--auto`. I will amend the commit message to explain this better.

Patrick

--IqMlqqb2dlMGNtvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBP5oACgkQVbJhu7ck
PpQmpBAAm5mYBiv2ivwHJR0BVvwDn9yuZozQFTaeXrnrkB7EW6MFd5eciBAxJl+d
gIaxgSs6dnR+dly8zFc38UaFJhUEJzv1hON3kX0lHN0/dR2L/MvkzRg2ip3bSw2e
FETZSrdKC/x6xIdK4BcN6leFBNyzXbhiV7zBRHTjgiWuA/111Oy9Mq+DYRe17wvR
/tulbRcZrFP8a0kNFqSbDLJmRqAQr2DJuF68OK/FnGBaJEkxq6aRJidDFE6oU8Zm
IAZJToMC4ME3ar8kytgrYSA9GJkOE6YUy7fv6Rjn0/WI1TjFdDSlx6myyMyS8/Yt
fDfb9WIrWFIyI89fqncLU7SzO6Ywjz9BhqctfxZnCZYE3nrtYA5HBHmcklFatd89
PZEWxP5ECjvv1mX4cD2XhRc3IHkjlnv/cziCQ9OHTSL0iL+t5ZKWV5WkOsdsTXwx
CvUuDcBXgHYOgPx0VW3pNpRz1cIc572Pu+dGFbkPd+cNTmpN+YWqQat3/ofx/J9b
ddNncaEQ0eexdhX0faEIbPTOpYBmb44IvIV0B8a/PyBP+lvyfj2Riip9zO/A1L8d
bMdX6FNo/eyRJyIDrtPkJGiDtmClBezuxhPO5dJsk4AFZ7VZtX+YmYTu185GLVK+
tx2wTfmKWua3Bizc+1vr6JwA/7ObgxDDPmvnRMrNyGonlvvSXxk=
=o3gu
-----END PGP SIGNATURE-----

--IqMlqqb2dlMGNtvo--
