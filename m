Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26401C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB74020735
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQvOyGZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgEGNKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 09:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgEGNKQ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 09:10:16 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35EDC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 06:10:14 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e2so4472517eje.13
        for <git@vger.kernel.org>; Thu, 07 May 2020 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HT48dWBrPK5Jr2sLNt0tE3STU5LXP3GXgrLmaIMldA=;
        b=sQvOyGZBL4e5Mt9hd3485g9TaDk5ab7svMLiqtwF6T3JT1T1xl8e8Kjf+Edm06czWM
         BFsRKrV5fHiFff9NHyCqVkpUmCYn7vVJSBpCECKhAt62K0Y0AbQK78TWoJ/DdfNS3l97
         X3r1kiN0rOs/rLTxD1p0xB4k1i7qp4MpT8Rh49AIYDi813Bo9arWA29tJcbFqx9X06TI
         bZhKF6773boZkPt/Qtfz9tNfN5IiruFE5HT9saZJHhWIKo3YQ+Ad/mWldVqnoHpi0qBc
         WduM0MHqAR5qAwx6sShhrRZ45Dch1rZICVp9mJzL7XfrICXcdd7apHKL4h+yqr+On0zp
         fG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HT48dWBrPK5Jr2sLNt0tE3STU5LXP3GXgrLmaIMldA=;
        b=LnV027lZU5WIBcjo1S6TvoPR31AgMgmOxM0nqOEo/vk/kgDWh6/iiyUbXs6N8s4nme
         wpgewbHiOwILRtGqq53dr/KWoLPsJGTsqQtmEfKTW/4hSLGsh4IC14ukUWe8s1Dv7G7u
         ZSyaQlqk2ijLpNa4AtUh6zRGxdJ9wWmMqiwdAhS5OiNMr9b6XXS+bw9I61W9Ps023TeN
         RRJAbmW4Qgo9tm6kzobckXruhlLjNTOTgRa054M2rjPAWW7PMQJDbLnGK84wugWQSUQh
         2tS7bLaBYz4tbxw4KUMcIL7KxuhJp9eEBqko+NlwwVcchFelX67KwmoJ5Qwr4cDqFPce
         Vmhw==
X-Gm-Message-State: AGi0Pub//VAVnYm8aaBvuzcrm9AWTVmp/Kv9034oPSh39RJjtTMNIgH3
        g+v5U/Tw2FzRjyWN1bpkhu7ZH44Y6G/DiHGJP8k=
X-Google-Smtp-Source: APiQypJ1Ey5WZAqdFV8zbWs1xbI1+VkE8L9Jv5fPp4xOMGSBzjzpEhvnuvIIcKkcKSa+QSRIF88uBjc+JQ69m96iNXA=
X-Received: by 2002:a17:906:2f8f:: with SMTP id w15mr12077766eji.255.1588857013206;
 Thu, 07 May 2020 06:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.606.git.1587412477.gitgitgadget@gmail.com>
In-Reply-To: <pull.606.git.1587412477.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 May 2020 15:10:01 +0200
Message-ID: <CAP8UFD2SNnpKWtYUztZ76OU7zBsrXyYhG_Zds1wi+NqBKCv+Qw@mail.gmail.com>
Subject: Re: [PATCH 0/2] [WIP] removed fetch_if_missing global
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
> We are not much happy with global variable fetch_if_missing. So, in commit
> 6462d5eb9a ("fetch: remove fetch_if_missing=0", 2019-11-08) Jonathan Tan
> jonathantanmy@google.com [jonathantanmy@google.com] attempted to remove the
> need for fetch_if_missing=0 from the fetching mechanism. After that,
> fetch_if_missing is removed from clone and promisor-remote too.

You might want to add Jonathan in Cc next time, as it could help your
patches move forward. I have added him to this email.

> I imitated the same logic to remove fetch_if_missing from fetch-pack &
> index-pack.

Maybe you could add a few tests as in 6462d5eb9a.

> I'm looking forward to remove fetch_if_missing from other places too, but I
> not sure about how to handle it.

It is ok to not take care of the other places for now. If that was the
only reason why this patch series is marked as WIP, then you might
want to remove WIP, especially if you add tests.

> In fsck, fetch_if_missing is set to 0 in the beginning of cmd_fsck().
>
> In rev-list, fetch_if_missing is set to 0 in parse_missing_action_value(),
> and in cmd_rev_list() while parsing the command-line parameters.(almost
> similar case in pack-objects)
>
> fixes #251

It would be nice if you could give the full URL of the bug, as there
have been different bug trackers used by different people.

Thanks,
Christian.
