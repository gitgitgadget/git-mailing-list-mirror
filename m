Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F2FC678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 21:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCGVJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 16:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjCGVJv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 16:09:51 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C94BA17E5
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 13:09:49 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so13123461pjp.2
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 13:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678223388;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZSrz6444lqgYyqb1/Nlzh40akMnsTYUsM9rWMHtx+E=;
        b=Y1FaHV9LrrvpK/6zqXO3QpC8QxW2MUy13xehAc2HVeN4fCxVN3VvtBgqx2m/XNumvc
         gbW4K+3wtnr9FsYQe5IrwKBhItKUyvlTOtS/QzPMf+x8vhMg+qICx09E0q//rR9IGaWc
         ZAI0OecG6vhxJlK6Ln/y1j6XVvc0hcuXCO2Qxj0FwnPNnWYlqo2SnHs9xn/+NfsEXfE/
         HCq+3edofkNaoWX0c4XGzuSfwdAAjpy8pxaXfhwUIT0D80j0MIFdN4dRHFp+ntgHoK2b
         ZDPmsfrwQWEEr+Bhfw4IPAwEnnu/6GZnIXhjH+6hR+pjwRh/tY8V86EpXmeSgIHF/7Sz
         xDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678223388;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NZSrz6444lqgYyqb1/Nlzh40akMnsTYUsM9rWMHtx+E=;
        b=K7A/dno5zy4CZfWykfm3CaWZxAfY8lMJKESrxyFRRniBTpJhxdAxXnvOWEuUt+pwfc
         MHiD78EVuTRMG3ylFYrqCkmPR6wpUoQ8TlUOEtL1oJDK6jHrdDRAOafaUrNIgSWgqlAJ
         0rbdt1MoOeXslefzSfIc2YZ/aHPrFzSYgp5M6UwzAL9CUVEO+EsMRWjVe2nkX9B7Nt7v
         erogYn74pwzVJR/ylRk4IwTlzpBS7Wo3LQWV6g8xpDuIyzwO7KK9ZSVfSr0/guPG9/JA
         3D9ztKCf1adNVaxGjR6JAJnTDWuL2o+uywUvKVmRpXKFB0K6JQ7/IVhvVt9rP44wdO5u
         Ss8A==
X-Gm-Message-State: AO0yUKW6xfFYxXs24q1r9joNUFSihibabzjoxrX4zQIRQSYSqZD7b9lh
        MoHmJlfM23uT5jLffVwLm2s=
X-Google-Smtp-Source: AK7set9xmNMhxl8BMXsd6ei1MD9HLgSLl9eomkE+0ouscjzpgHt/pN7aiqT62mnmpYkEzdSS9SPGGg==
X-Received: by 2002:a17:902:a9c6:b0:19e:7c33:3722 with SMTP id b6-20020a170902a9c600b0019e7c333722mr13518953plr.40.1678223388542;
        Tue, 07 Mar 2023 13:09:48 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id la16-20020a170902fa1000b0019cb8ffd209sm8800868plb.229.2023.03.07.13.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 13:09:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Fangyi Zhou <me@fangyi.io>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: fz/rebase-msg-update (2023-02-27)
References: <xmqqcz5snyxz.fsf@gitster.g>
        <007e6f051381d86da6881644ce300b6eea944194.camel@fangyi.io>
        <xmqqttyww9tl.fsf@gitster.g>
Date:   Tue, 07 Mar 2023 13:09:47 -0800
In-Reply-To: <xmqqttyww9tl.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        07 Mar 2023 13:06:14 -0800")
Message-ID: <xmqqpm9kw9no.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Fangyi Zhou <me@fangyi.io> writes:
>
>> This patch is actually a hotfix for a topic added in v2.40.0 RC
>> 2c6e5b32aa (Merge branch 'en/rebase-incompatible-opts', 2023-02-03),
>> could it be reviewed and included in the release?
>
> Is it?  
>
> If a message used to say autoSquash 2.39 series and 2.40-rc2
> has it autosquash, then it may be a hotfix, but otherwise no.

Besides, localizaiton teams are already working on what has been
in 'master'; it disrupts their workflow to change end-user message
under them.

