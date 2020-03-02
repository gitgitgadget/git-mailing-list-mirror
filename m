Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DD6C3F2D2
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 04:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9223F24699
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 04:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R82iayGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCBEqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:46:15 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42139 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgCBEqP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Mar 2020 23:46:15 -0500
Received: by mail-qt1-f195.google.com with SMTP id r6so2024454qtt.9
        for <git@vger.kernel.org>; Sun, 01 Mar 2020 20:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=82xZYbCQfeLiyZ0TS6GQ7ILCiHfPJ60NKVfbZ50KiVk=;
        b=R82iayGfGJ8F+FOFSTOyT5X/to6vqLr5GAsl7WbQcAc7/9wT3nOu+Z1OvpRk76wXKk
         +RkMxHJ1PWVxIRKVPGEPMJD9N/EYEWS7C4vgBsueX/1Tn5LuSvY/s+pGZhfQcSOdEWA2
         eRUIYkoBAv2vtGlQbaPh+IfAYp34hnnk6XOwWbjVCjVZH0milyihr7KnFAGDnEumfN8v
         CI7f+qYfpl9J+NIqhKI19VBgooWhTw0S/pZCSd+gOYfVRSGkGiu+0yikbD2lG6d0lcWT
         lQ6el2rExikO60sIoAf4iyfuahIoH9/IwN4OrUlxaUv6lW+zNHfXAGE4/kbiIX1Ohwlx
         rm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=82xZYbCQfeLiyZ0TS6GQ7ILCiHfPJ60NKVfbZ50KiVk=;
        b=ongU+nLiAcemkycVSpjaVyv+lxkoECQ14/bSGxIHEJOGherk1Qc9ZA4ODPxPTDCQJU
         eVEdjtD1XNZyD6Xf/BOGTjngrMnIuiSBTMM7C0wqZ5G/1mqPh0K5BlgDF+lgBtVLYJTD
         ch2sdIRuxNWu+0vMzswSD9JCqYNUpnWzsSQqIXHsql2ziGJIVKOmTknjPSadef9mHucL
         ju//1RfoTFCdC3Uwmvqp5sIVR8A84B1mIt43PE+GpFIR4vzGBQnmxz/usm0rXMqX8vxO
         0E4hfCcu9hCO4E3wjWn42IjL0OYGDwcngYJoL1UBaftchLuWy0DJ+YkJvRdQEWAZgrsz
         /qHQ==
X-Gm-Message-State: APjAAAWFc4XTRwWkDiGoNnoaiBEbCCsazX7HFdXD0oPdACdszK5MhgPm
        63EcXVcs3ExN+5fZ0We489MVtjaz
X-Google-Smtp-Source: APXvYqwNccPifniQx03kzYb1Lk4k2v/5ZxKnUVEYvdxOaYXAkHnQKtdA/wzL23P09EmfE3Y7KwPpZA==
X-Received: by 2002:ac8:1e8e:: with SMTP id c14mr13483824qtm.330.1583124373021;
        Sun, 01 Mar 2020 20:46:13 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id i4sm9594602qkf.111.2020.03.01.20.46.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Mar 2020 20:46:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 4/4] doc: be more precise on (fetch|pull).recurseSubmodules
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200228103558.1684937-5-damien.olivier.robert+git@gmail.com>
Date:   Sun, 1 Mar 2020 23:46:11 -0500
Cc:     git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <695F48BB-F9EE-43A4-8B12-CF331E5A941A@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com> <20200228103558.1684937-5-damien.olivier.robert+git@gmail.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit message title mentions fetch and pull but the patch also =
talks about push, maybe add that to the title ?

> Le 28 f=C3=A9vr. 2020 =C3=A0 05:35, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> The default value also depends on the value of submodule.recurse
>=20
> Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
> ---
> Documentation/config/fetch.txt | 6 ++++--
> Documentation/config/push.txt  | 3 +++
> 2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/config/fetch.txt =
b/Documentation/config/fetch.txt
> index f11940280f..8f716809f9 100644
> --- a/Documentation/config/fetch.txt
> +++ b/Documentation/config/fetch.txt
> @@ -2,10 +2,12 @@ fetch.recurseSubmodules::
> 	This option can be either set to a boolean value or to =
'on-demand'.
> 	Setting it to a boolean changes the behavior of fetch and pull =
to
> 	unconditionally recurse into submodules when set to true or to =
not
> -	recurse at all when set to false. When set to 'on-demand' (the =
default
> -	value), fetch and pull will only recurse into a populated =
submodule
> +	recurse at all when set to false. When set to 'on-demand',=20
> +	fetch and pull will only recurse into a populated submodule
> 	when its superproject retrieves a commit that updates the =
submodule's
> 	reference.
> +	If not set, it fallbacks to the value of `submodule.recurse`, =
and
> +	if both are not set the default value is 'on-demand=E2=80=99.

For such a change to the doc, I=E2=80=99d expect the commit message to =
point=20
to the relevant part of the code that supports the behaviour that is =
being described,=20
or to the specific test that enforces this behaviour (I briefly looked =
at t5526 but couldn=E2=80=99t spot one).
If such a test is missing it would be good to add it.

>=20
> fetch.fsckObjects::
> 	If it is set to true, git-fetch-pack will check all fetched
> diff --git a/Documentation/config/push.txt =
b/Documentation/config/push.txt
> index 54871f8213..2a5250cf5c 100644
> --- a/Documentation/config/push.txt
> +++ b/Documentation/config/push.txt
> @@ -112,3 +112,6 @@ push.recurseSubmodules::
> 	is 'no' then default behavior of ignoring submodules when =
pushing
> 	is retained. You may override this configuration at time of push =
by
> 	specifying '--recurse-submodules=3Dcheck|on-demand|no'.
> +	If not set, it fallbacks to the value of `submodule.recurse` =
(where
> +	a 'true' value means 'on-demand'), and if both are not set the
> +	default value is 'no=E2=80=99.

Same thing here. Also, I do not think it=E2=80=99s good UI that setting =
=E2=80=98submodule,recurse=E2=80=99 to true will make =E2=80=98push' =
default to =E2=80=98on-demand=E2=80=99=20
but will make =E2=80=98fetch=E2=80=99 unconditionally fetch, but I guess =
that would be for another series...

> --=20
> Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)
>=20

