Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D34EC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 18:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701472075C
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 18:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Tw9uZ1cD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfKZSVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:21:47 -0500
Received: from mout.web.de ([212.227.15.4]:52217 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfKZSVr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 13:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574792501;
        bh=2vsKAJ4y8HJCwQLOJNDHxiIK4+Yf0LBl4giosfjIGNs=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Tw9uZ1cDQ+m3qPWFiNCx9gqmDeQpf9DCTgM7vp/ctqW1wgxtHqAkXRAW9rx2ulVJ5
         YJiQF4tgcVZlkrXEUerOB0+DtZCY5Dk+QQTNjlZBMGC1FOsW4DLSVjIkkCgOORxgfa
         ZAXvusf6nR+L9nipbECi3lUohlHgIsC5ayp+kWbg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSs2H-1iPNwG2tZV-00Rq2f; Tue, 26
 Nov 2019 19:21:41 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t1512: use test_line_count
Message-ID: <c926a7fd-71c4-269e-4352-207edddf85f2@web.de>
Date:   Tue, 26 Nov 2019 19:21:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Be+WDGzLppv0iMDasgLx+8aXCiliU7a0LLnPt00QumU16AujStS
 rnIoVXbIznzWY8a/qGy35mgsx095gb+Iy+cPIquNxOFHCjmzDToRVB8iQH73JSpVtZ1GyW5
 eU6gBGhNtqjbs8cy7lYpb8KSqcRRwaqPcoZf7lRN2/gESGfyONLkO+OaP1VzbFqsM322eD/
 kJVY6gdjyt9kK/z/rGUeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Z9UhrkoGPY=:RVa+tNozKG72HsTlmcHi/N
 ApOpcwGlQPMwD6ZWS/q+9IkbfEgwq8TDc14nvS5KO+7PY872wRMw7j36GbgYF7zaxmppDmA3v
 FwaEXnkZ1WSM0bJZ/VIJ16oAErffy0eACC4brJ8xI3gOEbIExKvk7s/TFekm7E9s0H7C2/GeA
 Um4zro4WFWtwf6jrkbl+QGUcEYg7+Ax9fWxKxAB6MNP/FX+GANdFV9VrhqAHvZBGkPq9TIvDx
 bJuCzFiavbKTCPVFNh69+UxQ3P/5TdMJRwEDIAFtYGvqhv6TP3BQuU/BZ4E2jfReBJBCRd40r
 v1k7ezHrpL0dym233TVU8MX4ErytSxuKD/s/4d0njuFpKPjoU7N3ytd2XCIpg3r73bQSHfkSm
 meWvdQYfLGS20HxJjKXIkn5B5YLi5NoMtyGZE6yqUXJALYd/EAFlGhByQB0OHdjtv0E6G8jCE
 gPv6Mk96ZDztmgY2z0qg/eQQvOABt6CmY8ONIfAMXUgxBgp4ftUhWfeGigsKpTJc7pIsZ/6k7
 YVQzYftyBGra82x23MFo1PCTUgBqWOlS8CdLgUip9C+XLI3WsU+6x9mI3RQJh3QD0mswyFBLz
 FWCCPedoYoD6IiqyoVIuwhya6+uBuV7xdKvCYf8RrCRhwrRyigiqKjghSsyqcQ8/+ccQFdQVY
 JCkE0tfpuh/FfRBS5IYvW+wBAMySFBn6hD+eNknZqpjmTvUDgSTY9PeoyCVtDHGspje9Y/Ql2
 d3XlPmYeJ7TWYbbqE+DVwcfUdOa58bzOqr+3+TIkLwGekMjASiSCRVQVz1VbeSWr2qhak6ror
 0OqdjNMchFYX+xNFPLawSrxAKErgyt65qvIgESn2w04pdpNeMCLr8dD9c380nnARl5dxOjqxt
 R7b6DOhUHowjwN6eKaf51V04jxA76jDTB2rAuIJEAu0BzFxBa91Oa9teBDH80tMFHwi2TMoei
 ySZAQEa1kqVRugz9vcucL+DMAAg1XtP9g7lZjSOrYpDfzo4aWwApSkroQ4qn/vyG4wPn7GkpM
 6Db5PGzJvgdGW28TBGHscfPDzjcqEI4xl0OnkpDG/y8JriKxAyhVZIx/4iImacaKaAFZGE5Nd
 BVJu5b+WQLiYd59Ab6m9ME+B84RKIohIe8F98ZF3uMOy9+RH20Wf5r3whL38J81K3WjDDu8p9
 Z8SKaZMAiH3ngxOqv1CmjhmDJGQBLF5Nt1Q/UR6sOcTFnoQMh/Z/XKjDomaHbXs3gyngT+vcH
 8s/LKPteXGwYvQNiEKeACG3NMIPvZTaHokSqDdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use test_line_count to check if the number of lines matches
expectations, for improved consistency and nicer debug output.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t1512-rev-parse-disambiguation.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disam=
biguation.sh
index c19fb500cb..f06b045edd 100755
=2D-- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -282,7 +282,7 @@ test_expect_success 'rev-parse --disambiguate' '
 	# commits created by commit-tree in earlier tests share a
 	# different prefix.
 	git rev-parse --disambiguate=3D000000000 >actual &&
-	test $(wc -l <actual) =3D 16 &&
+	test_line_count =3D 16 actual &&
 	test "$(sed -e "s/^\(.........\).*/\1/" actual | sort -u)" =3D 000000000
 '

=2D-
2.24.0
