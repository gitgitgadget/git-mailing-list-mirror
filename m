Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9CB15533D
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759194; cv=none; b=Gk0LIjCGBW3RLXT4yOgr5deEG6BHMNds8MgwMZT0eL+h7VtSdW4D5SmlqF3wqZ8QRVWtiKN2u1Mc8mmY+mzTFiH6xJmDtSehCAOU4xR+a8SySQGaNI0mVxcrxYgI3XTaYr9P2QEPRxo99xyveZ6ru0CJjMb2hjdJDRyT23JchiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759194; c=relaxed/simple;
	bh=5oAMuP4HOnI+iQGFA2Qgxl690CFd/2B8KhOL9BP6Khs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBia7SQXeXI+VkmHSTH9SYMTtZIbqLlnBIT9whgsmVndhIYg8p6RppK1mcJjefKHYkAdkBbdTEYCUDv+LAmgm4gdBKfAc72/nuQOpwYFIbx5gSlFd+fThX3gI5SYHJlaWXhpG8AiIqv9xlPvWkNkMmz2EO1L5o2Kx6hV7WtZgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iVCQWHdZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e/s81geH; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iVCQWHdZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e/s81geH"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0BAA11140173;
	Fri,  3 May 2024 13:59:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 03 May 2024 13:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714759191; x=1714845591; bh=5oAMuP4HOn
	I+iQGFA2Qgxl690CFd/2B8KhOL9BP6Khs=; b=iVCQWHdZ0NukNwAyVnZuWmgIcI
	s1roqhtPOMYXvkBN8n/wN5k06qWpZQQrmYCzD+ZOrgYuApW9NV8CURubeD2iFhmw
	KYTQn+MaVoJ0XYtgshZ+HVDThFQeIBSLAhtmSKPgSpkADo6dEY3i8fxzjKHtF7zP
	t7b7sQVI0SFgqgQyWtGbrN+ujMpBammrT3vps8x5NTx9BgtgfyaznixZV7Fu3ZHM
	NR7lFePse+qzwzcVfr5rjZ59Yh+jl4W91neySEjg43upaixSrFMDFBs63Pqa/Ktz
	yGOUyLD0k3Cc4/skVEGPG55xlCJ5pyfowjmo2dJxPIE0D0HxAecJ/wvGISXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714759191; x=1714845591; bh=5oAMuP4HOnI+iQGFA2Qgxl690CFd
	/2B8KhOL9BP6Khs=; b=e/s81geHvMyfdcsOO0iGtqWExuXMzBPUk83+BNHCT6L5
	mSfMntDLUEFyIxhZkmb6BoBhnLeU5cREHZoBpMFTU/CnHAOXLf0Zm1g/CmjW1fKm
	TQryUdCeO2Oq3pwF6IsI5op/K3k+w4Szh0EYYJb6o5BiD77gD6lDZJpTk1M58W1o
	88NdUrASKx6zuRmrwlamc8A12Yu6e9kThtDCGNNU2Nr4MtOZ+kf0Wb2EY0/dYA1Y
	6TCkVDgPxo3OKfbIujmFldHXoOKapNCKNSf/CyR8K0MGCCNA+B3rJwaWJfeje43f
	4SXpoM6cMu1MuCXSt/6yKFlcdLgj5YkN+9S/8+k4Gw==
X-ME-Sender: <xms:FiY1ZqcB9Bqj7c4c142ZRj7jP37J7wZ-KO6jBp4LayAoaQ13aC6b4g>
    <xme:FiY1ZkPaSlPJ5aaKuelJhitg2A4eyJOThZxPHy7iwWHN3MkGIw0NpljweK7IrbPn2
    -iMC3bLd5_DgEGXPg>
X-ME-Received: <xmr:FiY1Zrh4G_78Oa9o9TLDUAPWOF18hAltQdAtHGdLJLuA0gD5-sxe3mAAi4uyelMSgD989ifNdONq1rBRswsNLaFZgdz9dwG0uSJZOH4yGn0hRigT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:FiY1Zn8iq_70ITBT8AC4s0t4LCcbmqi98I1xV3qyBxi3HJ4zj-CXnQ>
    <xmx:FiY1ZmuOM1uStKT8CI4a23lOYgHcheSdS83mkaLS0JQ7MOS6w9SLig>
    <xmx:FiY1ZuFhcrzJvBRkmqoLmkVwTkqlwZ2x5UFLeAU4SCkjHuWUgBnf-A>
    <xmx:FiY1ZlNkrcyGYmdVmLxehbHqoF4uEm3I0J-JxTDq-2M_4TGERyI5cw>
    <xmx:FyY1ZqLCth9GlW-WXIPYBEp5A5kDiu_EktYbKX8m2uzyxnIIRNaAKcXg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 13:59:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eef43e2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 17:59:20 +0000 (UTC)
Date: Fri, 3 May 2024 19:59:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ci: separate whitespace check script
Message-ID: <ZjUmEuKZB1xwAPo7@ncase>
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240502193840.105355-1-jltobler@gmail.com>
 <20240502193840.105355-4-jltobler@gmail.com>
 <ZjSKqaJxd55328Fn@tanuki>
 <awbex2f6p4sqdneevwrsba4gayidhvxrdyqjqffcn7ub5imcmm@t3wfqe5xmytv>
 <xmqq1q6ialiu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5LMncqYOZb2Sh+GB"
Content-Disposition: inline
In-Reply-To: <xmqq1q6ialiu.fsf@gitster.g>


--5LMncqYOZb2Sh+GB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 09:49:13AM -0700, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
>=20
> > On 24/05/03 08:56AM, Patrick Steinhardt wrote:
> >> On Thu, May 02, 2024 at 02:38:37PM -0500, Justin Tobler wrote:
> >> > The `check-whitespace` CI job is only available as a GitHub action. =
To
> >> > help enable this job with other CI providers, first separate the log=
ic
> >> > performing the whitespace check into its own script. In subsequent
> >> > commits, this script is further generalized allowing its reuse.
> >> >=20
> >> > Helped-by: Patrick Steinhardt <ps@pks.im>
> >> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> >> > ---
> >> [snip]
> >> > diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
> >> > new file mode 100755
> >> > index 0000000000..f57d1ff5f0
> >> > --- /dev/null
> >> > +++ b/ci/check-whitespace.sh
> >> > @@ -0,0 +1,74 @@
> >> > +#!/bin/bash
> >>=20
> >> This needs to be either "/bin/sh" or "/usr/bin/env bash".
> >
> > Since the script is using some shell specific features, I'll update this
> > to "/usr/bin/env bash" in the next version.
>=20
> This is a question to Patrick, but what makes it bad to assume
> "bash" is in "/bin" when it is OK to assume that "env" is always in
> "/usr/bin"?

My own bias. I know of systems without "/bin/bash" (NixOS), but I don't
know of any without "/usr/bin/env". But you're right, "/usr/bin/env" is
not part of POSIX and thus not really portable, either.

Ultimately I don't think there is any way to write the shebang so that
it is fully POSIX compliant. So I'd rather go with the option which is
supported on more systems, which is to the best of my knowlede env(1).

Patrick

--5LMncqYOZb2Sh+GB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY1JhEACgkQVbJhu7ck
PpQtABAAncNr5hWny5u7PiWNK1E8R3UEUvGNG/O4awP1XheSKTYpkr7QkTpaMKMN
Sf1VlWjDvMOH5/RZLR2jdRu0Mqz2cAUvKt4SHAjjX5nVrAFRxsw1v9ehIcOck3nH
D5yHf1xtRzccRji89vbJHxSgLAHWlRGXnLqxh+vEzco/zygBOXgFruk/eP4ttvpB
gVonkXG8Bw2O3g7qYTyTRte3yEPiX4WrN53j1LiTSRoWEQGb7rKbNflzY9Ul3aXl
FiVjpk7RgDbPDqgMisiJHc+CMnFYddMS0oRXafRkzAsju/pNrHsCfP7uj9u8uJjE
aDzxPNuQB4IjgO1a3+gktGPe3qxq8s9xcf0VLIX/nvGmByxOsGf6JyStBFXzXfWb
W0d4pGOaK6mdy+QTF4Fo3sa6cJdSrsciY22DJkUbVxNSEzR6OdwASQOXT+eHa2RT
XBpfDuZdMLbC80BofdbgccI7HV37huptypxZiN+VxIvOT1xIaOutDVfuBk4W+zz6
6MXhLsYASSFF/XFc8Db1Tgm7M5bN3UwqJrEu9BYU29P3ZYPRpVUAZ2Gw9O7hmlaV
Ws71r8OsHxFPRPYwEo92vBgmLBx6xvLahRcmIL6nW2BqHX/bhM7JW87MYbNsJa6I
4NFDh+MRnZFTmnxgcF6vEuhgIVu0pPD+9q6e3RIPAuK9eo7ca/M=
=Ndwb
-----END PGP SIGNATURE-----

--5LMncqYOZb2Sh+GB--
