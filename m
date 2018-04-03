Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D977F1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 05:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeDCFCk (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 01:02:40 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38405 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752675AbeDCFCj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 01:02:39 -0400
Received: by mail-it0-f67.google.com with SMTP id 19-v6so20998868itw.3
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 22:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=lmEWMBxEHMDYNpSLBvV2faZnDVAZLuwJiVSPOQ/tpPg=;
        b=Hc7QoLm8I5Jy8PznFVR++Q3dFoSLDtpvSpuxQ6jfwD3+18ZyKywCnsRh56DO2J7C/L
         LuMrFCGjLyG24ySK+MCtbOD8ZG3O9ZplIZstIM8rl9AwOGYu1WLJK15Fo8EkRHxt+0hN
         L6/XHNPRoR2bhZBnfVeItN2CeUt/VcOeng2XeOXnpOPf/Zyf4wbjOCOBMR5vgVHeLoDV
         JahGisJP/3OXSttunbasvEFzEafMxDLbUUGVYc9j3mOD3XDoY6HXFfKH0cM6Bt9wQZm4
         yRas2waHPPqxmm/n0EOgxx3AvIVwjTzxxFxgTvd+LbMaRgyQpW5NIgKo1MEw5/Y1jhIs
         R5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=lmEWMBxEHMDYNpSLBvV2faZnDVAZLuwJiVSPOQ/tpPg=;
        b=KkNAKwqCJni5WwWMZJruz6KCQ6bGqw06nfO4lu/S04l4YAj4NkrnZT/TqgL2QYOkZa
         lHfCxb6AXKI9A97Zr0OhGK9GoQtJsNle1CzKhFfVHoJPu6S3MQmAL9XUKpFT3G1uS51n
         IauJNb9fw3gwqubEkPgH0BxZrayAbJNi1INwFl7LEfnDUdVcAJOv00Hs8zsBDgSB6eN1
         xNTyNifP6swl9hYNWBJEySZx4ZeRMw5D9wAFP5j7+KNRCb/1u92UjDUHM+V3QcKIumcy
         kYyQji7sRyVK8Nt+ECVi4If/qP3t3p3kB1Q+USq1pcAFXP8Brv8w9meDnrbW2qj4HXin
         g2Ug==
X-Gm-Message-State: ALQs6tAwFNtRZBMPJmnRTejOYvhcd2rzn5x00HdC7hL5YghRYaBIDYcg
        12Ftv0KEEYd+VkaGQfmhjkrxfgaFFq0=
X-Google-Smtp-Source: AIpwx4/1pKUbMB4aTAPSdagidyFC/ocZGNR8ugdZ7zuImYFxf+o+QGnrQAu5h2eXXI9duivPCPYsQw==
X-Received: by 2002:a24:1c4:: with SMTP id 187-v6mr3788522itk.117.1522731758895;
        Mon, 02 Apr 2018 22:02:38 -0700 (PDT)
Received: from [192.168.43.33] ([157.50.37.209])
        by smtp.gmail.com with ESMTPSA id f189-v6sm1158734ith.37.2018.04.02.22.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 22:02:37 -0700 (PDT)
Subject: [PATCH v2 0/2] branch --list: print useful info whilst interactive
 rebasing a detached HEAD
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <20180403043101.4072-1-kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; keydata=
 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
 IZ7P/DJ/
Message-ID: <3566c82c-114a-ec2d-286c-2851e4b2952d@gmail.com>
Date:   Tue, 3 Apr 2018 10:32:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403043101.4072-1-kaartic.sivaraam@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fS7SfVOhDDcVzXvzw4Z0hQM467xsoq2wO"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fS7SfVOhDDcVzXvzw4Z0hQM467xsoq2wO
Content-Type: multipart/mixed; boundary="sH00zw1fkE4KjGiUS5YBNSuhsjlrzNZOy";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>,
 Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>
Message-ID: <3566c82c-114a-ec2d-286c-2851e4b2952d@gmail.com>
Subject: [PATCH v2 0/2] branch --list: print useful info whilst interactive
 rebasing a detached HEAD
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <20180403043101.4072-1-kaartic.sivaraam@gmail.com>
In-Reply-To: <20180403043101.4072-1-kaartic.sivaraam@gmail.com>

--sH00zw1fkE4KjGiUS5YBNSuhsjlrzNZOy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Ok, I seem to have forgotten the cover letter. So, here's one.

The changes from v1 are as follows:

* Changes to the commit message of 1/2 to fix some errors

* Code changes to 1/2 to address the comments from v1

* Patch 2/2 is new. It's adds tests for the issue that 1/2 tries to fix.
  It's written by Eric with a little fix by me to make it work with
  GETTEXT_POISON.

An interdiff for 1/2:

diff --git a/ref-filter.c b/ref-filter.c
index a4c917c96..db2baedfe 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1309,18 +1309,14 @@ char *get_head_description(void)
        memset(&state, 0, sizeof(state));
        wt_status_get_state(&state, 1);
        if (state.rebase_in_progress ||
-           state.rebase_interactive_in_progress)
-       {
-               const char *rebasing =3D NULL;
-               if (state.branch !=3D NULL)
-                       rebasing =3D state.branch;
+           state.rebase_interactive_in_progress) {
+               if (state.branch)
+                       strbuf_addf(&desc, _("(no branch, rebasing %s)"),=

+                                   state.branch);
                else
-                       rebasing =3D state.detached_from;
-
-               strbuf_addf(&desc, _("(no branch, rebasing %s)"),
-                           rebasing);
-       }
-       else if (state.bisect_in_progress)
+                       strbuf_addf(&desc, _("(no branch, rebasing
detached HEAD %s)"),
+                                   state.detached_from);
+       } else if (state.bisect_in_progress)
                strbuf_addf(&desc, _("(no branch, bisect started on %s)")=
,
                            state.branch);
        else if (state.detached_from) {



Eric Sunshine (1):
  t3200: verify "branch --list" sanity when rebasing from detached HEAD

Kaartic Sivaraam (1):
  branch --list: print useful info whilst interactive rebasing a
    detached HEAD

 ref-filter.c      | 12 ++++++++----
 t/t3200-branch.sh | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 4 deletions(-)


--sH00zw1fkE4KjGiUS5YBNSuhsjlrzNZOy--

--fS7SfVOhDDcVzXvzw4Z0hQM467xsoq2wO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlrDCugACgkQveda2sPW
GWlung//S7Zw+WKFNQD+p4zJU7ljtEcJLMUOglttUL2dqKLXjtK4ikpCpHZ1ebyW
vESGgjA+dft0m1WpG6I6XkJMcC2wsbeHQibSBxiD8a2NDqMyxQDcapaHG7M1rKKY
sMtUInrBfDpYiLVR/QgfKqFjMRCVDRc/XU02r/pPKkv9ixA3AdHpxKeVMSJBXiz3
cKTE7jj2/q3B1ElGs3AMtCTdrroU6JhqzbNWhuKa32wcl7etpOlhA4v5H2gwoXXs
/p1G2amATJQFqao0obc2ik37WGgusTSCLnhzY5mMxIZnDuQa6CvIemXkrHVtDWD/
m69e0QIETEOeYzpEmXlzOg2cYKOmA+qBz/+Vn1x/qwnTIQO9g8JpbU3VipxUNYSq
5yGJSJ2WckXWlrS+XyaY9P5AoxLMflM/CKpxapu4eCYgVYza5y58p2GNwCfnZKXW
pGGnkIlOYxI6pFyAQcAuZxKOja/J697i+Wqb7ojlTCDxy3bjt+E6PBI/h9QQa8MX
fIiKIqL7+4nfInwK1u6aqYIXSmT4yiIWkUS3lS8tyMEJAECHAWl0bOcRrsDpGTo7
TXpFbB2AaF9/pW6o+I3uVLyhkgkNt2QLcw8Eq6ImnVIfcA9k+kjwSqqxHtXfBDHU
gKtZRMGS59ojMqnNuB/X73H+0PqTZcot008sKf+pecH3eAVSOAw=
=DOG3
-----END PGP SIGNATURE-----

--fS7SfVOhDDcVzXvzw4Z0hQM467xsoq2wO--
