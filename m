Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54224C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10BEA64E40
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhCAJoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 04:44:39 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54193 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233762AbhCAJoi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Mar 2021 04:44:38 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2C4639FA;
        Mon,  1 Mar 2021 04:43:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 01 Mar 2021 04:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=3kNG+kEMnOwCNZi2e2JWLgjGUwD
        teikDdVoETte1plM=; b=NYIgJFqxGXoM1D1GLcVNJUE/hgi3Coj+TSHuxMa8I0i
        ZatBGo+HSSryAoE8BVYdV1LqxIdbA2s0Ay8qWxH7Tg2xoSHbP7Ac7zxOa0wEKy7j
        1AhJqWr5uvD1Zatz5guEIHzPmm5cOlavVqQ9k1zcSQNNOtmDnuDg7AMjOcJP5ik5
        3iX76HfLNJot3UKwbQUu75l/B3+48O4EL/5KYdltDv29yy2RPFPQdVI2Y1rTEOhK
        GAGwj4v1RiHvlq3jkLuOT48sCWEl07jWIW9H61HfI7amLrh0uG/ox9uKpFTxexF7
        Hn6IjNZmtBFoeXEbV6DkKcwyf79C8ciWOJ6D2uNp/sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3kNG+k
        EMnOwCNZi2e2JWLgjGUwDteikDdVoETte1plM=; b=hIeC0Kc54+qbkOHOG0CdU6
        uv4TxyZl4ac41m/z+Gk2TNNtXRTyARhX4PIaHNWWlCs391CCohF+df+5dd/mlicW
        jowb7JTSZzYQAna4OyghnCxgky1olhJCtirY0xTMKicJEee6OWhm5x92FzvpRG9G
        26nMXMdt52f2UpQQKpOIFNCfOgZabitVRael4idaQ5ATGC16OaTX7xBVViKcfoHl
        akmAUwKEKWA/G5TBFPYjuFFzHvb25HA6FNQlt1xOgCQfaqkqZxsmjG4jBBIhGWCZ
        tfAbmf9kzN9C8M9bs/6Y8occXMJLi6A790N45JGXX2luJHLP6IMYsuO6rraywzxQ
        ==
X-ME-Sender: <xms:V7c8YJZ85GE9Ph0HuUgeBeZzqKVTwd0za7PAi-0MNYWO7II7wwRFOA>
    <xme:V7c8YAbsdSxuotjpaJrZcQ9H_jTOfPQ7UB8WkdKqAefe-jcbetqen8fPA3iZX6V4R
    d7nxERq_btTTH3vqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudeluddrvdejrddufedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:V7c8YL86K6EkYS424gxg7ptoRNid8ohVfvobnLtWIg0bd65hiIz1cQ>
    <xmx:V7c8YHoJJ4WGJq37uiYxFhf5nZvVzGg49qGC7XRqrn96rV7Ffazrrg>
    <xmx:V7c8YEpp3ogdFa4zwjWTDaUtsFoabC0zyjTLNDpUHGJfZg7FxRxihw>
    <xmx:V7c8YBAK5KgLnXUwDLXf1vFZFTck-Dol-Udo2DRoeiid0hyM5PtfFg>
Received: from vm-mail.pks.im (x4dbf1b84.dyn.telefonica.de [77.191.27.132])
        by mail.messagingengine.com (Postfix) with ESMTPA id BDB7524005A;
        Mon,  1 Mar 2021 04:43:50 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 530a6700 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Mar 2021 09:43:49 +0000 (UTC)
Date:   Mon, 1 Mar 2021 10:43:47 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yaron Wittenstein <yaron.wittenstein@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] githooks.txt: Replace mentions of SHA-1 specific
 properties
Message-ID: <294fb32de2681dfeac836d2b64c7e0853721d1a3.1614591751.git.ps@pks.im>
References: <c30d41de55b8991a09e1d550e853f582b5394dee.1614232040.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4IIi/DiiVKhIuarp"
Content-Disposition: inline
In-Reply-To: <c30d41de55b8991a09e1d550e853f582b5394dee.1614232040.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4IIi/DiiVKhIuarp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The githooks(5) documentation states in several places that the hook
will receive a SHA-1 or hashes of 40 characters length. Given that we're
transitioning to a world where both SHA-1 and SHA-256 are supported,
this is inaccurate.

Fix the issue by replacing mentions of SHA-1 with "object name" and not
explicitly mentioning the hash size.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/githooks.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 1f3b57d04d..4dad80052e 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -138,7 +138,7 @@ given); `template` (if a `-t` option was given or the
 configuration option `commit.template` is set); `merge` (if the
 commit is a merge or a `.git/MERGE_MSG` file exists); `squash`
 (if a `.git/SQUASH_MSG` file exists); or `commit`, followed by
-a commit SHA-1 (if a `-c`, `-C` or `--amend` option was given).
+a commit object name (if a `-c`, `-C` or `--amend` option was given).
=20
 If the exit status is non-zero, `git commit` will abort.
=20
@@ -231,19 +231,19 @@ named remote is not being used both values will be th=
e same.
 Information about what is to be pushed is provided on the hook's standard
 input with lines of the form:
=20
-  <local ref> SP <local sha1> SP <remote ref> SP <remote sha1> LF
+  <local ref> SP <local object name> SP <remote ref> SP <remote object nam=
e> LF
=20
 For instance, if the command +git push origin master:foreign+ were run the
 hook would receive a line like the following:
=20
   refs/heads/master 67890 refs/heads/foreign 12345
=20
-although the full, 40-character SHA-1s would be supplied.  If the foreign =
ref
-does not yet exist the `<remote SHA-1>` will be 40 `0`.  If a ref is to be
-deleted, the `<local ref>` will be supplied as `(delete)` and the `<local
-SHA-1>` will be 40 `0`.  If the local commit was specified by something ot=
her
-than a name which could be expanded (such as `HEAD~`, or a SHA-1) it will =
be
-supplied as it was originally given.
+although the full object name would be supplied.  If the foreign ref does =
not
+yet exist the `<remote object name>` will be the all-zeroes object name.  =
If a
+ref is to be deleted, the `<local ref>` will be supplied as `(delete)` and=
 the
+`<local object name>` will be the all-zeroes object name.  If the local co=
mmit
+was specified by something other than a name which could be expanded (such=
 as
+`HEAD~`, or an object name) it will be supplied as it was originally given.
=20
 If this hook exits with a non-zero status, `git push` will abort without
 pushing anything.  Information about why the push is rejected may be sent
@@ -268,7 +268,7 @@ input a line of the format:
 where `<old-value>` is the old object name stored in the ref,
 `<new-value>` is the new object name to be stored in the ref and
 `<ref-name>` is the full name of the ref.
-When creating a new ref, `<old-value>` is 40 `0`.
+When creating a new ref, `<old-value>` is the all-zeroes object name.
=20
 If the hook exits with non-zero status, none of the refs will be
 updated. If the hook exits with zero, updating of individual refs can
@@ -550,7 +550,7 @@ command-dependent arguments may be passed in the future.
 The hook receives a list of the rewritten commits on stdin, in the
 format
=20
-  <old-sha1> SP <new-sha1> [ SP <extra-info> ] LF
+  <old-object-name> SP <new-object-name> [ SP <extra-info> ] LF
=20
 The 'extra-info' is again command-dependent.  If it is empty, the
 preceding SP is also omitted.  Currently, no commands pass any
@@ -566,7 +566,7 @@ rebase::
 	For the 'squash' and 'fixup' operation, all commits that were
 	squashed are listed as being rewritten to the squashed commit.
 	This means that there will be several lines sharing the same
-	'new-sha1'.
+	'new-object-name'.
 +
 The commits are guaranteed to be listed in the order that they were
 processed by rebase.
--=20
2.30.1


--4IIi/DiiVKhIuarp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA8t1IACgkQVbJhu7ck
PpRuiQ/+P1t+ujDHZrS0jrjOSRHTvTmxsY+L3kMtWTRj0QgJDxmQh8Z2PAawgYUa
VDc7pW09/3sufstM7Qk+IEzElc28k1KjVsTliycH3ZEmc2IADsdJoAO4rvBN9mH+
gs7U/X6XKI0KltSb82+5CZEg9UsOqgbu99c+SwkbehrgIQXo2RDwCUPCPP8UacpJ
1d2Up1JcrexzwmO2NY2I7kSYVqyVTeK/eImgp5Yi773fXgTzax7TIcVJm4Ddjdtc
gymb3A6lobas8rDjXjZSTyqxLcUUzqIE71rbtQ8DdwaJ4SrmVdyBtQXTFCmKf0Tc
4gP4KVltVzoq6X/yPJTMhjag97s3pi/DN2gCWjjfj13ZndgIIOOkRSAFOyhtGGBj
ex7VmXFNjtkn2dWJQj4weC1WqJH0rbKk8PFT6X8tpP5nIEFO6Q6oWd0QiXt4pvqi
qJ5v1oRcHJxAr/Nou6z1krTt9biRWetY8Zw1i2xD1PtyX6/u+kzbTAHH5J2mDuJ/
Bppi+3pqeOvAnOep8/d18v7Kmjvxgn4ng8ZQfOkI7F7rcDduSJaOf4/Leh0gw4yq
SBi6thZVlAsYefG26G9UBNXoUlNJ+Uij7lKacay1K6frCVmd/c7c7T9YE6IDasyU
NPvnhI1Usq3S1dR5W1yWYL7TOHtyAfZll4+KA97nft1kWk0VORw=
=KeeL
-----END PGP SIGNATURE-----

--4IIi/DiiVKhIuarp--
