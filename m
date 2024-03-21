Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D5355E7B
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027382; cv=none; b=N5R+Ms7IeAP9uAE2QYaW8fi71cEH4v+YEEsqcVVrhubcLS3INLKn3HHlYQ1Q6mYqLTtiPbq9srVGB6nqjiwnSYOCiaxpXLv16TFc3tVagSND4hsXVByr18UsFSLKVXOkFZXVW9V+UDP7PJrzzm6ImV/hnUGi60LTdp7UFLyG+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027382; c=relaxed/simple;
	bh=S8SLpCc39crMA5RH4e93XX3a3BSwdBOpK0U3kzzr4I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q98w04Lg3pSoC54DPgkNoze1bgDvaHfQ/SCQs8NmQ5vJzWohP6MuvNQ8+Pj/6kkLZBJor1R3BQT0e2a7OVRH/+jX0r1ZJ0yhJ80fhbCd9WXvzpYyKGXnPA3desvI52mBwmzhkYKjmK/4eM/4897y0vfmyH/L9AOHWXQ3wgYPeyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kWVP2WUk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AqlUuLIl; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kWVP2WUk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AqlUuLIl"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 008721800082;
	Thu, 21 Mar 2024 09:22:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 21 Mar 2024 09:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711027379; x=1711113779; bh=Kb1+wDwo+o
	vtQC/OnaGHG6KuRwI9+DM0/vqUyB30qBE=; b=kWVP2WUkfAUbebvtAQAYCJbGkZ
	aJqLSJWxLt8YvrMh5sPIcBa4c6sCmQsbPthbwosLwPz/OZT3MltIETITJ4/ETD5Q
	IRXxjjo2c+ivxVxopes5lzW6diP3xNt3JNIo65VRg6x2VGeI81CDqfxe8m4iYRWF
	yCAHCrpXY+VkfTbbMy/HAsyjkj0T/lYOWoqObhJKAI++cIZUvvdP3oRcaVUUkn3w
	bdG8PYkMxSPT4GpVIo74RGBEtwrKQa8MdmO0MdMCZ56c+YUdNG4kZebe4H2c5VhX
	XkUA4qP+EOdwrGr33a4AFmZntr/j0c/BcBCkXTjf9xL+7GLvv+aKyt+Ye6Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711027379; x=1711113779; bh=Kb1+wDwo+ovtQC/OnaGHG6KuRwI9
	+DM0/vqUyB30qBE=; b=AqlUuLIlskk35XJrs8Gn8M2wKb16hIAsdj/U2f6N2i3Z
	z/DsgiayXBxBKSr+FqqOPQNykYfkjhJeDlwU3rk+tglff2aPSFUTcuIc6goQJ8Dy
	qq/z1cXIo2Ai/pb6nTJIk2AgKw2QIcLmIGjui3iUJrZemSiQRUY+Uk8HHCYb2gLy
	QIHOEnopqjyWk01DDRJH62isGJna2IJnum9nPZYDUZ6JBkAvujm6GfrFnY+ENmmQ
	kKaDxQYN1TiyYvmYK77N/LbLy/GA4S6aFvzy21EmH6IvFRpvhZ4yOSt6i9fJW+DV
	GQbw2iHI0mTTGNpXN9buoW0jI6vq69TQwuVTLML2nA==
X-ME-Sender: <xms:szT8ZeCJWlBdOqBO5QAFiwkv_xz4WFHdPRibPp-DwNAeQ_3Yi10tLQ>
    <xme:szT8ZYgQ4jAIMsMcBxpxb6p6olbVNRfi93izhz-Ud0iSfrr12awBW5yYGzzVJmZI0
    UOyBgH7FBChGjy15g>
X-ME-Received: <xmr:szT8ZRmS2w9uyniBW5GYcvXYP1kZ-FXH9gYqWCoF6bLvGz_2Mn6vKHlSo6pvDdskjn1_WTVQ3V4hO_FMyNQeSn7p9W7pmlLmkRDjNaLvF-guZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:szT8ZcwWr6fTIKeLxaDmeJDgTRNUSDIqxUTfEVKZLFZprGT3UEAzeQ>
    <xmx:szT8ZTTBW9xHfIyvyv5UNZZwH09cbvQuOY8leVM_i1E3MilHfuSXXA>
    <xmx:szT8ZXaXfPf7IIymLISh-bt43LI0xwsm0eYvxpX2UM2SIrQpFL_APg>
    <xmx:szT8ZcQShretNuFTEMJXpfGi_GCtKOsWFJUvSePBTheJnBknlYgkRA>
    <xmx:szT8ZUKOQPHChHNScx7uf5ef1EI9j5l1EYzdXo4FlRjn99rs8XP3wJc-4fU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 09:22:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e4fe0bae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 13:22:51 +0000 (UTC)
Date: Thu, 21 Mar 2024 14:22:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Max Gautier <mg@max.gautier.name>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 1/5] maintenance: package systemd units
Message-ID: <Zfw0rf7ez7Im1rIx@tanuki>
References: <20240318153257.27451-1-mg@max.gautier.name>
 <20240318153257.27451-2-mg@max.gautier.name>
 <ZfwqCv889UdI0mU6@tanuki>
 <Zfww9jI2em6ZY4SL@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8EdKAasi9QdeEWbN"
Content-Disposition: inline
In-Reply-To: <Zfww9jI2em6ZY4SL@framework>


--8EdKAasi9QdeEWbN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 02:07:02PM +0100, Max Gautier wrote:
> On Thu, Mar 21, 2024 at 01:37:30PM +0100, Patrick Steinhardt wrote:
> > On Mon, Mar 18, 2024 at 04:31:15PM +0100, Max Gautier wrote:
> >=20
> > It would be great to document _why_ we want to package the systemd units
> > alongside with Git.
> >=20
>=20
> Hum, I wrote that in the cover, but you're right, it should be in the
> commit itself.
> Ack.
>=20
> > > ...
> > > diff --git a/systemd/user/git-maintenance@.service b/systemd/user/git=
-maintenance@.service
> > > new file mode 100644
> > > index 0000000000..87ac0c86e6
> > > --- /dev/null
> > > +++ b/systemd/user/git-maintenance@.service
> > > @@ -0,0 +1,16 @@
> > > +[Unit]
> > > +Description=3DOptimize Git repositories data
> > > +
> > > +[Service]
> > > +Type=3Doneshot
> > > +ExecStart=3Dgit for-each-repo --config=3Dmaintenance.repo \
> > > +          maintenance run --schedule=3D%i
> > > +LockPersonality=3Dyes
> > > +MemoryDenyWriteExecute=3Dyes
> > > +NoNewPrivileges=3Dyes
> > > +RestrictAddressFamilies=3DAF_UNIX AF_INET AF_INET6 AF_VSOCK
> > > +RestrictNamespaces=3Dyes
> > > +RestrictRealtime=3Dyes
> > > +RestrictSUIDSGID=3Dyes
> > > +SystemCallArchitectures=3Dnative
> > > +SystemCallFilter=3D@system-service
> >=20
> > Curious, but how did you arrive at these particular restrictions for the
> > unit? Might be something to explain in the commit message, as well.
> >=20
> > Patrick
>=20
> I copied the unit file which is defined in strings in builtin/gc.c,
> which I delete in patch 3.
> Should the moving be inside one commit, in order to explicit the fact
> that it's only moving things around ?

I don't really think it's necessary. But pointing that out in the commit
message would go a long way to explain where exactly these definitions
come from.

Patrick

--8EdKAasi9QdeEWbN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8NKwACgkQVbJhu7ck
PpTwAxAAoMqg/xCV6ujDogOEm6nDCHCJjc0RyNHlM+DK9uBXFui4j7S1GzKyggIt
73msLAte6RII5k6UhXxijPTBVayKHr9cnRlGm/zgCMYmUIffGM8G30ekwUpVRJ3T
NgP2MPcRcKY6HMGx0AfXTQILuogls4bzomukzD0XAPOOkSkAleQBtSxuCGyOr6ma
cINtl/+poPvm8nGnQMTktYP05uTDpkdSzWWD0KNU5LDlU2VhTqchrvbE5TH9c0aF
oFf3CT8AsI6iuY5+3ti4kF2c7KqqqpjYvA+uscIy7oEnI/TMLwloQKEEbIcPdEBE
vphOCxfjJ8rG96HQpbroaH86ebHahk4R4UmFyWSkECE3nXcKijE3Ph51/+hnhwBF
1g7lzqxy21Dliw9LSEbES+6b5wwQZs52IJtxfcXgG7YoBAn2IZrmwuyXzpSO1X2N
91TducGUZ2bj3X3u1QywETqg28xKrC8T6qz0qn5dBmZ20h0uEHR9TzVX8hCOxfQ8
9+QVykYz4WQXMaOIDIR8UFRnXrJxMIjlkhARWCv/y3svJoDdjr7+wg6xJWHMf89B
NLC8EeENkmzcbmZa8Fgk3eDkfhVZPUt1sTO8Zg7lgEICrdKkcBzK5c6TkHzapA4/
OzGMheGMrkcvaGhn3SxmRsEeO/pbKKGIJVozh2/38XXFLhJQt6c=
=lkUa
-----END PGP SIGNATURE-----

--8EdKAasi9QdeEWbN--
