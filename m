Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954A4C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 17:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiGURv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiGURv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 13:51:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B1882F89
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:51:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g1so3062656edb.12
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=MK5mMKr8sQRgZYtnNql0FmMmHoCT85kQ1ka8uvZ7E2o=;
        b=h7+7bwQuU43OgO7QIba2NL1fiJNLKUf/N7Br08VKk2sHnhS/2X8BohNqiOXKkV7MlP
         2Co0q3ABKdB13bfzYwJSQE+ALT7OjffY0VmyjHAiaGGORtKpUYLcBY2njTT86g76tVxd
         ZRlLGxnjH7AMTvgtARqmcKfizGIE4KlN5ABqy+OqPwNp7xWWqJ10O1tCm5xws36RlPQV
         e6LPYsbkJaQwNqExNvKfCqsTpFDCzxzcxv8c2XJSUOKq/vxmT2GaMcVZ6VqkvEZ1nGw5
         S1LI3NI5maA3MCSyqG3LcdSovCsu8J+ZCW9kW2w8NqmFUOOCrMqjuplmVj68J9zuIm/6
         hyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=MK5mMKr8sQRgZYtnNql0FmMmHoCT85kQ1ka8uvZ7E2o=;
        b=XpuZ6LLB0lFwAf1xOO3rMnuAWjH+dB86ps1FKvu7b/wBr3t748M2uUTLOKz31l7ofy
         SToU71/cAXDQO6YnfmH98cx08u5zAPO6PxYCCK9D17zHYuHj9k8dK3kbudlehIoKF1Lx
         f0R9+XmAGa5j9VlIAgle+slFSGBsXFaNDukOTgi/CqaRoKio9Qvhh8AikSZeusTk06j6
         XdL10Y3t5QuF4x8axsMNNmvJ5cSLunZArVd7pnc+eo8I8nAdUVDGkeduf+y9epDTP/AD
         Jf5unQ8hrOHu4gooW/PVkQazjxZ8TIw6OfTTBkbDMZ083gOWvUdJ/mxxlsL24NhT25AN
         RkAQ==
X-Gm-Message-State: AJIora82b770f3KAyn/OmmlH6qvXMLbJN0fMyaU9ZEGf0Kcz+YwZs77c
        UHnYOamCHDHyXK0WBkIXsb7mtS7/Wy9vyw==
X-Google-Smtp-Source: AGRyM1vQYrPRhhPXyPttZITKwxg2U8yelm251pVyUiyygKO5a09tQ2996lSAEoz6q96GdTecMEkFYg==
X-Received: by 2002:a05:6402:520c:b0:43a:aba8:84ae with SMTP id s12-20020a056402520c00b0043aaba884aemr60570758edd.198.1658425883465;
        Thu, 21 Jul 2022 10:51:23 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id da24-20020a056402177800b0043bbea24595sm1343513edb.31.2022.07.21.10.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:51:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEaKX-004k9u-CG;
        Thu, 21 Jul 2022 19:51:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: On-branch topic description support?
Date:   Thu, 21 Jul 2022 19:49:31 +0200
References: <xmqqilnr1hff.fsf@gitster.g>
 <220721.86mtd2tqct.gmgdl@evledraar.gmail.com> <xmqqwnc6idxr.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqwnc6idxr.fsf@gitster.g>
Message-ID: <220721.86a692tkva.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 21 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> To steal and amend a diagram from git-merge(1), we now have turned this:
>>
>>
>>               A---B---C topic
>>              /=20
>>         X---Y
>>              \
>>               master
>>
>> Into this:
>>
>>               A---B---C---M topic
>>              / \         /
>>         X---Y   ---------
>>              \
>>               master
>
> If you mean your topic have 3 commits, then I think you want the
> first parent of M to be Y, not A, but I agree the above arrangement
> can also represent what I was discussing.

Yes, sorry. The diagram is incorrect, but not the commands I posted,
i.e. one of the parents is "master".

> The thing is, it is unclear if such an artificial merge is an easy
> thing to maintain by individual contributors.  "rebase -i" with some
> extra options people are not familiar with may be able to reproduce
> the topology without losing information after you accumulate more
> commits on top of M (e.g. you build D and E on top of M and now you
> want to make it A-B-C-D-E merged into Y with M that records the tree
> of E; you'd amend M's message to talk also about D and E), but
> "it is possible" is different from "people are comfortable doing".

Yes, it's magical, but so is an empty commit having a new "CL"
meaning. I'd think both would require relevant tooling to be aware of
them.

But this is worse in that "git rebase" will get rid of it by default.

> If M did not have a backpointer to the other parent, and instead
> were an empty commit, then you recreated what I wrote in the message
> you are responding to.

Yes, that's the difference between the two.
