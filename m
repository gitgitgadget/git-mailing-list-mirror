Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10014C04A68
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 13:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiG3Nuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 09:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiG3Nuj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 09:50:39 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF3BFD10
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 06:50:37 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e11so7859931ljl.4
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=GukR2BMjRI1tdSNBQbmqoCTmNMCVPefSCtCWgBplDzk=;
        b=j3kp5Pqq60x0DXRqKHlurQDXNBwHDU+8SWxkbQv/h5+/R0op1gBEDY3c8qnK+VnHz0
         4gUetZF+m4mTCZHhzMjKzbSwStJk0E5bywse9yd86gjFZgd9XAOgIE+zn+35W8iHT/HM
         jDRLDzX8xhd4bSro1Uu4GY6RU4aLXAAz/KkrxkSTmXweRiUCnKxUVf2asDYtnX/4WYvs
         2S4Eku2QKiNp6jdkFfdFW/1/i6vJFSVfnrT70J8bMpkb0eaUWwVaRHblzZ6yh1KpaheP
         Jlx5JFuyUbnI0DPQ1wh6tGIdB9zEAc1xEGfLhGDCtZzai8mGbkm1EyGMYn1SoISkT85N
         1utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=GukR2BMjRI1tdSNBQbmqoCTmNMCVPefSCtCWgBplDzk=;
        b=8O3YqxoTt7RlyLHtHXO/w09vY37u5S+v/ARugpQlqWpqg6w/DHqhrD++0Q9EiK6lw4
         On0gpJqkj0gj1E74MnMUrrdOF4tEH3HYAbJnln/XYal4KAhMaf3npGdxTEKJnrMkpW2f
         LNKltxDWaO15eSLD/Ib0f4thlhc4+q4lDddJ1tm58HVf5ick4hAP0xYdfMP5SC5YUcS2
         JyZC+kk9epItK2xEzSgM+2fUzOWRvFSXy6a24ut3P7oMXuqd/vjf5YA8/MDT8+Oz16mr
         XUDZbtEwvgJPyJ4uVLPxOnC4FDLh6+7Pgg+wvU4SpuH7AHF4WVQkvRgUTcUsPz0YA+et
         rfOg==
X-Gm-Message-State: AJIora+ohbOo1Qw/CNG3OdXPE7BtTstS3/yzL/Yu9gUcOM7JFI+9Mrcp
        bObYTwS9EfC8xnEBi8Cs0T+Xjv/jTxjWEuteVIJBEQ==
X-Google-Smtp-Source: AGRyM1vtWoEfP2btWg7PW0tCJtdFzFWL2VQRUo6T19MV+VJ2R37GaPpijAi6u4ZHwrYVTExj0y+633XaNigorVbh5QU=
X-Received: by 2002:a2e:9595:0:b0:25e:110e:947a with SMTP id
 w21-20020a2e9595000000b0025e110e947amr2407023ljh.334.1659189035898; Sat, 30
 Jul 2022 06:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657819649.git.matheus.bernardino@usp.br>
 <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <patch-v2-4.9-b9750ae43e1-20220729T081959Z-avarab@gmail.com>
In-Reply-To: <patch-v2-4.9-b9750ae43e1-20220729T081959Z-avarab@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Sat, 30 Jul 2022 10:50:25 -0300
Message-ID: <CAHd-oW5z07MTEg8OW4ftSJXG2F3Cu+WpctefZGOmMWsAM-nb7Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] apply docs: de-duplicate configuration sections
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 5:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> The wording is not identical to Documentation/config/apply.txt, but
> that version is better.

Yeah, I agree. The only potential "loss" of information here is that
"apply.whitespace is the default when the cli arg is not used". But
that is the default for all configurations anyways.
