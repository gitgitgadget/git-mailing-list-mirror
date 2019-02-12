Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4961F453
	for <e@80x24.org>; Tue, 12 Feb 2019 17:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfBLReA (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 12:34:00 -0500
Received: from mout.web.de ([212.227.15.3]:46703 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731220AbfBLRd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 12:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1549992822;
        bh=Nhklkzi5QYEmtLeGfHLdPM0FsEQaYpYKwHZovqBQptc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ksFWjUU1gqS1Yx/Vu8JxTlgEV56wFGOXK3WKFnn2w9cM1GrGrYpFKVKruQI/xFw2D
         dozEoo/P9SVCAGpR5TF0jNr79t8I3vbyPmIrzHS2Y2msL/LqDDy+PToJKyoFPEbk6S
         +yuYArF0/l+ITvM85Uglh3sv+3V/u2HJwOatVcRs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([79.237.250.190]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqlRS-1hWoMu0IcM-00eP78; Tue, 12
 Feb 2019 18:33:42 +0100
Subject: Re: [PATCH 24/31] archive-tar: make hash size independent
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
 <20190212012256.1005924-25-sandals@crustytoothpaste.net>
 <2a6cf99a-c297-225c-b3c9-c30e1ac83948@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2e0ab97b-2a9f-6820-46fa-ba664c42cd87@web.de>
Date:   Tue, 12 Feb 2019 18:33:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <2a6cf99a-c297-225c-b3c9-c30e1ac83948@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qKR6gw805LI0GPZRYKNk4WdaCwfDxp0CigEp5n4X2QPGZ7Bk6n5
 9Y71XCs96BZrIVkkIEWBvx4jKGCY7JsyHIT6FArJtc77HhGEoMtJBi3HP28CCycYDrICOF7
 kEqq1KLMtvjGhp2wFNIdJXdQ4khVCog/Kthis3WvJ2eF/Kj+UJTxPw3q9XOILLw53uTuaSw
 Rw506t13T8qHbwfILdwzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mLl59yYYplQ=:F/HQV7MpiRxDZCNtQR5q7S
 iqIfdmne1U4poGw2ObwchoaMdyx28/ihoGoCyYu/WJx4LrOa172eiIEoa9+rPQJM5K+l7onx5
 NJyJGzS5j1nUKHFyWDe7GWRt+izM/amQ+OziMYv/0971kcJOEltv0SsYEMdv2LTvLW9c78gdt
 at4nV/bMswc/QQXByn5Lg0CqWdmkOfeYSFcIhoklNS3DrIx7g6QXGx8E8GKFCjtCWF0EkRZnB
 oZ5g88cn72dsc56SXym2YKl2SLQiYcZo7zRaPKOdru9WwRftfjbOKj/KVgta0wf3cbp6wb9fo
 8idOvfxT5WwxyciLyqSTSmyEBPrh5aZQC+qAve9+N9iawOhWixyExItKbxr9+FxnErFfSoV8F
 mhu6hLF4mWUfMw6FTse+jT0uo5nRgRoX/oAqrf8Or1z4WdOuT5MEBkA7NT66YewRrnlCB2pZP
 TsqBJZp7eh9fMoArFtXMSRuDCeSOKpGhn5AscZCKAzrCKuLbF7fcBFguki/UNnjhYAE97OEN1
 uCprWFMqV0/lfR0AtYWcjNceRSTC2yvES+FaG6mWRL5ZmDTXXMuOSLqzFV16OKXnrrYvAKujj
 yDRPPckjXTS0B0nRlKFeU19rXG+QSmkcCgwkG814hegMjYzjHcjDNkn58qbuQkbIBzC0B26iO
 a3DSwUpEhJz8nkyKO06BnWKwCqj1Yk2TGnj0udQVl898GhdsnBUk9S8RqrouGOyWEFJCjxso5
 auZqeYGxCyGxiwKflW9eDJBnvYq6GfNTZx3GOKt0Q/FJoT64qRNM05S0dRH8kpRQtvtflFt4F
 rhmc9CYgrrn0yotEsTOvOpytR5U2TmSRpSbJSJ48k10FJZtMne9wrk3XCNWd2fxfFxPcGzNlj
 6qadJH+q8ja8pIuc57kJAXEWKAe+PZJklsaW3rEnsBafjpCcQL5f8mDFmmglVx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.02.2019 um 08:20 schrieb Ren=C3=A9 Scharfe:
> That command currently prints the pax comment in tar archives if it
> looks like a SHA1 hash based on its length.  It should continue to do
> so, and _also_ show longer hashes.  Your change makes it _only_ show
> those longer hashes.
>
> So it could check for all known valid hash lengths in turn, or accept
> any payload length between 40 and the_hash_algo->hexsz, or loosen up
> totally and show comments of any length.

How about the following patch, as a preparation?

=2D- >8 --
From: Rene Scharfe <l.s.r@web.de>
Subject: [PATCH] get-tar-commit-id: parse comment record

Parse pax comment records properly and get rid of magic numbers for
acceptable comment length.  This simplifies a later change to handle
longer hashes.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
=2D--
 builtin/get-tar-commit-id.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 2706fcfaf2..312e44ed05 100644
=2D-- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -21,6 +21,8 @@ int cmd_get_tar_commit_id(int argc, const char **argv, c=
onst char *prefix)
 	char *content =3D buffer + RECORDSIZE;
 	const char *comment;
 	ssize_t n;
+	long len;
+	char *end;

 	if (argc !=3D 1)
 		usage(builtin_get_tar_commit_id_usage);
@@ -32,10 +34,17 @@ int cmd_get_tar_commit_id(int argc, const char **argv,=
 const char *prefix)
 		die_errno("git get-tar-commit-id: EOF before reading tar header");
 	if (header->typeflag[0] !=3D 'g')
 		return 1;
-	if (!skip_prefix(content, "52 comment=3D", &comment))
+
+	len =3D strtol(content, &end, 10);
+	if (errno =3D=3D ERANGE || end =3D=3D content || len < 0)
+		return 1;
+	if (!skip_prefix(end, " comment=3D", &comment))
+		return 1;
+	len -=3D comment - content;
+	if (len !=3D GIT_SHA1_HEXSZ + 1)
 		return 1;

-	if (write_in_full(1, comment, 41) < 0)
+	if (write_in_full(1, comment, len) < 0)
 		die_errno("git get-tar-commit-id: write error");

 	return 0;
=2D-
2.20.1
