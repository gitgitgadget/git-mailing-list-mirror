Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E159CC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 03:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB21022CA0
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 03:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgLGD1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 22:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLGD1B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 22:27:01 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A5C0613D0
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 19:26:21 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 91so7372313wrj.7
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 19:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IH/OpjfhkviV5FgvBot4sBQZu0MpRJIAJS+60nWDgEA=;
        b=R8a7OuJrMZ5xX6F4g1j47NsyG4jm7Hlwi8A6csWXNB6akO4CCdaU4KwcyadwAAwPg2
         5/dZnVtrWmuOZd6TCBbFna1wgf7AH50cC9p6gibKPrvZXWRe1xRiW50i741S27EjiKqm
         CtT2xE4m+wCUoep7MAvIYGqIOuZZtGrFnxm9x2WMbZh3iepynnWK3wgXDvC1XHKvJrxJ
         2eMCGqNEQqVirWNGmSk9g7P2ugAlzrgPKbu5tiJZqgFDpfBvO4bjkXlo11yO4jznoQ8O
         JO5MYeoHNW0w+v3CxWokHmRjeojcrTnNh1Zg+L3hBSX6oUsKva28HugtIZSgEnxW6Yd+
         yqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IH/OpjfhkviV5FgvBot4sBQZu0MpRJIAJS+60nWDgEA=;
        b=gbpdmt/9piqdqPTqSlvJjLkERPjH3Uyumzleh+5koXAmas6vrl/BI8Zd5+L2B6SUZ7
         GfGznnDjmoAn6oAVSgKZFIIhgxCPpLqc0gOxCCVnxIAOytRCpLEabzGKQ+UiIZxGalE8
         w/v4NlgVW3BGoI+ccv09w32kX9I6UzMx3OpJ+zgAmYP1k5njiYmhtBVhDFsviATxjnJ8
         thFYiEhEgFyx1J98apjJl0l+0+c7uXHFC2t1iCLMWHKo9jJBDUCjDBqH1CcLew3CIeSr
         q8YqtEPoep7nxkj0kJ0P7lnUHgRvgZkllunteQ+m7jCWphgDtmrMPRKKydJpf8IBhVFG
         q3cw==
X-Gm-Message-State: AOAM531e3Ec5K+1lsZQIzxpvsgwlKP/SqhQdIi0nf/wpZRZCXMt3tEws
        2jVhAb0gsi50Xn8IQDZ1f97o79MRRpt52b5joiT7Hr0wuKEGnA==
X-Google-Smtp-Source: ABdhPJymMyfERjER7WnI03QzGFWXgC4tC1BDotz7dz93KbRV/WxsbOvnBqSpOLzazsBsSWdvIhHDnX/K3zHmKM1ehA0=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr16783827wrr.319.1607311579948;
 Sun, 06 Dec 2020 19:26:19 -0800 (PST)
MIME-Version: 1.0
References: <f96f5cf3-713f-5c89-d486-e1a3f1c97b07@ramsayjones.plus.com>
In-Reply-To: <f96f5cf3-713f-5c89-d486-e1a3f1c97b07@ramsayjones.plus.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 6 Dec 2020 21:26:09 -0600
Message-ID: <CAMP44s1TQ3vmn2LT40jXA_3503hLWvadc3oDsatrOZ9weO_t3w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] gitweb/Makefile: conditionally include ../GIT-VERSION-FILE
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 6, 2020 at 6:37 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:

> Notice that the 'clean' target is making a nested call to the parent
> Makefile to ensure that the GIT-VERSION-FILE is up-to-date. This is to
> ensure that the $(GIT_VERSION) make variable is set, once that file had
> been included. However, the 'clean' target does not use the $(GIT_VERSION)
> variable, so this is wasted effort.

Same goes here.

-- 
Felipe Contreras
