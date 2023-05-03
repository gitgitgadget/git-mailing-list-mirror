Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A32C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 09:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjECJoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 05:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjECJnj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 05:43:39 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1832D69
        for <git@vger.kernel.org>; Wed,  3 May 2023 02:43:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B23E15C00B2;
        Wed,  3 May 2023 05:43:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 03 May 2023 05:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683107016; x=1683193416; bh=6P
        8JtEC/+P2ltFIc8IBxyWcB7zBFrjR5lPhJOE7+ztM=; b=rHcNbOXQTyTQMV7HWM
        P2wz0jaz9YBQbnaNXrizTQwKYa3NUSXEtCtaXm7ugQlNlRXWbQaqWEJXVPwgoBut
        mUO084fj5shTP5JzLrtRCxuC3tvB/fv6yJOfwe/+Wcc+hEn20SvBabHm0t4hAvzj
        opH9jOrltn23GnOzo0Ti6jkUeuRHBO4ZwgeyC0yaHYmTMRo/TXWPWLooxcQs9+xR
        VnW8i3qH/57iKzuR3HkE2hd+r9pKBOOmfdVWIuOQv4jG9JVcg4GJLdZKSh94OZKG
        vxYJCu+Rw8ab7csxanbK8nZXaF6tj+cRK1etJtkSSYBHQANBgaOocgjZ50AkOJAV
        5Pew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683107016; x=1683193416; bh=6P8JtEC/+P2lt
        FIc8IBxyWcB7zBFrjR5lPhJOE7+ztM=; b=hU21knDg9pnMvVqAbvpvwmWKUxlSA
        PEFOdOYZSADj+sg+mUUMPAWqp9BNtr7C/fNn/XbghV+JS3mcywDSowXe75KazuW6
        8sViBgImqqTMmBtvfqd1lyWhYEpskzceuQeprg1IeZ2PhZfO0uSy1812OIf3pO4Y
        QfV4f2J9igtejptvtskQ3PzmqfV+Q7rDrtUIDp9a6WExACktKbc8o3jKtkOWNByd
        7I807S0TB8DW2jk5ktk1TEk+LzoV0NCL4qvBPIfOUOJCF/BaNZtcDrwJoA1a5Zj5
        QsD8lCYxV8BnFPVbSX+OThtdwMUAOtEN7MF8Q7tfp7XcAhn7Q8U771/bA==
X-ME-Sender: <xms:yCxSZJh8YfnM4_XNtudyPtxdeepzlvd2Q11IXse4ugztn970_vLUeA>
    <xme:yCxSZOC4iLj1h42sqPtBnVMriJHApqiUtAz91HL38Jsf3-K5MPA8KQejWvpSdpjXX
    GMXW8sNsFYvQbGkUQ>
X-ME-Received: <xmr:yCxSZJFPMA6fkLIIEQ8fAXBnSJp97EGja8WSYNwjqvfMj2bMqx0kj2MRirw6Lc5vjmVTC2NJLZMcvWNiJTBamo2KdGM2hwJSuo8lSR8SP6lq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yCxSZOSSnc6g0RmfnLNY8vM2rosDkUIgiIDeMuqGnuUy-gkJ6eO_Uw>
    <xmx:yCxSZGwnhOnSlDl8ECFWIymb6D6tdFvwjbpGl8I04ccyGSSABhwASA>
    <xmx:yCxSZE5tJqkIq2FKfbxefh9uCZVZBIcIIMbhMZpo6yWcHLXAnxRioQ>
    <xmx:yCxSZAt6n-9CST5h9DEEY_AWEVKPK01c3Oqqia4dxLaGc2i7CABEOw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 05:43:35 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e7e17ade (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 May 2023 09:42:52 +0000 (UTC)
Date:   Wed, 3 May 2023 11:43:31 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 7/8] fetch: introduce new `--output-format` option
Message-ID: <ZFIsw94SBxRVkWmz@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1682593865.git.ps@pks.im>
 <0335e5eeb4ded336c5ff7c8888c8aab9dfed2505.1682593865.git.ps@pks.im>
 <kl6l5y9f3ahf.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6LX6uBppoyQ3qifu"
Content-Disposition: inline
In-Reply-To: <kl6l5y9f3ahf.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6LX6uBppoyQ3qifu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2023 at 03:31:08PM -0700, Glen Choo wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > @@ -1894,6 +1902,9 @@ static int fetch_multiple(struct string_list *lis=
t, int max_children)
> >  		     "--no-write-commit-graph", NULL);
> >  	add_options_to_argv(&argv);
> > =20
> > +	if (format !=3D DISPLAY_FORMAT_UNKNOWN)
> > +		strvec_pushf(&argv, "--output-format=3D%s", display_formats[format]);
> > +
>=20
> I think these lines belong inside add_options_to_argv(), since that's
> also used to prepare argv for fetch_submodules(), so we'd also get
> support for --recurse-submodules. (I wish I had spotted that in v1,
> sorry. Thankfully they use the same helper function, so we only have to
> do this once.)
>=20
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>   diff --git a/builtin/fetch.c b/builtin/fetch.c
>   index 422e29a914..7aa385aed5 100644
>   --- a/builtin/fetch.c
>   +++ b/builtin/fetch.c
>   @@ -1796,8 +1796,11 @@ static int add_remote_or_group(const char *name,=
 struct string_list *list)
>     return 1;
>   }
>=20
>   -static void add_options_to_argv(struct strvec *argv)
>   +static void add_options_to_argv(struct strvec *argv,
>   +				enum display_format format)
>   {
>   /* Maybe this shouldn't be first, idk */
>   +	if (format !=3D DISPLAY_FORMAT_UNKNOWN)
>   +		strvec_pushf(argv, "--output-format=3D%s", display_formats[format]);
>     if (dry_run)
>       strvec_push(argv, "--dry-run");
>     if (prune !=3D -1)
>   @@ -1908,10 +1911,7 @@ static int fetch_multiple(struct string_list *li=
st, int max_children,
>     strvec_pushl(&argv, "-c", "fetch.bundleURI=3D",
>           "fetch", "--append", "--no-auto-gc",
>           "--no-write-commit-graph", NULL);
>   -	add_options_to_argv(&argv);
>   -
>   -	if (format !=3D DISPLAY_FORMAT_UNKNOWN)
>   -		strvec_pushf(&argv, "--output-format=3D%s", display_formats[format]);
>   +	add_options_to_argv(&argv, format);
>=20
>     if (max_children !=3D 1 && list->nr !=3D 1) {
>       struct parallel_fetch_state state =3D { argv.v, list, 0, 0 };
>   @@ -2403,7 +2403,7 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
>       if (max_children < 0)
>         max_children =3D fetch_parallel_config;
>=20
>   -		add_options_to_argv(&options);
>   +		add_options_to_argv(&options, display_format);
>       result =3D fetch_submodules(the_repository,
>               &options,
>               submodule_prefix,
>=20
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>=20
> I tested the result of that locally with --recurse-submodules, and
> it works.

Unfortunately it doesn't quite work alright: while the porcelain format
does indeed get inherited to the child process correctly, the parallel
process API will cause us to group output per submodule-fetch. This has
the consequence that stdout will be redirected into stderr, and that
then breaks the assumption that all machine-parseable output goes to
stdout.

My initial reflex is to just outright reject porcelain mode when
submodule fetches are enabled. But that would require the caller to
always explicitly pass `--recurse-submodules=3Doff`, which isn't exactly
great usability-wise.

The alternative would be to ungroup the output so that we can continue
to print to the correct output streams. That works alright, and I've got
a working version that does exactly that. But now we have the issue that
the porcelain output is misleading: you cannot tell whether a specific
reference update happens in the parent repository or in the submodule as
that information is not part of the output.

I consider the second option to be much worse than the first option
because it can cause scripts do to the wrong thing. So I'll send v3 with
the first option, even though it's kind of an awful workaround. I'd be
happy to hear any alternative proposals though.

Patrick

--6LX6uBppoyQ3qifu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRSLMIACgkQVbJhu7ck
PpR/Lw//RYTflw0zdiX40tkFDriUypqS1qHg/k8E/M187LIQGdyhH5ZBxxZ3PHXP
SDyHvKfYmE87SvbgLO0dxIRlHhwUNYpr1bD38JN4YWZPvcRWu7JMPs7XC3Q3s1/g
6u86qSDIwMAvJ9C1HCTYlHLl7xzry4XxcX6h2aeJcauYQhx8DIvlKYzT71a2H1ps
90ZFtv4bIX6Ln/cMK4fgE5+AqYvMP1AMuQr0pfDaLo+gnVc28r0/lg9OCRg4NX6G
0Ws2Wcl+FGjjmXYR4g2G5GX09mrFyIbyFocXam6lF69Y1QUTGMoTr6Te9WDcDobs
Y3zaOYHnOsBZ2R5vz5psj6z4nqOGWGvYiwf4ieBf84x4QmK4/7j9T6YvE8SMIfDY
/dzz8PfC5RNbfa+oc7v7GpizxX3CHhS3qqdXhl+cWEZrl64P4tTY1pMjYiLx5lMs
z0m3/LHwezue+Grdi86Go89Bv9JMjOJVBUASG1CEh0Cd0LsvY0jDpC/1LN8nSIcv
MqxaQgQAHEYNhXsStTDPEK6Fr05u+qHAAg2SQoOkl61JJfaWH5MPmPgCUhlcOfUl
mkL95RQoRgmQhkXvCq1g/f0xvxFeevdYumu5P44On4RH1njtYniuIerzkEGHinKA
gyppuUhlfRKxNo5U8dBH58GGTLZukIMS/AGNYpTaU/hX6yO09Bc=
=aYKc
-----END PGP SIGNATURE-----

--6LX6uBppoyQ3qifu--
