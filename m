Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09882C678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 21:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjCGVxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 16:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCGVxB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 16:53:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77581F937
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 13:52:57 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 130so8502385pgg.3
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 13:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678225977;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hy6EhBqmCTxcjXHMxxeOzvnER95fmH0KmWJdyV42QE0=;
        b=hwz6B7kZbdwpl8ho250k27ZR8U8+enaZZ5F2FwqhoWqOEFEkKbRhh6LQAMYVmmwXqC
         N8cQLHWT7+vaqC48Ww80rccxJ1LXNmQ4R5257W5B5zfsBJ2peMQ1s/sRr7uW+XI8C7b0
         2usi3d58bamNZJKykMgIhli5btJrlIUAPeHamx8NizF1vjY5Poa3BLVAtYouaKGCn8DN
         dESxB9vPBb245rgz8Mzr1exaETVTGhkGYPW+KKDFoHCF2yDb1mjxU5GqonFfeQBFAnY0
         NmXe2jA++vXLi6UVDILJ6NLPRm/TMUc4tG+9H7W4C4XgS5WJWbuUxT5uzzP7OMRiOnWP
         AfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678225977;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy6EhBqmCTxcjXHMxxeOzvnER95fmH0KmWJdyV42QE0=;
        b=f0Nc8fb1UPEZ7XqivcK+OeueGpBS9e8zgZsIeEYVWkT8cn8OkEBVd2NiDnJFKKC3zn
         8z7WqTHlmaWPU7/rfTVlR8xafQpgS7+sjNEdGjUpyqtTADqx4ib/ZwyD65xL4Y1YUd/I
         vRgm4GIgtVMpWtSsytyTOxAfnK0KjesyiLworL/Ml+6XAecPy+70oqmStC2brD8TqAsi
         kfC5H75JBBWr04zP3Uma85v09oWpEYNjWCkPewAmezfh7KILy6Qj4ENRQ98Hxe9+Dl7M
         3ihUc6D4qu1XcQJ9XIXDy7VQL6rfBWpRKQHW/c4iSUSE3/FmjPXpdE0MPTOfDN00PV3n
         usXw==
X-Gm-Message-State: AO0yUKWFgvd8tq5gLPlblwSKXHy8QRwIulirD6FDNuJiV0qODDWscM7K
        sFzZ4bmGuEdIWNmS/yxJxqaS01Idz/c=
X-Google-Smtp-Source: AK7set+xddw61cNYNt/F6tQpYE6dn4z8d7y6sa1XlEkGlmCBVH49mevmldkSbYIGHLR/xj1IisVtHg==
X-Received: by 2002:a62:19d6:0:b0:5a8:be36:65a8 with SMTP id 205-20020a6219d6000000b005a8be3665a8mr14599930pfz.27.1678225977167;
        Tue, 07 Mar 2023 13:52:57 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id e19-20020a62aa13000000b005b6f63c6cf4sm8344865pff.30.2023.03.07.13.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 13:52:56 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Fangyi Zhou <me@fangyi.io>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: fz/rebase-msg-update (2023-02-27)
References: <xmqqcz5snyxz.fsf@gitster.g>
        <007e6f051381d86da6881644ce300b6eea944194.camel@fangyi.io>
        <xmqqttyww9tl.fsf@gitster.g> <xmqqpm9kw9no.fsf@gitster.g>
        <37ed877d5927c7cebba7e47769be3a069eacd6c6.camel@fangyi.io>
Date:   Tue, 07 Mar 2023 13:52:56 -0800
In-Reply-To: <37ed877d5927c7cebba7e47769be3a069eacd6c6.camel@fangyi.io>
        (Fangyi Zhou's message of "Tue, 07 Mar 2023 21:48:31 +0000")
Message-ID: <xmqqa60ow7nr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fangyi Zhou <me@fangyi.io> writes:

> On Tue, 2023-03-07 at 13:09 -0800, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Fangyi Zhou <me@fangyi.io> writes:
>> > 
>> > > This patch is actually a hotfix for a topic added in v2.40.0 RC
>> > > 2c6e5b32aa (Merge branch 'en/rebase-incompatible-opts', 2023-02-
>> > > 03),
>> > > could it be reviewed and included in the release?
>> > 
>> > Is it?  
>> > 
>> > If a message used to say autoSquash 2.39 series and 2.40-rc2
>> > has it autosquash, then it may be a hotfix, but otherwise no.
>> 
>> Besides, localizaiton teams are already working on what has been
>> in 'master'; it disrupts their workflow to change end-user message
>> under them.
>
> The patch fixes a newly added i18n string, not the option itself,
> see
> https://github.com/git-l10n/pot-changes/blob/pot/main/2023-02-04.diff
> I found the issue while conducting the localisation for v2.40.0.

Exactly.  That's not a regression.
