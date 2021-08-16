Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF934C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 14:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19446113D
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 14:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhHPOCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhHPOBG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 10:01:06 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE06FC0613A4
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 07:00:34 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y3so18652799ilm.6
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TFrTmHpsciDFuT7Oi7tX87e+kqehukqqE0XM6d8smjY=;
        b=Yl08qLw/5Z37rBdHgW3jBXylr8Df+mJrEE5skIfvHu/05J2EmgG41//XgY1S4Uji8W
         2vrwoSsmFXnbehWcsKOFm0s6UuwqHH0OGtjB31nqISV78JOYryFYtF3T8JbT/c/l1Pwj
         EjVKCZoA72Vp0R5dLXddR3wcBi303jnaMaGOkPhYhwQ2WrCKUwLxgCZbkBZ2mo+fYzlu
         Qoz2UpBdYaDo6oK+9bL6msDqFkm8QuwLngNKvjJpR5Z8BQr3uOFIAXfc5VMyfxwpaX1D
         F5Z421L6k6SFgwLbdTI+1bkwwDz8MYBfLoIKeqn0kymKYdHFEEIuWJgAP5wraimx0ClJ
         XySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TFrTmHpsciDFuT7Oi7tX87e+kqehukqqE0XM6d8smjY=;
        b=SY2gZwnd3WW2ppmyy/8xEocwUuGJNyIeGCzAZqF1nblPCbPHZNUCrF1ZJDz6TmA16h
         Z2/1DUbX9tbkqqtWLoWe11StzujnT7PMu4fajCf1vWTaZzTn564GFYGLad6wK6uMJKyI
         iytTT8CZdRl31JYnfqanovoUMMhFx5dL1nOFcoqDJEFgjJkJYpW1M9ytit722tWYvg3P
         VqSaX6d7Aq4XFS3UdGor2OgVyT/P2wuJOgjfjoQ9RIxkiQiTrgVIpI0PwyQGLK7M+V8S
         jIbazR1oHDFSMvTalT9pGM+l50pFdxq9pDhSZrjLqA8iB3PdBeqeRFP8W4+uTRGn+BDs
         avpA==
X-Gm-Message-State: AOAM533peOwfHp2ZwBwM56Gv5exG/tiIMugVkmHR3MJ69v1Pzjzhv68a
        UfiSpVifeikQqs1lgTQog1DfAXXojRWeiGi+J5yW/vPbUHHTaHDG
X-Google-Smtp-Source: ABdhPJwGu82klNIro3DMePsgloJAlRaHHk3iQky3CX9BiwB5UJO7BDlV5pqUfR+Nd/ZphMoYNd4ajmoyEgJxEBhijqs=
X-Received: by 2002:a05:6e02:1ca8:: with SMTP id x8mr11403592ill.259.1629122434113;
 Mon, 16 Aug 2021 07:00:34 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 16 Aug 2021 22:00:22 +0800
Message-ID: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
Subject: [GSOC] [QUESTION] ref-filter: can %(raw) implement reuse oi.content?
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In the implementation of %(raw) atom
(bd0708c7 ref-filter: add %(raw) atom), we use xmemdupz()
to copy the content of the object. But if we can reuse the content
of the object?

Since git cat-file --batch needs to use ref-filter
as the backend, if the object buffer can be reused correctly here,
we can save a lot of copies and improve its performance by about 6%.

Tracing back to the source, the object buffer is allocated from
oid_object_info_extended(), but in parse_object_buffer() we may lose
the ownership of the buffer (maybe the buffer is eaten), but I browsed the
source code of for-each-ref.c or cat-file.c, and I don=E2=80=99t seem to fi=
nd that the
buffers which have been eaten are released by the program.

So can we reuse it?

This is what I want to do:

diff --git a/ref-filter.c b/ref-filter.c
index 93ce2a6ef2..1f6c1daabd 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1443,7 +1443,7 @@ static void grab_sub_body_contents(struct
atom_value *val, int deref, struct exp
                        unsigned long buf_size =3D data->size;

                        if (atom->u.raw_data.option =3D=3D RAW_BARE) {
-                               v->s =3D xmemdupz(buf, buf_size);
+                               v->s =3D buf;
                                v->s_size =3D buf_size;
                        } else if (atom->u.raw_data.option =3D=3D RAW_LENGT=
H) {
                                v->s =3D xstrfmt("%"PRIuMAX, (uintmax_t)buf=
_size);
@@ -1768,8 +1768,6 @@ static int get_object(struct ref_array_item
*ref, int deref, struct object **obj
        }

        grab_common_values(ref->value, deref, oi);
-       if (!eaten)
-               free(oi->content);
        return 0;
 }

Thanks.
--
ZheNing Hu
