Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBBD15FCE1
	for <git@vger.kernel.org>; Fri, 10 May 2024 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335027; cv=none; b=AipyDevNKAUqZAzd5ZVadW1xUPqH0OpnbaZFNOkz/N60mlJMnlZlJ8bgsanxgNBVx1a8iiKfGvZt6ZkIrT6fht+7eshWQ92vQaNj2a4xg3g21FJxPxY6+wxIVaapNP/tWmB09Lxgi6JLqE6HmCMyMc+m6FTT+uNPjeCt/qqP8eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335027; c=relaxed/simple;
	bh=S4wEafXKDzj13i11D+SPH6Rq9fUB76PaM5jkyoS2EBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKLdvTAzf7E0V2Wv6M2gLY1GzwUJe7ZXe9Ow57jcUG8gHMss05aD/lhP/qVMM+Gpt/eU+FecAH2f3dhERuGcBa2bhg3TsBQ1cgegkRt4OnKRpudMt4hlA4/pR4ed5rgcJgNSDGSizC1LhdA79z1HJ+rigO7V7+UIO3DAXO2idp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m3QLigq5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dw5MrKRD; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m3QLigq5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dw5MrKRD"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id BBAFD1800158;
	Fri, 10 May 2024 05:57:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 10 May 2024 05:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715335024; x=1715421424; bh=VuPnM61KkE
	Cf81DGiB2rQB/WCcCL6IPlGi4ONhNk/VU=; b=m3QLigq575HzKT62vZE6lKZXtU
	J1hJcPWcR8ZyiBHTkpf8Mj0K7wejItMGPD9/34Jnbw4xYwPoxyXeKTdvth+7HFR3
	sidFWjKy1qzHyVNTPLzudd1NqIZP2r4mjVUNvyGypqRvBHhZsYEEMYOQtXRRJMuZ
	Ir6uIxvzASovOCoJEugWDxtwFiFWCjAWjdUroOZTd28fy+CVH1NmVR7SuBZZ4vCw
	BDM1gG83nccDT/1rI25dnDnyMuW03T5Rh0qEKBvzwmEqdXHh6VnHir6CcZUKTSJl
	KWrFZySrSjqt48uLgwQOUq1ezY5sosVWbbaYzGeh4r8rJcsR7czWoL1uMm3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715335024; x=1715421424; bh=VuPnM61KkECf81DGiB2rQB/WCcCL
	6IPlGi4ONhNk/VU=; b=dw5MrKRD3VC6DVbpnNt1myvnmi3sKfVK7KZZLYMDQahr
	1MSGuoCDtaIbnJXVB3HL4fwRMKV82ve6wU7xF1HVke+aeqZSxG1Pk+Jyt1DK8o9r
	k/a2NZmzys9NsxCS7bkmYPfAVbXHE77qXZ0zp72T5WdsBT3k92v7ZWClP2OEf4or
	Gi4MrwGDoD6ftyD65kZDOmj5J1h/LoGu35BgqFIv5Gte0Eqw/Gmz2dw0Yv1fndAO
	yzuTlLCe+n8eGcQ4MejNgOkztRKCZxGVJJu9xGh1Thvn6GB8mQgD/PDAKZYGhJKT
	x9Rqd67xE6pijmdDcngbbVhDiECa5HdpYkwpdus39Q==
X-ME-Sender: <xms:cO89Zjv-hRnlcHYGFNFNyLQuAs4zNjssb1DiIt8LQV0ypgZJc8u6Gw>
    <xme:cO89Zkdd0BDSdaHCPnUXeeZH3bGg55B5Amt9wC-k5McPoSL1y3IRw8AjqFl8SVcl1
    d_ZLsVrT-pvjM1hag>
X-ME-Received: <xmr:cO89ZmzZWeOhJKebVj51jLF3R14mYsfSqplvAg2t2_itPM4GA4co9ceAXadHLMX6ydUC7mjT9rGaUykfdJVhO-FmEboVgFRcpzqPCq8RBJA0n8EnJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:cO89ZiMHDOOPa65KDZEUZ-26eK0NbSSTteCjeODV2MP6pez_hEpbKA>
    <xmx:cO89Zj9AEKUyykAQIqdfEP8bGoVjBvUCcNbpby0s3GytzcH8q4Zs_A>
    <xmx:cO89ZiWRnj5vRsfndPBsymtkChsL1KxcLylJ09z6svmSzelnkBQvtw>
    <xmx:cO89ZkecpHYZbFr1nwpbgBTbtcVWtkJbQb_b2Vod9cPQeyllZjrOtQ>
    <xmx:cO89ZmYWmGlJ9bMHhGWLhxylGcC4TGrFDmCnTFGoOajp_8FCcJPGGU99>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 05:57:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 25d24da8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 09:56:48 +0000 (UTC)
Date: Fri, 10 May 2024 11:56:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Subject: Re: bug: git config --global --unset doesn't unset configs in corner
 case
Message-ID: <Zj3vajAeJKuRaCvn@tanuki>
References: <20240509021352.se4u7ajaolveyyjf@glandium.org>
 <xmqqmsozuf7y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tI12pm4Z9/Oum1OC"
Content-Disposition: inline
In-Reply-To: <xmqqmsozuf7y.fsf@gitster.g>


--tI12pm4Z9/Oum1OC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 09:23:13AM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
>=20
> > When both ~/.gitconfig and ~/.config/git/config exist, git will read
> > both. But when using `git config --global --unset`, it will only touch
> > the first one. So unsetting config items from ~/.config/git/config is
> > not possible from the command line when ~/.gitconfig exists.

This actually works as documented:

  --global

    For writing options: write to global ~/.gitconfig file rather than
    the repository .git/config, write to $XDG_CONFIG_HOME/git/config
    file if this file exists and the ~/.gitconfig file doesn=E2=80=99t.

    For reading options: read only from global ~/.gitconfig and from
    $XDG_CONFIG_HOME/git/config rather than from all available files.

    See also the section called =E2=80=9CFILES=E2=80=9D.

Whether that behaviour is sane is a different question though.

> Interesting observation of an understandable behaviour.
>=20
> I think the original intent of limiting the writing to just one was
> to avoid having both files in the first place.  When both do exist
> already, I am not sure what the right behaviour on the write side
> should be.  We could special case "--unset-all" and remove from
> both, but "--unset" is to remove just one, so when the reading side
> reads from both, it becomes "which one to remove"?
>=20
> Comments from those who are more familiar with the "git config" are
> certainly appreciated.

Honestly, I even think that the reading behaviour is weird. For almost
all the other tools that I know of that did the XDG migration, they only
ever read either the XDG config or the one located in the users' home
directory. I think this behaviour is quite sensible and leads to less
surprises overall, also to avoid asymmetric behaviour like the reported
one.

In any case, I find the expectation that `--unset-all` unsets all config
reasonable. But what about `--remove-section` and `--rename-section`? If
a section exists in both files, should it be renamed in both? And
removed in both? What if you set a value with a value pattern (`git
config foo.bar baz pattern`)? I think the answers are less clear in
those cases, and that to me hints that the design of how this feature
works is off.

As said, the most reasonable behaviour would be if we started to only
ever use _either_ the XDG _or_ the home config, but never both. This not
only solves the reported issue, where it's unclear which of the files
should be modified. It also solves other problems -- would you for
example know the precedence order of those two files?

I have no idea though whether this is something that we can reasonably
change now. I doubt that many users rely on having both configs, and
I cannot think of any reason why they knowingly would. But it would be a
potentially breaking change regardless of that.

Patrick

--tI12pm4Z9/Oum1OC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY972kACgkQVbJhu7ck
PpRiiw//aAVhTp7Lz9Kk6L9PTq45pO5wlwnm7t2PBQ4a5nMl1k8lvvXPqq2gGMdM
IzihuW6qa0dw1xqD1S1w/E3P0FtoC3cqC9Shh7MnO4nhv27DG5UYxIS3kV7xk+VO
1gOHOc8E3iW0wjsD7uR1tIknDYnYGdbh6eEh4JF6eW1qMsErc4U8XAkJYl9F2gYW
I8Rs43RisUeKCnZ2FjZNkICegwZGZCUQg7imvr1PWOaqdUz6P2L5/SfOOPzta8PT
Shgq5BFl2hNBX6KGY+ONaynwFaZ/n42gay60lWsLGNZJ0q5X0ooIYvqr0D7bOH55
1qPshMOPDq/r3QRm79e4x2ur36KiiFXAxBqt7KEKFQO4I3DbQcM/7BhWNQ6IbM0s
XuuDpfaqJc7q72pvzHbkhQnbQHhMGjhfx+Ufx1XKpeUKKszb4wUbGM4SWEnkLLtq
bMNv9vo0tifZobU0U88mZSO4j3ot05Pzuf+M4GwUTkBfhQkmvZb5ZDg+vxtbjxZe
yeuAtpS1Do5csGtov4j9715j4jq15JPVbIc76ZvWM/5jADDJYAjt4MXq25CpaFV4
MmQInooNTHZet2y7feHqxpm0Vr3OVDkmqC77NxcOEHj5gdCuSdGP4P/nGq2iTFOK
zpE6VL8oYqIOURuzXxVWLqrzfNiSOq70S4aPQIQKaij1XXS38T4=
=+X8S
-----END PGP SIGNATURE-----

--tI12pm4Z9/Oum1OC--
