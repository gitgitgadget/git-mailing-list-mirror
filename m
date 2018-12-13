Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A537C20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 04:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbeLMEXG (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 23:23:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55469 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbeLMEXG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 23:23:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so893877wmc.5
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 20:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bAnP4Giib2JCZxx7J5OU80oH1lMFE9M7GTVGVvh/58s=;
        b=hlywfvnGr3majDf+8qx/yI+Y+qw5YoXrVhY7YbblT0g4iM2K8pP7+unb2iUYrSkVHW
         e3wBTkdsUHP8T1lX4tmXoSpGOSAsycCIJIXLaWeRbtO+5ZRiEV7iwz+lEhTgZW/b8hXk
         Fwgjq/XWMGuqeynfPnPyTsd5TiwGbhzSX6Tc1FVPgTNKSYAxNG/fIzFxb/LjkJTyUeFH
         vkzlftOs1SuZ6MdLStRhXKkIBjYXrkE8FVmYCXCZHQWw3XVKP+Zvyv0KvW3BDydLH+G6
         071c4XKK4uBDWy1yj4GkymJK1Y53KXxJnlZ1ZW0v2z9vMg6R73Vo5AHzEbaOfxelDDe9
         75jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bAnP4Giib2JCZxx7J5OU80oH1lMFE9M7GTVGVvh/58s=;
        b=WU5qVslP8R71/ne0NbecYIACz9XU/VHFrj57nx4GeDT0io4yPGxUHShryVjeT7VLRn
         SzW56QfC7SOImlB7Oi1MBd2OFtC0QjlzWpIzsbMZDS/zDBpO2zC7RSn69dYUHxl+tilW
         YrrIcw/voDiAE6dnjAq0GxNlCrEzkpKMpZ6wOOZwDRjTaCMLedbItWIKs2nvz/4C+StD
         jZFhIogqqJpZWN6YfiahqNfudugb/VUcawWd4SH97c9pn7alY5nbarxOOoogyHo5cH3k
         qSe1ALY8Ig+ntbLmeQK/kL+GKt7Xv76XyQCrp8C4Wi2bIHsbqC95/p/Z7Rjs+X9Tb+rw
         ad9Q==
X-Gm-Message-State: AA+aEWYW8Ui/mCsTy93SR0HdQuJeccqrINmGkL+Yn1CAyvnmN0YWWlFO
        SEQBAEfErBYMBz6cQvZGpFc=
X-Google-Smtp-Source: AFSGD/VXJq+tqul8P+Gz788TQr4WqHDajcl0Onsi+9wN9zCBe4JT2LIJvx+mkFbwarG0Ko2TzqzWgA==
X-Received: by 2002:a1c:8089:: with SMTP id b131mr8721664wmd.141.1544674983828;
        Wed, 12 Dec 2018 20:23:03 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l37sm560762wre.69.2018.12.12.20.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 20:23:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/5] midx: implement midx_repack()
References: <pull.92.git.gitgitgadget@gmail.com>
        <41ef671ec8361a9635dc78c078d2d84e9d985236.1544465177.git.gitgitgadget@gmail.com>
        <xmqqbm5rjipo.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 13 Dec 2018 13:23:02 +0900
In-Reply-To: <xmqqbm5rjipo.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 12 Dec 2018 16:40:51 +0900")
Message-ID: <xmqqk1kef42h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +		SECOND_SMALLEST_SIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 2 | tail -n 1) &&
>
> awk is capable of remembering $5 from each line of input, sorting
> them and picking the second smallest element from it, isn't it?
>
>> +		BATCH_SIZE=$(($SECOND_SMALLEST_SIZE + 1)) &&
>
> ... or incrementing the number by one, before reporting, for that
> matter.


Oops, please disregard.  My awk is rusty.  Unless we are willing to
rely on gawk, which we are not, it is not practical to sort inside
awk.

