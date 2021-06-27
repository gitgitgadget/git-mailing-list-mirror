Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABC8C48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 22:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2A261A1D
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 22:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhF0WKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 18:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhF0WKg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 18:10:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F6C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 15:08:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id c17so108395ejk.13
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OpEaMYxrVG/arniuwoLR2We6fSYgWvDy4IIpCrgS5Vs=;
        b=HUGhYRvhhmwb07MCMKtXuI8oLQ3cA5HbVf4RsKUcvTtFl75fNLfVqs3HmVpaBJ4HaD
         ocamCzA4GSaiG1vW5NnkOtsYY74R9VIB83/6kTkT7gg8q02aANVTFHmX8zUwPIvOb0u1
         cVRrap0sP+PZVa18strTptTGFdbrZxZtIz2VXBgyoZK4hb8ts0BrjhA1o9jenw+vw/Fk
         6rp+dgI1usKN9tNwtQKR5IJnNaX3fXsTQGus+r4HdH9lGRrU2nUs2hbcWIgjI38V8JEM
         k42HYOFD9B8YxRoEi4SgjGk+xLVCn8LOE8w7yaFj2NvGC+84UlNBrbc0Ta+brlxRbEnr
         AH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OpEaMYxrVG/arniuwoLR2We6fSYgWvDy4IIpCrgS5Vs=;
        b=DVvw0XkbPgk/eXi5b3VriZNR6HQzsDp8G1JXX5FFcBeJhyaSwq1gJuM5ube7he48Bs
         hJAPimK7b7lshywU+NL3gXtMO+81JsHtTDHwZ1EfMeD84tBb7DRPS+E4WdaHGbuSPtpX
         KLQgrBZ/i54vmx5H/LTSuj3rCBCtMaJRFs9hAX/pLL2KXQeL79REI/So1mOdmY6BxIIX
         rwteUmD0G76s5zGXmDL7zra/kjLUWEkRYCVAXtEwGLXjfRLgBXXyRBYroEaFluodKeT+
         mdo1ckj1fODhx4tFh9YevNhvmhzqUaViMc0ptzc77Rp0Rtck2tqqCl9lNOxv+DAndFxu
         avTQ==
X-Gm-Message-State: AOAM530CpcF/ojzU6hEjbsbHKY1zXimiOjzq9insDdWXHrlBZ7/NSZBc
        QAp1Pj6coHxyvT5DPLmrWHNBf+vYe9kNjRuBJj+FWflCET2Ifw==
X-Google-Smtp-Source: ABdhPJy/ON/hYzs2CI/PuAAF0DyoZX5kZjTZ6tMstUMhY188lLroXOJyh0ws40BGNm4hlcT/NfPjiWmzbzUanXF8H24=
X-Received: by 2002:a17:906:244d:: with SMTP id a13mr21585414ejb.551.1624831689904;
 Sun, 27 Jun 2021 15:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <4E38928E-A98D-4F57-8866-8A237B31DDE0@gmail.com>
In-Reply-To: <4E38928E-A98D-4F57-8866-8A237B31DDE0@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 28 Jun 2021 00:07:58 +0200
Message-ID: <CAP8UFD2xCzJ7hxd_Of0FWnPKGzm9j9DizK55GyMhedzGgbs8gA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSoC=5D_My_Git_Dev_Blog_=E2=80=94_Week_6?=
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 27, 2021 at 1:24 PM Atharva Raykar <raykar.ath@gmail.com> wrote=
:
>
> Here's the latest instalment of my weekly Git blog:

s/instalment/installment/

> https://atharvaraykar.me/gitnotes/week6

Great, thanks!

Small nit: s/has not not yet/has not yet/

About "This kind of an invocation was done before in the context of
submodules, but it does not look reusable to me because it seems to
have side effects, that meddle with the repository=E2=80=99s object store."
couldn't a commit walk do the job (see
Documentation/MyFirstObjectWalk.txt)?
