Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E12561D
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558788; cv=none; b=dN4wJGV2fYOkKYw0rDE50ZDr3snBUoEhWkETBPqPpc3d1exBqBmo/EQuD8lpmem0+sCnp3E20BbWeVJJBF6sPWzbAf+THF2SyayHEqwDSVtkY6i5CTv/e+FcVVChdZ73rzvii608N5VvkVz3jz2Xg29cBTK/XmnTZTKafYz9Gq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558788; c=relaxed/simple;
	bh=igWirBzFcwBSTwliqDgQxcguwUhaUNbRxT9KRcH5P6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b038HsVCefxJfy4u7FMzObDUB8L7hLCkf96Ky9g2puhKE+aLn7ooEG9p4BIyr4h0IWmAzoMPxiGVDP6JwoulzTQdjmAUvrpBgJvlFqeGO/MwojP2Swvv7pmoTn8cWTUnwQ5Fz2dmu9pj85yGuwHf2IxxSOpZOWcvDQdNiVgu2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=asAYqRb6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q5yQ0++I; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="asAYqRb6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q5yQ0++I"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 95A1F114008D;
	Mon,  8 Apr 2024 02:46:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Apr 2024 02:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712558785; x=1712645185; bh=ST5T+9nWFO
	rPiCE8WSgoQVV/VVDx1TQUMyxABDwm99A=; b=asAYqRb6yrE+FaOYXppxwphzzJ
	3DadPaUr0GCVLPYw15cixhbjiBajAdbhqg28huJa9YT7cynzARpivgpa5IyJZJdk
	f6dod95KkqRH3FHNT4UIMZvZaVWUQ0WF3YK5G9oFtUXIHc+sU19sQytpRW/zbWxD
	Cg/3g8VFe8Eg5SoF/pBu9gfh66RIY/a3+xvRanhM+czI1dVpUzaMwbTmxn84wVQ+
	+bXBMWMMniuE+li2cFG5bdbKvA6jprey9rOE9pwxc68uHhOaUGuP1FGsYJ/akHDR
	u+s1oQFBH+SqWUsEj5xBqxxJTVH26UNyKsTM/y+N6UunGHzXrR8yhSDueUnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712558785; x=1712645185; bh=ST5T+9nWFOrPiCE8WSgoQVV/VVDx
	1TQUMyxABDwm99A=; b=q5yQ0++IJGC0r4dBpOl8Rx04OVep3ZfoV8FwNHAU8GkP
	jot8/xzwxNBxexGW88kVv4ujfZSSJCuJfxzumnM8o41UimE8GAub/f3gC/RWvcUQ
	LqvpD4Yu0gM88zYnZfWyzC9gWaT8f5a/3e7uV2szgaXtZJ8oF0DqDdMOmtnKCGCo
	VeRmZewp7aIQ5YWuz6a6osk0ot41oPqpq3f8m3QFe6Cx/yX5eNuLbLIZ4iv9mWC/
	0kHsBDSoet9WsSg3fM6SnnN0aQfi/GI3juXk/uC3As/UnbJZsimokyAcFMqPtSAI
	ykEn9ZBB6OcgZiaYRA1rYkSXIuvOAK5boQrXp7z1bg==
X-ME-Sender: <xms:wZITZgortReWww5oalPA-XxXL7b47o8f0erZakp2sYiBu9i_pjM9_w>
    <xme:wZITZmpr_H1bwsIo9gK0cFUAD1j3uW8mnjXAAuXSWWSC5i6MJQ9bGM0XNrNvjqw9Q
    RUi5eaCxr7XxJHSxQ>
X-ME-Received: <xmr:wZITZlNQE1YrY504-jKWR4yf_6RnLqffxFKPTuFyPSu8bluIRRaB_nl1OEVrmT0FWYWcq-qyQIQpD77usLGD9lYh9iPRNxzkGLkMIB7OlQgQb3mV0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:wZITZn4xy0sKubTLE-W-DqAG8dkNfKlsRV5sfYJHeL9lj16yrFMF4w>
    <xmx:wZITZv4KZ_SjFcdkNVUKdezYrYyQaXx_kVRdbJDb0W2xnEbrP4KhIQ>
    <xmx:wZITZnh-zoqcgOKe-qxvjy2IjTPLO_KkMGi4GOomy6P1dEzmXg-22Q>
    <xmx:wZITZp46ybi3HrhY_ram52if7_YNQ-aE6TF5cJGC6xpr4t5NmcdYJA>
    <xmx:wZITZlRKQvcF0TmE1HT1O2B_cs-vFYHFDUorEdFPNtCOxCJtYwceOJT3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:46:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cf2efd25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:46:18 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:46:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 03/12] ci: allow skipping sudo on dockerized jobs
Message-ID: <16603d40fdf96948580c04a7c2b791a97ec64fe7.1712555682.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3vnunv4WQM5oem+q"
Content-Disposition: inline
In-Reply-To: <cover.1712555682.git.ps@pks.im>


--3vnunv4WQM5oem+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our "install-dependencies.sh" script is executed by non-dockerized jobs
to install dependencies. These jobs don't run with "root" permissions,
but with a separate user. Consequently, we need to use sudo(8) there to
elevate permissions when installing packages.

We're about to merge "install-docker-dependencies.sh" into that script
though, and our Docker containers do run as "root". Using sudo(8) is
thus unnecessary there, even though it would be harmless. On some images
like Alpine Linux though there is no sudo(8) available by default, which
would consequently break the build.

Adapt the script to make "sudo" a no-op when running as "root" user.
This allows us to easily reuse the script for our dockerized jobs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 7d247b5ef4..7dfd3e50ed 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -11,6 +11,17 @@ UBUNTU_COMMON_PKGS=3D"make libssl-dev libcurl4-openssl-d=
ev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
=20
+# Make sudo a no-op and execute the command directly when running as root.
+# While using sudo would be fine on most platforms when we are root alread=
y,
+# some platforms like e.g. Alpine Linux do not have sudo available by defa=
ult
+# and would thus break.
+if test "$(id -u)" -eq 0
+then
+	sudo () {
+		"$@"
+	}
+fi
+
 case "$distro" in
 ubuntu-*)
 	sudo apt-get -q update
--=20
2.44.GIT


--3vnunv4WQM5oem+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTkr0ACgkQVbJhu7ck
PpQJCA//bNmBqtvZJ4HQ88nTaGoe/QusIHyQSQ6abIrOPYGKx3hZTOn6n8gbxy2w
Or1TDbrSnTNKZLHuQB34bsDfjNLcd1zgfL+YMdUFMYJ8s5lRzk9KOfPzfBGIUDAr
r/TjIlMPFuiQyW/b7R4mLOseBMsh2lT9Wxv9CY/jWY4ZonSBGqWnXaeaxyO+LPa3
Eh10CrKbjejvNfWnxYv97JS4tNduoDeKjazNpZJHTctoNyXDNmFyhNS/leXzBk0P
mYByXghdZYEGOCtz7UigoWiKSCemGNbcOIi/ZgSyd2dHWvtYV4PkGrHxtl+I1QgP
5EuwIdNLVniqhabqe4pT6ABLEzrVm/Jpivkf8r1aUy3IzlQj1SP8M3yC48K4zSuT
ZT7iE+N6dfgJ0ZMID2F9iRINzP3SFkZ98IWxpXeTtGb2FZ8mmDCyBrsEeCEGzNhx
oyWoCfF6Jj9yHsdPFoLHJ66BKnWVPruSzkV/hLGGih8XbMUt4F2N6S9D4rRMCQKD
1FbIxEOw7742xstFswfA6A9/D8bamAIfaL4WkR8LWyd4I0o1Q0OOzrE5Z0MF4Kcn
LWi6RMrjYrwQZzPrIWxsiSqyzp81mQDZD2uZX7orQVxhcapEgw2JEmegR5+OwEwY
q7YUddDJQsCdUh1WBZDa4iexlkxQClvzEC4stp4th03bwGBdloI=
=e0uz
-----END PGP SIGNATURE-----

--3vnunv4WQM5oem+q--
