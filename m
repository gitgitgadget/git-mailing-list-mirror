Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63302C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426A061040
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhJHUOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhJHUOe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 16:14:34 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3066C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 13:12:38 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id f9-20020a1709028609b0290128bcba6be7so5489003plo.18
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dDYhDNvDJJutlbZatGIhggSLxPi7RhFcU/f1uPRvmJo=;
        b=sbYHl+LYnwGEI0xNgIQnZIrlx0WA1HicSMUiW3ejZEzbp+9tftfP1zzQELlg/mF9LC
         Mzt9vLEy1GNIuf9Zi6c+0ihi+KP8RB5cDmAqN2aSfe4i17KQd1Vv6aWbHR+Ziuy/ybgK
         FolD4ruRbJs7/cInNHZwQwW0PK/W8GbwctkJkNvp+oLarrjrdfFT5rqaNH79mrzh4U68
         7mNi/H9gxU9QzZJ3gXxBMbdmnMXno5fxOp2h2nn6+P3n+kMdheqQSRTR5kHFFCuujgse
         EeOWyi2ldOXCwcw4gUQ906xrW8ScHr5Ik7qNKgvpYNEtEGXf4u8LZbsFAGmuNDVSzvoD
         5TIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dDYhDNvDJJutlbZatGIhggSLxPi7RhFcU/f1uPRvmJo=;
        b=2SaWr4RvvrtM8L+/F2NLcygHks7W0MQzLZWXtRgzjlmg/CDStyrPo5bl/N++kY2MT4
         WWhTJh+8ISl3jujD4BbMU3xkG+gdF0Q/7ZDpjGtN73MIq6ZJS3lHmBqomeIJ2X7eBCmJ
         1GcR37CKRJ1k0NgyHLlbFXZgbmAsMgN1py4GhVIXfix0kkqJSOQ5sknILn3gMoJr4I7Y
         vkw5pRTF7DIg1kj8Z+18C0wBjtJvLEAxRCY2xYMjw1/V9qYMlGCk9zpQ7Z4qLJtE2bpZ
         9oyti6V8XM1qz3rGkkN6Z2WS1/fcBAYky/cc1cJuxh/TMI5lBcRnavn2hy2ufgX0V67R
         +rGg==
X-Gm-Message-State: AOAM531EnxvYz/eNSHmRp5lQB8sekfrI6X1GVT0pvocO19BzsTJ1wYZ/
        LntKPpsUoZ2M/ai9MPMQUrDifewOlA6bSMH/SgJo
X-Google-Smtp-Source: ABdhPJxmOzL6Juf79Eb7z6rj31Cr0dI5GlLNnOI8OEO/VAxrS1ajF7Qpdi2dpGpmpc8jZeYKJgqUxnC97cXC6CT10tna
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:bc4:b0:44c:a1a3:5c20 with
 SMTP id x4-20020a056a000bc400b0044ca1a35c20mr12090394pfu.55.1633723958233;
 Fri, 08 Oct 2021 13:12:38 -0700 (PDT)
Date:   Fri,  8 Oct 2021 13:12:35 -0700
In-Reply-To: <kl6ly274y6l6.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20211008201235.1324349-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <kl6ly274y6l6.fsf@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: Re: [PATCH v3 2/7] refs: teach arbitrary repo support to iterators
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -1139,7 +1142,7 @@ static int should_pack_ref(const char *refname,
> >  		return 0;
> >  
> >  	/* Do not pack broken refs: */
> > -	if (!ref_resolves_to_object(refname, oid, ref_flags))
> > +	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
> >  		return 0;
> 
> Nit: It would be nice to have a NEEDSWORK the explain why the_repository is
> hardcoded instead of the commit message. Without having something in the
> code, it is a little surprising to see the_repository when we are so
> close to removing the_repository from refs/ altogether.
> 
> This in the spirit of your check in patch 3, where we explicitly warn
> readers when non-the_repository is not supported.
> 
>   +	if (iter->repo != the_repository)
>   +		BUG("peeling for non-the_repository is not supported");

This doesn't bring us closer or further from removing the_repository
from refs/ - originally, this call to ref_resolves_to_object()
implicitly referenced the_repository, and now it explicitly does, so
there's no increase or decrease in usage of the_repository. I think that
the true NEEDSWORK is that the entire ref writing system operates only
on the_repository, and this is probably not the place to note it.
