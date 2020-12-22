Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA170C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 02:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A47522AED
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 02:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgLVCZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 21:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVCZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 21:25:58 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FE4C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 18:25:18 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id s75so13362753oih.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 18:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wSYU7KvrYBfszjOjD3pWl5qnvX6bZCTLYOo94QqpFog=;
        b=DiyYOcDIlVJtjOaPE6uMShxAjlOj2OuldYWVV+aEgARLl2H9sGUo2gJ+QyCJC4rh5l
         R1chDLE29kKcb47XqzzQdB0GqC65VM2xoMCmwpsFpqHBornPLwREVtWbX/f6S9NVORMU
         Ft8jh4kbKAh4hNQEl3ZrqPnfsXqVlSLZs+6T80D5AevF3BoLy5Env/pz6YClVd/2f3CB
         tsJnCTIKRcCtAzYaWZUgcegMqd4RSzdJOUBEvRkoJu2NXJykGsOGxs6omX+gFknrDqz8
         SDou7CZT5PjYkJ+uDL7zHe2RJDO+VZKtG4/YdIy8+UTzoOY9d+coTRDIjX5laORxKsjQ
         cUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSYU7KvrYBfszjOjD3pWl5qnvX6bZCTLYOo94QqpFog=;
        b=OXUnzWGgotg4HFhDTP5L9uIxaX5GhPNCcGye/7VDHRy31XwLvRsoRvzlNA+keewCEs
         Q2sQbKKJERGTnsX+ugT8GaJlT+fFL7L5JnUY1Mn0QzzAyRMjWRxvY9QxMgNokqiAkfl5
         Io7Hwq5Rz8kmyf8zYsRIW/CyO/nMOeOICxL0oee78BVAc8MKgkCFPSjoJWMC6swI9I1k
         Ob8jRpnkk0dGaoUViyT02GMCbs6SGMJawmv4+z8QYmv4ev72n8k08VcISLbCb38fSh0+
         SNUEukpAA++0bH8YtD7/zEp6PGyGosHuNPTg2qS4HW6nxM2dhEDVvBsa7f1CNwyD3OR2
         +3vg==
X-Gm-Message-State: AOAM531F9XQ3tiTb6spMJJgeWI1QaXd7E+dYn26fuOAunVWSDOw6XIR6
        JmiFKngTYw07A6ooxj7JUDxfkVfLwdhmLUoKK2U=
X-Google-Smtp-Source: ABdhPJxzvnXVY1PF7AM0curCtJhFk9Gg86bZ4Zv+EoKsmutXqRhsbfF8Lzmb3H9rZOfa5OYfPtydiMNk8eQdT/jSJ7g=
X-Received: by 2002:aca:bac3:: with SMTP id k186mr12622413oif.93.1608603917315;
 Mon, 21 Dec 2020 18:25:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
 <pull.820.v3.git.1608516320.gitgitgadget@gmail.com> <733c674bd1901c931a8917045eb72f661872f462.1608516320.git.gitgitgadget@gmail.com>
 <CAPig+cSaq4vTK7CtvxB2bd0=WTW+d=s0H2RMquyCEf+q0YVn2w@mail.gmail.com>
 <xmqqa6u7m1bu.fsf@gitster.c.googlers.com> <CAPig+cRqa9Y4mEdktdP3d2+PHWanKZ6q6tXfJXEAW9sqcVwHOw@mail.gmail.com>
 <CAN8Z4-UG-watOnJMYUe3KU4JHnmJTxvwKSZ3s2DtBg104PACaA@mail.gmail.com> <CAPig+cS4F5fhu-ej5ZVpzLR17AUhxzLRKVZxLuKaMCCk937C1A@mail.gmail.com>
In-Reply-To: <CAPig+cS4F5fhu-ej5ZVpzLR17AUhxzLRKVZxLuKaMCCk937C1A@mail.gmail.com>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Tue, 22 Dec 2020 02:25:06 +0000
Message-ID: <CAN8Z4-WpNuqN=HxL4AQU_+zi4hGhkC18d3ZSOJGzbdkMPkYAMQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] test-lib-functions: handle --add in test_config
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yes, you could do that, though it is somewhat subtle and increases
> cognitive load since the reader has to reason about it a bit more --
> and perhaps study the internal implementation of test_config() -- to
> convince himself or herself that the different methods of setting
> configuration (test_config() vs. `git config`) used in the same test
> is intentional and works as intended.
>
> The example presented earlier, on the other hand, in which cleanup is
> explicit via `test_when_finished "test_unconfig ..."` does not suffer
> from such increased cognitive load since it uses `git config`
> consistently to set configuration rather than a mix of `git config`
> and test_config(). This sort of consideration is important not just
> for reviewers, but for people who need to understand the code down the
> road. For this reason, I think I favor the version in which the
> cleanup is explicit. (But that's just my opinion...)

Totally sympathize with wanting to reduce the cognitive load of
reading the test suite.
As a reader of the test, I found both implementation choices
nonobvious - and requiring
some diving into test_config and test_unconfig (namely the --unset-all
behavior).
A comment on the `git config` stating that it's there because
`test_config` doesn't yet support
`--add` seems equally clarifying as inserting a comment next to the
test_unconfig usage.
That being said, I suspect anyone in the future poking around with
this will have to sourcedive
through test_config and test_unconfig to make sense of it.

I'll switch it over to the test_unconfig option on the next reroll if requested.

--Nipunn
