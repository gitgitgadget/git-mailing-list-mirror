Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA7DC77B78
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 17:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjDZRuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 13:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjDZRui (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 13:50:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1321CE6D
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:50:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b92309d84c1so201027276.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682531436; x=1685123436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PfTpoq125RqY1lfW29pOxTHE2RlmE4sR/8rsHWc0ceU=;
        b=E+l0/cx5KUnPAeP7gpGRsgduu5NDtDDqzvHnQPyVGT8YNN0hndLb7Yq86gvxn9sVuF
         n4Na0HSXlbrLOS9FVbmmX5pnDvoPCR6urnup8dCu5VDml8+otntZ2AVkM+//rkSAhuKy
         O22ybj6EBK82FM0FRn8vX+Wk6gT/P+6sT+EQ+a8cup+5QGfcL/OdvDbcCXo8imxVY2zt
         xs+Xp9A8bDwJvEihzpBASu2XSMCpcIem9PZoslvCWSvLi3ZFGipzZlo84SlAkIYC+hMc
         Qn1DpOpADTOJXwidRSISlOl9yjFS/rxuFjVhUNAV8tMZBMoK3K5vWbbdZyE0KyWQimua
         2HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682531436; x=1685123436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfTpoq125RqY1lfW29pOxTHE2RlmE4sR/8rsHWc0ceU=;
        b=mIhTgNjhwyYPgISWuxce1a40mzbcwN/M4idAMr20M0FHZhIHjaFjCZIVWKoY1uX/d0
         so0a2QQRElJlyvyi1EOl2PLd+3c48xgRPV+rOiEUxIZOToEmgB4Vfx/YfxyJhMgs+6zj
         eok3ovUX5bw/73WGxrBdriy3FlGT4CdqbFDGBjRF+odNenkCPjUFEBVjgi6eqy+PW2nR
         FxDz4ybrjxuKxdnpn6OVtCX/0ke7kZghZ2CGxi+tRZ0GkEDcCk7eGc1psdES+F73Ll4r
         kwLy8PCeefr8ZrHmAYCrVjMH2W4cq+4i2f/0Ud3BDQakw3pfvzbYm/Guxt3q79Pf7wJN
         4RmA==
X-Gm-Message-State: AC+VfDx6Vp+hjfW7hOH3lhXyNi7doNYa3q271i11abOfHKye1WS+3OO8
        Q0UH74avCy/3vWnRUG/9LgbM4H84NRqmvA==
X-Google-Smtp-Source: ACHHUZ7R3XYgCkgqljNIxFETEjfjUDZ4c2yddHIS2y/qZE94ofQaL1eg2Upb62k8cleMN3xiHd3n6jZsR1cqWA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:b46:0:b0:555:a687:e151 with SMTP id
 67-20020a810b46000000b00555a687e151mr1975559ywl.3.1682531436120; Wed, 26 Apr
 2023 10:50:36 -0700 (PDT)
Date:   Wed, 26 Apr 2023 10:50:34 -0700
In-Reply-To: <CABPp-BEWS75TrsfUQUP9t4_2B4FTDbM2FamqTgvVj8WpxUgSYA@mail.gmail.com>
Mime-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com> <d95f97f5e90da40b285aa8fd678efcff0ae11033.1682194651.git.gitgitgadget@gmail.com>
 <kl6ly1mh865x.fsf@chooglen-macbookpro.roam.corp.google.com> <CABPp-BEWS75TrsfUQUP9t4_2B4FTDbM2FamqTgvVj8WpxUgSYA@mail.gmail.com>
Message-ID: <kl6ledo6o7md.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 13/22] hash-ll.h: split out of hash.h to remove
 dependency on repository.h
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> hash-ll.h doesn't depend on repository.h, but these functions' bodies
>> use the_hash_algo. Does it matter?
>
> That's a good point.  I think eventually moving these functions from
> hash-ll.h to hash.h on this basis makes sense.  But I kind of view
> this series (and its predecessors) as focusing on cleaning up header
> dependencies, with the idea that hopefully we'd go through and do
> further cleanup of dependencies of C files that would likely result in
> further changes to some of the headers.

Yeah, for simplicity, keeping this series header-only makes sense.

>> Moving the functions to hash.h requires changing 8 files to #include
>> "hash.h", all of which seem to be because they were getting hash-ll.h
>> indirectly via object-name.h.
>
> Yeah, seems like a reasonable further change.  Are you okay with that
> being in a future series, or do you think it should be included in
> this one?

Let's do this in a later series. As you mentioned, there are probably a
lot of other clean ups that make sense, but this series is already a
good step forward, and keeping those clean ups out makes this easier to
review.
