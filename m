Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7060FC47082
	for <git@archiver.kernel.org>; Mon, 24 May 2021 03:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C30061168
	for <git@archiver.kernel.org>; Mon, 24 May 2021 03:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhEXDCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 23:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhEXDCw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 23:02:52 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12E7C061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 20:01:23 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id v22so25868341oic.2
        for <git@vger.kernel.org>; Sun, 23 May 2021 20:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=xhOFdCpi5AmjJmFZfEK3M3BQVe/VTgyx2Zu94spsOMs=;
        b=UGN9y5qCL3RIwPU96uG8ZTQ9nvIr3vrCj1HPTm0eaIQl9/OmLYqv5gRuE56WhvfA9O
         EtXY9dWjxUUHjcxNgiuCPSH+y6wjBs1g5klhRdgsOArzdXXPz1XizFk7TtRODSIS9L5L
         q68zKy5xTYxvirwnd5LNvbQmBPIP5o6XCr39yK/5TwRQc/Kt3yyAyPb+rfsYva0TQxXK
         abaU92zd7kI5GDbceKcnajwEreAUYVMomc1VASes2OPLW75T6KEFtLBI1h1nJZ9djMby
         Y2KpSYvB1/eIKsYH4lqtTUCRZ5gf//1GibUjoDEeBF4EOFGK+nXxgeHSOyPw4XXQydOw
         vgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=xhOFdCpi5AmjJmFZfEK3M3BQVe/VTgyx2Zu94spsOMs=;
        b=Kmma2JUoAPOfDRzkGQUGsg0UojJOG8h58e7E7RXoI35qgorLQ8eDIbWIscshoLdT+E
         +E2PcZOJYf1zFfAuXJn2aSn6whT51rm82Ok5iEM0aQWjIOzYEHvQHNqWfay9IaE9SHUE
         sZjbFAzMxIuJ7ndzO0LWhrx3DTxOdZbsuQQYv17XjZXZgWFjRfesj5lunN2a4qUJIXOi
         ckvBhG6t/33C+LHh2cbl5I7KMKrSG9X5jkSdaU0oNr7o3C9goXnJc+iXG8YE2V2FtCoB
         cTeBpPs35rmv93og7eY45LQiQJ3JVb6nfEdDq7aRJ0mk+oMw2r6xzaRi6UvEK5CcxC4Y
         kH6Q==
X-Gm-Message-State: AOAM530xeXPgE1k2Zvgg8Yc0ydfMvXDj8w/FRfue6SPuWWq+ZCktc8f2
        x9aqJ6fcNqVj2yEntoO2NyI=
X-Google-Smtp-Source: ABdhPJxyE/EgsnGBvmFGM/lmBcMi5mYTonDzclxyxVXAVB+A1nEV886U69jplwOFwVbnxet9OdvPbQ==
X-Received: by 2002:a05:6808:144f:: with SMTP id x15mr9368001oiv.172.1621825283238;
        Sun, 23 May 2021 20:01:23 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id z9sm2592960oog.25.2021.05.23.20.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 20:01:22 -0700 (PDT)
Date:   Sun, 23 May 2021 22:01:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Siavash <siavash.askari.nasr@gmail.com>, git@vger.kernel.org
Message-ID: <60ab17018efee_1691c20832@natae.notmuch>
In-Reply-To: <YKqzj/DZU8m9AaI/@coredump.intra.peff.net>
References: <87k0nt3f8i.fsf@gmail.com>
 <YKcTFDgW4etXFpOR@camp.crustytoothpaste.net>
 <YKeFxcTDp4tHSRu8@coredump.intra.peff.net>
 <YKgzvFHOcUgPjbj/@camp.crustytoothpaste.net>
 <YKqzj/DZU8m9AaI/@coredump.intra.peff.net>
Subject: Re: [Bug] git-credential-netrc.perl is not built and is not available
 in `exec-path`
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> I suspect that just opening a bug report against distro packages might
> get some traction (especially if it comes with a patch to create the
> extra package).

I have tried that; do doesn't work. If git developers have $x in
"contrib" it's for a reason.

> I do wonder if packagers are hesitant to reach into
> contrib/,

Of course they are! The word "contrib" has an obvious meaning.

This is precisely the reason why I tried to graduate "contrib/completion"
out of "contrib" to no avail [1].

If you want to install anything from "contrib" by default, it should be
"contrib/completion" first, which is already very well tested, and
shipped by many distributions. I would move it outside "contrib", to be
semantically consistent.

Then maybe "contrib/credential", sure, following "contrib/completion".

But to do a mish-mash between "/" and "/contrib". Does not make sense.

You can't eat your cake and have it too.

Either they are contributed, or they aren't.

Cheers.

[1] https://lore.kernel.org/git/1399607587-14127-1-git-send-email-felipe.contreras@gmail.com/

> [1] I was actually surprised I had libsecret installed at all.
>     Apparently pinentry-gtk2 links against it, which I have for use with
>     gpg. But my system might not be considered typical anyway, as I
>     don't use any kind of "desktop environment".

Unless you have a backend (like gnome-keyring) libsecret is useless.

Can you do "secret-tool lookup *" and fetch any of your passwords?

Cheers.

-- 
Felipe Contreras
