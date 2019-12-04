Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA808C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 10:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3462068E
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 10:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="H1JjOoz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfLDKgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:36:43 -0500
Received: from mout.web.de ([212.227.17.12]:57377 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbfLDKgn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 05:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1575455793;
        bh=dbt2LG5ycuYCeAykFxHqk3lKP2G46k0V91bpv76gXuc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=H1JjOoz+RVJ1RJI/tAFUeyBGzbh2iwA1vv7XXpaa6eiOG/ubppdgy+RdEy0xEAkIX
         lE8AtyjpvZ/IEQeSyDMLOHb135Y8u77hLZftPNMTt1+d+9cK/1ebX3gUmNEyvOqFqC
         B+A+aHqVyiHR4XKFPCAXbnawmOq+G3NsoJhqId2I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYvxn-1iFkck39MJ-00ViLX; Wed, 04
 Dec 2019 11:36:33 +0100
Subject: Re: [PATCH v3 4/5] format-patch: teach --no-base
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1574878089.git.liu.denton@gmail.com>
 <cover.1575445582.git.liu.denton@gmail.com>
 <6cba51ca247423c76bda498152c162900aba1b59.1575445583.git.liu.denton@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3d355c0c-805a-a55d-eb4e-e4918585e30c@web.de>
Date:   Wed, 4 Dec 2019 11:36:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6cba51ca247423c76bda498152c162900aba1b59.1575445583.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xupxPTIbiLGR+/YD02k//Y5n0KmytyxnmJDa9urBR2fVbB9krEY
 s6TKQtBPDZWyvL/0nncZCKWXXCR7By5O/HE88bxHxxy6vnuIzGtwtRks3NL9AkH1ub2FNox
 xA58KW/iGmwLtPwK9FkEixPdf19Q04v2bpF9UcepjurRLB1Soa4mrO+2RqXypCYFsYP174L
 WlWxYJiVAlyRBYXBtXQKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CEyIxvai7AY=:BrLFzsd2nB8J/pxmrewBIf
 nxrkzya+9WcG+htayX1skvFMHRWzUfmX/zXG/GJjhkbgd+C8EPAQayBTbKTNRuaKxiNURpnHr
 WqjY06RfHuC8srhAUCKnCjThEHJ3hvRknVtdRA5OcdpUKYkGjDK8/IWiNuzaM51vArh/kZe+0
 h79BaP1pgeF5uDPuBHnBZ7bbjhr1G8ZDrJ7o9gN1hqQOFHCAi1tgBwpduMqNmNMIEyYD95xaC
 p91wQmHho47tOMWCyrqDrpZWbccabrFZqcC7i+Wgn6QQWpjZ320twGmE3tkZVCr8/e8YRF08I
 XdkNkbihjnyTjP3Cq/7yNKbUcIgL1GNJt2EnzDe1CxGPA3GPnXOMA8ahodkA3Pu9bAiHxJ1h1
 +efu4nLgHe6USJSMeHsgWYZ+M5wxrJe5PwaYi6t78Sq3pPlTxl9LOuJqeAaUif5R3G60H8Wz8
 b3cEw2s9c3b0PIWTV1xUB0ItHD4dX5Biht8NrH22VzoqNZOdQczUSa+ZY8ipta5J15MJwmTzN
 sROg+aiDoZGqs5kOdwjiKOS5D9rjxZ5NcQbGdHtg2SvZNFy1r+3OFaycqvZ20VcqXLLuMVlxb
 77VeJXCk8FIIOZrBzgrNXWhRl0cuj2vu5BBmjPa5KmA4pZLG2UerpbAi/4HwJGoEa1aOzVaO2
 8bTGcZz3We+bQ27E4yLfrA1dNZ0OEijmcI7rTxM4V3JjbT+0KpVUQBrMqA+Nv+hC27hplS2KT
 hm5QtVLvUkSldIJh7GNvnCgmtcg2mNRLJisvLStc3f5KmAm0TVuSouqH8k0tGh/Ow2WUNyz5C
 hxZlRshppEf6UohH8RauCVRsxfdhrCBRQWGDm1P4HLwdYHOd9xW7nhA8nJqdIf559iO9SDPft
 Bgw9252OpEnO2usP9pwx436lXmZiHQ/ByB3e24+0x66aCWGN5OAZlibojZIntt/8sHWhtP0Fa
 6h9rGjoPEJGHf3NlVt31sgznifSNc7pFi84QHiDSsy0u29PvbspfH0FxwDpkBj+su4tyoHtAf
 FSgAPxN0BN211nAD+AhiPb2591DWAGhcTIm4gTetj/xzdV9/aBXRBDInOyR33H9bObrmrHBt2
 ECkj0q/uPBwLLGt/gJFZYL2ILcP64oJdX7LvniMGyA+mqqJ5DJdEzOTWN3+KjfZtmbp3YIY9P
 CtfhG64wdEDYq2YRBUhAj9q6e4Q1fE478kB7fvQBxxc2563l3JRjtEP0ScprgoGddIsK8k3gI
 IiOm5U8doUkWUN0DgAhQWK9uMNXckMHLlbD6VUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.12.19 um 08:47 schrieb Denton Liu:
> If `format.useAutoBase =3D true`, there was no way to override this from
> the command-line. Teach format-patch the `--no-base` option which
> overrides `format.useAutoBase`.

> diff --git a/builtin/log.c b/builtin/log.c
> index 9c44682f61..645d6db7cc 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1388,6 +1388,23 @@ static int from_callback(const struct option *opt=
, const char *arg, int unset)
>  	return 0;
>  }
>
> +static int base_callback(const struct option *opt, const char *arg, int=
 unset)
> +{
> +	char **base_commit =3D opt->value;
> +
> +	free(*base_commit);
> +
> +	if (unset) {
> +		base_auto =3D 0;
> +		*base_commit =3D NULL;
> +	} else if (arg) {
> +		*base_commit =3D xstrdup(arg);
> +	} else {
> +		BUG("arg is NULL");
> +	}
> +	return 0;
> +}
> +
>  struct base_tree_info {
>  	struct object_id base_commit;
>  	int nr_patch_id, alloc_patch_id;
> @@ -1676,8 +1693,9 @@ int cmd_format_patch(int argc, const char **argv, =
const char *prefix)
>  			    PARSE_OPT_OPTARG, thread_callback },
>  		OPT_STRING(0, "signature", &signature, N_("signature"),
>  			    N_("add a signature")),
> -		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
> -			   N_("add prerequisite tree info to the patch series")),
> +		{ OPTION_CALLBACK, 0, "base", &base_commit, N_("base-commit"),
> +			   N_("add prerequisite tree info to the patch series"),
> +			   0, base_callback },
>  		OPT_FILENAME(0, "signature-file", &signature_file,
>  				N_("add a signature from a file")),
>  		OPT__QUIET(&quiet, N_("don't print the patch filenames")),

Clearing the global variable base_auto feels unclean to me, as does the
introduction of a callback for that purpose.  Why not set base_commit
after reading the config and before parsing command line options to
reflect base_auto?  That would achieve the intended precedence in a
simpler way, something like this:

diff --git a/builtin/log.c b/builtin/log.c
index a26f223ab4..af1b0d0209 100644
=2D-- a/builtin/log.c
+++ b/builtin/log.c
@@ -1714,6 +1714,8 @@ int cmd_format_patch(int argc, const char **argv, co=
nst char *prefix)
 		rev.mime_boundary =3D default_attach;
 		rev.no_inline =3D 1;
 	}
+	if (base_auto)
+		base_commit =3D "auto";

 	/*
 	 * Parse the arguments before setup_revisions(), or something
@@ -1973,7 +1975,7 @@ int cmd_format_patch(int argc, const char **argv, co=
nst char *prefix)
 	}

 	memset(&bases, 0, sizeof(bases));
-	if (base_commit || base_auto) {
+	if (base_commit) {
 		struct commit *base =3D get_base_commit(base_commit, list, nr);
 		reset_revision_walk();
 		clear_object_flags(UNINTERESTING);

