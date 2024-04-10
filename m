Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7D158D8A
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744326; cv=none; b=RCqtL/TdwRrLHfNR2TCAsIX+xNjNsReEUq//RLQQug3HwI74KFwmHjTzm5LAwQHTTAaBvtWcFA0h/luhqZcTXd6Zu+BpL8pCe7cz90VH6hmsBCORooOMrChN/fblAdN2qMSh4/+yCHLONiB5502us1dkEEqcro3OiY6sRiM/89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744326; c=relaxed/simple;
	bh=KLujglKe3I+eauhotLfRem1owVlSIOd69eeYUhS9o2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDf/BADqo5cP7zYA/ersqge8mA8tB0sHHbO0q0zlfiZuYP3+y1OzleOPtjUi3Ta4Y7M+7Kz3fHojAOrWdZpf7H6N60SZsFYRH2u09GwwqXqOPaFz47ZzxE6lQ2RpmLYuzssJyvL2WTQWq/o9DXm9EYXCcwREuKI1KP2O88id3Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e2MIsZRc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KN//dbLk; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e2MIsZRc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KN//dbLk"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D4E39114017D;
	Wed, 10 Apr 2024 06:18:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 10 Apr 2024 06:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712744323; x=1712830723; bh=KLujglKe3I
	+eauhotLfRem1owVlSIOd69eeYUhS9o2g=; b=e2MIsZRcBMSaqfVktW/sCh9TQI
	k9Q82u3oId2yMfZ6woX9KSqzoVNN49yUE/rjFRNS7DDT/y2Ox+r9se+mnt0/LQp5
	f6LvEqqxfk0lcP84U9bvcZIZHLCXwgtBc813AuTNKORZ17KvFhdu+rLm3k5kiN7B
	CpG4Yj8jPgoH52XagizL3i+XnXobKsoc5u/qUd47u0m0LZT1QmSlS8bYfIjDZ7+N
	tLiss7yjhKGtHbRi6OIxsRi22A852vgLWpKNei7C5xBqc5mQkl0QPFboENK/Cqlf
	xnudVPAd4p6iD3VQPUR2HPK1839l3JypTAHXnl1R8xnFo1daFZyL4qVgHA/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712744323; x=1712830723; bh=KLujglKe3I+eauhotLfRem1owVlS
	IOd69eeYUhS9o2g=; b=KN//dbLkCtKdYUhDZY+fRbzUqkObjn6WDOCYT6PDN6d+
	avlSC6UQ8F8/ItfHOK3mFks73DkKHZcnd5xw7spD8+J+rKWO2iAkrCtPdpYqJTOM
	3TmTEqM0/CL9NKYdn/flvQXoCrkZkVvwimwwsybahARH4SzYRIgPNVX2LwU0RbQQ
	TvRDkqWzB4Jq/3B5rUWGmRjVUMbrKN9yxJsDH1Xe3AIqUzrZw4kZwR6drBMTV4Su
	uNbGDHxYzsYVkz+fY8VdnfiGY5mcTUuAHLqMZzcjzH/rIuvTAc6Qos9mb+ZbyHYa
	7tOLfX1Xil3TzGG1qtsrDCA3TxDgtMiD/C9AbEJWEQ==
X-ME-Sender: <xms:g2cWZqvF_F_RBoo6joViMvZ0PNOR1NbGDXxO04cx-UvM2utYxWNHUg>
    <xme:g2cWZvfn0cOs6tE0TKwfIdX1Ylh1HpPxnNhI03zB4jN-Fcn3DfHe-ActiMS2wvQPO
    kPPi-fDkWODDcb_ow>
X-ME-Received: <xmr:g2cWZlwG3PfP0axygMAy0xZMbFfCqiR26V9ZxPjKRhqUFi4c0mTibN0GCZP1G52bz29_hewSZVdhWlY-2oFeqZHLmdiWM3k0LzHodfbS0Curxt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptdeiffelledvfffgtdejgfevvefhleetjeduhfeuhfeiledvleetiefgkeejueff
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:g2cWZlPJGCCM3dPMANtt1nBtkJlkzHovC4ufLY5xhxZtnGlll3NfBA>
    <xmx:g2cWZq8ONr6OLbQqmh6e858S7K-tlXF5gbdvJ41UIZlqdQbWhzWjng>
    <xmx:g2cWZtUWcFrBSRbcf0aKxXUC-aumtEVZ_KWNYFuPdyf-xUJQkrgGwQ>
    <xmx:g2cWZjeoNmu_edauDEMqrFolxf78fGZdPTceJTYgIPP9ziM5rfYu8g>
    <xmx:g2cWZhaiEsRIDwLM5ssiaS0GcAU9vC7te9iLjuVF6Ja8gmT7bHQcb96e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 06:18:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id baaca9cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Apr 2024 10:18:29 +0000 (UTC)
Date: Wed, 10 Apr 2024 12:18:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/8] fast-import: directly use strbufs for paths
Message-ID: <ZhZnfHqMD-KtIsF2@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev>
 <cover.1711960552.git.thalia@archibald.dev>
 <82a6f53c1326a420348eb70461f5929340a930d3.1711960552.git.thalia@archibald.dev>
 <ZhYxP42Br2h1mq5r@tanuki>
 <17089372-8AF1-49A5-A582-8153E87380AE@archibald.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OxTuwT5DC2BHaxR5"
Content-Disposition: inline
In-Reply-To: <17089372-8AF1-49A5-A582-8153E87380AE@archibald.dev>


--OxTuwT5DC2BHaxR5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 10:07:13AM +0000, Thalia Archibald wrote:
> On Apr 9, 2024, at 23:27, Patrick Steinhardt <ps@pks.im> wrote:
> > On Mon, Apr 01, 2024 at 09:03:06AM +0000, Thalia Archibald wrote:
> >>=20
> >> + parse_path_eol(&path, p
> >> , "path");
> >=20
> > This looks weird. Did you manually edit the patch or is there some weird
> > character in here that breaks diff generation?
> >=20
> >> + tree_content_get(&b-
> >>> branch_tree, source.buf, &leaf, 1);
> >=20
> > Same here. Is your mail agent maybe wrapping lines?
> >=20
> >> - s
> >> trbuf_reset(&uq);
> >=20
> > And here.
> >=20
> > Other than those formatting issues this patch looks fine to me.
>=20
> I=E2=80=99m not able to reproduce these rewrapping issues anywhere I view=
 this email: in
> my outbox, inbox, or the archive. I think it=E2=80=99s on your end.
>=20
> https://lore.kernel.org/git/82a6f53c1326a420348eb70461f5929340a930d3.1711=
960552.git.thalia@archibald.dev/

Could be that this is happening because the mails you sent to me are
actually encrypted.

Patrick

--OxTuwT5DC2BHaxR5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYWZ3wACgkQVbJhu7ck
PpQg3A/8CRicf5A4Q327T5/VdHV+2UuaqAk2cJqt67UM9Po0e5tiHjiDfQsaDg4T
4ZNR+u740xuSRoCI1mBofKAZq4k9xPUMFJm63xpfTgBohEOUs5VxKA6IDWe8DLyX
Zxx+YOA4baB9c/BguajzZZ4XRTUsC/rV6vPQTcsO/WT6NnsUXLEWiKGVtT1mB5ZO
bpymp3L1OavRYsNNhhD4vHDLapnAD4Nmh5Khqa6vHNC7PVJLhC7qrvxxrKoAV2ye
jciTFPuCqwLutmDL+7n6BE9ZzZv5xP9TIXV/INEV0ndQd4bB/m60ghS8wzLYvJMo
V0XV9K7deDrYM5Ue431Ky1p5OOzCs2Nx6cc/IEkiWIYLD/vKIZ6JVAzYJMKujGue
LCT7UVH5joe6MZP6JUcDWsRElao4iFdMxWewYQcdxQnt8l+XRa4nIijpcQLnJj2S
wEV2VBpSyRei4lPuLxcrIlEX6Gnoi1+xIeKBnDcQSLcrA1uGYMqSLN3GLp+JTJae
LGVixWZdqNZU5xOSLyMyMGqEsBRDAlXbrBRYMnUSfzsRicA/hM6Rni+2+Wa7DwH1
QDUckRRdtFMUpelkboY18K2liFS5X+glqfZyNSjXNzwwDBn2Wjp82LZV6nZr8oZs
5FRc/liwC3Tc9lKwyt10TZa+BffJgJyvA7yGMb+GvKoLPq2TKKk=
=ZYCB
-----END PGP SIGNATURE-----

--OxTuwT5DC2BHaxR5--
