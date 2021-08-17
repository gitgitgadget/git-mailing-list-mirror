Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5572C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 14:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A9060F22
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 14:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbhHQOfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 10:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbhHQOf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 10:35:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB7C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 07:34:54 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f11so27913228ioj.3
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 07:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PIkcZ0v4wMSr775b23sSgiylk3dTytnh76kknsGXWG8=;
        b=ubE5S4KSSY2y2i2qQmKE6qYEBKz/kY3V2ZU8/bWHuULGCGC2TxvEQHxiP3I/ioVaiC
         eXSjPIy70G7Len0ake2fJT0zo6IVBmaI0sqEXNSv/9/S74bJ9Sqo2Cv6doOYJOQNWrcp
         d6f7e1VSHz7v//M/VX6g+MTh9cx/C5EOSPViVGSqmsMstff+4DwHOPe54GEzXYObOoTA
         rzHRfuomW5lCdTLbkofA5WWuAa3Bpg/GQ54t2GXF+RiML6ukJydAg6I+4XQATK2Fh245
         jHa/joXTUUUCZAJ5EAez7I2836+3uVvim0LrTr9jHSq8hVG6IDoYTV5PU8eBzvnHZOoZ
         XYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PIkcZ0v4wMSr775b23sSgiylk3dTytnh76kknsGXWG8=;
        b=Y2mPPbg/3WucfDeil/ReB5qMOJlgRxWSdaQJE+whtlxWdn64GsiTKACVuVx2YNdmYG
         Aegxd92LdK8ZpgDbS1U/r6pAND+D5jAQL/lcucNA2BWxNuC3xRVjJEEW/rq4vy/IHp50
         2VZ2bBZ8GDJOcX+q3mZUv7pV80z8TmqEnAaLytL+U/C8Lg+GzdSNfTvSOamW7IhBZObw
         Vvuyvv0nOpqkTcA4kFwGEtJgV2s4/NG7eoXwYBtLrrrFH6qwnm1I54Xyc7Vt9ttgAI8B
         bAEhmId0njG5L5P3tCQ53cUfWepvXWKygxpghkJzK1CeI2u4UjdAfloC0a4lFvpLXVAW
         bhOg==
X-Gm-Message-State: AOAM532jC1bmmDJAgTM0nk5ZhbPD6pP1+xVeuuS4ljApc/0zMcU8XoYv
        XmRRY2escn5FcYpP/ru1iZc9Y+51C4XFDRRw5pQcMH+P7cWLJ4ng
X-Google-Smtp-Source: ABdhPJyEUVCJ3frzBx3i9OQjMnSW6zORtTgPUv3NqJC/M4Ru+SYG1N7Eh5/SHgVTYT7IOri4C9ti1l1W930LpyOwmgU=
X-Received: by 2002:a05:6602:25da:: with SMTP id d26mr3132001iop.106.1629210893203;
 Tue, 17 Aug 2021 07:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
In-Reply-To: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 17 Aug 2021 22:34:42 +0800
Message-ID: <CAOLTT8QRrHp4OmCS7-sV481cMPK2nmVuiaQpqzv_cM5T0HKbRw@mail.gmail.com>
Subject: Fwd: [GSOC] [QUESTION] ref-filter: can %(raw) implement reuse oi.content?
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Because this email was accidentally sent to everyone=E2=80=99s mail
instead of CC everyone, so this email was re-sent again.

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

So can we reuse it? (Or can we free() it freely?)

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
