Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,RCVD_IN_RP_RNBL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B471F453
	for <e@80x24.org>; Tue, 19 Feb 2019 22:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfBSWdF (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 17:33:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55795 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfBSWdE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 17:33:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id q187so4503751wme.5
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 14:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Xyk2Zq04tZUrqateZaf7vLDJxS89aoTN0GFbgRVIVB0=;
        b=H7vIlYtc94pfXBblKONuOKTFQWgI3HffMY5uoubLxiExS5aYYhM2hPJB+t3tjRckrF
         BnBftrSmW8fE9VBdgmSrDGZaoMoqDrzVuBxhVbBIFIjOnXL+1DOGMhaZa4hVcrvRRbaP
         FaLGOXHSEFN/hkfkyCsYj7oCOKcUJvqS3EMMJz3sDqa7cqn/JjTIgWn+7ed3Gemuiy3B
         vfUY5JduAvcvZXS2jwDpgbPVOkvSj3J5ByQYZNLovqCn5azJOogKMzHuXbOBzVgouKeA
         2+HGaaetIBK/Z0au2hxMvh1ygUQhSuSDg89+8gVY0BOJRiQzY9pJWxVhYdjyesCKOe6U
         cBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Xyk2Zq04tZUrqateZaf7vLDJxS89aoTN0GFbgRVIVB0=;
        b=SLUFa0xmPHrJz67uvOMUo59BBT+QMViWHipKwWqJWvN9gReTC6Q+E23gqD0UlFIsIy
         pYlajjCVWFyzOCU0DskKPNys/g1NS2WuIbK+zlMI76An2JR7t0xYZa5HwqfHCLVqMMZ0
         oxYA3a5NGq8tU262Lcz3hdpLJ9diWXJo2hk4E+RDXUln69T3204oatO6K3IbXD0ODffb
         uPy6ZMzKe3fpXeNYn2LV2ITZ2fGox6srv8aBjVQWgxVAtcgIXw0whgV0Xui6UEd+WwtH
         kUIJNqM3w6M1ysYRj3i/T2nS6Iby/DFfZgD/zqd/6Run3oo9Iq44O53sKgxeTUJSmkVR
         0b8A==
X-Gm-Message-State: AHQUAubUsmek3m2TR0qrKCVZqRndH0SnMA1oP2JY/oErWuoPm3isGrNN
        4lceDfJRGnob5elC/wxKq/8=
X-Google-Smtp-Source: AHgI3IYZGP8+jnPoJn9tX09CXpcnDgB+An/YzxC8O8uGje9iuq58hBfvRdcQ2UFac1rBm540WJmagQ==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr4219836wmj.77.1550615582253;
        Tue, 19 Feb 2019 14:33:02 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j22sm138447wre.34.2019.02.19.14.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 14:33:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] checkout: add --cached option
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-7-t.gummerer@gmail.com>
        <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
        <xmqqva40lps2.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
        <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
        <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
        <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
        <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
        <xmqqwolv1tzw.fsf@gitster-ct.c.googlers.com>
        <CABPp-BEsK8grsGCMq9-QCWd4fgYzm7GfzQudbhFvGj_C55LNyA@mail.gmail.com>
Date:   Tue, 19 Feb 2019 14:33:00 -0800
In-Reply-To: <CABPp-BEsK8grsGCMq9-QCWd4fgYzm7GfzQudbhFvGj_C55LNyA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 19 Feb 2019 14:13:52 -0800")
Message-ID: <xmqqwolvz9wj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Feb 19, 2019 at 11:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>>  * --no-index --worktree <path>...
>>
>>    Update only the working tree files without touching the index
>>    (new feature that cannot be done with the current Git, although
>>    "cat-file -p >path" may be close enough at times), from the index
>
> I worry slightly that wording like this might paint ourselves into a
> similar corner of only correctly handling files as paths, rather than
> also handling directories as paths, and/or which presumes the
> no-overlay mode that I find problematic.  Maybe your "at times" just
> meant "when dealing with a path that is a file that existed in the
> given source", but I wonder if you are pushing more than that?

No, I meant "when you are not doing smudge filters (including eol
conversion)", aka "'cat-file -p' gives you raw blob contents, which
may not be what you want in your worktree."




