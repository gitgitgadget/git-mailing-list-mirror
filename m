Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B52C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 17:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2FA2464D
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 17:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwCML740"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfLEROe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:14:34 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:44257 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEROe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 12:14:34 -0500
Received: by mail-lj1-f175.google.com with SMTP id c19so4410758lji.11
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 09:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=JAnYNt7qkVHoxOst4D3NWQlJ2UIQ9psaUWb4ASSbZ6w=;
        b=YwCML740GFmJZss8X1h3NTVGTj/HyMuGAz/uqA/I2r2HKv5lNonhyvGVYqMgsDfhx7
         tnbAKbVydla1d8Y1KD4Nvut6HHmXVImCouMn2TUG1sFx1IqqmzDbUfB7Ru6kmmG4LgRa
         YCwdbAwG+cLKrkEtjhpccWNw4tgDYPTgOTZ6tru0bSjLSbrl3gDitKtZOE7zyAO3Rn2Y
         WN67+hCZxqIA4OhzmUjaEd6oDvXGaCFNQgoTiI/P8tT8zAtHyjDWzNyHK89BbGMRFkRc
         gradRkPEJ60LysDcmlHF1YvoYwwOYyrdPlaQ98HYrZOnnfL6vm/WzyptjjzscIOkpUvX
         mkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JAnYNt7qkVHoxOst4D3NWQlJ2UIQ9psaUWb4ASSbZ6w=;
        b=lexaUOMjhhUXeuwADlMkslNoeBOKa3CLgUX9z52xauzn635wVv3PFDO3NPFw95WRhu
         NHgWcrAOhvHR3jRk661r7YslokvBJ4F2g2w7bH4OyPTR0jZgv7FDxrJrh0qqSp/04eUE
         KwjknYMbRUHSpnboF6i7F7A6bmopSFO+badRDeRvIt8FNzgXzO0La0rx2itaKxvGbojd
         h1d3WbE7yX6PaJDg8CVr9lxIesmev+dhrQPkVEa7Gzx6P4Ks8DyF/rE+LfpYdVHieUtH
         btIsKP071EjknfGF+689TrVyYpKreG2k+KlyXQsVLv4gMjiZ//BC1pTJRkiKwuoH12cU
         B6kg==
X-Gm-Message-State: APjAAAU+oZe9JuHL9g3jYLsyPT/B4qsh0Dyb/lpniGxi6ClleBAadpof
        QkrRYcsq1v9DcBiNm2c/g0p2WFwH6jpn+SBu2h7ZDBI74Fg=
X-Google-Smtp-Source: APXvYqzKgEB71wclZBg97EfAoqq58MAHE/q6XQQ3o2Gs1Qs0P9FOmPho5mM3rf36eYkOi4Podc69XI2cLa1XSi7sv3g=
X-Received: by 2002:a2e:9b52:: with SMTP id o18mr6013586ljj.205.1575566071043;
 Thu, 05 Dec 2019 09:14:31 -0800 (PST)
MIME-Version: 1.0
From:   Nathaniel Manista <nathaniel@google.com>
Date:   Thu, 5 Dec 2019 18:14:04 +0100
Message-ID: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
Subject: [ISSUE] Stop accessing, storing, and sharing the user's time zone
To:     git@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000009520a0598f81020"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--00000000000009520a0598f81020
Content-Type: text/plain; charset="UTF-8"

(This is also filed at https://bugs.chromium.org/p/git/issues/detail?id=43.)

Affected Version: All? This has been bothering me at least a year.

What steps will reproduce the problem?
1. Author a commit.
2. "git log --pretty=fuller"

What is the expected output?
The log will display that the timestamps of the commit have both the
author time and committer time in UTC. Internally no part of the
commit will have stored any time zone information and when the commit
is shared with others no information about where the user was in the
world at the time of the commit will be obtainable from it.

What do you see instead?
Authoring and sharing a commit by default exposes the user's time zone.

Additional context:
"commit --date=YYYY-MM-DDThh:mm:ss+0000" suffices to put the author
time in UTC but not the commit time in UTC. But the user shouldn't
have to pass a flag at all.

Where the user is in the world is PII that git ought not to record and
make available as part of the user's software engineering (make
available to colleagues, in the case of proprietary development, and
make available to the world, in the case of open source). Git should
entirely stop accessing, recording, and sharing the user's time zone,
full stop. Failing that, git should by default stop accessing,
recording, and sharing the user's time zone, but if individual users
want to have their time zones on their commits, they can opt into it.
Failing that, users should be able to add a .gitconfig line to ensure
that all author timestamps, all committer timestamps, and any other
information are in UTC.

(Thanks much,
-Nathaniel)

--00000000000009520a0598f81020
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS7QYJKoZIhvcNAQcCoIIS3jCCEtoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBTMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
QAYIKwYBBQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWlt
ZWNhMS5jcnQwHQYDVR0OBBYEFB+uy5CRUlsCSQJmRN5PB/ONuRB9MB8GA1UdIwQYMBaAFMs4ErDH
mcB4koyzIZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0
dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQCVKSiPTUZm
DBntx3awgIcunrrCoYbRWdKQVWldUhC/UXXQ3XC49JrSTdOLtuQg7Snfb69qhuxKPRiY67PT1vVp
Boh3li9nQS3v5N/l0zZtqEDTIG47aYrES5pWAMDSM3hIC3BLr/vxuvuxGQSSZvwdfdRHUG1lM3Gz
JAP4vt7DFURfW3L/RQXrgsCKJ/3hr4DQwShluZNFaSj+jvb6Js3RpbYpdddjsIeLWFNkJnaOvJaU
Q8ds8K15Gj7w57zdtNA3Il+qzOOK/mLZlL7isshVkolmFZxDJwRN9xgG4kIPVu1igcZFsLQQ2ft+
n1g+m99xhj6YOMyOtGX3x2qVjbLbMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIM
Z+k0k1Q9vIiIACubMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDVQOLK1s/b7c6z
Q5AYeEdj6Q3Ku5vfNBbW5N6CXTrBfjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0xOTEyMDUxNzE0MzFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEALyo5J13Cri+Pd0W16mm9uPndnPggtCGl
/C8BtufhqNkfO8EEShdlrlvcznA//QrBNaV6jnIgNdjHI5l3TpBnXzMDrYOXfNf/nWRqOw5sMKGK
YuU3BJfU0MeSZ0r22GGpi9pGIVAGYgh/A7yt8JcfywpC61SvXtm3syycyk7rbcWtXuIO1BlYogyi
Wx/uFaPTQcHawTIDBMGkolNKjj3xnUBTvQL8/zjZMRSFhTyKi2etC6ZTsrBUZ4u/JLCRfRbf+J/s
yQwYITN/RrAOiFNh4TT2IwLWc+0tQyDp4UoNZjuXTWjbXjDoc+jPOXYmVC9ZKLFvWdmm0JnMO9bU
smRgzg==
--00000000000009520a0598f81020--
