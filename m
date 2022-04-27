Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A39FC433FE
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 09:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiD0JUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 05:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiD0JT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 05:19:59 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9AF2721BF
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 02:16:42 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id bc42so596768vkb.12
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QM6G606g+yJpD9hr0k/SFlkGrA4onUEx9o0iTpkiDCU=;
        b=R4UHVq2BKABIRCeUNEnIebKoFIL5Y1PwNLW2/mONOEHdhN23Toze9NH7ZtwTz8anCM
         TI2vHIP/EMOjCIkgP++vDKRHYhJRun5Ro8ToK6PlYkx8n2mr58+pgDOeQPCD8Tt0xhaR
         bGZPX5ulyzmLeoAiUzOZi8/0YiYBDzdH71wBc42GOd2OAcz03dMIuvOvoNfwQJ5ZrcgA
         kEDUoEHBlVBGLdYGkmvigQGoavtpIgSY4idUp4ZJj6jBJDL9BGAiWcf13KG2i7lAcFRS
         lOTRNCYMRxJEnUXRigUk38f1c2c+UhvEzvOOZDGlpeOnSTGSDhpn0tDdJtrmBattder5
         W/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QM6G606g+yJpD9hr0k/SFlkGrA4onUEx9o0iTpkiDCU=;
        b=l/Ozx/P9x43jBblr1cBmKrnxRgk//jEOWeEhnlmQD9haG1LV6mgwq/gW6X1RLmsrV8
         yRSAfhTVIJhY2Xuet91fxKWKQUp4DWuiTqHXhgwcNcZ+yPqFtE1xdaJJmIAn9WQgKEO3
         RrgyJ90FZAu1mUeziEaeDUm367XroUcsIw7dgzrLPgA7s5U5T6eURiQ5WJRC5kdP6aHw
         FnF+CPrB5wQsfGA/e3MDezACO2ypsuG6zgN3cx7YmzKRe3xvozMU5zk/iBuhRLITSOla
         O3xLevBu2mgVVgELms/aSozSaZ1UghU+l6mAM8yfAs/tApSXyFjQ7VQNT1iIGg8x9mjG
         B9sg==
X-Gm-Message-State: AOAM531fkiS5z6V2BaTyS2OILqdYtX4+y7jjoJ1NbHybzmtBaXkUYLfb
        Jm2ln5yQ3zk657AzveOzpenGR/gA1pI7X+0LotQ=
X-Google-Smtp-Source: ABdhPJzWw0SKZDFnHvQHmcGahLWH13S2jn0kJ73+9t0j8/2MBiFwvE21gXOM9DvMfaR/FUqFxKWslsXIFoXV31GJVXU=
X-Received: by 2002:a1f:38c2:0:b0:349:9667:9232 with SMTP id
 f185-20020a1f38c2000000b0034996679232mr8388789vka.16.1651050988584; Wed, 27
 Apr 2022 02:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220427080412.37766-1-carenas@gmail.com> <CA+zfrf-6c7BG-PDehHKh6_8zWdu=NeM9gL6zN8Ug+oT9fAOfqw@mail.gmail.com>
 <CAPUEsphL6TARGuhjvCiXXt+CQZd1+c22KBw5n-XCvnP176yz8Q@mail.gmail.com> <CA+zfrf_mHfDXk-1VhU564YeCTW7rgDeeuORdTT61LkTESmC5Og@mail.gmail.com>
In-Reply-To: <CA+zfrf_mHfDXk-1VhU564YeCTW7rgDeeuORdTT61LkTESmC5Og@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 27 Apr 2022 02:16:17 -0700
Message-ID: <CAPUEspgf_PpjjrGaAqeE50fWYeCqevQRGutocNOA4gyYzQzFsA@mail.gmail.com>
Subject: Re: [PATCH] setup: avoid uninitialized use of is_safe in ensure_valid_ownership
To:     Matheus Valadares <me@m28.io>
Cc:     Johannes.Schindelin@gmx.de, derrickstolee@github.com,
        git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 1:33 AM Matheus Valadares <me@m28.io> wrote:
>
> C99 standard =C2=A76.7.8 (Initialization)/21,
>
> If there are fewer initializers in a brace-enclosed list than there are e=
lements or members of an aggregate, or fewer characters in a string literal=
 used to initialize an array of known size than there are elements in the a=
rray, the remainder of the aggregate shall be initialized implicitly the sa=
me as objects that have static storage duration.

Thanks, I will include the change to remove the path initializer and
add instead the is_safe one as part of my bigger change, but FWIW the
following doesn't even trigger a warning with the highest level we
have with neither a recent clang or gcc or even the cppcheck static
analyzer, but leave and uses is_safe uninitialized.

diff --git a/setup.c b/setup.c
index 17c7f5fc1dc..28d008145fa 100644
--- a/setup.c
+++ b/setup.c
@@ -1122,7 +1122,9 @@ static int safe_directory_cb(const char *key,
const char *value, void *d)

 static int ensure_valid_ownership(const char *path)
 {
-       struct safe_directory_data data =3D { .path =3D path, .is_safe =3D =
0 };
+       struct safe_directory_data data;
+
+       data.path =3D path;

        if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
            is_path_owned_by_current_user(path))

Carlo
