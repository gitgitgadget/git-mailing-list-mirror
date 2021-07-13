Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B60C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678FA611AB
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhGMIFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhGMIFa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 04:05:30 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2E8C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:02:41 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id e7so8295010uaj.11
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JPaMO8ikGe/9Aai44oRp9xA1kb40jTegF+7+rxhMpEQ=;
        b=QrVp/de9JU4czAmViesUO8BEv4Gi8S/FiZHKPDaCjwcyi0d+ZUYQAUcBIG0drrK8bZ
         5m6Xq6RZ9LB/pC0n865SiLg23LVf7PAdvceYaYzKeLU4ltdoLLaYfw03oibe+cHiHuN8
         dzKeUWnieFgE/n55FN8PKLYiQ1+oO00mAnXMjFEM3Pi9I7PZChb7dENatl22mKpstPme
         XQjrz+aPYAG73FpAVH6O35gaAby8TaBMwJCD10qk5My8cy31Udtdn0XN5zAubi4Mivqf
         2TaMa/KLzvZ0EXWZVBXK3tMPVuAIOx7cGSay4n2jU/TOeBtbXutxkechNGATNydKg0RL
         sv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JPaMO8ikGe/9Aai44oRp9xA1kb40jTegF+7+rxhMpEQ=;
        b=QUrxetyRUKiACq79uqkr0ZtM8hlx4VbeFXdTpgxeBNlWREF7kErY1s/tzfam/qmToX
         ScT94dZ3QImy7i00Li1nd/rZBfyg4CovRCiAV1MRSXFQ6lvqkn96tUfuema6ESat+c66
         X3/jgBcucWN+36ZAKe31wugdQ1z5JbnyqBhPAGF9FFxxV34fWA+p+hmdjHEwhN6KBkYC
         qagbPxjudV+9eVQNdZIPYXUPq/R7S4ygTK5TGzy7lwC5u0yGtXAiWOU7Qn4++z6TnnW/
         QWOhOjtHOZmNRBmvihX0v8VgCw5qx93OGFOSKweWsVF1duYFmv+cali21LSzZm5BXNU4
         lYsg==
X-Gm-Message-State: AOAM530XVGEdlF/fCxUF1uYaRuzVe4VldGDJrPDm8HMoMgbRmanOaS8F
        2DOyXFnprtvnS0yho7Enr+8SfihSVhAajUmlGv4LXQ==
X-Google-Smtp-Source: ABdhPJz9CyFikwvLA8YHE7bDwky1RjcaSo415hTTLqBdNXaFwoRE099v+ivyRU7PP7c6m8jNiuZQtcXPPe8asnaJZzc=
X-Received: by 2002:ab0:3a94:: with SMTP id r20mr4213537uaw.55.1626163360080;
 Tue, 13 Jul 2021 01:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
 <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <ef91f5cee13b1153f597f31451460bba543a63c3.1625684869.git.gitgitgadget@gmail.com>
 <87fswl3vsn.fsf@evledraar.gmail.com>
In-Reply-To: <87fswl3vsn.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 13 Jul 2021 10:02:29 +0200
Message-ID: <CAFQ2z_NzykfcBSvtHQ10RZWxLP48+qArZk9HbDJQB4tNX-GtYA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] refs: add failure_errno to refs_read_raw_ref() signature
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 11, 2021 at 2:00 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Jul 07 2021, Han-Wen Nienhuys via GitGitGadget wrote:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > This lets us use the explicit errno output parameter in refs_resolve_re=
f_unsafe.
> > [...]
> > +const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
>
> This and the subsequent commit don't compile for me, because this lacks
> a prototype that you finally add in 6/6.

Whoops! thanks for correcting.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
