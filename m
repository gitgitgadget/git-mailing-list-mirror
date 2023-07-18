Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22D2EB64DD
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 17:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjGRREY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjGRREH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 13:04:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B343171B
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 10:03:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cac213f9264so5760290276.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689699787; x=1690304587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Rxk7i1zRXK6lEPTcfgTQvpYLWzT9wrQrd542TMTQWs=;
        b=PZAFIEOUNOvZSIK7avg0gcePR5rnvzILahRRiu5wcWEa6KdT/YQ3AIc6zWm8CiecFa
         cDihIIhOhu5+Qd+dghZdwY9wrfF24ofcW71j4auSAczjA1tzoRd/fFsbE3OF7UW2Pwcq
         4sYe9a9+/lyZoanpUGPm4E5d9cAsWHjdjQLvrQONaHQTFwpQPlK0FlPtNfcMtSxm8SS6
         Bhasl8nk59FzHM4Whmh9ExX6hk/L8Y9OeTi7EVSkH9nd94NsgP+JH1J+UVg/XLSM7Xfw
         uGA/UHLWfeIZ3FX6b2XJG4uIs6Ild7WRnUIZuBi/pmGQf/yk/MfeIcDlEIXPyJo3jNjk
         QU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689699787; x=1690304587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Rxk7i1zRXK6lEPTcfgTQvpYLWzT9wrQrd542TMTQWs=;
        b=YwSIfHApUGdEwSoJ0bDCwLfzwRPcu+67m8cqn3XZWsglOWWXdShbUTKeYhPqnX2HJS
         WF0e3mZ6hct8qyJCjB/JEkk1lyHLTVxsuiSADmk/m5AgyQD+wKBr8AGXVZvQ1wib9qgq
         lxOmT4EQo/wAxlksbroUkkj26KwxIwPiQ1JXyEdjWN84H6GyRYDRcADWCs5vKnOz+WIy
         UwcpHWWJDDNR+prgFzeNHlLnA1CJLja9QljmUbgKpxk+7waXVFi037bNO3cbla3AYvgn
         p0/AUDWNEDB7XiG366NuoNplFoHrOHtDE1HzUf3PBdHaAuoUrzANVdvmNocFJxjsuj8a
         cQ8A==
X-Gm-Message-State: ABy/qLbTICepL1FY04QrtiG5Pu4a5LF9RA9a8ckAA+QR2hnhEsuUBGSQ
        DyAnBlc5uTpzrK68qJg8k3HKLXb7EvdgyOB/k0EYOasRnr3eRhHHUrspne3yEjlaEG9XweF4yak
        GYWmcx+CiL0tlRIreSW1yodRQVhyUTcvb6SPHyPp4AvijRmrMIuJlYjiUSM86Hyo=
X-Google-Smtp-Source: APBJJlEh8kl6vp+Iid7eqyhh9mZJSSPUGDmm54zVgI/ewN1qD6NAz+RhXcIo49O7Gy/RVDVja9NbeKx3JZ+MDw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:849:b0:ccd:1938:58c4 with SMTP
 id d9-20020a056902084900b00ccd193858c4mr3546ybu.13.1689699786832; Tue, 18 Jul
 2023 10:03:06 -0700 (PDT)
Date:   Tue, 18 Jul 2023 10:03:05 -0700
In-Reply-To: <kl6lilai18zu.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lilai18zu.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <kl6l7cqx17au.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: Join us for Review Club!
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> This week, we'll be discussing Andy Koppe's new ref format specifier to
> pretty-formats [3].
> ...
> [3] https://lore.kernel.org/git/20230712205608.1806-1-andy.koppe@gmail.com/

Correction 2: The most updated round is at [1], not the above-mentioned
thread. Thanks Andy for pointing that out.

[1] https://lore.kernel.org/git/20230715160730.4046-1-andy.koppe@gmail.com/
