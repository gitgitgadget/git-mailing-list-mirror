Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE910C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiCUXX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiCUXXv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:23:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C553730DC79
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:17:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c62so206606edf.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=WoQ51O3UQKmk/bN4dMKg6c439B+sESH5J9g9Nv2wvHo=;
        b=Utlvf03psDzItnQUVVX4EZap3OUuWhdWUUDW+LxnZV6QKF2rxGAQUlObR5hli0aiSh
         oFUhSS40V9KLPSmVj+4aftOEd7FiR4iXB/K9fJnJt6Hm/sABhm3/Ivz9eIXGX+Nl2vFL
         j1VjQAzLGe+1cR+wM60J6BHg1Rg7Qq0HTioWrbHEi8LrLC9tfjROBCnsJWc+Llx2LNPD
         9RU2rMY1xxqtGBJUta1APVrSZUv0pt59bxJ/oncFybfEL/hzXOBxAoihg09HiJCICJ9k
         su81IK0f81Tbq4wk9uP8FTxVISrlh6T2Ioqj/y5SsHxAXRXmrMKamRFQYPs6Epco7vCY
         MqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=WoQ51O3UQKmk/bN4dMKg6c439B+sESH5J9g9Nv2wvHo=;
        b=SNxWIfoJq8dyYCbH/VB7yd00qNBpuvzdZ9Uevepfxks4qbH/4wkFuWrOiwvBdG8xzD
         uTgOd0wky3RZMVjy+/C1t7+7fInQqJAXHpibc9LmwJeIo7FQWHfjEdgYkrW+bMPIl+Gf
         Olqfgnk+FXP2uKPak/UCt/YUVpiFs0eotoBg1HvstG6u7SQ5wA3f3KHQq2hHrtsHQpkB
         j/fm/zJlOlyJhvMemBECFrt+pTpPrUiBPjlxqGQBBajjrx/pzykCC9yLGPThGqQtIP64
         LzTKlSEYSDfraRP7CkWcNLu/8PW8hMZANkgCF/vHFzOB+gM2ogtrIFrGSxXwbwcQTlo7
         CryA==
X-Gm-Message-State: AOAM531qK81MBqwKHLwi5kpkTUto6YRylGqq27IpDqv/PZaItb6M4dD9
        6x2gouyXpYj69PL1cvgoRk96ffgiTrXoWQ==
X-Google-Smtp-Source: ABdhPJx+T12iQeunG6bZyT4WKhBvo+9QpyT2vnv2YCASFiGMlTw5mXSQ8eF1KGEQ7y5oAM5A0QM8AA==
X-Received: by 2002:a05:6402:1706:b0:419:1548:8119 with SMTP id y6-20020a056402170600b0041915488119mr17417731edu.126.1647904650013;
        Mon, 21 Mar 2022 16:17:30 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h30-20020a056402095e00b00412b81dd96esm8411440edz.29.2022.03.21.16.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:17:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWRHE-000Akj-Sz;
        Tue, 22 Mar 2022 00:17:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 3/7] update-index: use the bulk-checkin infrastructure
Date:   Tue, 22 Mar 2022 00:16:31 +0100
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <54797dbc52060b7fa913642cd5266f7e159a5bc9.1647760561.git.gitgitgadget@gmail.com>
 <220321.865yo79wkf.gmgdl@evledraar.gmail.com>
 <CANQDOdeox=Wox94SW+oUgbLDdLZ+KOdw6AWdBzwFkR18xmaNtQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <CANQDOdeox=Wox94SW+oUgbLDdLZ+KOdw6AWdBzwFkR18xmaNtQ@mail.gmail.com>
Message-ID: <220322.86v8w6opyv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 21 2022, Neeraj Singh wrote:

> On Mon, Mar 21, 2022 at 8:04 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Sun, Mar 20 2022, Neeraj Singh via GitGitGadget wrote:
>>
>> > From: Neeraj Singh <neerajsi@microsoft.com>
>> >
>> > The update-index functionality is used internally by 'git stash push' =
to
>> > setup the internal stashed commit.
>> >
>> > This change enables bulk-checkin for update-index infrastructure to
>> > speed up adding new objects to the object database by leveraging the
>> > batch fsync functionality.
>> >
>> > There is some risk with this change, since under batch fsync, the obje=
ct
>> > files will be in a tmp-objdir until update-index is complete.  This
>> > usage is unlikely, since any tool invoking update-index and expecting =
to
>> > see objects would have to synchronize with the update-index process
>> > after passing it a file path.
>> >
>> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
>> > ---
>> >  builtin/update-index.c | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/builtin/update-index.c b/builtin/update-index.c
>> > index 75d646377cc..38e9d7e88cb 100644
>> > --- a/builtin/update-index.c
>> > +++ b/builtin/update-index.c
>> > @@ -5,6 +5,7 @@
>> >   */
>> >  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>> >  #include "cache.h"
>> > +#include "bulk-checkin.h"
>> >  #include "config.h"
>> >  #include "lockfile.h"
>> >  #include "quote.h"
>> > @@ -1110,6 +1111,9 @@ int cmd_update_index(int argc, const char **argv=
, const char *prefix)
>> >
>> >       the_index.updated_skipworktree =3D 1;
>> >
>> > +     /* we might be adding many objects to the object database */
>> > +     plug_bulk_checkin();
>> > +
>>
>> Shouldn't this be after parse_options_start()?
>
> Does it make a difference?  Especially if we do the object dir creation l=
azily?

I think it won't matter for the machine, but it helps with readability
to keep code like this as close to where it's used as possible.

Close enough and we'd also spot the other bug I mentioned here,
i.e. that we're setting this up where we're not writing objects at all
:)
