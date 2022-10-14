Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9273C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 09:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJNJIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 05:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJNJIL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 05:08:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000C52B25B
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 02:08:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a67so5931986edf.12
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 02:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GImWgNGyHIjbU1dxHtXK6TB94HqKJsUgbfz6GIpin9k=;
        b=U77/HqxB4GCKVSkNarA8mr8R0RkRZArZ37DKhxxAivo/qcW544N4DGxQhLDJXf1HFx
         hAU9dJFXXmLdKCWEcD5nCujkvwAaXWuwSRxd3xCJB+JNlUZmwZHX1poAFykQ+Pq/yHgL
         sXbWnpjmEFxdY4bzW0++R+EpSa0cq5ouYoNfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GImWgNGyHIjbU1dxHtXK6TB94HqKJsUgbfz6GIpin9k=;
        b=qq2MInVxdTndLXYIvjwphJWM28/zCQMQOl4f3F6UA2uov5IsRCXvtcKzOgUx7TuET1
         QhOhE+c3dTOpDOSHZeNQBapu1g01N09OKN5OaRrDe0aFbAp5OQHSMl0oZ5LgTWhHH33w
         1ZxKLsdqFUdWpyU7m1pDxHsj+gV1TQkurur1IHD/OtyXOEtZW2QhXFKKsfnaL8PpSKSo
         uJImUJjzdm2Dto7d4fdUEU66qPRX+e+LrgBtBmXj7/3BN+9ctlXLQVes55Iox5AL6wzy
         UO7WzJIU0NjZ+GxjNys4sQUs5Vi52CJZ76DQDNWdW1paYpjbBIuA/O5SyI1/GDOVkQyo
         Gq2g==
X-Gm-Message-State: ACrzQf0H6jJOc4ZMhdki3IdXzww/fv6Jp6rzrvbWSWUnjSdOySu7dx/i
        EbuU0j56S/jx4bomFIZ7AVO94UxUtL2i9jNDII1rTsPXzdS9VaV0
X-Google-Smtp-Source: AMsMyM6COb7DTp39r9qLB307fJa+6IrU47OGkJemMmbicusSjcoeKj4ywh0Os3L9ivZhT8YnpgVUD4THNZ9Xp9jfx7Q=
X-Received: by 2002:a05:6402:50d4:b0:45d:fe2:45 with SMTP id
 h20-20020a05640250d400b0045d0fe20045mr3162822edb.221.1665738488490; Fri, 14
 Oct 2022 02:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
 <220930.86r0ztufwd.gmgdl@evledraar.gmail.com> <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
 <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com>
 <CABPp-BHaMCcLjdx2m4CALZQiTRQy_LovWfbdrga6XWhQJhoxWQ@mail.gmail.com> <CAPMMpojvDj7Yc27HKQU4seSqg5Tx61RY3LOgMfkK=a0J25QYQw@mail.gmail.com>
In-Reply-To: <CAPMMpojvDj7Yc27HKQU4seSqg5Tx61RY3LOgMfkK=a0J25QYQw@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 14 Oct 2022 11:07:56 +0200
Message-ID: <CAPMMpog94YUDPZswcGZ0ns10QXhaWOGmE95mgZEpdcx4GKsV3w@mail.gmail.com>
Subject: Re: icase pathspec magic support in ls-tree
To:     Elijah Newren <newren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Small typo / confusion on my part:

On Fri, Oct 14, 2022 at 10:48 AM Tao Klerks <tao@klerks.biz> wrote:
>
> That said, what "icase pathspec magic" actually *does*, is break down
> the pathspec into iteratively more complete paths, level by level,
> looking for case-duplicates at each level.

I meant what it does is *collect path matches* at iteratively more
complete paths, level by level - it doesn't care about duplicates; any
duplicate-detection is what you can then do on the result.
