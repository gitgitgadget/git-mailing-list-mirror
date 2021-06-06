Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497FEC47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 15:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3104560FE7
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 15:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFFPX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 11:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhFFPX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 11:23:27 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E89FC061766
        for <git@vger.kernel.org>; Sun,  6 Jun 2021 08:21:24 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b14so585679iow.13
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=pxvxbYUUedwhM/7WhpOj3QLiRkXwZO87QKMvYqHW0lU=;
        b=AlSJ8D3ZCnz1zUAz7KCgoHfAq75SWqa9Z3WPFovTE/ph4dcvUg4rQlZW9rgR5IDhVj
         YtnoT1X4PI9zhxqZzcMzus6O/rBdlH7eKlX1YUYxqIF831hxRm4Xa49EGbAbcLdoBrNi
         pjjHlwC18IGBUd4xI+4Gu2vqUurhvYgk2mBf0lmWRKEqPA/LUX10ZY+9MMh/5P+TP2Hv
         ZjU5/llABjwcU6QzAcOnLkaILAYK4cEn59ENMfzejBvZqomzebm7ohmaGkF3kAdyOX/F
         2isKfWFjFDraTg/GUIaY7ANYjkapmPe1bdUVj4ClqMQEvaoWnO5f1Kv5E/9rQFzQosHJ
         4ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=pxvxbYUUedwhM/7WhpOj3QLiRkXwZO87QKMvYqHW0lU=;
        b=mgPeERABoNQ/YqbmFCQoZwbDqm313tEkkNxd9m4qvbAhg9TiZxf/KF/FjbrOdL3Z5f
         4pgoIzlrbjNBxl7RfElB/wjyTYx+UPgPUUVxgicxWTmctZhQ0lxwU9gPXCPWNXItmQfD
         3qcGmlMDdNAnKNqYDhTeWD2sk50qTsOBuE4uZwhbRu79qCMPIFhh+JUncvRT6+nu0ybh
         JGtIWXEg9yn4g3wa+FhFMl2yffKBzvZwVxFVs9cJ2FCVpYSqZKGrGlv9NcPavqb1UY8/
         tD2yL90Hwk20b1taFrSMimw6VaQx3ST26Ef7ZeEVDFak5/O4xJBLCTNvPSzCj+IcUMzk
         6nvg==
X-Gm-Message-State: AOAM5311alxdINKp8piuCfxVFJNTM9pAVpvTTj9IXiwhLO8Tj7qEtzw3
        rslR8jPAPmvt33saUem6yYEFLqngBPbGZrBXvTkLlCXOokXZ7HxD
X-Google-Smtp-Source: ABdhPJzD81kkwLv5kT4Ik+VryKi+wpphQEwh40i4DMDGxZeLJNgG4xLpIwqu8a0mBvfo/XM3yRBjtT7T9JZcAiBQvEE=
X-Received: by 2002:a5d:814d:: with SMTP id f13mr11098065ioo.203.1622992879657;
 Sun, 06 Jun 2021 08:21:19 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 6 Jun 2021 23:21:06 +0800
Message-ID: <CAOLTT8SJkVeSQKB7eN5Lw+OepeRXiZXWf_t-E09KxT1pmYBMag@mail.gmail.com>
Subject: [GSoC] Git Blog 3
To:     Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My third week blog finished:
The web version is here:
https://adlternative.github.io/GSOC-Git-Blog-3/

-----

## Week3: Meticulousness is very important

### What happened this week
- I found a `git cat-file` bug this week, see:

```bash
git cat-file --batch=3Dbatman --batch-all-objects
batman
fatal: object 00345b5fe0aa8f45e9d1289ceb299f0489ea3fe1 changed type!?
```

It seems that Git died for a strange reason: the type of
an object changed? Is my Git object damaged? (Just like
a friend of mine, use `find . -type f -print0 | xargs -0 sed
-i "s/\r//g"` remove all the '\r' of all files in a Git repository,
this caused most of his Git commands to fail.) So I tested
it under different linux platforms, they all have this same
damage.

After a series of testing and debugging, I found that
`oid_object_info_extended()` did not get the type of
object.

So I submitted the patch for fix this bug to the Git mailing list in
[[PATCH] [GSOC] cat-file: fix --batch report changed-type
bug](https://lore.kernel.org/git/pull.965.git.1622363366722.gitgitgadget@gm=
ail.com/),
Peff tell us the essential reason for this bug:

In `845de33a5b (cat-file: avoid noop calls to
sha1_object_info_extended, 2016-05-18)`, this patches
skips the call to `oid_object_info_extended()` entirely when
`--batch-all-objects` is in use, and the custom format does
not include any placeholders that require calling it. The correct
solution is to put checking if `object_info` is empty after
setting `object_info.typep`.

Finally, thanks to the help of Jeff, I summit final patch in
[[PATCH v2 1/2] [GSOC] cat-file: handle trivial --batch format with
--batch-all-objects](https://lore.kernel.org/git/4af3b958dd056e2162fdc5d7f6=
600bcedde210b8.1622737766.git.gitgitgadget@gmail.com/).

Talk of experience as a story: Even experienced programmers
make small mistakes, writing any code requires very careful thinking.
- The checkpoints for rejecting `%(raw)` and `--<lang>` are incorrect.
At Junio=E2=80=99s reminder, I changed the checkpoint from
`parse_ref_filter_atom()` to `verify_ref_format()`. My mentor Christian
pointed out some grammatical errors in the cover letter.
- At the suggestion of Junio, I rebased `0efed94 ([GSOC]
ref-filter: add %(raw) atom)` on `1197f1a (ref-filter: introduce
enum atom_type)`, they have a clash, after resolving the conflict,
it's better for me to consider the code I implemented before and
the code I wrote now at the same time, I can find more problems
and find better solutions.
- I submitted the patch about `%(rest)`, `%(raw:textconv)` and
`%(raw:filters)` for `ref-filter`, they are used to simulate some
functions of `git cat-file`, my mentor Hariom noticed one of the
formatting issues, I am waiting for more reviews for the time being.

### What's the next step

As long as new atoms `%(rest)`, `%(raw:textconv)` and `%(raw:filters)`
for `ref-filter` can be accepted by Git, We can start to let `cat-file` use
`ref-filter` logic on a large scale! Exciting! But the performance of
`ref-filter`
is still not good. Perhaps I need to find a new breakthrough in the
performance bottleneck of `ref-filter`.

Thanks!
--
ZheNing Hu
