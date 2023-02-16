Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89470C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 17:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBPRLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 12:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjBPRLL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 12:11:11 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214223A0A2
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 09:11:07 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id pg6-20020a17090b1e0600b002349579949aso2362340pjb.5
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 09:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOCjTgAyMvYoOBJKqPkRrsvsEYHHHd3MyA+kKXWzMAs=;
        b=UzRMKtoLSEH/XljjM7eAgvWD8IkCkn5dhlszJ/sYLIZSdJVFjhQWFRFJcfnkkIPtwg
         giRmedRZzwHsCbd5q5qJYDTGcvvlIVpcUmOgozvS2TMrmkt9Dq24F5Y6Y96t6JDopRDk
         cuI/FpKo/o8+8fE8AiMfYYo+opffDnoQylFXWv0Mx+hW0xJxX0wFbSOk/Vc+JQIVp4QT
         U7eN7OR7kn63T8lBYnpE9OsP5LrlfGttmqEdLRLnpc9uJJxik5fyEy17g/O0YHm8Fe9z
         K+fDRRV98NU5zxVFiahdWSnFchmwWI2kPGrSqmA2ty75whf57GMnpIQJeN+BGVO2jy5A
         ScFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SOCjTgAyMvYoOBJKqPkRrsvsEYHHHd3MyA+kKXWzMAs=;
        b=3oaoBxxG4lxehecUVB2C/WXgwQ6MSrmOBeAoyd6hzIDZSxp4Q5LkiTOO7er5EAGRol
         8yYk3l707/EcJFQacKQUHgUBevLxbOdPRPULXFujhMDEolmEtwZWz1w7nvgY5qt5Hrnk
         Q4MKrvQoANi1FF6chPmcBfZCTcIZfWkrNbVP8tFxISjjq3AqpQimc9b0wM5K9wY1xhDs
         3pryeB4z2aMFBN2KPruShekkZG3q4spRTQbDtAqDKA3HD0EBmSFQA7wU/7Jt21jdPKfu
         zU2J6hPrRLH4sj1NDHwDLjO35pMO9plm2iue20IC4nWTAv3TVuf0tfjYQqhoPKiFW68m
         jDMA==
X-Gm-Message-State: AO0yUKUCrLWb7Xoo/IAynQsZNCXXZdXVGvbdyD1OK7dgYIAcKzZ81PKD
        PAq2gqOv6NZTI7SPIn0E2hE=
X-Google-Smtp-Source: AK7set+A/tRuvjgOVurLSaTH8YZKpWqnQ6i2t3ufh8knW//W1XV3YEY1FrD0op9qhbGSA5DDdGgoPw==
X-Received: by 2002:a17:903:1109:b0:196:2bf1:b690 with SMTP id n9-20020a170903110900b001962bf1b690mr7932146plh.13.1676567466444;
        Thu, 16 Feb 2023 09:11:06 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b00199563fff0fsm1545624plz.190.2023.02.16.09.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 09:11:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [GSoC][PATCH v3] apply: Change #define to enum and variable
 types from int to enum
References: <20230215091950.2976-1-vinayakdev.sci@gmail.com>
        <xmqqmt5ezun0.fsf@gitster.g>
        <CADE8Nao=ZrF7_0+G=jB8=j5Aji4ndCLfMp-xjbSpc1HKmmFM7w@mail.gmail.com>
Date:   Thu, 16 Feb 2023 09:11:05 -0800
In-Reply-To: <CADE8Nao=ZrF7_0+G=jB8=j5Aji4ndCLfMp-xjbSpc1HKmmFM7w@mail.gmail.com>
        (Vinayak Dev's message of "Thu, 16 Feb 2023 19:34:44 +0530")
Message-ID: <xmqqttzlr0wm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vinayak Dev <vinayakdev.sci@gmail.com> writes:

>> As a faithful rewrite, forcing the same values to be given as before
>> by saying that "_DEFLATED must be 1" is a good thing to do, but once
>> the dust settled from the patch, it would be a good idea to go back
>> to the code and see if the values MUST be these, or if it is fine to
>> use any value as long as they are distinct.  If it is the latter,
>> then it would make a good follow-up patch to remove "= 1", with an
>> explanation why it is a safe thing to do.
>
> Removing the 1 _may_ be a safe thing to do, because ...

I didn't mean to suggest you think about it _NOW_ in the context of
working on this patch.  Rather the opposite.  Let's have a faithful
rewrite first and then as a follow-on work after this patch becomes
part of "git", a further clean-up like that can be a good idea.

>> > +enum diff_name {
>> > +     DIFF_OLD_NAME = 0,
>> > +     DIFF_NEW_NAME
>> > +};
>>
>> Ditto.
>
> I think that since enums start with zero by default, you are right in
> saying that the '=0' here can be removed.

Not what I meant.  I was referring to the lack of trailing comma.

> I will do so.

Please don't.

Thanks.
