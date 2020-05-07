Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC39C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E3C20838
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O17MNkbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEGNRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 09:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725948AbgEGNRj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 09:17:39 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2CBC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 06:17:38 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d16so5324114edv.8
        for <git@vger.kernel.org>; Thu, 07 May 2020 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zv3Nk/o2XxnIXrUZpw8Hk7qxAV1kgwkkfsM0q2AGTv8=;
        b=O17MNkbNCsc7xYkXinLJcmff1lIDl7xPuJhdKnHrVNHnjOLPggX5ODXf+ceBiupZiW
         tPYSK2GiMvi0sIDTZfsh+ZC0zRyYSb3mDjHahIhuLLdVRtj9w7fMImo0EbVPI34noa9f
         rwcWVRUoqUpZ3iT7FOO52g7XqmppjDh2J4CP874VfricSY1G7xHgrTKNvxded4RLTdEV
         QZ1SOdrAfqifZPNV7JNcp4NrDhhRFW8i+4Go2pg9TwREmsZN5EXRb5YIjcvZdg7KKKtj
         RfOpU7OT9cUu/kATgFWlkYFpvG3roHAaA5chqBZ2si4VT0Msx3fey2AvY/16yY1FjeJt
         kE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zv3Nk/o2XxnIXrUZpw8Hk7qxAV1kgwkkfsM0q2AGTv8=;
        b=EN5WFR49M8yKeqntI3B1Q7G6aALnoSfpv0d/M4U4riZVVI++fXmcZ/bDaqbqmAiv9U
         +i5NVSBn6pHMYX3sP29FH5hO47jE/dFdEDy+RgwpPjacawEh8pzsK+PexhU+kWKVQAgo
         COUQKWxhWpQEP5/pbEPdaWpcWd/hokk9tU2MhjD++HiQGtb7FTHrDNU9zhk/Xo9yfZV8
         M4RolhUQ+5nMqFJad+3rGBWcSo12D8yR5a/2rDav5vTC0cJDEJgj/kkoJyJbnfIGdrbC
         Z5t3YMM6lOYfDixloNkoFW1XdCFyJAemmD3XB7k9De88eynBBjEI4KsXwD0g/f9V7pvN
         4oTw==
X-Gm-Message-State: AGi0Pubftgs/2LNqEp16EUO8yyhoV3qYPQYS+5+8f4AQJp729WDRPUs/
        WP10nNTyTFXq7wYnUIVKjLfliNbHp6CH6CRj49I=
X-Google-Smtp-Source: APiQypKc3Fq/UK78nVDNgp7zgmcxZ0BZ9f768oF0Q6NBYckZ8LYpuEl0VHS8cx3QFU/BOZbc/0IHUul2UtQbG/qVBUA=
X-Received: by 2002:aa7:dd84:: with SMTP id g4mr12139257edv.273.1588857457609;
 Thu, 07 May 2020 06:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.606.git.1587412477.gitgitgadget@gmail.com> <eb0cbeeeed080596c130f657186894999ae6121b.1587412477.git.gitgitgadget@gmail.com>
In-Reply-To: <eb0cbeeeed080596c130f657186894999ae6121b.1587412477.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 May 2020 15:17:26 +0200
Message-ID: <CAP8UFD2b_27VeLFg3BrbacoJ5+GAxa+JrF3E2jS_dN-xyCRP_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] fetch-pack: remove fetch_if_missing=0
To:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Hariom Verma <hariom18599@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 9:57 PM Hariom Verma via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Hariom Verma <hariom18599@gmail.com>
>
> Commit 6462d5e ("fetch: remove fetch_if_missing=0", 2019-11-08)
> strove to remove the need for fetch_if_missing=0 from the fetching
> mechanism, so it is plausible to attempt removing fetch_if_missing=0
> from fetch-pack as well.

It's ok to refer to a previous commit, but I think it would be better
if you could repeat a bit the reasons why removing the
fetch_if_missing global is a good idea, and not just rely on the
previous commit.

"it is plausible" also doesn't make it very clear that it's what the
patch is actually doing.

Thanks,
Christian.
