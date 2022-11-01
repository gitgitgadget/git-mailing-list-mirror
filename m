Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E481C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiKAWX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiKAWXm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:23:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46F01A21A
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:23:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p15-20020a17090a348f00b002141615576dso341307pjb.4
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgVYTAtK3FjYia5NlNZLubxLxlTtYgkOXJ2Vq1HVqVo=;
        b=ITVyZRikacZlkbcJl9AVWY3rOF1xfS5PyadzZepty/nPVUD6R+BJmJvU4OiBhEuvwe
         sjWYIWMZAGI5Igy/KsK45Dnyx+mli/utERIfm1s87HPAulBQJksgXHFo9Y+YGG4Q267F
         yr537GqXauIz0Bwy9J84/J6dfpvDMS2o5lRN6ZqWzL4PnmxzYgCcyziOvnUUUM6yJGzD
         i+wHcSkPLTBe5ytVMvfz5E+hUx8Sn/CxIg+enfm8CAtDXuq9O4+eboJZ4d+U9L7pPQjo
         ebDYz7EtvFtvelg8mc7MHhncr6gXOh4UrREMecT7BeP8I+HKVAOhELi8CnaNmIaF7Yq8
         +Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DgVYTAtK3FjYia5NlNZLubxLxlTtYgkOXJ2Vq1HVqVo=;
        b=Bb+ibS8xiHt1I6zTf2Hp57w9Xua9EoUQBfkhkH65vqi7Bx1dpd+CJsZGI3w4+X10ol
         9877jKu4BmkTeny8AwYd1/f3JL4TqCHarTiNp5FhEvcZsbKddOIkTl/5U49O3fUfbE0A
         5/NlISqsHAMKRQCLFwsHvyNXTfSvnXAD1csPZS9cH5TTt7uxufg4vF3VeSiqy+tjAsf9
         zwDpVISRnSilCAxGhp/xqNxYQQQ/3ClojRRZ+yUODdaid3Gp34SZCWuNQgv2fIISMxgY
         R5ckJ5avFTAksL0xDAAGuZtps7jJbIC4D1xxpwO9NAkAkgMrtwDFCtHW+I4lS0kY14il
         VHTQ==
X-Gm-Message-State: ACrzQf1LOfqj9poFAsEHAkOMOke0B1HayJuomUPBZM1h6d3BpdXLANao
        46ygDF1ULutXFUT7/ilK+3o=
X-Google-Smtp-Source: AMsMyM7WhmToMvk1Ws/LPfw3gXRylE5dq0nSdY3JUIFZm4NJ/U2Zrc43IwEufee4qR9e6V//5o5ZHw==
X-Received: by 2002:a17:90a:d3c7:b0:213:7f6:e5b6 with SMTP id d7-20020a17090ad3c700b0021307f6e5b6mr40169408pjw.42.1667341406061;
        Tue, 01 Nov 2022 15:23:26 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z27-20020aa7959b000000b00562a237179esm6985702pfj.131.2022.11.01.15.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:23:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] Documentation/howto/maintain-git.txt: a pair of
 bugfixes
References: <cover.1667260044.git.me@ttaylorr.com>
        <Y2DSSM8ujceSgp+b@coredump.intra.peff.net>
Date:   Tue, 01 Nov 2022 15:23:25 -0700
In-Reply-To: <Y2DSSM8ujceSgp+b@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 1 Nov 2022 04:01:12 -0400")
Message-ID: <xmqqo7tqco0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Why not have a single file with all of the topics, with two "###"
> markers?

Mostly because jch and seen are built in two distinct steps, and I
need to be able to rearrange lines in the redo-jch.sh file either in
the editor or by running "Meta/redo-jch.sh -u", without touching
what is in redo-seen.sh file (meaning: what comes after your final
"###" cut lines).

After replacing the existing topic branches and creating new ones
for new topics, decide which topics to merge down to master and next
and edit redo-jch.sh (while looking at the what's cooking report
and/or output from "Meta/cook -w").  If we merge some to 'master',
then tentatively write '###' marker before these topics.  Then

    $ git checkout --detach master
    $ Meta/redo-jch.sh -c1
    $ edit RelNotes
    $ git commit -a -s -m "${N}th batch"
    $ Meta/round -coccinelle ;# and other tests as necessary
    $ Meta/Reintegrate master.. >P
    $ git checkout master
    $ sh P && git commit --amend --no-edit --reset-author

will rebuild the 'master' (but this is needed only when 'master'
gets updated in the day's integration).  After that

    $ git checkout -B jch master
    $ Meta/redo-jch.sh

and use 

    $ git branch --no-merged jch --no-merged seen --sort=-committerdate '??/*'

to see any topics that are not in last 'seen' and 'jch' we just
rebuilt.  They are either replaced in 'seen' or new ones.  Then
merge some of them that you are more confident than others to 'jch'
and test and update the redo-jch.sh script.

    $ git merge xy/xxy
    $ git merge fr/otz
    ...
    $ Meta/round ;# or whatever tests that are appropriate
    $ Meta/redo-jch.sh -u

This "-u"pdate step can be done without disturbing what should later
build on top for 'seen' by having the script separately.  

When day's integration contains an update to 'next', there is
another step here:

    $ git checkout --detach next
    $ Meta/redo-jch.sh -c1
    $ git merge -m "Sync with 'master'" --no-log master
    $ Meta/round ;# or whatever tests that are appropriate
    $ git diff 'jch^{/^### match next}' ;# must be empty

After that, queue new topics that are more questionable on 'seen',
and the rest:

    $ git checkotu -B seen
    $ git merge ni/tfol
    $ git merge yo/min
    ...
    $ Meta/round ;# or whatever tests that are appropriate
    ... here, new topics may be worse than what I initially thought
    ... that they need to be ejected from 'seen'
    $ git reset --hard jch && git merge yo/min ... && Meta/round

And once satisfied with the new topics, queue the remainder.

    $ Meta/redo-seen.sh
    $ Meta/round ;# or whatever tests that are appropriate
    $ Meta/redo-seen.sh -u ;# finally

Being able to rebuild the redo-* script for only the 'jch' part,
independent from the 'seen' part, is quite essential in the
workflow, because I may not yet know how day's 'seen' would look
like, when I am recording the topics and integration order for 'jch'.
