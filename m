Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CE0C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 01:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjC2B6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 21:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjC2B6P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 21:58:15 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7D51BCF
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 18:58:09 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y5so17601690ybu.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 18:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680055088;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e93D5S1sxxVcgExr75yJU7Db6mj8o4aTV8GVUvfIHQg=;
        b=dc1egL0P9tLYfiaYAm8A7UZ+2dCNavdPlDtUoCiJgV5doNHZo5UNF0q5xFO+fMO/rZ
         T1on1O7pAT7XNzx9a+fi7bEJG0+5IiBbhm3dVZN1T0EaiQYqsKZwh31Cb/OcjkLZdwfl
         3TrMQcwqzuQqh3S7C4MdOm/LSymbuLHDaX+d3uxcLQQJl/ZadKRUVv+BKptzQBARNv/j
         7M0zWOv1IJFgf2Ffd/c2P74pd07PuOMJtYw6QWsGIs9To8ZGi+NyosJAYeIFgA0QeTO8
         NNPWBYrNdHIArx6alJiqIwJUMQmE286ARX21Khxsq8T9qbMGXSHu21PJbBBfY0ckHfkJ
         k1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680055088;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e93D5S1sxxVcgExr75yJU7Db6mj8o4aTV8GVUvfIHQg=;
        b=5h0TLmMCDxxUvwq9ewHoQBO28Utb0CqWV+rE9cNZEsjYN3DuFBeghvZcg4mR/O3S18
         k2MXrGW1AXgKyNHjrxZnQOQ+6rgjWBUpnfne36a6XNOxogAcAVgeLHD200bgPoHtm/CV
         1k40HR5qH1s/sDEwhhKU/yWpz25rdEjX9Ae+HivMCG/qgowRf/p7zcgpLkk5BSVgKq7y
         oUIr+r1NlKa5wBOdTqaLm7Iuk3ONxtCsyWrSMw67HOoHPTB8EZ4d+718+Mf+2O6IF1/e
         DoZzJU2Y5I+Pu8RTmVppPajJ9drDis13gbrEZifDZW4vqbtI4OManDgH3yBad6LDnhxk
         E3Ig==
X-Gm-Message-State: AAQBX9e1usmtap5DuxGjn+uOciA3lJiuBrOOhVEhzrqRR/gYoWHFZj6N
        VHZLJIUq/RwV3kIuqBnYFkUxQlgoj8cV0rmyO3g=
X-Google-Smtp-Source: AKy350ZUqV0ELH/c5y5awKE+L9k3eBUiQ8MAsL0Cf55vl8eIlfyLmRBMDyitWlB3Se0uhe6Jvb3Zdv+gEJbDVCcZMA0=
X-Received: by 2002:a05:6902:18c6:b0:b78:4788:525b with SMTP id
 ck6-20020a05690218c600b00b784788525bmr10802665ybb.0.1680055088521; Tue, 28
 Mar 2023 18:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173932.3614601-1-felipe.contreras@gmail.com> <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net>
In-Reply-To: <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 28 Mar 2023 19:57:57 -0600
Message-ID: <CAMP44s07W6SzJZnmpMMejM8cTNvwrKnNiD+1U=JWMBwUX8JbMA@mail.gmail.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 6:57=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2023-03-28 at 17:39:26, Felipe Contreras wrote:
> > It's not difficult to make the testing library work for zsh, so I did t=
hat in
> > the first patch.
> >
> > The rest of the patches are basically to deal with some variables that =
are
> > special in zsh, workaround a bug, and a minor discrepancy.
>
> There was a point at which the tests worked entirely in sh mode with
> zsh.  I know because I fixed a handful of tests there, ending with
> c64368e3a2a47, and I patched zsh to run all commands in a pipeline in a
> subshell in sh mode to fix the remaining tests.
>
> If I symlink zsh (zsh 5.9 (x86_64-debian-linux-gnu)) to sh in a
> temporary directory and use it in SHELL_PATH, I get only the following
> failures:

That would defeat my motivation behind the patches, which is to be
able to run one test file in zsh.

Only the first patch is needed for that, the rest were in case anyone
cared to run all the tests.

> I don't care a lot of other folks want to make zsh run the testsuite in
> zsh mode, but I'd think that using sh mode would be simpler and less
> likely to break in general, and would avoid us needing to carry a lot of
> patches to work around various variables that are special in zsh mode.

We don't need to carry the patches if the patches are applied.

--=20
Felipe Contreras
