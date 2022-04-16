Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DDFC433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 02:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiDPC3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiDPC3H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 22:29:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCBC167E1
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:26:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y32so16384108lfa.6
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=P3FpYYU1x5xqcnqCBdZZ3N1qFKWC0pcHcaUGcvBL/Ik=;
        b=EbNWuMG/vy6dr58TZijp26iz6bWQ6LjkLCelP7+HKLwRrrGDyNzbsT8RmI/W4m2uJ+
         Qt9tlJRwSR4JX3WF2GjlMi9lNA8o66OgyKPGC9Tc6YH/TTCWy/uELOKrKZt7vFtMAJW4
         kdr/5FbTQ7+XNY+eeBpdr3xiF/OOIl59Qxl3pzg9WscsF5YKiD7dHFqNhPArbSWOdB8n
         wNFJOCZoMn5FmYbCxq26kumtm5y63zd+0Vkx7MumIOJ5l3g6VbfSQYZr5Qqkosy/r1QL
         GX+9D4Y7jf7fwNZhE9zoL80TSXVWwW4zF0uX8zcdE/fKbRX8Cl2n1pjSL/+bUGO5rmeM
         melQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=P3FpYYU1x5xqcnqCBdZZ3N1qFKWC0pcHcaUGcvBL/Ik=;
        b=6Z8PcsjT7raN/hxgZfEkeNkm4P6kZUYUYcGsbWEG8Eet6PqjaALS9X/FmszVWQZzoW
         B+Gq2LymacOMfussLPeD+jsMSkEnfilWB5Oo2FjOFei8d3ZZiwTjXpASlGF4Ll+yhiwk
         rlrhL44LRhYhRMFcrMuXCmiilP1adsF+ykfBdigxvTl9I031DQscUMfgBz0j8DjaGf48
         jG5S7WoJ8syh9OFSTMnc6IWztMjRo+qDYNMplqmR5B25GkfQcY+PcvlfU8TlL9P0KRlw
         ujgJYYBstk8U4C+xx96Ob4UPVhm0/5JjuDxJD0xG/3zFUYbkYF9ObMyZB+e8uGxM+F0s
         n+8g==
X-Gm-Message-State: AOAM533f5I78qpKKncbXVSMFzFeV8+WUBU3i98KnxF8YtJPsEwU0Ybbe
        158XBW7H/blq2SnqwvgyqrTiWox4oWQQ4w==
X-Google-Smtp-Source: ABdhPJxu3TASIy7C1j92XLBnDf1/AsfFu5dPt2+O4p1YX/jIecO3eJ7aVzEqwoy6mdt7O42Gbu3DPQ==
X-Received: by 2002:a17:906:360d:b0:6e8:7f57:2d4d with SMTP id q13-20020a170906360d00b006e87f572d4dmr1209016ejb.736.1650071817840;
        Fri, 15 Apr 2022 18:16:57 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y13-20020a50eb8d000000b0041f112a63c4sm3389037edr.52.2022.04.15.18.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 18:16:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfX3Y-005xZK-OT;
        Sat, 16 Apr 2022 03:16:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        phillip.wood@talktalk.net
Subject: Re: [PATCH 2/2] config.mak.dev: alternative workaround to gcc 12
 warning in http.c
Date:   Sat, 16 Apr 2022 03:08:18 +0200
References: <20220415123922.30926-1-carenas@gmail.com>
 <20220415231342.35980-1-carenas@gmail.com>
 <20220415231342.35980-3-carenas@gmail.com> <xmqqh76taplg.fsf@gitster.g>
 <CAPUEspj4zu-59qxoVPMDGwMvWmu977WRDe7=t0if7raz=H24AQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPUEspj4zu-59qxoVPMDGwMvWmu977WRDe7=t0if7raz=H24AQ@mail.gmail.com>
Message-ID: <220416.86pmlhaktz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 15 2022, Carlo Arenas wrote:

> On Fri, Apr 15, 2022 at 4:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git c/http.c w/http.c
>> index 229da4d148..85437b1980 100644
>> --- c/http.c
>> +++ w/http.c
>> @@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot *s=
lot)
>>                         select(max_fd+1, &readfds, &writefds, &excfds, &=
select_timeout);
>>                 }
>>         }
>> +
>> +       if (slot->finished =3D=3D &finished)
>> +               slot->finished =3D NULL;
>>  }
>>
>>  static void release_active_slot(struct active_request_slot *slot)
>
> this would be IMHO a better fix than the one currently queued in
> ab/http-gcc-12-workaround and indeed squashes the warning with the gcc
> 12 version that is likely to be released with Fedora 36, but notice
> that it was proposed before[1] and apparently didn't work with the
> version of the compiler that =C3=86var was using at that time, as
> documented in the commit message.

Does it suppress the warning on your GCCv12? It doesn't on mine, as
noted later in related threads my "yes, that does quiet it" in [1] is a
misreport. That doesn't suppress the warning (the [2] patch notes it.

1. https://lore.kernel.org/git/220127.86mtjhdeme.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/patch-v3-1.1-69190804c67-20220325T143322Z-av=
arab@gmail.com/
