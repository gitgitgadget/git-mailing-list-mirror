Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C8FC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 17:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJDRm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 13:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJDRmz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 13:42:55 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC8C265E
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664905360; bh=2uD2KNjAWt4unKI+04Ee7wRwoqng5WNkADCQtpAMBW4=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc;
        b=WpFQPpXX9D5r8mDX/HGcCLDSdZ7lAokLm2C+RYOukrurkrbq2TL6i8l51tSrQ1ZBh
         IPzQcTYOKcLEiuM3cWi/CwtYwPQ5xTXYE36oghBWrYcthLGyiPt7IFVrV5c9/VGwSA
         +wKANcZcGnqbXdiskMyNTBx/cGCUA7B2fZomC0CGL8porxJwjGRna09cvXA1MCoJ4V
         xSAoQSRgtcnSpbV5A3xHY0GdDYhHfU2iSTaGFot4yZZpypuvrvPN7pC17SdxjVLXPb
         Xp8A4vdL+sDX+HvwCUbgaP/grvpxY2eMpfOI7GB+TJVMZjar1Dqw3JAr+Riruon0/x
         i/V0yG99EJZgw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.26.45]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M76bV-1oYteJ39TD-008Rsj; Tue, 04
 Oct 2022 19:42:40 +0200
Message-ID: <3b370f7b-df84-0629-d334-aa9dfbca1c05@web.de>
Date:   Tue, 4 Oct 2022 19:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t/lib-httpd: pass LANG to Apache
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+Pcteczo5gSs4grsfx403O0mbrwog+MVPuxk2sYAd2AbPYJQ9zU
 VSFnw+NgtKD9WS9kt9qusIs/XpTjf1BRnInq17BjxWrcLEd/zPerwpaU1aGX4tagUaP306X
 QeT8Drt2Ki/jtk+VaT9VZAFzmJtZk+9pLlC4GzP4qaNEUW3M2514UrdErihFv29HmEb9HZN
 9MCFeq+ls6XvGol4bDu7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GKlrroazysw=:6Rp9fFeLZM/+0RuzT9NVH+
 dvrRKHytFegsFlHtHH2oO1Uk0ksfogx0R/1GQhfjFKvnIGrYr6Y7dc3Vi/slqRmQw4O5sJDix
 rbV1t8CyTYj/HATUWUzdWu4X0vbZHka7WDgx8CRSlno1mpNKCAfsfDANqMVVR4SFusIXeczPA
 E2yPpIQGGxAfVpA/3vrLlI9aPjIJvTJg8Aj/sU2+EvlaMQstmVcPlF90m7ecOf9NgGrgtMjnJ
 GW3fv8M0mwMTUweO8wzYS7f8fwx5qGGG/rU+KPuN+RfPbwkOJR43X8vZekuWownznSNxw84NZ
 L7DbbRvpMkufC20I/HqMfqnyZXNwp2gqHIjg4Vv52nEEBp1wZt3LiRRBf9f3d9Dj+Etnu6NyJ
 8TO+iebr9sKXBAkF9LReBwev7QW/cCyiV8pT1BdUhTjJ9mvR6vcAUX8GxxaNsMURpb2peDlcv
 0hu9xR8cWmy4iIgjtpysTwCum2Ay8v2ltpeynuDC+gpUC0NxJjTgW3Vd23P6ya1qxt5xpXfNl
 2lxDp9IW2skdxBApKLYeOUUfeG0XaWL7NaPvs8YQpuJViL0WYjZU53CWNgV7CoYlpQGHOLrSP
 JGuMoTq2jlD/PGXryIG9plLtM5PUUuu/z/M9NMV/5jmOknZOLdtGAfAaKJafVKVlUue5ikab9
 5XR3VHuu7R2PL3W5li9hfpwxARJrt3+J0Bug3YT/fgfdxgCgpl5BJ+CwAYRIkFHLoOEPdReSS
 suBifxOgxqM5ZJVmy8ZGH9HyKm8LDnb0dXpepk92TFOcMivCPLYxVU2EiTwloqJo8EUWiQ1TW
 WDzOlLS4/kq0W3JzhBXgjtG4GYMFGk/Wigpz90zsu1RTwp2ekvVueQBzJhF9z+l7qGBT6wGxk
 nQenaAJ9kIJ7J0CNfYg2EDTASKPdBluv4ZDCzns/GXWVoQ4rQjQCNlPImTLzAGowVD2LoKzqf
 j7fakaVlj06xwM+AWTAzQ22epOZ4741xeF0PkX/JkLoqOtxJCoHIMNE0U7M2fvEl0b5CcnERn
 nD0n8ZB7b4GrJBEi0s1+YqNXSzknInJkLWXr6BXmyUfS1lBx9ZY+ug7efvUPIAwO9mwkWW+tI
 2U7s+P8Jw+NElULWLQOAUcRZaVpp3XDcA89KKWjoL4uWzKZBrsB12y8GVt75pyeInc9Y+JsGQ
 4IgMw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t5411 starts a web server with no explicit language setting, so it uses
the system default.  Ten of its tests expect it to return error messages
containing the prefix "fatal: ", emitted by die().  This prefix can be
localized since a1fd2cf8cd (i18n: mark message helpers prefix for
translation, 2022-06-21), however.  As a result these ten tests break
for me on a system with LANG=3D"de_DE.UTF-8" because the web server sends
localized messages with "Schwerwiegend: " instead of "fatal: ".

Fix these tests by passing LANG to the web server, which is set to "C"
by t/test-lib.sh, to get untranslated messages on both sides.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/lib-httpd/apache.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 497b9b9d92..1e2295a7cb 100644
=2D-- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -80,6 +80,7 @@ PassEnv LSAN_OPTIONS
 PassEnv GIT_TRACE
 PassEnv GIT_CONFIG_NOSYSTEM
 PassEnv GIT_TEST_SIDEBAND_ALL
+PassEnv LANG

 Alias /dumb/ www/
 Alias /auth/dumb/ www/auth/dumb/
=2D-
2.37.3
