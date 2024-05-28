Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07503F9CC
	for <git@vger.kernel.org>; Tue, 28 May 2024 05:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873233; cv=none; b=MYNx1vWsrM6h63c8QdZDypHBvrq4ltYkv61YtbH22iJ80JSGj9KauHbhslPyd1m0cSAwHfUufh9BKs+EcYhXQ1v9Dn1ceCdI4SDwFzD+Hlr545gya1SzNORtywDj/D3wFatzEftj2fB4vw28LpHOfprWGvoBRtUreWjAZ3pjfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873233; c=relaxed/simple;
	bh=XGT83xaOU+mZtgn+4v7bXM89wY+OwMzwpM+m4cxwJkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzOJGZix+BqMDRL1CG9EgY+zU+JG0YDxs7BEGz3cbCFd+BdoT5BhK7xh7bcJQrdVNJHwLPHxm/z98o0iIYXGWynPdc5L81kof38tal/4R7jST8Xv1GfWY54hTTR0msBWfuvGzpsInLjxHXx+iz+jV+9Z4GMmhdOQaa0wChmVt9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RUM0Nag4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qKqE+wDQ; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RUM0Nag4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qKqE+wDQ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id CFC111800158;
	Tue, 28 May 2024 01:13:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 28 May 2024 01:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716873230; x=1716959630; bh=PFC9+brJil
	6m9cU5TDGtFJqYC+WT3dYlppRn/rf+O8o=; b=RUM0Nag4DfdxYte9Hkbxo4VEwx
	pE6iuz2DuCCjWUFU5XMHdLMSZ3pfFNPs7oo9pZxCEMJJsDG33bDTIPed+lF7c3dU
	9UG0GFcCWXuUzXWoSHeGh0oYFgMBcEY/9gc3RYXdtz9R0IrQGlUSvIUjN7JkSlFy
	Ugi+LDZVxII6KucmteBlZd8Mv2n4AkzemBRoZ+H1+OImol7/5xFohr7I/nnGr2g1
	XF9/4dVyLSsE9yixWJHLf62TtM1mhC9+bkCMvEkLCeCCwgJydyuZc5FkU6ySEJip
	210SwS+V9vGmoWowFhCzON6DNWlNoKbVnKlualEk/W3T+cPRcje07C5opR7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716873230; x=1716959630; bh=PFC9+brJil6m9cU5TDGtFJqYC+WT
	3dYlppRn/rf+O8o=; b=qKqE+wDQ/DOuJE5OAAfehgNVnHXxSbOyiRSaDVxtqZs9
	Cg34lxxhRh+HMbqec2n8DH2PhC+xivjZcBmqHtq1HVAhfsX3SCd3QnUviO1Vj2/3
	jgfRdyEwRoCq3rvYKhVnMjsUpkYppBZoKHlr2sVAxMY5aOH5ODaLOXEH1d2AdJt5
	PcvLfM916g7u1dtNuYWm3r3bzgkn5aifJ0StpRjtrKpVoCk+5C8nAtpxinSwKqF7
	SZeW0vFg93N+HssVvksL/5tPOSkR9XySqNkVoKVUVQkyF7/pOpNuuqUDEfFukiuy
	CaHXkMW9M8jT+vii+tMMswMEh83CU8UqRDacx8By5Q==
X-ME-Sender: <xms:DmhVZkF9glM6SjF82hmgQdnCynQ_dqXGrEfpBAfmavWOLMKz7HgaQw>
    <xme:DmhVZtXW-ei4YnENEsJZRj0bcSrCeKJ61HYKRV4oEc310GcMVpHo93Y2jiZdQrTmm
    2gwpRpmpB50fAY5yQ>
X-ME-Received: <xmr:DmhVZuIuIGO74N1KqdW-iAQHfdKcg-i5istSbHAhyN5CvynIwIV6lx731Sdn4kb26Ao-jWf6GgPKfEW_tJqnRtL44bovKXWdO3nncT5XqFpSXHJP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    orredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehfefhuedtvedtfeeiteeugefgfeelge
    elveehffeukeelfefhieekteevudfhffenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:DmhVZmFuDpiKowmUQXAW56uBabpTYRexU6MAuUMcDJPCDnE0wvOAVw>
    <xmx:DmhVZqXp_9AwYdvzc3nEQa5FvxnbCAwVMt7p0Ri1j7E4eznacdGKFw>
    <xmx:DmhVZpNV4-NeVB-8bCEqM5K19PCkFBQPhFTeLwi3wzrZhd5Ad5Twhw>
    <xmx:DmhVZh0TzxZ3tlYIkdAvfENJmdWfozgX13Sx9nVVByphfmj5cSFe6A>
    <xmx:DmhVZnimvt8yXFuaC6t8Ji0a7vQjUo3z4xy32716_u5lJ4iRkkhHwKmm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 01:13:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d0f5a40c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 05:13:37 +0000 (UTC)
Date: Tue, 28 May 2024 07:13:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/9] refs: ref storage format migrations
Message-ID: <ZlVoCnojAiShmtRg@tanuki>
References: <cover.1716451672.git.ps@pks.im>
 <xmqqwmnkv7ay.fsf@gitster.g>
 <ZlBC5O4CHqrx1di7@tanuki>
 <xmqqv833maxu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lFXGYKl16Jm5E6cx"
Content-Disposition: inline
In-Reply-To: <xmqqv833maxu.fsf@gitster.g>


--lFXGYKl16Jm5E6cx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 09:28:13AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> Documenting the limitation is a good place to start.  For normal
> >> users, would it be sufficient to
> >>=20
> >>  (1) tell your colleagues that this repository is currently closed
> >>      and do not push into it;
> >>=20
> >>  (2) configure "git gc --auto" to never kick in;
> >>=20
> >>  (3) delist the repository from "git maintenance" schedule.
> >>=20
> >> before they try this feature out?
> >
> > I think (2) wouldn't even be needed. Auto-GC only kicks in when there is
> > a write in the repository, and if both (1) and (3) are true then there
> > are none. But other than that yes, (1) and (3) should be sufficient.
>=20
> So it may make sense to document something like that at least?

It is documented as part of the new git-refs(1) man page, in the "Known
limitations" section:

    * There is no way to block concurrent writes to the repository during an
      ongoing migration. Concurrent writes can lead to an inconsistent migr=
ated
      state. Users are expected to block writes on a higher level. If your
      repository is registered for scheduled maintenance, it is recommended=
 to
      unregister it first with git-maintenance(1).

Is that sufficient, or do you think we need to expand on this?

Patrick

--lFXGYKl16Jm5E6cx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVaAkACgkQVbJhu7ck
PpRMDg//RuUuYvxA2tiDwX28szX5Qyo/zUGh0oFSeR+xsUkXouG6VGr2QlPRFlyy
NizhS0DiN8Vf+YfDBILzrbz+AVn/G+SCVSlwH7EteDRL8xuu/jQInGq807kZzGH6
PQBOEa/312bXXKg/0Xg6qcZQ9nvkEIOT/7Wlh3HeE3F7sY4BGAifPvVtXGCG0EcW
j7qURbEH3alKmS2j8UQjiE+lSsQrG+oQVdvrAGh+UUVoGs0CbHO/1App8T+oU0MT
EC5Y6Mf0iNarMBPDtjIy7sDJUEd9gJts1xK7ODcBcOEi/HazCnfuCIBypXrpw5DJ
5XTI/MSz3FbfWtB4+RRdUZPD7X1c+lE34D3+6cy5+fpkCtosQSoUC4Kgn78UY+9c
loMY481taHIvyc3lNvReDl9YClKCoJaZiOo2eAjmsSL92T0X59tgJhSfLvs03TKF
CoHwocbEimIn7ZZd2pmEDLF8YedI9ZhTlC+QvU2BjysZs7SChd0T8P77c1zS8Itj
nXlsoZlYPItKeqGCctYqWquBQOu7ywG15hAV1WiatZT+k4YfbrLwJs+aviN1h0FZ
R39Bxbjt8/GbtKD8AdNPvJ+cR/XIFHtcbXBozpN+oIkkXm2ELBfh84tykQUeApSc
yrZvd8ruYltDiTM7KLiaX4O5YzCbfjap+ZBef6xjM4Us2H91zxM=
=NAI3
-----END PGP SIGNATURE-----

--lFXGYKl16Jm5E6cx--
