Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ACA1C0DE9
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712556749; cv=none; b=B1jcDfam2rIR19vIJO3WNKE4JNyY8MjheZR8h2ceMJh50imoqQLWMZu5Bd4BHThP8NoeHAlVA4fy24OwVVXkoDPxRWib5FG7vMpSIe8ygXjrYIDZhqcrj51KsGhrKOKSv5YbQtSkCLvFEmbCz+PdJ2TO/3nJc0fdVcLSKM97a+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712556749; c=relaxed/simple;
	bh=sZ8tWQyR748t2EuIn5izFqGzXW77aYNUaQX2hLNJnw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orJ1x4D/hqp2P60079JBHcuHX4JfH9s18Rn0+9cWCMjcs7ceKTQmUc5KpC+JiJ7z7+O5Q7LwGP9w4YixnCG9P8otCV0/6V/bBpNJaNpD+Lwqs+QThXcUKU9+tQgUyiCa8yY4+egjAgzSikpAj+M16YzNMLBu3ru6xD4PytJ77pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MQ4QEZHk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E0kJBwDF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MQ4QEZHk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E0kJBwDF"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E3C6611400C8;
	Mon,  8 Apr 2024 02:12:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 02:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712556746; x=1712643146; bh=2r8713Y80m
	nyyWzn6/p5Jm+n8fhlflra3AKBx0z7JY0=; b=MQ4QEZHkf4I4GH2chCsHMbX21h
	h0VrOxn/FD1ECmRMWkHi0ymzauve0c364NN+qYhsVu0U3biDAIIuTGdZrIPLLZiH
	xdFM5w9HOzBmOsAsUNwQeSuaWYV4Wi7ig22luHzXaXy6k87HtBdEyFe0W+UKcZVR
	Yth0i5F42MeYpu8E+yicLWmt1k22Zg4/CuQH0qPGmv2QwG0MtRHq6YRYV5vXWcRt
	jQEtbah0kPII7duFVqZKUC58IvY5SWxobSR7WCAfR5jRKAekE/sjXPCmturM0+Nv
	wrQ5nAurUsG54bw5S4Q1Pc6wMHGNGqv0gUkm4pGhbuKGhaHVyUXqcLNAF2qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712556746; x=1712643146; bh=2r8713Y80mnyyWzn6/p5Jm+n8fhl
	flra3AKBx0z7JY0=; b=E0kJBwDFopCaSXFzky1LCBYQuaWdyCQ272xTaApQNmSZ
	owxvhWhldQtBOttn33lOFc+bIrrMS9XH8OYqdxcdwc+16UWWSb38cBj2Hs3rMzsU
	bMIr381WenySmlpd+OguI/PmBl7P7FEvAkN7fVBc6PNCqmZSdaKBcqsbtN7mut5O
	btcvG0D23CNA5KLRTfwulD3dYP+ZMtlXU/ntNKWyoKybhDr50I0EFS1qlsyN9HIe
	reZPV4GABMxz3Pd/NzY/4vO2f/+G4yl40+fWQA4sVF7RugWRze+MdlZCRinUUJiN
	Fazx2eUvv6gGzf9k1a6GtXvj6PLKR2LSfRdWYX1Hgg==
X-ME-Sender: <xms:yooTZgD6w-ZBjuQebEXlbB-Ic73sqx0VnMQInV_15mTdHZZWJiN-sQ>
    <xme:yooTZiiOAxQIpB9HPxijThPSbA_65Y8F7aKxEuErLDmpsYCocxXNrSEuK78usaYWQ
    _2DxL8_xYhMjLF7RA>
X-ME-Received: <xmr:yooTZjnPe2sexf2GxMr47HhggtR03e9QpU53FJj81gYU5HyigdTUe8VhaDAb6YKOuEVNgLy8P37IKuhGHmHOj1LFI4NBTRG9oCM3abWV6ehMb2HqtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheegkefhjeehfeekhfev
    leenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yooTZmzdU7vrUaSp-eHPMSJOCAhXUeM1yrQN_kABL7Q1_GE5sowDbg>
    <xmx:yooTZlQTeB9bjND5dT-lJ6ZiufBcEDiN3GPzJ3qtgPTdk3shdKBKMw>
    <xmx:yooTZhZP1HEY4q2qgoTmQMZakoGp4O-rgCY_nai13v-7rbH3YFS4tw>
    <xmx:yooTZuQBWaUaWA0DDTsam_aVLQL_16sRYL8_6KIu8Ru8ljvbE4GyqQ>
    <xmx:yooTZuKSLAhWfi5-HUCBgd_XNsfIbjKPQmPu5NykzGQUiZquIhk_fzYQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:12:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6a6d10a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:12:16 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:12:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v5 0/3] reftable/stack: use geometric table compaction
Message-ID: <ZhOKxLCWxp-lOyVh@tanuki>
References: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
 <pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hr9xWzE4UNqqT2Fh"
Content-Disposition: inline
In-Reply-To: <pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>


--hr9xWzE4UNqqT2Fh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 06:29:26PM +0000, Justin Tobler via GitGitGadget wr=
ote:
> Hello again,
>=20
> This is the fifth version my patch series that refactors the reftable
> compaction strategy to instead follow a geometric sequence. Changes compa=
red
> to v4:
>=20
>  * To fix some failing tests and conflicts, this patch series now depends=
 on
>    the ps/pack-refs-auto series which is currently in next.
>  * Lifted the GIT_TEST_REFTABLE_AUTOCOMPACTION env out of the reftable
>    library and into the reftable backend code.
>=20
> Thanks for taking a look!
>=20
> -Justin

I've added two additional nits which you may or may not want to address.
But overall this patch series looks good to me. Thanks!

Patrick

> Justin Tobler (3):
>   reftable/stack: allow disabling of auto-compaction
>   reftable/stack: add env to disable autocompaction
>   reftable/stack: use geometric table compaction
>=20
>  refs/reftable-backend.c    |   4 ++
>  reftable/reftable-writer.h |   3 +
>  reftable/stack.c           | 125 +++++++++++++++++++------------------
>  reftable/stack.h           |   4 --
>  reftable/stack_test.c      |  77 ++++++-----------------
>  t/t0610-reftable-basics.sh |  71 ++++++++++++++++-----
>  6 files changed, 146 insertions(+), 138 deletions(-)
>=20
>=20
> base-commit: 4b32163adf4863c6df3bb6b43540fa2ca3494e28
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1683%2F=
jltobler%2Fjt%2Freftable-geometric-compaction-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1683/jltob=
ler/jt/reftable-geometric-compaction-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/1683
>=20
> Range-diff vs v4:
>=20
>  -:  ----------- > 1:  a7011dbc6aa reftable/stack: allow disabling of aut=
o-compaction
>  1:  2a0421e5f20 ! 2:  7c4fe0e9ec5 reftable/stack: add env to disable aut=
ocompaction
>      @@ Commit message
>      =20
>           Signed-off-by: Justin Tobler <jltobler@gmail.com>
>      =20
>      - ## reftable/stack.c ##
>      -@@ reftable/stack.c: int reftable_addition_commit(struct reftable_a=
ddition *add)
>      - 	if (err)
>      - 		goto done;
>      -=20
>      --	if (!add->stack->disable_auto_compact)
>      -+	if (!add->stack->disable_auto_compact &&
>      -+	    git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1))
>      - 		err =3D reftable_stack_auto_compact(add->stack);
>      -=20
>      - done:
>      -
>      - ## reftable/system.h ##
>      -@@ reftable/system.h: license that can be found in the LICENSE file=
 or at
>      - #include "tempfile.h"
>      - #include "hash-ll.h" /* hash ID, sizes.*/
>      - #include "dir.h" /* remove_dir_recursively, for tests.*/
>      + ## refs/reftable-backend.c ##
>      +@@
>      + #include "../reftable/reftable-merged.h"
>      + #include "../setup.h"
>      + #include "../strmap.h"
>       +#include "parse.h"
>      + #include "refs-internal.h"
>       =20
>      - int hash_size(uint32_t id);
>      + /*
>      +@@ refs/reftable-backend.c: static struct ref_store *reftable_be_in=
it(struct repository *repo,
>      + 	refs->write_options.hash_id =3D repo->hash_algo->format_id;
>      + 	refs->write_options.default_permissions =3D calc_shared_perm(0666=
 & ~mask);
>       =20
>      ++	if (!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1))
>      ++		refs->write_options.disable_auto_compact =3D 1;
>      ++
>      + 	/*
>      + 	 * Set up the main reftable stack that is hosted in GIT_COMMON_DI=
R.
>      + 	 * This stack contains both the shared and the main worktree refs.
>      =20
>        ## t/t0610-reftable-basics.sh ##
>       @@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction=
: writes cause auto-compaction' '
>  2:  e0f4d0dbcc1 ! 3:  8f124acf0f8 reftable/stack: use geometric table co=
mpaction
>      @@ reftable/stack_test.c: static void test_empty_add(void)
>       +
>        static void test_reftable_stack_auto_compaction(void)
>        {
>      - 	struct reftable_write_options cfg =3D { 0 };
>      + 	struct reftable_write_options cfg =3D {
>       @@ reftable/stack_test.c: static void test_reftable_stack_compactio=
n_concurrent_clean(void)
>        int stack_test_main(int argc, const char *argv[])
>        {
>      @@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction:=
 writes are syn
>        	EOF
>        '
>       =20
>      +@@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction=
: fails gracefully when auto compaction fail
>      + 			done ||
>      + 			exit 1
>      + 		done &&
>      +-		test_line_count =3D 13 .git/reftable/tables.list
>      ++		test_line_count =3D 10 .git/reftable/tables.list
>      + 	)
>      + '
>      +=20
>       @@ t/t0610-reftable-basics.sh: test_expect_success 'pack-refs: comp=
acts tables' '
>       =20
>        	test_commit -C repo A &&
>      @@ t/t0610-reftable-basics.sh: test_expect_success 'pack-refs: compa=
cts tables' '
>       =20
>        	git -C repo pack-refs &&
>        	ls -1 repo/.git/reftable >table-files &&
>      +@@ t/t0610-reftable-basics.sh: test_expect_success "$command: auto =
compaction" '
>      + 		# The tables should have been auto-compacted, and thus auto
>      + 		# compaction should not have to do anything.
>      + 		ls -1 .git/reftable >tables-expect &&
>      +-		test_line_count =3D 4 tables-expect &&
>      ++		test_line_count =3D 3 tables-expect &&
>      + 		git $command --auto &&
>      + 		ls -1 .git/reftable >tables-actual &&
>      + 		test_cmp tables-expect tables-actual &&
>      +@@ t/t0610-reftable-basics.sh: test_expect_success "$command: auto =
compaction" '
>      + 		git branch B &&
>      + 		git branch C &&
>      + 		rm .git/reftable/*.lock &&
>      +-		test_line_count =3D 5 .git/reftable/tables.list &&
>      ++		test_line_count =3D 4 .git/reftable/tables.list &&
>      +=20
>      + 		git $command --auto &&
>      + 		test_line_count =3D 1 .git/reftable/tables.list
>       @@ t/t0610-reftable-basics.sh: do
>        			umask $umask &&
>        			git init --shared=3Dtrue repo &&
>=20
> --=20
> gitgitgadget

--hr9xWzE4UNqqT2Fh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTisMACgkQVbJhu7ck
PpQxnA//YVrn3tAwBMXC0vOfXThzdDqCq22v1XG+Q5BUJzZT161EWms0F5zkXu9V
G7Z0umKYErXHb5OZowGxVAD0xgtfFYFL6RP0Uqcs8ZlTI6VIDe7OWhBeMerjVHOj
94c8JnAE2bJaSPwLfy2P2ZRxSqlWcdPaBrewZBQ82tUrdTXgxJ7U7HFkQFdJ41yo
ygKMxrJWgBuGtcds02JdG37zcHtZH02NwOKwk9zN4/i70XfommI3NDDFC9LzvwAw
vVd+ZPgqbLfFqOL6ks2RbE8KKVw5ps1mw91cepA6rrEPkO/3rr36uOZn/e0fEufz
FIi/JZ1jtrm0pqrlOhkxgJXkWBuftNdHAP97Iwi+IZ4XlbSo3mh25ZTtOk6fKGnY
tlI4VuvlmdFZUkVB7ifNDYb7d7GtlDr3mEJAF8tffX/Z8iLcqRSNKlNvTWrHfcTm
GU5FloHLp9ch/oLAIFbTKmCocYp0mPn9+EhnbHufJ3c2qUEXxDhWhZ+unA0mLkXV
8Yfi2crhE8XrwxArcDQqnowAo0QD+O9EuOMJGLQDKfVZDbJun8cwi5sRQu0sTH7K
Hne+WFf04xNXjDZivgEoCydD5bkPbMbsaMfQ8R6ry0kvRIbhSLNjtHnsdWF7159r
d0UZ4Lld9efd6eU20sIjWv4BoMT3ymnKXKU78Vti1lY/QOifbdc=
=Qu05
-----END PGP SIGNATURE-----

--hr9xWzE4UNqqT2Fh--
