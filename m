Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E30C7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 12:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjCTMfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 08:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjCTMf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 08:35:29 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946211E1F6
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 05:35:27 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0FEA15C012A;
        Mon, 20 Mar 2023 08:35:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 20 Mar 2023 08:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679315727; x=1679402127; bh=j1
        TJKT+Db9uRZq35IyOPM458YgvTXanWdJd5ewctBZM=; b=GN9NBRQb+9TzZIUp4Y
        lLhWsIfHbW68LQM0Jtw/ZqA5a18vVixeXzXfmSwXuXNIjNDoRmK2EJHKOYAPv8n9
        mMVRv45V9NXHJsnWNkmUUCJ05Pul0ntzr7UquWZGoCH5dZIN4lSKIvDEGbuHMGMX
        hy1KeUkjnvJnyE+gAD93dI3Z1cjbI0brjbnNU2o5nT58mi4kbiZ7ulnLQQssAaVa
        WgkxBqrHqHXlZezd9Ara5N9vdsF4veMZehntd+MkEI16aO0lePUhCMKij8RqFIe3
        4WO4iPZ/kgoy825QOaJj/QSd10NATN/LZDq9qNj291tOZtb9sc+KGxHNTK9is0Ez
        1gRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679315727; x=1679402127; bh=j1TJKT+Db9uRZ
        q35IyOPM458YgvTXanWdJd5ewctBZM=; b=FXei37DdF92J3S5WIaWFMgRP3CA7k
        QlFotWXtstaQMKzo4XDn9t+Kj8+7jkUvhcmNpaiq6XG8i8pgjdnbh/BkqTCzs2qj
        ptxvsO5Pjs3mxG9bHeSe4tRrwB54ccsjORHdLfPw5sJNB5dckDk4/vwNEvetpYED
        o1/1PwzxvAq82UVYB7DiWxVoHlVt5KLLzWQFp61rGFANCbyTfEb3efuZlvJW0HFP
        UlR0q7jdMm1VrzXU/tTuXnkpcgyZ6bqS793HODyhwgeKJb0sWiXojpPcXxy0fTuB
        DqZWg+bWkgBOugkiEbKE0lrjqkaQ+Yn2z/+lwGJ16Emq9BmTc+ziVNr7w==
X-ME-Sender: <xms:DlMYZGx8sHk808jfHEWw_cb8XQ6HuaPlEVb-Ur2ZXdIcOPdpqd3UpQ>
    <xme:DlMYZCQedAPWmWWPN-h1dYLP7mwmUCJ_0Zu1P-69hIp12AQ-taGWdpm6yr61k0voo
    bCcIj5UaXI9l8tmbg>
X-ME-Received: <xmr:DlMYZIWFFcT0J4diC6xvuwpNLM8picF3HnP3MOGjuHhgjLh1Ey-oQeqrMcbqrvQOPa0U2pb8tUaDbPlsR2XvdCFQYTlJbFrZcOHjNes5TgUXHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:DlMYZMjDnoSssXjpPTnVrdi72sTrf6XZUT28BxLJdzYvjk3K9dID1Q>
    <xmx:DlMYZIDQIkTshhLEdJDGy6NU2Zb2KP1lZmhc79N_fjol6oMywCtL8Q>
    <xmx:DlMYZNJiDAEsLY12RCIdPUR0IQcqIJseU9EIoiKusO8nML4naHxwsg>
    <xmx:D1MYZB6AT1MA-B2SS8j2HS9EoLrtCYdSTxDs1lGoAvMTVWKzR8zO7A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 08:35:25 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 79e3e5a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 20 Mar 2023 12:34:53 +0000 (UTC)
Date:   Mon, 20 Mar 2023 13:35:24 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 2/6] fetch: move output format into `display_state`
Message-ID: <34eedb882cf06ddc6dba9027d15872527c4500b6.1679315383.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
 <cover.1679315383.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yqhy+V5F+GHznOxH"
Content-Disposition: inline
In-Reply-To: <cover.1679315383.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Yqhy+V5F+GHznOxH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-fetch(1) command supports printing references either in "full"
or "compact" format depending on the `fetch.ouput` config key. The
format that is to be used is tracked in a global variable.

De-globalize the variable by moving it into the `display_state`
structure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 391959ad3d..6d6146b0f0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -49,6 +49,7 @@ enum {
=20
 struct display_state {
 	int refcol_width;
+	int compact_format;
 };
=20
 static int fetch_prune_config =3D -1; /* unspecified */
@@ -745,9 +746,7 @@ static int s_update_ref(const char *action,
 	return ret;
 }
=20
-static int compact_format;
-
-static int refcol_width(const struct ref *ref)
+static int refcol_width(const struct ref *ref, int compact_format)
 {
 	int max, rlen, llen, len;
=20
@@ -789,9 +788,9 @@ static void display_state_init(struct display_state *di=
splay_state, struct ref *
=20
 	git_config_get_string_tmp("fetch.output", &format);
 	if (!strcasecmp(format, "full"))
-		compact_format =3D 0;
+		display_state->compact_format =3D 0;
 	else if (!strcasecmp(format, "compact"))
-		compact_format =3D 1;
+		display_state->compact_format =3D 1;
 	else
 		die(_("invalid value for '%s': '%s'"),
 		    "fetch.output", format);
@@ -805,7 +804,7 @@ static void display_state_init(struct display_state *di=
splay_state, struct ref *
 		    !strcmp(rm->name, "HEAD"))
 			continue;
=20
-		width =3D refcol_width(rm);
+		width =3D refcol_width(rm, display_state->compact_format);
=20
 		/*
 		 * Not precise calculation for compact mode because '*' can
@@ -887,7 +886,7 @@ static void format_display(struct display_state *displa=
y_state,
 	width =3D (summary_width + strlen(summary) - gettext_width(summary));
=20
 	strbuf_addf(display_buffer, "%c %-*s ", code, width, summary);
-	if (!compact_format)
+	if (!display_state->compact_format)
 		print_remote_to_local(display_state, display_buffer, remote, local);
 	else
 		print_compact(display_state, display_buffer, remote, local);
--=20
2.40.0


--Yqhy+V5F+GHznOxH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQYUwsACgkQVbJhu7ck
PpSBARAAp99O97xGbWM/HDZPxZ2D09TnZH51gJxSDw11xj9G6JD/itkfxzA3t/Gm
ks1ixn36eLQyDuauB+RSdNij2pO0/d4b6/E0WhSoD7cpyQ1gmTj+hjEBQXP636EM
qnjy8XncFnGEGLKhibNS3Vf2STrF+qkfUln/ebrlyMGnTxvOxbw34wuPCO4ebWdI
4t8v0JCdNop3C42W4krs+KwmLpQs6ri4IP7lyhAGFDXcCsRXq3jcDxDfCUWJoKJH
wNn/7ImmzJ5Dv+gHgFKoC8diRO7r0yRQB8pcC85wtWVO8AoURuGVOQyF1rD7BQ8Z
usiiteHM/k+XxI8H8juwiQzq7AI9ogjEKia8UmXK4IBMiL1rlzCgieTjFnHwR7Xv
yk+npkxXR4VpDfCQnalmOUETqDpV1F+etLM3rbPrWBI8k/3/0EU9KYbfZGnnNQAx
85FISyJ6LjeRcOHDJKFxiNU4ZxwSfuF+eL5sN9p9gJb40t8ofpaZtUV7LuaZ6+AK
stHgmZZNVsu+qTdswxNKTNOCxCv8yjJgkQvsG/F+KLdcVmjkNEhBbwknbFRw+w+j
MQ9nHagvmyZsyVv1szgd5KTZ2CdtP0ssOl7Qw8M0rihSsRcACAwDCn1qe9LfNDAi
61xflBjVy5/smED+B39op8d9U4oSRtc9SkHsaQRKXLjXcEh3fpM=
=UCrP
-----END PGP SIGNATURE-----

--Yqhy+V5F+GHznOxH--
