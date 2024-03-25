Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E21966A8
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711351728; cv=none; b=clF3/ZtvoEvWEzlG9Cnqnx22VVkHPnTXBQiOyzpxSWGnnt/XYVUROX9+ErDJEcy2ZJ8GQ3NEVlXJtrAVXhSDrpNfndKHnjMonq+TZKwMZd06+a8rCWQzefBEjqh5PIeRY/WSpKDDzKVrPS/Mt3PlWvQVEkZBIL/jPP6GzRUKjO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711351728; c=relaxed/simple;
	bh=fpfqNbN2zph53Wn8McEIHYKb2J8psfvaGBZGXnRCpVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSO7mklwk+F65uk3F0cTDPC7VhbukYKQNS31LLBq+Yk01yW47cmclMMzaY9nONvsAr2x+bZUrGid5hhkaw9RGCVMYvZ1iuqMLZZTSxQtED2GxBGHXnS37AndvAVtb7qjxFXLNf5LTzvmVqZAYO8YDTr8VtEfAOBW6HYI+PCOiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cjveqGvH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NiuLk2V9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cjveqGvH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NiuLk2V9"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 424FF11400CA;
	Mon, 25 Mar 2024 03:28:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 25 Mar 2024 03:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711351725; x=1711438125; bh=fpfqNbN2zp
	h53Wn8McEIHYKb2J8psfvaGBZGXnRCpVQ=; b=cjveqGvHW02i/tvW2d3GQHdTOB
	hSQ4nv9dzYPtMZcykNjhpl9m5DZGYMWOMaZpa4N3CUB/loyzy35XJNzqPOKEWlZl
	oZwBJ8bfpSPHXwDAT2tPWSK1tcN84SdROSGuU5az1S7tmhlSCowwIqXrzx1xIeEG
	r+BfjQjPkybx/7tW+5het+BAN9O7kuy4DzUqKFhmIvlrvo1W7nmpfPzTsBTzQQRE
	iA0obwyw1Wcub0oRrw488dc7uO5Rl5/uqd52iDntRsvZNSvsuz7taJ6fU4LaPpye
	YI/mRB1gaHbFK6sr52qJ36dBnQAXnBprKvscrIYER8N6PCO6fiIZX+Y/PXcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711351725; x=1711438125; bh=fpfqNbN2zph53Wn8McEIHYKb2J8p
	sfvaGBZGXnRCpVQ=; b=NiuLk2V9DH5l6C/ToelSCSvtCNdKW5sE09TR19iKnQLe
	qZT62PH/EacXQQ9GGidNvFvoH7yXHaULjFPY1duGYulxIR0ES1JZpcSUWCSgQuju
	2nbCU4jFcxDugUqm9OFQ5qEBklQ3qkTDBRih6YT12ly/6YiTYQnLeeOz26yuBMtJ
	19DdPrBDBt0fIeeqSKXyC+pVKndAedRNlJaCO5ucEy28Bb19DSNO3tD4/IbwW97u
	BNO+b1z3xbxyiAIsEBOpE7DbfDI6IHGmtoLw75HqPnvWsoPKZIh0PAFYSbFVD1I8
	vmjBN2Fx/vJu65sBn+x1RFPlw84gnfW3IP9CxnqgWA==
X-ME-Sender: <xms:rCcBZkgjdgeepyywPzMFWaSK8sMBKz0VHmWJtSLFyEEIfcD6mLh_sQ>
    <xme:rCcBZtDRVY-wSdcHCejdZStV5Yw8ype4NJKs-lZdhNZJ3TYbZzCcb4CcRBNq10u6C
    lSb-Q_9UMWRh-xTkw>
X-ME-Received: <xmr:rCcBZsGNK-W709V5YRG_XhOirv30KKbMRuNSE7NuVH3Wy55Nx_J-FOho5GLtG4PecyFOMXl3C5ItUMr0aNtHo4tKVxdKAIGSNVEQRszidw-mFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnheptdeiffelledvfffgtdejgfevvefhle
    etjeduhfeuhfeiledvleetiefgkeejueffnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:rScBZlQttgVEYc-LC7Y7dznfy1-Vi73rXYXCJutxpAnJPbTahqnwHA>
    <xmx:rScBZhyJ_vgwEP6jUHip9zLdAZtgdZu2EXZSHu_TNbYWRjsCTTLumA>
    <xmx:rScBZj4lRuIqPjgth733HD8rjAd0x1vfgnb-kMryQiDjjH83rJ4qgw>
    <xmx:rScBZuwgGenG74VWPn9YgL2src_ZcOSwUqAUwO7VOL0SVE850tmSbg>
    <xmx:rScBZjthvVID305QscJ3vYfCqoL-JwYzLUPLhDaiJk_v-caSrJePpw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 03:28:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0f044672 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 07:28:32 +0000 (UTC)
Date: Mon, 25 Mar 2024 08:28:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Tim Landscheidt <tim@tim-landscheidt.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Inconsistent/buggy behaviour of "git config --add"
Message-ID: <ZgEnqE23PYVCNeKc@tanuki>
References: <87o7b5dj8h.fsf@vagabond.tim-landscheidt.de>
 <xmqq8r28ygwi.fsf@gitster.g>
 <87o7b3xxta.fsf@vagabond.tim-landscheidt.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8xHVShCUe8CAGyVq"
Content-Disposition: inline
In-Reply-To: <87o7b3xxta.fsf@vagabond.tim-landscheidt.de>


--8xHVShCUe8CAGyVq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 06:57:21PM +0000, Tim Landscheidt wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
[snip]
> >> My expectation of least surprise is that "git config
> >> section.key --add value" should be equivalent to "git config
> >> --add section.key value".
>=20
> > You cannot have "--add" as a value by doing so.
>=20
> > [=E2=80=A6]
>=20
> The standard way to achieve this would be to use "--",
> i. e. "git config section.key --add -- --add" (apparently
> even part of POSIX as "Utility Syntax Guidelines", but also
> commonly used elsewhere in Git).

I think the whole design of git-config(1) is just not great, and I'm not
surprised at all that folks run into issues like the one you describe
here. I agree that it is quite surprising that modes like "--add" look
like a flag, but don't really behave like one in the general case.

This is part of the reason why I have recently proposed to convert this
command to use proper subcommands [1]. This introduces things like `git
config set`, `git config list`, `git config get`, `git config unset`
that (in my opinion) behave a lot more obvious. Also, I certainly agree
with you that those subcommands should respect "--" as many other of our
Git commands already do.

I plan to reroll this patch series soonish. Please feel free to provide
your feedback on it so that we can iterate on the proposed UI/UX and
make it match user's expectations better.

Patrick

[1]: https://lore.kernel.org/git/cover.1710198711.git.ps@pks.im/

--8xHVShCUe8CAGyVq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBJ6MACgkQVbJhu7ck
PpQSaQ/+K61F9f7gB8IL+6qT8jIQBZY+CeqV+npckznpSIYM3xlisHYaJA3Wr2DP
oe1KH9FBf8tn3vLGBbBCeVpIKIoOJZB2XRUWEVpyTHblxj7ev53eK9GbLmsEcfRa
5GosT6V781zr21yNUgwwZqJeIy0JNlI5q44B/xYvv2O17zvii6i25Q1a+tkdsF7H
R/p6eIKFkP1r8H/4H3Az2GgsYBVTByD+mkQC+mg60DPKDC7Bx3MEBGLS4IGKOIA+
m0HVSs/+K20LcqHMC6T23vTjF2Q48c+cjrRGvOBs9CnimqPhzMGbxb6AQb8jDT++
zDXS9JaPtdroJEvPX4wRxfue/7Ihxl8vL5KssNmOPwCjRtXFRShrDmmi40q8fw21
u7Jz6lG3SqLCzQoz9bk0HLnv+Lk6UV5WhkaGnP5LgD1tzZ//8VOJs8fOlMBy6+Zh
yaa/ovG5CQcEZObWKV9aPx41JnNBkn3A91rTr8Asxe1emb/FBRiMpwCihfwOqJKx
xQGxTTzKvhjcuDftcmDHudRsLMJvxygIOHiDQwgcZXOsr7v5/9Zd7uB+Dy3+9Xby
XG+aNi/1nVhoYJtny0lYNU+LGC2e1gsdlMIED9Nddj3+cHC94knduZ68ZoFIcP/y
RNAO+3cK7ZZL0OMBbLJS+0kO9l1GAz5r4XZI8eLfE07Cr55VkhI=
=RU6E
-----END PGP SIGNATURE-----

--8xHVShCUe8CAGyVq--
