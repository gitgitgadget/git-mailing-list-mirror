Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1DFC433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EDF964E12
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhCDAWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842951AbhCCKW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:56 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A6CC0698C2
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 23:43:15 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id e45so22667295ote.9
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 23:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0mk/9Au3bvd9wYZ7Zd5TpHA/IY80v5XsZczaMsCyh0=;
        b=MRPSReUba5mwBJ92/nOE33c4XNhlziGkqbcjsTEQTLrEVN8ywqyudIRSNenQcEVMBF
         RbWAJVRwSD2j0CHxEkczvqawygspoUfD+rkXqKU3XzQMAKn1imq4AEPIOibOGUcePAgA
         7JAEtlC8/27O+FzsrNLCIhm0PwM5Pvgb/g6h5XEcJs+0M+9XdaH9Havje/Nm7SeNzIiO
         p2W+7ufye1bbFS5yAMgo8fVY3UmhvjkJVur/77WATNxk3gX0+oJ91GhP0BSbUNfWppg6
         tck0t4xEQCOARo5duk3uxW+xIM1LJE9g4OxOm0zGqqNZcEAeJi8KwF+6d67jPNV4DvGQ
         2NAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0mk/9Au3bvd9wYZ7Zd5TpHA/IY80v5XsZczaMsCyh0=;
        b=CFJbcsGI3Ydb/heWCIQLcrPutHfeIkHNeQZnFE2LujD9FyusW76iHSFAUs9oyalSki
         SxqeI9FzO5W6kQ1rrZssELI71ecBo7ocLXOhKACB0uiWVAVOmk6BpYVJTkMGSI6z7N/U
         xD3KJxYPb1iIxq/5mAaOwH+21gUv6Ed2TQHCrXJHmieBLDET8A1rSVWIJS8bb6vQxzMe
         PgBA108ebfdx5AFVO7l2y7iT3nC0+KBIX39CktiyBEv2mvKGtQZpRWpRfW2frh+KMXVN
         UknNXOI4OHR05NkphVeLvckeQ1f70FjTBzVA5Q3y5WeI2xbbRc0fAnmC542HOaZnAxxt
         IN3A==
X-Gm-Message-State: AOAM5324g74sD32DWIfvs7ajypgOqkrtf2cMFISYuQnP5StdySY8cqwR
        zI7ey04OpwGE3ysQ6jRZ3en5iapEeKMLJ1a3jyg=
X-Google-Smtp-Source: ABdhPJyP0IsIXGcOt+jV1jfzAs1OiTURf9y47mmr6+dXyMo1OQE6NHp/PC+w5d+Qa7J1FgZSBOd0entJdG+N7pR+S24=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr21555143otq.210.1614757395229;
 Tue, 02 Mar 2021 23:43:15 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-5-charvi077@gmail.com>
 <CAPig+cTVrcWm8pJvnkP4gnWE6B8SKHENjvbAR7Do0ury-ArnaA@mail.gmail.com>
In-Reply-To: <CAPig+cTVrcWm8pJvnkP4gnWE6B8SKHENjvbAR7Do0ury-ArnaA@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 3 Mar 2021 13:13:04 +0530
Message-ID: <CAPSFM5eskkpwB0gN-nr3KBeH31A+K3LRh50daHZ-xhR9EaQpug@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] t7500: add tests for --fixup=[amend|reword] options
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        20210217072904.16257-1-charvi077@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Mar 2021 at 11:13, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Mar 1, 2021 at 3:50 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > t7500: add tests for --fixup=[amend|reword] options
>
> It's usually preferable for tests and documentation updates to be
> bundled along with the patch which makes a particular change[1] rather
> than waiting until the very end of the series and adding tests and
> documentation covering all the changes made by patches earlier in the
> series. As a reviewer, it is much harder to tell if the late-added
> tests and documentation updates are comprehensive since it's difficult
> to keep in mind all the changes made by earlier patches.
>
> When reading earlier patches in this series, I questioned whether or
> not certain features of each patch were going to be covered by tests
> or documentation updates, but I couldn't tell because those updates
> weren't made at the same time as the change about which I was reading.
> For instance, when reading the implementation of `--fixup:reword`, I
> was wondering if the documentation was going to be updated to mention
> that it would ignore changes staged in the index and leave the index
> untouched, and I wondered if and hoped that tests would be added to
> verify that the index was indeed left untouched. Over the course of
> many patches, it can be difficult to keep track of all the accumulated
> questions, which makes it onerous to review the final patches adding
> the tests and documentation updates enmasse.
>
> I'm not necessarily suggesting that you re-roll merely to incorporate
> the tests and documentation updates into the patches to which they
> belong, but it's something to keep in mind for future submissions.
>
> FOOTNOTES
>
> [1]: Once in a while a patch introducing a change is so large on its
> own that it may make sense to split tests and documentation updates
> out to their own patches which immediately follow the patch to which
> they apply, but that's different from delaying _all_ tests and
> documentation updates and plopping them at the end of the series all
> crammed together.

Noted. Thanks for guiding, I will take care of it.
