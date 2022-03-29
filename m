Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A34C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 12:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiC2MOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 08:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiC2MOH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 08:14:07 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A3164D01
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 05:12:18 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id y7so6345777uar.9
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 05:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LCa23OWaLzMxcQR/KaPHpXttnBp2HqFi9ZCBCKuUCHs=;
        b=PjIqgNgfZpEz6hca//kuuRh1Y86U9ALzajAIpAlTvAbtKo0C8XrhVeCooLDWHkAkRP
         RyyvEPk0l+8bvXFCIJtvVyrCAEbvV7cOhLGGJdwTcqZq7WWJoueX2++tmo4xEGsCIn+Y
         K45FB8hYdMKBt5MZlw6OON140sFUxxWUa8Gaib746gvy2BB9hP2K8BPr0C8oBrFLgZfU
         GaLYQOkuna9at6UvLShnN+5GRitFDMpi8APIXQ2niqxA9ZwhDyemWj0TU9XaTpZaA4ZL
         YRnodBWsOnJqy9E2huxdLf4vJ5lrncTtcLcFEfyqYr6x3QV7+saIMB0DATtwO7Kq1ELI
         FTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LCa23OWaLzMxcQR/KaPHpXttnBp2HqFi9ZCBCKuUCHs=;
        b=mpLlmozQGAULl/uzTP9SQpKZt5MwkBoZpD7E+W5SZj0ss0O8/wcKm8BWgyCy8e9Prd
         LNWGoeZCZWYZmLUedodP7aDGxOHUj1+z3/8FeEKnNsm5if7QeQpdWKm5enrnVAqGZk/r
         FtMcYc8SApN9zgQy1tLbug8V5MimxYne9BvvgukSUD5rN5cnMeCS2t7brIKuxlzgrxR8
         ExDk0bNEOfp88eFCx9jgWvpYVz4vz6hPTMwxYmIe99YcHVekfVJDTpDeWvP8hhVolXse
         yScIZ4b/FQa/zYysbhxmSPUt4dzbxqjC0KfSROPEUeUSuwtLwtC0FpJtBMO3AUvGMeVY
         rn9A==
X-Gm-Message-State: AOAM531zFq9IIO754R80T4Y3WRxCkS0e3b5GFMHg5SE5NOrsRQArorDb
        w6eue3FLU4Kc1sojkoZPc3Y2tIlCQjy16hKXRoIivw==
X-Google-Smtp-Source: ABdhPJwEbjGcvfh4dOg80X8K8EYCYjJnZOweynhg6XbmP9S6TI64feqUeAYmVB6bUM0lKfFb+LXlVGkIQcnbXzb/x40=
X-Received: by 2002:ab0:7290:0:b0:34b:71ac:96c2 with SMTP id
 w16-20020ab07290000000b0034b71ac96c2mr16089929uao.102.1648555937316; Tue, 29
 Mar 2022 05:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <c052b97e-e788-f63a-15c5-b1fbb6a480e8@web.de> <patch-1.1-98267695418-20220328T190642Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-98267695418-20220328T190642Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 29 Mar 2022 14:12:05 +0200
Message-ID: <CAFQ2z_PBk57smzqDMVGN7YO3TvutrpaXERfKU4Mp45RfWkwcuQ@mail.gmail.com>
Subject: Re: [PATCH] reftable: make assignments portable to AIX xlc v12.01
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 28, 2022 at 9:10 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Change the assignment syntax introduced in 66c0dabab5e (reftable: make
> reftable_record a tagged union, 2022-01-20) to be portable to AIX xlc
> v12.1:

LGTM.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
