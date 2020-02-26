Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D31C4BA0E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BED20801
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t03NGNrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgBZKfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:35:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39958 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgBZKfC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:35:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so2431475wmi.5
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QKnaQcOMrkTHVAr1Q4/bR1IIzNt1/XDEjZR80dTFyWQ=;
        b=t03NGNrWXymx10PJ461ikAxpxS1pcw71Y2GPqx9gLzXoNNOEIu8WVhUKxQ2Zf48ZQI
         X6pL+k/rsQgoeu3gooE9KyMjmGmEi0XmS/7o5TTU6N95nNqmGhqrWBa9TQJhne3DS9jX
         aWy83sIcL5a37lK+D44Zh2TuBYmWHi6ZnsDoNpwqJaYfC5p6Er2eeh1qQqyQEibDCUeU
         C03yUIQtwbonQjAP/tc4VfTg5NPjAEv3wS/83XvlBTPr+CzajxF8X8BPFYnwBvfzaYNe
         0xshOOauS/WK0np3CE6Pauos/jIFmHiS158ZEDHBUKwsBfA1I06GeNEB8nS3hVomiBXs
         NvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QKnaQcOMrkTHVAr1Q4/bR1IIzNt1/XDEjZR80dTFyWQ=;
        b=W/k+tH9StO2NpCnsR4d8vYYuCb1TFIwsPv/p7eT3OhocpLrQaobX2vR9ATnnNYsgLn
         xRUtJNRn8Dl/Ny5EeWk49CE0AKo5SJjrbfdbFoMsDnPOPtcqD/ukvkBq8co5+0Hu/RB5
         locK4BPvL2shzV7wbZuRwB8dmdGLFm3xKLEa+gwPD1wXZjV0dQEK+nrVNOMPcJ5kfbwI
         9X6Ism8SVcmFwDThhpbizLRDkBglFFgeo/GsijuK4VUlzR0ObF8Q8KNjnFde8jbnV4+0
         U05/LesybUkic/U5q5uZcvBWbgmxiAO1HP3ngqau+wxSF4Rsz2TkkhCO+mFWxG6BZ2GV
         Cnkg==
X-Gm-Message-State: APjAAAVvt+5Nyb+R60sj+807swct6Efhwo1cHAyubpY9lfkDepLwBOos
        mF5jwygS0jYukTiYNv/Ak1/OqOKM
X-Google-Smtp-Source: APXvYqyn7u1TKItmsbPgTfpTprnmQ/RmRaN8dAbQjP4wp9LFS5PtFyyuZj7V1Gz4DKS8GnQbLefA4Q==
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr1359126wmj.1.1582713300307;
        Wed, 26 Feb 2020 02:35:00 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-654-1-296-184.w86-199.abo.wanadoo.fr. [86.199.79.184])
        by smtp.gmail.com with ESMTPSA id j16sm2678483wru.68.2020.02.26.02.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 02:34:59 -0800 (PST)
Subject: Re: en/rebase-backend, was Re: What's cooking in git.git (Feb 2020,
 #04; Mon, 17)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com>
 <CABPp-BEFQs4LL0uwkZSpXb_wxo7Wk-gEQSsv-=4B5ja5H1xXTg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2002181659540.46@tvgsbejvaqbjf.bet>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <3b63cd85-93b4-b6c1-6b42-c079691267dd@gmail.com>
Date:   Wed, 26 Feb 2020 11:34:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2002181659540.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 18/02/2020 à 17:00, Johannes Schindelin a écrit :
> Hi Elijah,
> 
> On Mon, 17 Feb 2020, Elijah Newren wrote:
> 
>> On Mon, Feb 17, 2020 at 2:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> * en/rebase-backend (2020-02-16) 20 commits
>>>  - rebase: rename the two primary rebase backends
>>>  - rebase: change the default backend from "am" to "merge"
>>>  - rebase: make the backend configurable via config setting
>>>  - rebase tests: repeat some tests using the merge backend instead of am
>>>  - rebase tests: mark tests specific to the am-backend with --am
>>>  - rebase: drop '-i' from the reflog for interactive-based rebases
>>>  - git-prompt: change the prompt for interactive-based rebases
>>>  - rebase: add an --am option
>>>  - rebase: move incompatibility checks between backend options a bit earlier
>>>  - git-rebase.txt: add more details about behavioral differences of backends
>>>  - rebase: allow more types of rebases to fast-forward
>>>  - t3432: make these tests work with either am or merge backends
>>>  - rebase: fix handling of restrict_revision
>>>  - rebase: make sure to pass along the quiet flag to the sequencer
>>>  - rebase, sequencer: remove the broken GIT_QUIET handling
>>>  - t3406: simplify an already simple test
>>>  - rebase (interactive-backend): fix handling of commits that become empty
>>>  - rebase (interactive-backend): make --keep-empty the default
>>>  - t3404: directly test the behavior of interest
>>>  - git-rebase.txt: update description of --allow-empty-message
>>>
>>>  "git rebase" has learned to use the sequencer backend by default,
>>>  while allowing "--am" option to go back to the traditional "am"
>>>  backend.
>>>
>>>  The last step may be rushing things a bit and may want to be
>>>  taken separately.
>>>  cf. <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
>>
>> Thanks.  I'm curious, though, what you mean by this last bit -- was it
>> just a reflection of my request for folks to comment on whether the
>> last patch was wanted?
>>
>> In my view, taking the last patch separately does not make sense; it
>> should either be dropped entirely or taken close to the same time as
>> the series.  My reasoning for this is as follows: The only place the
>> current backend names exist is in the documentation.  The cost of
>> changing the names is thus low.  Once this series lands, the backend
>> names will be exposed in the user interface.  If we cut a release with
>> those names, then changing the names will require a bunch of
>> transition work.  So, if we're going to change the backend names, it'd
>> be better to do it sooner (while the cost is negligible) rather than
>> later.
>>
>> So far, Phillip has voiced an opinion on this (cf.
>> <e2863381-174c-a55c-bb22-0c7aec9cabf4@gmail.com>) -- "I think it is a
>> good idea - merge and apply make much more sense that interactive and
>> am"; haven't heard from anyone else yet.
> 
> FWIW I am also in favor of renaming the backends. Unfortunately, I won't
> have time to review this patch series for the foreseeable time.
> 

I do agree too, for the same reasons as Elijah expressed.

Alban

> Ciao,
> Dscho
> 

