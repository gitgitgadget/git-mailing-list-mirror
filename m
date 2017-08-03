Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0BA1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 20:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbdHCUnx (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 16:43:53 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34165 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbdHCUnw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 16:43:52 -0400
Received: by mail-lf0-f53.google.com with SMTP id g25so10923345lfh.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 13:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xtA0O0+tGUZo9qTlkcibQXIaTYp91he1+vpzNAR3Oqc=;
        b=bVExf4cynFeKVbelXWE6I9F/mjwf5MKgID4TMxPsMy5u3f6zvSImECajCVcnC55ZFe
         2yLIPbS2byct9aWzt9Sr/EER3hYFgruzn4N/O2ZqWlNrje7V2BWG1Eqz9J92kDVMY6kL
         mrGiWEI7lzxh2gmW5VXDZFBJzHlfqSG92S5I6G1duZh8nbg7xE3vUpP24I5fhFVuDM1Q
         VSib/kep4XAhW8huP24Xmo2lMH1qSQmhzZomWmnbxmrp19vwS1WAIpZh0g4acGsNzCUo
         eZwKkcrx2UOyk+1mAeMizcP3b0mWA2isZGDTKZLOiO4tvsnIEdJkX4rtUqDVKLf4BjrN
         2piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xtA0O0+tGUZo9qTlkcibQXIaTYp91he1+vpzNAR3Oqc=;
        b=nCKc1oOe6t+BCJYQri42egqRdVvK/H/gCUMdqfxmTgIuNh5S2us70tcVQHLfbxZl3b
         PL/mTlgq40WSIFoJoVufoHH+dTwxB7f8uGHiqGZe/SsiPUv8xo8UaRFvcbceIYbIZqmU
         6nU9KT7esrrYIp6SLTV4heLZHKI0awEJYdb+6WFTvVySMOn5yRdhykrw2gbW3vbChLAm
         VY35eTJu0lPj0FzgQq2rbikBNk/Iihn7vkZ3gB+W2vFc/XX2KnZSAfT3eJHgtVmxs9Kv
         w3+YN/yAoi+EnzbkGn1ej88EeX6msziJZJPKDw3oR9mJU1e7lG7eOpRglLymluFt6ouB
         7bNw==
X-Gm-Message-State: AIVw1133X3DWcEZzD0rFR7oI3eNzVdBydzVaSeM4HgZYUuFUWa0rZqcy
        rSfhhb+8Q9B0WvmRCqrN883qNPxucPsG
X-Received: by 10.46.69.6 with SMTP id s6mr35210lja.40.1501793030869; Thu, 03
 Aug 2017 13:43:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 3 Aug 2017 13:43:50 -0700 (PDT)
In-Reply-To: <xmqqpoccwfpl.fsf@gitster.mtv.corp.google.com>
References: <20170725213928.125998-1-bmwill@google.com> <20170803182000.179328-1-bmwill@google.com>
 <20170803182000.179328-9-bmwill@google.com> <xmqqpoccwfpl.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 Aug 2017 13:43:50 -0700
Message-ID: <CAGZ79ka8YeW0ChP3Z3xjfV0r0aqg2sGpLDU5m5LGWyG9QED0Uw@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] unpack-trees: don't respect submodule.update
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 3, 2017 at 1:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> The 'submodule.update' config was historically used and respected by the
>> 'submodule update' command because update handled a variety of different
>> ways it updated a submodule.  As we begin teaching other commands about
>> submodules it makes more sense for the different settings of
>> 'submodule.update' to be handled by the individual commands themselves
>> (checkout, rebase, merge, etc) so it shouldn't be respected by the
>> native checkout command.
>
> Soooo... what's the externally observable effect of this change?  Is
> it something that can be illustrated in a set of new tests?

The illustration can be as follows

    git config submodule.NAME.update none
    git checkout -f --recurse-submodules HEAD
    git status
    # observe dirty submodule, which is
    # not what checkout -f promises

> IOW does this commit by itself want to change the behaviour of
> "submodule update" and existing (indirect) users of unpack-trees?
> Or does it want to keep the documented behaviour of "submodule
> update" while correcting unintended triggering in other (indirect)
> users of unpack-trees of the same machinery that is being removed in
> this patch?

"submodule update" is unaffected, only the recently introduced submodule
awareness of checkout/reset/read-tree are changed.

This option is documented as
    submodule.<name>.update
    The default update procedure for a submodule. This variable is
    populated by git submodule init from the gitmodules(5) file. See
    description of update command in git-submodule(1).

which doesn't indicate that any other command apart from
"submodule update" should respect it.

>
>> -     switch (sub->update_strategy.type) {
>> -     case SM_UPDATE_UNSPECIFIED:
>> -     case SM_UPDATE_CHECKOUT:
>> -             if (submodule_move_head(ce->name, old_id, new_id, flags))
>> -                     return o->gently ? -1 :
>> -                             add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
>> -             return 0;
>> -     case SM_UPDATE_NONE:
>> -             return 0;
>> -     case SM_UPDATE_REBASE:
>> -     case SM_UPDATE_MERGE:
>> -     case SM_UPDATE_COMMAND:
>> -     default:
>> -             warning(_("submodule update strategy not supported for submodule '%s'"), ce->name);
>> -             return -1;
>> -     }
>> +     if (submodule_move_head(ce->name, old_id, new_id, flags))
>> +             return o->gently ? -1 :
>> +                                add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
>> +     return 0;
>
> With this update, we always behave as if update_strategy.type were
> either left unspecified or explicitly set to checkout.  Other arms
> in this switch (and the other switch too), especially "none", were
> not expecting a call to submodule_move_head() to be made, but now
> the call is unconditional.
>

Yes. This is because each command (reset/checkout) should provide
one expected behavior. It is not that we can configure reset to omit certain
(tracked) files from being reset?
