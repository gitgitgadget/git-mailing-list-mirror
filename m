Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8412FC433E0
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 19:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A7E20720
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 19:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTQsv5M2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgGUTb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbgGUTb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 15:31:56 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14D0C061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 12:31:56 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v6so22681805iob.4
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:autocrypt:message-id:date:mime-version;
        bh=dARhT/BmrDFi+SMTelaK3F+uE1oH++UfhTMsqnw9qaQ=;
        b=hTQsv5M2G6rUb1dJ3lFmDA7xuGGL5RRIu2mG1trtpLPABlt1XIRPEE9wTM++ck6xTj
         bRMlcMOCpPNhwVr+kR6l9y1VDD+yBQwOOPRizp9Hc9tuFXr4eHHzBL/fa6zuW/9qRmw4
         ka5+96t9jDuUZS4qPiq1qBi0RGT0e/34LrWH1Mud0ro6UrU+MqeoKqgvqH3CAdSOSJeK
         6Ax+Oa3or++v5GZflPGlDwe8qturl19TO5IGo9z7/h/OD3DN4wZJnQEvNSL/5/GK2p3o
         aiyyhdLCr16skV2d8tSkT5te+IT9TNmZJsMWXr5Av3wr4u3l2+u1dc5AzE1wLB4e2oJV
         vQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :mime-version;
        bh=dARhT/BmrDFi+SMTelaK3F+uE1oH++UfhTMsqnw9qaQ=;
        b=Ew+fxgnbaWQNzXhFDKmvD4DK/A7tVDlo8aRhEdRS45n3XjI1QKKomNw4iOshuj+hsl
         t9psyjV8EAnFXElcxfNxrYUd+lR4IaCzdkn8s7gkdq3MrBzS4Ehk68TaSCYHDUVKkIa+
         QQZlYNsLKHh6+tgA9Qg4QJ7MlH6xH372FuE67xg/eJI+dOCJUL2jj1ijQqQFvUs4oc/C
         bX0Qj5qbDXkilrKstozpmRSVKFkic07J13pbGPUubPxO2g4FO4Rp59i1piy+lVeyUets
         c1oW9w464xYKao2bRP4AjI+UXE0ZWoDg6FZVJ6x3QG7q1JUPrrWGDu1cKeyePWVJcqYZ
         Wg/w==
X-Gm-Message-State: AOAM533I3sedRvdkbhkRUKjyeI8KLkZ/sDGlSNhqaFVsfDkuxIFaF/VM
        HWGSH8uw1AIceoNTkLz56I69qttIbno=
X-Google-Smtp-Source: ABdhPJzfgV5vKPuPlnXuModaT1haFUwgp5AmAVKFhYkwiMqLKBVugrftezm5PyhxV3RE1eTbQmLkmg==
X-Received: by 2002:a05:6602:2c46:: with SMTP id x6mr2680809iov.208.1595359915704;
        Tue, 21 Jul 2020 12:31:55 -0700 (PDT)
Received: from [10.77.0.2] (173-29-182-101.client.mchsi.com. [173.29.182.101])
        by smtp.gmail.com with ESMTPSA id f76sm11268135ilg.62.2020.07.21.12.31.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 12:31:54 -0700 (PDT)
To:     git@vger.kernel.org
From:   Matt Parnell <mparnell@gmail.com>
Subject: Disclosure - Git Packs (zlib) Allows for Zipbomb Style Attacks
Autocrypt: addr=mparnell@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <eafc4ebc-47dd-8f7a-d201-74e5369014d1@gmail.com>
Date:   Tue, 21 Jul 2020 14:31:48 -0500
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="COJioJGJKXloPMVquUIp0GiBW97okNJGO"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--COJioJGJKXloPMVquUIp0GiBW97okNJGO
Content-Type: multipart/mixed; boundary="bTpAhhXy4aekFQHJSSNcHU0twcGM1Hdh6"

--bTpAhhXy4aekFQHJSSNcHU0twcGM1Hdh6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Description:

Using compression friendly files, in this case, multiple 99MB zero byte
filled files, a prankster or malicious actor in control of a popular
repository can cause all who clone or pull a given branch to take up far
more storage locally than displayed remotely on the git host - this is
not limited to GitHub, but would apply to literally any git host,
including just git+ssh.
My Example Repo: https://github.com/ilikenwf/git-zlib-bomb

The size of the repo on GitHub and my local git server is 744K, while
the non-mirrored, cloned version with extracted objects is around 101GB.

I argue this is a bit different than the "git bomb" by GitHub user
Katee, as hers was more focused on recursion and segfaults. In this
case, the attack focuses on git's use of zlib to compress the packs,
especially since it will store only one compressed copy of an
object/file in the repo, even if multiple copies of it exist.

While Github does already abort pushes when it detects files over 100MB,
and warn for files below that size, it doesn't seem to investigate
cumulative size of the extracted pack on disk. Even so, this doesn't
really help with git itself, the application, as it means that hosts and
users elsewhere are still in danger and the only way to mitigate that I
can think of would be to have git store a cumulative size value that can
be used for warnings, or perhaps some logic that detects zero or
repetitively filled files that compress in a deceptive manner.
Steps To Reproduce:

(Add details for how we can reproduce the issue)

=C2=A0=C2=A0=C2=A0 Create a new repo locally.
=C2=A0=C2=A0=C2=A0 Create multiple 1MB to 99MB zero filled files in the r=
epo to get a
total in the tens or hundreds of gigabytes, or beyond. I just used

for i in $(seq 1 1035); do dd if=3D/dev/zero of=3Dtest$i bs=3D99M count=3D=
1; done

=C2=A0=C2=A0=C2=A0 Add them all to the repo and commit.
=C2=A0=C2=A0=C2=A0 Push them to a remote git server, or clone them as onl=
y a mirror.
=C2=A0=C2=A0=C2=A0 Compare the disk space utilized between the original r=
epo, and the
mirrored repo.

Impact

While this does not give unauthorized access to an attacker, it could be
used to easily consume a large amount of any given developer's time and
storage space. I personally would be very angry if I took the time to
clone a repo, only to have it crash when it ran out of space, or occupy
hundreds or thousands of gigabytes.

My quick and dirty way of doing this could still be abused further, with
a purpose built tool that adds objects to the pack on the fly, avoiding
the need for disk space to stage our zero filled files onto, making for
even larger repositories, that are deceptively small in size on the
server/mirror side.
Suggested Mitigation
Considering this particular issue, along with that by Kattee
(https://github.com/Katee/git-bomb), I think it would be beneficial to
at the least check the repo/clone/fetch size and warn if the target
location is not large enough, or if the repo is exorbitantly large.


--bTpAhhXy4aekFQHJSSNcHU0twcGM1Hdh6--

--COJioJGJKXloPMVquUIp0GiBW97okNJGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Using GnuPG with Thunderbird - https://www.enigmail.net/

iQIzBAEBCAAdFiEEyxaUgysVmYyKexNvud0OTyTSWqAFAl8XQqkACgkQud0OTyTS
WqCPlxAArbOtOVMn0umZvrNhJAIkMDyK762nZ5rpiNlIDzZTJI08uwmrURo2t4YX
cOhNwm6g7k6ibanCZUjxKxNGqdPIXnMLSIrp7b9Qq0CQHxlOcsNXyCMiL9Qz4b8H
LjA8QTLW5tXWBDWLZzt+fzXqB6pBIxGpzvlCAAWe3nt/OrUqrf2aYktMP1AzJ9hK
J3ENPEMXFKaC3cxPBq2BcutEgOhaW+/oCK/du1zMn/vJ2Sh2qOoCzAldnYzQzDpZ
3cmy+WMMzNjNBIY8Cg36W3FkzDihEzInolJBDue24FT7q0M7EabxTh8eqdaG96xj
WP2ktOPL9p1sWPl9QlIqfIXA+Yk2P0tyl98g73Dj27RcWqoIdBFxo0VS6KR4WCam
fA0HahPUpxyOLzLzFLC9oSDVGedWoQhUtNr+YbLDZjAtd+DgIWR1MN8oOJ4RlsFq
LEJMHGV9pxAOMhPmSbz+EpU5Pl4z6B8KOd9ZjTR37XKv6WEufss486aGqUo2iqKl
bVca9v2SSyBJ7HH2eYDDCHrFbdz16RaALDtdX+JPl/ghVDs8LuWFIBupJbrtBtdY
WNPuOg44QRCDuuBL5YMUlRTZq1pjjoYR9QQJN+txgOSC0u2cjz6KBJDkJWlZG4CO
8G7DQtsFq0SL4q3OPcClNP64D/yf2xQnJe1lNoUx31hF78+iB28=
=IW0T
-----END PGP SIGNATURE-----

--COJioJGJKXloPMVquUIp0GiBW97okNJGO--
