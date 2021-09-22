Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1BEC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 07:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4133561215
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 07:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhIVH4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 03:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbhIVHz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 03:55:58 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0F6C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 00:54:28 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id x74so1981911vsx.13
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 00:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNofj9qqMp/ciAz48J/DwGqkYukWuNkX26PTHyuRRt8=;
        b=q7IIap4WAjpO8c+O+vODn4XRtHk9QpyYtgD/TwwiZDilDm37jRwx+pTIXONl1Zfob4
         vpa5YpLza50ymdujMCbaf0jtfQNlo/m90igMgVhjl1ppYbSX46dn0gmfBQjkAAXZH+7e
         D+ChlBfNUTiDaqfz/Fu17ptSx+CV2naM7NbFMT3NxCJ6C6BKRyi+cOWZfryGk1vMJuIE
         Ru196hKeZMt9ySgddI56CQzOAI1WWNdUE4SWUXVmwTr7plw43bD7hmiH5S7q4LHpVR0H
         3rW46qpbYzlv+3jbjvyOD+E63tUJIzPOuXCsu0IkAIKTIblwyDBoN5kaZe7N8YD4b3LD
         gyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNofj9qqMp/ciAz48J/DwGqkYukWuNkX26PTHyuRRt8=;
        b=p/6StyPniPdmZPNdEY39wMYtgt84Jmgfg8z8bfhUfB6VQwKpODh4m5NzDf0C1hVhvj
         SVW1j3bToTGSvTu2y9R0PJOLLdjeEfOJ8JuedJLBDEB9AHUPhyYV/b+PBFkXo4gI62XY
         dEMUwsBJm4k2w7IJO9pcmuvccGRra14yj6xrHIpVDdedaotwUAPS653aVGWc1ZGl0StF
         34rjtwHj8Fl9BFfdHCX8NcAA6syGFopNePpEn+juDEtusWIUsKMrMLuLam70o1oXrFBo
         pvXAzXypDAxykMDYp1IgpS0jeFbB2QCfu+5JegHniw5jKeQv29DjR3tU28NF9b2uMSTy
         9YMw==
X-Gm-Message-State: AOAM530OOvnbczZZ/DJyjyFKakeOyHc2OnbN5pfIouOU8RB+4lU40mM/
        AYztqiYkuU3KKduJZwP3rBfKRqU5l2pUN0rnhtnxW42n
X-Google-Smtp-Source: ABdhPJxcj/V6Lv3PcGH7nJMJ+Vf+g5Odi7niCvy0hG+dHLlXqw1KatwOs6WoAjER+O0UbEYTlchkACWdOY1g2iIbb4M=
X-Received: by 2002:a05:6102:1d4:: with SMTP id s20mr1254111vsq.3.1632297267986;
 Wed, 22 Sep 2021 00:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
 <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com> <patch-v3-3.9-76f57eadcd-20210805T103237Z-avarab@gmail.com>
In-Reply-To: <patch-v3-3.9-76f57eadcd-20210805T103237Z-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 22 Sep 2021 00:54:16 -0700
Message-ID: <CAPUEsphB3cdCx3js3-_7-o7nvqsREPcqLwsTwTfaRDNT8v863g@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] test-lib tests: stop using a subshell in write_sub_test_lib_test()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Why does this need to be independent and can't be squashed into patch 2?

Carlo
