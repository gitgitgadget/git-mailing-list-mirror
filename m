Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3B8C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 13:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E00E6113D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 13:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhKRN07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 08:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhKRN06 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 08:26:58 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6449AC061570
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 05:23:58 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so27019964edd.3
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 05:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UsFZvogcXg/P1RiJudK/bUHokIyGfURXtQyoPjs+/4s=;
        b=qgBe6GPW/xJmffIrIOXXh1jS+H0iIeKMEIYiUYohp3eYXHKDIarQD7ubhD+wZlCX5i
         y7JvSEAC+O70HqSCJSgO79td9x3m5r7D6l+YGcvpz+XHKpFhKwk54/IIC3DCDksk6EXv
         XoL/loVcPRP1xrwaDorA01oF7dtW3WI2pTVhhfQfqixIASMmTJyc9toGHLI7O0tCtsZC
         89TyhSxXAZ0F3+w4sGYtWV1xV0ekaIMwyQooDFnmFhFm2P98Hn5V5gcWAwvbZD/KiJfo
         F8g7/81nr9Eq9GozLNlQ0KG9qHOvnS92KmDuhW4sJcyoKYDLV+147efLVPn0ySEUYjxN
         tODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UsFZvogcXg/P1RiJudK/bUHokIyGfURXtQyoPjs+/4s=;
        b=SNnFvvIuTGUwO/JAFme0auxZXheKVJ+k8iLnqIFNzreVHrjv/Q7AM6McI34scdfcuM
         uY7oJgPUy00o3zwTPX+WTRGfvXaD0zM43ArHXDaLyuSGft84oaBLDNbsDy4LSoXR8OGI
         Nzp6AuTqcCnIK+M+rBJLNLBDCR+sCiwCpu1g15CZJ1rD6vLm/F9p5M/x0jID+mAAY9eV
         nU1MG/AHEBim5p+SBrJwo/jEF3g5rEo8ER+T6WUIACYyfcfrU0k/Utucm4Xp8ZqjqJti
         mHhh3aIC/3Rlj6nc0IGm6BlLPc7ZtZCudvMUa6ztCRUdl4Uxq9H82jKmr8F/69CkfxlK
         y1lQ==
X-Gm-Message-State: AOAM533MVn5I73e/dzUf5ELKVRe7BWT2wm72rjKkHpPV5DU4zHx4VBXa
        NJVRVVMM0gB33Gght7hrZK+cK5jC98U=
X-Google-Smtp-Source: ABdhPJzwlTNdq2xppFvrNvw9lfQ2CXbzOS8VSeFYOFx3jqe+s/DK/mWrqGv4Xbn62WGov8uvtjVehA==
X-Received: by 2002:a17:907:7d89:: with SMTP id oz9mr33153849ejc.450.1637241836843;
        Thu, 18 Nov 2021 05:23:56 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id he14sm1320644ejc.55.2021.11.18.05.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 05:23:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnhON-000TRF-HV;
        Thu, 18 Nov 2021 14:23:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] fetch-pack: parameterize message containing 'ready'
 keyword
Date:   Thu, 18 Nov 2021 14:21:33 +0100
References: <20211118103424.6464-1-bagasdotme@gmail.com>
 <CAPig+cTKNYCoiRiDyi-KxxvheiYJ4rAxFY7vHx-r+qNyXYHNjA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CAPig+cTKNYCoiRiDyi-KxxvheiYJ4rAxFY7vHx-r+qNyXYHNjA@mail.gmail.com>
Message-ID: <211118.864k8961hw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 18 2021, Eric Sunshine wrote:

> On Thu, Nov 18, 2021 at 5:35 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> The protocol keyword 'ready' isn't meant for translation. Pass it as
>> parameter instead of spell it in die() message (and potentially confuse
>> translators).
>>
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> @@ -1410,9 +1410,13 @@ static int process_ack(struct fetch_negotiator *negotiator,
>>         if (*received_ready && reader->status != PACKET_READ_DELIM)
>> -               die(_("expected packfile to be sent after 'ready'"));
>> +               /* TRANSLATORS: The parameter will be 'ready', a protocol
>> +                * keyword */
>> +               die(_("expected packfile to be sent after '%s"), "ready");
>
> Missing closing single-quote after %s.
>
>>         if (!*received_ready && reader->status != PACKET_READ_FLUSH)
>> -               die(_("expected no other sections to be sent after no 'ready'"));
>> +               /* TRANSLATORS: The parameter will be 'ready', a protocol
>> +                * keyword */
>> +               die(_("expected no other sections to be sent after no '%s"), "ready");
>
> Missing closing single-quote after %s.

Also s/be sent after no/be sent after/, i.e. there's a stray "no".
