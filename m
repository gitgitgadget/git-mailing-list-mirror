Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D9CC636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 12:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjBGMuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 07:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjBGMuG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 07:50:06 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6FEAD04
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 04:50:05 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lu11so42899470ejb.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 04:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ji9NKJJICdV9QTuyjHgYrhPeZ2xCmoIA8RIZbZwmi0w=;
        b=FPOIMaus6XTFmi0t9fXVAtK8YUjLxd8krHNLoQbi2dLv1mnlvbh8P7+p+/qFRrbmOx
         8m5j9xHvV6IZ/SDGy9WGoJmWigcYxz09c8dbwv3c08cF9qzr0iBi3IjnRiRj/fA04rn1
         y3PO5jULRyPxu1qB16xPyTo/5Z17sMj+Jasp0yQfwE5VAsfLmofAOVQALXWvIAADgtya
         ORZxcwpaYvhYTit3AGRLKptOecpT5orCJOcEMg+s3X5m3GclAlFulZkwiecDnnI8SItb
         BkMEAL5mlJsyM8etlN4QbUw+rgOeLqKvuMaqfD0euhxuYeqHx3lcWXAwhWeC96V6VxLq
         nxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji9NKJJICdV9QTuyjHgYrhPeZ2xCmoIA8RIZbZwmi0w=;
        b=2Go4OivkUFNreyVGCYHCRu/r6OPay626E2uabTzDLYUGwcVZZFxymEj2/YiWrP6qQF
         6HxCPMm6hCE/6TcWNiqaWWLtT9xORbxQXKrL51haDG/KFzUZtxZXcl/YJF+RliySvDkC
         rLAtBa8GTsnCrUfxOcaf7jiU0lFOEZ0sB5/y4MQmzO4NqukMVDS0w7Xr9cDLlVeJKOKf
         2nyF8VOGbfSxHYYOK+HsEQhZYWQ6+wo2THj5tN2k3RYzBx0elSb4WT23UxgPD+rUR++t
         TC3vyaRkaLY4wmKaHaP8fu99LIk3akxLG1OF6xzOrYDAjxnQGo3INZqgxWtvfFUaBVrb
         s+KA==
X-Gm-Message-State: AO0yUKXrtoKImn4MI+OF/2bi96aGM4zYFNCyTAsqzyn3oTvZj+cCRpFu
        /ve/9XAiLwttFf9SbGMTINt0wVRkbUTWzA==
X-Google-Smtp-Source: AK7set/QDp8AirALSu25VuSEw29kAotvgEB+hIXIzcfHOcKfaYNJh2eOM2bAoL1v6xQ6zIZmjMOxew==
X-Received: by 2002:a17:906:5d06:b0:878:46ed:6a29 with SMTP id g6-20020a1709065d0600b0087846ed6a29mr4287140ejt.3.1675774203216;
        Tue, 07 Feb 2023 04:50:03 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id ks14-20020a170906f84e00b008a5cbd8f7d1sm2201662ejb.127.2023.02.07.04.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 04:50:02 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb
 2023, #01; Thu, 2))
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 07 Feb 2023 15:50:00 +0300
In-Reply-To: <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 07 Feb 2023 12:06:00 +0800")
Message-ID: <87wn4tej2f.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Hi Sergey,
>
> Sergey Organov <sorganov@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>
>>> * so/diff-merges-more (2022-12-18) 5 commits
>>>  - diff-merges: improve --diff-merges documentation
>>>  - diff-merges: issue warning on lone '-m' option
>>>  - diff-merges: support list of values for --diff-merges
>>>  - diff-merges: implement log.diffMerges-m-imply-p config
>>>  - diff-merges: implement [no-]hide option and log.diffMergesHide config
>>>
>>>  Assorted updates to "--diff-merges=X" option.
>>>
>>>  May want to discard.  Breaking compatibility does not seem worth it.
>>>  source: <20221217132955.108542-1-sorganov@gmail.com>
>>
>> Hi Junio,
>>
>> This does not break any compatibility, as far as me and I believe
>> reviewers of these series are aware.
>
> My 2 cents (which maybe lines up with what Junio meant) is that this
> series doesn't break compatibility on its own, but IMO the approach
> doesn't make sense unless we also intend to flip the default somewhere
> down the line. "log.diffMerges-m-imply-p" is a really specific config
> option, and it needs to justify its addition with an outsized benefit.
>
> I don't think it meets that bar, the only use cases I can think of are:
>
> - Before we change the default, setting "log.diffMerges-m-imply-p=true"
>   gives the 'nicer' behavior. But if the user had the permissions and
>   knowledge to do so, they could just pass "-p" instead for
>   correctness.

Except I can't configure this in centralized manner for multiple users
on our host machine?

>
>   If the goal is to reduce typing, then we could add a different CLI
>   flag that would behave like "-m -p", or we could teach "git diff" to
>   accept proper single-character flags. Either of these options would be
>   more discoverable and cleaner.

The only drawback of this is that this leaves "-m" inconsistent with no
apparent reason.

OTOH, teaching "git log" to use common options machinery to accept "-pm"
looks to be quite a project, and doesn't fix '-m' inconsistency anyway.

Then, out of curiosity, what do you think was the reason to change
"--cc" behavior to match that of "-c"? To save typing? To me, changing
"-m" accordingly is an improvement to the overall feel of git interface,
the same way as changing "--cc" was.

That said, if we decide to go for new option, I'd suggest to add "-d",
and probably obsolete "-m". This does not look to me as appealing as
finally fixing "-m" though.

>
> - After we change the default, setting "log.diffMerges-m-imply-p=false"
>   gives the old behavior, which might be needed if the user is running
>   scripts written in for an older version of Git. I would find this
>   compelling, but as Junio mentioned [1], breaking compatibility doesn't
>   seem worth it, so this point is moot. On the other hand, neither of
>   the alternative approaches break compatibility, so they're superior in
>   this regard too.

The only incompatibility found was obsolete use of "--first-parent -m",
that was the only use-case for "-m" for a long time, and this could
probably be detected and handled specially, though it sounds like a
nasty kludge.

>
> - The only legitimate use case I think of is something like a script
>   that uses "-m" assuming that it implied "-p", AND the user has no
>   ability to modify the script. Then the user's only recourse is to set
>   a config. But this is so exotic that I don't think this is a good
>   enough reason to have the config.

Yes, let's just change "-m" behavior then, and let exotic scripts just
drop "-m", as it's not needed for a long time already in the combo
"--first-parent -m" that currently reads "--first-parent".

>
> I wouldn't mind seeing a version of these patches without
> "log.diffMerges-m-imply-p=false" , but in its current form, I agree with
> Junio that this isn't worth it.
>
> [1] https://lore.kernel.org/git/xmqqbko1xv86.fsf@gitster.g/

All you say is understood and are valid arguments, but then we will
continue to face pretty valid confusion of why "-m" behaves differently
from "-c/--cc/--remerge". I personally don't care, provided I get a way
to make it behave sanely, and that's what "log.diffMerges-m-imply-p"
patch does.

As a kind of complaint, it was simple 1 patch from Junio once upon a
time to change "--cc" to a sane behavior of implying -p, and now it
takes rounds and rounds to do the same for -m. This is rather sad.

Finally, event without "log.diffMerges-m-imply-p", the rest of the
series still makes sense, so if the conclusion is to remove it, let's
still merge the rest, please! Let me know, and I'll then remove the
patch and will change documentation accordingly.

Thanks,
-- Sergey Organov
