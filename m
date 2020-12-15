Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F8EC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A9822ADC
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbgLORop (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 12:44:45 -0500
Received: from mout.web.de ([212.227.17.12]:44313 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731184AbgLORoe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 12:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1608054162;
        bh=+9XoA0KMbQfuGnQttLZQTMUs2NhXMhNOr8aF/XOghnE=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=WNuqVfEFvJSxyajqUoSq7G49n6ROcJQ6vYakh+pVvwdsZ3Q7TENL4Z/Yyq4qRE9kn
         MkKm/HeuQFkeTtV7sSINWezghcLRIB/NkLs99oHDpelT5zhgmbDjET/HTMwaiRhGtz
         biYZbJWBgEhPVB5e4OJEwOww73NeEknaskolqH4k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.0.3] ([91.8.26.16]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M91Lg-1kmSnT330Y-006Hw9 for
 <git@vger.kernel.org>; Tue, 15 Dec 2020 18:34:53 +0100
To:     git@vger.kernel.org
From:   "Daniel C. Klauer" <daniel.c.klauer@web.de>
Autocrypt: addr=daniel.c.klauer@web.de; prefer-encrypt=mutual; keydata=
 mQENBE4SVr4BCADAQ2AhDNA3gIPHz5n8PhtbcvD4GD6+Kg9xxPE6wPaTPmsGjXRJVyJL1fu9
 hIfBCxLAdEfygsMW+b6O7OojyRyaRYUBSXw2M7wfa9+yyqN9URXLShsiNG22YiGQWUhs4+Xj
 bbF8lORYM+1G8Sj3gu1bmVbGZ1kmAIMcwD82Lz9hny3wShDP/Wt+Td5+WcxzDlfdHoO8iEP7
 mOR9iAXYoy+P0CaAxJL65BNjXXocEwlmoX8EQL9/Z4hT13c2OoAEUDcGl8aP6bxqVh2fb8fo
 rw9HN2vkZZpjPk7BEhfkmM/oZgj4MAS1Dg+0jGa+AED1F0TI4HY59DbzouOY35+tq8OJABEB
 AAG0KURhbmllbCBDLiBLbGF1ZXIgPGRhbmllbC5jLmtsYXVlckB3ZWIuZGU+iQFVBBMBAgA/
 AhsjBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBLpkyNBKIMqMO+QbL8xpwz0WL/1wBQJf
 MdsGBQkahYXIAAoJEMxpwz0WL/1w330IAKBsBoHBOeG4ltpkquObVsSKBoKSKOMD7i3qj7Y7
 yzUC9PUJLVPEYYXhD9QSXySFZ9YWTp3C+lAxJIUJbt2/HlVHQOaeAcuuwhDiBpyhzk/ixIR6
 vMvsux1pW2JCrN5usQzlOOWbe9oSO6/pkd/TE7/oxFIPacQHHIkiPLuypL9v9NjIL4ebdCle
 BlOZfGlC/sKEnePKhS4SXIegdoHBK1kepNZ9Dj8pAaVDvDsC+ijT/ubIgaVqNRRWVNI2DbmN
 XXNV+A9dhF3eNpaEBu+Yf+HViDu4eVSGtopb5IyCfPOaJl3dxq4fPIDN9XoYI0xPHhTrLGfi
 7i7f7Cjw2IppMv65AQ0EThJWvgEIAL7mpt6tLNOKLQoHZs0wgGJgDYCm4KeGcS/UiWMZUl4E
 Zi2toUO8zkQiO0KjMIx4jKYEkJN51aU7dp6Ba9Z7L87yVfXmv3MdF/uCf2kqc577h7ZtSdrm
 gJsHNpMA98E7JUUCzhXLQsIpEbQsI/f2kokNbo+ONPWgdMp/90l6qOcP9vxITBf5CT3tekGI
 Voug6wKdl2e+5aStz3wpmBr523LOAZmHaMmRoDbVqejE4KUAeXQHOtGKMJAv2Ys7T8FPsLyK
 E6iG2CGC8IVfDYZT3DdZoTzSgy4BSWnpZYwZ5ELp61V4WQqFNGB5RH23CUYHwVCX798X6jgt
 we+ku75C8v0AEQEAAYkBPAQYAQIAJgIbDBYhBLpkyNBKIMqMO+QbL8xpwz0WL/1wBQJfMdsG
 BQkahYXIAAoJEMxpwz0WL/1wVngIAITLQyNEd/8pjTMa7th4fNbL/MBjGJqppMAkBLHsQCea
 OaReBSPXMTGJULmIHmxun30A/glAxR28knBJfghfroemTOEDEwVvqmuXX8LFFxfTBbOn1qkm
 l2R8zybpzUP/c7IyTFu5zBsRZ+9nCTynSZQBHSEOfJcterE2LhFlNDyIdE73kB3Tyu/o54Lr
 /I8YbVw63o7j5rQ2lKbT7xlTOekNZ428obVvXSZFlVYxnJPSb3l+UdCE9XhH4hAz3deQQ2Pr
 u3J2vR6+KIqSZqdgDzP++5rvu8UAS5txQq8N6TG6Of4kaA572FAq1GEXVIlUxFpU9hbTF0+K
 eDXLzZhp6a0=
Subject: bug report: "git pack-redundant --all" crash in minimize()
Message-ID: <dc410ef1-fc05-162e-ed4e-c843e0bc285d@web.de>
Date:   Tue, 15 Dec 2020 18:34:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:rif7CZVBam58ApcGVTX8M7R78SOvgBi4AlO530WHQausZfRihDM
 WZ6d8s3hPnqxvYgX3EHuejgO2QwJOwoEOWFkYAd3lx9Vlup3XCvdWF51ilB56BXMUKOxpqW
 dnzbFsme28EroKF/pDtLm6ohaXTzUdJfxtog7FV9Z2GaF4IvOJKPyineFIhyZ/BSre11ZOz
 yRf5bYEMpCMlx/R8Zit9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+NpKkhLyS0w=:b0fn+ITaQgidp2qo5aGQ63
 k6vsF67K3MOZQpuhFLf7i2W91FS6fuA/qrEbJMUQUDjMlDMTgBCDlOp6ZS/RIFqOQENB0M07P
 FI/rNBNa3g+Q0/6fM1rOy162vaWtljzus14X5IgcmzpY3nd8rwZSmVyNDCQZ8KVa+TrTf4sAM
 MX6Zv6DvfeVDy8nKm+E6+yPgFPGXDFoA122GgxGqr33bDZ6qAqvwcCO6S27SOXQjZBXPw+8H/
 j48I8EaXorc0VVPnBv+jJFkKFv4NeQqqe2cbYjdMMhhVDs5fiIOhS+h5fkExN/dd35KJnb6zb
 wFrgwWf0TScKdNdJBGPgHxMbkjmm8yZ0/uttMZ6J2b4KH2jzb88NEaEBQWj1sYJGtMCQqMV5p
 H8aYNbhqYcu3TPBSyBkQDp/WLh+zirQ29OyKVh84aME7dO0z+GSg1DIZ99KrmOrA19EoHMurK
 V1ssbVfWctUc0BFl+8cGcjdjijXPDmPwcfc3kYCUGXoqVAdMJXduxVMQLbCyCbbbWC/RDcsZb
 F0jGCq+RrTNKYzVKn6oiTFnDsifJbtOrissJnW9TQcsGe3v9ixU3ogWQHlhoUX46zB6STsgE+
 exSUnZiviA+QcRUonwOzbFmYIF6asAOEYZy8B/LN0I1Mj/+cfZdLEmD2g8efGF1JcrijaZJt6
 i09gM0au3wD3rWDBzA4B152G0iDXyF8lgXs1Md3T4jzIB3LPHiu3/ZAeaocEUGSdeFKCVzr6O
 +Z17R/kvvJp3dgYEo40XE+W+BUdUBTEjY1wcxZHoehA3iMWF6k7RtzGvKW/GFOHxrbvFKWV18
 zJQlv7Z0/WLEiIV645ThzkHscdchoK6gN2hVU55iQwEs3FlemlrXAp1jmWk2sEGY71qci3Ih9
 yKOH4DFS2SFIyi6/Y02w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm getting the following crash from "git pack-redundant --all" (output
from valgrind):

==14070== Invalid read of size 8
==14070==    at 0x18F165: minimize (pack-redundant.c:399)
==14070==    by 0x18F165: cmd_pack_redundant (pack-redundant.c:622)
==14070==    by 0x1242D3: run_builtin (git.c:444)
==14070==    by 0x1242D3: handle_builtin (git.c:674)
==14070==    by 0x125393: run_argv (git.c:741)
==14070==    by 0x125393: cmd_main (git.c:872)
==14070==    by 0x123E7D: main (common-main.c:52)
==14070==  Address 0x10 is not stack'd, malloc'd or (recently) free'd

Commands to reproduce:

mkdir new
cd new
git init
touch foo.txt
git add foo.txt
git commit -m "first commit"
git gc
git pack-redundant --all

The same happens with Ubuntu's git 2.25.1 as well as manually compiled
git 2.30.0.rc0 from current master.

The reason this showed up is that Yocto's build tool, bitbake, sometimes
invokes this git command on some of the repositories it downloaded. This
issue was apparently also reported here:
https://bugzilla.redhat.com/show_bug.cgi?id=1803506

Kind Regards,
Daniel
