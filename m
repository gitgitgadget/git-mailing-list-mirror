Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3395C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB0360F42
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbhHELyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:54:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34963 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230446AbhHELyL (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Aug 2021 07:54:11 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 685FC5C00C4;
        Thu,  5 Aug 2021 07:53:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 05 Aug 2021 07:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=CDfkousypEfkArvtmlmZeMAkEp5
        7g+zBDp0PU/5gTuQ=; b=d/mgjEOhsjSv4pF4nSeEjqjselJCPohm3LFBWxy5rDi
        R9RRaOKu2ui9GUEgS9tCtf8zGz9JVaH/cgHns7Vy0b9EZ0gmJK04/Ftws+0fGhEn
        Oi5vX2usK6F8jyYFCA/4NlrgCAXPMT1Ait48R/FzYr6FA1nWHC4aEdCykdcib5Cg
        7ct2lrqmd0BcN6wq2GFmQKvQYPlie6kGY8vR5W4GlwU2k8AWUhJCB+eth1CLUWxf
        MKhWP2IomyfO6TbpxHXKLo8ZSO5TUdJJPHfO99lYWeeRPkS7rlHsQR3cH7r6JAyv
        ZIuBqpxoy7UNVawY4I96G1Seaz+FxdBaJG1KHFADqUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=CDfkou
        sypEfkArvtmlmZeMAkEp57g+zBDp0PU/5gTuQ=; b=PtTCSeOvLWPfxGKT5f4NBC
        ukfrBAHjQaJg7yEA4RWk809n9gupQybnwRdzba5dmyDwBGzrgJvwteRhbmVsuOl8
        Sinl7MoFNuSJjDXonh3fDESUqY22oPg8/bB/AnlRw/2cyJoAW9fHT7WglQf+e10w
        UhSipizT7qicol5f/mnZ5wHlfNXFGAciA7s62lPW2lz6W7lh6o2baF+q2F+5HgY8
        Mcp6bEcpZUyboaKGw5VdFip0x5avX/bt2yxWL6qeeGNlcBS5vGE1ivui2xLRUir6
        1QsFz+BuexQbh7xARjcR0oDDT+xQrBbW5fuoeD7H7t7ylF/gfwLti2uHjM4gGH1Q
        ==
X-ME-Sender: <xms:VNELYf5KAMWTGfA32DlM4nEnXoo7fRm4BOGrfY-72QNsemPmnHGa7w>
    <xme:VNELYU4-ntJrIu35Wfrw9Ng6MsrSH_c-2MCx4mNDDBYPcgAJOcgYEuUp7tqabLW1p
    t7MufQJ2w28maTE3w>
X-ME-Received: <xmr:VNELYWfzouTTVv6QTemXxDS3QsAGUWFFy0F1H-3CBiNBWrQNnTEVvY2pzcubFujw5bH-ymQDD9M0153qxNqct-AoxlMtBS259mV9IC03zEnT2_-o_2r9i-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeikeeihfffteefhfekheduueeludejte
    egjeejudethefgffehteeugfetvdenucffohhmrghinhepphhusghlihgtqdhinhgsohig
    rdhorhhgpdhgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:VNELYQKZ57nB9WIgircPHjzkMKQYBf0r48A3UIe0J_sjJO1F7w7_Uw>
    <xmx:VNELYTK2L0FohUlfmEZ0VFt5oL1p4JSmC19Aj8Y1A7BSwvrRhKot5g>
    <xmx:VNELYZwbAHJkQgxvOp5o7rDa32yXhtVcRXI5umEUppqPXRqjUvtSug>
    <xmx:VdELYVx2Xv3JhrENmgmSXp6wIRs0t1TprIzqsFr9-QOcxvwV4Dh5dQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 07:53:56 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 72b0057d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Aug 2021 11:53:51 +0000 (UTC)
Date:   Thu, 5 Aug 2021 13:53:50 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: speed up loading of refs via commit graph
Message-ID: <YQvRTpJ0NGakTy9W@ncase>
References: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
 <YQr/vLNjZomIe1ME@coredump.intra.peff.net>
 <YQt/g0iZxAVgw66o@ncase>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AXGLqxUYJRPqLbEi"
Content-Disposition: inline
In-Reply-To: <YQt/g0iZxAVgw66o@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AXGLqxUYJRPqLbEi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 05, 2021 at 08:04:53AM +0200, Patrick Steinhardt wrote:
> On Wed, Aug 04, 2021 at 04:59:40PM -0400, Jeff King wrote:
> > On Wed, Aug 04, 2021 at 03:56:11PM +0200, Patrick Steinhardt wrote:
[snip]
> > I wonder where the remaining 20s is going.=20
>=20
> Rebasing this commit on top of my git-rev-list(1) series [1] for the
> connectivity check gives another 25% speedup, going down from 20s to 14s
> (numbers are a bit different given that I'm on a different machine right
> now). From here on, it's multiple things which take time:
>=20
>     - 20% of the time is spent sorting the refs in
>       `mark_complete_and_common_ref()`. This time around I feel less
>       comfortable to just disable sorting given that it may impact
>       correctness.
>=20
>     - 30% of the time is spent looking up object types via
>       `oid_object_info_extended()`, where 75% of these lookups come from
>       `deref_without_lazy_fetch()`. This can be improved a bit by doing
>       the `lookup_unknown_object()` dance, buying a modest speedup of
>       ~8%. But this again has memory tradeoffs given that we must
>       allocate the object such that all types would fit.
>=20
> Other than that I don't see any obvious things in the flame graphs. In
> case anybody is interested, I've posted flame graphs in our GitLab issue
> at [2], with the state before this patch, with this patch and in
> combination with [1].
>=20
> [1]: http://public-inbox.org/git/cover.1627896460.git.ps@pks.im/
> [2]: https://gitlab.com/gitlab-org/gitlab/-/issues/336657#note_642957933

I've put some more time into this. If rebased on top of v4 of [1], then
we can also use `parse_commit_in_graph_gently()` to further speed this
up from 15.8 seconds to 11.6 seconds with below patch. It's the same
memory/speed tradeoff as I'm doing in [1].

I guess I'd still like to treat both series separately for now given
that [1] is more involved compared to this patch series here. I'll then
do a follow-up when (if?) both series have landed.

Patrick

diff --git a/fetch-pack.c b/fetch-pack.c
index 0bf7ed7e47..cc8b2ffa6c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -119,6 +119,17 @@ static struct commit *deref_without_lazy_fetch(const s=
truct object_id *oid,
 {
 	enum object_type type;
 	struct object_info info =3D { .typep =3D &type };
+	struct object *object =3D lookup_unknown_object(the_repository, oid);
+
+	if (object->type =3D=3D OBJ_COMMIT)
+		return (struct commit *) object;
+
+	if (object->type =3D=3D OBJ_NONE &&
+	    parse_commit_in_graph_gently(the_repository, object) =3D=3D 0) {
+		if (!repo_has_object_file(the_repository, oid))
+			return NULL;
+		return (struct commit *) object;
+	}

 	while (1) {
 		if (oid_object_info_extended(the_repository, oid, &info,

--AXGLqxUYJRPqLbEi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEL0U0ACgkQVbJhu7ck
PpTCTg/+JXpPdGm+1pJGu6PrL3YDYv8bZbIFQX0RU/AEd1yvx/mis0UsDXYx33nY
JOlogwx84gQHfh6YZ+2ImTGB9Hf5RZJKu6cUw79zdOuD5XpiZSFbC9IrnV3GJkO5
Y375cczEsJupQHiv3wiqEmI5fBd141NThOqAcK89G5chsMC9XvHOCLXGoPspG9b4
qjBObn9+htnwN/LeMQI7woky015HH66sZwsEJliG7oCRcFZjV7vamOgqpQgXCWJq
P+5AVmWqSI10AtfpLaE1nDmS/Eyk+9ZF7mh1VlXv6XnRbPk3o5Bg2F97HqiBVUgB
mVdsJkwVqleiu0J8LUprtjJTGh/ohJnHdPUcWVKnoZ8zR4ZgScSRhIDxaM9L537W
WuLMS4rC/M2NApPOBPLa/faNOZtZP4miIm2Uc+Y8acA6vy4m2Z6I7pIYVx8BOneb
xVF5JAQmtbxg4AVFycm8ZqbTKupBtvbzQnR+keeLE9dNodw9S5AeM2ELBjNXY7Hp
5l/J4pLgeOrdAUZ7j49AtjiH0hyFWPYu5Wvy0t38Z+hwqGJ3wNI3KSDWaoaArrCk
YvMLwWFD83724O78if80RZMdxKI5cWV/oqY2U3WumiU0xAr+95c66oitNTev19LN
dWr3vz5fjPV2XT8XiesBSmKS3Gr+HBzbkM2jIKW7WNcs/5+QALA=
=QE4e
-----END PGP SIGNATURE-----

--AXGLqxUYJRPqLbEi--
