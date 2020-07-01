Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9912C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 17:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C6B20771
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 17:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2t/XVAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbgGARuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgGARuB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 13:50:01 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D095CC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 10:50:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 145so20546580qke.9
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNSc8AMhwog0EjXW1/BLbamhG2fO8WYY2MMFa+lzr18=;
        b=f2t/XVAnrRipYJH/Q4vbC/Kl2qLUiBgm3asUW3/Q0NHjkAhqFL9o140RCQLqhLeXiD
         mml371TKno8KoexIDvCwppQzPZm/HTr+HRMg7CZJbzPN5MUYexoALoH/x+0wFKBjiI3S
         uzV6AMfmUT4K0e+8WTUb/w7t9ul5x7L1szsenRKesxBvRDm4jysE/WIa7y1uvCSoHy5i
         R41MpoSZqcx+q1iFszls4PT7qBgURfs3UBPpCkPkY9Q4u7brLUpaQNlVVhbxUXZKnS6e
         m6rhECe+tUC8DEGdWKZiIkfr+BWQFTFTGSClNFeLoTua7AmYNeOG3TMo7NUaNjoicX5C
         K+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNSc8AMhwog0EjXW1/BLbamhG2fO8WYY2MMFa+lzr18=;
        b=rK0gumZv8RtF8LHsAE2FTsDW+VEmdxgA1ecItRpZXbQhztfbA+3zvyuI6qXH6DfnzT
         9tP5oDrfUcDXQglRVZaYLUj9vsU/nO+uXDvtsebJJY0h3mBGT67ISGFDGakk4YVG8JXM
         gE0d4r7BFHFlH/vobgNQTdiBkD/jNcZm+jiSdvdaJYB26Al3hWEsX+cJ07tb8+K53GL4
         jagJd3EYHuPKVfKI5mnwVdmfbctMtUfEU663hbJ4I4Hh8Uf/D+9NtLSFWTi3+PqnE4bU
         73PQgwWGnU5HBFPUq5Pp8/Gkq8I0aEIav7MNnXzfqqZJRD8RZvGwOHqtECkPuKoFfTB5
         6Wow==
X-Gm-Message-State: AOAM530tKwiikw+jIQaNB2KBERW37yx5/Ut0sjYSt4kscLh+CKGlp7le
        sGGpNwOHQZ7twHZvBK3Ulv+7GWv/gbGBnZv7KiRjfA==
X-Google-Smtp-Source: ABdhPJxvHntUW6ETEVVhl/O4iSEI7E2Q75/mMwog+YMeqXNcgOI3NA/ZbgrWD23gQo9Wt+Gp1yH0khXZ116C4Bqo85U=
X-Received: by 2002:a37:84a:: with SMTP id 71mr6912416qki.77.1593625800008;
 Wed, 01 Jul 2020 10:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
 <pull.614.v5.git.1593187898.gitgitgadget@gmail.com> <10acdbf5e4d4c49f69889ab1129d3d6b5a7fd754.1593187898.git.gitgitgadget@gmail.com>
 <20200630072521.GC1962986@gmail.com> <CAKiG+9Vws-_6rYh=Kcc2W3qbo_7LdxrE0WGPwLmGGewM+VqcVg@mail.gmail.com>
In-Reply-To: <CAKiG+9Vws-_6rYh=Kcc2W3qbo_7LdxrE0WGPwLmGGewM+VqcVg@mail.gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Wed, 1 Jul 2020 23:19:49 +0530
Message-ID: <CAKiG+9VSC1ee8ck3Y0Xs4QVGudi4kG=Xc9M3-cRcru1jcLkpnw@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] cmake: support for building git on windows with mingw
To:     David Aguilar <davvid@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for top posting, I realized it only after clicking send :)
