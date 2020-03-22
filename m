Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8E0C1975A
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 22:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC742072E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 22:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1b00kwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCVWhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 18:37:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36300 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCVWhl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 18:37:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id m33so10176831qtb.3
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 15:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pnCWsAaV9NhQs/bvKpSJy9WEsR981hP9G45OLWD1bdQ=;
        b=D1b00kwlVjycwjNTw2/Pc03VurJEVNG9kyIYHaSbxZqgCZaZ4gjD9hxmjxhL/BXEB8
         5GrDT5W5yvzzriXwmWVjboajnwCSuoKFX4iJcvQt1toKFztvuYMoV162vUJTIZTD7YaX
         0ZaNYx3noxme7MpH5huZo6uI3f7WKQ70WVCpaSy4MN2jXvKt4kIQuL+pLzZ+Eiq/IfRq
         pMK3yZ1Xl/vYiDUoC5Z/uGU2wQNYOzBoy0CW6JaOaiGhdyyo1GcZ+yMmndmQNauWQDao
         B+oF7yKryYu7xeUcd+ISQG5gXXFb+IHkGUvF6yrT/2nHyNZkd76J3VRIw4j2YIh4GN44
         vabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pnCWsAaV9NhQs/bvKpSJy9WEsR981hP9G45OLWD1bdQ=;
        b=ZXCvYkMSXIGsLfIwRnOFvLrX9CxZC11bhk/fF1pwOLO0VAk76cmal5V6ydxvF+uyAQ
         HCEL7a2Bmj+MNlCK0uw7hYn0dQ373nH0G5BpeKyOF5l0UsqYmsNxZ7m7gYNlASQ7ikKZ
         KtG+aETr1El5In+LPxckSI+r3qJqXSCEj+XDA2Fz3doDUGlABITjuw4gny7yvY/unQc4
         WNRNWxz2xwgq0iIk+syYpkLwkjaxM+Uy/Yqjt48qQes7F3c4poLoAa0MAbSTP4I4zgwT
         ymcs2QDiwd9XmGBMgCeVwhQSl5t/qkKn1FTkCcua/m/m+l84r4YcdrlBAzRYgtD6adnO
         OkHQ==
X-Gm-Message-State: ANhLgQ1U6Mbm5LsDD3uAtHDlZKGDE5HXdHLSKfStyp+EcO7Gy7/p06sk
        YxWoJ5aR3ETLXUwcc6uzxmU=
X-Google-Smtp-Source: ADFU+vsAeDz7fEyI7SVkOxec/Kv658U+azErkaZv0SiMcaUF9KoK0EuQs8lBvNl/1d3yrk0y1D9zXA==
X-Received: by 2002:ac8:18a7:: with SMTP id s36mr18462197qtj.389.1584916658972;
        Sun, 22 Mar 2020 15:37:38 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id u13sm9683903qku.92.2020.03.22.15.37.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 15:37:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 4/5] doc: be more precise on (fetch|push).recurseSubmodules
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200320213729.571924-5-damien.olivier.robert+git@gmail.com>
Date:   Sun, 22 Mar 2020 18:37:37 -0400
Cc:     git <git@vger.kernel.org>,
        Damien Robert <damien.olivier.robert+git@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <260F83FF-484B-438A-B70A-8348A5267877@gmail.com>
References: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com> <20200320213729.571924-5-damien.olivier.robert+git@gmail.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 20 mars 2020 =C3=A0 17:37, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> diff --git a/Documentation/config/fetch.txt =
b/Documentation/config/fetch.txt
> index f11940280f..8778a99fa6 100644
> --- a/Documentation/config/fetch.txt
> +++ b/Documentation/config/fetch.txt
> @@ -1,11 +1,13 @@
> fetch.recurseSubmodules::
> -	This option can be either set to a boolean value or to =
'on-demand'.
> +	This option can be set either to a boolean value or to =
'on-demand'.
> 	Setting it to a boolean changes the behavior of fetch and pull =
to

I think in the context of patch 5 maybe it would be good to be careful =
here,=20
and state that this only affects the underlying "fetch" in "pull", and =
not the whole pull ?

> -	unconditionally recurse into submodules when set to true or to =
not
> -	recurse at all when set to false. When set to 'on-demand' (the =
default
> -	value), fetch and pull will only recurse into a populated =
submodule
> +	recurse unconditionally into submodules when set to true or to =
not
> +	recurse at all when set to false. When set to 'on-demand',
> +	fetch and pull will only recurse into a populated submodule
> 	when its superproject retrieves a commit that updates the =
submodule's
> 	reference.
> +	If not set, 'on-demand' is used by default, unless
> +	'submodule.recurse' is set.

I know Junio seems to think otherwise, but to me it would be clearer if =
this would be=20
clearly spelled out:=20

Defaults to 'on-demand', or to the value of 'submodule.recurse' if set.=
