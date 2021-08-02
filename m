Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8096EC4320A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65208610D0
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhHBJiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:38:19 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55473 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232871AbhHBJiS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Aug 2021 05:38:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2CCAE32005CA;
        Mon,  2 Aug 2021 05:38:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 02 Aug 2021 05:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=sRvXTRj2BFYEmOAU5FhhwrIp3Hv
        TDhVqzm4KfXrhpxY=; b=JbgD0kxMEI3Vd4f4zLNxYlBNasR9NywU/LfA2XAN7yH
        aX0gjH6tpkTCXQ+uLu+nHu1L10wa7V/6xNMP39STwbvSbc+BZbyk9HU/DICILe7E
        sCwNmxR8HDsOl8p6WUqfdWXfTgTs+dosmAAiUKY4lTfkcy3MK+EjRmzY5KQJUwrK
        /upOmfoQnsQMefkGBxWn21rspr/7Hyx0QrC8EhehMWo1R4AcEzQiJefS8ah8oxBS
        Hw/ckvwpT0FhYh4P3j9RyOZW09kWUyKMPKGHems5nV8wu1RQ8BmXTwTnV/tgh2wn
        il9rT8V9ZELkPfJuhZ+YVaSmtOeWh5ioiBdirsqwIfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=sRvXTR
        j2BFYEmOAU5FhhwrIp3HvTDhVqzm4KfXrhpxY=; b=aWVcE3AuxYyJ2zks3Hkfqr
        TQWnVdoeASI7Eh01PSr+NZPZVoN2Tcn7t6klx0LzupKnJpuWRtmAA7MPb8zDsQO7
        6B221z7mIcNJkCXZUnv8+vRIUbSMB+q1n7dcWYwFO4sVp5uD65wD16bEw25L0Jvk
        bVSb6e1YOjaaA2ww/aeKAN220UiNM1J1StoOAuETc02q8SH3gKU92s2OqqU4sbeB
        cX3q0wVVIVI2EdBmouDAMcAarZpc6N5KVEghUbO+TrvW/C/br9F7EyQJxSVqHj8G
        TnRIHmrCru1dzyb55PzUszkunusZf3IDtXBzEOUjGU7HXngjkANdx0M5D5OcUtdQ
        ==
X-ME-Sender: <xms:_7wHYUX2Fu1Yeugml2l0We9W682e7Z08mYzQn0ND-uUD3_B5NzlYpw>
    <xme:_7wHYYn1mrmLrHsIMHLQBUvGxNmzUET3ANNdGMZ-PxhnVs86S-OEMVAUOqkM_ngEu
    EGK_KMhly9_-A9skg>
X-ME-Received: <xmr:_7wHYYb5P1-zGQOUXtwlvaO8FqmTCw-hh56_Qwt_-sZmPCq2dKQxvI9wXqBLt053zagPS04iMiacPxb-9pqCkx9qrmFhsHuMZo3HofU4VlRZHYelqboWCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddriedvgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveduueeitefgieevvefgtdeuueevveeggeevgfegvdeuleeivdelleelkeeuvddunecu
    ffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_7wHYTUO14iGH1-S_q8vauGtyx1u4_o_Te9Uq-wf0alP1z54Jxv-Gg>
    <xmx:_7wHYeludMX_HGCL8nyvCIoWJLddcqM8ZbkqX0Q-A_hN8wYKzPf1hA>
    <xmx:_7wHYYcr63s0acPzxsPfRXvlf5Mn9eq__8Xp9IJHLLtie30XjpdjkQ>
    <xmx:_7wHYcZ2coPXclV4Ouj0h5FttPI2xFOWVUr4VTBvxVkoKXpRjlyRig>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Aug 2021 05:38:06 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c2ecb61a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 2 Aug 2021 09:38:03 +0000 (UTC)
Date:   Mon, 2 Aug 2021 11:38:01 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 1/4] connected: do not sort input revisions
Message-ID: <1fd83f726a04dfb5be27c74cb116618cb76be923.1627896460.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MKnWqu4+dpP9xZz2"
Content-Disposition: inline
In-Reply-To: <cover.1627896460.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MKnWqu4+dpP9xZz2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to compute whether objects reachable from a set of tips are all
connected, we do a revision walk with these tips as positive references
and `--not --all`. `--not --all` will cause the revision walk to load
all preexisting references as uninteresting, which can be very expensive
in repositories with many references.

Benchmarking the git-rev-list(1) command highlights that by far the most
expensive single phase is initial sorting of the input revisions: after
all references have been loaded, we first sort commits by author date.
In a real-world repository with about 2.2 million references, it makes
up about 40% of the total runtime of git-rev-list(1).

Ultimately, the connectivity check shouldn't really bother about the
order of input revisions at all. We only care whether we can actually
walk all objects until we hit the cut-off point. So sorting the input is
a complete waste of time.

Introduce a new "--unsorted-input" flag to git-rev-list(1) which will
cause it to not sort the commits and adjust the connectivity check to
always pass the flag. This results in the following speedups, executed
in a clone of gitlab-org/gitlab [1]:

    Benchmark #1: git rev-list  --objects --quiet --not --all --not $(cat n=
ewrev)
      Time (mean =C2=B1 =CF=83):      7.639 s =C2=B1  0.065 s    [User: 7.3=
04 s, System: 0.335 s]
      Range (min =E2=80=A6 max):    7.543 s =E2=80=A6  7.742 s    10 runs

    Benchmark #2: git rev-list --unsorted-input --objects --quiet --not --a=
ll --not $newrev
      Time (mean =C2=B1 =CF=83):      4.995 s =C2=B1  0.044 s    [User: 4.6=
57 s, System: 0.337 s]
      Range (min =E2=80=A6 max):    4.909 s =E2=80=A6  5.048 s    10 runs

    Summary
      'git rev-list --unsorted-input --objects --quiet --not --all --not $(=
cat newrev)' ran
        1.53 =C2=B1 0.02 times faster than 'git rev-list  --objects --quiet=
 --not --all --not $newrev'

[1]: https://gitlab.com/gitlab-org/gitlab.git. Note that not all refs
     are visible to clients.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 connected.c | 1 +
 revision.c  | 4 +++-
 revision.h  | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/connected.c b/connected.c
index b18299fdf0..b5f9523a5f 100644
--- a/connected.c
+++ b/connected.c
@@ -106,6 +106,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	if (opt->progress)
 		strvec_pushf(&rev_list.args, "--progress=3D%s",
 			     _("Checking connectivity"));
+	strvec_push(&rev_list.args, "--unsorted-input");
=20
 	rev_list.git_cmd =3D 1;
 	rev_list.env =3D opt->env;
diff --git a/revision.c b/revision.c
index cddd0542a6..7eb09009ba 100644
--- a/revision.c
+++ b/revision.c
@@ -2256,6 +2256,8 @@ static int handle_revision_opt(struct rev_info *revs,=
 int argc, const char **arg
 	} else if (!strcmp(arg, "--author-date-order")) {
 		revs->sort_order =3D REV_SORT_BY_AUTHOR_DATE;
 		revs->topo_order =3D 1;
+	} else if (!strcmp(arg, "--unsorted-input")) {
+		revs->unsorted_input =3D 1;
 	} else if (!strcmp(arg, "--early-output")) {
 		revs->early_output =3D 100;
 		revs->topo_order =3D 1;
@@ -3584,7 +3586,7 @@ int prepare_revision_walk(struct rev_info *revs)
=20
 	if (!revs->reflog_info)
 		prepare_to_use_bloom_filter(revs);
-	if (revs->no_walk !=3D REVISION_WALK_NO_WALK_UNSORTED)
+	if (revs->no_walk !=3D REVISION_WALK_NO_WALK_UNSORTED && !revs->unsorted_=
input)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
 		return 0;
diff --git a/revision.h b/revision.h
index fbb068da9f..ef6998509a 100644
--- a/revision.h
+++ b/revision.h
@@ -134,6 +134,7 @@ struct rev_info {
 			simplify_history:1,
 			show_pulls:1,
 			topo_order:1,
+			unsorted_input:1,
 			simplify_merges:1,
 			simplify_by_decoration:1,
 			single_worktree:1,
--=20
2.32.0


--MKnWqu4+dpP9xZz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEHvPkACgkQVbJhu7ck
PpRzBw//blcegALRgqFsLLJpH2p9neeu4vapq26WuhF/IWPC9cOpdz94WV6MUmjx
jFUmt7/rwc8Brsk0MFrlEJsHMqNa97kg6uagni1fMqhN5LqVmCJiXm5KRl2SCQNL
079fpJwtuD0OdeYkFcNXGAgO6zVOH2eJR0Z20XCPVJ3AHe+Ww/afd/bWlWSwJOQQ
T34vKO1c17PuAFycimHnUAhirJrTKTLZhvd8uJ7WMdnGWnSOcCiQWLoZaVDsnwOi
aZbcvxZNEGO5k7Rh0rKwqZ7I3haCEXbichWk9ju2s657MQl2B+liS9aRMeLh8CFV
AtcfyV+ik4ge+IRAIH5U/ECuhBt/Pq7tOIHPfmmPUdsNz55BI25Yyh1IbKtzpRV2
B7nlnwSpqxKyOEHW4CK9GstLL2ehKWCPncGu/JzyuOty1MqpMrcaxoDaMgilpdNr
Hyw5yv4RwBF3OdrA4x20Xs//ZzuLV4kVpioADE5qThjIDr055ikc1oUjL3E5ky1J
Z76eKrkADz4DbUFWnG55ZwiI4e+JJa9qYoNP/GhQAcR7nqOTJe/ZlO0shdnDzPgR
IGz7CjWrrWZaE+zOnSfKUzeLibP6exdHavAOPZe2qT7x3J399WsHhvdQL1X4imKz
/0NXBBCLOwgehFRW7LHtskW8Ef97cN6HO0jq3UFRfR+mggRp/GA=
=7vrt
-----END PGP SIGNATURE-----

--MKnWqu4+dpP9xZz2--
