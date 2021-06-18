Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55929C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 23:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D861611B0
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 23:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbhFRXqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 19:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbhFRXqo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 19:46:44 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33937C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 16:44:33 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id n20-20020a4abd140000b029024b43f59314so1061462oop.9
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=OTtTc1g/NbUKTpveD19zdhQt51O6HqiMvue3AoqX0cw=;
        b=e0gbW93qHH0QZH6sXrknMInhm0ARRpHM64hqRtS6zFuYGJb3Wt5ckOO3ggA5ovlWZN
         RYTiVgvdJcuLdQfZX+HuWqs0Gu6ZIqG0T7gdm0gMdyiisRJvyEizX0NUGP9hLy6CL0C2
         S+4H3kYgQiT9ZSCP/dzKD71+w3/WLWEDENJV1mE0QLpW69O3Iivd3CyEwoY40smADQt1
         hyVo6b6NaIWTMeoCFEWjZWxhAO1MGrkkjbr3RSa5d3qGJQTFLl6jB1m9QEvl4YAtHuJr
         VvfdFVtmR0Cw+AkeDur34CHf53nunzjV9VqJe3xcN9Ma9kFAzXEvtuGC2Fa5U5UM7H9M
         5ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=OTtTc1g/NbUKTpveD19zdhQt51O6HqiMvue3AoqX0cw=;
        b=eUn1hlR3yuXngHq7tqhmjyEKkrrZAIFha9U1C+vI11j1TPQrIfi78u+XPv4dWgQV2k
         LfOcHgojE30/SZ05wmpjZgDIVYr7jfIotNV2oiiAmI/AZpRqYbDMiJX2o06eMCwxX11S
         R1K9G+jdrSrED9+XUfymVWd/3LcOxLixe1AaGGUfbTPVPOPRXVIC/zElp0RaLYdqq4LD
         C9F85H98SEw9UFRWZjMw3u/bvtDTzKqr9pT7mRxQQS9/kPPAII75BwBMBIxfLjErgyO0
         DjW8ZO8kE0lpeIp6sJuWQtip1H8oGTQ2B7UQOaEiM4HAfKst9M3gYtbMejONo5K1+Ach
         i+4w==
X-Gm-Message-State: AOAM532sBafgsQmJtEHe9ulSLL8KGo11GaeypIzDSUxHp7FqlTitgSqV
        o87FY9RB85Wr8gljD6cVi5mVfrN4ywim6w==
X-Google-Smtp-Source: ABdhPJxOS7Ugh+JSVClL0eybSU4TiyXsqCYhWCOJpol/ECwqFGrz5YcnQWlhUosKUCaNtzS2et8tjg==
X-Received: by 2002:a4a:9c8a:: with SMTP id z10mr11033165ooj.56.1624059872612;
        Fri, 18 Jun 2021 16:44:32 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 79sm2358114otc.34.2021.06.18.16.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 16:44:32 -0700 (PDT)
Date:   Fri, 18 Jun 2021 18:44:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Marco Giuliano <marco.giuliano@tesisquare.com>, git@vger.kernel.org
Message-ID: <60cd2fded6889_ca711208d7@natae.notmuch>
In-Reply-To: <CANLwWg4hG=iv9qjOmGHSJ7z7Y+vvvP+x0o3DfR5bH5A-C6_7aQ@mail.gmail.com>
References: <CANLwWg4hG=iv9qjOmGHSJ7z7Y+vvvP+x0o3DfR5bH5A-C6_7aQ@mail.gmail.com>
Subject: RE: Nonexistent changes appear rebasing but only with
 rebase.backend=apply
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marco Giuliano wrote:
> This might not be caused by rebase command itself, but rather by some
> previous operations which might have accidentally "broken" something
> and that the rebase simply makes them appear.
> You need to know that commit 4 is the result of several squash and
> reordering of multiple commits; is it possible that some of those
> operations have created some "leftovers" ?

Smells like the reflog.

Have you tried --no-fork-point?

-- 
Felipe Contreras
