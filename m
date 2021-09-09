Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84185C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E74061131
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347460AbhIIVrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 17:47:09 -0400
Received: from mout.web.de ([212.227.15.3]:37249 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345868AbhIIVrI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 17:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631223952;
        bh=rxwjtceI1+GesFKUTJQs9ZyuEh6Yz+MNNUAPNry9E/U=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=dNw+Npwg/NKwyQiTE1iZQ4Rq5Vlsrc7P6no0PHah8+Zd0BWsIpMi0sQ3cg0VSanqC
         5QMNSVUcO+MMAwhs3sdRZocx7w0TuA6p1WSVvX6rSGeN1DyEUtXoGuKPn7xdu7FklK
         Zog8EAhFgA+Y62fU95mUKEbKjyShS6NtZBCvOARQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0M7sga-1nAnGR3YDw-00vS4R; Thu, 09 Sep 2021 23:45:51 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] refs/files-backend: remove unused open mode parameter
Message-ID: <ea424e3d-6269-f50d-1a4a-643bb95cfa12@web.de>
Date:   Thu, 9 Sep 2021 23:45:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4ETcY3kD7Lzd4CpZkGHsGwv38TCFaOAnzPFHNnLvg2FhS0MO504
 //jWT0O0w2+GJk0TQhF9C6fm7pqtMg5WIvBmB0jKCNrJPKqKWRETYXBjeymD+a0wJ9kn//r
 UeSeg4kaH5JwRk6SRrz7m656yEAf8kiiH+o55WhRwO+9AksoFllsILiRknxXpQTUI2lUgQE
 WLgiiNaqbqYKg6UVDniOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d0L/yfgygow=:zXPzWrh1kGmehQUKmiqwQk
 +QVwF4QRx9p+R0hKH2l64eGrZtZdrw8CZx147fGGvoTeIy8SaVL+XhHaI2qyDYtXKxwLxFoj5
 V1DFSIkt/egIxvg97ar3HA6k5DqmEGMCWgE3P+1hAsDARrUPf85Ch4dyiCXl02pPjte39p/T0
 P2v3dBNEgYvW/JYoIWOJ8cKDyounub/coi011/OpUWixg6ZeSLCSU17PHQjShpKO1bB3OVzh7
 lJK02ZYsBt7AfJrG8BBn4kJgbuwcFF6AzP8sa/txwutkH76s8EGvDxJEU1IlDLs/+1DfoXL2Q
 /9ltzzF7sXlyFmzAV8s0aHqOylGZtYCj/oy7oCT9hJpLDUsudC8Pu+BUqirIfSebyMYuauVIK
 06uz1XzGn2xqRh1Q2YznjvDzUO6w/pKBU/AzjA+/Py6fb/JtAZbGnf5utfokm6aarnn7FInfs
 tv6RuEbWTOFRrxAoh6FsO5q8LPoNLnV29yoTh15yXCxcVspYLP/aQUbcROaHooe/8x8orOZ8D
 PTINRTunVd/3ez7W5rTHzB5WIhjf1j29aftUcqQU/6IefwMKytyVLQCWUSdzV1feKNaPTG25o
 Jd/UQXy5rIjJZffrSqsN90e3Z2Gbf73kd88s5Jlc/hB802Q7jhYJgKGDqwwbl0tb3Leud8zE7
 9lTZjwr+fuP1DWgY0QFz0rzP/s6Tb90aefm5CTTb04E1pLEZ2fPulNRrAfwp2y8qt4mCZ3Hd9
 hcrDgko5cbjrZaeVxYd5/dMz9xaIy/0DK1MvdCjmbjxtXLjo8i9PYvMBTHwxtSI6wXh9qZ8jO
 snsBg09Jl4kmf1gQbAJlWu2tMOupqn1VbeWeyREiPmauYXgghGWINscWTLCcy+r2mqqtNXrHi
 W+idHQkUF2OGiYHTCoc8A6R8qsN1Y8l4Hv7fn7Tt25zaE7kGfdFhEAhTamCXMUrq3dgcBanDg
 /tAj3hit/QEpqdj60LpsGkaNVtQ4WlYoHXciRYzVEU4KuoXELhd36KQENsbydRf4SmtYHceL8
 vNeimSEhGP6ots5tsippfbA11sBYgdwoVB1uyfbzBR03IGm89NEAvz4E7L4tf+CHIQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We only need to provide a mode if we are willing to let open(2) create
the file, which is not the case here, so drop the unnecessary parameter.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 677b7e4cdd..74c0385873 100644
=2D-- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1569,7 +1569,7 @@ static int log_ref_setup(struct files_ref_store *ref=
s,
 			goto error;
 		}
 	} else {
-		*logfd =3D open(logfile, O_APPEND | O_WRONLY, 0666);
+		*logfd =3D open(logfile, O_APPEND | O_WRONLY);
 		if (*logfd < 0) {
 			if (errno =3D=3D ENOENT || errno =3D=3D EISDIR) {
 				/*
=2D-
2.33.0
