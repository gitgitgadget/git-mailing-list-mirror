Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69259C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 17:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiGURxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiGURxI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 13:53:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F6986C39
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:53:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id os14so4464027ejb.4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=d7ZYaecReRjed94qUJBJlnXmd2n3xPF5JzPOjK6G2dc=;
        b=ok9CywJWPTrXiJlBMC84R+dnC7/bkeu73Xp+irSLjlWnFTWd1l9yQx8iDlCred3qHB
         0fiQvvaC747DyC+8V6Itvp3CIiYYNDZCWZCpB0zo7JUnm9ejlQb4tSqgOfLoObcNost6
         +WiDmrQTcZQmwCqnYypK7htD3eXvFizLKUyWFZtPYKDPOEUqeUk0+1OJu580isZtzEF5
         8Oe8Z8wZqXfUJNJowtTigPB4Q8X4lj7rGnk1g1aGWT2KW/8Fe1D4lusP/S8EYD3QzqQC
         PEm1vd6mTc0wNJ86JkD1v/83QKDYbcZlYADrCGLSqD2bjTN2ptVovsU5s0YufZH+lcUY
         fgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=d7ZYaecReRjed94qUJBJlnXmd2n3xPF5JzPOjK6G2dc=;
        b=B+Po7pacnHTKGlqOMk2PqlhIt3580HvKOLskxAwqPP6Fk9joftw3xdSIzAepV7Efu1
         caVpW9JZ6vsWunVn7q0ZTfKqQ8d3clvFenRykSOVFhnR6pb8Hms63y7wmmd8TNsc9j0s
         H3t5ETkwg4HpgQrJGjc9Rx3eHd9lxeIyXRvyYJ/PNe2a59h7bvwjX7YOpZPWMd7agjDf
         5MeU07zneGpHKmRlsuL2WEmeVq7TILaditiS15P2fFQw7XhpKxGZaT4plZEb0FAR8t8t
         YYRBeQ8eqLBLdwWUr/Z5SgsGrNIlPCW8/OyhDUCa5s4GCF4sWSgwQIKuBXYw0PA8AEKM
         3NSQ==
X-Gm-Message-State: AJIora/HZplYMuKnNFp+OU1eSaInKUPNLzY+kJz5/i+jEIFaOhGFjogJ
        4flWE476iNP04I4VtFvQzHI=
X-Google-Smtp-Source: AGRyM1uOTHo0hDw2j6yugQJt95JwJnYtCu7kc7IvgJS7NavyCxZLNLSkMJvjaAILPCJ6QUDxp4EsVw==
X-Received: by 2002:a17:907:2816:b0:72b:4fc3:1b3e with SMTP id eb22-20020a170907281600b0072b4fc31b3emr39797955ejc.601.1658425985582;
        Thu, 21 Jul 2022 10:53:05 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t6-20020a170906608600b0072ecef772acsm1085589ejj.2.2022.07.21.10.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:53:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEaMB-004kET-PP;
        Thu, 21 Jul 2022 19:53:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: On-branch topic description support?
Date:   Thu, 21 Jul 2022 19:51:51 +0200
References: <xmqqilnr1hff.fsf@gitster.g>
 <220721.86mtd2tqct.gmgdl@evledraar.gmail.com>
 <20220721162620.f5ffcedkbvvdhhu7@meerkat.local>
 <xmqqk086id1k.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqk086id1k.fsf@gitster.g>
Message-ID: <220721.865yjqtksg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 21 2022, Junio C Hamano wrote:

> Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
>
>> On Thu, Jul 21, 2022 at 04:53:18PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>> I tried now with "git rebase --rebase-merges -i", and it supports it
>>> properly, i.e. I could re-arrange it so that it's:
>>>=20
>>>               A---C---B---M topic
>>>              / \         /
>>>         X---Y   ---------
>>>              \
>>>               master
>>
>> This is clever, but it has a hard restriction that nothing happens to A:
>>
>> - you can't move it so it's B---A---C---M
>> - you can't squash A+B
>>
>> Unless all the tools are taught to properly modify the merge commit.
>>
>> Or am I not reading this right?
>
> I think the drawing is about a two-commit topic that has B and C
>
> Or the drawing is wrong and M's other parent should have been Y.
> IOW, "git merge-base M^1 M^2" is the bottom of the topic (and our
> ranges always exclude the bottom end, X..Y does not include X but
> does include Y).  "git rev-list M^1...M^2" are the commits on the
> topic.
>
> Then you can shuffle A--B--C in whatever way you like with "rebase
> -i" or "filter-branch", using "git merge-base M^1 M^2" as the base.

Yes, those last two should be:

              A---B---C---M topic
             /           /
        X---Y------------
             \
              master

And:

              A---C---B---M topic
             /          /
        X---Y-----------
             \
              master

I.e. you could re-arrange it so that it's:

              C---B---A---M topic
             /          /
        X---Y-----------
             \
              master

Or whatever, sorry about that mix-up.
