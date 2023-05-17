Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF25C77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 11:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjEQLti (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 07:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjEQLtV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 07:49:21 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE7159DA
        for <git@vger.kernel.org>; Wed, 17 May 2023 04:49:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1C1F032008C3
        for <git@vger.kernel.org>; Wed, 17 May 2023 07:49:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 17 May 2023 07:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684324159; x=1684410559; bh=64
        wpYUiW4jS/CcCCMLrzOd2XSkgM0m9UnFKQwP/r1pc=; b=k67yWIfJZZZ94diRj1
        rBqqMEQ0wywueUNV9Dp+qM51PUY3Q1tR+tu6B8B96Fzl52SHN14l6hDB0DY1fTLz
        HMq3UizZ2VJQkL9Qk1OazcJJS06v/mcsLMb3vk0PjX2J3HG91K0tynOm+/7w8bAL
        4PPENBTTpqRPbXHNUhnZUa1/PSECv4GPYRFraBZTrVVO/czdG9K0wpQG3Aaps3EH
        uTlrZYunRzJOsaDOw0mM7/E9xbfytu4cbPcEG8Esejxh+WkDgZ27lBemPEjs8x8z
        TD1e1+xNvG63KC4j26EspbdchBEBZXUhZnnt0DTgwh3ilqPACoX9m6OVG/kWtCuv
        j9cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684324159; x=1684410559; bh=64wpYUiW4jS/C
        cCCMLrzOd2XSkgM0m9UnFKQwP/r1pc=; b=BGD3leJgzljO7zUmFyTs7ZuSLkEeJ
        Tg/yxLBu2QAIM5ww/EyUDGF0fFs47VLj7ILPfb3g4YfjFftqS77cI7CXV8hP6+un
        By0q51pui86qAysz9QdWk76yMasm5iNrddyGodJKPFCb0mO68k1EXLW7Np0ZJM8s
        0dJqNJFvtBywp70Qgd/5Ra9h4InLd0XIj7oZUzZlrTBcgtKspezXYR0CpVTHOEhb
        k58zz4dwTc9lQ5QfCexVB3PHWXJtKIXs8mA3vYgmbjpJ/KUahZsdpttvYzr5FfqS
        223m95t6FMDswv9TaxI70YJrpPF8E6vR0UyDcJrry77Yqo31HhKD0CStg==
X-ME-Sender: <xms:P79kZM8XhNjWDVI_WJTtvnu484YvVFBIknw84rCFLkKawcI7pzCcIA>
    <xme:P79kZEs5bJo-2wxSgN1MVoXE2mqrTwDIvwtKBcBozuZbd-9LD0GkBYfCAnjpc_KlI
    q6aVUgJx-cFoXPFpg>
X-ME-Received: <xmr:P79kZCAfEs4-B-N1tE9wXvQOH0cXtL72LPlMXdHcTIE_6D-lMjK102I1ODtKF6Jxq27OM1QfVOto7QKOXGGaTyAbCUa5c3R_L-HVOFb9J2G3xcTs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:P79kZMdsEbz_4qa48mzyL6lz_fXyACaojK4vXkrMBZcjuqdJLFDg4A>
    <xmx:P79kZBPf3dBwXjWB_JjUnhtfKYjNI133puwiX0MiKF9S85o167bKrA>
    <xmx:P79kZGmpTeXiDTe8wJk5Em5Rf5-MvgBSZ3hundR5VsD0MtFKtcnPcg>
    <xmx:P79kZIYqJGy9CefF_i3pfA3EtncPkucSIMYsuDeuVhRpAcRRx3pasA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 17 May 2023 07:49:18 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 8c8e0dc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 17 May 2023 11:48:55 +0000 (UTC)
Date:   Wed, 17 May 2023 13:49:17 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 9/9] fetch: use `fetch_config` to store "submodule.fetchJobs"
 value
Message-ID: <0eb84712a07243957d8037d7f1b3ad01260abe2f.1684324059.git.ps@pks.im>
References: <cover.1684324059.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IPSganvAw7FpuzfG"
Content-Disposition: inline
In-Reply-To: <cover.1684324059.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IPSganvAw7FpuzfG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move the parsed "submodule.fetchJobs" config value into the
`fetch_config` structure. This reduces our reliance on global variables
and further unifies the way we parse the configuration in git-fetch(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 29b36da18a..e3871048cf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -86,7 +86,6 @@ static int write_fetch_head =3D 1;
 static int verbosity, deepen_relative, set_upstream, refetch;
 static int progress =3D -1;
 static int tags =3D TAGS_DEFAULT, update_shallow, deepen;
-static int submodule_fetch_jobs_config =3D -1;
 static int atomic_fetch;
 static enum transport_family family;
 static const char *depth;
@@ -108,6 +107,7 @@ struct fetch_config {
 	int show_forced_updates;
 	int recurse_submodules;
 	int parallel;
+	int submodule_fetch_jobs;
 };
=20
 static int git_fetch_config(const char *k, const char *v, void *cb)
@@ -136,7 +136,7 @@ static int git_fetch_config(const char *k, const char *=
v, void *cb)
 	}
=20
 	if (!strcmp(k, "submodule.fetchjobs")) {
-		submodule_fetch_jobs_config =3D parse_submodule_fetchjobs(k, v);
+		fetch_config->submodule_fetch_jobs =3D parse_submodule_fetchjobs(k, v);
 		return 0;
 	} else if (!strcmp(k, "fetch.recursesubmodules")) {
 		fetch_config->recurse_submodules =3D parse_fetch_recurse_submodules_arg(=
k, v);
@@ -2119,6 +2119,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 		.show_forced_updates =3D 1,
 		.recurse_submodules =3D RECURSE_SUBMODULES_DEFAULT,
 		.parallel =3D 1,
+		.submodule_fetch_jobs =3D -1,
 	};
 	const char *submodule_prefix =3D "";
 	const char *bundle_uri;
@@ -2268,8 +2269,8 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 	}
=20
 	if (config.recurse_submodules !=3D RECURSE_SUBMODULES_OFF) {
-		int *sfjc =3D submodule_fetch_jobs_config =3D=3D -1
-			    ? &submodule_fetch_jobs_config : NULL;
+		int *sfjc =3D config.submodule_fetch_jobs =3D=3D -1
+			    ? &config.submodule_fetch_jobs : NULL;
 		int *rs =3D config.recurse_submodules =3D=3D RECURSE_SUBMODULES_DEFAULT
 			  ? &config.recurse_submodules : NULL;
=20
@@ -2432,7 +2433,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 		int max_children =3D max_jobs;
=20
 		if (max_children < 0)
-			max_children =3D submodule_fetch_jobs_config;
+			max_children =3D config.submodule_fetch_jobs;
 		if (max_children < 0)
 			max_children =3D config.parallel;
=20
--=20
2.40.1


--IPSganvAw7FpuzfG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRkvzwACgkQVbJhu7ck
PpRJuRAAhHm06cRxjz8sct3LrDXRGAqLB7kMov6xKh4wWtasYFZQbPCikdClBnmg
5ldyuJOEUm1wTiOJCUtUea+swiLoyT40lsdDTxysMs57/ham+8FeekhMxC6uaBfh
2iAX897WIqfQV26SkfyuR/Uwb9jDjkYSNjF2r65G8pEF1pkMelaC147z7+gxvkWk
CxWXJv7JVf8LYkrokok90ff8v+c0ZAkcvcOoQ6rxGihwfF1FA8OzQ5OaFZszmjU4
gm9cOnnGRnL5LYB7xmMiA7PJOxXCI35eE50shNQdPin+48SaZU5JuPuvdY9hUSIp
l3pgCwmt3v9tHI8U76dok0nYtIVMOn+a3Gd1J2FHiUVhLPXDvVfSpBodDUt1kC06
g4ZGE7vGxQqBarUuQJi2S5KxgWF461U37pj4kP7PyFKrWZ09tmA++1dWXrrSIlm7
3HLwIlselxhuLA550HcMKqEFZ7P6dDhuVbTX6snYnsnXaiIs5sIYTzbKQ0NcXRMN
PA5517hPmyGe+k5g/aQkBW1iTnbkh9hVKcsPIsbLEEWmirNxOTGZGJTDebBc0uVk
uCAOoDKsALSqaeSKNDZNa2ka/Jq3ETpmNDw/cO0KJoLvNo5ZLh0E7eoijPjvmy+C
hqhzCL2gXgLIEQdUwted58op4ObE6uqPtYcuOBh/B8Qwgc9hpww=
=J+O1
-----END PGP SIGNATURE-----

--IPSganvAw7FpuzfG--
