Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BB7C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22CF61401
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbhKQOld (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhKQOl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 09:41:26 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2B0C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:38:28 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id t5so12433020edd.0
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qDh0I62ae81COe+GAZecnQHmZjqzEm5MluyHrTthUes=;
        b=McQIjNHMgmVhOaUG+MWrrN72wCHCZy+A/SkvhoWhKhf4bzbk7YOO07asJ6eye56rZ1
         1raL/E1ijKwG84Lr6iAlW08S/ZWcvdLGDtNdqAe9xO5OWqLWrt9q1cUyZ5yMH+Qwt+pf
         qCsJGFJxIm5+hUKq407bdZyO7UaQx4xNZHJBHjryCbYLiATws2HD2nK45OGloPpOs1xo
         XwWYGzpoGjk4Xoxt1Upa9jNlTTWhlMVQDz0LEiThkQZ4IG756rt25n+4/81H8RzB8atS
         EkFklRmOdxlNiag1GCoqEFgzIrS1ePP2izmHMyAyQfhOxsVzI7qumAn/JjF7cA/OiOcI
         lB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qDh0I62ae81COe+GAZecnQHmZjqzEm5MluyHrTthUes=;
        b=ZxdjV/xHt1y5SoWR+jkNJSaxu+hs/2ChnOAshzhpuxXCPTYC8oo3HW+xUOOe6ADATL
         rrrd/PlYaVmjT9U0WdwhYc8KIyPIcoQ+JSq/TdOhoNYTOVkLMmVU8fWnp3WY6MF1v0XN
         Tm/8ko4/rbA8TT2qHqmtamvUy7l7f0ZooQy0kLWFLjltDlA/ZtIHkP3xZBXRtqTzgPxI
         OR+NUS9P9g0hZzfjsZvPXwPRNSXssKRe4gNmmPR+hP0dU6kiGlz1yeWyUPgDi1Hr9Mk0
         P8pL9sQUYs2mNiayGswjAU2zsP1KPh6cIYeKuDRJOKAHXhDRvO3bTJ9/QTzQm08xUThB
         WZsg==
X-Gm-Message-State: AOAM532cAbfkafd1XwilWN8TeVJQLwsxvtAV4OFzs7N/+KS/rRToPeDQ
        zgnN2scRfD+N7BIMFZn2d0M=
X-Google-Smtp-Source: ABdhPJwK3SYfwX9e0OhDK5bIV0UlQ5i0GrACoAtcZjV7Y+MiRdQ1tLBlT82rLXx+T4Al2Oc5OLjZ2g==
X-Received: by 2002:a17:906:9941:: with SMTP id zm1mr22498357ejb.466.1637159906452;
        Wed, 17 Nov 2021 06:38:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n1sm10953183edf.45.2021.11.17.06.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:38:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnM4v-000BR5-3T;
        Wed, 17 Nov 2021 15:38:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] grep: avoid setting UTF mode when not needed
Date:   Wed, 17 Nov 2021 15:31:19 +0100
References: <87bl2kv309.fsf@igel.home>
 <20211116110035.22140-1-carenas@gmail.com>
 <211116.86tugcp8mg.gmgdl@evledraar.gmail.com>
 <R33O2R.WYXS4AQP7W05@effective-light.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <R33O2R.WYXS4AQP7W05@effective-light.com>
Message-ID: <211117.867dd67spq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 16 2021, Hamza Mahfooz wrote:

> Does anyone know if Ren=C3=A9's patch causes older PCRE versions to break?
> If it doesn't I think Ren=C3=A9's patch plus =C3=86var's fix is the way t=
o go.

I haven't tested, but I think a very good thing to do/test (hint hint!)
is to add a CI job where we build/test git in combination with various
PCRE versions.

PCRE2 used to be in SVN, but nowadays it's in a git repository on
github: https://github.com/PhilipHazel/pcre2

It should be a small matter of copying the existing template to set up a
"matrix" where we test various known older pcre versions, they're
available as tags in the git repository.

"--enable-jit" and "--disable-jit" should be part of that matrix too,
and "--enable-utf" and "--disable-utf".

See the "microsoft/vcpkg" and "regular:" parts of
.github/workflows/main.git for relevant examples, i.e. this would
e.g. clone pcre2.git into compat/pcre2-repo, check out a given version
from the matrix. Then:

    cd compat/pcre2-repo &&
    ./autogen.sh &&
    ./configure --prefix=3D"$PWD/inst" &&
    make install

Then at the top-level:

    make USE_LIBPCRE=3DY CFLAGS=3D-O3 LIBPCREDIR=3D"$PWD/compat/pcre2-repo/=
inst"

Then run "make test", for saving some CPU & speeding up the runs it
should be more than sufficient to only run those tests that match
*{grep,log,pickaxe}*
=20=20=20=20
