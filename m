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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8B9C63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 22:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 460C02463D
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 22:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ILNdFcU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgKQV75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:59:57 -0500
Received: from mout.web.de ([212.227.17.12]:36103 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgKQV75 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605650390;
        bh=LhLBnSIXYPEkmacKyTdnGVs8AKFfXy06pHpoMht+Evw=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=ILNdFcU7QJX50N8dfMU4PdSkXDtZMLNFGZokjEMgr1PmY0Vck6PKpXvTL5ZJspy5V
         KKT+6tQErtLrm4w+pjLsKFDDuzrcqMwnJIV0Wau+3AQy98uT56ZgYrNJHAAhm4ia5h
         zWhR90x1CsYr5fhIdlbuyNDFPtobpDEfITjSn/Lc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnpKq-1jvgzM0RgY-00pT8G; Tue, 17
 Nov 2020 22:59:50 +0100
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] gc: fix cast in compare_tasks_by_selection()
Message-ID: <d80423b7-c89d-99a2-ce49-8308822f7769@web.de>
Date:   Tue, 17 Nov 2020 22:59:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lH48AjgLJ7j/9acm9eOjbd7wJPJaXz1Oc+2zlpmcpVp4LcENW4x
 fLAkF5mf+fd8pfb/ogoqxjivcDuYCD+yWpFZseJ2sVAqrcX2n4I2Pp2WzyUKDtR/EyQpisl
 tBvQ+H4hLH4c69P9BiK4iroBFNsjhdALtJmq4nURPkTcx2DnjL/hkaXtAaOVCd0IyODr8tF
 LsFyiheQWy4baPtHvneCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PsIFgNL9/vY=:aa360S2L9hI7vTLuZjOGmo
 1sD5ZbaSOSmxmaMieSyLbjmFOoWt94WwFUIhGR3VRjbRhyNIVUaBxWSJsFcAWkXab9MaNqjIn
 juLNOPQnvc9fC9MV9GK7UZ15eWTEkL14bAGNUBlEw0rT6SOj+0jRoTDjCadGqB0q85+4N+v/a
 E2pNj5bTFWc55R4alIs5AJQLOY3Sh165m75mEilwMdiZu5AEgxVyFgAFRh2AZbeKCplr3z2WF
 CqkGZdxlvdKENrAqXYRYqK5Pv1v8yqxSYMC0ASuqtx8Vc5Ws0MKlJ+oGmjwW8baVP2B4FW4gz
 937nhnxt277RyRfW1OwgSjSRIJWoFar0T/oVOriOSy/jo6cnUri3Md0AaLuQX6/XHSOsxFnbT
 85lIdhG9kW3ZNh1oOoBXCE7dNysN+c5IrBGYtzIgVNk2yQm6KM823I+CDYBp7hAQigRhx4hZ9
 TPIPtnhsF+onK9jXU5yJ3kAByCQrEVSqn9QM/9foAHMWP2NwrDgAekxfFPVu8bleBzAqchY2A
 mV+cH6khIcs7HG0iYP1Uex8uFZnwpb9EZ+1eagwxBY/ScytMVkod86Y+gGG/ALuk8Tt5V00+B
 mZ8hp40l2aZslx+jBPo+LGS6H5r6yM9T2Zf+sY2wWklDJzdLYz5Ei2fcV8Qpz/V6ABSTyYj03
 9kQDCI3inalUQxHEUSE6B4YTTD7s+GYMu27WgVSJiBvrjoj+fYtgHqfBKe43V6zZt+CwEXWTk
 NfrIaMUJ6muCQbZpUKxLADntHKfeUG2m+1zOyp3nQmmb1iX6iSHdS8kI2J8eBPnYzNo3p5ZOT
 n4hxk8FytXsnSSdmFVZ0eRnXQD8sb/Gk+1Px1UuGhGKST3oPfh9rXU7wHPA8qI58An7JTzx/1
 CNJD9nomJI9lgWzvI+PQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

compare_tasks_by_selection() is used with QSORT and gets passed pointers
to the elements of "static struct maintenance_task tasks[]".  It casts
the *addresses* of these passed pointers to element pointers, though,
and thus effectively compares some unrelated values from the stack.  Fix
the casts to actually compare array elements.

Detected by USan (make SANITIZE=3Dundefined test).

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/gc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 5cd2a43f9f..986b760b30 100644
=2D-- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1213,10 +1213,8 @@ static struct maintenance_task tasks[] =3D {

 static int compare_tasks_by_selection(const void *a_, const void *b_)
 {
-	const struct maintenance_task *a, *b;
-
-	a =3D (const struct maintenance_task *)&a_;
-	b =3D (const struct maintenance_task *)&b_;
+	const struct maintenance_task *a =3D a_;
+	const struct maintenance_task *b =3D b_;

 	return b->selected_order - a->selected_order;
 }
=2D-
2.29.2
