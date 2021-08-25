Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E57C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 15:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5D46108F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbhHYPp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 11:45:59 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53139 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240408AbhHYPp6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Aug 2021 11:45:58 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0D1F03200B7C
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 11:45:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 25 Aug 2021 11:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:mime-version:content-type; s=fm1;
         bh=AAg+6W8KKEZRHCPOnA6Nk2a3KzLS3gplUtQOz2GxKG8=; b=RCjmhgDCM7Bj
        MhSC1tHTJCmfHMKwhfMCm2VqnKSZqY0izbYCFCMEq4+vjEwnQ4VT21aXss090Bg/
        FiP5+BdV3nop7dl6tueGqrH5g1A3ItD9ECe279AsgriYNB7IClKmG0sMz8F5iCU4
        vvQzLN2UPB9h+9977xhykkAuyAyZwCOlfv2uH9+2iF3NHJaUwgGm+5YkzyrkZC4R
        ZecmfiDIFzm3REv3VF0C6mL1vLt9UlWzQ5QylFb08TLNYhS/sISGtA+htCGozz1j
        TBxjRmcawM8cq/cnuYQ+CHznP/1SRKW0Ia+ZvoWkd3217k8/cdnD7R6cqJKz4/k5
        nhnqlKUzxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=AAg+6W8KKEZRHCPOnA6Nk2a3KzLS3
        gplUtQOz2GxKG8=; b=YEgNZ1Fau92vgdNy9PUFV5h2Rs17qUiYo6d2Wdd3wyLqC
        S4BeSMl2P9ocAg2UVByzWrB5BA0CbQRDAmUH3oQxS95Ld04/R1PiBT4+dExm+0Ly
        ssP6aR16JuX6AK8TaimksPvBxzhXuvD0nQj598sGok349i57oQriBUxFEHPPTNKG
        1CQs859gCMbrQk8R4p90WRpkoOdg8RRySjee4+06sSr/xM7AjJOQEEo0u43WXGUU
        DtrUJW3XX7O0nIvwcAErlie6UXxaD5jgOwVoQebS78aGSHYpeP1WNrMN7VGv66Sg
        u3na2es8HYNEdcaxyWK/oDdMvA7+bTEFn1SUgRW2w==
X-ME-Sender: <xms:h2UmYSXH4jiiYzqt9_QzDAPm3DHgI1BYZZ2XyV6_jBcPX1DMwufQEQ>
    <xme:h2UmYekkjOvdlyJX8FQe3qkFeJBS_lv8BH3HSjojis05hZqWS7AsIcNdrOQnAiG62
    TezmRppXU186NZ4fw>
X-ME-Received: <xmr:h2UmYWZlAUBaReWFHII3XozH623M3qiO7wXtEXqZux-7zbtU6zsZKhPtaH7bOslffIOXnGsz0NraGf4yfgUsY0hkSV6JdQ_J5rZRpiR54o-I38rTKyyW8xE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtledgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjedtfefftedugfevvdejtdehjefgtddvvdethe
    eiteduuedtteeileetkefhfeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:h2UmYZU8nbTayfIJC5lsy_Gq2aoOwkPZ4zO5xel1ja0GSdvtmQJpXA>
    <xmx:h2UmYcltAHeN36H4XYpVtJdJX6dxpM_PnaH9tfM5CPXMLG5o5W_NYA>
    <xmx:h2UmYefwAxKnUZY9WbHlqE081A8MFVeh9wLej7bNSH7fVYGk4RYvdg>
    <xmx:iGUmYeSrbuR8F0D4bJsKkJ9Ty4JGWed_G1b0nLlKZL96YPU_3b6iLQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 25 Aug 2021 11:45:11 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 1ff9c773 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 25 Aug 2021 15:45:10 +0000 (UTC)
Date:   Wed, 25 Aug 2021 17:45:09 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] fetch: skip formatting updated refs with `--quiet`
Message-ID: <40c385048a023dbd447c5f0b4c95ff32485e1e23.1629906005.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wTUceE8tDtlFR7eX"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wTUceE8tDtlFR7eX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When fetching, Git will by default print a list of all updated refs in a
nicely formatted table. In order to come up with this table, Git needs
to iterate refs twice: first to determine the maximum column width, and
a second time to actually format these changed refs.

While this table will not be printed in case the user passes `--quiet`,
we still go out of our way and do all these steps. In fact, we even do
more work compared to not passing `--quiet`: without the flag, we will
skip all references in the column width computation which have not been
updated, but if it is set we will now compute widths for all refs.

Fix this issue by completely skipping both preparation of the format and
formatting data for display in case the user passes `--quiet`, improving
performance especially with many refs. The following benchmark shows a
nice speedup for a quiet mirror-fetch in a repository with 2.3M refs:

    Benchmark #1: HEAD~: git-fetch
      Time (mean =C2=B1 =CF=83):     26.929 s =C2=B1  0.145 s    [User: 24.=
194 s, System: 4.656 s]
      Range (min =E2=80=A6 max):   26.692 s =E2=80=A6 27.068 s    5 runs

    Benchmark #2: HEAD: git-fetch
      Time (mean =C2=B1 =CF=83):     25.189 s =C2=B1  0.094 s    [User: 22.=
556 s, System: 4.606 s]
      Range (min =E2=80=A6 max):   25.070 s =E2=80=A6 25.314 s    5 runs

    Summary
      'HEAD: git-fetch' ran
        1.07 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e064687dbd..d064b66512 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -757,6 +757,9 @@ static void prepare_format_display(struct ref *ref_map)
 		die(_("configuration fetch.output contains invalid value %s"),
 		    format);
=20
+	if (verbosity < 0)
+		return;
+
 	for (rm =3D ref_map; rm; rm =3D rm->next) {
 		if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
 		    !rm->peer_ref ||
@@ -827,7 +830,12 @@ static void format_display(struct strbuf *display, cha=
r code,
 			   const char *remote, const char *local,
 			   int summary_width)
 {
-	int width =3D (summary_width + strlen(summary) - gettext_width(summary));
+	int width;
+
+	if (verbosity < 0)
+		return;
+
+	width =3D (summary_width + strlen(summary) - gettext_width(summary));
=20
 	strbuf_addf(display, "%c %-*s ", code, width, summary);
 	if (!compact_format)
--=20
2.33.0


--wTUceE8tDtlFR7eX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEmZYQACgkQVbJhu7ck
PpQWqxAAlJzCe+tGQgUn0ah7Md+DYSA3L5+cVN8rUP/c2LCjEeTrhrAhfk9bPVAm
QrcET31341A3YoF8k/W+y3HPTbCRoJQW6yA/vvVo6wo2XhksZnp75hPICmclZqWk
hS13Nnn8K61Hwx42KXP6RoDezu9239jmjlIX0pI0IDEq4Il+oL+0KNamheSsWK0/
ToP9xsYLRm0VrHZ6bPdYCSbgT8zh2ymxjWbevLcuOdvFtb1tiQ0qOp4CGrx1d7xA
uq7oTo99mh30poK2fG4B7aYR4TOC3ic4cbc0UUCmYcx4vlnRQZ5DZqURh2sm4zSr
1rXxhbEFgztxf4FkIydCjkLL3YUJ9ah+hi24JgsDttNm2gml8M4KPhSNtmIVbVsC
a0uuRn6m7IMPAav8qhXwc0uJtw5sA5n78T5yeiS0zJfGNvz7BayfxLZCya97fuy6
9yeiqAADmUq/8gWabiEaxew9hp1H1gQTvOGpndCwTAbADCuJUggSmFY1Y6xfZFc6
rW3cGmhPLPEE/EQ/zXsu6EzSQUsXlRbInOTiW44Vqv7qJorFDUUBoEB4PDMRA7YW
lki7KkiIcvPAUAlHEhAFKQGotputgzZzinHZ8UhSPfhLCrATbdt8KEpBgv06xV55
ctKqlIN2rxVdlhNCPiLTXNTYVHJ7hnBeRNAc9eRH9ewvWi6rR/0=
=DrOW
-----END PGP SIGNATURE-----

--wTUceE8tDtlFR7eX--
