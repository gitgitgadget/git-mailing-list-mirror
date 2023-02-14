Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE84C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 04:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjBNEDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 23:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBNEDt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 23:03:49 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965661422E
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 20:03:48 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4c11ae6ab25so146690027b3.8
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 20:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BpwP6yNxxVBeeSxxM39csZeDLEt66x4ujKvyKHHfOIk=;
        b=AltBTDz3YjmtyqJCum9OrEvz3vemllNkcCIP5JsuSLs8MFVBNlHQNQuIHlOkTrUPeL
         D+ObGvh9EG9Gb0fSBqlLy3sZvcJBRczNlsXvmK+g7ugK2jvX4EMKJNEXjL0JT0LrRF3x
         eKIW/yyO6k5yfnnGbiyXTy936KTowLOK/XBHAQ1I+4dayTgo3I1mTef1jZ8btjyHKp3B
         43u0YvEmbJLqvP4iIWWVLeZz/RvoXkQElyPkijadlsDn80+Jc2A1xzOJoqK6zqnxr2J2
         cn3QKmhbT8oMKbBV+HhRFbQN2we3DXq8IoZk9yrAIyUswZMtjJIpC96M3hS/I6m5zOLi
         RxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpwP6yNxxVBeeSxxM39csZeDLEt66x4ujKvyKHHfOIk=;
        b=xIBw17MAt2/C2P/GIe4JEMgRD1rrAXq0+6F6gsJKmbtL+pYBakibQNi8qaesS6e09V
         /E4395Npf+fCHs/T0puEGRdoj0tBX+cMLT6u2szxRS7BcWFuF8wsZwfvV+bsenkTyKlc
         vr6HuF2rMFGiD8Cfogk9+B9Jk8jbRvIfi24eQu4sOf9/ljiO/X/rrj9mwRe0f+w6ZXlx
         wNyy862ffjBm/kPX3k0bAqC6F50nYroGjUXkbKsOhGzIqHpyGpAgoJdrDTiG6UzhSWGr
         lUVS+0i4iLnEdZ/du3cysiR8r5SFwRDD3QVg02chuxGAZuy6PLzs3+zKUhz5sD9dsJtN
         W//A==
X-Gm-Message-State: AO0yUKXHCz9fxnf0h8HZWeuYkCQ3BW6hs4BcmHKBSzEKt3x/JxB/rQQF
        HKEds48h4f8tyGovkMcXU/rpGXuAWDA0KA==
X-Google-Smtp-Source: AK7set/fLd/WnKOZ606W987qfnMnUR5/WjxCie59lhFIE9/4miqKPVbz+B2cUFk2PrMr52+/UtSBgszit4oM4A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:52c1:0:b0:500:1982:86a5 with SMTP id
 g184-20020a8152c1000000b00500198286a5mr39831ywb.148.1676347427790; Mon, 13
 Feb 2023 20:03:47 -0800 (PST)
Date:   Tue, 14 Feb 2023 12:03:45 +0800
In-Reply-To: <CAFySSZDz2BE4yrWKrWZhBx_yFBTUcWYtM9Fie-Npa84Ln0RTZA@mail.gmail.com>
Mime-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com> <20230209000212.1892457-6-calvinwan@google.com>
 <kl6la61iardd.fsf@chooglen-macbookpro.roam.corp.google.com> <CAFySSZDz2BE4yrWKrWZhBx_yFBTUcWYtM9Fie-Npa84Ln0RTZA@mail.gmail.com>
Message-ID: <kl6lwn4kopum.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v8 5/6] diff-lib: refactor out diff_change logic
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>> > @@ -245,21 +269,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>> >                       newmode = ce_mode_from_stat(ce, st.st_mode);
>> >               }
>> >
>> > -             if (!changed && !dirty_submodule) {
>> > -                     ce_mark_uptodate(ce);
>> > -                     mark_fsmonitor_valid(istate, ce);
>> > -                     if (!revs->diffopt.flags.find_copies_harder)
>> > -                             continue;
>> > -             }
>> > -             oldmode = ce->ce_mode;
>> > -             old_oid = &ce->oid;
>> > -             new_oid = changed ? null_oid() : &ce->oid;
>> > -             diff_change(&revs->diffopt, oldmode, newmode,
>> > -                         old_oid, new_oid,
>> > -                         !is_null_oid(old_oid),
>> > -                         !is_null_oid(new_oid),
>> > -                         ce->name, 0, dirty_submodule);
>> > -
>> > +             if (diff_change_helper(&revs->diffopt, newmode, dirty_submodule,
>> > +                                    changed, istate, ce))
>> > +                     continue;
>> >       }
>>
>> If I'm reading the indentation correctly, the "continue" comes right
>> before the end of the for-loop block, so it's a no-op and should be
>> removed.
>
> It is a no-op, but I left it in as future-proofing in case more code is
> added after that block later. I'm not sure whether that line of
> reasoning is enough to leave it in though.

I don't think it is. If we haven't thought of the reason why we would
need to skip code, that seems like YAGNI to me.

As a matter of personal taste, I wouldn't leave a trailing "continue" in
an earlier patch even if I were going to change it in a later patch,
because it looks too much like an unintentional mistake.
