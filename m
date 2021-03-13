Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4688AC433DB
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 02:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C55164F48
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 02:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhCMCwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 21:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhCMCv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 21:51:56 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96244C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 18:51:56 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p21so17047556pgl.12
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 18:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m9r/qk3Sy1MjsN8zztL9xPIkD2t2bdVD+ZihYPO8sZM=;
        b=hbXzTG2IKu0Y6AdkkC9QYkOkK33WM42vMnZoOEkNsn03WzW0EivQ41hOTyRNycwM8v
         mFCSpd8zVYJQbjLv+/oUBWKWPyv2qSxbcAb8dugmQKzV6xasmW2zTUHMoaJRpWPTlolQ
         8XXd1m9kXcF38n3Mmp6KT8QXQbzC2gR90oIQTWf8Hp27cG2aI9KViwcrWbLn82s9BLUK
         nlYkLGM0Lma4gscxqlMamglyz/OCC4o9HTKsKXRxIYYdk7jGNcE+DqjUaFFVlQTubKxW
         9pQ1O9eIgxdqCQ7ncwkfEzRz5ltA1hamaPOK8IXeRu8zo+N+/wZv+7ymRB3ukCcN2GKq
         404g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m9r/qk3Sy1MjsN8zztL9xPIkD2t2bdVD+ZihYPO8sZM=;
        b=jwTdgK8Yea8+kU6XDmk17Tk3GdVvFVW3cEgdvkXx68YwcJYnOFcX6tT7gx9kp6/tkA
         iDOXRu4QjpN2X89ZEb7eltTYq76Or1hxYjm74D4jGtZZjyq9WqcGempWbbn+sRMzrrA/
         8igNc8zBcX9wqyMlTrlyaSmHcO83QrnfXPksv2SZT1KbuvQj2QQVOYkBP4PTu5dfJ6Rp
         +BOv7PGYkULDxPK0lHSuE5KaS5BVbpfadNwIqalOF5u+/nQX7uGn7NGeZR1OORO/nnhk
         7GDeB2JJhel9Tns4YOeVqbJPoCrXgvKritEA/mL61Z8cFLZYTsimZ2xSdUdCKjV0Duf6
         X9Dw==
X-Gm-Message-State: AOAM533GwK4SvY9Ul9BxzwKZaIKnrV3XkZBF+zkIGSYpZhUfThoFJWPs
        ya1fHhfUWr1g6RfKLkRrrqI=
X-Google-Smtp-Source: ABdhPJyVFGYFuBcfM6KF5NLDpwKs/hVlU/J16CcH4e/IR3IRIbmXiuZe/19DCH924Jbg3JnP6YsMQQ==
X-Received: by 2002:aa7:83cf:0:b029:1ee:f550:7d48 with SMTP id j15-20020aa783cf0000b02901eef5507d48mr15489044pfn.12.1615603916135;
        Fri, 12 Mar 2021 18:51:56 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a1e7:6707:cbf6:696d])
        by smtp.gmail.com with ESMTPSA id c12sm7127155pfp.17.2021.03.12.18.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 18:51:55 -0800 (PST)
Date:   Fri, 12 Mar 2021 18:51:53 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     John Ratliff <john@technoplaza.net>, git@vger.kernel.org
Subject: Re: git credential cache and sudo
Message-ID: <YEwoyeYM7ac+6aIx@google.com>
References: <CAP8UukjW_TeswTHHfiwzc989U+wZMVcHeS1siRF0Rbg5nc3D5w@mail.gmail.com>
 <YEvPQS1+1sxd/aGw@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEvPQS1+1sxd/aGw@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Note that it's a little funky to be accessing the cache as a different user than
> the one who created it. This should work reliably when the cache was created by
> your normal user, but then accessed as root, because root has permissions to
> access the socket. But if you spawn a cache daemon as root (because the _first_
> operation you perform is as root, which automatically starts a daemon to store
> the cached credential), then it's likely you won't be able to access it as your
> regular user.

I wonder if this suggests a missing feature in
git-credential-cache(1): if the manpage advertised a way to launch the
daemon through an explicit command, similar to 'ssh-agent', then a
user could run that as themselves before running other commands that
communicate with it as another user.

All that said: John, why are you running git as root in the first
place?  It's likely that it's safer to run git as a different user and
use a separate command such as rsync to perform the privileged deploy
action.

Thanks,
Jonathan
