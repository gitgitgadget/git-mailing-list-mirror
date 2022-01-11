Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8912CC433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 10:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiAKKhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 05:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbiAKKhk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 05:37:40 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E46C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 02:37:39 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id m15so14442495uap.6
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 02:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MT7ReaU5pfxOHPu7TjKgfx/J/EzIblebxgNZoT956Tk=;
        b=joQlmNs7+bdD7ISJHFA7tA9uNUFAtJ9KLZ2bm5XCNsOLFjsCaRurHr8Bykiv1Li2f4
         mjAd6Nou0XAi3xteVmn+qAWdxm64TQaQZD4LXr5mmd5VQnYGtxWjZiO4qswyayZXt6Gi
         2yNLQgY2qZRNiyww9BBOBxY/o/UjeuhOjB6M035e6SpTpylYkBxeZ/1PyFVb5XWU0Rk3
         WVFOuKdLSRdAyA1S6RMgUuR32fsqLHQjubgkYhhuOK31HokP6Yk49ggxfqOu/2rIdL67
         w1uHV/7XtT01TzW22ZbPn/uUe4aubsI3Q4839HFB5W5Vj+c9sTdnh6BlS2qmpRZ7b4sJ
         0rEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MT7ReaU5pfxOHPu7TjKgfx/J/EzIblebxgNZoT956Tk=;
        b=h3B8K7+DArgqju61OqJKyJDtJSqSBcuym4wiYW5caKQC+AglKgcTZn4DBi8Pzt3RJr
         evT+4/xPaAc8BIsEzgbITHyKm0G1m4ea4uDzEm4O+pnNdqj3SbJ9swTIQxYQnsXSVEmv
         YbMdMtvM8CmTAiFpHMAZYIqiIROh6lLSEYukAtAfB/HcVoieF7ZPjCYEPRZFkcYiJ6TF
         hH98xyICOkNJUMwNkQ/IqznWi+gwU51w2rqW3ZwlneShNuB43TyVuuKdglclup/rF8cv
         E0FmxdQO2He/gxOblmcbHslJrW4g2cZna9iGNLYpy5pAD7qN2dU8tKylCBwP7DzSbmfQ
         m/Vw==
X-Gm-Message-State: AOAM533cX33CmQsdv0Irj9WXz1XgvsXd9WtHeSRu9DJ4Y4JFPDbIUlf2
        BREmsmlM2UKsunJDOeEL4lK6RV2ynK4SSkhrOig=
X-Google-Smtp-Source: ABdhPJxVocO4THBPGwr3DKRThkI2oQofwMpMo4ZdCLUx+B/rU3uYVXUvPxraooURfGZYbFAG6+U2Crd5MwgjjM4gHW4=
X-Received: by 2002:a67:e9c4:: with SMTP id q4mr1667863vso.43.1641897458725;
 Tue, 11 Jan 2022 02:37:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641440700.git.dyroneteng@gmail.com> <8dafb2b3779715aa277eb825a94af87b72f3e093.1641440700.git.dyroneteng@gmail.com>
 <220110.86ilurzcxo.gmgdl@evledraar.gmail.com>
In-Reply-To: <220110.86ilurzcxo.gmgdl@evledraar.gmail.com>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Tue, 11 Jan 2022 18:37:27 +0800
Message-ID: <CADMgQSQtAB_rX7TPcqbpDoozjghnHRq=HghGYQrmFVzWbB23Aw@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     congdanhqx@gmail.com, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, peff@peff.net,
        tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 2:02 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> > The original rule was introduced by commit:
> >
> >     https://github.com/git/git/commit/28c23cd4c3902449aff72cb9a4a703220=
be0d6ac
>
> Let's refer to commits like this:
>
>     28c23cd4c39 (strbuf.cocci: suggest strbuf_addbuf() to add one strbuf =
to an other, 2019-01-25)

OK, I will.

> That file currently has:
>
>      18:format F =3D~ "s";
>      26:format F =3D~ "s";
>      47:format F =3D~ "s";
>
> If we're fixing these let's fix the other logic errors as well.

Thanks for the reminding=EF=BC=8C they'll be applied in the next patch.
