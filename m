Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA72C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 11:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358269AbiBDLXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 06:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbiBDLXf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 06:23:35 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D619C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 03:23:35 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j23so12409626edp.5
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 03:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=t870WGgdXkJGN1D6NP8HuBMpQVJhacOj9hkpp3I4YU4=;
        b=jOqkhQNM/3j9bJkOhyeKeFsEtPi24mYrKpye37k4DSrZ94OzEXnpuMEld7DeFAKNQr
         3XNHQJz7IOHpn5peMFSWUlDb5ecLRCvvfu30ZK0ZVTx1SH2tXkrhs9AL2eB3bJhQhAnj
         Lw23nAjygYAw/IBdGB7ACPmwtGFDNRrEBANJ2ObIEAX8+EIqS/Y2zIgiSqXWqBexTJKO
         hOtdi3u3NgiKHdiQ9DOMJfepaOXl8IgVYY3rUrmwUuEZz2mJvLyw9oS6ThNkZXch1/XL
         j5XuwAAIY9muxA807t9dK87Kxz7xeuYozPplnSGDqwTW9Ju3lVaY62z37KfDV4gl0CsK
         5B9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=t870WGgdXkJGN1D6NP8HuBMpQVJhacOj9hkpp3I4YU4=;
        b=h736vfgbH+dKA7C2hwYwnM9e2IUd6F4o8n5K1fzqhEiXQykEWQOZKa1qDb4zsQZi+e
         RsmCi6CQ8wMmE84gIeqhfDbEW+tDdfWyG2UufdXTmn7MA3rVceMwfF5oRQGCcTlmW1u/
         elQo462Co0D58qIJRMpDysZKST/XC3SmYSacU1P7OcNGwS90kE4+ZDtZlqoOhzvXLP3m
         veEKO/nThNxVhT/WjAwAiRZoIbM7C0KLsAjbpouQpTLX6y2I9TNp2U9fxvuFLE2l+iTz
         J5iHjf8KELvqqacolzSHaAcURRl5xwV2Ga3ER2WMYCpwD6fytFjQ7WHAJ5DwXo5y0GvI
         nHRA==
X-Gm-Message-State: AOAM531wZpw14aP1TpNWJUcH5a2PBMuHTsaKJwMrhIhtM5yb9B2SXl6/
        7epYduqeNSEQ6ZnEBb0zN00=
X-Google-Smtp-Source: ABdhPJz4m7mwmkAVpTemrfkV1y6VGpYUZDdFpGdFb5INTkTCijtEhl8lCSfEH6za6YgHb7EOKE5t/A==
X-Received: by 2002:a05:6402:5cb:: with SMTP id n11mr2498229edx.399.1643973813318;
        Fri, 04 Feb 2022 03:23:33 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d5sm724915edz.78.2022.02.04.03.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 03:23:32 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFwge-0061ky-42;
        Fri, 04 Feb 2022 12:23:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: en/remerge-diff (was: Opinions on merging questions (Was: What's
 cooking in git.git (Feb 2022, #01; Thu, 3)))
Date:   Fri, 04 Feb 2022 12:20:04 +0100
References: <xmqqr18jnr2t.fsf@gitster.g>
 <20220204081336.3194538-1-newren@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220204081336.3194538-1-newren@gmail.com>
Message-ID: <220204.86czk250zv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 04 2022, Elijah Newren wrote:

> On Fri, Feb 3, 2022 at 21:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> [...]
>> * en/remerge-diff (2022-02-02) 11 commits
>>  - diff-merges: avoid history simplifications when diffing merges
>>  - merge-ort: mark conflict/warning messages from inner merges as omitta=
ble
>>  - show, log: include conflict/warning messages in --remerge-diff headers
>>  - diff: add ability to insert additional headers for paths
>>  - merge-ort: format messages slightly different for use in headers
>>  - merge-ort: mark a few more conflict messages as omittable
>>  - merge-ort: capture and print ll-merge warnings in our preferred fashi=
on
>>  - ll-merge: make callers responsible for showing warnings
>>  - log: clean unneeded objects during `log --remerge-diff`
>>  - show, log: provide a --remerge-diff capability
>>  - Merge branch 'ns/tmp-objdir' into en/remerge-diff
>>  (this branch is used by en/merge-tree.)
>>=20
>>  "git log --remerge-diff" shows the difference from mechanical merge
>>  result and the merge result that is actually recorded.
>>=20
>>  Will merge to 'next'?
>>  source: <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>
>
> =C3=86var's recent opinion on the state of the series was "I think this is
> way past good enough."[*].  He's the only reviewer that has commented
> since December, leading me to believe the half-dozen or so other
> earlier reviewers since August are content with the current shape.
>
> [*] https://lore.kernel.org/git/220202.868rut8qkf.gmgdl@evledraar.gmail.c=
om/

Yes, I'd really like to have this merged down. I didn't comment on your
v4/v5 re-rolls but everything there looks good to me and addresses any
outstanding comments I had (to the extent that they needed to be
addressed at all).

In particular the small addition to the docs to give us a way out out if
we need to improve this in combination with other options is good, and
much better than my proposed (and more verbose) version.

Thanks!
