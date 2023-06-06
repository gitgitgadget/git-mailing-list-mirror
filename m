Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603F0C77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 05:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjFFFTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 01:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjFFFTd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 01:19:33 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3004123
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 22:19:31 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0369F32002D8;
        Tue,  6 Jun 2023 01:19:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 06 Jun 2023 01:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686028770; x=1686115170; bh=Ra
        fEOYM6KPWu81DUBBZirdJAmZHh7aYGnLHOkNsPYEo=; b=pAsqnzf3mSyVfAZaF+
        nsvRxwJEgHZXcw7XbSgRNP/FRPzUkp516Q5axkX/qOzChSYsfyNBhU5UypvVwlYS
        qUTrCU8WqzJ4L3qLN/PbTfxApu4YzvK5qRus0UeCqIjJ2rl3BuM4tf9kOrRNGJ72
        fzhEAQ7LRjxJhUcv1eeCeSED1jHKTZi+vMqsqdZmdcRhJ5exg10/olSHpfLlRfSb
        MRNjYjZkWtMacpTQltz4WFc8U0vODh0FFXFySakx9VYMeXU9CL34CPsgB4R8TBPf
        R58RPOxEhH4LXOE/lfzXW6ypdSxmgFVwUm2Wfgauyj/2wC9+mVSVVIdAGbM/K27B
        eREw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686028770; x=1686115170; bh=RafEOYM6KPWu8
        1DUBBZirdJAmZHh7aYGnLHOkNsPYEo=; b=j7GsLOWbtWb+UmLF+cinSglmjUONc
        dNpPPJ4O2yg+adg5O0FG7cYnkiklsE9JUS42mio/2NdIUWr8enOnB4Y6upKMWje9
        eY87/0IXf64HRRu1qNesAwaZlpuvQe0PZnwvuBVbYuVCo+CEQbq4P+87mZHm4ONk
        63KjiMYug1m5UzwVbUxzG3aG+FEpEc3ugwTKH48VgrlkLbyyY30wZI+GaYmjivMV
        mBW9hUj/3cPZuTAwop6DHEK88TXPJmxEyUv+Xm8wOKfRl1lHtc8p5hYvwYrLBfWf
        OW8PrRBeTCYowf8cAFnbMYBAOtIj/YT1cOamQK+kKtMGtTQyWbPv0HyOw==
X-ME-Sender: <xms:4sF-ZCreoPj5guOu_X6h8JZ4iAn7svRrgwOLThlOiH406o8-lTMO0A>
    <xme:4sF-ZApwxuY7_wEXlnqjH37jAgNDE_NucG9aQqLKKB8uDDHLP9BALsKH51Hw7jr3A
    15m5TdkWg7QHAZzcg>
X-ME-Received: <xmr:4sF-ZHMIv3fHxYYQpC1G_4G935MuPJbBL9U2HzOdpvbuGwsqGf98caaUAH7un_pt8o7RjgHOMOq7tGn5POZLY0l6w54PqYMac9ZmhAwRpRI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:4sF-ZB5X1Wa0pTiYG8WqohNcaNK8EU6SbMqI4nLsxlnX1v0rSh2JKw>
    <xmx:4sF-ZB7QBgVHngDq-E1V_XC47LKT4veJqyWi1vTfnHK9yPcyr3mcVg>
    <xmx:4sF-ZBgtcKMZS5sXmFGcXMskLycD9VnqQuubHVcsJKGJgNfswkpGJw>
    <xmx:4sF-ZLkdmA8H-S5X2HSiEQoAay0pbu04oKFTsG0_I_4u0AcfILOYzQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 01:19:28 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 70353c3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Jun 2023 05:18:22 +0000 (UTC)
Date:   Tue, 6 Jun 2023 07:19:24 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/5] catfile: introduce NUL-terminated output format
Message-ID: <cover.1686028409.git.ps@pks.im>
References: <cover.1685710884.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zfHs/mwqx5KhF82g"
Content-Disposition: inline
In-Reply-To: <cover.1685710884.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zfHs/mwqx5KhF82g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that introduces a new NUL
terminated output format to git-cat-file(1) in order to make its output
unambiguously parsable in the case where the input contains newlines.

Changes compared to v1:

    - Improved the commit subject of v5 to mention that the new option
      changes both input and output to be NUL delimited.

    - Extended the commit message to make a better case for why `-Z`
      changes both input and output format to be NUL terminated, instead
      of having `-z` change the input and `-Z` change the output format.

    - The `-Z` option is now sorted before `-z` in git-cat-file(1).

    - The `-z` option is now deprecated "even more", where it is hidden
      from the synopsis as well as from the `-h` output.

    - A small change to pass the delimiter to `batch_write()` directly
      instead of storing it in a temporary array first.

Thanks for your feedback, Junio and Phillip!

Patrick

Patrick Steinhardt (5):
  t1006: don't strip timestamps from expected results
  t1006: modernize test style to use `test_cmp`
  strbuf: provide CRLF-aware helper to read until a specified delimiter
  cat-file: simplify reading from standard input
  cat-file: introduce option to delimit input and output with NUL

 Documentation/git-cat-file.txt |  15 +-
 builtin/cat-file.c             |  85 +++++------
 strbuf.c                       |  11 +-
 strbuf.h                       |  12 ++
 t/t1006-cat-file.sh            | 249 +++++++++++++++++++++------------
 5 files changed, 233 insertions(+), 139 deletions(-)

Range-diff against v1:
1:  5c8b4a1d70 =3D 1:  5c8b4a1d70 t1006: don't strip timestamps from expect=
ed results
2:  251fc2a387 =3D 2:  251fc2a387 t1006: modernize test style to use `test_=
cmp`
3:  8127eeac97 =3D 3:  8127eeac97 strbuf: provide CRLF-aware helper to read=
 until a specified delimiter
4:  e7cba8dc4c =3D 4:  e7cba8dc4c cat-file: simplify reading from standard =
input
5:  07a7c34615 ! 5:  79ed618c84 cat-file: Introduce new option to delimit o=
utput with NUL characters
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    cat-file: Introduce new option to delimit output with NUL characte=
rs
    +    cat-file: introduce option to delimit input and output with NUL
    =20
         In db9d67f2e9 (builtin/cat-file.c: support NUL-delimited input with
         `-z`, 2022-07-22), we have introduced a new mode to read the input=
 via
    @@ Commit message
         given that revisions containing newlines are quite exotic.
    =20
         Instead, introduce a new option `-Z` that switches to NUL-delimited
    -    input and output. The old `-z` option is marked as deprecated with=
 a
    -    hint that its output may become unparsable.
    +    input and output. While this new option could arguably only switch=
 the
    +    output format to be NUL-delimited, the consequence would be that u=
sers
    +    have to always specify both `-z` and `-Z` when the input may conta=
in
    +    newlines. On the other hand, if the user knows that there never wi=
ll be
    +    newlines in the input, they don't have to use either of those opti=
ons.
    +    There is thus no usecase that would warrant treating input and out=
put
    +    format separately, which is why we instead opt to "do the right th=
ing"
    +    and have `-Z` mean to NUL-terminate both formats.
    +
    +    The old `-z` option is marked as deprecated with a hint that its o=
utput
    +    may become unparsable. It is thus hidden both from the synopsis as=
 well
    +    as the command's help output.
    =20
         Co-authored-by: Toon Claes <toon@iotcl.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ Documentation/git-cat-file.txt: SYNOPSIS
      'git cat-file' (--batch | --batch-check | --batch-command) [--batch-a=
ll-objects]
      	     [--buffer] [--follow-symlinks] [--unordered]
     -	     [--textconv | --filters] [-z]
    -+	     [--textconv | --filters] [-z] [-Z]
    ++	     [--textconv | --filters] [-Z]
      'git cat-file' (--textconv | --filters)
      	     [<rev>:<path|tree-ish> | --path=3D<path|tree-ish> <rev>]
     =20
     @@ Documentation/git-cat-file.txt: respectively print:
    - -z::
    - 	Only meaningful with `--batch`, `--batch-check`, or
    - 	`--batch-command`; input is NUL-delimited instead of
    -+	newline-delimited. This option is deprecated in favor of
    -+	`-Z` as the output can otherwise be ambiguous.
    -+
    + 	/etc/passwd
    + --
    +=20
     +-Z::
     +	Only meaningful with `--batch`, `--batch-check`, or
     +	`--batch-command`; input and output is NUL-delimited instead of
    - 	newline-delimited.
    ++	newline-delimited.
    ++
    + -z::
    + 	Only meaningful with `--batch`, `--batch-check`, or
    + 	`--batch-command`; input is NUL-delimited instead of
    +-	newline-delimited.
    ++	newline-delimited. This option is deprecated in favor of
    ++	`-Z` as the output can otherwise be ambiguous.
     =20
     =20
    + OUTPUT
     @@ Documentation/git-cat-file.txt: notdir SP <size> LF
      is printed when, during symlink resolution, a file is used as a
      directory name.
    @@ builtin/cat-file.c: static void batch_object_write(const char *obj_n=
ame,
      	batch_write(opt, scratch->buf, scratch->len);
     =20
      	if (opt->batch_mode =3D=3D BATCH_MODE_CONTENTS) {
    -+		char buf[] =3D {opt->output_delim};
      		print_object_or_die(opt, data);
     -		batch_write(opt, "\n", 1);
    -+		batch_write(opt, buf, 1);
    ++		batch_write(opt, &opt->output_delim, 1);
      	}
      }
     =20
    @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, co=
nst char *pr
      		N_("git cat-file (--batch | --batch-check | --batch-command) [--bat=
ch-all-objects]\n"
      		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
     -		   "             [--textconv | --filters] [-z]"),
    -+		   "             [--textconv | --filters] [-z] [-Z]"),
    ++		   "             [--textconv | --filters] [-Z]"),
      		N_("git cat-file (--textconv | --filters)\n"
      		   "             [<rev>:<path|tree-ish> | --path=3D<path|tree-ish> =
<rev>]"),
      		NULL
     @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, c=
onst char *prefix)
    + 			N_("like --batch, but don't emit <contents>"),
      			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
      			batch_option_callback),
    - 		OPT_BOOL('z', NULL, &input_nul_terminated, N_("stdin is NUL-termina=
ted")),
    +-		OPT_BOOL('z', NULL, &input_nul_terminated, N_("stdin is NUL-termina=
ted")),
    ++		OPT_BOOL_F('z', NULL, &input_nul_terminated, N_("stdin is NUL-termi=
nated"),
    ++			PARSE_OPT_HIDDEN),
     +		OPT_BOOL('Z', NULL, &nul_terminated, N_("stdin and stdout is NUL-te=
rminated")),
      		OPT_CALLBACK_F(0, "batch-command", &batch, N_("format"),
      			N_("read commands from stdin"),
--=20
2.41.0


--zfHs/mwqx5KhF82g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR+wdsACgkQVbJhu7ck
PpT47A//T0s3i56/tBa9yODuUHZA5YGfk7MLkkKfa2OAzdG3+o1B1cgWikmWTNNi
LZ3OADfzyHpcAnEsazrTzILXkd1TLs8XxjXrNVg7RaSjY/RrYeSp+vlTbG/n0pv3
ju8j/kyjadsWkYLcLxRQ6W+ZTzs8y2etWNN/llG76o6iXts2RJywPyvokdU1JxP0
wD9t6LM9LmQyG0pOS0JoC97TrihnlbtHI0XeBPYuDljckpES7UgEtGOAvUHVasiV
0EP+VQHWvsGoOf28PRrlcYq8fSrWoH4dkUriQ6NvaEfyBq77khpJ7HZtZgDVeQu6
cXf9FfA/YmZOIRzvi5JWn01DFTcHLdWBpzTMuBMwTBQ5f5p0T4TVU6eqR93KzsMS
EG5/4AEZPF8slFZPnfIoRzK2ajk8XpNXz1pXZsx5SnU2ZFrRWNqe9eJzlxCbNymJ
knyMETOiWUzWIUDIJwCrQW7a8BO82vjlqBe8+aMB5rXWtqsSUqFu6G+oTClskzm8
gESZCtp0hsnaFqGbRaMTFp7K4FKGXk6zUobTwSMrJTQo7rUMLfn8Qn2W7LmN3hCM
0nEyvAMVGv1vhU04sInOcFG16lIRm63HiiJ8Ew8DNtqmyFgfQ+jUNZEfXrRqSq8K
avWSQMXnbx5iNBD1/qqp1qyqlPLn+7jrCnQBsFjVBbvqi+KCAUw=
=9jpp
-----END PGP SIGNATURE-----

--zfHs/mwqx5KhF82g--
