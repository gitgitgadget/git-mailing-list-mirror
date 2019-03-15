Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6CDB20248
	for <e@80x24.org>; Fri, 15 Mar 2019 10:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfCOKYW (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 06:24:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37287 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbfCOKYV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 06:24:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id m12so7154006edv.4
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 03:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=TJtIp74JatWzTl2ebk9ih99Xu8URqC/zvX+i8mt1Tg0=;
        b=QKub3H3T/fZ50a8GBiq0EjrfQ9jlGWFEG1D5tAzH05T5MGjzENUzSVkPGtAz840HJD
         dGr+hHVUU9/RS8HWQnUHyLcOTXPitQgtDZS2dS67/Har6QHThx13rvJh7IgrO8+TSDrA
         2fxhwE9F9JSsMXdSVtrxMbnJEWAAjmnx6wrDsU8hXdSnyEAazxRkm0lmfH0W0y83Yx7h
         rwQFycLD5mPwYcIb09SyNKVX6L0itJ57fMQES/OEwopPWa+9HVPPFZBzi6f0UQPftzG9
         l7YByHAjSWhI3npsJ/vmDmdhCM/N9pIQecuQnRUd7Qgx8UTrpgJk3GFFATcQ80XNxwu4
         KuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=TJtIp74JatWzTl2ebk9ih99Xu8URqC/zvX+i8mt1Tg0=;
        b=LPKuiXME1WOTdxfbuCq6SsSs9SNiRDTIka2stMZj4NvBllJloJv5SwM683nAkb13rd
         tuxCQIfGqqhJmAaWWMdUU3aWzma71vv8Ip1czCd0OSG3phGyIDStaOiXagyp2KKMIHbI
         zNBgAko9JdciIcUOjrZkGISWOgFNSyZpxUzHUDVHNfhpQVxbRF0AkZLZkRv0+/39Ql9m
         K/eauuqZt65BaPdvn4zPgoJlUKUHcliv1vu7gCm83gzANbkZBrzDw4a22LpoaCxOIXt/
         Hf85ojgET2Yg0tWIbmsXHCjuH0ACN4Sdd74+JXfVK4PhPfo7FBRpn+oge3Ml7VSo7EcA
         1Wqw==
X-Gm-Message-State: APjAAAX1Zso1qpmjTkckQfo0VdDwAv7d+8f8wHi3JMPF9hMSQFsLqHs+
        Sxg7sMBs25TWMsO4vynv0DVgb90KwlI=
X-Google-Smtp-Source: APXvYqy9OOky5f9HTRnkpd6OwyHBD68Zkosgip2BZmnT9wMwoHBS2xnWlW04MMeOX9etqIZK3byHvQ==
X-Received: by 2002:a50:8835:: with SMTP id b50mr213611edb.262.1552645459498;
        Fri, 15 Mar 2019 03:24:19 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id r1sm516430eds.39.2019.03.15.03.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 03:24:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 6/7] gc: don't run "reflog expire" when keeping reflogs
References: <20190313235439.30439-1-avarab@gmail.com> <20190314123439.4347-7-avarab@gmail.com> <CACsJy8B=76dMKhvdzOyyOMK5o-s8t+77ZE-hBmezhxLdv7E9dQ@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8B=76dMKhvdzOyyOMK5o-s8t+77ZE-hBmezhxLdv7E9dQ@mail.gmail.com>
Date:   Fri, 15 Mar 2019 11:24:18 +0100
Message-ID: <877ed0bfl9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 15 2019, Duy Nguyen wrote:

> On Thu, Mar 14, 2019 at 7:35 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> @@ -127,6 +140,10 @@ static void gc_config(void)
>>                         pack_refs =3D git_config_bool("gc.packrefs", val=
ue);
>>         }
>>
>> +       if (gc_config_is_timestamp_never("gc.reflogexpire") &&
>> +           gc_config_is_timestamp_never("gc.reflogexpireunreachable"))
>
> Nit. configset api normalizes the key internally, so we can safely
> write gc.reflogExpireUnreachable here, which is a bit easier to read.

I didn't know that, do we want to do that?

I'd think that as a matter of coding style always sticking to lower case
in the C code made more sense, because e.g. you might #define a config
key, and then use it both in git_config_*() as well as via strcmp() in
some callback. Mixing the two would lead to confusion and possible bugs
as we'd refactor the former of those patterns to the latter.
