Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2617C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 15:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiKIP7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 10:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiKIP7I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 10:59:08 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988A3101DA
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 07:59:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so47901653ejc.4
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 07:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5CDWFD5nWLZHMjoSf+ivItzmIK1A85qwC2HmPmaMp+U=;
        b=O0VYPZMbkOwtOZ2rA7k47rSILNWM3TXYRT7nhKT4tr+qZM3y1ETEltBraM3NLQ5pEU
         dCEfmHYhQ2I0dQgkVeeoyC4YkQOQtAOK+vwOX2i3xUXy/wy0yxx1NUhNtkuYpd+G//1T
         aRM/FRMxpK08nJHwjFERXuZwiAm7Qsq4HiRc+8lR4T1e8OVuqpux//eO0rfJaYSep7Hk
         /JhthHdxxeRg18/DhnIiEmTHgHp2/nW6CqkrL2QyTuXTYV40YnGSQ6CBPYurfG6XVXOt
         hjcWpLMmp6ldH50GBxJhOZlfYwXJaXqHKcLjNBq69/oYhXYQ+bXDzrL0Uk7S9ahw2560
         wcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CDWFD5nWLZHMjoSf+ivItzmIK1A85qwC2HmPmaMp+U=;
        b=RVpDkh254ric99jljfDOEREy/6TkdqJ18RmQAOIpe1yTnGRpKwYdiPZtsCAopa1h46
         RHTLq97/b5JL8CgNEZzmuHGmxEhjrdeg++gLAxSvu9IdI4i6PhD7SD0WvBP8nhmElE4w
         upAdnFiji7s2k+yOF/XhxyM9+D1KoC145jHPeenWmhClTddigPr9Fnb0clqFt8e/txge
         88uxuvhqeCxQgZ7d1mUGYDXf/SowSgk6OnBT3uUA3c26uGpSZzsYbsBW8BGe1reMkudh
         Bo+YGekgIblnqu9yClnzCzFYxoP1o44XrHawmVirhJ1HJs+4Pe8kxeM9NYIlFlqbSp7q
         OrLQ==
X-Gm-Message-State: ACrzQf3Ouxon6qANo8bLgyIRIyjsmmVc7sqRTWt49aqny036z9Pfu8Mk
        8WFFfhZzmyPQ5aO/0fGt7V4=
X-Google-Smtp-Source: AMsMyM6jb5Z0vwfsCkesdojneJplAIppo4nu/w8VweZvWcR/0DyTiaooxyXbjV7ktruPCsZQ+DXTug==
X-Received: by 2002:a17:906:fc18:b0:78b:5182:7ffa with SMTP id ov24-20020a170906fc1800b0078b51827ffamr1230933ejb.244.1668009546154;
        Wed, 09 Nov 2022 07:59:06 -0800 (PST)
Received: from gmgdl ([109.38.150.4])
        by smtp.gmail.com with ESMTPSA id cz10-20020a0564021caa00b0045726e8a22bsm7065801edb.46.2022.11.09.07.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 07:59:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osnTk-00100A-0c;
        Wed, 09 Nov 2022 16:59:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/3] git_parse_unsigned: reject negative values
Date:   Wed, 09 Nov 2022 16:57:23 +0100
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
 <pull.1389.v2.git.1668003388.gitgitgadget@gmail.com>
 <d1ac79909b9e777cae40a6a301e5cfd988c5f9d7.1668003388.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <d1ac79909b9e777cae40a6a301e5cfd988c5f9d7.1668003388.git.gitgitgadget@gmail.com>
Message-ID: <221109.86pmdwp19z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 09 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> git_parse_unsigned() relies on strtoumax() which unfortunately parses
> negative values as large positive integers. Fix this by rejecting any
> string that contains '-' as we do in strtoul_ui(). I've chosen to treat
> negative numbers as invalid input and set errno to EINVAL rather than
> ERANGE one the basis that they are never acceptable if we're looking for
> a unsigned integer. This is also consistent with the existing behavior
> of rejecting "1=E2=80=932" with EINVAL.
>
> As we do not have unit tests for this function it is tested indirectly
> by checking that negative values of reject for core.bigFileThreshold are
> rejected. As this function is also used by OPT_MAGNITUDE() a test is
> added to check that rejects negative values too.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  config.c                 | 5 +++++
>  t/t0040-parse-options.sh | 5 +++++
>  t/t1050-large.sh         | 6 ++++++
>  3 files changed, 16 insertions(+)
>
> diff --git a/config.c b/config.c
> index cbb5a3bab74..d5069d4f01d 100644
> --- a/config.c
> +++ b/config.c
> @@ -1193,6 +1193,11 @@ static int git_parse_unsigned(const char *value, u=
intmax_t *ret, uintmax_t max)
>  		uintmax_t val;
>  		uintmax_t factor;
>=20=20
> +		/* negative values would be accepted by strtoumax */
> +		if (strchr(value, '-')) {
> +			errno =3D EINVAL;
> +			return 0;
> +		}
>  		errno =3D 0;
>  		val =3D strtoumax(value, &end, 0);
>  		if (errno =3D=3D ERANGE)

There's nothing wrong with this, but since the topic here is "some
issues I noticed" here's another one: We don't actually care if you set
"errno =3D EINVAL" here in particular, just as long as it's not "ERANGE",
anything else will do.

So, not worth a re-roll in itself, but maybe a prep patch (or follow-up)
to do this would be nice? to make sure this errno handling is
"reachable"?

diff --git a/config.c b/config.c
index ff4ea29784b..33d05fde0ea 100644
--- a/config.c
+++ b/config.c
@@ -1260,9 +1260,12 @@ NORETURN
 static void die_bad_number(const char *name, const char *value)
 {
 	const char *error_type =3D (errno =3D=3D ERANGE) ?
-		N_("out of range") : N_("invalid unit");
+		N_("out of range") : errno =3D=3D EINVAL ? N_("invalid unit") : NULL;
 	const char *bad_numeric =3D N_("bad numeric config value '%s' for '%s': %=
s");
=20
+	if (!error_type)
+		BUG("unhandled errno %d: %s", errno, strerror(errno));
+
 	if (!value)
 		value =3D "";
=20
