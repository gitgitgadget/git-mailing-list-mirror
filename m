Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF82C433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 02:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbiBSC5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 21:57:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbiBSC5O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 21:57:14 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA1724092
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 18:56:55 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qk11so19126839ejb.2
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 18:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Cdp+vDCFw3wH3NMCchd0soUjtlhWClqniB8PkCezElI=;
        b=QNph1WAW/EJkkTcoDEIILalr6Zt2auITE9JakMOaJQ66y3C+tO5vHWaUzYPy7u+GJ2
         xaIKyugiClzLEeV1xYI9BrG5bKW2seSwj7j8gkOpE0OtfrocTyccWUhbtpvyO3FZQGqa
         9cw7FUtn6UmZ5Mkwz52v6JwEp+nIfc/j8XV+uTRGiDRuWuU/66yo9mQz7CUmBuKjcyf8
         tuAPpswE7Ezaq9xtbaMVF7UVPWSGtIphH6FsbUXq6+K7bnAh/vyDxhQIfGZdM2D/sCBu
         lggAWGdGbN8DaVxY1DPP2q8WzD7RpKr/pYwKLhEenucHFtiwA29oIbjmVkrJdGZIF7rX
         QGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Cdp+vDCFw3wH3NMCchd0soUjtlhWClqniB8PkCezElI=;
        b=2g4H4Vz6AAIYKJfguY5lslYRgQS8CzFac4yFAIYxwjOI/Z82mHksvwtDczp24Imj/A
         QW1sddhhDlxeBYh7yjUaoMe1dcZIHCvPKD0OlWCiT//sDGTwWhO7epkg3Ggnqa+Ql78+
         HohB2uvk7SpeM3Lq2i+6JmXynfxE/fI6TdVSY1E5UpBfX9r4p0B8QaWTf7wBk98SiFsF
         sc43e1GCMEsSwMwk6c2i90iO/NYq+yzcW2OEIZaLS1fj0WahK6WplDAF8k3+l6QDlT0J
         eWKK2G3XKknHUFl5bAYP6EZktfQQH2bkdl+B54Cd22Wf2InZCHSrTbUuqwtAfU53IJIs
         Rs5g==
X-Gm-Message-State: AOAM530fuE2lL7KnJqj/VmO6zacu/v0DZ2HwMPf3hc6V2qXK86ydI/2q
        PgrER4MOBXlEePSXPHXWP/bFo4Z2uWTLvg==
X-Google-Smtp-Source: ABdhPJwIRlQ3++/EzVL2rBC30T39Tl09iOB1Zcnors+nuDK7C/jrJdsSP3fD5Q6kXVUDjagi399Qaw==
X-Received: by 2002:a17:907:1384:b0:6cd:5c6a:eec0 with SMTP id vs4-20020a170907138400b006cd5c6aeec0mr8960230ejb.35.1645239413999;
        Fri, 18 Feb 2022 18:56:53 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f19sm1232210edd.70.2022.02.18.18.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 18:56:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLFvZ-004fkU-60;
        Sat, 19 Feb 2022 03:56:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] reflog: libify delete reflog function and helpers
Date:   Sat, 19 Feb 2022 03:53:14 +0100
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
 <xmqqpmnkymfn.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqpmnkymfn.fsf@gitster.g>
Message-ID: <220219.86h78vftsa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/reflog.h b/reflog.h
>> new file mode 100644
>> index 00000000000..e4a8a104f45
>> --- /dev/null
>> +++ b/reflog.h
>> @@ -0,0 +1,49 @@
>> +#ifndef REFLOG_H
>> +#define REFLOG_H
>> +
>> +#include "cache.h"
>> +#include "commit.h"
>> +
>> +/* Remember to update object flag allocation in object.h */
>> +#define INCOMPLETE	(1u<<10)
>> +#define STUDYING	(1u<<11)
>> +#define REACHABLE	(1u<<12)
>
> These names were unique enough back when they were part of internal
> implementation detail inside builtin/reflog.c but it no longer is in
> the scope it is visible.  builtin/stash.c (and whatever other things
> that may want to deal with reflogs in the future) is about stash
> entries and wants to have a way to differentiate these symbols from
> others and hint that these are about reflog operation.
>
> Perhaps prefix them with REFLOG_ or something?
>
> Or, do we even NEED to expose these bits outside the implementation
> of reflog.c?  If these three constants are used ONLY by reflog.c and
> not by builtin/reflog.c (or builtin/stash.c), then moving them to
> where they are used, i.e. in reflog.c, without exposing them to
> others in reflog.h, would be a far better thing to do.  That way,
> they can stay with their original name, without having to add a
> differentiating prefix.

No objection to this, but FWIW the general pattern for these object.h
flags is to use these un-prefixed names:

     git grep -A20 'Remember to update object flag allocation' | grep define

To be fair the only one that's really comparable is the revision.h ones,
but those are very non-namespace-y, with names like SEEN, ADDED, SHOWN
etc.

I'd be fine with just leaving these as-is, especially with compilers
warning about macro re-definitions.
