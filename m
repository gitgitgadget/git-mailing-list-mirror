Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D89813E41F
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666852; cv=none; b=MCnWekvYGSNDzMmamYWpIm+1e8RLf203YXhM8mqnr8SfQwvCqiyfPPQTAgA0n5d+IrPg3Gzja9Qky+5EDFS4RMJpfEzTs208aFbZZ6aKBTiFayeWkfcshHgoYnW22AJ+3pAXgnxky7eUM7PvnastIZvBT1iF5pwxGp5aPeLPRZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666852; c=relaxed/simple;
	bh=jSsesADse4Z/esX5Ko/+TOOPCaYZRvWMYtVM3wz18Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8JW/XA2Rt028T3rQBYuSyFpVDkhVLxssrwDZ53ijvxBRqg0J8Wp2PJ59R+FkLskNAvLqga8MFs+rJLTZ/KqKM7yfLpRJ1xihUueQz79nrONItgjo2it71poT1SpbAC+D2v1GKyC6mVe9u5z0W8xHCsdimjo/kb2URQ+kTNUD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AdE4tw3/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nJrXDGlg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AdE4tw3/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJrXDGlg"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id C15CD1380185;
	Thu,  6 Jun 2024 05:40:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 05:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717666849; x=1717753249; bh=jSsesADse4
	Z/esX5Ko/+TOOPCaYZRvWMYtVM3wz18Xc=; b=AdE4tw3/Zz+6MjbTSj0jjOoCwM
	17HKbTV7qJ99biqe72nSjiJj68LZ8X+mEL/dE+jrqVswCRNtTt/JjG129PhUChi9
	tG9yPOW9d8lgx31VMMoHyHubxdpK5HEIkKrzSgiQz+Im19EuVr2tZV1yJPz+gnhN
	y5orEa8mCqyfh01GA6fdxdSNiSMaSxqWhimYlkm87ZyDqAn2yYb72JjyvT6vvGqu
	3upQ+rLxXGy93sc4bI69rui8KePvePUus2PRNKCflhkffafQ0HTmisGbb0RuF8Ta
	E1H91uZ3yqBSqCiUqSw3tClKe2cqD8sXtBXG3Ai6wAmDLN0EMojUDkdzoW/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717666849; x=1717753249; bh=jSsesADse4Z/esX5Ko/+TOOPCaYZ
	RvWMYtVM3wz18Xc=; b=nJrXDGlg0Jjg6EaX6Swtpoufcq5vowayfKSo4Dp9pWHP
	Ps1s1KQM1p65WI/X2/hbiuqSEqFDn387wZeuwgjlxRG1Ep1x8vtH1RyF4JfOeJ0i
	Agh5vMBytN75Ru7FA8KKD6r/mf1Dwgtj2358NIiA5OinKRuNrMuuEEKa2kzxAi13
	clGIk9VVWfTqGeBjA6Y2KeAanuBb2c8veeRf+vxoyRWJ7BPv699cd/1HOU/vM4o5
	fdO/KHDI95katf1MV3HoU17fSxflDf4jjjhJSOOS8t9Sm+oRXW0Mnut7cfmsdB7D
	uIExQ9o2jrzemAu0colD3J3E40TKPmIkc5/HiB6r0g==
X-ME-Sender: <xms:IYRhZmalxA6XSEYkSit535ROeIhRbY8g0BnBgvzzc_R6q3BPxJIGYQ>
    <xme:IYRhZpYsUiyciaOypfHFi4Gs9nqYunaVHqr9B-pK8rLbJuzMn9gTize2vTIITjwbF
    LRUdb7rCCe14lefDg>
X-ME-Received: <xmr:IYRhZg8YtNhwjd2GZ5b_zO5ZXFhG-rKInVEH3co5Zm4xRptkvhEmuGofvQez4HSnZzbG9lf9zYkI0PU_E1TMgW6BRP3qRBhdgjRyorK_IdVhceFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:IYRhZookA4ea9SJPlJgPxqMOmpgJ3CnR-dHhupQ5OtVV6LaaYIGcjQ>
    <xmx:IYRhZhpPpuaUgzQk3M7L4KeQhj5GlQyGjJvbVYniaBWvziSSCOb3Hg>
    <xmx:IYRhZmSmv5jyfZ3oXBw4Z7lRL42gN-rF1G1NnYrR2_cHjTfFW97XgA>
    <xmx:IYRhZhpC5ccy4S0GUuIKK_AIDR7m9wvkQ8BgHLvolOjhKj9r_qocDQ>
    <xmx:IYRhZo1lHlh4n6VDMQLxG8Q01gwqpkIsEMCJsRzKOqiKwpg2kSGLUjo7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 05:40:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5b31278e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 09:40:17 +0000 (UTC)
Date: Thu, 6 Jun 2024 11:40:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] add-i: finally retire add.interactive.useBuiltin
Message-ID: <ZmGEHuNZsfgczr7X@tanuki>
References: <xmqqikynqdvq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3NF6GWTGTT5nhhr3"
Content-Disposition: inline
In-Reply-To: <xmqqikynqdvq.fsf@gitster.g>


--3NF6GWTGTT5nhhr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 02:27:21PM -0700, Junio C Hamano wrote:
> The configuration variable stopped doing anything (other than
> announcing itself as a variable that does not do anything useful,
> when it is used) in Git 2.40. =20
>=20
> At this point, it is not even worth giving the warning, which was
> meant to be a way to help users notice they are carrying unused
> cruft in their configuration files and give them a chance to
> clean-up.
>=20
> Let's remove the warning and documentation for it, and truly stop
> paying attention to it.

Makes sense, and the changes look good to me. Thanks!

Patrick

--3NF6GWTGTT5nhhr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhhB0ACgkQVbJhu7ck
PpTUIRAAiw7vbReAsrXmEbPlwB4wOhVzwdmsLipRA0KvVPH/0rexopGLGWafI1Ss
9pEASpcxwNsY48t5O82Jta6XHZu8h0Zx3qIYQB7YEfdhE+7NLyErcFFKKmOhYsCf
45FsCtqA1CWXCZ3pmbYGCb8rgy8g47HMVKp/AgzxW5By+EcxImKy6aX4qQdDDlcJ
9A7ID9+/J4Ls0TzHieffSmiOvAl4mVBB79gDo/BVzqO6Fsj3RISOppB/ZZF+mZvE
kRMKkPWSWGfsv8ZcHtEvmHsRi1XGIKjlB8vfFcrDr8ZipIZLC6PSuBBZqHBP8Ru0
+BcR4Rwe+itob0fv+ajp6S6JJBPeXMqnfivuca6uJfpp17zPkp2Nzorhi/lVTkOD
NMMRshyc8UW5VhlZwNONyXA9+1RiJXlFfb0j3OL5Y6GqYd1FEUJ3uwSxM5SdHNub
5c0ueGWseLoo4V1/IZSwzcsgfvVFEMIfQcan/XstXUCI5owf/Hjo4LdyJcgs6+9a
juO2z/fbdhlEjd5sA8C7yuWWkWBejJT8BlZsfC8yWbYJlpNoUB2CajicM4uCMLHu
dcskxekO9C16Xbb1ll53r0LQcBOKJB1Op6ppVXtWLcXp09ztjKP9gFDzRJ0CchJm
AJhx0Kql5Q0Os9V3DnNRVXKxI66OolCPfzbGT/Ee/OGEumlmLjM=
=GNIs
-----END PGP SIGNATURE-----

--3NF6GWTGTT5nhhr3--
