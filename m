Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2ADC3F2D2
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 04:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B3924699
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 04:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvlUTjyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCBEpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:45:47 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40004 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgCBEpr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Mar 2020 23:45:47 -0500
Received: by mail-qv1-f68.google.com with SMTP id ea1so4271844qvb.7
        for <git@vger.kernel.org>; Sun, 01 Mar 2020 20:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=QpVLiHghtYk6fuV3WRXncqnFijZDbArHpd7VmrfLKIM=;
        b=bvlUTjyHUH5Bpk6dCKSJJZKLbGg2keYH2K0j9z1/q5JztSjDLX42rZ16I5RWmj1W4l
         EgbUgFAxSV3+J35z7z2zyxVm0vK2W/8MmmoOdE2d8mVihKECE3eKgpFhM8sfX6SLyYxD
         S7EBEShQVyXb8ja/ncvH7kIby+AWMQq7BWFkuIDWWF7LilBsPHOe5ha4cIlBnjAneCuf
         eFzlOhWTiUxlZpsAo6i85KQook9ECTSRpTQKqvd9Ghjye4HTNZ6GqYKJMBDb9TIYnwfP
         9AOZ7mKgglyco9gXH9UpB7yv/7W1Ya/rqxeS42J8PPk9HxLkaZ1TRNCuUViIENAsOikN
         V8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=QpVLiHghtYk6fuV3WRXncqnFijZDbArHpd7VmrfLKIM=;
        b=SFcqjHBzNO6iKL7KmJ03wDEbRo8R+8AKbTSRAGMLirA6kmegS5nVsO5TNWZz2Yc0+3
         lPONCKfCM/7BXEM/VQYS/5sKzPS4uftMcB+8z5DR+IixTxED6TWIG97SdNHF10piGeZ1
         OlgralqgmeLUyFeSQaCIaFbtMiyLiT9mHUHe1iol1JM865f1n2K15w0iyymyII+oud5w
         Z28OKtrbWkqn7q5tfawLeVlgSn+wJDg9AqwvjoFejlZ2I4mQwt7UQR5yuCoEAf2Yqwz4
         YsLorwEmFhNseNmWX46KcvY+wd/AsQDiGUyC3mjq8j1lTzGnG+Gg8lvkuw3mXLRKAIAc
         ZjtQ==
X-Gm-Message-State: APjAAAU5nvBJC8sZXcNUDp2L6ng74AluW0x8G94myLJvrZ+tz3s2xpBE
        iARUj1ZQSY+LQOSI5t7xhmd6IY9C
X-Google-Smtp-Source: APXvYqzvvipMTI+fQ0jQtsOV2NHVZvCVwBTMbwYCEAXiMgHyigFSH61ZkkRXZxUKrzWhyHXh3nBnFg==
X-Received: by 2002:a0c:fca2:: with SMTP id h2mr13808890qvq.146.1583124346292;
        Sun, 01 Mar 2020 20:45:46 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id i4sm9594602qkf.111.2020.03.01.20.45.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Mar 2020 20:45:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/4] doc: explain how to deactivate recurse.submodule completely
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200228103558.1684937-4-damien.olivier.robert+git@gmail.com>
Date:   Sun, 1 Mar 2020 23:45:45 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <2442144D-A86E-4DD0-BA0B-ED02956820D0@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com> <20200228103558.1684937-4-damien.olivier.robert+git@gmail.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>,
        git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Again, the commit title has the option name backwards :
s/recurse.submodule/submodule.recurse/

> Le 28 f=C3=A9vr. 2020 =C3=A0 05:35, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>

I think the commit message for this one could be more detailed=20
(even if it would say something very similar to the text added to the =
doc).
I think it could be made clearer, for example, that the `-c =
submodule.recurse=3D0` is
especially useful to deactivate the config when calling commands that do =
*not* have a `--recurse-submodules` flag,
but that internally call other commands that do support that flag.

> ---
> Documentation/config/submodule.txt | 6 ++++++
> 1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/config/submodule.txt =
b/Documentation/config/submodule.txt
> index 5962f41ead..f4edc6cad0 100644
> --- a/Documentation/config/submodule.txt
> +++ b/Documentation/config/submodule.txt
> @@ -62,6 +62,12 @@ submodule.recurse::
> 	applies to all commands that have a `--recurse-submodules` =
option
> 	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, =
`reset`,
> 	`restore` and `switch`) except `clone` and `ls-files`.
> +	When set to true, it can be deactivated by calling
> +	`--no-recurse-submodules`.

I=E2=80=99d say "can be deactivated for a specific call by adding =
--no-recurse-submodules."

> But note that since `submodule.recurse`
> +	also applies to internal calls to git commands (issued by other =
git
> +	commands),

We tend to capitalize "Git" when talking about the system as a whole.

> adding `--no-recurse-submodules` might not be enough to
> +	completely turn off the effect of that config. A solution is to =
use
> +	`git -c submodule.recurse=3D0` instead.
> 	Defaults to false.

Personally I=E2=80=99d let "Defaults to false" just after the list of =
affected commands.

>=20
> submodule.fetchJobs::
> --=20
> Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)
>=20

