Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D130C3A5A9
	for <git@archiver.kernel.org>; Sun,  3 May 2020 01:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360022137B
	for <git@archiver.kernel.org>; Sun,  3 May 2020 01:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgECBWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 21:22:15 -0400
Received: from mail-qv1-f45.google.com ([209.85.219.45]:33382 "EHLO
        mail-qv1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgECBWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 21:22:14 -0400
Received: by mail-qv1-f45.google.com with SMTP id ep1so6652665qvb.0
        for <git@vger.kernel.org>; Sat, 02 May 2020 18:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version;
        bh=yfm/frNkRXdt/gXxod2j43ECw+B9i37VF0rcEtCHHUU=;
        b=hjs6U2E3zqOR8RsXgh2f+PlW56ZBX6ym1A1FU5Q4VFG9/QFra1hlHr7rAOd+cEOtSA
         hRDv03bPwTtIf/mhNODn15Ml2GO94uffi+jMqiF0DvJSWKcODO9pne1NDoLGboYJIoeO
         Sk5bGMfnUeb1DdUim3yTyiJi8lE5f8GttA7KQPTCkpMfiB5ZfLcnYcq2hCISYgLtbQZv
         oSpJ0oVxRPZLX7Xj+uHQIftaa/uSBTdMkAUHftfdSwc2ehlVKLYHmchT2mFD5VoV+8z4
         kOjrrYI69pQ87fb80gG3HUARifJChU9bwkmxzlXrv2OHPEDtN7xDuqHUkZqy+kH2AGjY
         GGIA==
X-Gm-Message-State: AGi0Pua/XXNL/v9ZKesWSKUsCe+6+NXY3TVd50Ayd4KtSe62QgvtBCOU
        z5spGs2XVwKw7m2MmW1TBNnOoY4V
X-Google-Smtp-Source: APiQypJ9Dgfq67Pz219KEbXBGryUCYFpbkCFxExY6kSOD8aJIERQlGpdmuEf3b54e82KSR1aUdbGqg==
X-Received: by 2002:a05:6214:42b:: with SMTP id a11mr10563090qvy.186.1588468931312;
        Sat, 02 May 2020 18:22:11 -0700 (PDT)
Received: from [192.168.0.153] (pool-98-113-53-115.nycmny.fios.verizon.net. [98.113.53.115])
        by smtp.gmail.com with ESMTPSA id x125sm6446202qke.34.2020.05.02.18.22.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2020 18:22:10 -0700 (PDT)
To:     git@vger.kernel.org
From:   Paul Ganssle <paul@ganssle.io>
Subject: Segfault when rebasing with --autosquash
Autocrypt: addr=paul@ganssle.io; keydata=
 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
Message-ID: <017dbc40-8d21-00fb-7b0e-6708d2dcb366@ganssle.io>
Date:   Sat, 2 May 2020 21:22:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WCAfZDhACe9Q13CsJP9S6R7M4GShKGf88"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WCAfZDhACe9Q13CsJP9S6R7M4GShKGf88
Content-Type: multipart/mixed; boundary="YZSrMcnh8tz5HiDcXmOSHGbdFbb147IjX"

--YZSrMcnh8tz5HiDcXmOSHGbdFbb147IjX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US-large

Hi all,

I have recently been using the git absorb
<https://github.com/tummychow/git-absorb> tool to automatically split up
various minor adjustments to my branches into the right fixup commits,
which I then autosquash at the very end. This has worked very well for
the most part, but twice now it has managed to get into a state where
`git rebase -i --autosquash` leads to a segfault in git. This may also
be a bug in `git absorb`, but I think the segfault must at least be a
bug in git.

Unfortunately, I have been unable to /deliberately/ create a repository
that exhibits this behavior using `git absorb`, but last time it
happened I created a fork of my repo and trimmed out as many commits as
I could while still exhibiting the behavior, you can find it here, along
with instructions on how to trigger the bug:
https://github.com/pganssle-bug-mwes/git_autosquash_bug_mwe

I'll also note that I have confirmed that a fresh clone, git gc and git
prune do not help here. It's easy enough to work around =E2=80=94 just do=
 an
interactive rebase without --autosquash and manually squash in any
commits that say `fixup <commit_id>` instead of `fixup <commit_message>`
and you will get back into a state where --autosquash works.

Please do let me know if anyone comes up with a better diagnosis for
this (there may be an associated bug in git absorb, and knowing more
about this bug might elucidate where that could come in from git absorb).=


Thanks!
Paul



--YZSrMcnh8tz5HiDcXmOSHGbdFbb147IjX--

--WCAfZDhACe9Q13CsJP9S6R7M4GShKGf88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEa0msutz2vRyiBmerzVT849lkvvsFAl6uHMEACgkQzVT849lk
vvudig//dK4MDGeLh+WwqAAUmORcQzNUaYgi8wT253PAq3JR6fIjT8B4SHVA9wLK
D7bU3OLAxviaKQKf2TIKO9miEi2Tv6OmUr/lq+x3IQHuogPNzMhzZXs5b/rGKEjE
glu7RWBwXQikGey8QHUpkVTjeEjh4vWnFiApKd1hSRpWd3fRI35Xs8s8VxVMMfqJ
TIu0JBY5qmY2Tm+dUmR2Dnzb9/jkAgBP9GNcsQ6FZyeL84YhckgosOHbzDH5tNzJ
IH8uwgCL0StjQu+cn8GCzlXM7Qr5cjc5F5LYi29H2qKGHTSBhkr3YnUCtvmaREJT
hFatpKUqsPPpVl8wXBopftwoPbSvSmSRX0oqVMjrS0rjdSVxBYIt3zGmsJHtttvW
p+6zkG4ICcwERIqZmOYcVPhpHOFASUn1uaLOX58aQYGxyGaR1bxo71A3sb1UkuOM
VQ1pki1bycUOvnXxRpBxqX1HdeKZcr587hTu1HIx0EeZVeVacgY3TaiAcY0jiPC8
IFDYCZsAxiNuTPtxHtcAvfVRh575Zej899OmwnVqhclZ/0yFboAYDOCpLH9BIZYE
OYDd3eXSDHcCBY83t7D/7JKq3EMEt1/g/ZjelTeVr8afu8o3194d4r60YwtjE17y
RDcMQDkFw90YbnAwjOPOsoNR21NWwqtyj1b8Ay4zDjIci1p9SjM=
=TjSO
-----END PGP SIGNATURE-----

--WCAfZDhACe9Q13CsJP9S6R7M4GShKGf88--
