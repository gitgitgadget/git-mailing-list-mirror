Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EB8C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 00:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhLOAn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 19:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbhLOAny (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 19:43:54 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85AFC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 16:43:54 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q17so14935860plr.11
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 16:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=SrhKyM+fMmFOqO2gHPyPZ9oBnK5yflZBrO0no3wTo+0=;
        b=MrBBGnjq8dX4rPXbJjCPpdmz5qb0Ey/EFNzF3bTMZgn8znUs6C57F4IKzYvh8BkrRa
         jE930+zZUtaCqVguk0NwvjqH0vfvhxa0gEF8BELrfjnRj1ulahWvLFrm0M+PV4MopmaL
         OUxFkDW6b/ZoGFDH8V3fD82pqK9hAUcd8Yio6lPJLIpqn6c7qKNi87if02e9uZjKE3VB
         7E9jqkUl4pqdm0Y2CY5OytmOU1UidzufLidVX5XKj3o44c+MJyNEAOEJ+bAHklUJu6ju
         zioYcvQJk15mIaFZMXKHtl0Xxq0rO4ErGY3tkWRs4BfVV7Gjm5Whjy8hWoQjaeeI5hxW
         3ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=SrhKyM+fMmFOqO2gHPyPZ9oBnK5yflZBrO0no3wTo+0=;
        b=ggdG15Snw4FheFQCQafRRACQaCuGk0QOmgSjENeVJEQIYrUISyaUsUq6HhdCM4Zvjn
         i7iIidhoUxMYkmuP4/tLQSSpZrmlgIzD1drE3YTGKwsUsTx0cQGYTEBLG+nmnfDXMzJ4
         ICnnW31atdIPUkabtgBPcAb8VCBcgc+Nbjk7XY/xMUpaYot8y/APfKhH/l+CaJDsOGhc
         Q69zyCFBvRu4mpJDbxpL968uBUNGAwoX8m83NOZg1TfjqLPzousYCNWd4XHi2RNTLVOb
         nfyBk/bbbix2KFU7i6WMxVI7Oddoc0WngW3O3jZbc4wyLfhGcYileUISZVBVldboxTo0
         BvpQ==
X-Gm-Message-State: AOAM532AkaHRYWij1o6/sc5wa5PUuzNZ/gXyko5W+FWpdLYRaG9aB6K1
        gE/g+zhfBuxsPqEA9Lqki7cGpT5vJhkCRA==
X-Google-Smtp-Source: ABdhPJxvIsR5lHHmE640aUlMXUof2EhFDGJHiw/ZYnjA+O+EtmmlXpGgSqZC2gDx0JyC8npvMda/VA==
X-Received: by 2002:a17:902:ecc1:b0:142:fae:f686 with SMTP id a1-20020a170902ecc100b001420faef686mr8539877plh.24.1639529033748;
        Tue, 14 Dec 2021 16:43:53 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:b37:fbed:ef52:5dca])
        by smtp.gmail.com with ESMTPSA id rm1sm3534125pjb.3.2021.12.14.16.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:43:52 -0800 (PST)
Date:   Tue, 14 Dec 2021 16:43:46 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chooglen@google.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6 0/3] branch: inherit tracking configs
Message-ID: <Ybk6QsMdeBl6IweW@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, chooglen@google.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1639524556.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1639524556.git.steadmon@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.14 15:44, Josh Steadmon wrote:
> Changes since V5:
> * Greatly simplified BRANCH_CONFIG_VERBOSE output to not require nearly
>   so many conditionals.

I meant to expand on this but forgot before sending the series. I
removed as many distinctions as possible, as most can still be inferred
from context. For example, previously the output specifically called out
branches vs. tags, but this is obvious in the name itself: "some-branch"
vs. "refs/tags/some-tag" for example. Likewise, we don't need to specify
whether refs are remote or local: "some-remote/some-branch" vs.
"a-local-branch" should be understandable without us spelling it out.

Of course, if people feel like I've over-simplified here, I'm happy to
revert this change.
