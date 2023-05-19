Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D66C77B7A
	for <git@archiver.kernel.org>; Fri, 19 May 2023 18:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjESSfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 14:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjESSe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 14:34:58 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095691A6
        for <git@vger.kernel.org>; Fri, 19 May 2023 11:34:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae875bf125so5526365ad.1
        for <git@vger.kernel.org>; Fri, 19 May 2023 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684521297; x=1687113297;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmZ0hquL1ytQFDfxmuTtu5e5hfVDmAkfnHUtk/P+ams=;
        b=UiIXuAtIFamR4C/+Tle+AmYm2c9UVCRSYjJEKuukLxk9v/fnq3HWT3O05F9cEwlk9C
         JXNKaPJ5Qw02rQEM7ygyCcq9wr6Lc9lYOzB9LQP/UXAc86P1e0WP56VD84hpWIvrDZ1G
         U+4LSPp/1M6pnnhUJtKw03heVYGj7uiJYM6lh637iceDyHLA5ysHvCFj7RnmK61afRqp
         87BXFbY8pKgfLg3yspBusWRu/h4lxg8vA9oqR2iyHHPkocg01B1UjUYohdmnKxBzJ4AL
         AXH9N9nKYElPxk3HLX70PTjlz7eoCMhCHgmpxXlNCotF5mFqQo99ANkee5uAEpJhzu1R
         jxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684521297; x=1687113297;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wmZ0hquL1ytQFDfxmuTtu5e5hfVDmAkfnHUtk/P+ams=;
        b=XoHEvvypOdCMD7vgRw2AhenO2qUgN7DkAsbutU8n2zZY/i4j2PDf7xFFgjQvgLZ68D
         CH+1Y2dBPnFdyP3CgbOB1OFwyi5yPTfv9cVl5UaNgoRfygphv8zrDyNpVA+joNMjmGU9
         nDxobERQ0/ovCtXYFn66EKN7GU82DYwsjGE+km8ObJ0Tcooi+Kr6G1KKx8Z/iLCDYRKf
         g08eYnJuwinrk6gnBnplUIBDyhqtHVOO9n4Fp9l9okB51pqUcOxxO+BBr08boDM1vuoE
         jiVjy9i0LhXBU9jHk08xUkFExos3pBGCKYcGes0YhYwvZ8gJn6fGi99FqhHgqWocpyUH
         oN3w==
X-Gm-Message-State: AC+VfDylesNT9D85SPHD6YjXwF9REDslX9sx7pmAxihM/ZkSmqAuRzkO
        dJUo0gxM3ICZ3j49wolspE8=
X-Google-Smtp-Source: ACHHUZ7mN8+a/mc97wThr5OzFSRJFE4CH7yc488MS1pcb0iYjtAKzPV8X+SLuMW/DHt9TqfTWLcMDA==
X-Received: by 2002:a17:902:7fc9:b0:1ab:63e:67b0 with SMTP id t9-20020a1709027fc900b001ab063e67b0mr2910519plb.54.1684521297334;
        Fri, 19 May 2023 11:34:57 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id s19-20020a170902989300b001aaf2e8b1eesm1987680plp.248.2023.05.19.11.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 11:34:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 03/20] t3210-pack-refs: modernize test format
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
        <4fe5e5cf9e068d20bbec3580df3030cd74ca4122.1684440205.git.gitgitgadget@gmail.com>
        <xmqqlehkqmg6.fsf@gitster.g>
        <1FB4B833-C883-4AC8-999E-FF3F56D621FE@gmail.com>
Date:   Fri, 19 May 2023 11:34:56 -0700
In-Reply-To: <1FB4B833-C883-4AC8-999E-FF3F56D621FE@gmail.com> (John Cai's
        message of "Fri, 19 May 2023 13:52:06 -0400")
Message-ID: <xmqqa5y0qien.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

> On 19 May 2023, at 13:07, Junio C Hamano wrote:
>
>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> +test_expect_success A'see if up-to-date packed refs are preserved' '
>>
>> Huh?
>
> oops. not sure what happeend there.

That's OK.  I've locally tweaked this 'A' out and changed t1000s in
the description that wanted to talk about t0000 before queuing.

