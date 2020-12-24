Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057E0C433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 16:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6D1224B1
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 16:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgLXQQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 11:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgLXQQp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 11:16:45 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710F4C061573
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 08:16:05 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id l200so2737357oig.9
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 08:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=GGiIy1rjq8gyG66zTeU1SPZxod7TYo4pRetXJfgQl1c=;
        b=ZSpvEoeNTWEge1mBdQ7/3e3yePyObx92M/qwnRLtWPTIASoVBH6JIwJOj/6NFnn05X
         5h6OfoGfyrpnrFxLACm2m7dApbclrtZgnzMSzpoXVvxuRFMA2A8VP83X8zEtN89mUyt4
         lbBYi1KM5DY86AcLp9hEP+L9N9hyQ8vkRlWzH26qqLlW4tFTAETE9FJ1H/FAx8nizHO7
         6JRFjFYZbj/7T3qCrA6LjsmNXjsTDjpzLnAZVrPNsNz9O7Wi/lrfyonRINM97BchY0pv
         F3BKZNuVtw9afbpn/CcFChrMDn0tiiFow61x8tVtZrcCRI/agSOBFcxMLwAwEbapBKDG
         AFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=GGiIy1rjq8gyG66zTeU1SPZxod7TYo4pRetXJfgQl1c=;
        b=ctWjZVkV3H2KLWcNkUozIaOGfcRkhS3U0DcMM5Cpf8fy3G5Yk4ryAp8Xy7N+yiAjjR
         dJfW+GhC6VevNj2Awef89dnmmVrzr/INYps7WSSTTEjvlSOzz+zOGqR/+ULllONttSi1
         nkAJ5nNN7cIIdjtLBxsjtYA2c+v5LPQ9frw2FNsdhuhKxDhVI8eDQsEmvrwapBoCdkiq
         A4Kwabc8m6Tr1i+nP/6EGpRurKyIWRQn0z9OQweXoK77XQUYHRHWk+qNWrTvggsIejy1
         XT0SA6HGdjpV3OosA6TmJos3o4QYdk8Es9KAnCkPaLMVJpJpd/JXJqkaCSNiCVrkzky8
         aGAQ==
X-Gm-Message-State: AOAM531Wq0qFXdL1sqvqPeOhCo6RCRn6Qm7NchhoNtUmPV02KSMpOF02
        LDrbTcKGC1HvpMmde4CmeGs=
X-Google-Smtp-Source: ABdhPJxxl0GAhzIKPg766cy718HfzAjx9iD0+CPUWfnlsuTfNIdwNLYpnapUkLIx0xHoDopLnfrGFA==
X-Received: by 2002:a54:4005:: with SMTP id x5mr3356935oie.74.1608826564855;
        Thu, 24 Dec 2020 08:16:04 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id c12sm3916962ots.7.2020.12.24.08.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 08:16:03 -0800 (PST)
Date:   Thu, 24 Dec 2020 10:16:02 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Message-ID: <5fe4bec2da21a_19c92085f@natae.notmuch>
In-Reply-To: <xmqqim8r36ba.fsf@gitster.c.googlers.com>
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
 <xmqqim8r36ba.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v5 0/1] mergetool: remove unconflicted lines
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > There's not much to say other that what the commit message of the patch says.
> >
> > Note: no feedback has been ignored; I replied to all the feedback, I didn't hear anything back.
> >
> > Changes since v4:
> >
> >  * Improved commit message with suggestions from Phillip Wood.
> >
> > Felipe Contreras (1):
> >   mergetool: add automerge configuration
> 
> This breakage is possibly a fallout from either this patch or
> 1e2ae142 (t7[5-9]*: adjust the references to the default branch name
> "main", 2020-11-18).
> 
>   https://github.com/git/git/runs/1602803804#step:7:10358

It seems likely it's the mergetool patch.

This regex '/^=======\r\?$/' is supposed to handle the crlf situation.

I can't imagine what would be different in Windows regarding that
situation.

-- 
Felipe Contreras
