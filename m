Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1E7EB64D8
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 03:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241234AbjFODEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 23:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbjFODEs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 23:04:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F5E26AA
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 20:04:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd5b8a9d82cso1839225276.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 20:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686798287; x=1689390287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7eATv/BzRt3oH6d6o92YnEDubZiOfP+5Gz4wVaYsAA=;
        b=iLGVyuJkC67lazEWMROajvYh7iJ3Bj1595x8p7MXgoVQXFV8gZ4Za70kJfFu5HvlGm
         vaNXFVPxowP7iqLVfYWXGgiw7/kcv2qjP7rpzAu+OrAf0lwM8ViAPYZfURXudhc/m6Uh
         9jILJfG384l2f8wi67BylhtBrLquge5hpCUEJ/gB4r9alZJPeOOcmgr6cmyT9WsFL4w0
         wXztM/r7lDqWOccIQgSbfw9/3thgS6FU/1sPFiPv+2xl5GAR3SDuenoQ7N+MSD8c7qNq
         WW4okbwaVS870tlMtlgyiRyGBx0jUDuStrjfbucvf5xNu3eY1Sy+uXmc3TBK5gvsinv9
         qGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686798287; x=1689390287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7eATv/BzRt3oH6d6o92YnEDubZiOfP+5Gz4wVaYsAA=;
        b=hjKs5fyxNV5qYJcC0xz/wAWztOI1Ed2UOFn48UEuZZuff1MkwMVDcYvdCz5cpfMU8X
         QbZ8aKjHl1mx1b0EItYoncLE6dcZ57NCSxcxf0JP9iPV4FL/wcy0hmF4H6LZV6/2MHfx
         2UcW7tQp5/DAdbCnhmEFaOg/eGkgxKCHT90T/Vzf+oU7Z3+BHI772nJ/YYNCtbXZYpiB
         TjJlWaf4JqZzF7/SVOuu/9gDvFFLQlFCT4dB+sS2Iwb/DHGUmvXy5DWCMj8YfxMK2rLn
         dzJ08O8Kg4GZaN9k5R3ErhfhphxNbBp5xSftPF5Lje+a3IASti9XrgK+/RjKEvpB6TFS
         bkMg==
X-Gm-Message-State: AC+VfDzctix1YYjBH/p1x4wYoqpoOoboVqYlRUEoZVM6q2U0/SF/YQ09
        qdfudwYnOboDEvY7s5Ty/+5YDO3mtJA=
X-Google-Smtp-Source: ACHHUZ5ltnEvuSNYfCO4/ZDD6J+M+ODOMoBMm8vYDaG9rQVsltXvVDHPt75shGpY1OlzilayzXJ6M0YrSWY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a5b:8c5:0:b0:ba8:2415:f27c with SMTP id
 w5-20020a5b08c5000000b00ba82415f27cmr1764114ybq.3.1686798286804; Wed, 14 Jun
 2023 20:04:46 -0700 (PDT)
Date:   Wed, 14 Jun 2023 20:04:45 -0700
In-Reply-To: <CAP8UFD3ikE8k7TJnX7wOt9K3JAhkh4chB3Gjp1B2tofU81xXWg@mail.gmail.com>
Mime-Version: 1.0
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
 <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com> <b13bd73d24885d65440e22202183bbec9deec1c5.1686017304.git.gitgitgadget@gmail.com>
 <CAP8UFD3ikE8k7TJnX7wOt9K3JAhkh4chB3Gjp1B2tofU81xXWg@mail.gmail.com>
Message-ID: <owlyfs6to27m.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 8/9] doc: trailer: mention 'key' in DESCRIPTION
From:   Linus Arver <linusa@google.com>
To:     Christian Couder <christian.couder@gmail.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>>   This means that the trimmed <token> and <value> will be separated by
>> -`': '` (one colon followed by one space).
>> +`': '` (one colon followed by one space). If the <token> should have a  
>> different
>> +string representation than itself, then the 'key' can be configured with
>> +'trailer.<token>.key'.

> I would rather say something like:

> "A <token> can be a shortcut name, for example "sign", instead of the
> full string, for example "Signed-off-by", which should appear before
> the separator on the output. This can be configured using the
> 'trailer.<token>.key' configuration variable."

Updated in v4 with a slightly different wording versus your example.
