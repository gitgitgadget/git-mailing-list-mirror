Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A5A11F403
	for <e@80x24.org>; Sun, 17 Jun 2018 14:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeFQOC7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 10:02:59 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46274 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeFQOC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 10:02:57 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so7640956pld.13
        for <git@vger.kernel.org>; Sun, 17 Jun 2018 07:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=fDfl00XVzU/wHLkZRDXfX9CyiRjyWsXo+yeoJGA47UY=;
        b=Wtr2YJvwDdfNI+zcKoDeaQql2KhVPBN9BVhXIai5OqvmBuaZ3+XbSZgBhSl2s6hUbl
         OERCGQjC08+rn38aRdG9u1rQz33FpKnDDoaroy0+/iFU8E5de/WiSjcl8A0HzkCul2uN
         n/+Fd8/tcc7MAbRqw3SXc+RNMAUGBfhbIWoxjt8d6Q4w1wT6n1wHq6ytSMl834lZE8nd
         Zm02AQCvPoGZ9akoOyc4Mo0iB04nVW9jEdpjXTaeT0eIEN65GmUBkL5tVjZuDMKU4QBf
         7CBBFdbJ0D4br9ngEhhwTgIrTHRwCWTj3Ydzm9duFRw1n8ZsGS1j/uzQLFzR9Uh2WkYN
         PqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=fDfl00XVzU/wHLkZRDXfX9CyiRjyWsXo+yeoJGA47UY=;
        b=aONbG6kMfg8ToHiYd8/RfNkxgbmGzXsuSClJUkOcdMZB91ZKMX75xr+kvQl4sE1s5a
         a++udbNraXaA4Ae5H4vH5XBq/PlmI5sLW0Ka1yBMfOaPaQHHxSAXfQ5AyWXZIb1fzEn9
         67U4WD+641HAVTlzrr40xudYjmzCs+8hzvG5hv7Icgd2fUpDLxlz1WhiNsPPXVxu7+CZ
         +c1HtiehVyXVt+58WCse6XvF8aTgYGXHLUHQzG+IloB01mVI6SX1IqWRSBJ9O8vdNXhl
         HFg9IDmJrvQ3XWiZ/en9ztHG0RVjxk1+NmEMO2/fmjgJPE4/obZP6b9Vyy84OMCRQRGu
         /1MA==
X-Gm-Message-State: APt69E0Gq1V9owZ3auq0PAF5eTfE1GfhKZrKBDIdc5SNGaGCzzgTedf4
        kM4nOAX5GwLN3IabhRwXGX4=
X-Google-Smtp-Source: ADUXVKKtid2XGZ24t9aoVXm0KujCZf8d7Nbt0tTwb8bmKVRf/aOnzQVuwdlmFyZlWoV1MJOUqcjRrw==
X-Received: by 2002:a17:902:6686:: with SMTP id e6-v6mr10229577plk.35.1529244177386;
        Sun, 17 Jun 2018 07:02:57 -0700 (PDT)
Received: from [192.168.206.102] ([117.209.147.247])
        by smtp.gmail.com with ESMTPSA id 74-v6sm1864877pfj.127.2018.06.17.07.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 07:02:56 -0700 (PDT)
Subject: Re: [PATCH] submodule: fix NULL correctness in renamed broken
 submodules
To:     Stefan Beller <sbeller@google.com>, pclouds@gmail.com
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net
References: <CACsJy8Ab3HoVWSWOtCBRYcsnnHnpO-2oEfV60f=H15RuzwpWwQ@mail.gmail.com>
 <20180614173107.201885-1-sbeller@google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <9588295f-f809-c95c-664c-c05b04d7fc5c@gmail.com>
Date:   Sun, 17 Jun 2018 19:32:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180614173107.201885-1-sbeller@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KOkD5SWhav1GcC4VigWE4l8q9aZkoXZp5"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KOkD5SWhav1GcC4VigWE4l8q9aZkoXZp5
Content-Type: multipart/mixed; boundary="dFShUTMxt28KTMxLuHrwMyBYTk6NoFY7Z";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Stefan Beller <sbeller@google.com>, pclouds@gmail.com
Cc: git@vger.kernel.org, hvoigt@hvoigt.net
Message-ID: <9588295f-f809-c95c-664c-c05b04d7fc5c@gmail.com>
Subject: Re: [PATCH] submodule: fix NULL correctness in renamed broken
 submodules
References: <CACsJy8Ab3HoVWSWOtCBRYcsnnHnpO-2oEfV60f=H15RuzwpWwQ@mail.gmail.com>
 <20180614173107.201885-1-sbeller@google.com>
In-Reply-To: <20180614173107.201885-1-sbeller@google.com>

--dFShUTMxt28KTMxLuHrwMyBYTk6NoFY7Z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Thursday 14 June 2018 11:01 PM, Stefan Beller wrote:
> While at it, make sure we only attempt to load the submodule if a git
> directory of the submodule is found as default_name_or_path will return=

> NULL in case the git directory cannot be found.

I found this a little hard to read. Maybe it could be sentence could be
shrinked a little. Possibly,

    While at it, make sure we only attempt to load the submodule if
    a git directory of the submodule is found.

I guess the other part of the sentence doesn't make much sense in the
log message. Maybe it could be an in-code comment. Speaking of in-code
comment, the following would also fit there, wouldn't it?

> Note that passing NULL
> to submodule_from_name is just a semantic error, as submodule_from_name=

> accepts NULL as a value, but then the return value is not the submodule=

> that was asked for, but some arbitrary other submodule. (Cf. 'config_fr=
om'
> in submodule-config.c: "If any parameter except the cache is a NULL
> pointer just return the first submodule. Can be used to check whether
> there are any submodules parsed.")
>=20


--=20
Sivaraam

QUOTE:

=E2=80=9CThe three principal virtues of a programmer are Laziness, Impati=
ence,
and Hubris.=E2=80=9D

	- Camel book

Sivaraam?

You possibly might have noticed that my signature recently changed from
'Kaartic' to 'Sivaraam' both of which are parts of my name. I find the
new signature to be better for several reasons one of which is that the
former signature has a lot of ambiguities in the place I live as it is a
common name (NOTE: it's not a common spelling, just a common name). So,
I switched signatures before it's too late.

That said, I won't mind you calling me 'Kaartic' if you like it [of
course ;-)]. You can always call me using either of the names.


KIND NOTE TO THE NATIVE ENGLISH SPEAKER:

As I'm not a native English speaker myself, there might be mistaeks in
my usage of English. I apologise for any mistakes that I make.

It would be "helpful" if you take the time to point out the mistakes.

It would be "super helpful" if you could provide suggestions about how
to correct those mistakes.

Thanks in advance!


--dFShUTMxt28KTMxLuHrwMyBYTk6NoFY7Z--

--KOkD5SWhav1GcC4VigWE4l8q9aZkoXZp5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlsmagsACgkQveda2sPW
GWkR4A//Sxi1AUZTa5/a94Gr/qmKcdyT0wwRZLgXR1hzjbxU8BWgilLBJnhdQ0hR
RnYP1Z4swcbp0/rXbh9jc31kZda1gSEydINsVemsboCA7Ds1l32J1jNlXSF5Txqm
RThexdcxQ97T+4oq0sAQwKlloZMB20OScAJGr/agn3w9ssre2gu/0J3uRXqaqvII
hZzjjFyv8nxa2/f0zNNjNqOB7kRLhLevIC/q5EZJSLdwr5JHxdD3y7vLXbOJK11r
J/1BaihH/mBau/K/6Qxo4qKni5wr2hYL3jpvObSTU2+AUEkr4VqNgD103IxEcMeN
iJgOrkgIvkVYWOqeNl9GTY89ef6ico78z0RaJshQh9kvoLcJTJZH4CAYfErB+PCW
4XaD9Tw5pzt09LAo5Mj6vqqTHlIzwfGo33w7f3ES2WbVFg4wRHr/utfxH11kZC7P
kb0enU6kEULs4FKaDHCHMal9d4AomCRqDjOsynOhcfa+6HJgElcGtjyMbn2R1Nnr
zY6g6TiF88wW51e5a4Zhg5L4T1xAWPGZxLeZp2+q6c0Gt0MJhJcRNvX7l6N2dP5c
atLAG1CY6FgUoArJGAc02tjY12BGozr/7FZDCVfvDt5g26E2U9C8AGMeQBobPtOU
AJuJ/c5N4yD715RdPq1vr5T0AJpJYJURPGS/bTRbBSqMGuhTzRM=
=9CQ3
-----END PGP SIGNATURE-----

--KOkD5SWhav1GcC4VigWE4l8q9aZkoXZp5--
