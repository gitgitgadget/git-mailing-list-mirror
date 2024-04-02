Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D681598F6
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078683; cv=none; b=CPBh2qK1EPdjN5s2GavqV9KXmQnAas7HZPF/rjMXFlc3Hl5fXRQxd8xGcfMfYBz6xlGne5uRjiIa7J3IRb/k0peI3ijgzhCtG68lnFR2+CyaS3mfaoXjf91qu4i4yLhRlsI9vtBqtPJwyp3J/QqpsGTZJWBAZ41hSrx8JUYPkLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078683; c=relaxed/simple;
	bh=VhYo5G+KWLBhr5f1uCNCzCp7Si+XxFPqcmvLLAOSq/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaWIyQZDA/TXSgd0NDSellfI/slP1NLuLtj23ir5K81tbfKrkOzYYFIKVwMcV50eBZtI8yvX9xLWfJEIF6Wk/R5Qax4pJy23zfPWQWnZxszlzZOi6dL5EspOo6NsLYuyfAcF1EJb6UAnxmtR0ZylsOswwfIa+5m2VNAwYj3jmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gpyo65pT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j4idXI6Z; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gpyo65pT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j4idXI6Z"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5800718000E1;
	Tue,  2 Apr 2024 13:24:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 02 Apr 2024 13:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712078680; x=1712165080; bh=Lv16YzeyUR
	k5BAa9ZPnpQXXu1aguD7gdRPH0pRfSHYc=; b=gpyo65pTEpJLn+8mrDji1QqhMs
	zZ9GzP9tquMzvBbN9X46dSNzTlNzr2xB2+xRbO0TUukd2skfrndeuurfmWjGYTp9
	NA7BBXkT6fIafVOiakMXyTqhbP6grG5LsFNAAd03ChlrwMx4xfc+kSmwTcewYeET
	uqAgmbVTkzj7NbRaMN8a6fVDPfrfux3ggePU5zS6t1NNKo/U/4B2WNE71NRsW3fk
	JJof3CVRqE7ID+oZG7PVmhkFe7KqNBWmCCyoI68g4tuRw+i0za90OUW3rTb8JJbu
	MiU5hoCxKgn78wiAR1/0z+QIKHpSRltCPEtKLJAu575ni4ViT49W5TNI+nXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712078680; x=1712165080; bh=Lv16YzeyURk5BAa9ZPnpQXXu1agu
	D7gdRPH0pRfSHYc=; b=j4idXI6Z0OXZsk4+4hUXgHf1iuZT44eAkKFw2Lz7Lnrl
	wGWJWDSO75+xE+Dg6k94lgYhaj/kkiGUQ5o/lzmf8FiYmRL8z6/mSjsoWpWBQWwa
	KGhcH0zd3jDOGATnc9seqtbOfodElm4018LqaEZmBuzdulizi09Iu4Ci9A5hcxiz
	ywbSPh7XZtOdBmtNqudbg0hmkGWhxwUXHjqxqant8pyKBGCXvmTgA3gakjuKsPnA
	b+gieNY6T3QLRcEYv+56alzQu+8CBszyonVBYWPTGftGE2SB47guLsIlBkSr+obH
	L/c8znfI0dmCib7AsnYIddHsmwzQMTPjsl0pH5/pcg==
X-ME-Sender: <xms:WD8MZqfEdDb3fCXHcjfyG5O9oqVW8iYl1yTveNl7AXPn3pi3BU6LZw>
    <xme:WD8MZkPhT3z7CJL8eDEEjRQR4SXAgOxmJ2a0AQ2-O-wEpuoqqkkCCBVmjLlVeRPHg
    VtrSjE1WO9xV78guA>
X-ME-Received: <xmr:WD8MZrhziW0wERyDEj0TBoH_Zfvwjdv6pPHuZt4gMyg1U6NctpQj3B1cpNrJeFZpcOqtjmMpMqXA9xOJ-9D0CXtDvzBo1wi-XX5vXB4YbY0EyKo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:WD8MZn8BAaSCVb94-nqDq3jwmpJIp42NOexeTOjBgThr406Ef4Tvlw>
    <xmx:WD8MZmuBHXtbJe0fUC4xlfHVWKNA2A2DL4D4grKwf2kZXvTcTbkEzg>
    <xmx:WD8MZuHYYIdHUN_9lBdS5YlC17ZsgO3MKK5X8ygHrgTzDfP7kXNIFw>
    <xmx:WD8MZlMPICcB1XDB6a2Z2zQYLGS-37QVmYks12j2ya4Ng9HBCjm55g>
    <xmx:WD8MZqIZXZefgpxXw_SAJPJ7BtmUzeWjdsyZdphev9a9NjZXOV69AzRE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 13:24:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 05781c93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 17:24:30 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:24:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/7] reftable: improvements for the `binsearch()` mechanism
Message-ID: <cover.1712078263.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JlEUoNdCMmG7pNzy"
Content-Disposition: inline
In-Reply-To: <cover.1711109214.git.ps@pks.im>


--JlEUoNdCMmG7pNzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that refactors the
`binsearch()` mechanism in the reftable library. There's only a single
change compared to v2, namely a rename of some arguments when calling
`refname_needle_lesseq()`.

Thanks!

Patrick

Patrick Steinhardt (7):
  reftable/basics: fix return type of `binsearch()` to be `size_t`
  reftable/basics: improve `binsearch()` test
  reftable/refname: refactor binary search over refnames
  reftable/block: refactor binary search over restart points
  reftable/block: fix error handling when searching restart points
  reftable/record: extract function to decode key lengths
  reftable/block: avoid decoding keys when searching restart points

 reftable/basics.c      |   7 ++-
 reftable/basics.h      |   7 +--
 reftable/basics_test.c |  55 +++++++++++---------
 reftable/block.c       | 114 ++++++++++++++++++++++++++++++-----------
 reftable/record.c      |  34 ++++++++----
 reftable/record.h      |   6 +++
 reftable/refname.c     |  53 +++++++++----------
 7 files changed, 179 insertions(+), 97 deletions(-)

Range-diff against v2:
1:  cd82ac6531 =3D 1:  baa07ef144 reftable/basics: fix return type of `bins=
earch()` to be `size_t`
2:  a277d4fa6f =3D 2:  cbc2a107c1 reftable/basics: improve `binsearch()` te=
st
3:  9ffcf45c32 ! 3:  f5bf65e0dd reftable/refname: refactor binary search ov=
er refnames
    @@ reftable/refname.c
      };
     =20
     -static int find_name(size_t k, void *arg)
    -+static int refname_needle_lesseq(size_t k, void *arg)
    ++static int refname_needle_lesseq(size_t k, void *_args)
      {
     -	struct find_arg *f_arg =3D arg;
     -	return strcmp(f_arg->names[k], f_arg->want) >=3D 0;
    -+	struct refname_needle_lesseq_args *f_arg =3D arg;
    -+	return strcmp(f_arg->needle, f_arg->haystack[k]) <=3D 0;
    ++	struct refname_needle_lesseq_args *args =3D _args;
    ++	return strcmp(args->needle, args->haystack[k]) <=3D 0;
      }
     =20
      static int modification_has_ref(struct modification *mod, const char =
*name)
    @@ reftable/refname.c: static int modification_has_ref(struct modificat=
ion *mod, co
     -		struct find_arg arg =3D {
     -			.names =3D mod->add,
     -			.want =3D name,
    -+		struct refname_needle_lesseq_args arg =3D {
    ++		struct refname_needle_lesseq_args args =3D {
     +			.haystack =3D mod->add,
     +			.needle =3D name,
      		};
     -		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
    -+		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &arg);
    ++		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &args=
);
      		if (idx < mod->add_len && !strcmp(mod->add[idx], name))
      			return 0;
      	}
    @@ reftable/refname.c: static int modification_has_ref(struct modificat=
ion *mod, co
     -		struct find_arg arg =3D {
     -			.names =3D mod->del,
     -			.want =3D name,
    -+		struct refname_needle_lesseq_args arg =3D {
    ++		struct refname_needle_lesseq_args args =3D {
     +			.haystack =3D mod->del,
     +			.needle =3D name,
      		};
     -		size_t idx =3D binsearch(mod->del_len, find_name, &arg);
    -+		size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &arg);
    ++		size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &args=
);
      		if (idx < mod->del_len && !strcmp(mod->del[idx], name))
      			return 1;
      	}
    @@ reftable/refname.c: static int modification_has_ref_with_prefix(stru=
ct modificat
     -		struct find_arg arg =3D {
     -			.names =3D mod->add,
     -			.want =3D prefix,
    -+		struct refname_needle_lesseq_args arg =3D {
    ++		struct refname_needle_lesseq_args args =3D {
     +			.haystack =3D mod->add,
     +			.needle =3D prefix,
      		};
     -		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
    -+		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &arg);
    ++		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &args=
);
      		if (idx < mod->add_len &&
      		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
      			goto done;
    @@ reftable/refname.c: static int modification_has_ref_with_prefix(stru=
ct modificat
     -			struct find_arg arg =3D {
     -				.names =3D mod->del,
     -				.want =3D ref.refname,
    -+			struct refname_needle_lesseq_args arg =3D {
    ++			struct refname_needle_lesseq_args args =3D {
     +				.haystack =3D mod->del,
     +				.needle =3D ref.refname,
      			};
     -			size_t idx =3D binsearch(mod->del_len, find_name, &arg);
    -+			size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &arg=
);
    ++			size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &arg=
s);
      			if (idx < mod->del_len &&
      			    !strcmp(ref.refname, mod->del[idx]))
      				continue;
4:  5e20d93ae0 =3D 4:  435cd0be94 reftable/block: refactor binary search ov=
er restart points
5:  5bbeab114f =3D 5:  8d8abfd290 reftable/block: fix error handling when s=
earching restart points
6:  271bacb210 =3D 6:  f87f7ad01a reftable/record: extract function to deco=
de key lengths
7:  e751b3c536 =3D 7:  f53bf9e1cc reftable/block: avoid decoding keys when =
searching restart points

base-commit: 11c821f2f2a31e70fb5cc449f9a29401c333aad2
--=20
2.44.GIT


--JlEUoNdCMmG7pNzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMP1QACgkQVbJhu7ck
PpQKFhAAjUZcfqfLFUZFKSarjkAHKgofsW1tNofpWbFuQrBfIBnzkMEOjQs3A9PB
dtJoPOwMlzHm2r1LCPXVKklDc+yUlB3R19NtxFTRf77YuTL+LpTAeurVgUygAhcS
t2cawQfCRcVbtLAS4mHD+wJNGmiQxglhkoM1LPdLK1E6k6kk6nFba91O0CG3A2VJ
APy/HlkNnWfV9dWi3y/0mml3tPTei2G1Who4YA3a/XatXZi/gIsmvJaorV/iRw5G
3pScbPfbLCpTAuslXFPXa2zdbLGasi5g+LN3LHUYypVNWBAccHc+kjSTp4+RS0I9
wDAsJ6bOPceBI9MawrL8K2heRxzSrclGI5w6cabyDRHBDWgsWZ0o0a8gJWLKhPce
rYeaqseYc6cfBP6pCGjFazhoYizYYOElra8v/E3j1fkNjN3LNZlzo325trqRzT8k
kiH3nvBWiszD0wTRPWsKqL/boXvCfgr5m3hicHN0Dc50f6Ucsy4D0H9mdrNdw+LG
j5dAXznXZ/t5RlG2rnhbJRdRAFfLNyKxjeIJUTSBuBCCtpe81n3S7Qu3hBSlIcyL
gJtxCgVsoGVuBo7js18QYylL8ltk+/zNwq4kd6uT4ZeG+U2pe+cfdgB0n4K1VA1i
0RHO6loJ5e3hNFsSXk+4yKiWgzR3dTgzkfLvEtJLNxzzoC/zHBI=
=JFd4
-----END PGP SIGNATURE-----

--JlEUoNdCMmG7pNzy--
