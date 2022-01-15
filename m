Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DF1C433F5
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 01:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiAOBHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 20:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiAOBH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 20:07:29 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D44C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 17:07:28 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c71so40100173edf.6
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 17:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Oc7Q74TYLnKbQ2kcn0cP6Dhy827Drfecin1tX794EAQ=;
        b=iV0skBQCwb2Iuavge8G1O9elCs6nLrFNxp4nO6YGsn7WdD2YZRUxen2LVZD0Jif5Zp
         aWrFjXiswm/6hgmePiJIdPKANRrLVd0jHp+EPvFGNIfVtgBhddPCTVs8+aqjVg4gXzFP
         HBU7t7F61FEw5Esgn9NKAQWjg5fCm2uXJxMtoERKGoX2W01ijrrshINJoxKwOeMWvydN
         fCIzNzSoUlzPpYcgikWpAf3TWktHTc06i2Jguj8e4CehpKZ8h/EqWdcpeb3eRpEgQ5Fq
         9sNRyEzSHfgyp90eNlwe+x/7iPWO0nkjcr5ImOJKTR0o9aXj+u4DbK9se8caVd+4CP1m
         jnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Oc7Q74TYLnKbQ2kcn0cP6Dhy827Drfecin1tX794EAQ=;
        b=6QLb7pPJ3u5LwtLjI7rNAyaMeDHNTKXc+rF18DKeNWwJPwXPBXg2I72wlXoR0iaif2
         1IxqslsbXxV4axj9rmeG/XPk6Y92TY2f5t0uhZnLiSO+JLxMYOJXOGLTmXCXajmfpTFx
         palvKWlD9e1Z/Xc18IGe+T8CphoeBSOkkvkx3wwj3hSJ7MXf4fnzqXNBqkdvjw33lGAf
         p0ieZwMlxFtWj8ZP9pCgsK8yYUGoGZvKIRIecohc9ySv0PMPj5EqdDAh35NrxY8ib8Kx
         xMV7m0tt8M/0UUBuzxDGm4P2KnwKhEIhq46UQCnp+T5A8oSfT5CWqrQ4q4BhkIxx1bjP
         djeg==
X-Gm-Message-State: AOAM530UcNW0WaN8YP2nDn0JldyoWV1zz0jel/taWmBzN4cLIA1JL6p/
        XRve4CYzidNfdcJg0bJTVjk=
X-Google-Smtp-Source: ABdhPJw45mio3CONV2+sgCFIWMxZOv0ErXYXpk9c4x+vGVfYD/LAu3ljeWZ4H6RWHt9im17uOTW/Tw==
X-Received: by 2002:aa7:d29a:: with SMTP id w26mr11450253edq.207.1642208846522;
        Fri, 14 Jan 2022 17:07:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w3sm2174110eji.134.2022.01.14.17.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 17:07:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8XXR-001In6-J2;
        Sat, 15 Jan 2022 02:07:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
Date:   Sat, 15 Jan 2022 02:02:15 +0100
References: <cover.1642129840.git.dyroneteng@gmail.com>
 <xmqqfspqeun5.fsf@gitster.g> <220114.867db2rs0n.gmgdl@evledraar.gmail.com>
 <YeHnT1BcisbVvQHB@camp.crustytoothpaste.net>
 <220115.86pmotrgjo.gmgdl@evledraar.gmail.com> <xmqqr1996cw2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr1996cw2.fsf@gitster.g>
Message-ID: <220115.86czktrelu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> But we should really be recommending use of -- or --end-of-options
>> whenever possible, as it can be hard to know in Git's CLI whether
>> options after args are accepted or not.
>
> Way before doing so, we should recommend the "options and then args"
> order.  Users do not have to know which subcommands accepts options
> after args.

If you want to script git to do e.g.:

    touch -- foo -r
    git add foo -r
    git rm foo -r
    git status foo -r
    git log foo -r

You do need to know that those won't work, if that "foo -r" is from
e.g. scripted arguments that those commands will accept or interpret
that -r as an argument.

Hence suggesting that the user just add "--" to resolve the ambiguity,
as gitcli already discusses.
