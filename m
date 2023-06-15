Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001CDEB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 14:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbjFOOmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241515AbjFOOjw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 10:39:52 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEED1A2
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 07:39:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 155325C01B7;
        Thu, 15 Jun 2023 10:39:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Jun 2023 10:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686839991; x=1686926391; bh=R1
        i5Shtnt8kVKI6s6EMEGWkkd6i/vsXurwrwGkFob8o=; b=nad2RKbkzEXUvQ59X3
        AXYQ9YM4IZzwAx+6H/UimS19uBsqs6qOI6uLlLUMTadipYXsCdqFv5+kX6aIoQWy
        VbYCbhNdTzswianXm2+3twOPPNzTMQqpSPCVRX8fMNqqfdjZMqJg+AOY949T6mxb
        xjwOibRwZQT7m9mV0vj32ywOE9KChEvPrMKHbbOeTgwishgc0IANQpwngZZt2h6y
        r9cDU329VDLbdmrzirWpIh6eebbQTh8NxOw2Nqwg+XHbNjE2TxEgFkfSQRgCJVId
        7skJqpRzZfdidDlIs958eoz6HSqhdjSnd0fenItixV/5/a7nMid8YsVVWNf/ibbx
        4iWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686839991; x=1686926391; bh=R1i5Shtnt8kVK
        I6s6EMEGWkkd6i/vsXurwrwGkFob8o=; b=eY2FOMOoJT9qAtAfZ9HnyQp8TQRyN
        mb2XuX8oJFQ+6/fsbtKbeADDGOrgiZE9hRITkgD2XGBP4IVVlFpS9ihK+5YV1uGN
        cF/xNF/gYZLbNh6mBu3kD1yq9JJIOUo0RE+MaLONDJV2ksvspmGifzdHfwZIDFoc
        +f4nBpkBvZbhlZ+BY6Z3LOzp52OB5gsprpoNHES6w6Siq0+Iu423WbR12FUkWZY7
        ZN9sjikV2+ISFwQt2cCpF+odQGXKDTLduq7+lIVd9lUHhj6xmLK476xDCEQ4+43t
        UCminEPRqPiIE40tkPPWrf/Tmlcr396j/oS40lsDYOlYqevThsQEsInWw==
X-ME-Sender: <xms:tiKLZKd4PKv54dZNB41rb1vWfCMt-Elkz8k5nzzTg0Sb12If0aMRsw>
    <xme:tiKLZEOFD5HteOG71rHFkln6QhJLCyi9DeFW0CK6UOThJlfTrfb4q9IpzChQ_YLa5
    qtblWMKTjmeP6fJ6w>
X-ME-Received: <xmr:tiKLZLhHeqCPp4Jv_P8mLOGRXLjxklm_MWdAJXxf-bD5xl9eh-Bu8AaUwFXah6_JF3aOe-R6EiOaQdHSm18ZaDGEDuxdxKtwFmaKEGpJzePWMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:tiKLZH9FAyOTsuw1LjQ6aB1sRueewPORipXOxLWv_xJ9Qn2QTvYUkA>
    <xmx:tiKLZGt1LEhVWhDCoHsSPsAVlkC5pTzjdygIDEQRK0FZwUz_EWJ12w>
    <xmx:tiKLZOG89jWRCVi4H-7qNNwhVqYBVbIE8eELxgdeB_qxEEyNCGuNwA>
    <xmx:tyKLZM2jM3CUA4zgIC4luS4751MAG8vFRAEbOMrHIS2pl0RUX6fAeA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 10:39:49 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 209e9d03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 15 Jun 2023 14:39:43 +0000 (UTC)
Date:   Thu, 15 Jun 2023 16:39:46 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] revision: handle pseudo-opts in `--stdin` mode
Message-ID: <cover.1686839572.git.ps@pks.im>
References: <cover.1686744685.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xvumfsonaeysoyjg"
Content-Disposition: inline
In-Reply-To: <cover.1686744685.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xvumfsonaeysoyjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series to support handling of
pseudo-opts like `--all` or `--glob=3D` in both git-rev-list(1)'s and
git-log(1)'s `--stdin` mode.

Changes compared to v1:

    - Patch 2/3: Changed the small refactoring to hoist out the check
      for "--" out of the `if (sb.buf[0] =3D=3D '-')` block completely to
      make for an easier read.

    - Patch 3/3: Implemented support for `--end-of-options` so that it
      becomes possible to ask for references that have a leading dash.

    - Patch 3/3: Fixed an issue where invalid pseudo-opts (e.g.
      `--no-walk=3Dgarbage`) would not be recognized.

This is based on Junio's feedback, thank you!

Patrick

Patrick Steinhardt (3):
  revision: reorder `read_revisions_from_stdin()`
  revision: small readability improvement for reading from stdin
  revision: handle pseudo-opts in `--stdin` mode

 Documentation/rev-list-options.txt |  9 ++--
 revision.c                         | 82 +++++++++++++++++-------------
 t/t6017-rev-list-stdin.sh          | 51 ++++++++++++++++++-
 3 files changed, 103 insertions(+), 39 deletions(-)

Range-diff against v1:
1:  6cd4f79482 =3D 1:  6cd4f79482 revision: reorder `read_revisions_from_st=
din()`
2:  38c0415ee9 ! 2:  5c1a9a0d08 revision: small readability improvement for=
 reading from stdin
    @@ Commit message
         revision: small readability improvement for reading from stdin
    =20
         The code that reads lines from standard input manually compares wh=
ether
    -    the read line matches "--", which is a bit awkward to read. Refact=
or it
    -    to instead use strcmp(3P) for a small code style improvement.
    +    the read line matches "--", which is a bit awkward to read. Furthe=
rmore,
    +    we're about to extend the code to also support reading pseudo-opti=
ons
    +    via standard input, requiring more elaborate handling of lines wit=
h a
    +    leading dash.
    +
    +    Refactor the code by hoisting out the check for "--" outside of the
    +    block that checks for a leading dash.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ revision.c: static void read_revisions_from_stdin(struct rev_info *r=
evs,
     -		int len =3D sb.len;
     -		if (!len)
     +		if (!sb.len)
    - 			break;
    ++			break;
     +
    - 		if (sb.buf[0] =3D=3D '-') {
    ++		if (!strcmp(sb.buf, "--")) {
    ++			seen_dashdash =3D 1;
    + 			break;
    +-		if (sb.buf[0] =3D=3D '-') {
     -			if (len =3D=3D 2 && sb.buf[1] =3D=3D '-') {
    -+			if (!strcmp(sb.buf, "--")) {
    - 				seen_dashdash =3D 1;
    - 				break;
    - 			}
    -+
    - 			die("options not supported in --stdin mode");
    +-				seen_dashdash =3D 1;
    +-				break;
    +-			}
    +-			die("options not supported in --stdin mode");
      		}
    ++
    ++		if (sb.buf[0] =3D=3D '-')
    ++			die("options not supported in --stdin mode");
     +
      		if (handle_revision_arg(sb.buf, revs, 0,
      					REVARG_CANNOT_BE_FILENAME))
3:  4575917127 ! 3:  0cf189b378 revision: handle pseudo-opts in `--stdin` m=
ode
    @@ revision.c: static int handle_revision_pseudo_opt(struct rev_info *r=
evs,
      {
      	struct strbuf sb;
      	int seen_dashdash =3D 0;
    ++	int seen_end_of_options =3D 0;
    + 	int save_warning;
    +=20
    + 	save_warning =3D warn_on_object_refname_ambiguity;
     @@ revision.c: static void read_revisions_from_stdin(struct rev_info *=
revs,
      			break;
    + 		}
     =20
    - 		if (sb.buf[0] =3D=3D '-') {
    -+			const char *argv[2] =3D { sb.buf, NULL };
    -+
    - 			if (!strcmp(sb.buf, "--")) {
    - 				seen_dashdash =3D 1;
    - 				break;
    - 			}
    -=20
    +-		if (sb.buf[0] =3D=3D '-')
     -			die("options not supported in --stdin mode");
    -+			if (handle_revision_pseudo_opt(revs, argv, flags))
    ++		if (!seen_end_of_options && sb.buf[0] =3D=3D '-') {
    ++			const char *argv[] =3D { sb.buf, NULL };
    ++
    ++			if (!strcmp(sb.buf, "--end-of-options")) {
    ++				seen_end_of_options =3D 1;
     +				continue;
    ++			}
     +
    -+			die(_("option '%s' not supported in --stdin mode"), sb.buf);
    - 		}
    ++			if (handle_revision_pseudo_opt(revs, argv, flags) > 0)
    ++				continue;
    ++
    ++			die(_("invalid option '%s' in --stdin mode"), sb.buf);
    ++		}
     =20
      		if (handle_revision_arg(sb.buf, revs, 0,
    + 					REVARG_CANNOT_BE_FILENAME))
     @@ revision.c: int setup_revisions(int argc, const char **argv, struct=
 rev_info *revs, struct s
      				}
      				if (revs->read_from_stdin++)
    @@ revision.c: int setup_revisions(int argc, const char **argv, struct =
rev_info *re
     =20
    =20
      ## t/t6017-rev-list-stdin.sh ##
    +@@ t/t6017-rev-list-stdin.sh: test_expect_success setup '
    + 			git add file-$i &&
    + 			test_tick &&
    + 			git commit -m side-$i || exit
    +-		done
    ++		done &&
    ++
    ++		git update-ref refs/heads/-dashed-branch HEAD
    + 	)
    + '
    +=20
     @@ t/t6017-rev-list-stdin.sh: check side-1 ^side-7 -- file-2
      check side-3 ^side-4 -- file-3
      check side-3 ^side-2
    @@ t/t6017-rev-list-stdin.sh: check side-1 ^side-7 -- file-2
     +check --glob=3Drefs/heads
     +check --glob=3Drefs/heads --
     +check --glob=3Drefs/heads -- file-1
    ++check --end-of-options -dashed-branch
     =20
      test_expect_success 'not only --stdin' '
      	cat >expect <<-EOF &&
    @@ t/t6017-rev-list-stdin.sh: test_expect_success 'not only --stdin' '
     +	test_cmp expect error
     +'
     +
    -+test_expect_success 'unknown options' '
    ++test_expect_success 'pseudo-opt with invalid value' '
    ++	cat >input <<-EOF &&
    ++	--no-walk=3Dgarbage
    ++	EOF
    ++
    ++	cat >expect <<-EOF &&
    ++	error: invalid argument to --no-walk
    ++	fatal: invalid option ${SQ}--no-walk=3Dgarbage${SQ} in --stdin mode
    ++	EOF
    ++
    ++	test_must_fail git rev-list --stdin <input 2>error &&
    ++	test_cmp expect error
    ++'
    ++
    ++test_expect_success 'unknown option without --end-of-options' '
     +	cat >input <<-EOF &&
    -+	--unknown=3Dvalue
    ++	-dashed-branch
     +	EOF
     +
     +	cat >expect <<-EOF &&
    -+	fatal: option ${SQ}--unknown=3Dvalue${SQ} not supported in --stdin m=
ode
    ++	fatal: invalid option ${SQ}-dashed-branch${SQ} in --stdin mode
     +	EOF
     +
     +	test_must_fail git rev-list --stdin <input 2>error &&
--=20
2.41.0


--xvumfsonaeysoyjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmSLIrEACgkQVbJhu7ck
PpSgoA/+Pdc0JCkTlt+JjYbH9t4JStbEknsou3E8DuXohalwi3TEHz3Vi5kokgxJ
mwe10d/Tx+sS7PVKCy0x8rFQCmoJlk+OyF/fLnmycccwp3fvPOHkv/pvSVzLNIUQ
WLQb9MaDkLmWbvhAKwbk8p6zri++80P8fYWPEoVGxZqMIsTDRoLn2YytmQKKy+P1
Wii+xvQIrK/bOEsXMo+htvuLJVynrEp0jj1DBwNPSK57Y3X3La2m+1scIwB+etEO
+12iDweAYqp8teCQyw4aB/3AdiLK5iTWhcnYaRIpDO8nz0df+nAsrL5F+BX4VcKR
4if7rvevMuCeyjJuJxbpHS9WmFXVtwX3imK6ixBbXWnihCp20Bajwi4ZwYyYMLPy
mvUWi0c+y+TcXzWKby0u9vGdcYbJje4ZxmJDsaQpW6YPeUJqkRCMWAe9PmRkgUUb
CSDYh1sNkdhEdcS0Fua+eOQsHmkhc65EgKs0PbgaP29VlZQBO5JfrwlH6bJfQZB+
8EfxPzrEdjYpchSRyrL43cVeAkUOTtsOb/EpUO0TX9z/k6l6jH7ENk4oeJCeE1X1
z1chbSwzQLI3irKUzkV4SpI0D/keqepdyHiqWWeH7ON1/pVLEg/QLeu7U9gOf9Nu
m5OkNFnoZ3WjklMp9m6NUnDwRiSqsZk+4xJlHPHGMx0XHs12tFw=
=Op+r
-----END PGP SIGNATURE-----

--xvumfsonaeysoyjg--
