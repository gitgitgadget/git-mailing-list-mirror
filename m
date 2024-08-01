Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0179F170A33
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508711; cv=none; b=n82FqHw2JI2ohygnycn5Y/MKLO3KeYN4yLwGf0ESpyTuGxsCbItT8UXhwfsPTRJFoJKmYzYPyz/KVi+3fFuBa7TVgttuVrSqNyISFad54NZ/2jYyBIABtQys08T2xuOI340I5BXisky30C1HCY4wwJ94iIGrFig8jsGARJstYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508711; c=relaxed/simple;
	bh=bFjPQb5B4ie9X601R9uGDxXWD16t4NJ+VHrnTJK0n3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfT61M0eb46v9ZysjOPDqqziru0dEO6lOVVUhvHgz/SPEAw0yBcolx6vNzj+JeNkXUMlvu2xq7pK/+6C5RRlsM76qCzlwlRbprLyB1iakYCZrNRXxJY87bJVQvq9yb/SiOnfn1OuWklndOPrhhVABg2ckW/hUDVhBoy0m/dDsoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J7XVQ72l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FQn2io8b; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J7XVQ72l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FQn2io8b"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2351611482FD;
	Thu,  1 Aug 2024 06:38:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 01 Aug 2024 06:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508709; x=1722595109; bh=tq8yMYQ/rf
	++b37g2JHXI/O2bOCGTG7BU+c/qmtPHnU=; b=J7XVQ72lkQkJu8oktGTy97O60H
	h86805fhgMgnLMXBPblAUflXpWgNytu3bnJ3QMuzkffDHc9lbWj4S/X5TmwdEzks
	ggGjzESdQLrWt99EXWFsWCrDCvqDyZJWfiYyzIeRvMLXymjSiJGFL2yv94oIjB1U
	Vm6/XhPYgZlFQ57CtclzKVorJl1eh/LaMMvvZca1F0b/6NXHigAFBKVqAf5koov2
	tcQaSB/X0kgYT3EtkLZiEU1ixNLqivJBfDaTK8jCqKyzu9fFNUMZiztwms3oMTib
	Zz+GKa1OXXPcsXm5LD8yYoaCkJ4hTGdC3bBkl1ndLnj+0sD1PrMRLKeouUzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508709; x=1722595109; bh=tq8yMYQ/rf++b37g2JHXI/O2bOCG
	TG7BU+c/qmtPHnU=; b=FQn2io8bpOn8KPqo+nnuoouGNsAqoqGLYi+jIaJrWlhc
	NETv9V/Xn+kUTZ3GxBbYNCkbUVdeEeNZw+UgyB3KRXewXf3ixp2L+dcNqXboFoXY
	ZXVwKFm1Ijqj+E9BXZNeNGnajPb2KQDYziRFq1ztqgZ7u2RWBfSWciRFR57PE5dR
	vseTiySoOZlUhSYeUWfQGRmhaHqng7oh/XXjs+kXhI364YmwHmbBPbaMQs1O8bXC
	nOqbW+b8NzIQoa7eBl2pgS+qI3KPOZzy3LbnGfv87qkJiVqau+0bIk9BZSFVSNfs
	2X2WApWUH75pMG8VWs2UqLDAcF4m1ZL042O7RN6UIA==
X-ME-Sender: <xms:pWWrZuZQE4_3od1EfA3wA3aebfSfR3zuUvf4pFtt5A5HgIr-3tcDEQ>
    <xme:pWWrZhYy5pWpmuxMQxOoJnauITtTeSTqBWR__LIM-ytkBRAJrS34rG_FGOR0e-SoZ
    w82j9a9yOBniXqeFQ>
X-ME-Received: <xmr:pWWrZo9vq9uXLG01iHwUxNeF7nTe4GsPCYC_61mBiaU8ULsfwiBFrpCm2GnpPoK29ho3BX4bpavMh6DqSTnNLQSCHig1BS3heVvg9UD5OaZThtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:pWWrZgpm8KzTe5KbdPHNmw1QTUHb6FqE0w-u5wKwnOVtqTlcwMUZsw>
    <xmx:pWWrZpoyhJdJcLjuBg6NunlExAclwvQ0dblCHReUaKkeM5qE1j1Z7w>
    <xmx:pWWrZuSDnvsDK5hiF39O_qnl7Bea9_hUNRruELxj0UpQ2yVgLls07Q>
    <xmx:pWWrZpqRyk2sdyNLwasP2dqnQGVJyrxskuqHW1MsgWg84typTXA_rQ>
    <xmx:pWWrZiAZs-jReYFstrSIXpZGoZ8MILeM7yXq32bjYvlDQPRM7RvfYes_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:38:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bec5e3b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:36:56 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:38:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 04/24] builtin/describe: fix leaking array when running
 diff-index
Message-ID: <19ca97e33a352b540a27feae5302c2311b707f9c.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4a7OQFbO9mcFZDao"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--4a7OQFbO9mcFZDao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When running git-describe(1) with `--dirty`, we will set up a `struct
rev_info` with arguments for git-diff-index(1). The way we assemble the
arguments it causes two memory leaks though:

  - We never release the `struct strvec`.

  - `setup_revisions()` may end up removing some entries from the
    `strvec`, which we wouldn't free even if we released the struct.

While we could plug those leaks, this is ultimately unnecessary as the
arguments we pass are part of a static array anyway. So instead,
refactor the code to drop the `struct strvec` and just pass this static
array directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/describe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 739878db85..2957ff7031 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -695,7 +695,6 @@ int cmd_describe(int argc, const char **argv, const cha=
r *prefix)
 		} else if (dirty) {
 			struct lock_file index_lock =3D LOCK_INIT;
 			struct rev_info revs;
-			struct strvec args =3D STRVEC_INIT;
 			int fd;
=20
 			setup_work_tree();
@@ -710,8 +709,9 @@ int cmd_describe(int argc, const char **argv, const cha=
r *prefix)
 				repo_update_index_if_able(the_repository, &index_lock);
=20
 			repo_init_revisions(the_repository, &revs, prefix);
-			strvec_pushv(&args, diff_index_args);
-			if (setup_revisions(args.nr, args.v, &revs, NULL) !=3D 1)
+
+			if (setup_revisions(ARRAY_SIZE(diff_index_args) - 1,
+					    diff_index_args, &revs, NULL) !=3D 1)
 				BUG("malformed internal diff-index command line");
 			run_diff_index(&revs, 0);
=20
--=20
2.46.0.dirty


--4a7OQFbO9mcFZDao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZaAACgkQVbJhu7ck
PpR+ZhAAlLhQxst0KHV5QFI20SoV6ccUKFJ80LiXCIW+s7CM3VCvQMHk4emkD0Q0
NE2EO5PGKisT/dE8G9MOjyZCGD5GaIraHhc8Gy8PnRtzRbyyDySdUcfnmlkMsJaW
0z83eo4ZsCiqnAubfurYNSdXwseajZALZCC2IcJ6nMkviosjDCMFvHpZ3DOVlZEy
DvS7eaXiH7W2kPlq2FPJGA1G3cznbyMgDmIw6ERk0vOFOPOdp5uj1cKY3Q401Mpk
Ko9ZONkemOXB4xseB3dYMezsg773BwWza8pzAASD9j/446mkRGsTChbjJCLb7jd/
5F9WMbjB6MbBqxBtWeqpTnuLFs0Lc9ULrERlKCoiqPQy61Fa55x7orFZVCiptWnK
F/mrNqdJScmCwxvN2aRG4m0OY6MEA1YeQlc+3XBzCB4wy7wsaWtgQYwO/SqkaFd6
mm5EKWCvq97wpdJIKg+B59DcSUovBNp16ZaBI7JeOot+7KFRxrVxr5Ne3yEXThQT
2bP9nHxc+1TXXL4jGkYmt1VMOT7Wx9PLjZQl0xFj0JlPp8u0/Huj6Ikby+7mW3YD
5hWTQWfYwVWo1eULXM4Vf1nPVxfFdyy460ZnhyW9Ekv786AEkdHUtnn6bIZBrpeP
E/VEXgdPtiN+gvZEs/3IgRI8waBFCGp0ZEjPMVPfKr5wPuEQjTo=
=0TMI
-----END PGP SIGNATURE-----

--4a7OQFbO9mcFZDao--
