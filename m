Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4376C77B7A
	for <git@archiver.kernel.org>; Fri, 26 May 2023 21:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbjEZVGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 17:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEZVGl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 17:06:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190FBBD
        for <git@vger.kernel.org>; Fri, 26 May 2023 14:06:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb7aaa605so2574087276.3
        for <git@vger.kernel.org>; Fri, 26 May 2023 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685135196; x=1687727196;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+RXWW4T/5aPVZ3oVUG5pereNr9um2gE8P1kdN6l2SOs=;
        b=7c5R7vOCSphNQ7saTnw/rFhhf9rPqyh5/wecBKNfH5eV/aay9wCFk3sd4w6xtrSVW/
         ZMmpiMFGosKoPjBmh3nxx8ZJNgqY6+W9bOfvJCPhdl8kYuID3tKdG2Iakdz0Tfu3TuoP
         TM9HFyeOtE698xtKVe4K3wRjcNhXIFpzTKidWv+PD+4mmVRLo/93JW/m6pojZDDIUvMT
         j1bYk9K6zwuA6xJMItsMiz8kygbue+9M57v9xG5soal1oYsSsXOECBP4roqmPHEFItJ6
         dP/wJ6GEAY1geMxd/n9B4ekinZllJf3g9uIC3IsOuFy4kESdU3YE1fxhojN4Y4nH/2jD
         AbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685135196; x=1687727196;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RXWW4T/5aPVZ3oVUG5pereNr9um2gE8P1kdN6l2SOs=;
        b=XsL6BSYpJ+MoViHo4VNEt+f6fEirHSfrYjFeGe2c5U6Yz5Tg9MnSb7Du3Fkv2+C8Pv
         biha3SBMmGUzoAxoNpmQ9zpISGNCEQmuA0MODdEnDblYGrk+DSGmUHHYTGHWJuzLoOaq
         Qm5uoq0QFm/SvP/XxGHFXxzu10wCJ+IAewIuvlUZOeXINNCDj9Z0jlqntzteNf6pAe4K
         k/5RoC6smpjyFugJlrbit2NJXUd42MZatwWjDZigS+Ub5/WX4zV8u3wbVhfjgOXe4zC5
         e05REa45O1QIRKsYjM73+GcLb7tkisvjVOuc2mEhYHJopP0ILgPCdz1BBrewVbOU5uqN
         Yerg==
X-Gm-Message-State: AC+VfDwuT0UT8U5xIO5lE1cdtCh8QwaZngs1YCOK4raR0QYO1ua8iTnV
        VXUwZpcH/WOICC68JJWCbiHPPyT7786Fi+GDWiCr
X-Google-Smtp-Source: ACHHUZ7CTp1PzqSpJv5Nv+vPohO17yru08BYdrjT1d1Mn9IKEcYpwlMP05cRmWOe7OgK+YwvA/Jumd6RydQUTGWghGP+
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:4ab8:70ac:b28a:a7ab])
 (user=jonathantanmy job=sendgmr) by 2002:a25:dfc8:0:b0:bac:3439:4f59 with
 SMTP id w191-20020a25dfc8000000b00bac34394f59mr1655159ybg.2.1685135196385;
 Fri, 26 May 2023 14:06:36 -0700 (PDT)
Date:   Fri, 26 May 2023 14:06:33 -0700
In-Reply-To: <20230523192949.1271671-1-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230526210633.2290844-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 1/7] strbuf.h: move declarations for strbuf.c functions
 from git-compat-util.h
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> While functions like starts_with() probably should not belong in the
> boundaries of the strbuf library, this commit focuses on first splitting
> out headers from git-compat-util.h.
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>

I know we don't follow the 50-character rule for commit message headers
all the time, but I don't think it's necessary to break it here for
a relatively simple-to-explain change. Maybe "git-compat-util: move
strbuf.c funcs to its header". Same for the other patches.

The patch itself looks good.
 
