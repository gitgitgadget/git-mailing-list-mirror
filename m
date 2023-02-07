Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF45C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 19:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjBGTz2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 14:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjBGTzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 14:55:25 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942E838B6D
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 11:55:19 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id g6so6715817wrv.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 11:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPlRVOg70poL8O8TYD66SxSCoxk38x7p06J9AP/nMac=;
        b=U+Vmi0KYbfn0MqLlGWBeO85X/fCcs9VtMcgZxKMdJJ0/nYyVKfbKAidWgNzXfDXwVn
         JTZs9bmongFPdXsNc3AjG4/EaL3LdY12eRF1P8RcXoqvHHpFSyCpujzTobku5YxKKD/8
         MQx5MfhtQU4ot99hHaPSEjtizk7krjJ90pC3YWo4/T10wK8sZkIY2kb4oN838HnBXk0v
         XSGahAMIVT4bqhEztxabvCcd8U8lm0CnpQyyBm29Hick4tuhgpXDwIP5zbm1CkWAfncR
         C24SDmCaqKgotoFRqzvqQx2eyjsjMKW4A4ma4updHLYLlQPF0XtI+J/HQgZA0T4rNFyH
         qSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPlRVOg70poL8O8TYD66SxSCoxk38x7p06J9AP/nMac=;
        b=d0+fkOb7nKDyycSNySDDZ3viYud13NaHLyPYuwjFckINgxjYGof5l/UnIw5TTsvudc
         5mA3LjZJyyy9PqFCgMSuPLYs6RBzN/jdRxjA+lk5xEJzQOfIPZyik0l+fQx1TNfmFMUE
         6fDuNdS8TIeloQTzlpQv5488hAA5uUeAKcPXOiLJPt3AwZxzhSpjvHSO1YQYh0FBMpDh
         Z6myXNCbQ488Kz12GlG4Avy/oMogMM25og8jy8D7x9eplJgGI26QGGtwkqdDjcMO+E2O
         4BnaI6xVj8HvicMVjZgbjgbuYNd2x6/7edC8PCOCLTzRD4bnCYoH8kRh7ZFj6eoCDlkT
         lRgA==
X-Gm-Message-State: AO0yUKU8AEoouuUQI4XvNfw34eX5QcHulMDVi6CNT552QIULG+rPPjWv
        Du/ltfKoGNoB/nI/kvAUlGKMl33fbbs+Tc9UEf6OaU16VEfaGQ==
X-Google-Smtp-Source: AK7set/RqpwhvDbOMlOU8Pwfyb/FZwlywH+YDzjMfiFVykoKi50+1ofdc1fW52yCcXJ2DtsgnLulaaVAdOgw+rtL3e8=
X-Received: by 2002:a5d:6852:0:b0:2c3:ddd2:fedb with SMTP id
 o18-20020a5d6852000000b002c3ddd2fedbmr154749wrw.52.1675799718040; Tue, 07 Feb
 2023 11:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20230205145245.11078-1-cheskaqiqi@gmail.com> <20230206211823.8651-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-4-cheskaqiqi@gmail.com> <xmqqlela2z3p.fsf@gitster.g>
 <CAMO4yUGmQ371hLCSTODQct+CzY2mqywfLzZO6fsgqN2=1cWGrw@mail.gmail.com> <230207.86h6vx51x3.gmgdl@evledraar.gmail.com>
In-Reply-To: <230207.86h6vx51x3.gmgdl@evledraar.gmail.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Tue, 7 Feb 2023 14:55:05 -0500
Message-ID: <CAMO4yUFMTSMuyDjiM_Ssa7X95Cm2x_uUR73Uf1UJoaPxqvoELg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] t4113: put executable lines to test_expect_success
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On Tue, Feb 7, 2023 at 3:12 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:


> The error doesn't tell us much, instead of "make prove" or "prove
> <name>" running e.g.:
>
>         ./t4113-apply-ending.sh -vixd
>
> Gives you better output.

Thanks, this is really helpful.

> But this is almost certainly that you're trying to insert leading
> whitespace into a line that's in a <<-EOF here-doc, the "-" part of that
> means that your leading whitespace is being stripped.
>
> A typical idiom for that is have a marker for the start of line, and
> strip the whitespace with "sed". See this for existing examples:
>
>         git grep 'sed.*\^.*>.*EOF'

Thank you for the tip! I'll try to fix the problem as soon as possible.

---------
Thanks,
Shuqi
