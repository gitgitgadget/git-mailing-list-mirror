Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45331C3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 02:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjAOCID (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 21:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjAOCIB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 21:08:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0475B9EE6
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 18:08:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g23so11477199plq.12
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 18:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajjLuAaKIJn1lt+9YP/jZKVhOFenckbZwQYqF0u5Zog=;
        b=NXWnONu7A3SnibrgV/I3H8/ykSabBRKojQvRsJZlTOYrX+JUFh+ce8pRsY451VcxdV
         +qzhSOzTMaGk6inFr7lRRSowqfdVuCWePibgl/WBK7pBM62jQRU/i4VYz3PebdnoLZb+
         8bgXkKLht8z3+JqHWl0usN/V8mMeQDmASGnUGpxvEugf06O1jhUg41RwTGJTmPLk3zHE
         Lw87AKMnecqsCv8yCrhyCklyVIosOz89uPs513yClxys2dHg8UUbWam9NYlJS508Sv1o
         5t77AY3eb3FauNVsfwRQCGt6verGR+7g34yugfcaqmwDatZUZc8IoTJMsIyElSEE55Yd
         s9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ajjLuAaKIJn1lt+9YP/jZKVhOFenckbZwQYqF0u5Zog=;
        b=dKH8ASDC+I/QJFOVH2roYl8rcIWE9LHZoIxiaIeKxKB7RPQwVJRp4Yp9PsH09qcvUT
         Ch80GT2n2iMILXHIsFHdiUMub+KFTrkVbszY1nLNxCwtrGavOcGN5Fo7Kjr1HVvOPf8F
         IRFQ68v3bfuVITYIVC2c8rInG0d6vSvgCzOJ6fioCiqJD7nx73QLLcYNcq9/QfTehJdT
         9fcLeOrRqMmTibVpjCG97CtHm1FYHPgiF3/nH/6lkVs0HQeYKuNyIF4TiOujo6vAy0Tk
         yeDkmtzE4IIaoDhU8zj0vCX2FnFVSYuwtdU4Qr+gdC645csDetY6cVAp2s5bgWzmmUaG
         9HEw==
X-Gm-Message-State: AFqh2kqFjjbO6WLSE/vckO2ejbceiUj8/Bjp6peMyT7RI5Gi/BYhX9LW
        R6q5yUs+5j3Ry4ms9++DqhRMeDBlqSQ=
X-Google-Smtp-Source: AMrXdXs9/7H+L9zVwGRyU1Nb1/xwVOKh6qPNHSW++SSpx9bTuUabjAfKe2C7r72SW3w+sTQBI+5EKg==
X-Received: by 2002:a05:6a20:158b:b0:af:7b32:4deb with SMTP id h11-20020a056a20158b00b000af7b324debmr119986352pzj.4.1673748480418;
        Sat, 14 Jan 2023 18:08:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p128-20020a622986000000b00581172f7456sm15727541pfp.56.2023.01.14.18.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 18:08:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: ja/worktree-orphan (was What's cooking in git.git (Jan 2023,
 #04; Sat, 14))
References: <xmqqilh9ms1p.fsf@gitster.g>
        <11be1b0e-ee38-119f-1d80-cb818946116b@dunelm.org.uk>
Date:   Sat, 14 Jan 2023 18:07:59 -0800
In-Reply-To: <11be1b0e-ee38-119f-1d80-cb818946116b@dunelm.org.uk> (Phillip
        Wood's message of "Sat, 14 Jan 2023 19:28:02 +0000")
Message-ID: <xmqqy1q4k0sg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 14/01/2023 08:36, Junio C Hamano wrote:
>> * ja/worktree-orphan (2023-01-13) 4 commits
>>   - worktree add: add hint to direct users towards --orphan
>>   - worktree add: add --orphan flag
>>   - worktree add: refactor opt exclusion tests
>>   - worktree add: include -B in usage docs
>>   'git worktree add' learned how to create a worktree based on an
>>   orphaned branch with `--orphan`.
>>   Will merge to 'next'.
>>   source: <20230109173227.29264-1-jacobabel@nullpo.dev>
>
> If possible it would be nice to clean up the ui before merging this, I
> think it would be quite a small change to the implementation. cf
> <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk>

Thanks.  Let's wait for and queue an updated one.
