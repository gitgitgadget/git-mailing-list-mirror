Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F15CF4EE
	for <git@vger.kernel.org>; Sat, 20 Apr 2024 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713593799; cv=none; b=Z6CF0wOde9Kf+b4U97cmLyFH0ixzTcKN2GWwTmeMY6Au/ivUt3SuRGxJWp7Aadml0voC0nVAUaf9lUpAsaWMCyGK6aHIjddU/0PFSA5rRsgWVicgYc6uTHa5JSM2cE/86sgFZoh1FgBCgc34Ysb7Og1127WVTn3CopmsGHmyPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713593799; c=relaxed/simple;
	bh=0nx9ETBBT8OtVFHNmwcbxuNNB/5jrprEl4narGO8ndo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaVMc4EuQlfF1RDbkaYlm3l427vA5nrYjcR83DdX5kvW99Ut9rzlAvaFQ6Fye40TfZHktceLRad1RlZUFYKYEuTlJFHs5qlzgs9Mjwacvb6fRgBl9IXnypE8C6xiGtkGZSDWG2bo3hKc4f1Oygq6YB/n+F5Iag4zzjaWPuNQ/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kW97DLdX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJxBqYpA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kW97DLdX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJxBqYpA"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 210EF1140130;
	Sat, 20 Apr 2024 02:16:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 20 Apr 2024 02:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713593795; x=1713680195; bh=TWodP+VOk0
	rNvpf4f6yvnlK5N+rWRg9wYwv/YTXIysc=; b=kW97DLdXDFl5J3ppYtkPRm5ceG
	RYrvGWTZq88oHOtUpekpV9kL5P+G2fWZa7A1tauE1ueL1p+TVoRykNHUAQUlfb9U
	ZEKy7q8VKyn3ZDxNJpg84hnDEufLpFpNLyGtQb76pEJnJ/01p8xIWlVu7Vq9mwvB
	Oi1Q3My5KzFpcY1hQ5fj0UnC/xGILkVPGM3na6FSZ71i/yrbs3vnacp+Hn+KKLdJ
	rB3/J79/1qcI/07LzW7IbIrbnVVABjscwnD3rNXaHn9qA41P1KqPoG7spNw0jEaj
	e6ufciWDSraUMUnVLnZn4ogcSl8ANDUBv2PvyYcd5JYktjlC6lzKWRKvxpKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713593795; x=1713680195; bh=TWodP+VOk0rNvpf4f6yvnlK5N+rW
	Rg9wYwv/YTXIysc=; b=bJxBqYpAB4ZlETPjD2+3IunhQOSHAFxLUPP7P4agfmph
	nKJF7AarFoCwIdfmQGSCqOzM8Swb6cKjn2KPcCNfIK27fkW4ucIgLraSjrW/LRUO
	d7QCRCTIuTOh4zXVKCdNc0Eor9ZPB6HPKV8uLJC0t1Kfxc8cY+dG0eh+W7A8MKA8
	gt7WJn1C1XNgY7WLa9i2B35JVsSfG50508q7+X4mcsU19v0exoZVz+bkjxRHNpbx
	VOYVTggFAgzVBjKU3uh8gYvWwK0GetcyWzH51VZDnTv4k8inA9YCoxwAUrsn3XhX
	pQ+S4QyHBMYOnYtM2Q4fw3PPgUAmrXarLHmDrrQ1GQ==
X-ME-Sender: <xms:wl0jZvsvS8-2AXxhW8idD7Otmbm42Dl96ZhSO6h54kILPkFyuzLltA>
    <xme:wl0jZgcMef3dFMxqCRJ8lwfHRghlxFCvRx-4eFR8vjicvuP6M4lhCymIy5abKaI3S
    va1oy799kImMWbyRQ>
X-ME-Received: <xmr:wl0jZizBLM25bS3ArXUGY9XvKGYKc6b1BSmEQKR7kXWWF1ObsUxU-Xo4NGBMTBypVvgcpu5PZCAAU2KcHkdc54qp9upSnhcnSLREjZo5Yv9niNfvtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekfedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:wl0jZuMzDxMSHIHwd45US9whVEkSfk34NzQh4bk6bjuV8X2_UFTCXg>
    <xmx:wl0jZv_NnrEA4N41BARH7fB6i4rTn_VpcOMRlBCMR9FIbhGEDSqrhQ>
    <xmx:wl0jZuVrq9cEXjoD2dIBqoIQfB247OYMpVCho6BkKmBQG1-VQLRIGA>
    <xmx:wl0jZgdAplZBN7ioMCe1ZcUbioxWCIY33-7nnuxWhsTG50YNbAXBOw>
    <xmx:w10jZrYoJ1zhbAFkpB3R8bXonpwvGxlpp8Sfp5AbS1EWoluA50mAZQo0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Apr 2024 02:16:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e72add32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 20 Apr 2024 06:16:02 +0000 (UTC)
Date: Sat, 20 Apr 2024 08:16:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/7] update-ref: add symref oriented commands
Message-ID: <ZiNdvEhuhtH87Mw6@framework>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L5WESj7i/lfR2TlB"
Content-Disposition: inline
In-Reply-To: <20240412095908.1134387-1-knayak@gitlab.com>


--L5WESj7i/lfR2TlB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:59:01AM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> The 'git-update-ref(1)' command allows transactional reference updates.
> But currently only supports regular reference updates. Meaning, if one
> wants to update HEAD (symbolic ref) in a transaction, there is no tool
> to do so.
>=20
> One option to obtain transactional updates for the HEAD ref is to
> manually create the HEAD.lock file and commit. This is intrusive, where
> the user needs to mimic internal git behavior. Also, this only works
> when using the files backend.
>=20
> At GitLab, we've been using the manual process till date, to allow users
> to set and change their default branch. But with the introduction of
> reftables as a reference backend, this becomes a necessity to be solved
> within git.
>=20
> This patch series goes about introducing a set of commands
> symref-{create,verify,delete,update} to work with symrefs complimenting
> the existing commands for the regular refs within 'git-update-ref(1)'.

One more thought crossed my mind this night: is it even necessary to
introduce new commands for this? As far as I can see, it should be
feasible to introduce symref support for all existing commands without
breaking backwards compatibility. This can be achieved by using a prefix
that cannot ever be an object ID, like for example "ref:".

Thus, all of the following should work (with 1234 being an OID and 0000
being the null OID):

    update HEAD ref:refs/heads/main ref:refs/heads/master
    update HEAD ref:refs/heads/main 1234
    update HEAD ref:refs/heads/main 0000
    update HEAD 1234 ref:refs/heads/main
    update HEAD 0000 ref:refs/heads/main
    create HEAD ref:refs/heads/main
    delete HEAD ref:refs/heads/main
    verify HEAD ref:refs/heads/mains

Parsing is unambiguous because we can use `starts_with("ref:")` for an
otherwise invalid object ID. Furthermore, because refs cannot have
spaces, we also don't have an issue with the SP separator.

I have a hunch that this variant might lead to less code duplication,
lead to less confusing behaviour and also makes for an easier user
interface.

Patrick

--L5WESj7i/lfR2TlB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYjXbYACgkQVbJhu7ck
PpRhwA//WYiwGCSSVXnNiel0n+4DibTpsIQ/T4SBdM/7VFd1griynai8jah6XiOS
HYQ5KjxDGF+jNqui8EwdgbMLp4VwX94RV5HdBEfIHHGY8BIBfNwubxOx30MiX5Fb
imWhDmpwKsswBTUxnxBKGfd8H9PI82y8snUzYWH81FE5geBu4bDoFo8Oufk+bnMT
C0lRvEZ9gto9ZLQzC3tnY4GVQpxcX+v7JHJZv/+qzFVILVo51NPzUJfZFxkU+fk1
Q3oW4ukL5KhiwHraPQHaZh0/R6eIRC8Y1MB0hzY3bjfecAVpq1cfe2we/SWAS+Xe
BOaiF7evLb0YjXuDWrXEVRBmwYGUzVf1mjI4lS33dA3Bs61SEgrtA4CyMtM3o/MA
tmQST2b4uGZY9UmWkJAFd3634Zyg20eFWhmX3SXmjzheJD2kxRQG53ucL0fH1mpb
95Wc2f54TKP4zhuPsKcDU9TpGFtBW4WBkmzOfgBSiKB6SB5mflnnsws5yiYrl2JH
Ix5cEbn9z5B5QdoiNOjHOv19jTLtwgTVHIoB3477bYVvBTzy1bdpVA8zHDUQ+zrb
1LPdMLU5TS9Q9riBTa5gBx7L4JIuRM9koXRh5M0rTYxDxABcLHpt4LlozVHii4/k
e5XrJahiSJz1S/ZGaSF9b6MIPa6Bf+Vrl9T6g05EcT8uzkZKA08=
=xW92
-----END PGP SIGNATURE-----

--L5WESj7i/lfR2TlB--
