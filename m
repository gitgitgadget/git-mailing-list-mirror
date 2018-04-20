Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00B491F404
	for <e@80x24.org>; Fri, 20 Apr 2018 03:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754203AbeDTDFU (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 23:05:20 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38972 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754100AbeDTDFT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 23:05:19 -0400
Received: by mail-wr0-f194.google.com with SMTP id q3-v6so8955626wrj.6
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 20:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lwWdHJd+wVB6+DnMuZAxB2JUbKj4gkVO4gU0XesXcNY=;
        b=JF1DdJefsFEcoipGukcqKm2ZbKZ7Bum3FMPOVkrpHH77Ar52C/DU3alcsM5tPjptwd
         qTtx0q13G680b+LcD5mVCNkvehklKQI/BsNm869WNxrwxZHie7ePo/2BPQKYVs8FCCsy
         gcU9Pxdu4DxsM72uPol/cjbTRwKKTu2kniPHw8MLx3V2IerKCVy4pQ54XGEbmP10iZzM
         xKWOcj2U2TNcpxHW7jiyi/HuYdgqmQFgdsbqCSBvbFFx1lbOjSMjo+CJwXwhgqv57fog
         wLikWpa3f74oxWX3TJ6Iim9H7ZS+deGfxrq2aw7zjGgMCcafICi4NgkH6zGw7Fz0gxm4
         3qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lwWdHJd+wVB6+DnMuZAxB2JUbKj4gkVO4gU0XesXcNY=;
        b=D2/5y2DseYwpeUp/fxruwTQ3xp5wAolmMf/5T2AtNHeMpSZYcD/bGt7AJVcMRnK48O
         hFYDNm/oq2L/bHw4lk7lZFz/+OTBrPXH+h+F59ilwvIQbV95XFLqyABwbJ0WjSURNe/R
         xrylhIOa+Pi2bUXcNmy4AMb10LgsLf4Rh0pr5LVsA/1tsN7Bjr6mwWMFBAxot6rPibel
         GC9MO3Rn6eanvH+SMP3K+bUeCRDKzi1aDfthwQgRyrDG/ccn0CqsczpF5qTrdRBYvn70
         FlfcJEnsuEHHrU3qonoPeyNbtZqUZEIda7alHSU69Fn0UtuOwooXEMIwptoRyEC6DNZF
         yobw==
X-Gm-Message-State: ALQs6tAhIzPDB8C27ZelV/IL4tCAekgKCGismeZoPevaZZYOoyCdvqMy
        Ykyc5z6gHi1UkkHk0Y6tSZQ=
X-Google-Smtp-Source: AIpwx48tmdLMPOBV+WtXbQYWvcIJd5hSClOXzUflMPrVCfo4++QEN7wRS8Cue3aoXp6wFyU6rEsSHA==
X-Received: by 10.28.58.81 with SMTP id h78mr598276wma.110.1524193518382;
        Thu, 19 Apr 2018 20:05:18 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j3sm2224401wmf.23.2018.04.19.20.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 20:05:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH v10 00/36] Add directory rename detection to git
References: <20180419175823.7946-1-newren@gmail.com>
        <CABPp-BEhfMPNEtAvdc3MsX5mWsq=YT_=rVeOzCfidJde7Mhh-Q@mail.gmail.com>
Date:   Fri, 20 Apr 2018 12:05:16 +0900
In-Reply-To: <CABPp-BEhfMPNEtAvdc3MsX5mWsq=YT_=rVeOzCfidJde7Mhh-Q@mail.gmail.com>
        (Elijah Newren's message of "Thu, 19 Apr 2018 11:35:19 -0700")
Message-ID: <xmqqy3hibms3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Apr 19, 2018 at 10:57 AM, Elijah Newren <newren@gmail.com> wrote:
>> This series is a reboot of the directory rename detection series that was
>> merged to master and then reverted due to the final patch having a buggy
>> can-skip-update check, as noted at
>>   https://public-inbox.org/git/xmqqmuya43cs.fsf@gitster-ct.c.googlers.com/
>> This series based on top of master.
>
> ...and merges cleanly to next but apparently has some minor conflicts
> with both ds/lazy-load-trees and ps/test-chmtime-get from pu.
>
> What's the preferred way to resolve this?  Rebase and resubmit my
> series on pu, or something else?

The series as-is is fine, I think, from the maintainer's point of
view.  Thanks.
