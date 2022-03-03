Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBF6C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 11:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiCCLUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiCCLUY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 06:20:24 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3EF171EFA
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 03:19:38 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A2A05C0307;
        Thu,  3 Mar 2022 06:19:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 03 Mar 2022 06:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=NwwMj9+JfhwTEbAxu8w1O7etCWhtYxFqYzn/FS
        9HRjY=; b=rUq/bZS0xQb+pdAw8b+uooCSFsIs0Yk9lvcmKrxzcldZGrpYNFFuiB
        CY/6fVqUvja1mxe/F/5PEYt+LjnB1Z+GzAvMjnhuwjxnoozBOatUC71djiFNJdzO
        D1FWNAua0J+05GGfpMJrp1nCdjS217c7VGTKyCep9/iqfX2AX3fJJL7jY6BbOntb
        wx2jd8sNDFrHoUwXjhrAjUqVswXaKQDgV0RnOCUQC+yqC5r8AsBK+LSjYaLA76iU
        8b+tAzNmxjcAyZcKevAtM0urWJNRdMefc9vzzcWjMCCW0Fdae/oyX98AFkzZhqxM
        PvZIcAkTSn7NDjFQFdfH1mD+L5HpTvxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=NwwMj9+JfhwTEbAxu
        8w1O7etCWhtYxFqYzn/FS9HRjY=; b=hvIYLl0Pqy0ksHnKmPOMUHIcLiQtZ6BpD
        uWK1boDUsl+OASjX3VBA3/fK+MRMMdGJcoDZ5MXSjPC893kWmF7R5v86muYjfXuK
        w0q1atD5mFrhuulJtVpYLFFo8Kj7xfLavfFSWtkWfPLzrm5QoHMUoMb5UX8Fxquj
        5M5qq74raqHc9ZlBuwdOM7RQ+FmZ0owexakbuG/9ZRlH+QZ3kLMqFLjUriJ9ABGF
        G0MPc48JAjRUcSZuOQ88lVGqtg17/hyu2jJ/zF64Zvl+Gzrof/1Xs+lwzrHvHATK
        QMH4aagkAvlS1t+ymSHMLNcCTWW5ZYrjmQYtF4+cX0NfPWjQsyKEg==
X-ME-Sender: <xms:SaQgYkeKzbbeC6EXLBslh8hRIJSRYSA8N7ACfPS7dXJyJqTu7N0dHA>
    <xme:SaQgYmPGKdMi6xt-oEWcIQUXzT97LzePbRoo6Zz0gz3_1_K4j2mNaqeOLvHCbir2e
    yAwAUvW8NF30KkUwQ>
X-ME-Received: <xmr:SaQgYljCqiUnXOrrUDQ_FEmu1E_tvjCOT1YgpGEhD-beMnG2yuKFbMy5yzWVscxYAp7wwOfmsQRpUUH2kHeSSCGNoG_Mha-lHl5GpqFTiaRPibM7F6jo2be9LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtiedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeegffehheelhfeiudegtdfgfedvueduveehgeetvdffleeuffdvhfehkeehieelheen
    ucffohhmrghinhepghhithhlrggsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:SaQgYp87UzLLwROT1az6i0jln64mvJpuofkAJob-asS4v9BDEQ6KGA>
    <xmx:SaQgYgsB2Ul4q8RgkpLSAMMKfWwH5N2ghlCIVoWofcPOQ-9wwfR-bQ>
    <xmx:SaQgYgHwX2npXs5n3NMkqvw8U74HB_zMGLbTqb2BzTvlK7ifLCj6dg>
    <xmx:SqQgYiIi2Y4Kud2xb4jxkq_AygxmOKucazEMwVWvb4G-c9ADPxKZ8w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Mar 2022 06:19:36 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 05473ecf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Mar 2022 11:19:33 +0000 (UTC)
Date:   Thu, 3 Mar 2022 12:19:32 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Message-ID: <YiCkRLFxn8Pok7Kc@ncase>
References: <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
 <Yhz/hsDDGNVjt64R@xps>
 <dbb59fe7-4918-50ef-33a6-79eb430445e8@github.com>
 <Yh3rZX6cJpkHmRZc@ncase>
 <Yh325v3RBDMxjFnD@ncase>
 <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com>
 <Yh4zehdSnHLW1HuK@ncase>
 <1b9912f7-87be-2520-bb53-9e23529ad233@github.com>
 <Yh93vOkt2DkrGPh2@ncase>
 <db5eb248-1b54-9f24-8f8a-28c19a1eee6a@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ah2Agu4cgmlr/9Fg"
Content-Disposition: inline
In-Reply-To: <db5eb248-1b54-9f24-8f8a-28c19a1eee6a@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ah2Agu4cgmlr/9Fg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2022 at 09:57:17AM -0500, Derrick Stolee wrote:
> On 3/2/2022 8:57 AM, Patrick Steinhardt wrote:
> > On Tue, Mar 01, 2022 at 10:25:46AM -0500, Derrick Stolee wrote:
> >> On 3/1/2022 9:53 AM, Patrick Steinhardt wrote:
>=20
> >>> Hum. I have re-verified, and this indeed seems to play out. So I must=
've
> >>> accidentally ran all my testing with the state generated without the
> >>> final patch which fixes the corruption. I do see lots of the following
> >>> warnings, but overall I can verify and write the commit-graph just fi=
ne:
> >>>
> >>>     commit-graph generation for commit c80a42de8803e2d77818d0c82f88e7=
48d7f9425f is 1623362063 < 1623362139
> >>
> >> But I'm not able to generate these warnings from either version. I
> >> tried generating different levels of a split commit-graph, but
> >> could not reproduce it. If you have reproduction steps using current
> >> 'master' (or any released Git version) and the four patches here,
> >> then I would love to get a full understanding of your errors.
> >>
> >> Thanks,
> >> -Stolee
> >=20
> > I haven't yet been able to reproduce it with publicly available data,
> > but with the internal references I'm able to evoke the warnings
> > reliably. It only works when I have two repositories connected via
> > alternates, when generating the commit-graph in the linked-to repo
> > first, and then generating the commit-graph in the linking repo.
> >=20
> > The following recipe allows me to reproduce, but rely on private data:
> >=20
> >     $ git --version
> >     git version 2.35.1
> >=20
> >     # The pool repository is the one we're linked to from the fork.
> >     $ cd "$pool"
> >     $ rm -rf objects/info/commit-graph objects/info/commit-graph
> >     $ git commit-graph write --split
> >=20
> >     $ cd "$fork"
> >     $ rm -rf objects/info/commit-graph objects/info/commit-graph
> >     $ git commit-graph write --split
> >=20
> >     $ git commit-graph verify --no-progress
> >     $ echo $?
> >     0
> >=20
> >     # This is 715d08a9e51251ad8290b181b6ac3b9e1f9719d7 with your full v2
> >     # applied on top.
> >     $ ~/Development/git/bin-wrappers/git --version
> >     git version 2.35.1.358.g7ede1bea24
> >=20
> >     $ ~/Development/git/bin-wrappers/git commit-graph verify --no-progr=
ess
> >     commit-graph generation for commit 06a91bac00ed11128becd48d5ae77eac=
d8f24c97 is 1623273624 < 1623273710
> >     commit-graph generation for commit 0ae91029f27238e8f8e109c6bb3907f8=
64dda14f is 1622151146 < 1622151220
> >     commit-graph generation for commit 0d4582a33d8c8e3eb01adbf564f5e1de=
eb3b56a2 is 1631045222 < 1631045225
> >     commit-graph generation for commit 0daf8976439d7e0bb9710c5ee63b5705=
80e0dc03 is 1620347739 < 1620347789
> >     commit-graph generation for commit 0e0ee8ffb3fa22cee7d28e21cbd6df26=
454932cf is 1623783297 < 1623783380
> >     commit-graph generation for commit 0f08ab3de6ec115ea8a956a1996cb975=
9e640e74 is 1621543278 < 1621543339
> >     commit-graph generation for commit 133ed0319b5a66ae0c2be76e5a887b88=
0452b111 is 1620949864 < 1620949915
> >     commit-graph generation for commit 1341b3e6c63343ae94a8a473fa057126=
ddd4669a is 1637344364 < 1637344384
> >     commit-graph generation for commit 15bdfc501c2c9f23e9353bf6e6a5facd=
9c32a07a is 1623348103 < 1623348133
> >     ...
> >     $ echo $?
> >     1
> >=20
> > When generating commit-graphs with your patches applied the `verify`
> > step works alright.
> >=20
> > I've also by accident stumbled over the original error again:
> >=20
> >     fatal: commit-graph requires overflow generation data but has none
> >=20
> > This time it's definitely not caused by generating commit-graphs with an
> > in-between state of your patch series because the data comes straight
> > from production with no changes to the commit-graphs performed by
> > myself. There we're running Git v2.33.1 with a couple of backported
> > patches (see [1]). While those patches cause us to make more use of the
> > commit-graph, none modify the way we generate them.
> >=20
> > Of note is that the commit-graph contains references to commits which
> > don't exist in the ODB anymore.
> >=20
> > Patrick
> >=20
> > [1]: https://gitlab.com/gitlab-org/gitlab-git/-/commits/pks-v2.33.1.gl3
>=20
> Thank you for your diligence here, Patrick. I really appreciate the
> work you're putting in to verify the situation.
>=20
> Since our repro relies on private information, but is consistent, I
> wonder if we should take the patch below, which starts to ignore the
> older generation number v2 data and only writes freshly-computed
> numbers.
>=20
> Thanks,
> -Stolee

Thanks. With your patch below the `fatal:` error is gone, but I'm still
seeing the same errors with regards to the commit-graph generations.

So to summarize my findings:

    - This bug occurs when writing commit-graphs with v2.35.1, but
      reading them with your patches.

    - This bug occurs when I have two repositories connected via an
      alternates file. I haven't yet been able to reproduce it in a
      single repository that is not connected to a separate ODB.

    - This bug only occurs when I first generate the commit-graph in the
      repository I'm borrowing objects from.

    - This bug only occurs when I write commit-graphs with `--split` in
      both repositories. "Normal" commit-graphs don't have this issue,
      and neither can I see it with `--split=3Dreplace` or mixed-type
      commit-graphs.

Beware, the following explanation is based on my very basic
understanding of the commit-graph code and thus more likely to be wrong
than right:

With the old Git version, we've been mis-parsing the generation because
`read_generation_data` wasn't ever set. As a result it can happen that
the second split commit-graph we're generating computes its own
generation numbers from the wrong starting point because it uses the
mis-parsed generation numbers from the parent commit-graph.

With your patches, we start to correctly account for overflows and would
thus end up with a different value for the generation depending on where
we parse the commit from: if we parse it from the first commit-graph it
would be correct because it's contains the "root" of the generation
numbers. But if we parse a commit from the second commit-graph we may
have a mismatch because the generation numbers in there may have been
derived from generation numbers mis-parsed from the first commit-graph.
And because these would be wrong in case there was an overflow it is
clear that the new corrected generation number may be wrong, as well.

Patrick

> --- 8< ---
>=20
> From c53d8bd52bbcab3862e8a826ee75692edc7e4173 Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <derrickstolee@github.com>
> Date: Wed, 2 Mar 2022 09:45:13 -0500
> Subject: [PATCH v3 5/4] commit-graph: declare bankruptcy on GDAT chunks
>=20
> The Generation Data (GDAT) and Generation Data Overflow (GDOV) chunks
> store corrected commit date offsets, used for generation number v2.
> Recent changes have demonstrated that previous versions of Git were
> incorrectly parsing data from these chunks, but might have also been
> writing them incorrectly.
>=20
> I asserted [1] that the previous fixes were sufficient because the known
> reasons for incorrectly writing generation number v2 data relied on
> parsing the information incorrectly out of a commit-graph file, but the
> previous versions of Git were not reading the generation number v2 data.
>=20
> However, Patrick demonstrated [2] a case where in split commit-graphs
> across an alternate boundary (and possibly some other special
> conditions) it was possible to have a commit-graph that was generated by
> a previous version of Git have incorrect generation number v2 data which
> results in errors like the following:
>=20
>   commit-graph generation for commit <oid> is 1623273624 < 1623273710
>=20
> [1] https://lore.kernel.org/git/f50e74f0-9ffa-f4f2-4663-269801495ed3@gith=
ub.com/
> [2] https://lore.kernel.org/git/Yh93vOkt2DkrGPh2@ncase/
>=20
> Clearly, there is something else going on. The situation is not
> completely understood, but the errors do not reproduce if the
> commit-graphs are all generated by a Git version including these recent
> fixes.
>=20
> If we cannot trust the existing data in the GDAT and GDOV chunks, then
> we can alter the format to change the chunk IDs for these chunks. This
> causes the new version of Git to silently ignore the older chunks (and
> disabling generation number v2 in the process) while writing new
> commit-graph files with correct data in the GDA2 and GDO2 chunks.
>=20
> Update commit-graph-format.txt including a historical note about these
> deprecated chunks.
>=20
> Reported-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/technical/commit-graph-format.txt | 12 ++++++++++--
>  commit-graph.c                                  |  4 ++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentat=
ion/technical/commit-graph-format.txt
> index 87971c27dd7..484b185ba98 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -93,7 +93,7 @@ CHUNK DATA:
>        2 bits of the lowest byte, storing the 33rd and 34th bit of the
>        commit time.
> =20
> -  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
> +  Generation Data (ID: {'G', 'D', 'A', '2' }) (N * 4 bytes) [Optional]
>      * This list of 4-byte values store corrected commit date offsets for=
 the
>        commits, arranged in the same order as commit data chunk.
>      * If the corrected commit date offset cannot be stored within 31 bit=
s,
> @@ -104,7 +104,7 @@ CHUNK DATA:
>        by compatible versions of Git and in case of split commit-graph ch=
ains,
>        the topmost layer also has Generation Data chunk.
> =20
> -  Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
> +  Generation Data Overflow (ID: {'G', 'D', 'O', '2' }) [Optional]
>      * This list of 8-byte values stores the corrected commit date offsets
>        for commits with corrected commit date offsets that cannot be
>        stored within 31 bits.
> @@ -156,3 +156,11 @@ CHUNK DATA:
>  TRAILER:
> =20
>  	H-byte HASH-checksum of all of the above.
> +
> +=3D=3D Historical Notes:
> +
> +The Generation Data (GDA2) and Generation Data Overflow (GDO2) chunks ha=
ve
> +the number '2' in their chunk IDs because a previous version of Git wrote
> +possibly erroneous data in these chunks with the IDs "GDAT" and "GDOV". =
By
> +changing the IDs, newer versions of Git will silently ignore those older
> +chunks and write the new information without trusting the incorrect data.
> diff --git a/commit-graph.c b/commit-graph.c
> index b86a6a634fe..fb2ced0bd6d 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -39,8 +39,8 @@ void git_test_write_commit_graph_or_die(void)
>  #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
>  #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
>  #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
> -#define GRAPH_CHUNKID_GENERATION_DATA 0x47444154 /* "GDAT" */
> -#define GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW 0x47444f56 /* "GDOV" */
> +#define GRAPH_CHUNKID_GENERATION_DATA 0x47444132 /* "GDA2" */
> +#define GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW 0x47444f32 /* "GDO2" */
>  #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
>  #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
>  #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
> --=20
> 2.35.1.138.gfc5de29e9e6
>=20
>=20
>=20
>=20

--Ah2Agu4cgmlr/9Fg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIgpEMACgkQVbJhu7ck
PpQDBw//edm8MDq+mPU4I1akeUQD7xLO56klBOD/3sceKDy/LYPPk4wYie0Se8Li
I082+0R4TSP5XgeLLFGCVIHEa1hclZooiAQfep60p+Oih0P3X/zPoXpX0JOXJeqq
m31dIeuB2IcBtSemRT3hQ+iMuawWLFFxC0FMVix69wUHK2wfSYDBA4Is+m1Pn0iF
QvrjISrUSlimn4oMlFlML2RKtrVbjrGMiPEPx7ShnttclpySH8fui6Q6aRQBQkGC
PTnIcjwb2lCWrcFTzMRcVTv0JR94O4zatKVOhlzW/Ydx3NqPq1ALPC0qfh4jYTXa
bosuyImlzx5Ryd4TT0Y+ANvFh4NoREFji5PzuAOxkcnR6vtLf0CO4nMnCTjsw/+1
eCEFBsgOv8xeQxH58OS7i8j4sgb4jgnzj1OwefrLF6wrjpfP1wSV+x0chQIAzI1Z
HK6MsNW1upN6egGMCvDLE/eR5LaEySyHW9THDNaGMLcnKEGyyj7rXt3E2SXIcbKB
yadB1NAkT8vCehI6uhygdKPleOXBTividvzmnMAOHEeYXDuBgG+h9EAApd4v7gD6
oslUVPmD9AE1BsLCL84YFEIzTY+AkSjridx53fLrEhJ3DHUatXms5XxsAdKD5CnD
eklE4HnPI4Led34xnM/s1xjYIBwtMbB2AMvZ8BZnLzhh/Hirrbs=
=8qbg
-----END PGP SIGNATURE-----

--Ah2Agu4cgmlr/9Fg--
