Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8506BC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 20:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352232AbiETUD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 16:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiETUD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 16:03:27 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA419C3B6
        for <git@vger.kernel.org>; Fri, 20 May 2022 13:03:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id rs12so5781638ejb.13
        for <git@vger.kernel.org>; Fri, 20 May 2022 13:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GmTmfw7WlqumPEftjp48zTXtmCbUSPUwuvwzlWTUJf0=;
        b=YW/unjnRDMT86j2qCmxVFTYY/eFNxUGhbezmKCeGxeZ361DyoGdsdYTR+QDp5WuoVZ
         Kah8tQUJmn5Z8BUNXVs1N3Pr31gI1qF6DzJXlE8HumRx7m4fqcAEgOHdSCuxssinT/ly
         OEqCmDPxdSN9POcvjnilPo9cDE4ROljJ8ZvjwllFcfKwytJ25pPouyIH8jB5w6nLEkmm
         Nf+lieTPypFrVHUmiWOh7vmGK+UT8UKjfg6D0bnKWvQHA5H6Z8piQQOwVPC706H/8JM1
         ha3JDpj7pHqnIGC5BuIjdf0D7oNkWvxUqSXP6nOSqlpTbRjdiLlDc4TpZhyCcAUw66Hc
         H9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmTmfw7WlqumPEftjp48zTXtmCbUSPUwuvwzlWTUJf0=;
        b=jdMGDJr3ROZJEa1PvedkO2TnMv4To7kK20zxqwSmFrwnmXPIETHdvxxeFQmHejP4Fx
         90TsQb5N8F0BdirI/ka5gjPxFA6wMnyHoYem7cMfTn+xN4kefv/TVSnp1CXWSYb+msZE
         siU++g5TTIanMavprPT2X7nHt30ZIDAaBRakpPQQyOBO/NbNbF8VYEkUw8KFueOLPKD+
         G26e48Ljl0PKmoJqDmY7FqTRRKAEzCJksQuU5uipH25bwRpCqioKiXYkk3aIRuK7oBiT
         cuyjSfxkII6VWsKPfcu1GNVgs9zwofeHEBCrKYAt3ZjSwnTpZ4Xw2IAMwXTxGciTCv4Y
         VSGw==
X-Gm-Message-State: AOAM530ZX26TVeZFeKtqtBTAMVdKfOOzfJ2poAit5eH9v6wL56vKIPU/
        pHnqb5KeLorNR2EX1VvqRklhvoTRKqI1fSpsuxU=
X-Google-Smtp-Source: ABdhPJxg9gjivSIh/EMv7a2NFb6CyP75UHjercq3erI9XDwA3BkgWPldNv8c4MPgTXqgf9DByQhLhBlzZzHdF+/+A3Y=
X-Received: by 2002:a17:906:39d1:b0:6fa:8e62:c8a2 with SMTP id
 i17-20020a17090639d100b006fa8e62c8a2mr10370803eje.487.1653077005505; Fri, 20
 May 2022 13:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220505203234.21586-1-ggossdev@gmail.com> <20220510171527.25778-1-ggossdev@gmail.com>
 <20220510171527.25778-3-ggossdev@gmail.com> <xmqqv8ucko6v.fsf@gitster.g>
In-Reply-To: <xmqqv8ucko6v.fsf@gitster.g>
From:   oss dev <gg.oss.dev@gmail.com>
Date:   Fri, 20 May 2022 16:03:14 -0400
Message-ID: <CAAA5oLndkcrRSXSmMbGk9JTQEE58e_Q=WYr3vaFx1C8i7ZSgZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dir: minor refactoring / clean-up
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Improve readability.
>
> It reads somewhat a subjective opinion, without explaining how/why
> the change makes it more readable.  Perhaps
>
>         Narrow the scope of the nested_repo variable to the block
>         that uses it.
>
> or something?

I've updated this message.  Thanks!
