Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D9EC433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 12:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D929E6186A
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 12:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBZMCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 07:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZMCi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 07:02:38 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D292C061574
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 04:01:58 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id q9so7813260ilo.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 04:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=69D0Qv1UNFmbNLmnNT6Dtf9DkPJSlxW03+KPu/YbOa8=;
        b=ak+hrhBawHoeo9qjEQ0io4Ewm/0Kpda9jQjhmJjXVLLoKmgj+ZUAASlKDig5ph20x/
         xV+JDiN/gx16UfhEZ/M3g77BbaJkNSpwnm+3pui3WarQhiGCy+V00moRwC/NlkWs43WC
         VyiRUCA/Bv9aldaS0ca42V2DkTriYDXrUIDrNatNYGSC/zARyxkIt5Hsz3svAtnrnadQ
         Ym4h5OvJ17sNmOFt+US10/7nK3w9rZwAMSU7lCtRe4lUFyaAI6zX3TKQ01r/CdjyQury
         +TZOAYNAYK8Byf8Wm6BL75zlbjRP2TuYb7erd8TC2tDi8jmdheeNW2x511KQSieh/PcY
         w+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=69D0Qv1UNFmbNLmnNT6Dtf9DkPJSlxW03+KPu/YbOa8=;
        b=Xbg0hXmGAHWeVLVnsSnyj9vR5JxtXqOr4vsS6xsG4NpI3o4LuNnEUhu380PwkRzY5S
         3WymWckQuCh3skTE4Uw+WzpLxToFX+7YzCHkouVDNIVHgQDfGNWfiz9aSkeaox9mhIAP
         YkxkSnLfqz8k56y7SS+qk8dmw9Hu9Wty/ZtxOM3AaEpzFzJ2GDVxHrWG7KIaglxDAp09
         1Gw0ncENmAz7stXeVPiSqhgNbM/QVLzXk9L8v1j5cYaij/P47/9W1Rv5zqqhENdq/EjH
         g6YBReTIlkltdq6mp+mh0CupwE7JINSQP9soDMPSEoXhb0Kw+6rrrXcEXxe0fy0FmTQJ
         wZEw==
X-Gm-Message-State: AOAM530lW6hCNEVNk155raU3Lkx961HUlRb0e2CZoZy/Xe6/ASr/S7Rs
        4rJJOR7jrrSRuY23YFYIIMLTzFMuvorC7UqNmMymnwkWSeh3d9GR
X-Google-Smtp-Source: ABdhPJyjEAEirFVCyvtsinkRuCt9ljgUTjpVVQuJvNcvpxiJie6ucSzf0aVHTQlRJM6aTcJHqoDAS8RP8GSJrHkoQpg=
X-Received: by 2002:a05:6e02:1a25:: with SMTP id g5mr2183132ile.73.1614340917171;
 Fri, 26 Feb 2021 04:01:57 -0800 (PST)
MIME-Version: 1.0
From:   Robert Coup <robert.coup@koordinates.com>
Date:   Fri, 26 Feb 2021 12:01:41 +0000
Message-ID: <CAFLLRpJgfseK5P8ZJm7iEW1onf7ROVSkyeuPfh1+qoHHjsC8uw@mail.gmail.com>
Subject: partial clone: promisor fetch during push (pack-objects)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a partially-cloned repository, push (pack-objects) does a fetch
for missing objects to do delta compression with.

Test-case to reproduce, with annotated output:
https://gist.github.com/rcoup/5593a0627cca52f226580c72743d8e33
(git v2.30.1.602.g966e671106)

My use case is partially-cloning some large repositories with the
majority of the blobs not fetched locally, writing some blobs to
replace some specific paths I don't currently have cloned, committing
& pushing (while leaving most trees as-is). I didn't expect git to
attempt promisor fetches during a push :)

I happened to see it because allowAnySha1InWant wasn't enabled, so it
printed errors but happily continued and completed the push (after a
fetch attempt for each object).

My current workaround is setting `pack.window=0` during push. Looks
from builtin/pack_objects.c:prepare_pack() that `pack.depth=0` should
skip it too, but that didn't seem to work.

Invoking pack-objects directly with any --missing= value still tries
to fetch. And regardless, it carries on if the fetches fail. The
fetches happen at the end of builtin/pack_objects.c:check_object().

1. Feels to me that fetching from a promisor remote is never going to
be quicker than skipping delta compression during a push. Maybe
there's a case for doing it during other pack invocations to minimise
size though?

2. Seems like a bug that check_object() doesn't honour
fetch_if_missing and skip the call to prefetch_to_pack().

3. But push doesn't pass --missing= to pack-objects anyway, so that
wouldn't actually solve the original issue. Should it?

Thanks!
Rob :)
