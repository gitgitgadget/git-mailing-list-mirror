Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69965C61DA4
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 00:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjBQAag (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 19:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBQAab (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 19:30:31 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1BC3B654
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 16:30:30 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k24so3624509pji.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 16:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQDAV1NwnG1vnpo6V+L6xPCgJODkzDoX8bhoLEivpe0=;
        b=jMswvKQmLZVoHW8fkmwnhHvPVveZXea5fRA43yTdzSfwueHKVZwmSLTZDeNXziIbj7
         0pE9HJTRWaOCNJRlz9mG+S1qTRiy/wy+tLZ/FKBhK5iAcQww0zJ8aGHpV/pnC7EDP+1F
         n/ukcn6pf5Ex5FpJ7AEgNfUujHK/+giV7862ckr26JJgFtn9Mf++PiwWwZ8/zbSBOnfH
         JevktdRYQx/H5BRBKGc6RKybdNVjovZiKJ0h77bjpApUq9y8ZCxzARfZE4giQjK4oeFo
         LqanIq5fumEpSOnHLuZybEXD/xItvjJsSigsEJsmXGNfgr4/+Li3UEuFb7WfOps458oA
         IFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EQDAV1NwnG1vnpo6V+L6xPCgJODkzDoX8bhoLEivpe0=;
        b=FdHuEBHFQHYsK7dQAEGNdkJsbQjOkowZogz22u6QLIUl40JMJSFn7cJthEorJqgLW2
         Ro3YRuae/hiDrOJV/DDxK/hzdkque/7nq4inUf5ebFqKVOTLq3W35HfgvgreqV5sj3HT
         dHgjp9odIQF5J2uWorV3EqfM2/QfsjpZri2u3cyaTiQ4Na25pscxjgc7APwrNitknBhN
         eanrIz2Ak6pmtkFcg/sYmos2l9czTd4EycHKsaqHS+4Erb/8yLDDm5KBa3UZZhlPkjft
         4nGgqgfzZz/ErVJ7M4LywIG5KMTGvn3kPC+j4F/2IO1/6RmUA6d2ftHFI3Y2IvWEVpEY
         IIwg==
X-Gm-Message-State: AO0yUKU4i4p02xDTnDmxWswa0H8eG9CF0FTUjMFCinLNpieb4jYgFfXx
        ctpC/KaY7Dm3GwXoGFc1aL4=
X-Google-Smtp-Source: AK7set/sS3hT8u4AMMERDVR+88+FGNVbaOAgiDAfL8eYtNPDIm9hJHDDcWSsHYvj8gGjwSqgy3YVMA==
X-Received: by 2002:a17:902:f28b:b0:19a:f9b5:2f2f with SMTP id k11-20020a170902f28b00b0019af9b52f2fmr2547325plc.55.1676593829394;
        Thu, 16 Feb 2023 16:30:29 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b0018099c9618esm1858272pla.231.2023.02.16.16.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 16:30:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     tm-uzr3z@entrap.de, git@vger.kernel.org
Subject: Re: [PATCH] add basic http proxy tests
References: <c0862f86061c220af289ce812d57f9c7.squirrel@www.entrap.de>
        <Y+6WOF+OHX4u94Z2@coredump.intra.peff.net>
        <Y+6YgALh6L9m6rSX@coredump.intra.peff.net>
Date:   Thu, 16 Feb 2023 16:30:28 -0800
In-Reply-To: <Y+6YgALh6L9m6rSX@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 16 Feb 2023 15:56:32 -0500")
Message-ID: <xmqqttzlm8uz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here is that patch. Even though it didn't lead me anywhere useful in
> debugging your problem, it may be worth picking up anyway just to get
> better test coverage.
> ...
>   - I'm using a single apache instance to proxy to itself. This seems to
>     work fine in practice, and we can check with a test that this rather
>     unusual setup is doing what we expect.

Cute.

>   - I've put the proxy tests into their own script, and it's the only
>     one which loads the apache proxy config. If any platform can't
>     handle this (e.g., doesn't have the right modules), the start_httpd
>     step should fail and gracefully skip the rest of the script (but all
>     the other http tests in existing scripts will continue to run).

Nice.  I have to move it from 5563 to 5564, though.

>   - On the client side, we test two situations with credentials: when
>     they are present in the url, and when the username is present but we
>     prompt for the password. I think we should be able to handle the
>     case that _neither_ is present, but an HTTP 407 causes us to prompt
>     for them. However, this doesn't seem to work. That's either a bug,
>     or at the very least an opportunity for a feature, but I punted on
>     it for now. The point of this patch is just getting basic coverage,
>     and we can explore possible deficiencies later.

OK.

Thanks.
