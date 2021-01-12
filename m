Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4B8C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7121D22BE9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbhALM2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:28:42 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:52633 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729535AbhALM2l (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:28:41 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3E8D61B13;
        Tue, 12 Jan 2021 07:27:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=/FDmOpW5PUNq5zq6l04HuRhXe/s
        AiOB6DsDkYYGRvFY=; b=vQjbk0TbQ0MYPuI7Pxabonv2QY9W/5w7sUAAp8/AiJe
        TLJOCBWdydc8h3Ozmg40FDBn8Jjv5/0MZMphm0vTZiFzj2AoQFr4ChPA8B7+7JGj
        m7InWw8+GOqCAEDz7WCh3Bs6/hZ6X4xyYyxAzvYpW3uwJS0sUOSRZTQMijWk6KWS
        HR+j5h7BAmW8nHIttV50DWGpWfQU1WYzQyitc4w0LYt47Mnte7r5cF7vMJh5Iega
        xB+96TKUu+fJac8xt4KObCer1AaD50g1X/iPdYRQYwgAmODEg/P/1vKgwtxl0L57
        pRc6Nd4Of4ZH0ujpUQ/idXtL5vu5i8qyqYg06vI0pnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/FDmOp
        W5PUNq5zq6l04HuRhXe/sAiOB6DsDkYYGRvFY=; b=m3PdanSzh5Cd9lOSVunR/f
        zr2nIcKWLD+1mL5PoNvXasYSV+tdGrskPRrDY3d0wy+Y2kwmajZJlmBPXYfmKyKg
        ME5IuXizc9T+pTT2RMfS3KvAzzalO3aVhzDA1XwrqmnrwDcexU3Dr2JPCFCC0D/f
        scEUELj9aBeCBLFR19qzcxOopgnpAtVSami9rz78RokHeMKsb68vpAIEd9K9ktT7
        cJyW4NwVeYVcSfbr9nw2Wm9H2ScZU/U9biqO8umgSpoZQGeDk7V9jOHlev5yl48Y
        3puvt845rZsFln/QsmTIJXdMrxtDjx7efAyWYJ4HFqCGH9YieN0Ze/aVRRA0jPHQ
        ==
X-ME-Sender: <xms:vZX9X593cf0ScXwkaF6wd7aTAjA13eA0yqY3WUoWUpbGjX5C54rs3A>
    <xme:vZX9X9vkUkuialO4Ba1APDiOwUmNI30_D9BHs03jsuKs4W7mygYpSt8MWkmHwzvkR
    rO9kuwO9QaqnRWsQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgepuddtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:vZX9X3CLLGePy5W64-I-t3fQkQhRjOKMIohoC6O9Lm6Uz3a0DKlnGg>
    <xmx:vZX9X9dqYeN1pigTiWmahWhhy3AV7WtHyg5ZgKJTv3ycO-yUJHxi5g>
    <xmx:vZX9X-Nr74JbklImxmJ_L4Kn7pCtQ84oPxUiY4IuIz3K9SszZdd6iw>
    <xmx:vZX9X4Wm1dZApzJ200Fk5xsMrFxO6kJFpcmAlH1XM8tBQ4T-CBryXw>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4976D240065;
        Tue, 12 Jan 2021 07:27:41 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a361bca7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:27:40 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:27:39 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 2/5] fetch: use strbuf to format FETCH_HEAD updates
Message-ID: <fb8542270a66873c9738a94ac178a06f1c2121d7.1610454262.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610454262.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+y4SS7cYYtcWFXXj"
Content-Disposition: inline
In-Reply-To: <cover.1610454262.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+y4SS7cYYtcWFXXj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This commit refactors `append_fetch_head()` to use a `struct strbuf` for
formatting the update which we're about to append to the FETCH_HEAD
file. While the refactoring doesn't have much of a benefit right now, it
serves as a preparatory step to implement atomic fetches where we need
to buffer all updates to FETCH_HEAD and only flush them out if all
reference updates succeeded.

No change in behaviour is expected from this commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2dd5fcb652..e317e828cd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -899,6 +899,7 @@ static int iterate_ref_map(void *cb_data, struct object=
_id *oid)
=20
 struct fetch_head {
 	FILE *fp;
+	struct strbuf buf;
 };
=20
 static int open_fetch_head(struct fetch_head *fetch_head)
@@ -909,6 +910,7 @@ static int open_fetch_head(struct fetch_head *fetch_hea=
d)
 		fetch_head->fp =3D fopen(filename, "a");
 		if (!fetch_head->fp)
 			return error_errno(_("cannot open %s"), filename);
+		strbuf_init(&fetch_head->buf, 0);
 	} else {
 		fetch_head->fp =3D NULL;
 	}
@@ -941,14 +943,17 @@ static void append_fetch_head(struct fetch_head *fetc=
h_head,
 		return;
 	}
=20
-	fprintf(fetch_head->fp, "%s\t%s\t%s",
-		oid_to_hex_r(old_oid_hex, old_oid), merge_status_marker, note);
+	strbuf_addf(&fetch_head->buf, "%s\t%s\t%s",
+		    oid_to_hex_r(old_oid_hex, old_oid), merge_status_marker, note);
 	for (i =3D 0; i < url_len; ++i)
 		if ('\n' =3D=3D url[i])
-			fputs("\\n", fetch_head->fp);
+			strbuf_addstr(&fetch_head->buf, "\\n");
 		else
-			fputc(url[i], fetch_head->fp);
-	fputc('\n', fetch_head->fp);
+			strbuf_addch(&fetch_head->buf, url[i]);
+	strbuf_addch(&fetch_head->buf, '\n');
+
+	strbuf_write(&fetch_head->buf, fetch_head->fp);
+	strbuf_reset(&fetch_head->buf);
 }
=20
 static void commit_fetch_head(struct fetch_head *fetch_head)
@@ -962,6 +967,7 @@ static void close_fetch_head(struct fetch_head *fetch_h=
ead)
 		return;
=20
 	fclose(fetch_head->fp);
+	strbuf_release(&fetch_head->buf);
 }
=20
 static const char warn_show_forced_updates[] =3D
--=20
2.30.0


--+y4SS7cYYtcWFXXj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lboACgkQVbJhu7ck
PpS+Pg//RrBUtvV7+CtRaGw6adfzqEh+DKl/skekbcJ8/1sZNR0eZx7DMhfe2PzD
djmPkABUoyyz4nJDzb6BiACTBcGUnCGA4X387RIx3+USOM7uziABwF9D7tSz4ejL
/O5XKC4Xm9SdAlDVFonx9RNuIEWkcxuppOwJCSltB+0jlOO4gTh2NyQuaNlGQAOs
QyWSdF+TCo9qXqf8ck4JsgoZiiP5vfw2SOwPsy7HZdc1sU0rLk9fdO3qPVPjwdLL
jvc17mQrtFpqwtH/fexjCDMKJ/HAH138+LvSDnWtEZ6u006iAvFYAfIWpHsX/SIG
Xs8KjhXadKIX4o9b78r4AXLN/T9AwaF+v5rHDwtSrIGHSMtQhnOU+wKO7wA7Kwkg
mZhfZFG4K0GzB0bjThDXHMvG4T0m9c13oLT6oWr66YiLyJKPzOSV12Qd3AdZUa3m
63sf5wsIFvNkJQTSngkfVhRmknmZb7UzOk+6GSEA3vckaOGly4Uzx+d+eFtomcN4
8s8nyIEaoXHkt1URQi1pvlrfooey9xavyhK9aNQQK/N3lUEG5wQUYCIg1ZN2kvSY
y5yuoxdecS5nEs9XPOYm9eE+e2Y7oJKdXT4eUD5aWL+8zyW6Ka18zqT9iBr1Nhv5
vwnRaQniEsBWeXhci9PgfrOMhcv01xjymg9nqdbx30bjFSrwGQo=
=+5zO
-----END PGP SIGNATURE-----

--+y4SS7cYYtcWFXXj--
