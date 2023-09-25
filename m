Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE66CE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 13:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjIYNCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 09:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjIYNCP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 09:02:15 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01CE107
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 06:02:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E9EC05C0076;
        Mon, 25 Sep 2023 09:02:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 25 Sep 2023 09:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1695646926; x=1695733326; bh=LF
        AcvVRTxf7PDfGJwZncGSHEhXEeO4na1dbY5w4mnXs=; b=GLNaXuc/l0cCC/fy4f
        WiIMK74Ey5+F1nSC214H1lkiny50Br/73XbU0Hm77Ko0jTXXACjin9/STCGWkKIr
        fI2/Ud5vRI0IjawRoe1xAhyI9Ajo040lTTLGs6gBw27PHPtavZrTq98nk7Tq2i64
        prnj95OUyJmkMYz4hcDwpRCErSoVwkjrNVGzAQv890D79RKRedMgc8fZLRLoIASM
        cDZHgv7RDWRnweYm43W3osKaSNz6meuMdChrY2GHUGQtVUQq18Nq5b+8TtT762Nd
        CN1njuaahfT5a9VztKCO1j23SJpaPHagaK6fHWnlReUys9FMPb3foySzPppWU4E6
        Kjrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695646926; x=1695733326; bh=LFAcvVRTxf7PD
        fGJwZncGSHEhXEeO4na1dbY5w4mnXs=; b=bj8fULdBX8IjRvHGw41iQy5+8NS55
        knNJfFGTU0ztqtukOizVG2EnfjYD/qC4FN2qhErGqf+Mr+FPmlmthvRCECnWkOXD
        Pr5ewYpF++VN5cdz7oxp6ZkXTF5arBnReegFEGUa7iCcVymaPA/uIiYBC7AtfH2p
        11JOTBvhmxCyN6tZwW3Asu3XB535XOou45N3ntASdbgbkGWxlPyJx/cXV7cC2ioF
        yrwhFmgVnfYR9zfQ4ACKgK4G9DoItFxeoBkGS08Na+CCv5HluXr8gS1E4bh4bHs7
        LpwQXfJT3P/swSRIcQaRUSLTV6gn1sg/sf5ceXriAwyhleGVMi5dle0RA==
X-ME-Sender: <xms:zoQRZcN_t1kWvVgcuFogiJ_K3CzJP8cgG_OfX0VbYAJgg55Y43C8wg>
    <xme:zoQRZS-0pDkVFDdEDGOvmnuYLms09bi36Z6dgkCXrzavGRgVjbeKEq9yEorSqJ5og
    o353Cn1uGw31yO4BQ>
X-ME-Received: <xmr:zoQRZTRKt1lg0teTKEJ0tRfJ97gQ_T7SCnK6Eqm9oFbNDzHzNZmr-4wIaT4AmnfXcpkxDzKYQR-SJ4_fSzydtOKSjN4ODzYRNFnJKcvrWb60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:zoQRZUu8iKQC7jWJC6OeA7kRoBg7yzPTK6aLwWhgTfes25g-2ShSlQ>
    <xmx:zoQRZUdSy8JPSTyX_XwGqJ5BCQ8Fphl44sp9i6bhGwo0iKigFJNpHA>
    <xmx:zoQRZY1u2Ii4Bd_N-MOSVp6RmYtfPABP4DGv7lTwQ0KRCd5mApgYNA>
    <xmx:zoQRZVrBXR6F6srmrAXLhVP65eM_3gOjo-5wCVfGn8bd4-EjkoGoDw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 09:02:05 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 9942fb47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 25 Sep 2023 13:02:02 +0000 (UTC)
Date:   Mon, 25 Sep 2023 15:02:00 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] revision: make pseudo-opt flags read via stdin behave
 consistently
Message-ID: <6221acd2796853144f8e84081655fbc79fdc6634.1695646898.git.ps@pks.im>
References: <b93d4c8c23552abab64084b62f27944e7e192c0c.1695290733.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HVRnrMb86oT6HpGj"
Content-Disposition: inline
In-Reply-To: <b93d4c8c23552abab64084b62f27944e7e192c0c.1695290733.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HVRnrMb86oT6HpGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When reading revisions from stdin via git-rev-list(1)'s `--stdin` option
then these revisions never honor flags like `--not` which have been
passed on the command line. Thus, an invocation like e.g. `git rev-list
--all --not --stdin` will not treat all revisions read from stdin as
uninteresting. While this behaviour may be surprising to a user, it's
been this way ever since it has been introduced via 42cabc341c4 (Teach
rev-list an option to read revs from the standard input., 2006-09-05).

With that said, in c40f0b7877 (revision: handle pseudo-opts in `--stdin`
mode, 2023-06-15) we have introduced a new mode to read pseudo opts from
standard input where this behaviour is a lot more confusing. If you pass
`--not` via stdin, it will:

    - Influence subsequent revisions or pseudo-options passed on the
      command line.

    - Influence pseudo-options passed via standard input.

    - _Not_ influence normal revisions passed via standard input.

This behaviour is extremely inconsistent and bound to cause confusion.

While it would be nice to retroactively change the behaviour for how
`--not` and `--stdin` behave together, chances are quite high that this
would break existing scripts that expect the current behaviour that has
been around for many years by now. This is thus not really a viable
option to explore to fix the inconsistency.

Instead, we change the behaviour of how pseudo-opts read via standard
input influence the flags such that the effect is fully localized. With
this change, when reading `--not` via standard input, it will:

    - _Not_ influence subsequent revisions or pseudo-options passed on
      the command line, which is a change in behaviour.

    - Influence pseudo-options passed via standard input.

    - Influence normal revisions passed via standard input, which is a
      change in behaviour.

Thus, all flags read via standard input are fully self-contained to that
standard input, only.

While this is a breaking change as well, the behaviour has only been
recently introduced with Git v2.42.0. Furthermore, the current behaviour
can be regarded as a simple bug. With that in mind it feels like the
right thing to retroactively change it and make the behaviour sane.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
Reported-by: Christian Couder <christian.couder@gmail.com>
---
Range-diff against v1:
1:  b93d4c8c23 ! 1:  6221acd279 revision: make pseudo-opt flags read via st=
din behave consistently
    @@ Commit message
         While this is a breaking change as well, the behaviour has only be=
en
         recently introduced with Git v2.42.0. Furthermore, the current beh=
aviour
         can be regarded as a simple bug. With that in mind it feels like t=
he
    -    right thing to do retroactively change it and make the behaviour s=
ane.
    +    right thing to retroactively change it and make the behaviour sane.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
         Reported-by: Christian Couder <christian.couder@gmail.com>
    @@ Documentation/rev-list-options.txt: endif::git-log[]
      	Reverses the meaning of the '{caret}' prefix (or lack thereof)
      	for all following revision specifiers, up to the next `--not`.
     +	When used on the command line before --stdin, the revisions passed
    -+	through stdin will not be affected by it.
    ++	through stdin will not be affected by it. Conversely, when passed
    ++	via standard input, the revisions passed on the command line will
    ++	not be affected by it.
     =20
      --all::
      	Pretend as if all the refs in `refs/`, along with `HEAD`, are

 Documentation/rev-list-options.txt |  8 +++++++-
 revision.c                         | 10 +++++-----
 t/t6017-rev-list-stdin.sh          | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-op=
tions.txt
index a4a0cb93b2..66d71d1b95 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -151,6 +151,10 @@ endif::git-log[]
 --not::
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
 	for all following revision specifiers, up to the next `--not`.
+	When used on the command line before --stdin, the revisions passed
+	through stdin will not be affected by it. Conversely, when passed
+	via standard input, the revisions passed on the command line will
+	not be affected by it.
=20
 --all::
 	Pretend as if all the refs in `refs/`, along with `HEAD`, are
@@ -240,7 +244,9 @@ endif::git-rev-list[]
 	them from standard input as well. This accepts commits and
 	pseudo-options like `--all` and `--glob=3D`. When a `--` separator
 	is seen, the following input is treated as paths and used to
-	limit the result.
+	limit the result. Flags like `--not` which are read via standard input
+	are only respected for arguments passed in the same way and will not
+	influence any subsequent command line arguments.
=20
 ifdef::git-rev-list[]
 --quiet::
diff --git a/revision.c b/revision.c
index 2f4c53ea20..a1f573ca06 100644
--- a/revision.c
+++ b/revision.c
@@ -2788,13 +2788,13 @@ static int handle_revision_pseudo_opt(struct rev_in=
fo *revs,
 }
=20
 static void read_revisions_from_stdin(struct rev_info *revs,
-				      struct strvec *prune,
-				      int *flags)
+				      struct strvec *prune)
 {
 	struct strbuf sb;
 	int seen_dashdash =3D 0;
 	int seen_end_of_options =3D 0;
 	int save_warning;
+	int flags =3D 0;
=20
 	save_warning =3D warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity =3D 0;
@@ -2817,13 +2817,13 @@ static void read_revisions_from_stdin(struct rev_in=
fo *revs,
 				continue;
 			}
=20
-			if (handle_revision_pseudo_opt(revs, argv, flags) > 0)
+			if (handle_revision_pseudo_opt(revs, argv, &flags) > 0)
 				continue;
=20
 			die(_("invalid option '%s' in --stdin mode"), sb.buf);
 		}
=20
-		if (handle_revision_arg(sb.buf, revs, 0,
+		if (handle_revision_arg(sb.buf, revs, flags,
 					REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", sb.buf);
 	}
@@ -2906,7 +2906,7 @@ int setup_revisions(int argc, const char **argv, stru=
ct rev_info *revs, struct s
 				}
 				if (revs->read_from_stdin++)
 					die("--stdin given twice?");
-				read_revisions_from_stdin(revs, &prune_data, &flags);
+				read_revisions_from_stdin(revs, &prune_data);
 				continue;
 			}
=20
diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
index a57f1ae2ba..4821b90e74 100755
--- a/t/t6017-rev-list-stdin.sh
+++ b/t/t6017-rev-list-stdin.sh
@@ -68,6 +68,7 @@ check --glob=3Drefs/heads
 check --glob=3Drefs/heads --
 check --glob=3Drefs/heads -- file-1
 check --end-of-options -dashed-branch
+check --all --not refs/heads/main
=20
 test_expect_success 'not only --stdin' '
 	cat >expect <<-EOF &&
@@ -127,4 +128,24 @@ test_expect_success 'unknown option without --end-of-o=
ptions' '
 	test_cmp expect error
 '
=20
+test_expect_success '--not on command line does not influence revisions re=
ad via --stdin' '
+	cat >input <<-EOF &&
+	refs/heads/main
+	EOF
+	git rev-list refs/heads/main >expect &&
+
+	git rev-list refs/heads/main --not --stdin <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--not via stdin does not influence revisions from com=
mand line' '
+	cat >input <<-EOF &&
+	--not
+	EOF
+	git rev-list refs/heads/main >expect &&
+
+	git rev-list refs/heads/main --stdin refs/heads/main <input >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.42.0


--HVRnrMb86oT6HpGj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmURhMcACgkQVbJhu7ck
PpQ3jA/+M6LwEmiUqbL43vb8vJstUws1y9HgxocI2Q0BMoXHLMCd7ppEUMG5Dvsp
RlV+BXGKysbg9jxT4dMloiHN/UnlvuOzT9UKpyaCpsmE6AZlVCZjr33IYWCKPzXn
4RtLLK/CFIwA+4WlFufyrUThMNRQXVls1ZvMDahY7ix8XGTz9YVX4mnWbAm1jRDU
d2aUd+JNsPOLRzzxQ0o949ozqK4Xjq9wnZgsGhsjF69WAN4FI62+hLLcYjmzTFsA
rQXHP+gw2FnouTGOOk4HLy0j8l6r5tHHAj7/qDE0Va6n5pTfjuWlDRXI27SeFCDl
Q9iS6/WEwilCiFIj7CdRhzFgVMn3buy0+GZzE1kpTrnZnQVHNIvmWIL+jOS4DCJ+
oHeFjccwzEH5ufeL4/2Ak7WgjtFDzkOeziH06m+Uh8ygk5fm1El5CGUUs6MgAjS9
UotAQ6fR4mMTz9llyrT3F0l5YtPLgllmeGs94eHoIBwYQ5j2jeurGhPRMhWSd9kN
fil3JkPZt7KtdN8JLY/gd2sMCLynFAEygW3XDIbKNN3rysO+1h5GG5G21wSlOnAl
58N3giz/ntCyVwMGWYSFV/dWRWntxBDaceJA9ZHFlqDglaxChsJybGNwUWaZcN85
/hm1tkg7+++EIy0qlyW9Syqlgmp6F1I9mQHds0vv6e62W/weO3U=
=BHe8
-----END PGP SIGNATURE-----

--HVRnrMb86oT6HpGj--
