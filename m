Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C34CC32774
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 07:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbiHWHEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 03:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbiHWHEV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 03:04:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCAD5F203
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 00:04:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r4so16804076edi.8
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=u8yARoeUL8Te1FokMJncIPCdYHcBF5xCbM1qCLShUkE=;
        b=CH879ucEWiWsD26HVIfYxjJqNqVhvKK7B637awQeb/slQtU+XQN5cMBoAhst4RIN/Q
         g4c7MHM+9z/Gi7V5Gfp2BWxDWmFLVO+GuPdNAUT4PLBkA5ItMbmoQAUTnoNv/M6iEABk
         LlAHfbvWY/JnnhlIY11eRAJiJsWDNZOw1go6WO8wCYgv4CL2ujiIpUuFZqdBzrJ3SFz6
         HlgbyMEGqMlz7M3/PMhunIPpbqMS3QlHIapIuSBN/Puxh22dX6YdjWAOjEKS6Y6rIkoA
         s302SNi+9Ymc87kBewfE0JMHKg9pvDKQX7zBhnTHOvjsGSC+4lkKyiElEDEAFCnobgDy
         76xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=u8yARoeUL8Te1FokMJncIPCdYHcBF5xCbM1qCLShUkE=;
        b=WXtQWGwss9ikhds7Isb3akNxEnDc2nD2rBZKNpXdNASSNsvUzn5j300DHiFuqYEtwe
         gcLPEsSg5XLnWEtJ2hqNQCfX0rFphS/Wwoewj3/lYtDJfQka+k7Xm8DXKPU71RtcZ3W3
         qhK0PW5Rxrpb1pHR+6fnIi+xAP8eaTBb3/4kjMygzwP8clxjGAiDMPM7KQGa2TAD7UZH
         RKaeY2V7WhhC0KTUAM36L9qcG0Zi5HCGvb33WnGkEtVxobFtBarVWkpxlusBXYJ+0ykF
         Ri8FBbOui0bTPy6BRBYvBH52n6sJ8EkdUagAbV8uRz5iiQj7KHSWiznkZD2iqsTFE3wp
         Wfvw==
X-Gm-Message-State: ACgBeo2Tb38uCl4ZJ11V2kEhuyQX9Zzfy9eefM3ZRRNqg874Lis7b1Qt
        Ze8Ksdv6IQ25J6yP2JEFGjU=
X-Google-Smtp-Source: AA6agR4kjbfvcGJEJMm+qnrdmb2RoXr+26YOWfq+TzOu5dRty7hw/A40vc+i9GXT1kMMO/T8nyn0dw==
X-Received: by 2002:a05:6402:2b8d:b0:43a:5410:a9fc with SMTP id fj13-20020a0564022b8d00b0043a5410a9fcmr2451130edb.99.1661238259696;
        Tue, 23 Aug 2022 00:04:19 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id lb5-20020a170907784500b0073d61238ae1sm4522203ejc.83.2022.08.23.00.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:04:19 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:04:17 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] promisor-remote: fix xcalloc() argument order
Message-ID: <20220823070417.GA1735@szeder.dev>
References: <20220822213408.662482-1-szeder.dev@gmail.com>
 <xmqqh7249b8d.fsf@gitster.g>
 <xmqq5yijahpm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yijahpm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2022 at 06:09:41PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > ...  FWIW, "make coccicheck" with what I happen to have
> > notices it.
> 
> Oops, that was a serious typo.  "notices" -> "fails to notice".

Hm, that's strange.  1.1.1 did notice this transformation for me, as
did 1.1.0, 1.0.8, 1.0.7, and, contrary to what I wrote in the commit
message, even 1.0.6 as well.  (IIRC Ubuntu 18.04 has 1.0.4, which I
didn't try, but if that could notice it, then we should have heard
about it from CI.)

$ spatch --version
spatch version 1.1.1 compiled with OCaml version 4.08.1
Flags passed to the configure script: [none]
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE


> > $ spatch version
> > spatch version 1.1.1 compiled with OCaml version 4.13.1
> > Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc --libdir=/usr/lib --enable-ocaml --enable-python --enable-opt
> > OCaml scripting support: yes
> > Python scripting support: yes
> > Syntax of regular expressions: PCRE

