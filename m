Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2232DC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72B1610CA
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbhDMHMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:12:08 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58627 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhDMHMH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Apr 2021 03:12:07 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8ED965C0095;
        Tue, 13 Apr 2021 03:11:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 13 Apr 2021 03:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=/Z98uUx5ppjKUn4QLfLogT06aUx
        E5/QGfsFMEI8yxdY=; b=b9IDFDlGTu86m+N7F12viuYalMmNx0sUocK+MF7jhuN
        UYqt4eHZgA7Npi83t2Kuh3nxxQlQVCd+BEo0WrIRw9KGRKQFpPG7W+4D9f7V0hYK
        h0jGu+8nf/EDRuS/dirbof2DXsXnQRldP0TqdCOnKWPDFFgRWE6ZX3pOV5e0w0ZC
        h4VVNgav+PDBD+1dsF23lA2EWLAvrYWafu6Veaprs85DNvH+6DA/lI+J7Wk+3YOI
        V8ybVdpwJkBA4mtwPNXclr3TjPjF17pTLsWSZAERuS5iKq0Z9GMk7NzxWxtI4vrv
        Y3vymo6ba26ym1OpZ5f2KEtCpKAQydE12KD+u+/nrNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/Z98uU
        x5ppjKUn4QLfLogT06aUxE5/QGfsFMEI8yxdY=; b=KTEmVbDirkUO/fuebzajrU
        KmlKCl3VD22rnn9o49Yz7ejGwHSvujq6Fn6k3UX9SqEHASnESaQHmGxbqlHpuVh0
        rZzWnGN6GOPrFeCof5NiY/DIgpAtyahS/VhB3MPe5u1b/lOMjNYtrJNgmbs+1J1K
        Q+xIHLIJSR4GlrD5Qqe/43Ew+8aZxI8/fAzyk64PqzFwWHUNLBMXyKa/9+WfKTvE
        rT2XDbIeO2GxXcY0BciFElgv0bcj0EazvgJxUoKqmlGpu7Jl7+2ut9xTQeecOds+
        55WQ1s+KDH3P0kKNyUXWOSIIO1uk0uwDHlsogv88b7XcTEIB9g1nWE70Mux5f3sA
        ==
X-ME-Sender: <xms:MkR1YJlBNPSWHz_DSd84vfcU3KoWuoxeUIWE5-3ZIREg-Yr2VUWPtQ>
    <xme:MkR1YEzlsHwlIFh0Aq6omfgO-OEDKljxVlTabVc-9HR-z8TTvOdOv7953K0qje0Jh
    kRHeaq2lR-7GQ0Q9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekkedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeekledrudegrdefhedrvddufeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MkR1YMjeiPB-EeI0G_K26gspNWdBIHsw8ADMLMENc49-bvcKN2RkSQ>
    <xmx:MkR1YBV4efTDl5XrcocffCv1FqB5KbIbXWR-I3Zt76KaHwa4k-jowQ>
    <xmx:MkR1YG0I9jF3l3eWNwqBqQLPWjjjk38Iq-jWuLK0lle5fXtOwYA2Qg>
    <xmx:M0R1YAzDMIggK8jlHggyuZFOpZddaspKE7C33AGVGoWJcmQkvY4V0Q>
Received: from vm-mail.pks.im (dynamic-089-014-035-213.89.14.pool.telefonica.de [89.14.35.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id E148C108005F;
        Tue, 13 Apr 2021 03:11:45 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 48f315ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 13 Apr 2021 07:11:38 +0000 (UTC)
Date:   Tue, 13 Apr 2021 09:11:37 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 0/3] config: allow overriding global/system config
Message-ID: <cover.1618297711.git.ps@pks.im>
References: <cover.1618238567.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XOg2D5wsKTZ7OEDz"
Content-Disposition: inline
In-Reply-To: <cover.1618238567.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XOg2D5wsKTZ7OEDz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series to provide a way of
overriding the global system configuration.

Compared to v3, I only dropped the special-casing of `/dev/null`. As
Junio rightly pointed out, the special-casing was incomplete and would
have required more work to do the right thing for all cases. It can
still be re-added at a later point if the usecase actually comes up.

Patrick

Patrick Steinhardt (3):
  config: rename `git_etc_config()`
  config: unify code paths to get global config paths
  config: allow overriding of global and system configuration

 Documentation/git-config.txt |  5 +++
 Documentation/git.txt        | 10 +++++
 builtin/config.c             |  6 +--
 config.c                     | 41 +++++++++++++++------
 config.h                     |  4 +-
 t/t1300-config.sh            | 71 ++++++++++++++++++++++++++++++++++++
 6 files changed, 121 insertions(+), 16 deletions(-)

Range-diff against v3:
1:  34bdbc27d6 =3D 1:  34bdbc27d6 config: rename `git_etc_config()`
2:  30f18679bd =3D 2:  30f18679bd config: unify code paths to get global co=
nfig paths
3:  af663640ae ! 3:  d27efc0aa8 config: allow overriding of global and syst=
em configuration
    @@ Commit message
             - If unset, git continues to use the usual locations.
    =20
             - If set to a specific path, we skip reading the normal
    -          configuration files and instead take the path.
    -
    -        - If set to `/dev/null`, we do not load either global- or
    -          system-level configuration at all.
    +          configuration files and instead take the path. By setting th=
e path
    +          to `/dev/null`, no configuration will be loaded for the resp=
ective
    +          level.
    =20
         This implements the usecase where we want to execute code in a san=
itized
         environment without any potential misconfigurations via `/dev/null=
`, but
    @@ Documentation/git.txt: for further details.
      	Whether to skip reading settings from the system-wide
      	`$(prefix)/etc/gitconfig` file.  This environment variable can
    =20
    - ## builtin/config.c ##
    -@@ builtin/config.c: int cmd_config(int argc, const char **argv, const=
 char *prefix)
    - 		char *user_config, *xdg_config;
    -=20
    - 		git_global_config(&user_config, &xdg_config);
    --		if (!user_config)
    -+		if (!user_config) {
    -+			if (getenv("GIT_CONFIG_GLOBAL"))
    -+				die(_("GIT_CONFIG_GLOBAL=3D/dev/null set"));
    -+
    - 			/*
    - 			 * It is unknown if HOME/.gitconfig exists, so
    - 			 * we do not know if we should write to XDG
    -@@ builtin/config.c: int cmd_config(int argc, const char **argv, const=
 char *prefix)
    - 			 * is set and points at a sane location.
    - 			 */
    - 			die(_("$HOME not set"));
    -+		}
    -=20
    - 		given_config_source.scope =3D CONFIG_SCOPE_GLOBAL;
    -=20
    -
      ## config.c ##
     @@ config.c: static int git_config_from_blob_ref(config_fn_t fn,
     =20
      char *git_system_config(void)
      {
     +	char *system_config =3D xstrdup_or_null(getenv("GIT_CONFIG_SYSTEM"));
    -+	if (system_config) {
    -+		if (!strcmp(system_config, "/dev/null"))
    -+			FREE_AND_NULL(system_config);
    ++	if (system_config)
     +		return system_config;
    -+	}
      	return system_path(ETC_GITCONFIG);
      }
     =20
    @@ config.c: static int git_config_from_blob_ref(config_fn_t fn,
     +	char *user_config =3D xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
     +	char *xdg_config =3D NULL;
     +
    -+	if (user_config) {
    -+		if (!strcmp(user_config, "/dev/null"))
    -+			FREE_AND_NULL(user_config);
    -+		xdg_config =3D NULL;
    -+	} else {
    ++	if (!user_config) {
     +		user_config =3D expand_user_path("~/.gitconfig", 0);
     +		xdg_config =3D xdg_config_home("config");
     +	}
--=20
2.31.1


--XOg2D5wsKTZ7OEDz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB1RCgACgkQVbJhu7ck
PpQBMg//VOLjXkguz13dpa/2hk5Gn0CiQ4q4T7oArvyBf0GwHXr0enLMjCXoWEdf
LAtlCxmkIORI6Izbtd/hkGUTtZKWKo1VCOzGIa3hrSR3W3pjo1VUEUb7JhviGooB
EfGvx+GpEpeU0F865JD9OXsxMPX7Kt49UdWPUYnnxqyD++QtXeWElPLWjWWVHIJe
+4hbFJ+9amGS9/2eKElHKlfmVXsc7JFbhZRueHbHtca+5chAB0ktkCHpw2XO3Q7f
r7/HXfp2AOLedqVjzDwEgGiwsPUTGuM46o0B6KdBY8UWlgE845JIQV8UheWtcWP0
/sIzRnMt6ELgSGwe3J4Mr0V5BwbDDOv054yYMUA0pD8V8d3/hUHgkguHFVnhKPl0
24gpI5ORPs0kTPgdNmg3vKabjjsVtClLtNeSLlUGSny2bo64E9mu1OZ1gW9WMRuZ
8efkjUWHsHLggaXaDMHndPRaLGnJJjuL6M0t0aB6BpYaMWV00VY3W4DzzTfCcf+N
IU0MD4EOyeIDMrIco/W9u0/18M3H80Ux3I2B17BNgt9yV1GCDnSmW9rInL4JUHAP
bW645w9K3cXegLMQ10rTqPGJ4AZFYHeBC3OIla9a7klfZEBSgE1NY+3btXTZ/MQD
f06DXaG1qEDDaIeYh8qpaF1vabyNhbZ+4huEMvwojmn1yU4QkZc=
=rTJ3
-----END PGP SIGNATURE-----

--XOg2D5wsKTZ7OEDz--
