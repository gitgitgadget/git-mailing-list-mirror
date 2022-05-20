Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE27C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 08:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347239AbiETIen (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 04:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347237AbiETIeM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 04:34:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1963A47540
        for <git@vger.kernel.org>; Fri, 20 May 2022 01:33:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id m20so14238923ejj.10
        for <git@vger.kernel.org>; Fri, 20 May 2022 01:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=HIr69ZGR/itLG89CwbXzXU+uC2PDTQgfWsyFGBVrzmA=;
        b=Gd/hrlNpejbm+XbZnzgCf8PV6W8Wbi4Wc8WJF+EHTGXcPR+1wP/vz9Kk+1kxK+6Yvg
         +tnvN+22iUaulY3u6cGHjCubmCYOf8GqDl2bJRM6iuidaS/ai+MX2n5KOrpHDYY8t68K
         jmNlgSyMBhAsRYdYH7tf3z6eKKfuM5xOtb0V/L2O3etJHwHEgEtJEfTVhgdM2bO3OVx1
         XJz4XfjTyF2pNXqd3RSZ4a4GeFbIzAWumITQ9/clwqLOd4qOMnusa2hWecig8i75Hyam
         523So2CsfAzkI2wWdv8kdLjBYMReccuTF4ehclqBNFSAtQtQsiuvduwxkNzZxijnL7Fh
         phFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=HIr69ZGR/itLG89CwbXzXU+uC2PDTQgfWsyFGBVrzmA=;
        b=a8c1IjS4UOSSi2FTDadZylJO/TaAnVZaC5QBqhvuwKjGJyKhbLNCPY9se2JKINsUJ/
         9F72QCBUz6XwAkE/W7+1DByXb4i6G/aAsQ+Mg3+Apzg/Ur7/35J5kCqVNHIi17xZit1J
         ZDDC6PnVtDYKmsI6c+1xgiXgZjf1/c2dXmPh1x3vDWc9vr/U1vtsJF50A+J6MeNlTomS
         W+X4pk2Ni7Oux35OFwuGSUF2zMMMmfVtORsPodnfo4N0k2nQdcs7PzOq3KwmIViNrn9p
         2eQo/LHvDkqUpbzWwfIuyIDcAqdM6jte+WsElv3VqJVXrGpHYuAGLAkAl4kNnP3+/3eC
         hT9Q==
X-Gm-Message-State: AOAM531o4amTqQ4X9E1OPXe0cHpzSh5wClpf0Ssevc/RzuMkC0yDOu77
        Tm2XIgTG9KwGfpoRloEUjFs=
X-Google-Smtp-Source: ABdhPJzWGHNNdLnVimnCzF49dt+Ekhmh8W/61CFnL2Po2SBUArM+2aCzV/uiDPxqZKTW4R1qjN1njQ==
X-Received: by 2002:a17:907:1ca2:b0:6f7:f64:2788 with SMTP id nb34-20020a1709071ca200b006f70f642788mr7668524ejc.97.1653035611236;
        Fri, 20 May 2022 01:33:31 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090614d100b006f3ef214dd4sm2940168ejc.58.2022.05.20.01.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 01:33:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nry4f-002QnB-5Z;
        Fri, 20 May 2022 10:33:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: ab/env-array
Date:   Fri, 20 May 2022 10:33:16 +0200
References: <xmqq5ym4zpmn.fsf@gitster.g>
 <220519.86sfp52u91.gmgdl@evledraar.gmail.com> <xmqqzgjdkxon.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqzgjdkxon.fsf@gitster.g>
Message-ID: <220520.867d6g38o6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 19 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Mon, May 16 2022, Junio C Hamano wrote:
>>
>>> * ab/env-array (2022-04-06) 3 commits
>>>  - run-command API users: use "env" not "env_array" in comments & names
>>>  - run-command API: rename "env_array" to "env"
>>>  - cocci: add a rename of "struct child_process"'s "env_array" to "env"
>>>
>>>  Rename .env_array member to .env in the child_process structure.
>>>
>>>  On hold.
>>>  source: <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>
>>
>> I'm not sure if the "on hold" status is wanted here, or a holdover from
>> around the release time (per
>> https://lore.kernel.org/git/?q=3Dab%2Fenv-array); but in this case I thi=
nk
>> it would be very nice if we could advance this sooner than later.
>>
>> I'm aware of a couple of topics that would semantically conflict with it
>> if re-submitted (IIRC the rest of submodule-in-C is one). So if we're
>> going to do the s/env_array/env/g at all it seems better to do it sooner
>> than later.
>
> I do not think the run_command.cocci should remain in the tree at
> the end of this topic, as anybody who uses .env_array will be broken
> at compile time, so the only effect it adds is to make it take more
> time run "make coccicheck" for no good reason.  Anything it would
> catch we can find with "make" a lot faster.  It may serve as a
> dormant mine to surprise future developer who may want to add
> .env_array member for other reasons, too ;-)
>
> Instead of renaming .pending.cocci to .cocci I think the file should
> be removed, no?
>
> Other than that, I think this can go in any time, before or after
> the topics that add more mention of the .env_array member that are
> in-flight.  The rename done in this topic felt somewhat irritating
> while merging them, but the conflicts have been manageable.

Makes sense, I re-rolled a v2 with the removal of the *.cocci rule
added.
