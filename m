Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41B0C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 15:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbiGSPvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbiGSPvD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 11:51:03 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044104330F
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:50:53 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o21so11489369qkm.10
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WnlcS8m1VHtfkW/pYS7GcGk61ycF8evGu6ywBdy87Lw=;
        b=cB11P4wzu0wyVx/9LKqRaWN+ZB7I5Db9D9SULxW0YYZoXLWgIwSiWLGsWdv8BQrUdX
         kphLgGO+M2bfTTdFuM2OpfIXvTtdWFoMk8GnieNgFID7rLzCOtO78p0oMw2dMKcRGCM0
         JhBNHKQYt0JAYwE/kyDLHblaSQDyOZXqHzF8Zvzn7tyoEIGgovTWBWpiDSLb6NgwuLy1
         moW49y1TJTdq4JSjm+Tr1m5jWUhdxeP1SV6dq2o0kpbJP8M75oyPA4Svq7ARRc7k/Qu/
         5HiRADQb8gSlvtdyv8J880RsKz0GgzFO8abgph/QWA65n/ohHatdZVeh8/m0iTy29/iI
         MnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WnlcS8m1VHtfkW/pYS7GcGk61ycF8evGu6ywBdy87Lw=;
        b=j9wrETvLVAWUDdxxGfCvmYLZQRrLDukZOKlNtA6Ln0CVZwYywWdGdPDSDpHzdiMFEk
         iWcjOZCyKi/HfoB5XMQoDntWTTdtWi+sXYOvK8e3Euv0ikCH6ztt5KLB0gSrpQrlI7LI
         po2zJ+2Pj3pO9n8lprkX8mNAu2Cj+sah9TqI4kF7gnZoAwiPiLsxS9/6a+qOFRSQJMVm
         xjLgzWNf4taffIa/Tj5zAQEUEfatZ06Uen4G8dWT1v98cqZXCp4O4ZM1XBCWsHc2Meu3
         UIeIHK9tjUkCyqhhDAcRLNUqitIHejKikVN4hR9PtmaTGQHvvR3DEcCK79XmQo45IQTd
         1H9w==
X-Gm-Message-State: AJIora/JTEPBlbjzVq6iPZQtR7ujzC4E5z1LMN72EXvmbZw4mWEOxEmi
        /KgiEMSQX1gBgGPiQqnj5mSF
X-Google-Smtp-Source: AGRyM1s8jG7UbC9a/k1ukqrmJRXlNh2zOA317ealIwFjtUq6AB66gdqzR+oCRQQBS1YMCi8OVpEz8Q==
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id s13-20020a05620a254d00b006ab84b825ebmr21217838qko.383.1658245841648;
        Tue, 19 Jul 2022 08:50:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id az33-20020a05620a172100b006ab935c1563sm2500545qkb.8.2022.07.19.08.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 08:50:41 -0700 (PDT)
Message-ID: <01247261-dbf0-f834-965b-a4c02c4ef256@github.com>
Date:   Tue, 19 Jul 2022 11:50:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 07/12] rebase: add --update-refs option
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <3ec2cc922f971af4e4a558188cf139cc0c0150d6.1657631226.git.gitgitgadget@gmail.com>
 <CABPp-BENsp3uc7J_xS0gr_yjWQ25NVuJbdHzCMEcaaGYvLEiKA@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BENsp3uc7J_xS0gr_yjWQ25NVuJbdHzCMEcaaGYvLEiKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/16/2022 3:30 PM, Elijah Newren wrote:
> On Tue, Jul 12, 2022 at 6:07 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <derrickstolee@github.com>
>>
> [...]
>>
>> +--update-refs::
>> +--no-update-refs::
>> +       Automatically force-update any branches that point to commits that
>> +       are being rebased. Any branches that are checked out in a worktree
>> +       or point to a `squash! ...` or `fixup! ...` commit are not updated
>> +       in this way.
> 
> I think the second sentence here should be split.  In particular, I
> don't think I understand the second half of the second sentence.  Do
> you intend to say here that branches pointing to a `squash!` or
> `fixup!` will instead update the first `pick` in the ancestry of such
> a commit, rather than that such branches are entirely excluded from
> any updates?  That's what I observed in my testing of your v3, at
> least, and that's the behavior I'd expect this feature to implement,
> but this documentation doesn't match.

Good find. You're right that these don't match, and its in fact that
I expected it to work this way, but it doesn't.

I've added a branch to my tests that points to a fixup! that is not
the tip commit and use it to demonstrate that it is not reordered, but
_does_ appear in the 'update-ref <ref>' list.

I'll update the documentation to match this behavior, too. This case
is unlikely to happen much in practice, but I now believe it's better
to include the ref than to ignore it.
 
> [...]
>> @@ -5660,6 +5764,9 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>>                 item->arg_len = item->arg_offset = item->flags = item->offset_in_buf = 0;
>>         }
>>
>> +       if (update_refs && todo_list_add_update_ref_commands(todo_list))
>> +               return -1;
>> +
> 
> As a tangent, I find it interesting that you add the update-ref
> commands as a post-processing step rather than as a part of
> sequencer_make_script().  I don't think you need to change anything,
> but I am curious due to my git-replay work if you find it advantageous
> to do it this way.

I found it to be simple enough to do a scan of the steps directly
instead of injecting extra logic into the _make_script() method.
The simplest reason is that we would need to inject "update_refs"
into that method.

Thanks,
-Stolee
