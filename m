Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4848C47076
	for <git@archiver.kernel.org>; Fri, 21 May 2021 18:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FD561164
	for <git@archiver.kernel.org>; Fri, 21 May 2021 18:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbhEUSja (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 14:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbhEUSj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 14:39:29 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25CAC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 11:38:05 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id x15so20487464oic.13
        for <git@vger.kernel.org>; Fri, 21 May 2021 11:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=fN7ITp12lgBL/dANz+cRW9dd4t0gk2yH2t3UXo0mxXo=;
        b=bKeoEJwP3RW6asi3QdyjwAIGvFQZThIcDYo1YKlGBvu3Dq4vsUI6sD3sNr7gYp1Xzh
         G7DgwhlBVDvVnHR2ooJFo6CgnRoOxrnpp+2UgOYs2BPBE0DNpux0n3klErPc66Bew27E
         rT6Smh8aKP5LI9lCjo+hH/YHGFe6Gm9AY9sP1z5/jve+Z44IJdiDu9Pcq4ZKB286cumg
         FJiUrkEi0VgrHkyJHH8TEU2KcJLacdoP05smNGYY8gydmP465YyeAJ4IsPvPnTnjphct
         aqR5aNreCqQsx+vxHTAefhcwCb3vaHbTXryN0F/BkHgbA2ljIrvmpZkLFhxsUk7IevQn
         0Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=fN7ITp12lgBL/dANz+cRW9dd4t0gk2yH2t3UXo0mxXo=;
        b=c7j0s44z9JDJD3vyn+8O14T+91zQNpMWP6cAFgriZttNFQwL00UW7KOo1/42H45ya3
         op2ffEuTG1sbOGMXShvnZrfZXETUfVBnL3I7pqBN7q2AS7KbtRfuCTssadoa1I+Sm/Cc
         vqmT62V/yk0g55yfQ1kFc2bJ0JDt/kO8Nw2PHWq40ZN6MZjB3EE+nn/3kKl6CPkWzxXF
         8CrodSQ+2Zk4/ajI2tyIF/bts0QR0HIQEeygqYiLI+aZBsc8G42a4G2G2JkpcmoXDfJf
         dTTP5rw8Orx2Xo8hG42PYejIg/bR4tSB291jP8x3Ybyr0zKXau5ZhBd/1ERluhu43fTH
         E9Og==
X-Gm-Message-State: AOAM532l93jdF18qKu5nSlzTHJLY4jcsqwmMIQDmWXj4Y+D3J51fn3l6
        bjm8SFb0nlErJIyA7kfmm+4=
X-Google-Smtp-Source: ABdhPJy4jvSxstNDQNDLwHiAt85tD+LvDC4eztq/qFxjNUEZvbyXlKfutZjQUXsbftLaSNhi8vBmjg==
X-Received: by 2002:aca:f2c1:: with SMTP id q184mr3123871oih.29.1621622285205;
        Fri, 21 May 2021 11:38:05 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id t26sm1258485oth.14.2021.05.21.11.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 11:38:04 -0700 (PDT)
Date:   Fri, 21 May 2021 13:38:03 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>
Message-ID: <60a7fe0b2dd8d_558062087@natae.notmuch>
In-Reply-To: <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com>
 <20210520071141.GZ8544@kitsune.suse.cz>
 <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
Subject: Re: Should we do something with #git-devel on Freenode?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> Of course there's value in coordinating. Everybody _can_ hang out on
> their favorite venues and eventually talk to each other, but it's much
> easier if everybody agrees where to go. :)

I don't think it works that way.

I "everybody" agrees to move to Discord, many old-timers won't. Same
with Gitter. And if most people were on IRC, many youngsters wouldn't
come.

There's a limit to how many chat applications you are willing juggle,
and adding one more just to chat with git developers is something many
people won't do.

-- 
Felipe Contreras
