Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB25C7619A
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 08:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjC0IIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 04:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjC0IId (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 04:08:33 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1901738
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 01:08:31 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CDE175C00EA;
        Mon, 27 Mar 2023 04:08:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 27 Mar 2023 04:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1679904510; x=1679990910; bh=2KFapTubhuOIrIsMnnLgTb/kB
        dmXzWW4o8fSkA3dx6s=; b=KCjDgT7rIhPtFCyVPpMoYE5H0Bh6058HS41Q654yW
        lqCAUBtYMgJWcGkHr+pKPfak1fYwu2Tb4YWbGL7FS3fNvbQVpP+Fot/duQvz/wM3
        /WnJWPsZDmnljqsT6MsWhcwUc0MLXrTNPi5Uk9zQxc+Nk3FtEtWiEBDC1yjCz7QK
        SqGctH5a6zz4zgtP8Zi5CgMcl6VdgYejgxm8et88t9dYcszUqnyzyJmTJE8MNlUQ
        szlCKwOoeoJvCUzal1dOgLCfZOeSV5ZL31AvVOq2cQLhaPuxeqrO1bNmi5rYDjoE
        RfJbG4kEDiUpKHaZj0sc9wIKT2S59NbU8smOfzuIZafSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679904510; x=1679990910; bh=2KFapTubhuOIrIsMnnLgTb/kBdmXzWW4o8f
        SkA3dx6s=; b=QWsT4bmudV3++P6SPJbRdz9Z4VPxAWCIPBlhXRtnnxIM33BXAZr
        JRJUsjfVkmRt8pE8KW+3JzLnxm8QOJzRi8SldCeUs3MxWx0/boavP5vp1IM3Lk5i
        HhN1afW2k+XUm2H9NuFPXSP+lbakqI7ajerWem1UuD4DLefyd6Za2Nl71CEPVPsd
        NiP3TGU+E3dsIUREyzx5w+hYDk+gOO8nAfrEp305qW5lwkazduIm3kwtU7II+uXf
        z2+jpCWtv1CtZmE4S9NtrNAKRZeJxggJgEGRWPnMCTEMZbo9vcTeOTw4GoL3XaPW
        J4VZYtIpia5Lkmyueqh1BcNweHlR95MyJCQ==
X-ME-Sender: <xms:_k4hZMmGslIU_v8RN6uqe-5tEIkClOkgT_wUjdY1ypBHC-N7AWb-jg>
    <xme:_k4hZL0VXnILz2VV8EP74y8G1wzB6EjvQFD02XFtwerVGhH9MP0qNWQgdPEUxc0ps
    K7aZqAkLqEe5NM08g>
X-ME-Received: <xmr:_k4hZKpnMyFzygKg96G9qisStCiFIPnsLBwCXgOFlyq-Pjo9KdH_MhvWe9VDwPs03VCVDmK85BnPI8a0yXfvibb5mpVjL3fbwhjS4Dq3GfKnKV4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehvdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfggtggusehgtderredttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeugf
    eutdeuieehteelveegudejkeejheeljeejhffhgffhvefgkeeukeejtdeijeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hm
X-ME-Proxy: <xmx:_k4hZIlLoZNjxa2ZRZoBOQ0on_7ZwXcHWEUhVKUQkgJgfWqSm1CAUA>
    <xmx:_k4hZK0DGnKi4C6geTqVuak6dY2jbd2kFwX4Hr3cexGHi2QcObhktA>
    <xmx:_k4hZPuaw97TDaMVFOZzelm2pUZqyMdJiXPqCHwMgyZoxtJdftLwKw>
    <xmx:_k4hZP_e2FJGuV50tplSZ0HGKa7SfIBpDVV0tnQZQRqxEjateoXl5w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 04:08:29 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id dad5e421 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 27 Mar 2023 08:08:22 +0000 (UTC)
Date:   Mon, 27 Mar 2023 10:08:25 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] commit-graph: fix truncated generation numbers
Message-ID: <f8a0a869e8b0882f05cac49d78f49ba3553d3c44.1679904401.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ad0dTK1NmGVaPl+N"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ad0dTK1NmGVaPl+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 80c928d947 (commit-graph: simplify compute_generation_numbers(),
2023-03-20), the code to compute generation numbers was simplified to
use the same infrastructure as is used to compute topological levels.
This refactoring introduced a bug where the generation numbers are
truncated when they exceed UINT32_MAX because we explicitly cast the
computed generation number to `uint32_t`. This is not required though:
both the computed value and the field of `struct commit_graph_data` are
of the same type `timestamp_t` already, so casting to `uint32_t` will
cause truncation.

This cast can cause us to miscompute generation data overflows:

    1. Given a commit with no parents and committer date
       `UINT32_MAX + 1`.

    2. We compute its generation number as `UINT32_MAX + 1`, but
       truncate it to `1`.

    3. We calculate the generation offset via `$generation - $date`,
       which is thus `1 - (UINT32_MAX + 1)`. The computation underflows
       and we thus end up with an offset that is bigger than the maximum
       allowed offset.

As a result, we'd be writing generation data overflow information into
the commit-graph that is bogus and ultimately not even required.

Fix this bug by removing the needless cast.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

This commit applies on top of cbfe360b14 (commit-reach: add
tips_reachable_from_bases(), 2023-03-20), which has recently been merged
to next.

 commit-graph.c                     | 2 +-
 t/t5328-commit-graph-64bit-time.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 172e679db1..b96509354e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1565,7 +1565,7 @@ static timestamp_t get_generation_from_graph_data(str=
uct commit *c, void *data)
 static void set_generation_v2(struct commit *c, timestamp_t t, void *data)
 {
 	struct commit_graph_data *g =3D commit_graph_data_at(c);
-	g->generation =3D (uint32_t)t;
+	g->generation =3D t;
 }
=20
 static void compute_generation_numbers(struct write_commit_graph_context *=
ctx)
diff --git a/t/t5328-commit-graph-64bit-time.sh b/t/t5328-commit-graph-64bi=
t-time.sh
index 093f0c067a..57e4d9c699 100755
--- a/t/t5328-commit-graph-64bit-time.sh
+++ b/t/t5328-commit-graph-64bit-time.sh
@@ -63,4 +63,13 @@ test_expect_success 'set up and verify repo with generat=
ion data overflow chunk'
=20
 graph_git_behavior 'overflow 2' repo left right
=20
+test_expect_success 'single commit with generation data exceeding UINT32_M=
AX' '
+	git init repo-uint32-max &&
+	cd repo-uint32-max &&
+	test_commit --date "@4294967297 +0000" 1 &&
+	git commit-graph write --reachable &&
+	graph_read_expect 1 "generation_data" &&
+	git commit-graph verify
+'
+
 test_done
--=20
2.40.0


--ad0dTK1NmGVaPl+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQhTvgACgkQVbJhu7ck
PpSzIA//T5hAtKmnTQzpW9/lPGedMBArueq6XzcsykCUDsDuze/E34btwiCdGw6F
29U8kfRU2g+YSARtbg4iz45UiV9pw+sFxb2yZaum/ASpB8fvHeuSdnSlfvNzqkru
97KdPKn345EziYS0SPV395P0TEmLw8R0V5PHdm5NTjfbPASCh9bEmMVH9SgS8R/Z
aWuwpbkXTJJHI3uMhb1VrItItkkaldMQFqtmg3rHZ6JP0zob4zBATuolMrPK13aV
v8C8+o3/ho9PQsma59se6/AT+nCFYPaQiotbsg8WldWKEG7jHLPJimB6TYtDsgCc
7GXXLc0TJC7QWnd8UgnWNL+5e5RTqeG0ZZb54XvfS+7AHgbzX9qFSO1tVuMEkSHW
fVhPCTMY4sa7lCL52ekpzwV3p0AMyqNFQcnCK6eAHRiQcFmlvoxOYi2qR/6wCZsN
18WrlN+AlX525nJxMr7caYaGiWago+umnDdIgbja3bvgTfWJSmAQw8whQ7//vUL8
GxM9Ktl5W2L/Nrc9Ic7wOGCRl8rAPdOeZBr5BoWgy4n2z4msivmaPoN9PVyW86B3
IEdnK4IMLVwvfDBE2FNd3BiXJNZM71qtFCCiGc3UCvYKFsQG1KqbYUmfdRG76A6k
nca/dCwsYFhfOBr2qAJ3HncnslmOwGuqzcWqIG0JqDdgBIHi3Uw=
=ToTz
-----END PGP SIGNATURE-----

--ad0dTK1NmGVaPl+N--
