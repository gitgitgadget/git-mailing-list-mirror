Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E97C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 14:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91A861935
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 14:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhGCOUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 10:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhGCOUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 10:20:16 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451A3C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 07:17:43 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id g3so11413818ilq.10
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=acJXEGiNLyo/h7ihsmjKakqhbcDGbnWtc4mINStZsYY=;
        b=LeAw+nDT8BdnDQdJnxXfqEiDA1d/VZNI5AKjfVpqU97+SDViLwqemHKpBdByr9Msf4
         p9olEHTxyud6XF6nVvOY80qVSA+dUlz77a4cRQTIUEw5MtSsDWrOioeoMy+wP3YBsgWs
         Vgekag57UTj+PRdfjkJ14GR9SJutRHRpWfzOqfddt5avO0jBlHJPxCHhHnoUp2sbVTTc
         m/Z5rhM16GVxnveu4O8G4Ma92dMzY1CJmkDWQiUbx5/u2FicDwRej4Slu46ekCM9SGaC
         8nuz40vb+9OW04eIVKLv3gpDu4TajpKG/1+eYLodu0T8K/xk+NrSDjYu1IW/jM+i/aeW
         MC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=acJXEGiNLyo/h7ihsmjKakqhbcDGbnWtc4mINStZsYY=;
        b=S2aiBD+nJr5qVxI+diOq2PQf8Bv4w300lV9maOMkQGZlsjWUDWBWXMP5m7B3abcav5
         J0VNTgWapzeiBxMGIcvkninUi5y/Jhj/umVnv2ABGjYhn3Wm2mVFEqY48M2W4xlAamQf
         ME9d4St5T6v1F9dCBr2hW9PH/SuCkHsp/ktX6m1irIFdFusjRbidw9RHqU8rNpn5QhOC
         oRILt/Fd5skMXk+4e2ZJv6ajp7CyqXddn1TCFjayIXb21PHo/6L+dF2fSLq8tBqrA1ie
         JqQG6L8PVtmGisCZFUN6bJG+aIiv+l3/OSKpn7IOpaOtjYZwtQWsuQSF61QQ1F+CjQ94
         gMlw==
X-Gm-Message-State: AOAM531QK1O3Nv/qSouBY48UO53+QGQ669WyAuxCdMqli4VvmG/e1h8V
        K0/REUnnQCYV7MiDYh+pd1j9C72Oy0BAcytPKbs=
X-Google-Smtp-Source: ABdhPJw+dDvo32Oi9QnQtT1U+dA29dDSwUJx3BbdEaUq1lVKr0fcYNHSdWn0YqgTxinZHNkzS2Cip0P1tpWSpU+29Pw=
X-Received: by 2002:a92:5401:: with SMTP id i1mr3707619ilb.17.1625321862616;
 Sat, 03 Jul 2021 07:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <e04b970ccb0cad8c0b651ab11f5f52063bd84606.1625155693.git.gitgitgadget@gmail.com>
 <877di8al8n.fsf@evledraar.gmail.com> <CAOLTT8RdujpQ2uKEWPyG0HGkUz_EsONw3hEZ6YAhpmQc5rgohA@mail.gmail.com>
In-Reply-To: <CAOLTT8RdujpQ2uKEWPyG0HGkUz_EsONw3hEZ6YAhpmQc5rgohA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 3 Jul 2021 22:17:38 +0800
Message-ID: <CAOLTT8QdPXzkEak4HpHdxhSmpgDe+FEeRKeHkG8c_u7QV=BWDg@mail.gmail.com>
Subject: Re: [PATCH 12/15] [GSOC] cat-file: reuse ref-filter logic
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=883=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=887:45=E5=86=99=E9=81=93=EF=BC=9A
>
> See this two attachment about performance flame graph,
> oid_object_info_extended() in get_object() is the key to performance
> limitations.
>

Well, from the current point of view, The time of oid_object_info_extended(=
)
before and after reconstruction is similar. But after refactoring,
there are a lot
of additional detections in ref-filter.

E.g. append_literal() 1.68%  append_atom 1.63% ...

--
ZheNing Hu
