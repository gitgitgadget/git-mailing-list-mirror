Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFB5C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 02:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbhKXCNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbhKXCN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 21:13:28 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FD8C061574;
        Tue, 23 Nov 2021 18:10:18 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z5so3248334edd.3;
        Tue, 23 Nov 2021 18:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KPyI59aJUDhZgQKLkT0P156dlmLaw4MIeo3W6+teJrQ=;
        b=Su8/EHr0nUlYuo33kNieiPTWGMPchBnGnfM8t+AyJxSaWmt+gKmjzRHBxYyhmCale/
         o2xZcAwyY0o9qyjExW5I5NdJ8dZETdnor4ZCuUlclMcBs6n6uQTLhzp8z3jdvwt24dVR
         qyzWkLKCHv88jmTTZMBrX/6dxnv/wX5wf0oEpMj2B76pjCSwnhGw9uhZH3FbIHeM4Z5q
         XTwH70Hc7wR6YOHH5ZMDu++/+pYmlYFbc14Y4hxggIwDWEy6YzdsV0VD4y/AB1u+p9wR
         FYW65HtPRWjvdS9FiFDwdHBI3jsh6PQdiOzUgrjc48bYlhZX1O/1yMHik9JqmWBIHXgc
         +SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KPyI59aJUDhZgQKLkT0P156dlmLaw4MIeo3W6+teJrQ=;
        b=H7hqiyW9qGDmqlBayWy4ntQzEc7tJlydW5nJENYbcmGghaupVa/hIthON3AdWbvRwj
         D3hBEPPFkNdZ2Ax8SLSejY2auv3Nyj1GdG+WxEwR21LDTY80AZ3k4ksgL9AWXpF4DM9I
         yYoEeQxJYmLpPA6BX8qNRrvRy4JS6auscRp/QHouPQ7fQTZkr/i2hm11eNIINJMRIPvw
         qCJSARtbNEO+VDSYwg6Ks8eKk85168DONFS4YncQiOvogK+jLCe305cgQGdpe/alWM8h
         PT4mvvePer0t5+1/HVyUxkaA0P+CEYCtU0EHGdv3ciyCP7BM6WKaUh2XKmHDGFmqQgw/
         v0vw==
X-Gm-Message-State: AOAM533NJ6V8VEn1NvjSF6Ltk1bkH6+ayYAcg1g3P2DA3LronwqqG3zS
        ULoo9Uz1uJs7OVUCs1f2GRJWBuEuIvxHqg==
X-Google-Smtp-Source: ABdhPJxrlLw2N9yQm1P10FA8Dqjbe+bi5PNQHnhzK/w1A7cEPDhtM6BUJDHxPExHwX5gsVeMY3q9WA==
X-Received: by 2002:a05:6402:4312:: with SMTP id m18mr17413210edc.273.1637719817482;
        Tue, 23 Nov 2021 18:10:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i15sm6701319edk.2.2021.11.23.18.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 18:10:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mphjk-0008Xc-H4;
        Wed, 24 Nov 2021 03:10:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, workflows@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags
 'Reported:' and 'Reviewed:'
Date:   Wed, 24 Nov 2021 03:08:28 +0100
References: <cover.1637566224.git.linux@leemhuis.info>
 <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
 <20211123185237.M476855@dcvr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211123185237.M476855@dcvr>
Message-ID: <211124.861r36e22f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 23 2021, Eric Wong wrote:

> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>> diff --git a/Documentation/maintainer/configure-git.rst b/Documentation/maintainer/configure-git.rst
>> index 80ae5030a590..8429d45d661c 100644
>> --- a/Documentation/maintainer/configure-git.rst
>> +++ b/Documentation/maintainer/configure-git.rst
>
> <snip>, +cc git@vger
>
>> @@ -56,7 +56,7 @@ by adding the following hook into your git:
>>  	$ cat >.git/hooks/applypatch-msg <<'EOF'
>>  	#!/bin/sh
>>  	. git-sh-setup
>> -	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
>> +	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Reviewed: https://lore.kernel.org/r/$1|g;' "$1"
>
> Side note: that regexp should match "Message-ID" case-insensitively.
> git send-email is an outlier in its capitalization of "Message-Id",
> most RFCs capitalize it "Message-ID", as do common MUAs.
>
> git send-email's capitalization does annoy me and I've looked
> into changing it; but there's a bunch of tests and probably
> dependent code that also need to be updated...

"git format-patch" does it without send-email, but I see that send-email
will then parse its output, and would turn any capitalization into the
"Message-Id" form again.

We could probably just have it preserve whatever capitalization it finds
if there's an existing header, we wouldn't fix anything, but we'd move
the blame around a bit :)
