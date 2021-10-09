Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7F8C433EF
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 14:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B0C60F44
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 14:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbhJIOl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 10:41:27 -0400
Received: from mout.web.de ([212.227.17.12]:54359 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233850AbhJIOl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 10:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633790365;
        bh=akWAJkHUVdNW6eU5G0dTjSqbFWLE8c2Czkzwp1Iusaw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nl0BXb4np0tu1nxXAf+FLPU28Tx9ef1bVtNosu1fJOsjHmFDfsJ05j7Zc/ndJfiM5
         e/S393y9u5jkN8e55i/uBj4/J3l2s2HCspsA9rwTN3MfvtvfA2JQ7LZXMTwwbDQsmm
         s6mBXewLxgv5kyQxIgZPfsmHYloXYcwxnitT9BYs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1McIkg-1nBZWj14ZA-00d0ul; Sat, 09 Oct 2021 16:39:25 +0200
Subject: [PATCH] perf: disable automatic housekeeping
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
References: <b25ac1cc-8e77-17e6-602a-b289c1e1cfeb@web.de>
 <30df5e39-3f2a-00d8-541b-347c43f36b38@gmail.com>
 <581663a7-9b16-e464-ada7-368f20c99ff1@web.de> <xmqqsfxersvy.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ba3e16f7-bf9c-c5f3-4c0d-8288db6f44c7@web.de>
Date:   Sat, 9 Oct 2021 16:39:24 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqsfxersvy.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e4273xSS+WSxirvB0y9MAd/U0W2+ADjlTNvpELblD9CQekuUeuj
 /XspQlwcGIBHLwEAncaGVID4wiEQJ4UO3vWKWfxOGC6WWGYxlDcE0txgU7yDIk+TW3FrBFZ
 t9ULc7RuHPxKp0BiBH0b3PxfPAlR2+oZQm+VkJWkgX6diPFnTMxxkJodLx/SrmYJWOG605v
 qUooQV+b3PzZ8xkPu//Xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6or7G2kBkmI=:+k9jTmny1H1Emqi4hCm7YK
 11CW+EyBV+Z/u4TKMNH4V1zGEjoSMhek3eCQ/KK4W6A3a6Y+a2h73IyspbwyQVNvMZWnJlHZp
 jwZUCs/MkmoFMccOICFo4gz7CzR8R2V6EbMh3Ioem384nt/oW/6Zl7wHJzGeOQVwhUcCaxEB5
 g11/raYWg9fzsJdpbV5PRT8HHDNQHnKSY+gdUh6apF9WQFKWyZlYwNpKPpb7rQS8fCdPXhkhz
 GHznko7LaaHi6FiWmXaAeAwADA4S/SIta3fR83vyuRVznw/bhmqmIznwt/43iSk1tVLwOYyOT
 tZn6TRn/ym6KzqQxBHM5tGmR0cn1gfjwLGwJIZFnDmVizzeaQ62MBZEYzjllRMHQ7vHLLDyh4
 g3cpqOt/DYXLEF/vTWq/NP2tl9TRwONdpoVzgMDc4lKX+6Nig123teVhtRHeybmHJ1OsNjhRX
 yZQ6k3L2xSlIlVuv/QXFroDvP/et4kcXJj1XA+GXsZTTOqD3r+ywvmOVsTXhoHBI3hOShKTkY
 7rj6GRu614G7tMNlJIv9yMfqCO3AwPVr4njTuTlP6AcFoI9Sa3cmOmGHVmHevNPlWPBQysKYM
 LFmc8pX4oVav4G1f2Vmo5+ARkqdiwkwroldkIBJ2lKHJ3xq6NO9nYGKS3gj2WKh8yrVuJBrSs
 Nolg92X5XHZUt08IIF2w9pErdSEXgiH2QuOTBoQ9GQ3fXRBfuTRXlDtf4SCb+SVI8+Q6pqh05
 i3jfKckCOsLNhTNuDwS/Hv9Gy6idkOuF5qWcUh2IyPPaGKq0ygRzbO8QjwCzumnPyAE7fi3j3
 EhK9G61D9otfsnPbCy43ECaO/E0oOMbdM+4e6zUTSp9yN1U7OLUjXh8L6YgVQ3kGH7GMU767x
 jWh7whZYP8mSMqGpHBa2bQOqV0LW94c+MpOpILMwiHz7Gc5F4/2nsje9zwTG3m3BC8Ra0mL0b
 P1TZxxCk0WFcr54eKYK7ANXxeR0JCPDKnFC8xf+AWJbMsoMGQcCrLvoO+T4b/pi91kOnltHHz
 0YYxpxe3R5GItOFQercTsEAud9nRQneoYBcftNAWI+fkSc8mdyYE8OWYeVcmZl8Glw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turn off automatic background maintenance for perf tests by default to
avoid interference with performance measurements.  Do that by using the
new file t/perf/config and using it as the system config file for perf
tests.  Future tests intended to measure gc performance can override
the setting locally or call "git gc" explicitly.

This fixes a breakage in p2000 caused by gc automatically emptying the
reflog due its fake dates from 2005 being older than 90 days.

Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/perf/config      | 2 ++
 t/perf/perf-lib.sh | 4 ++++
 2 files changed, 6 insertions(+)
 create mode 100644 t/perf/config

diff --git a/t/perf/config b/t/perf/config
new file mode 100644
index 0000000000..b92768b039
=2D-- /dev/null
+++ b/t/perf/config
@@ -0,0 +1,2 @@
+[gc]
+	auto =3D 0
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index f74cfd35d6..4c4c568a37 100644
=2D-- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -27,6 +27,10 @@ TEST_NO_MALLOC_CHECK=3Dt

 . ../test-lib.sh

+unset GIT_CONFIG_NOSYSTEM
+GIT_CONFIG_SYSTEM=3D"$TEST_DIRECTORY/perf/config"
+export GIT_CONFIG_SYSTEM
+
 if test -n "$GIT_TEST_INSTALLED" -a -z "$PERF_SET_GIT_TEST_INSTALLED"
 then
 	error "Do not use GIT_TEST_INSTALLED with the perf tests.
=2D-
2.33.0
