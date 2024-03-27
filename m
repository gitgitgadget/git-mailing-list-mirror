Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE421EEFD
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529176; cv=none; b=jBnuH3Mv90eXYs9vjZrkHzlLu7thbvVRmuZOoXiqH/cm0bQUps4qamIw+/CgEF1s7cNRB7IgHKCtrSQFZWsO3WQuTookgWmR0MGlEwP4axWAVkkWqXNl1zDX+tLqvdySRg4SphqclRqmUzGIlSZe9bZWz+jcF7mdNqWr9bBUfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529176; c=relaxed/simple;
	bh=ZB7qg2bRxtI5iXSAkfg+JF851Rmr0SoHjQikBSWFPos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtutSSRZk+Yr4xPCTQXl7tTZhtH2UOpgGyLoIhLogAxtBJbLhewWj+oPx7c0z4eZMHv+yEoikxBtvs97NhRASaYT5smMUpB8SAFBVa+sVm2NP4wedqDOTxWtUuN9uK95Tm0fS7qNaVhx7DCsZYldK7VspNGjTOz2x18Ilt8aoy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AL7aqRZo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=esrx6tHJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AL7aqRZo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="esrx6tHJ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8993E1140175;
	Wed, 27 Mar 2024 04:46:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 27 Mar 2024 04:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711529173; x=1711615573; bh=voCRRaBsHd
	NLtmJUsI419P8wvJq/qxbkUuJUpRmtrwY=; b=AL7aqRZowb2izMKxdq/m/Z2iKm
	BGFzAMLMnMUnWdYh5iGVPaplCdLKfO1lfpVkKVKKITb1GFZ1YTw9enH31/984ab5
	onPEbGJGDcSMjcAUkUhw9iVZPUEe10M1iCpwx+LWty9DcO8s7JYr2Srlo/8AZMdx
	fsHNtHySRdipEUFP0yR210QLvN1ZDE9T2sJlQQTXp99mjzj5GNUjZW6+CmUtPfmh
	+szSGtm7BcJrLEFWX2/Pik5VLUrQM9FWssY2eZXVavNeK5kh32nxP+Vm9WsSoe5z
	yiZxkzXbCqnAzZU+Fsd8hnbLDedkO2sFRhZW1sZQEN0eTFJvV/geuQOA9pOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711529173; x=1711615573; bh=voCRRaBsHdNLtmJUsI419P8wvJq/
	qxbkUuJUpRmtrwY=; b=esrx6tHJ2bqjH5lYFmObZ0TxGvXT/9bRKv4apucQnm9b
	Joc2bprcn7bv4DyI6r6r/cIoJxrnSAdxPC/3VWsRRZHHZA1dMURLEKqC9NM7IlOS
	TJsZXiwBS+HpBjwq7P3bl0JrEG3DWJMJfJpoBYkhw9GcyghIa7Ab6RAFPVcCgGP7
	rnacAFq/Mn/AtzBxfbVwQ9rMvXymZxXISzA0agaudrJkTLhn7MxZJzBJaZNl1C9C
	SK/DhHfNOWXgRTKV/evvvWJy41GnPj6EWFEEFI4Ec+vSH9MlFf+xua1tkaUBhjK3
	zXunu+CTWFC8eD968SKjP7g520bJFwoW3wJLLhalfg==
X-ME-Sender: <xms:1dwDZgOcm1L_Y33hUsG_M2TCIJBG9bh9N-PGKn2x8HdOy0Ntlcthiw>
    <xme:1dwDZm87Jq92vwKAp9GjhJcMf3BbRx_8Ktr4uAAg1xBIQI9HGP-r16a7oTjzpyZxD
    9BRvr7L0HUyWykYOw>
X-ME-Received: <xmr:1dwDZnRgYfCJJYwPGiZ4q6_uVMH-Q20F4VpdQ9n90JC5ay6gTXIFJyaaobEG-zzoPfJdHEpmONTyCFko2Tms3f9MXpt3p1Fv731KieHIX9f1qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:1dwDZou18Z0CzqP32_KjbG03SIhva2rdAdZFR2Qw1KyzQA721AiZLw>
    <xmx:1dwDZofybIuePPIs__9wJjb79wHlxrfiJRoCYKp0hC7weBQLSJMVSA>
    <xmx:1dwDZs0po2ZYI7xobFECNbMkN-uiOdf4jPjptSdHz3PhYkAvztZrOg>
    <xmx:1dwDZs-LoAxdwkOOEmq5IOR_Pkn1muH2uLqFRMOjCDXOL7Ce0OOfIQ>
    <xmx:1dwDZmt_4UWc7CtoQp9wT7TIhfEZLMTksZjy6RN11rwRJCTE6CNu7g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:46:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 22dd845e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:45:57 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:46:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/13] builtin/config: introduce subcommands
Message-ID: <cover.1711527811.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ast0DnotEAQ9gOu2"
Content-Disposition: inline
In-Reply-To: <cover.1709724089.git.ps@pks.im>


--Ast0DnotEAQ9gOu2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that aims to add
subcommands to git-config(1) in a backwards-compatible manner.

There's only been a few changes compared to v2 based on Eric's comments:

    - Touched up a commit message to explain why I had to add cleanups
      to tests.

    - Reformulate "implicit modes" in a comment to clarify that this
      refers to the legacy-style modes.

    - Reformulated documentation of the "get" subcommand.

    - Use `BUG` instead of `echo >&2 && exit 1`.

    - Removed duplicate example in the documentation.

    - Fixed conflicts with 86f9ce7dd6 (docs: fix typo in git-config
      `--default`, 2024-03-16) and 7823a51203 (docs: clarify file
      options in git-config `--edit`, 2024-03-16) by rebasing onto
      latest `master`.

Thanks!

Patrick

Patrick Steinhardt (13):
  builtin/config: move option array around
  builtin/config: move "fixed-value" option to correct group
  builtin/config: use `OPT_CMDMODE()` to specify modes
  builtin/config: pull out function to handle config location
  builtin/config: pull out function to handle `--null`
  builtin/config: introduce "list" subcommand
  builtin/config: introduce "get" subcommand
  builtin/config: introduce "set" subcommand
  builtin/config: introduce "unset" subcommand
  builtin/config: introduce "rename-section" subcommand
  builtin/config: introduce "remove-section" subcommand
  builtin/config: introduce "edit" subcommand
  builtin/config: display subcommand help

 Documentation/git-config.txt | 219 +++++++++-------
 builtin/config.c             | 496 ++++++++++++++++++++++++++++-------
 t/t0450/txt-help-mismatches  |   1 -
 t/t1300-config.sh            | 416 ++++++++++++++++++-----------
 4 files changed, 785 insertions(+), 347 deletions(-)

Range-diff against v2:
 1:  1f21e7fa0d =3D  1:  bfcb50e393 builtin/config: move option array around
 2:  54e536394a =3D  2:  ff428d8a22 builtin/config: move "fixed-value" opti=
on to correct group
 3:  49d190ac24 =3D  3:  e049c05713 builtin/config: use `OPT_CMDMODE()` to =
specify modes
 4:  80093f3908 =3D  4:  41585803bf builtin/config: pull out function to ha=
ndle config location
 5:  283a199578 =3D  5:  95f661f267 builtin/config: pull out function to ha=
ndle `--null`
 6:  53401299fa !  6:  b50f32d074 builtin/config: introduce "list" subcomma=
nd
    @@ Commit message
         ensure that there really is no change in behaviour for the old syn=
tax.
    =20
         Amend tests such that we run them both with old and new style synt=
ax.
    +    As tests are now run twice, state from the first run may be still =
be
    +    around in the second run and thus cause tests to fail. Add cleanup=
 logic
    +    as required to fix such tests.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ Documentation/git-config.txt: Valid `<type>`'s include:
      --show-origin::
     @@ Documentation/git-config.txt: Valid `<type>`'s include:
        When using `--get`, and the requested variable is not found, behave=
 as if
    -   <value> were the value assigned to the that variable.
    +   <value> were the value assigned to that variable.
     =20
     +DEPRECATED MODES
     +----------------
    @@ builtin/config.c: int cmd_config(int argc, const char **argv, const =
char *prefix
     +	 * has been specified. If so, we re-parse it a second time, but this
     +	 * time we drop KEEP_ARGV0. This is so that we don't munge the comma=
nd
     +	 * line in case no subcommand was given, which would otherwise confu=
se
    -+	 * us when parsing the implicit modes.
    ++	 * us when parsing the legacy-style modes that don't use subcommands.
     +	 */
     +	argc =3D parse_options(argc, argv, prefix, builtin_subcommand_option=
s, builtin_config_usage,
     +			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_NO_INTERNAL_HELP|PARS=
E_OPT_KEEP_ARGV0|PARSE_OPT_KEEP_UNKNOWN_OPT);
    @@ t/t1300-config.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +	mode_prefix=3D""
     +	;;
     +*)
    -+	echo "unknown mode $mode" >&2
    -+	exit 1;;
    ++	BUG "unknown mode $mode";;
     +esac
     +
      test_expect_success 'clear default config' '
 7:  8ceced0fc5 !  7:  eee1fae50c builtin/config: introduce "get" subcommand
    @@ Documentation/git-config.txt: COMMANDS
      	List all variables set in config file, along with their values.
     =20
     +get::
    -+	Get value for one or more config options. Values can be filtered by
    -+	regexes and URLs.Returns error code 1 if the key was not found and t=
he
    -+	last value if multiple key values were found. If `--all` is set, then
    -+	all values will be shown.
    ++	Emits the value of the specified key. If key is present multiple tim=
es
    ++	in the configuration, emits the last value. If `--all` is specified,
    ++	emits all values associated with key. Returns error code 1 if key is
    ++	not present.
     +
      [[OPTIONS]]
      OPTIONS
    @@ Documentation/git-config.txt: OPTIONS
     ---get-all::
     -	Like get, but returns all values for a multi-valued key.
     +--all::
    -+	With "get", Return all values for a multi-valued key.
    ++	With `get`, Return all values for a multi-valued key.
     =20
     ---get-regexp::
     -	Like --get-all, but interprets the name as a regular expression and
    @@ Documentation/git-config.txt: OPTIONS
     -	in which section and variable names are lowercased, but subsection
     -	names are not.
     +---regexp::
    -+	With "get", interpret the name as a regular expression. Regular
    ++	With `get`, interpret the name as a regular expression. Regular
     +	expression matching is currently case-sensitive and done against a
     +	canonicalized version of the key in which section and variable names
     +	are lowercased, but subsection names are not.
    @@ Documentation/git-config.txt: Valid `<type>`'s include:
      --default <value>::
     -  When using `--get`, and the requested variable is not found, behave=
 as if
     +  When using `get`, and the requested variable is not found, behave a=
s if
    -   <value> were the value assigned to the that variable.
    +   <value> were the value assigned to that variable.
     =20
      DEPRECATED MODES
     @@ Documentation/git-config.txt: DEPRECATED MODES
    @@ Documentation/git-config.txt: you have to provide a regex matching t=
he value of
     =20
      ------------
     -% git config --get core.filemode
    -+% git config get core.filemode
    - ------------
    -=20
    - or
    -=20
    - ------------
    +-------------
    +-
    +-or
    +-
    +-------------
     -% git config core.filemode
     +% git config get core.filemode
      ------------
    @@ t/t1300-config.sh: do
     +	mode_get_regexp=3D"get --regexp --all --show-names"
      	;;
      *)
    - 	echo "unknown mode $mode" >&2
    + 	BUG "unknown mode $mode";;
     @@ t/t1300-config.sh: test_expect_success 'multi-valued get-all return=
s all' '
      	wow
      	wow2 for me
 8:  aa5c9743ad !  8:  e2815affab builtin/config: introduce "set" subcommand
    @@ Documentation/git-config.txt: You can query/set/replace/unset option=
s with this
      lines, a `value-pattern` (which is an extended regular expression,
      unless the `--fixed-value` option is given) needs to be given.  Only =
the
     @@ Documentation/git-config.txt: get::
    - 	last value if multiple key values were found. If `--all` is set, then
    - 	all values will be shown.
    + 	emits all values associated with key. Returns error code 1 if key is
    + 	not present.
     =20
     +set::
     +	Set value for one or more config options. By default, this command
    @@ Documentation/git-config.txt: OPTIONS
     +	values. This is the same as providing '--value=3D^$' in `set`.
     =20
      --all::
    - 	With "get", Return all values for a multi-valued key.
    + 	With `get`, Return all values for a multi-valued key.
     @@ Documentation/git-config.txt: recommended to migrate to the new syn=
tax.
      'git config <name>'::
      	Replaced by `git config get <name>`.
    @@ t/t1300-config.sh: legacy)
     +	mode_replace_all=3D"set --all"
      	;;
      *)
    - 	echo "unknown mode $mode" >&2
    + 	BUG "unknown mode $mode";;
     @@ t/t1300-config.sh: cat > expect << EOF
      	penguin =3D little blue
      EOF
 9:  c8a44b6189 !  9:  90f055ae1d builtin/config: introduce "unset" subcomm=
and
    @@ t/t1300-config.sh: subcommands)
     +	mode_unset_all=3D"unset --all"
      	;;
      *)
    - 	echo "unknown mode $mode" >&2
    + 	BUG "unknown mode $mode";;
     @@ t/t1300-config.sh: foo =3D bar
      EOF
     =20
10:  a3c66431b0 =3D 10:  3e360b1f47 builtin/config: introduce "rename-secti=
on" subcommand
11:  6314d51cec =3D 11:  d610b5fda1 builtin/config: introduce "remove-secti=
on" subcommand
12:  12011714e3 ! 12:  4a6512c88a builtin/config: introduce "edit" subcomma=
nd
    @@ Documentation/git-config.txt: rename-section::
     =20
     +edit::
     +	Opens an editor to modify the specified config file; either
    -+	`--system`, `--global`, or repository (default).
    ++	`--system`, `--global`, `--local` (default), `--worktree`, or
    ++	`--file <config-file>`.
     +
      [[OPTIONS]]
      OPTIONS
    @@ Documentation/git-config.txt: Valid `<type>`'s include:
     --e::
     ---edit::
     -	Opens an editor to modify the specified config file; either
    --	`--system`, `--global`, or repository (default).
    +-	`--system`, `--global`, `--local` (default), `--worktree`, or
    +-	`--file <config-file>`.
     -
      --[no-]includes::
      	Respect `include.*` directives in config files when looking up
13:  2046f6652a ! 13:  657d1355b5 builtin/config: display subcommand help
    @@ builtin/config.c: static const char *const builtin_config_usage[] =
=3D {
      };
     =20
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const=
 char *prefix)
    - 	 * us when parsing the implicit modes.
    + 	 * us when parsing the legacy-style modes that don't use subcommands.
      	 */
      	argc =3D parse_options(argc, argv, prefix, builtin_subcommand_option=
s, builtin_config_usage,
     -			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_NO_INTERNAL_HELP|PARS=
E_OPT_KEEP_ARGV0|PARSE_OPT_KEEP_UNKNOWN_OPT);

base-commit: c75fd8d8150afdf836b63a8e0534d9b9e3e111ba
--=20
2.44.GIT


--Ast0DnotEAQ9gOu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD3NAACgkQVbJhu7ck
PpQnpA//WSx14SMP9uSWa2BvKZHsZZAOiLn3sGy6oXeD/VAUrWnEI01BbOoyfaK9
v1nUPB10CVUHAAqmGQit8G3B1GWLUQyUGmcFkXhtuf0Sx/gVigmQP/7YTT2RMmfT
98nOK+8ZsJu/77d7RitWjfDQgZQvJNGca+h0BB8oLxYrzIUnntTdiev91ceYIChu
+8knv0ZCz87Ckd7xiLH4wQce5P0dglqaBCVovab6UHyp6vGh0Xi+UZLe9yI7Ycfb
IXJaUJfnlMVIstKBO6B+HGfcjDd+UK/45fIKUSC4ly+oX4zD9H2ul1cbzd774I9m
9Xf1whijsFKUqmwrbOSdeXBU7Ikqsg+wyu2Mk1seRVIrJvaNYM4J+VzQjsZFslax
L+pphbvs506O2k5DhASNtTt20BavfgMs4y5SO87dX+41xGpQjkqx0Pz/dOGD598b
l8/H4KDEM89NRtQ722V4hcTdBlJLl7X0P1MY8VVkaAk/bNhsG9oEqPwiVkPiQLGr
A5mlhsghLKBdnWLmH1eb6v0/kWmpxuDUn2J5EbZHpoXvThazx1hWoOQ73jmhbO+K
O7uHmk3J0l3sfxSQ5TzLy4LFcKfQNQs/8aF5QEIyrSqi5dGFnb5mSYRLqD4zr1xb
6b+PloF1BV2XkuDtkWnkAVOF+yzjU2i5beiLJR7gXoNOO+GsV+s=
=XLBz
-----END PGP SIGNATURE-----

--Ast0DnotEAQ9gOu2--
