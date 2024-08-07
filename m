Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2121E6724
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034639; cv=none; b=IAdD3N6owiO/I4u/RGAbVKC+qUbZhdsnHFO554KP6tXuULTghOhx+m3x++1tpeecH7evi4coo9ITxH2jkrY9HxtrSAWiZvsnoPXHHSuV8R1If0T3UmiLqQKp11sELWjx5PYD0DbWCh/jYGJOcLMf+18bGClwBEhRgCMaR+jRU7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034639; c=relaxed/simple;
	bh=IWHfI1sszDbDg4jcRh0APQ4qluqJJEL0Twxp3KhmWN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVFIFLWsx4T+CGeZWUSj1YJLuzNsN4+3cGYReIQSQ3n+/+qf+/31gMIy9gd1zxP2K7BcUrkgqBVp+rKm6IOIhty2ZP93IOSJtQJR3UOCDZ8fSTyoMK8UIjye63RHZDpB3Na1y9gJ38P5psC4aO7n99ZZLm5q4wRhKdLtoJC6ofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=de5xAMu4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d5pjUBpC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="de5xAMu4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d5pjUBpC"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id D69D7138EC5F;
	Wed,  7 Aug 2024 08:43:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 08:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723034636; x=1723121036; bh=oBkxJsmiRp
	u5AJfgQXyjPmNcfBoUgXyKE9W30yFu63k=; b=de5xAMu4n8GBzFttaM9wEQOMva
	YIe4iuHC+I3Za6qaJx+bwoqw9E1p1DB9iD+ApVirbo54UKqu0yHGGM5JlBeTzdMn
	KfyTCiq1l7pzGiAMogRVPcGQdpfROjuEkCWjoyi5t2SfaPyy3u2tlwEsPmfhRFOO
	BTyS34wqoAJw5ejhAZV+0onixpg2jkQwHD0CaOyTkGLZh8W1I21ytzISu6mohbBu
	NnajmAVgA7k4xEub2ukSnFKHUaxPmOOvd5YVkAlymbrAMX7Ike/I9L/5/lJx+Z9C
	/y6G9N6IUIH6HaGffMHagoWX+LktpNupXdSrwn0ss20sH5eZkUkfJGPDVHMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723034636; x=1723121036; bh=oBkxJsmiRpu5AJfgQXyjPmNcfBoU
	gXyKE9W30yFu63k=; b=d5pjUBpC+5aj5uN7XIInkCMkwnY5pqL6ouJCoC5a4JYN
	Bu8jkdQmF3GBzZKzvUh9sLSD22UDigBN76VpRGUO2PwTw/2kzDsKcfSQ/rfM+Sig
	r9gP+UWGMWK2R46Nz30Z1Rif8hSWAto91pv04giqrnSAlPliCGOZkuIOcTQH3quD
	IRhAdW0gSKYqr6yxDDys54+TREKaDkKGRn68OR59Ji/JV3sN2dCyaOdxW0gxFbGD
	XKJm6Ngp5HtbiV4MM3KTzku4jFhcWTd1GEI5VLOwNmdf3p4owRM8ZTFkwhmEtC7Q
	Us7WrvpF6Y7B1lss38rMcWjhJ9PM+rUe2RTZdzHwXw==
X-ME-Sender: <xms:DGyzZvqw01xXFD-QuulpEoKxGhZtjFWIczlndR047yBJ40XnYIVC9g>
    <xme:DGyzZpoSkfH4snzLAudsCDRgdZzG5Qx80r8mFUY9z1wEKvfLLR9AsEpy0UMj-cJiQ
    jZW-jkIu0N1iiZ-pg>
X-ME-Received: <xmr:DGyzZsOf09r5pW25o0zR1QEq4dO1yXR22CxUlHl__iu3zh0wKcx7YnMcnX5XYqG97y5Lik0e8Ur_ihVPvRX4nm2pfVUtx1ncYaAwKeKweg5kl-qb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:DGyzZi6kS_TTbZgKJ3pRmkiSL70zcQNnf7RYon0u980uJqrTTG-Uuw>
    <xmx:DGyzZu7_YXTlfsHkS-aOi2xNs2KylGjwvJLqluSvS6OL6NxNs3wzCw>
    <xmx:DGyzZqho-G3smk74enD79lxfexdwsfgBDaGZN1z4Ou0--2AdJ1VSog>
    <xmx:DGyzZg4RSZ4xg0wQGSvqbWJEwhspOyviVoJoMgnYyV3alldXa-DFrw>
    <xmx:DGyzZkk79tONI44GzJw6Og1pXxp7PvUCpr16uBFzQ9a0EsCOSf2DFgvK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 08:43:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5ef33583 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 12:43:50 +0000 (UTC)
Date: Wed, 7 Aug 2024 14:43:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>
Subject: [PATCH 2/6] builtin/clone: propagate ref storage format to submodules
Message-ID: <e5923c0b3364f28ce504c772f7fa75404f80e651.1723032100.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723032100.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5xGz819u6ykgPZ9l"
Content-Disposition: inline
In-Reply-To: <cover.1723032100.git.ps@pks.im>


--5xGz819u6ykgPZ9l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When recursively cloning a repository with a non-default ref storage
format, e.g. by passing the `--ref-format=3D` option, then only the
top-level repository will end up will end up using that ref storage
format. All recursively cloned submodules will instead use the default
format. While mixed-format constellations are expected to work alright,
the outcome still is somewhat surprising as we have essentially ignored
the user's request.

Fix this by propagating the requested ref format to cloned submodules.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c                        | 10 ++++++++--
 t/t7424-submodule-mixed-ref-formats.sh | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index af6017d41a..75b15b5773 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -729,7 +729,8 @@ static int git_sparse_checkout_init(const char *repo)
 	return result;
 }
=20
-static int checkout(int submodule_progress, int filter_submodules)
+static int checkout(int submodule_progress, int filter_submodules,
+		    enum ref_storage_format ref_storage_format)
 {
 	struct object_id oid;
 	char *head;
@@ -813,6 +814,10 @@ static int checkout(int submodule_progress, int filter=
_submodules)
 			strvec_push(&cmd.args, "--no-fetch");
 		}
=20
+		if (ref_storage_format !=3D REF_STORAGE_FORMAT_UNKNOWN)
+			strvec_pushf(&cmd.args, "--ref-format=3D%s",
+				     ref_storage_format_to_name(ref_storage_format));
+
 		if (filter_submodules && filter_options.choice)
 			strvec_pushf(&cmd.args, "--filter=3D%s",
 				     expand_list_objects_filter_spec(&filter_options));
@@ -1536,7 +1541,8 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 		return 1;
=20
 	junk_mode =3D JUNK_LEAVE_REPO;
-	err =3D checkout(submodule_progress, filter_submodules);
+	err =3D checkout(submodule_progress, filter_submodules,
+		       ref_storage_format);
=20
 	free(remote_name);
 	strbuf_release(&reflog_msg);
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mix=
ed-ref-formats.sh
index de84007554..4e4991d04c 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -21,6 +21,29 @@ test_expect_success 'setup' '
 	git config set --global protocol.file.allow always
 '
=20
+test_expect_success 'recursive clone propagates ref storage format' '
+	test_when_finished "rm -rf submodule upstream downstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	git -C upstream submodule add "file://$(pwd)/submodule" &&
+	git -C upstream commit -am "add submodule" &&
+
+	# The upstream repository and its submodule should be using the default
+	# ref format.
+	test_ref_format upstream "$GIT_DEFAULT_REF_FORMAT" &&
+	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_FORMAT" &&
+
+	# The cloned repositories should use the other ref format that we have
+	# specified via `--ref-format`. The option should propagate to cloned
+	# submodules.
+	git clone --ref-format=3D$OTHER_FORMAT --recurse-submodules \
+		upstream downstream &&
+	test_ref_format downstream "$OTHER_FORMAT" &&
+	test_ref_format downstream/submodule "$OTHER_FORMAT"
+'
+
 test_expect_success 'clone submodules with different ref storage format' '
 	test_when_finished "rm -rf submodule upstream downstream" &&
=20
--=20
2.46.0.dirty


--5xGz819u6ykgPZ9l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazbAgACgkQVbJhu7ck
PpTNvA/+JJzLHFM8i6ILAq1qjE6ia98kve7hWJxBlphMt0uEP1swff7nC72g6ue7
f5P9Z9uehGpi5i2nRW9XkheyZyVlGz2B7yif+sKNXWQJKV5+yxTtLf2Vz1L4Zgzd
qDT2CvtW8ks9FC5xC/cnPcwXxeQFAB73c0r5TUyYvdIUcs9rSW9S2PRvR813Iano
3oHNFsFUkmN8qw/zvoT9rdzuznTvJ6VqFVxUlNrOZw/7U7k28kc0tmMUhIolFZtq
4odlZcK4X0E+4FjnO6wYP7w58oiS0TDDLLPwrW9KluM88MtYAlUBAzEqeN9mXoBC
ioYLEd5bEeWKGtY8T/gAHObGOQoLout9xCpYWlSBVynKu9A99zpwhTOJb1jxjm2U
Ou2h3hwn9vvpHgSdIyjeyNsGoUXBR8KKuWCtfkYLJrISikYqNYWUlE/r3Bfh/wvE
VGnWNytDyZOauh6iIUBQK0fIcRmve1+1XRxSnbJSPcnB9NzpqDLIW+KLEy/BGggo
o3Ozze8avf6STLDO8/wAhVOOKIdAnSncqOMUEST44a6jxTCODduxHDGKcT9De5e3
C+b4yvdlFB57BlwVuscwjhLlBuZjPKoZUSEAg4c7EQ+8Ioj0cK0anQc07TWJD5QE
7br88PtlEt2u9qec+fLUI8YAUXgHyuA+J6BYomTU9t/CyysVjx0=
=k85v
-----END PGP SIGNATURE-----

--5xGz819u6ykgPZ9l--
