Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A237C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 08:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E922060EB6
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 08:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhGWICG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhGWICF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:02:05 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD32C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 01:42:39 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 19-20020a9d08930000b02904b98d90c82cso1372458otf.5
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 01:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=enKfxS9z1bzH134J4TQF4RMK8J2avk0W51A9R7sBcnw=;
        b=NzU9d/4JWzeM3AVN22NKOB2Nrar85nCWXQ/pY/gCYrvn+2VH3lfZ1CkPEd1mPYiCOt
         APlTicfIC7IonPTWlCsY8GYnnooxTQyq4nJ0tQD++p81OXsA5gxP4XjwFaMTwRn/tlwn
         zS2ahs9Qcx1NB4jBmYNoQ7hsnV8lkrZgcgZgzkr6eyky94AW+sYXB2av6s195o8Cu9eT
         YIwvOVgd1vG6t5BPuNxjw6NJSGtbhJdUNB0YhXkVrLHDPm6eH02oAIqEmUgzpXGzwLGi
         O6G79BmYjgkgeTO/zuK6H2bhJ+oxUgt1kWdsbJwAy511QmhJ+tpdVmdfMPmJxM7u4+yf
         VqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=enKfxS9z1bzH134J4TQF4RMK8J2avk0W51A9R7sBcnw=;
        b=HR5C8fnwsabLm8Q5VMIgGDZYEuksQ5VrSlJGyiTsK+wKkCRQWhtPcM6lic0D3hE38d
         cQ5LSMj9ft2h45bR+a1oUpY/FjzzwJ428zzHFnGxLI2sCpfemirUPoPBBTenU0574su1
         Ik9Bw2gdVWMUqMlz1gA3iTBaNE/F7dhoq0CC1daT1/tPq7iWMZxNRLvXbPe+th8+DbKo
         Vp1kQw/obJi1eMjvFPABLflV0uR66qM0HoJ1v1H/uVt9NtdHvo/OW+ojYHyv0gMe+YGS
         D/xrQ8AjSH4/QV34rojLvo3iFxAqHbBxrmCZfoMz/DPhCbzZYDRfUzhdSZv4PQ1jTCu6
         nzFQ==
X-Gm-Message-State: AOAM53302ZTfBWuEgz8T7faXe916bKPDC72sSuTNb6LlYS58CoADGCgE
        KSScIr6SEpSpbQUl6S4NQlw+V94717SnLwCM+ZY=
X-Google-Smtp-Source: ABdhPJypmIc9P4ndjlqjZw1EOmX3Z0mjRXBewAZ/NAZYVL6gcpbOlaK6J4USq0eoog9skxDpyTHsu1lE0ZV4wbg89/w=
X-Received: by 2002:a9d:6851:: with SMTP id c17mr2409580oto.89.1627029759154;
 Fri, 23 Jul 2021 01:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
 <patch-1.1-fc26c46d39-20210722T140648Z-avarab@gmail.com> <xmqq5yx29nj3.fsf@gitster.g>
 <87mtqet5aw.fsf@evledraar.gmail.com>
In-Reply-To: <87mtqet5aw.fsf@evledraar.gmail.com>
From:   Tom Cook <tom.k.cook@gmail.com>
Date:   Fri, 23 Jul 2021 09:42:28 +0100
Message-ID: <CAFSh4Uw0H-HHfEYZbqkzXvFu29oisRL71x7qp+=vu3mtoVMnkw@mail.gmail.com>
Subject: Re: [PATCH] setup: only die on invalid .git under RUN_SETUP
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 22, 2021 at 10:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> Anyway, if you're not happy with this pretty much as-is consider it
> dropped from my side, because I think the next step would be to do some
> more work on e.g. split up RUN_SETUP_GENTLY into a mode that makes sense
> for "diff", and another for "bugreport" and "ls-remote". I figured this
> was an easy bugfix, but if not perhaps Tom Cooks wants to pick this
> up...

Just to note that I am following this conversation.  I don't have any
time available to look into this immediately but probably will in a
couple of weeks.  If it's not resolved by then, then I can pick it up.
But please continue the conversation; I've no familiarity at all with
git internals so the more detail that comes out here, the better.

Regards,
Tom
