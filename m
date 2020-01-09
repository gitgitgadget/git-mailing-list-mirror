Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36533C33CA1
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 10:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0381B2067D
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 10:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ+JaqpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgAIKtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:49:06 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39711 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbgAIKtG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 05:49:06 -0500
Received: by mail-wm1-f45.google.com with SMTP id 20so2272903wmj.4
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 02:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yei++r+XR8nqTsaAcmx5X5FokVf41pGiC2ZJTBCbr1Y=;
        b=RQ+JaqpCSO/QK6Bxnf9HCGjeqx7stosLRPlRX9OUZobJpR0tz58XNskJ5r/u4HVAxP
         +WP91JMUKtf9CXXn1TSnPtaaO4nAOMbzgMxRrCmocxbB+SxhfgrGFKv+NBpngzTQJwlQ
         +MmaUv+Rv4znfJVeqtkUYTzb80TomM/8TXYxtquQm4Mq6h55gNc+5hgyymThR8WTEdKL
         WSJMuKHm2eVJq8CTc62T4f/izl0eD1CChEopkfAG6MvwFKyIEqyqdQBaGAdTKZUP2nMP
         NlXp9lse03HrAgsuOR/0Z6xLIZJc1Eird51pkB5jPHskWo+X4ebx+/OncCAXeJQatpgA
         yXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yei++r+XR8nqTsaAcmx5X5FokVf41pGiC2ZJTBCbr1Y=;
        b=ealHokuxMCA36ufCfc6nIXoHcKaxgDvVIDazh+srEWtEJzbjGpPWYZ0F5TOEnfwWUt
         jI1YAKLXxY8B9lVzxMc2Vf9a+nA0PksXIpu4XNVZ6TgUaBrRki2KyKukYJBh5gkbxWCl
         KkOtfzWtVYAhXg3UWREmKsFLXHboTLa8N6ajAtKOrpCayItk+CeWEJPz7BfXmGuTwBLv
         9RfKcHC3Ram1tizG4mSl0Phe9sYFK8FfBCzv0WeFDfblqHq7VUUj7b8y5IC2S8M0t5XV
         7cR67rpLfgCna5oTnOHyUsM9Y0lalmJou6/UyFy3Un1nQLvqmoWlzezCeUu6fgFYW7Xj
         WXkQ==
X-Gm-Message-State: APjAAAWhlvlgWloLfQfd0XN2tVQPUUchg8Ru7Jm5t+hL14eiCtWqMO1F
        7BUdA2WXS7HBH6WnPmWOlNqHI+ee
X-Google-Smtp-Source: APXvYqxxZlPItlyeBdrPLl1SV3Td+r2vcc3GbUxkmNRSln8SOlKKQt+YF8lozqjAmAgdKcHdxOBZYw==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr4242918wmc.54.1578566944166;
        Thu, 09 Jan 2020 02:49:04 -0800 (PST)
Received: from torstenknbl.mgm-edv.de ([185.40.248.10])
        by smtp.googlemail.com with ESMTPSA id y7sm3444915wmd.1.2020.01.09.02.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 02:49:03 -0800 (PST)
Message-ID: <df169ee421429f8f0aa18a897a67677a2adf2b6b.camel@gmail.com>
Subject: Re: Broken branch after git commit - tracked files in staging area
 can't be removed with restore --staged, or commit or stash
From:   Torsten Krah <krah.tm@gmail.com>
Reply-To: krah.tm@gmail.com
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Thu, 09 Jan 2020 11:49:02 +0100
In-Reply-To: <20200109093931.GA299671@coredump.intra.peff.net>
References: <07c84224bb0b093ab3770be9b5ab2ec23ce2d31a.camel@gmail.com>
         <234df85965f8a685be5e563fe795ed477f359d7c.camel@gmail.com>
         <f0638fc0d09c213b661d2b244d3457f362daebe0.camel@gmail.com>
         <20200108091119.GB87523@coredump.intra.peff.net>
         <2423f8c0b91578c0faf7527b7d97b0e1e9666261.camel@gmail.com>
         <20200108104008.GA2207365@coredump.intra.peff.net>
         <654cc7a58cf6947f91478411dd6a3f7f3473bc67.camel@gmail.com>
         <20200109093931.GA299671@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Donnerstag, den 09.01.2020, 04:39 -0500 schrieb Jeff King:
> You should be able to do:
> 
>   git checkout your-branch
>   git reset --hard <original>
> 
> to go back to the state you were at (this is assuming you haven't
> built
> more commits on top, of course), and then repeat your steps. That
> should
> also clear out any breakage in the index, since "reset --hard" will
> invalidate the cache-tree as necessary.
> 
> If you need to find the commit id of that original commit, try
> looking
> in the reflog for your branch: git log -g your-branch

Hi Peff,

thanks that did work - but I had to "rm .git/index" before the hard
reset to get those "deleted" ones removed from the staging area, after
that I was able to use "git reset -- $files" and that was working like
expected.
Without deleting that index file I could run the hard reset but running
"git status" afterwards insisted every time on this:

On branch feature-2182
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	deleted:    docker-compose.gerrit.yml
	deleted:    docker-compose.reverseproxy.yml
	deleted:    docker-compose.yml
	deleted:    docker-seccomp.json
	deleted:    gradle.properties
	deleted:    settings.gradle

Those only vanished after deleting the index file.

The "settings.gradle" is part of my changeset and listed in the
"commit".
But those other 5 files listed I had never touched in my commit - I
don't know why they are in the staging area here - maybe some other
edge case of the git restore bug - but just a "git hard --reset $hash"
did not clear those.

Torsten
-- 


