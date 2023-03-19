Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4F8C7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCSGHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCSGHL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:07:11 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89EB144B3
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:07:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x17so11255524lfu.5
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679206028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7GrEhep+VWw/mpkjhP2+sUK4h/zFBdKI4ac5kEKdoE=;
        b=nMn00VuTZ90ntxmqX3IUuo6fmXxMT/jvtTbCSJnuloC1E5rVoa4zADRd6r1VPFkeNo
         wHvMB3x5xiXj4h1jqRzLAGvbyx6CgYfF27tcQZD3DokMfWKTuqluNHOfFhsRa4N5qEsO
         ViDFDO57gGmQJiOoY6uy1CTjAxhjHys8ncWmD6xQJ6fFxr2K73sqSH9r2c9sVGh+ImzR
         krQ/TSaISzwt5olNXTvB9DClCsmAyGLOmlrjY5tJXOUuoPnxGNhvS69GMNiAe5Ih5LeL
         CzMe02C8Z4fEXJeq2PZbTuDK6/w5FUAiv+6mb7rzV8XthjFefskr/eSZzcezZvIsm5yA
         Y3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679206028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7GrEhep+VWw/mpkjhP2+sUK4h/zFBdKI4ac5kEKdoE=;
        b=UeHYIKXS6YkjP0bjyJQwMX5g7h2BJneBrIjFdHLVqUk3sCabqxwSa33eqILgrj99Mj
         PUh/k6Juc5+nuHiVfxgipM1JxsCEO1nD+/oU+74lT7HqO6CjjEjIhqMvUlMzurPSvIuk
         GXsSp5WO5KBvrj+vPbA/9Ka2zsTscoPoxtikydybJCItCT/P3uR94lIDTzuLSOAlQEpv
         cKtJDgg0sE+HJkwkKGEdmJBSYoeYSTUMEo3N1n+hhBHT6GYE3xnhcOZW12Ovuw0/uOqY
         TzGbC0rsE1POhrdtNE7imJpGJ2ficRro2xD+A6jBy/XSgQR9jFfpQ9iKU7yje0Ic1t48
         9Hvw==
X-Gm-Message-State: AO0yUKUIpDVggfInJdlSG2iU6xKvuEKiOwvkd/RYfOgUjRpWopH/o928
        Tz7LNybxfmJsl6jpX1YWiLX5pK/5oX5C++bpCuhdNu4wl58=
X-Google-Smtp-Source: AK7set8Et/L6mMN/ADqnIECDstViB5cDZxNvTrR3I0fBXl4zv3Y11pYnJut4l564vGTnlT8oZTauKAlhrZKV1kFHvqk=
X-Received: by 2002:a19:7009:0:b0:4e8:6261:58c2 with SMTP id
 h9-20020a197009000000b004e8626158c2mr3844382lfc.7.1679206027955; Sat, 18 Mar
 2023 23:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <patch-05.17-36eae891341-20230317T152724Z-avarab@gmail.com>
In-Reply-To: <patch-05.17-36eae891341-20230317T152724Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Mar 2023 23:06:55 -0700
Message-ID: <CABPp-BEaRY_NaDNVTWoYmn=61iEUfsi5MdkdYW9STRhQfMBj+g@mail.gmail.com>
Subject: Re: [PATCH 05/17] cocci: apply the "cache.h" part of "the_repository.pending"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2023 at 8:47=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
<avarab@gmail.com> wrote:
>
> Apply the part of "the_repository.pending.cocci" pertaining to
> "cache.h".

I know you said we only really needed to review 01-04, and 16-17, but
I spot-checked this one anyway, particularly since it conflicted with
what I was originally trying to include in
https://github.com/gitgitgadget/git/pull/1493.  But, I pulled that
piece out to submit later, I'm in favor of the changes you are making
here.

Also, looking over this patch I think answered my question on the
previous patch.  You only needed the functions sorted by filename for
the duration of your series, so that's good too.

Anyway, looks good.
