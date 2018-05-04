Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79302200B9
	for <e@80x24.org>; Fri,  4 May 2018 20:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751802AbeEDUgM (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 16:36:12 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:55783 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeEDUgL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 16:36:11 -0400
Received: by mail-wm0-f50.google.com with SMTP id a8so5796471wmg.5
        for <git@vger.kernel.org>; Fri, 04 May 2018 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=bke71dLcdDoSSznRt5+F6c+38PSNeDSynHKFFodcAkU=;
        b=K/vFtW4BfqrfT1XOWEYY7Z9UpT8kddO//OO/f2zt1tI7bwW9wKB4dSHtPzgTGD/SHC
         gORHc+qkusXDTgiyMpBEFea1WBBu14ck07wO3qjeEsykVeQ95AI37Z5JT+7QrIbmFYl5
         XobrZoVrWg9kJP7FXHzMAtR0IzJWu0odDmMHbdHNTWdX22MUihz5DPpHQfg2vWfvZYw+
         0F0QompNOXapc8ZqOQ7vDZp2ASPpzDcnJqWchKMxLXtRb2fmnYYCQsdvydTGihO+uNdE
         KyLO3KEgI7c9DU3vc32F0JEdrP6yoLldNGKa9CZT6oxTSSDh1TKRPXer9CuW9UWo3ld4
         uKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=bke71dLcdDoSSznRt5+F6c+38PSNeDSynHKFFodcAkU=;
        b=NkVO6mbSeWUT6AaiDKQfaRUm1gDTyZAEWohSAs81MFxzyJjtPhiIZv7mlwZCVMjDKb
         +n5hBI80GXTCYGxkr1PX4OhHIphEzrvbyWclBpD9f4FZrrIr/IkWLuOKlhBASz2QTLta
         zcLN6F8eyXugZZMdNsRgJ3XlYxTXn+XhkTzu9vkFlbYJNHvOCbaFUadW0+S7u9N1BT3P
         ngrn8wh7UxR9Pac2ZmTTqKJEGqO2R4zjrvDlO/mlFHGz2BsLSr5uUqZ20Rf0xnpW+baj
         jC1ID/bcxAlxIjHQzIrlps77tZE/LPAkjKg1KYhTF4jFdmg/RT3PJSu21YrGOEBT1aYY
         UQKw==
X-Gm-Message-State: ALQs6tAd/4DxcDAkt5EB07CF33soM7Km6BcQK5QR0VF3nRxOA9zf76SZ
        miI2QiZkTX9ZonKh5rjSiXJqgsIV
X-Google-Smtp-Source: AB8JxZqgyZzTH+0n/VA4zvDCBxN3nj1TT7ijfm7aAYDVvnl49Is8EQnmQgHac8IR2ZGVy0t1WhNiKA==
X-Received: by 2002:a50:a2e5:: with SMTP id 92-v6mr38167087edm.82.1525466169995;
        Fri, 04 May 2018 13:36:09 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id v17-v6sm10097984edl.47.2018.05.04.13.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 May 2018 13:36:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC] Other chunks for commit-graph, part 1 - Bloom filters, topo order, etc.
References: <86zi1fus3t.fsf@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <86zi1fus3t.fsf@gmail.com>
Date:   Fri, 04 May 2018 22:36:07 +0200
Message-ID: <87h8nnxio8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 04 2018, Jakub Narebski wrote:

(Just off-the cuff here and I'm surely about to be corrected by
Derrick...)

> * What to do about merge commits, and octopus merges in particular?
>   Should Bloom filter be stored for each of the parents?  How to ensure
>   fast access then (fixed-width records) - use large edge list?

You could still store it fixed with, you'd just say that if you
encounter a merge with N parents the filter wouldn't store files changed
in that commit, but rather whether any of the N (including the merge)
had changes to files as of the their common merge-base.

Then if they did you'd need to walk all sides of the merge where each
commit would also have the filter to figure out where the change(s)
was/were, but if they didn't you could skip straight to the merge base
and keep walking.

Which, on the topic of what else a commit graph could store: A mapping
from merge commits of N parents to the merge-base of those commits.

You could also store nothing for merges (or only files the merge itself
changed v.s. its parents). Derrick talked about how the bloom filter
implementation has a value that's "Didn't compute (for whatever reason),
look at it manually".

> * Then there is problem of rename and copying detection - I think we can
>   simply ignore it: unless someone has an idea about how to handle it?
>
>   Though this means that "git log --follow <file>" wouldn't get any
>   speedup, and neither the half of "git gui blame" that runs "git blame
>   --incremental -C -C -w" -- the one that allows code copying and
>   movement detection.

Couldn't the bloom filter also speed up --follow if you did two passes
through the history? The first to figure out all files that ever changed
names, and then say you did `--follow sha1-name.c` on git.git. The
filter would have had all the bits for both sha1_name.c and sha1-name.c
set on all commits that touched either for all of the history.

Of course this would only work with a given default value of -M<n>, but
on the assumption that most users left it at the default, and
furthermore that renames weren't so common as to make the filter useless
with too many false-positives as a result, it might be worth it. If you
