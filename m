Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA31BC77B75
	for <git@archiver.kernel.org>; Fri, 19 May 2023 07:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjESHB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 03:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjESHB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 03:01:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D71E6B
        for <git@vger.kernel.org>; Fri, 19 May 2023 00:01:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510f525e06cso1082926a12.2
        for <git@vger.kernel.org>; Fri, 19 May 2023 00:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684479683; x=1687071683;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mQZdufgJiIX3g11YEvCmeZgcxN3pmF8Khd3/FJPjY+w=;
        b=QdC1liyNzdbnBT5/ra5F1nanaJBYu6moqU7Ri+sgluJut14Cs9JiQhU+0QyfhYAkXR
         Ois2A8D2Uj+ouD7eYBWA/joGjo460phaGk+ItVOABloqLj4qg++ln25wZu54Hx3pGoB7
         G59L4aqbeCPh8BSkGohE6Je3BpgHQhVP8EmU4ohCc0bIorWx7uGR+R18GX+qD4lG4KYH
         hQOD4FCi8gP/RQoonSaDhRAZ1F5kObDOV7XehyZxPf7Bpp852OC1mVQchq+qk8cxo847
         G2jQod/2t3JnujzZ3VIoOmqE7TgDrlcNoWq+LpciJf1K6OwB63AmioX81+CTxnEi4Har
         WN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684479683; x=1687071683;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQZdufgJiIX3g11YEvCmeZgcxN3pmF8Khd3/FJPjY+w=;
        b=f1KHMmyWkOhRYTpDkRKJku/dSzs5LtK1WwIOOiSmXKcqEKdPkfFJLkNcR4ijw/h163
         4yo/q/Gb+QDsP6bcqs+e+0g5jg0Um94X9nnQu+/oTKJxjQWgWmoA+SX1GhWyRzWmeWTD
         YSeQ87yg3p1W7Tk0phU4UlFoukWsNUrvbKU6rHf1Y6+SldOw+ScmuEyIBK5SbxdDXxi3
         KFVBMtvBdqm9ehaL3g+cprH3ZdvjBKz+/oxof2B+g6YpSTAq2ei4rvpvfWRpa44M1RRU
         UEuvRTFIGyT7iBYpeOLe3hbRCICnRXSfjdQIUAiP2sfiEDRf4vHZ5yVl5EPq9hR3T4rY
         26Sw==
X-Gm-Message-State: AC+VfDy88ae7J3teDLpUiC1OGzLJUHxaxO19t6hdRj79hPJa8gbB6DyY
        Pm/L0sNEryZrNES0RhDkK3V+zRD9OaXWiiDjA2nOiR5wny+Ojg==
X-Google-Smtp-Source: ACHHUZ4080jGgGgqt6en03ODI7iKTq+/eqbuZWNsmPIeagNZjvhakfDG3DHWD9KgwmRSwJC0LnI52APPQevC8CLn8Mc=
X-Received: by 2002:aa7:d31a:0:b0:509:c6e6:c002 with SMTP id
 p26-20020aa7d31a000000b00509c6e6c002mr690190edq.39.1684479683111; Fri, 19 May
 2023 00:01:23 -0700 (PDT)
MIME-Version: 1.0
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Fri, 19 May 2023 08:00:00 +0100
Message-ID: <CAGJzqsnS3SnoW__aPQ+13s+-b3a+makCjWxR=z6mjgBBnuKjLg@mail.gmail.com>
Subject: Which macOS versions does Git support?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi. Does anyone know which macOS versions are supported by Git?

Motivation: I spotted that git-credential-osxkeychain.c uses a
deprecated API. SecKeychainAddInternetPassword was deprecated in
2014's macOS 10.10 [1].  Replacement SecItemAdd was introduced in
2009's macOS 10.6 [2].

Further motivation: If I understand the documentation correctly, the
new SecItemAdd API has better support for storing attributes alongside
secrets, which might be handy for storing Git credential's new
password_expiry_utc attribute (d208bfd, credential: new attribute
password_expiry_utc, 2023-02-18).

[0] https://github.com/git/git/blob/master/contrib/credential/osxkeychain/git-credential-osxkeychain.c
[1] https://developer.apple.com/documentation/security/1393322-seckeychainaddinternetpassword?language=objc
[2] https://developer.apple.com/documentation/security/1401659-secitemadd?language=objc
