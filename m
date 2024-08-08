Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E14145A05
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102534; cv=none; b=mH3c7UIGikd/eHHZ7cZCVBYiFyiNgAu8flTopFdMNy8BQfZ/HQgJ5YUlts+k5RW2DueSfV2N97k7Z6JtFZxicBJk0b0FYk+CuxY0Rjd9R1eHt3EZHsKoMcPSHHPn/NlNiVSc4LR5E0nt4ke0iLEzabMcIJWvibgvu6qprgqVJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102534; c=relaxed/simple;
	bh=4V9T7K0FBuMjUEWo3mby++Uer+2U+vCPWhcPvPX31CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3kqFyTYMmUUY4oo8XUNBa0p9VKrR+RjqwdRXIQ8bnfOTddvvXPuLEDKBlZ4SXwqOimE0FNFd7M+bE5d+nl391ETkq2H6bHuX9A1BY8ynHTajVrGtBU+kDw0BbVdXwA7+7e6kyc6rtTwdU6mYvvBZy2tRYDScLnG59vdVaFYo2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V5LbdtD9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NpV5DqJ+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V5LbdtD9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NpV5DqJ+"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 47207138FD36;
	Thu,  8 Aug 2024 03:35:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 03:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723102531; x=1723188931; bh=glvkNn8FMX
	Ynih0kSifQiLh8ZWcztl+ng1GKSCW8iZM=; b=V5LbdtD9EDcSnSghaRCXIzE7BP
	MwB8gRf8u6IC/oVUUQYFKftn4Bls30Os48X0g4uWe4vzZoYUqbgpDS35r8B2mAWv
	NHqvK+ehQudrjfKFp6gewN+625vEC4QPz+kXh8G0PoUqlzAQM90DJbsFSo5BMxeR
	//U/yZ0EKIFGIIJOdfR1KrOfX9Y1J4vwTVmY834M97UP1zcCRi9vJrjd9CTK15Ck
	GfyB87oZozBIyvzISXl90TwpSS+m042I/KdJza+qhg5l9r4yWVgTe9lhQbdranRW
	Prk5yni8ZYamNCRCTB9pDHYssUcw6w/N0TNXcKbCuW1EETcJt9hIuR5E3r8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723102531; x=1723188931; bh=glvkNn8FMXYnih0kSifQiLh8ZWcz
	tl+ng1GKSCW8iZM=; b=NpV5DqJ+yHUJIhtp8YMFDQRofZfFXrZ7cR1ECcaR+pXe
	wAYHuFgCjBGpEq2+lvmofNtb12zt5miVJQC9VmQSah03nMabbZYajJ+FNvM9pSV2
	V2Z4XwI6cSd+yic6l6MGe/aP/u9XprhhOdIKfOQ4kezfpHNw48y95PDYiMFyfmsP
	bnOPwifCVGcEEYCNhKN4T3pGpwmFgMQvMVXDlhOPKnbN2WdI82xUxAQ5bk7/5CBC
	7ilfrxs2F4fVDkj/YrCxBBrxnTFlCf/crM5dmbSy+207VnO2Np6ubdFi30QWboRv
	f5ehGazAEA6AhHb0XpUeEq3Ww2QV9qUFXHgoif/pfg==
X-ME-Sender: <xms:Q3W0ZlVVmJePDqxqDOmW1xvi6R-hhzEO8xc9KG16QMT63XJtRBqTDg>
    <xme:Q3W0ZlnP2BAdMtrybXBjYY79mpyULIWMy6SkwMTMlC9LpuEsIHDtxDmEOYKuaY5Mc
    Poe_gAB9mCjJmA2KQ>
X-ME-Received: <xmr:Q3W0ZhaXBkIkVS6LzxPHSPvmnnLwbP4mQn9vkpKJk-595oAC6cLFW2mUx5IPa_E_e9tbqAxls4I2bKcAKxMKzPaxmVLVFN8_ZVWQvf9riOjGzUdb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeg
    hefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjohhlrghnugesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhn
    vgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Q3W0ZoWEt6lGMGXlD_V9OFtE3dPicj7ogIU-xqHzuLlqX_Hq5-sdLw>
    <xmx:Q3W0ZvmuEuEgoxHxyw92-7LRuJWGxpdMD1p-UQdrBdQeCN_KPvTlcA>
    <xmx:Q3W0ZlfSmlqozkMQlSBvQ_kCnQD-3N059w6yUg7UCkMD4qHGX-HjdQ>
    <xmx:Q3W0ZpFKt3mYmwQT4-zasNTFxeF1X4xGO0Fz6-ksKRo1F9YjfTL1mg>
    <xmx:Q3W0ZoA617J4QWZmv4czlbbjwXwSoCNjR3AqJFBZI0jnoSLDsxxtoxJf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 03:35:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id df73f779 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 07:35:23 +0000 (UTC)
Date: Thu, 8 Aug 2024 09:35:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/8] git-submodule.sh: break overly long command lines
Message-ID: <6513c6b17d261ed5900aa904a438c8770ae026cd.1723102259.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723102259.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ciBO7c4ZMC845m+Y"
Content-Disposition: inline
In-Reply-To: <cover.1723102259.git.ps@pks.im>


--ciBO7c4ZMC845m+Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For most of the subcommands of git-submodule(1), we end up passing a
bunch of arguments to the submodule helper. This quickly leads to overly
long lines, where it becomes hard to spot what has changed when one
needs to modify them.

Break up these lines into one argument per line, similarly to how it is
done for the "clone" subcommand already.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-submodule.sh | 64 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7f9582d923..fd588b1864 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -129,7 +129,17 @@ cmd_add()
 		usage
 	fi
=20
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${quiet:+--quiet}=
 ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} =
${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate=
} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add \
+		${quiet:+--quiet} \
+		${force:+--force} \
+		${progress:+"--progress"} \
+		${branch:+--branch "$branch"} \
+		${reference_path:+--reference "$reference_path"} \
+		${dissociate:+--dissociate} \
+		${custom_name:+--name "$custom_name"} \
+		${depth:+"$depth"} \
+		-- \
+		"$@"
 }
=20
 #
@@ -160,7 +170,11 @@ cmd_foreach()
 		shift
 	done
=20
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${quiet:+--qu=
iet} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach \
+		${quiet:+--quiet} \
+		${recursive:+--recursive} \
+		-- \
+		"$@"
 }
=20
 #
@@ -191,7 +205,10 @@ cmd_init()
 		shift
 	done
=20
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${quiet:+--quiet=
} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init \
+		${quiet:+--quiet} \
+		-- \
+		"$@"
 }
=20
 #
@@ -227,7 +244,12 @@ cmd_deinit()
 		shift
 	done
=20
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${quiet:+--qui=
et} ${force:+--force} ${deinit_all:+--all} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit \
+		${quiet:+--quiet} \
+		${force:+--force} \
+		${deinit_all:+--all} \
+		-- \
+		"$@"
 }
=20
 #
@@ -399,7 +421,12 @@ cmd_set_branch() {
 		shift
 	done
=20
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch ${quiet:+-=
-quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch \
+		${quiet:+--quiet} \
+		${branch:+--branch "$branch"} \
+		${default:+--default} \
+		-- \
+		"$@"
 }
=20
 #
@@ -428,7 +455,10 @@ cmd_set_url() {
 		shift
 	done
=20
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url ${quiet:+--qu=
iet} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url \
+		${quiet:+--quiet} \
+		-- \
+		"$@"
 }
=20
 #
@@ -480,7 +510,13 @@ cmd_summary() {
 		shift
 	done
=20
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper summary ${files:+--fi=
les} ${cached:+--cached} ${for_status:+--for-status} ${summary_limit:+-n $s=
ummary_limit} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper summary \
+		${files:+--files} \
+		${cached:+--cached} \
+		${for_status:+--for-status} \
+		${summary_limit:+-n $summary_limit} \
+		-- \
+		"$@"
 }
 #
 # List all submodules, prefixed with:
@@ -521,8 +557,14 @@ cmd_status()
 		shift
 	done
=20
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${quiet:+--qui=
et} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status \
+		${quiet:+--quiet} \
+		${cached:+--cached} \
+		${recursive:+--recursive} \
+		-- \
+		"$@"
 }
+
 #
 # Sync remote urls for submodules
 # This makes the value for remote.$remote.url match the value
@@ -554,7 +596,11 @@ cmd_sync()
 		esac
 	done
=20
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${quiet:+--quiet=
} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync \
+		${quiet:+--quiet} \
+		${recursive:+--recursive} \
+		-- \
+		"$@"
 }
=20
 cmd_absorbgitdirs()
--=20
2.46.0.46.g406f326d27.dirty


--ciBO7c4ZMC845m+Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0dT4ACgkQVbJhu7ck
PpTcMRAApsNzABr5epldgfm77OUOVhrC/dPexTu1NqbQ/mDz9ns34GhyeoXmZle6
eR+lVPqUaJ8NE+HYREd3j609NelcHaW6AHbQS257YnBTpEgTbY3fkUuV0tODF2uS
pYZW03q3Z+rAavLUoaEGFNt34VtbeR7y5QMiiAYednpWOmR/8C1trmz0ifOkhcAA
FUUb8f2EYtVt58zEBNDDsG0suZy8KQW1wCq4yYPND2euPao1bpSN8prR7LnduzLC
xYEycdVR1D7aG2m7FX2/imCh9n9Q6VWEtLGkdp3VwUqh3lELT/bymNx3hha0NfT3
IdZYfX5pD8YfGQspBVz49M3ax2Rx49HWkmFpid/QlRV25gg0mpmP6q9Auvu4wRHh
7qubVdhyozt8sRweN/Ks+fpX6fio2dvNDDqLEyKQgiJMfIaAxHvA1kCoc0ODccUk
iRB31vRwIx+6Qi6WZouGbKviwt9BX1CpQbkg2/1czjkOdgMn5PCufpkQIwgaKhCZ
F890AnNYW7LGl7tqTNY++6cP3V5s2Xy1O32yCST4bTHWgoaHGpMDPAELb2x917zS
L7TVI+rzGbLtIsLRzvaon5HeWiPCjwctacVk96mciX139F2f1wxJiYoh+59Z3XaC
zD7wVMdUHlMMHLfRiBQvtd+uHZFeDkssAozsJp5RetdC3BYNge4=
=9UCS
-----END PGP SIGNATURE-----

--ciBO7c4ZMC845m+Y--
