Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A923C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 11:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhLTLFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 06:05:34 -0500
Received: from mout.web.de ([212.227.17.11]:49885 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231492AbhLTLFe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 06:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1639998320;
        bh=36PtjOsrhfp1CA7LUqmmSz+cWAYo0mZUGFLKKfsDqRA=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=QhaPp0HQZzcxKqH8EhCmqhpDXS0a4s2a7tnySR/Yq8lfBxxfXfYmmI0KSbDXtmIte
         O48irbte64HvGA6qKbRfLjimwtWW2PiKCkXcNeOcwBGkyMDI7EuwfI+PCl2e4lHzUK
         rjR3ri9pe7Joi3LrEiJ8ciLMkewcWYX7l6v1wtCQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoeY7-1mfrxJ0oC9-00otFx; Mon, 20
 Dec 2021 12:05:20 +0100
Message-ID: <f22f978a-26eb-8fe9-cab4-3fd60df69635@web.de>
Date:   Mon, 20 Dec 2021 12:05:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Johannes Altmanninger <aclopte@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH RESEND] t/perf: do not run tests in user's $SHELL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Iz1fWbh5XsjBVNnF5uXd4FbKASyL5R8pVSesJ0cHFGgSm3/ugIJ
 Zzk6+qGO3yQOIhTe65f7RVP491ylrK8bC5PLH7Y3hYaeNsEEeVnx0dGUyRZaQcemjlOQTdF
 bkaJICTOr7AGLxDms1sUKc63Yi3Btyo8kcsfzgmRNP/x5uPKnN03fjvla44JTuzSi71+j6W
 SJLb5j2aSyPCdpY3kZUuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eCnjrB3IaO4=:9QVx2IOsfwkwlpc3NO7Dpm
 VV68+31+tpF9Q3a6tqhNCavoLmw9dfIdMb3WArAeACljoOhMja39Q+Gk3XFuS6K+oKm8x/6co
 YcWxe9qMGi6A9o8CYwtzlnUoWa8kf60YVZx+E0O/MLaomZEU7NUYOphQ+ofEYW52D5wPVtP9x
 DgWgypvj1eZ7+hYh+3ESBXjJvyVa8ozIlze1SKTmx5LiOGQcvrCNYILIaX1QOt44vRoLa9r5e
 LeJE+hIAgeySWEEsB4AtH3NYOOBjbNtlexZbqWV9QUlEFL2DGx06vZQNBHvk78euEPT5R/Nzb
 0K8dsT2J2248//1dBTzhX64eMCup+coBdJ23BTAQNk/zGLexEMO84LxXOu017f3Oy5BkkiSHY
 TlwL2AHUYRLX755EbFdzbghSPETLEPC/AmLrEv5Tct2Zpouwx0LJWxVzT99bsxb14UgKPNO/1
 Db83HDEsrwv4s9JpDWZV1E3Z8APHdlrNX01hERiYjGh01UsKWihuTc1yO6/H6vuWktXT8gE2a
 4/Bd5HgVUofVsXY6DbrQXGcaDUh077XYTngCNJYaT3IcjS5iHINAcmzWbi4ASf3UYm5vrY4xE
 3J7wPnN8tefGIFJn5EwkdjhhucfLJwfkfNlRFN9rtG73+pmIDpP9bmhf6gIdQZACP/kVJ9KWO
 vnEUj+9KM4g92V297fTB/NV25WdpLjmgOAnLsEEjxM008E9+wglX73bCQQ2EfX9rBlIDKBbZ8
 0GxnBobWJsFhfAQY7uW41EU//crW/IxgE6AoAzmOldONg59ybqDhylYsO6/2/wTX2jmcceq9f
 mEfPKi8BUtP9AWLKyEZwmyza3jbJoRjcQr+eY/fl7f3MJCtaeVV8pGQ4CFt0AUgPxcLDYMJC+
 ydkR4WcyOM7J+HU/+SXoHirbKwOYau2ZgEpNvz4yC/L9o98C7LOveeGowVcMbcYMwoyUgmYOI
 XtYxmpC9TVro9keA1P2065GrwR1Zi0ZAK3kIFGDpMoG115bB2dhtLkTNKRFn3ngmlv6oXbzjD
 e+S3b8t5LsOriL4CD6fB4MzVpDsQYZGqbcim8P7wTg3dpHPuV3X96jE94VfriiAKjQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Altmanninger <aclopte@gmail.com>

The environment variable $SHELL is usually set to the user's
interactive shell. We never use that shell for build and test scripts
because it might not be a POSIX shell.

Perf tests are run inside $SHELL via a wrapper defined in
t/perf/perf-lib.sh. Use $TEST_SHELL_PATH like elsewhere.

Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
Acked-by: Jeff King <peff@peff.net>
=2D--
Original submission:
https://lore.kernel.org/git/20211007184716.1187677-1-aclopte@gmail.com/

 t/perf/perf-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 780a7402d5..407252bac7 100644
=2D-- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -161,7 +161,7 @@ test_run_perf_ () {
 	test_cleanup=3D:
 	test_export_=3D"test_cleanup"
 	export test_cleanup test_export_
-	"$GTIME" -f "%E %U %S" -o test_time.$i "$SHELL" -c '
+	"$GTIME" -f "%E %U %S" -o test_time.$i "$TEST_SHELL_PATH" -c '
 . '"$TEST_DIRECTORY"/test-lib-functions.sh'
 test_export () {
 	test_export_=3D"$test_export_ $*"
=2D-
2.34.0
