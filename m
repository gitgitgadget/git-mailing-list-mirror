Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23813C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D524022473
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbhAKLGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:06:10 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:43395 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728413AbhAKLGJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 06:06:09 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D20FD2940;
        Mon, 11 Jan 2021 06:05:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 11 Jan 2021 06:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=wornKp3UvFzSX701YFGR0AD7TLm
        rGRaSkdU6iVvPTnY=; b=nCuXK7Bpotmb/FYU7i8guVFBX7/U2Ef79GMLwZpGsDr
        FGlbOO++LYQo1fVqTglSGC2S+hRs+Jm4JyPyxZQgVY7N4jMhKxHSPG0i0b3ckA2N
        2CTxurndeqAXGfGW/XFRI51LJH5Rf/xBbkiRjKqlYwfGBXjgG/5YB05qdY+LiZKy
        HfzZNVwcDGX2zWgOmsrCv0qSL05rC2xmLtHMEzuKcxQ1c/ePPj1NjGEE2yiQGLcj
        YDtG/W97FYGsrzeu8GOOSDCd+PM3En8yuyECSF3bYdxdQa7RVBJH3CRoeKD0q0ge
        h+3RcOfdAY0bTnvzSOFKwReySbdBaMkjsHFC1vRiSPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wornKp
        3UvFzSX701YFGR0AD7TLmrGRaSkdU6iVvPTnY=; b=XKQJOLMBg1i0sekGwpyWuK
        qCW909BaH16TwYzy6blhJ3JYGsV8A+F1jD6OiR/v74vNmS3YV0LPnNmE9Xbv0nyC
        /ulFIZGXugC3RnRPYT0lLw+Qu542tgWbv24WdJCuYiR/USSywv3B2e2v4znYaTAH
        lO+15GESnxnNd4DrZsdXHUnlccmG8EQm2TbY8fjxq1+CwMIXhkHTDkGg4bsjfYD1
        XXMjCDb/dCsdUIs/5cK7GtM7w5y9P1ZQah+c3XTrdnmrwltMPCHgfVgmZiTyrcBU
        4zhURm5HLm0VQLFsYZESEmzncE6Xc85l7/hWoAowvJh7a7Vu31OppekhsSKwQemA
        ==
X-ME-Sender: <xms:8zD8X0g4mGGJgqABBA236xIfQbEHXE_b_pzLcIG8Ly6JKnTC_9SLug>
    <xme:8zD8X9DCtupsz4VxTVWFj5k40eR_doP3W03cI9JZCE8_yp1cAE6NWAo1-PHIQvK3O
    2302KxuYWzyNk_Tmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehuddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrgeehrddujedtnecuvehluhhsthgvrhfuihiivgepudenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:8zD8X8Eq-BGR4jFEfrIQKYJoNux6GWvU6wYDGFw9s0a9KQGTjLNsYQ>
    <xmx:8zD8X1QG46k7fg7qhlGNmN_wwZWNS4BUJR6iE8FmFwlpjHg5-uDDKQ>
    <xmx:8zD8XxzuDDdQOn0ZjUkO07uNcuVZd0lYPUGtqyRrMtC73fhZqCxHVQ>
    <xmx:8zD8X_Z-vah5sMf6zscrA5jWyr-KK7wqh5GNx7JXenownzntcTEnhA>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id C4E5C1080057;
        Mon, 11 Jan 2021 06:05:22 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6b04185e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 11:05:21 +0000 (UTC)
Date:   Mon, 11 Jan 2021 12:05:20 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 2/5] fetch: use strbuf to format FETCH_HEAD updates
Message-ID: <a19762690eb7f9957ac31d73e110f0103aeb2307.1610362744.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610362744.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GyUsAWtoUagyNZM2"
Content-Disposition: inline
In-Reply-To: <cover.1610362744.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GyUsAWtoUagyNZM2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This commit refactors `append_fetch_head()` to use a `struct strbuf` for
formatting the update which we're about to append to the FETCH_HEAD
file. While the refactoring doesn't have much of a benefit right now, it
servers as a preparatory step to implement atomic fetches where we need
to buffer all updates to FETCH_HEAD and only flush them out if all
reference updates succeeded.

No change in behaviour is expected from this commit.
---
 builtin/fetch.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 50f0306a92..1252f37493 100644
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


--GyUsAWtoUagyNZM2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8MO8ACgkQVbJhu7ck
PpQpCw//VnOcdoC/hCrOO2LxqxwefwCf2wLg5mNQ2+OTQLBh4HhaaPxg+QjncJBs
BHdye99eeJVrcVI7H6Pb2myWo8KLBknM0JrtXO0pm9rgGCjh6fgFArZhL8QY+Nol
aIzZc9IkAqYi73GGPXS3ha96HbFGQFGvmt+6lyX6QNlvslk4zspsgrxo1r+aFZam
AumXOcCAq3bbBNNcRWS5G2DNfbWTMLlYFUm6VMWB+u1HVCVtFtIYO6Aj0UbO8U+m
DinUE2QrZL4obyDOlWpuhTDltge1i/C6PpELBf4D9XPQXS/2oZCfLbYj++3t/6gg
EHSGsj6vSLt+dTlN9aorOObLJvjOnMlAAyycJNXyybTlJXTkUI2awr8oO/eI6z0o
rc3zzNWkNUJOui6ofxGAoYcQyN2zprca/gruoycaJvvBxy83R91g/crCjH93Iu9V
dgkPgixS0g1Mu2imY+swAK8fiBslE2YPuINlWxXNxPE2RTBtMIo3H5uhZIvvHybc
TGB0wy/RZ2XW2cXvb1Rz9qPdIPd9tn90zt6IiNYB4Zhxn4xlQAckDY3gZ+zYct78
x++Vexcjj6F2P1LGmfpFn7cx3Fv7gfCAjhA/gaXIOwffwnoJrCCcICV5htgKfjH4
Ilv0XG70ugc9CfyF7XcDqsu2JALW0JfQUt07XWKvRKw08qJ2dCw=
=kA1O
-----END PGP SIGNATURE-----

--GyUsAWtoUagyNZM2--
