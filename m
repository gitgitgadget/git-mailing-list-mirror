Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3CDC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 13:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350189AbiDUNg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiDUNg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 09:36:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C471BE94
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:34:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so3417069wmq.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=p1sec-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:cc:autocrypt:organization;
        bh=Gf6Bs5F5/9wwuPemWL2BMgM03Ew+elaIfGcU+0aNJMk=;
        b=DSXFFuf28/KHJq64ZPAiUxtZ6aYf5arOgKN5LkYs8X/ZGz3+nSw99W/Pc0RNDiIz0n
         4LcaQvL0YahKmiMkeBfT6URPHz5ZpzzBCuxlinCBH6xHhyh11Uu7VVQp/SRJrfuguYje
         CtMG6d+i2n0zV9wwbRHCkqT2w/wWgDOuYwoErshNdoyF7Vy2X59FxdBVZ6FPPvuktU/I
         BzeYkTVnFmkSVbovYUdXRHUhO1QoXL3AKaRU07sRJpTpcFHJ1Ggwh135b876mduzLHb3
         yRrt5eAqVB4aeLKrvjWYP1DbeLr0svvUDCQcbBG7RKL/pWm8BlvSIqNKtdJMXhOgopPJ
         3eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:autocrypt:organization;
        bh=Gf6Bs5F5/9wwuPemWL2BMgM03Ew+elaIfGcU+0aNJMk=;
        b=O+xzVuJFgOqTP3yH3tmMn9lQS+V4rfZx46mQlXqMW5cDJC5tM0O6FiINFn2FyvzDiJ
         B2DkJj0g9sOQp9L+wcs0PgracQJTT1h1HZG+8xEaVCeUzmXz9CitcKcELSVGVYZY8TV0
         /Bjay5AWvpKRI+frq4vEnKKlUccxq0hGl8JclXqQVJc+1GzTmjKx6D02klorFEsJGXgQ
         kyNZjI+hdnrtqX4s8DN22IgA0SIr46BuhWN65nBojNGgytCj/DJ+VSGyuwLKReu/TkNo
         wiYA+L/FN3+g6cGTU+Kscfv9zL2B31lLrjC0AovdnHfEgV0lavi2WFNxRDq0hs5nBnda
         nbKQ==
X-Gm-Message-State: AOAM530SHWnlWqG6/ysXg8jFkgJuI98XEMtGBvKdjxKltZiZXUm9Pjbj
        lw4x79EwWpsmjigpmY/vA6Q4Rflqd+Gu3g==
X-Google-Smtp-Source: ABdhPJxjE2jiwNMX2h+XGTDTCRaSmM/UcTg7cEahxls9kkSgNUJ6JJrVcop667PR2q36FIL0R2f67w==
X-Received: by 2002:a05:600c:4f88:b0:391:e34e:ca66 with SMTP id n8-20020a05600c4f8800b00391e34eca66mr8556688wmq.16.1650548044399;
        Thu, 21 Apr 2022 06:34:04 -0700 (PDT)
Received: from [172.27.32.86] (lputeaux-656-1-154-186.w217-128.abo.wanadoo.fr. [217.128.61.186])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm2086885wmj.29.2022.04.21.06.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 06:34:03 -0700 (PDT)
Message-ID: <225b410d-2d98-8c0b-c289-22f753c175d4@p1sec.com>
Date:   Thu, 21 Apr 2022 13:34:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
From:   Gregory David <gregory.david@p1sec.com>
Subject: [PATCH] show-branch: fix SEGFAULT when `--current` and `--reflog`
 together
Content-Language: en-US
To:     git@vger.kernel.org
Cc:     ptm-dev <ptm-dev@p1sec.com>
Autocrypt: addr=gregory.david@p1sec.com; keydata=
 xsDNBGIKmJoBDAC3FWaPT2Dbkcjzuscy//9UYL9bxYPWy5LN1UUvYJQbkCfEKjpXAsuzqnVq
 jVkLo883TAlFcbmpBtJr/4tkXTeetzEVQfK3cVgdRbMNq8SDgtcAcdSEh43QBOKhXU0TVTnt
 zhfJ5CKTd5RCLzKcIGw2UrY8Eu8KCtP5ZEZf1F3fjjQ3vxfsMwctZK364EU16SX4jTS1V6V8
 DMagxksQwsC9vhY61tMHNcdR6DjF1qAyjdHpywaJoGJefvTrYUWK1oNDPEmVn/GpSCoA6mjT
 7rzvsSSBzklBRPueeMl8MIataNCSNPii35y5fPkGyBblUWIW9AAKdIkBlXnF7uPVjKXYCgB0
 /qRXAASBYMfFLs2OBR/le17tI/TnJcfHTTC8cw4bQw5v6cRagUHhXyDn30gZ/P3WTiWcIgOQ
 d8l6C/KvMxF14X6rrV81Kutuip6m6mPrMxJAcoBjcNCT2I9TEG+ztEfS9ZJPoOY/yLimSMdh
 zDdqkS18M9V/OLrEzEkSbAsAEQEAAc0nR3JlZ29yeSBEYXZpZCA8Z3JlZ29yeS5kYXZpZEBw
 MXNlYy5jb20+wsEOBBMBCgA4FiEEgTMgz/uZophfcP0Opt83aS5d4vcFAmIL10wCGwMFCwkI
 BwIGFQoJCAsCBBYCAwECHgECF4AACgkQpt83aS5d4vcFkQv/d/UbYPXBRn+LxaAwL/hIrHcT
 4CQoGa9J6eyvsgDb55iuO4QIJ1cwDLYsAg06ajHO2LsgUDu8eggIJY4VTk8tLyCkMjgFhyrm
 ze2tsZWwre5maKTEe4g4dGAJ24Qnjcb52G32ucOeouJahaJuI3Dg24VtJtsSvuQtNsPJdksD
 TaLhMwkJ6W+3r0D2QJ5QUxyuLv+1dIO4z0TPtuUR712ElhhoKeEsF3LweQKS4bcxqFKPvFXm
 5ZmXHrucm/SKSUaD4aye5nYLPpDghuGmvTqKUMRwj+4lxYxwLfqau+edPYa49FLhapE38UJl
 imkgf5agsxkWVRrVCXimxJF/4H0k0XS8UpgqYhGkfEItm7kv3UOMVHEgcZQDboy3vyOgqc9T
 l97lG4K6xDM9azAb0Zw3Z9JeuN2Gj+DgmHsoXPIY8u4sHwkbOBI+mmcXd1X/4izclhrPN/Hx
 YK/WLqLQLyDLd5fVvtsziAcXk7xsszLQpAg2gYNPUzw36iWxFYwYK2WJzsDNBGIKmJoBDADN
 lLnt5oVNUC7Pq+Udmocnxxg443/emnOcgeYJAZX9nSLrU2oqwonKE333NyMBnifoW93xYAud
 04QqWszWNGw1Au4clLI8gXbdq8daFZ764pkel+xNAMTpO0P2twqC0UEGf9iqvf6DFNrrmmV9
 f94+m/WNwh+2tc5C3HA8StALqbp+pPZA08ZwEjHToGngWdJxFJLuJSVWYUMDFmc+4/KdyMSV
 jFv/wbjHXqlIF71zGAUJj8PIbPSAOMvdPkr71eWVk77geL3s6Ifm4OffXznqMsoSdhAvopoN
 S5P9fojNRDIGAk0+KIf5itCJOJOZSJ9fDCi3sarPQU6SJCP5Uk+cGwjI7CCXbfScQHJrPKZ3
 ptuprgW/4cY8RPxLyIj4mhfPJeAXgF1taqFyc7uC1VVPlhda9uzBj9/Bxr58ePfSUA5GccGo
 zPcbsE39s8em+FETFSUjCaX2FT2o9sIF0f3loJIib4/RASGHZvUlNMyJ0qPDdgA14L4LZH/D
 v4JyyhMAEQEAAcLBAAQYAQoAIBYhBIEzIM/7maKYX3D9DqbfN2kuXeL3BQJiC9dMAhsMABQJ
 EKbfN2kuXeL3CRCm3zdpLl3i935oC/0dOmOqDM2eu1hH1I4qtfiBlYZrO3me3XwZZWq49LLl
 8i6ZYFquDI+AnmTkusYDjb8lFKZzwM/rUXsmOhqYq08r+BTsYqdIslO/3Y65E2KYGQmX5NTu
 3T50c0Pni5i7N6AXN/FvTLgzCRMKgyyDW8nD4BseuhVAtbJaVkcOpv2jo0egjg0YIIqY485c
 4WQlJ7U3AJeT9HJgAjYpHMK3WEiE/L8XrP5NHJHgCufr8l1qwkIXqslOc2HR6+lwMISKalbo
 o5znHCxg/TbAO6vJr9MAJ5Ed4QkxG4B9Tw5/Cr84jhfx9Dfc+9XJ5+Rkjc8GSIms9AOdNeLw
 BccmYwPWL/wQXnDQ2L4n4PTkE5vMi0KWcSrIHtjzHX0HrU6nVLqgA6OPRD9usOUJZQ7TIIMq
 RnMqLLxElP5pZGV40W87GRYdO7kQZeMwsYABTnzRljWC+92u7Fi0pkCBiVWdAdK1M6jStecp
 v1dxvY4f2F5nhrZWkn5Rw95Qk2jIp0JB7GLzRSg=
Organization: P1 security
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------uUVz6NkmLsOWOeCGl5KtLHC8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------uUVz6NkmLsOWOeCGl5KtLHC8
Content-Type: multipart/mixed; boundary="------------HVNfVVwZ91V0h7IY8bL1Q2bV";
 protected-headers="v1"
From: Gregory David <gregory.david@p1sec.com>
To: git@vger.kernel.org
Cc: ptm-dev <ptm-dev@p1sec.com>
Message-ID: <225b410d-2d98-8c0b-c289-22f753c175d4@p1sec.com>
Subject: [PATCH] show-branch: fix SEGFAULT when `--current` and `--reflog`
 together

--------------HVNfVVwZ91V0h7IY8bL1Q2bV
Content-Type: multipart/mixed; boundary="------------RytaKy1fMypCEyBUKXqgMqJG"

--------------RytaKy1fMypCEyBUKXqgMqJG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

If run `show-branch` with `--current` and `--reflog` simultaneously, a
SEGFAULT appears.

The bug is that we read over the end of the `reflog_msg` array after
having `append_one_rev()` for the current branch without supplying a
convenient message to it.

It seems that it has been introduced in:
Commit 1aa68d6735 (show-branch: --current includes the current branch.,
2006-01-11)

Signed-off-by: Gregory DAVID <gregory.david@p1sec.com>
Thanks-to: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 builtin/show-branch.c  | 22 +++++++++++++++++++--
 t/t3202-show-branch.sh | 43 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e12c5e80e3..c8d830b7c6 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -812,8 +812,26 @@ int cmd_show_branch(int ac, const char **av, const
char *prefix)
 		}
 		if (!has_head) {
 			const char *name =3D head;
-			skip_prefix(name, "refs/heads/", &name);
-			append_one_rev(name);
+			struct object_id oid;
+			char *ref;
+			unsigned int flags =3D 0;
+			char *log_msg =3D 0;
+			char *end_log_msg;
+			timestamp_t timestamp;
+			int tz;
+
+      if (!dwim_ref(*av, strlen(*av), &oid, &ref, 0))
+        die(_("no such ref %s"), *av);
+      read_ref_at(get_main_ref_store(the_repository),
+                  ref, flags, 0, i, &oid, &log_msg,
+                  &timestamp, &tz, NULL);
+      end_log_msg =3D strchr(log_msg, '\n');
+      if (end_log_msg)
+        *end_log_msg =3D '\0';
+      skip_prefix(name, "refs/heads/", &name);
+      append_one_rev(name);
+      reflog_msg[ref_name_cnt - 1] =3D xstrfmt("(%s) (current) %s",
show_date(timestamp, tz, DATE_MODE(RELATIVE)), (!log_msg || !*log_msg) ?
"(none)" : log_msg);
+      free(log_msg);
 		}
 	}
 diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index 7a1be73ce8..7f6ffcf8a5 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -161,4 +161,47 @@ test_expect_success 'show branch --reflog=3D2' '
 	test_cmp actual expect
 '
 +test_expect_success 'show branch --reflog=3D2 --current' '
+	sed "s/^>	//" >expect <<-\EOF &&
+	>	! [refs/heads/branch10@{0}] (4 years, 5 months ago) commit: branch10
+	>	 ! [refs/heads/branch10@{1}] (4 years, 5 months ago) commit: branch10=

+	>	  * [branch10] (4 years, 5 months ago) (current) branch: Created
from initial
+	>	---
+	>	+ * [refs/heads/branch10@{0}] branch10
+	>	++* [refs/heads/branch10@{1}] initial
+	EOF
+	git show-branch --reflog=3D2 --current >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'show branch --current' '
+	sed "s/^>	//" >expect <<-\EOF &&
+	>	! [branch1] branch1
+	>	 ! [branch2] branch2
+	>	  ! [branch3] branch3
+	>	   ! [branch4] branch4
+	>	    ! [branch5] branch5
+	>	     ! [branch6] branch6
+	>	      ! [branch7] branch7
+	>	       ! [branch8] branch8
+	>	        ! [branch9] branch9
+	>	         * [branch10] branch10
+	>	          ! [master] initial
+	>	-----------
+	>	         *  [branch10] branch10
+	>	        +   [branch9] branch9
+	>	       +    [branch8] branch8
+	>	      +     [branch7] branch7
+	>	     +      [branch6] branch6
+	>	    +       [branch5] branch5
+	>	   +        [branch4] branch4
+	>	  +         [branch3] branch3
+	>	 +          [branch2] branch2
+	>	+           [branch1] branch1
+	>	+++++++++*+ [master] initial
+	EOF
+	git show-branch --current >actual &&
+	test_cmp actual expect
+'
+
 test_done
--=20
2.35.1
--------------RytaKy1fMypCEyBUKXqgMqJG
Content-Type: application/pgp-keys; name="OpenPGP_0xA6DF37692E5DE2F7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA6DF37692E5DE2F7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
v1dxvY4f2F5nhrZWkn5Rw95Qk2jIp0JB7GLzRSg=3D
=3Du6yb
-----END PGP PUBLIC KEY BLOCK-----

--------------RytaKy1fMypCEyBUKXqgMqJG--

--------------HVNfVVwZ91V0h7IY8bL1Q2bV--

--------------uUVz6NkmLsOWOeCGl5KtLHC8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEgTMgz/uZophfcP0Opt83aS5d4vcFAmJhXUsFAwAAAAAACgkQpt83aS5d4ves
ugwAjZXs4wEUTwq7S+ocLDgBQtxqnLgWq6ntCsa80C2Q16BHT/dYxqwobgemGXqd8RLX4XocCMpa
a+JBg5NGBQWK2ZMGI/Nk8cCOAK1PmJGQAdSM9Rz47DNDNzwCwI9Pzxaf7tK0dFB0DAbi5eUo0KqG
kvKCUTxXYkW3A+NZyB4WTu/EKemEHEGV4RiP8yuq8AEhqsLfqqcxaM6JM3JI2IQ+OSRY+nlOZAVL
YDYrbM2QJXJdazn4x4lquPft4KkVVq6MVa9JPVbJcQiNFReVmsPN2w6Yt6lIstNONqCGWVYtkXg9
aHLtYMaChCecQ8WXjEapqA0E+x6Ub9BVnbxUXDbMqoUydYeWThsL5iA93dQbM8pM+aw66cPSSXiZ
CMmMqf6kEse/PE1HNbBqvvQKN+5PTg37nGgWwGMWYFpdcU+5ogkC0JIWUhVh8rdj9beeaWU9U7OP
3dXsu+1ZoX/m9lCUHQ+1igI3uwnEpEH716DfQKW36Frg9RFZwZt3VW4RUr8a
=Oww+
-----END PGP SIGNATURE-----

--------------uUVz6NkmLsOWOeCGl5KtLHC8--
