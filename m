Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F004C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 11:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiC2Ldj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 07:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiC2Ldh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 07:33:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294832498B3
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 04:31:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w25so20314589edi.11
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 04:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1F3JrOTohFc9QRHnwMGPsEEHD76ehg65gM7L9zijjZg=;
        b=GxdSW7HP4D7nmCds9h+AEpjUcXR4kYBnLZ2RvUqfORhkYEfpuPVuWIJKQzliaK4027
         qzJgXa0q+AHbRslBvHkRX+9nZWfWRP7XpQM2VWaSBaoGagYAeYbm7vMoM3PTtqmWq54w
         Q/PBSCN0pwRIi/XvPKeJ4WQ4mleyy24VWuPS2SKN3sZ4qir7uL+v7cpn8zig83E9pSvv
         0/osj2DZkPrPlQuMkSdtd/eC+/qKQooxPffiAd3rOTX8+9uh0H/QymVRiVWnRkLuTrQV
         uLMs+xTvUOdPsd9rvQ1nFKk/vB4DYndEYCroALm90b3/uq0mPSj7BZHob6Ux0a8jl+rc
         TpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1F3JrOTohFc9QRHnwMGPsEEHD76ehg65gM7L9zijjZg=;
        b=xdfNAHWCQ8g8Uxq2oll83zpNxJkCyavJ5mCL7SJNk1Nmx89bAT/+YBQOBxLuNt3ZbS
         McY78njFvVRORT/+dOw8Uwj3weLVBLcJ2kh8sI+q5igoDI9/hLOSVM8DMC0suauc5De1
         BH6Tn8rm8NPYkZWelP29XMVW0mFZ/RbfkVYvkUFzZhQW1oCzdMSDlDLTM+x78jLKQT8z
         dG26tvfjEG+in997JuVWXk2dnsYywFXwWHbBycB3y0GbKQzqWU5rCrfLLIOZEX9YYkUj
         zTLehLzpdum+T9dT7YQTJaRH8Z4niNBATqWYzH5y5+RFdtDqaEPDH+YhGi9J0JOwcXgh
         SYfA==
X-Gm-Message-State: AOAM532556SKc35UTrt0dUl1PVzrUax57/LYJaIS4EFEGY3CDQQKDPr1
        61fDbKKHXvzQafOxdlDer246Tf4joHPploBP3KTUug==
X-Google-Smtp-Source: ABdhPJy4eOBfK4DmC8cewHtzjh5iUvqfXQtxQrpI6Ats3Suq1kHbV00oarGY/Lm90ck406jhY0ofAdM95OqhJaF9r74=
X-Received: by 2002:aa7:cd81:0:b0:410:d64e:aa31 with SMTP id
 x1-20020aa7cd81000000b00410d64eaa31mr3973367edv.167.1648553513599; Tue, 29
 Mar 2022 04:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com> <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com>
In-Reply-To: <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 29 Mar 2022 13:31:40 +0200
Message-ID: <CAPMMpojj81UY8-q2Oh6VeTdreoszfcTmLm6Hh+O5hoObaYw8Zg@mail.gmail.com>
Subject: Re: [PATCH v4] tracking branches: add advice to ambiguous refspec error
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 29, 2022 at 1:26 PM Tao Klerks via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
>     I believe this third version incorporates all =C3=86var's suggestions=
, and
>     might be usable. Removed "RFC" prefix.

Argh, sorry about the broken cover letter. This *fourth* version
attempts to address Junio's concerns over unnecessary extra
error-preparation work being done in the very-vastly-more-common
"normal" case.
