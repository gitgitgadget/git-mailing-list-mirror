Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED27FA373D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 23:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiJZX2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 19:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiJZX2M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 19:28:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7335D71E
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 16:27:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q9so25976243ejd.0
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 16:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja34sd2i5OU2lVRVcF0kJIRAp497Bo1Q31vEqwvyyQ4=;
        b=c7NMJTdgfcoimDOd3XwKNE9phVjNydpBpDVzDJcSugSnZIHiK7YGIov6vL07aweiik
         5x6QA3VCi4y++RJZ4gF3DnGawynJd1GcTRXnBO73iiLZjxT7HsWIzK4s14MwPwo6qu+G
         vBIf2L88KoSh9UgDN4RCmH1gUGLIlUvste0DFpGTJoxxhr+EaMj5mGr9PWwx7j6LjlTl
         D8P8O94LPzlfV1mSPpJzZ5HHK3WIcMdd79M+nG1GB8/JUJnvIicN2TE7Vg97fyiQNyH3
         Wl6CHtCiyrg77MDlw5M3UoxQiEMnitXrcFnDZ0gxGyhkauDsVNgSBQo7K3QGt3rcpr6d
         nYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ja34sd2i5OU2lVRVcF0kJIRAp497Bo1Q31vEqwvyyQ4=;
        b=y/VQe0WsDgr5AudWMgx/oYPpb+VVGAxjThGEVd/iq0jzsr3k14Fx43yvhHjz+c45JX
         xJQXb+Jt4oqfU4GXdxWWZAcjXnLSxj9mK+moGHgELTtC0TB4+hSv9gviUemlf18a6+2k
         IYFs6M2ekzzEK4AC7/hIMeDPAiXTEdG2KzxFFchQgmhe/R4Djf8L/6vSe5pQ0dhHR/D9
         YlNA+5gCSkfwrtghYX1RNdhyUvDZoLCSGpjNM1L7qKqtO/dVrVGZqcBJH3Tg9wP7O19m
         /CGiGjYFgVmQgnY1JFx9g9LNtUO9ClwftW6gShI+DzWlUbueiK4mSYVLnCvh/5svEHUR
         bD8A==
X-Gm-Message-State: ACrzQf0/WujhSZqAjske+rLsWfXkx2eVW+iQQ/zZrs1QwsqRXuGo+qFe
        LvP7b0JmXTPJdNP84dXOA7DNexAorpV+Tw==
X-Google-Smtp-Source: AMsMyM6xB80WereMCnbAC2gCRClNtl64ma4QvV93Yy4bV+8ZiNp1eLwDUy5ayZ2Y+Q83GHMbSP0EzA==
X-Received: by 2002:a17:907:2ceb:b0:78d:b765:c50d with SMTP id hz11-20020a1709072ceb00b0078db765c50dmr39411485ejc.73.1666826864864;
        Wed, 26 Oct 2022 16:27:44 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ky3-20020a170907778300b007a0b28c324dsm3566172ejc.126.2022.10.26.16.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 16:27:43 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1onpoE-008zrl-1o;
        Thu, 27 Oct 2022 01:27:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Teng Long <dyroneteng@gmail.com>, gitster@pobox.com,
        derrickstolee@github.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
Date:   Thu, 27 Oct 2022 01:19:16 +0200
References: <xmqqtu5zyndk.fsf@gitster.g>
 <20220829024803.47496-1-tenglong.tl@alibaba-inc.com>
 <Y1mp23NHB0qzKsPR@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y1mp23NHB0qzKsPR@nand.local>
Message-ID: <221027.86czaeb1xt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 26 2022, Taylor Blau wrote:

> On Mon, Aug 29, 2022 at 10:48:03AM +0800, Teng Long wrote:
>> > If the "ignoring extra" is a totally expected situation (e.g. it is
>> > not suprising if we always ignore the bitmapfile in the alternate
>> > when we have our own), perhaps we should squelch the warning in such
>> > expected cases altogether (while warning other cases where we see
>> > more bitmap files than we expect to see, which may be an anomaly
>> > worth warning about), and that may be an improvement worth spending
>> > development cycles on, but I am not sure about this one.
>>
>> That's exactly good suggestion. In my opinion, I think to avoid the sensitive
>> warning and the same time we keep some information to let the users know "Oh,
>> there are some extra existing bitmaps we just ignored then maybe can do some
>> optimization works", but I think just remove the total warning here is
>> reasonable also, i'm good with it.
>
> I think that it is somewhat of a step backwards to remove it entirely,
> but let me qualify that a little bit.
>
> At GitHub, we actually *do* remove this warning entirely:

You at GitHub also added it entirely :) => fff42755efc (pack-bitmap: add
support for bitmap indexes, 2013-12-21).

Anyway, I'm fine with removing it. From skimming that commit it was
probably added for no particularly strong reason. But I found the
omission of "it was added in xyz commit" to be sometihng that could be
added to the commit message in this case, and....

> You could also imagine adding a configuration knob here to control
> whether or not the warning is shown, but I find that to be kind of
> gross.

FWIW I don't find that to be particularly gross. I think it's fine to
just delete it.

But isn't this a general sign that we should perhaps have different
output when "pack-objects" and the like is run "locally", v.s. when
we're running via some server process, and end up spewing a message out
that the user can't do anything about?

