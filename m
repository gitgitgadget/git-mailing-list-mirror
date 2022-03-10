Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A472C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 00:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbiCJAWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 19:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbiCJAWE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 19:22:04 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BEB123BD4
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 16:21:04 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id r13so8647762ejd.5
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 16:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oCH71fKpyCcwbbT6I0rBSMxzHQs5Hc2PpA/8p868sO8=;
        b=KCtUpmMTCnHAFVxcuzEtyD/QbefZtJkfj9VlDKaCFmpoeVxef87t9nSYqT5avHNLkv
         sl1nysMShCnodYKCKj74cY8YqZZiPXj9gWGqc7ty9pJ0Mf5e7DBnsVTT4s646ayOeluk
         hMVHpBkzOc8gxN826MYUTbLMdVVu6UQtcWsk2SEYkjBf8hyGTYtg1C4BhGYFRpYaT784
         BeSmyCEo19yCqVNDL+zGpbe0x3nGsz8Vs7z5AAqQgzli3AiWCfvIR+sKhJMdIIZ51rm4
         bYslYzh2k+efk7fimLdHw4Arom4vfnrkpcWmpWCLG6+MbTxngqj4N8IcJrH1eAveFIIc
         hZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oCH71fKpyCcwbbT6I0rBSMxzHQs5Hc2PpA/8p868sO8=;
        b=UZ+C0Ks1SlgMpm8HDd0JgmXWh+vNp1WO8z31GWHSc4SOyiSlIsmrlFqm/HKq3c7CHv
         9HyImJuPPWD0t+3wbKwo2JK1g8mnZS8kRrdqWKKqjzPUe3Vx8SwywUs/6jSbvs5XS3Mk
         o1944zlh28vIiHvy7mblqWIzJpTIp/k/Hs1x1KHRfhZMYM0Urx5o+wNRnBPJAk1HPk4W
         8pH7YNv9oAnrlQqZnnErAZOiMny49GFPcPXavydvpfJyT7Sdxw9NvfKwZmHTFALz7g4p
         XrtZplYx0KR9H95m+txseSInl0E/2a9Dvd4fCBPNVlb2JnB+dEs06bmqvfobCileroKN
         uCvA==
X-Gm-Message-State: AOAM531AxMCJe7t9gcyWM4LqYfMYy3M303GW5DWwwvkjfdWwkmS/+Zbr
        EI09dFnEI1FI5XrmhPmTCzZqBR6nlPci/g==
X-Google-Smtp-Source: ABdhPJzDqy9Z3q6EA0g6xKPvzCBDbN4RrlWrJAUmgN65hIuwHK8BsFFmP5rSAglR3gdkvDnMx8Tn7Q==
X-Received: by 2002:a17:907:7f93:b0:6db:7634:f214 with SMTP id qk19-20020a1709077f9300b006db7634f214mr1989371ejc.3.1646871663064;
        Wed, 09 Mar 2022 16:21:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gb2-20020a170907960200b006dac65a914esm1239330ejc.125.2022.03.09.16.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 16:21:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nS6Y9-000NXv-Pk;
        Thu, 10 Mar 2022 01:21:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 21/24] revisions API: release "reflog_info" in release
 revisions()
Date:   Thu, 10 Mar 2022 01:13:31 +0100
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-21.24-ccf276641d6-20220309T123321Z-avarab@gmail.com>
 <99c429f7-af5d-78ac-9888-9f4f58d01b62@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <99c429f7-af5d-78ac-9888-9f4f58d01b62@github.com>
Message-ID: <220310.868rtilksy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Derrick Stolee wrote:

> On 3/9/2022 8:16 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Add a missing reflog_walk_info_release() to "reflog-walk.c" and use it
>> in release_revisions().
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  reflog-walk.c            | 26 ++++++++++++++++++++++++--
>>  reflog-walk.h            |  1 +
>>  revision.c               |  1 +
>>  t/t0100-previous.sh      |  1 +
>>  t/t1401-symbolic-ref.sh  |  2 ++
>>  t/t1411-reflog-show.sh   |  1 +
>>  t/t1412-reflog-loop.sh   |  2 ++
>>  t/t1415-worktree-refs.sh |  1 +
>>  8 files changed, 33 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/reflog-walk.c b/reflog-walk.c
>> index 8ac4b284b6b..4322228d122 100644
>> --- a/reflog-walk.c
>> +++ b/reflog-walk.c
>> @@ -7,7 +7,7 @@
>>  #include "reflog-walk.h"
>>=20=20
>>  struct complete_reflogs {
>> -	char *ref;
>> +	const char *ref;
>>  	const char *short_ref;
>
> This seems like the opposite change from what I would
> expect, because the 'const' implies non-ownership.

Yes, I'll change it.

FWIW we've had recent discussions on this point & it's a bit
context-dependant. See
https://lore.kernel.org/git/patch-v2-1.1-e2a166a9733-20211021T201541Z-avara=
b@gmail.com/
and https://lore.kernel.org/git/xmqqlf2vbbl8.fsf@gitster.g/

I.e. the preferred pattern is:

 * Make it "char *" if it's your own private struct, because it's non-const
 * If it's a "public API" and it's not really "const char *", but we
   don't want the API user to think they can fiddle with it, make it
   "const char *" and cast it in the free().

In this case I think I just mixed those two up, or maybe I initially
wrote it before that was clarified. In this case it's our own private
struct within this file.

>> -	free(array->ref);
>> +	free((char *)array->ref);
>> +	free((char *)array->short_ref);
>
> This further makes the point that we should be keeping
> non-const versions so we can clearly document ownership.

*nod*

>> +static void complete_reflogs_clear(void *util, const char *str)
>> +{
>> +	struct complete_reflogs *array =3D util;
>> +	free_complete_reflog(array);
>> +}
>
> Is there a reason we don't do the cast inside?
>
> 	free_complete_reflog((struct complete_reflogs *)util);

I think we generally do that more often that not (although I should add
an extra \n) there. I.e. to immediately cast the void* into a variable.

I also find it handy when e.g. stepping through in a debugger, because
you'll have a variable you can inspect without de-referencing it every
time, and if the function uses "array" for something else in the future
it'll be less verbosity on the second use...
