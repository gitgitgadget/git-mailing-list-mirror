Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999AFC77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 17:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDNRgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNRgL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 13:36:11 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883DA136
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:36:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id la3so18842334plb.11
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681493770; x=1684085770;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnhAxfp1jZ/UTqAS8bPZDaMuM6eXUx2oRejfg1Ywkf0=;
        b=mV3r625ekgGaPVWa1W9fGbJSfL4Xd3FpNJB3FTjYcDZfm2vlROdVOUM+asm78yBH28
         I6N9ewiuMau4Ndu0TonRJfygIcvCFnpVvzfqptIj/5Zb6KWq1C53pMKlu/hKm2A8P6vP
         Oo20hpyLnrpO7f9JOwJESrhAuomYATQhBUWCfatfhrhUqLeIzpx8Fm8CE3jPHRfu2G97
         p8Eg83HtQTbQ+V9UrhLb48OKbrSk5axaoOVyJjA93Lv4SFJZKzUnWNqkkgzq8487qZbC
         u5mrB5BjcYSCb+Tk898ap3+BfYRSnXg1JzZYYquZ/v0ulIUmmKAdV6dYKtNfhK1Y6zpw
         63og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681493770; x=1684085770;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CnhAxfp1jZ/UTqAS8bPZDaMuM6eXUx2oRejfg1Ywkf0=;
        b=FSXtjQ0a1aM/X7CrjXg0B6JyYjk1p4wZg9wp+XT1uI2Klyffn5/TOXjCnp8nF6mNaJ
         0aSY2Q1cHAY+M5pwwL3dzOxHjHYBO+xI/mZlc7DOCUb4BVcvoIpUn+oUynpzEKu80ZsF
         QkSS6PfVxY3FvFLAE88whRtACWVPFXrVQa6xy/ja7ft+6ZSSLI7n+gjy+Tjg+hFqqWhc
         0//LdQH2dlB9GkiVlCJsTA2GVfwDVfZDrhDI3p1vSEmHOtNpJ44XeeKA122Qr3joDyKS
         c46ZE4AD3aQAJQAi7D2t6GowwAPxP8DDcuOycw8zvlc/49zbIE4HHwWTdwONuAHaX0kb
         wXoA==
X-Gm-Message-State: AAQBX9c9FhrTuXn4kN0OQgG6v2V4ws9SpEDK/kTQLFOSr1+Toak2Lj3k
        50873whvJnhOOAw9FtDFfi4=
X-Google-Smtp-Source: AKy350bzqpclmwYKN/kJgQO/KFxjMDmfNZQWzIzxirQIcuAFmjd5D5JouQOmp/cEovD0pUGOFGvyzQ==
X-Received: by 2002:a17:902:f707:b0:1a2:296:9355 with SMTP id h7-20020a170902f70700b001a202969355mr3622477plo.16.1681493769898;
        Fri, 14 Apr 2023 10:36:09 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id w22-20020a170902a71600b001a520f9071dsm3315802plq.7.2023.04.14.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:36:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] doc: set actual revdate for manpages
References: <20230413074722.71260-1-felipe.contreras@gmail.com>
        <20230414070449.GA540206@coredump.intra.peff.net>
        <xmqq5y9yv601.fsf@gitster.g>
        <64397d3d67d21_5e3ce294a6@chronos.notmuch>
Date:   Fri, 14 Apr 2023 10:36:09 -0700
In-Reply-To: <64397d3d67d21_5e3ce294a6@chronos.notmuch> (Felipe Contreras's
        message of "Fri, 14 Apr 2023 10:20:13 -0600")
Message-ID: <xmqqv8hyqsc6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Are we sure historical GIT_VERSION strings never had a SP in it?
>> I would be very surprised if we did, but the correctness of the
>> approach depends on that assumption.
>
> Why would that matter?

Ah, that is true.  What I should have worried more about was the
distribution package maintainers who may set their own version by
writing it in the "version" file themselves.

Thanks.

