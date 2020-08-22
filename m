Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8022CC433E1
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 14:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5194C2078D
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 14:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IryGdhYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgHVODv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 10:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgHVODt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 10:03:49 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F092C061573
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 07:03:49 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id u16so322465otj.10
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+1o599MOsdgGPxz735IUhrLGRcciYL/zP5/wPAilKU=;
        b=IryGdhYyY0GtohSf5+s/zImBXbZ0QKGGE1G6eJmes07xJYIUmQKccDH4AKRB1QqkCN
         k176gDopEJEYsVAPqEAudc6nmAjdawc0rR0W8uVlmpJikgf1h4an18u1+8pZlwKAr6/s
         Ff6l8fFA0Amd48fdrdlQKsAYxq4zYBCoj4fwrfaJNKz4v78WB2IcXauUTsaVaFYzh53T
         VqcgVBrZpDFc/o68N7UsxThydsknHNLD/eH3LOKLGn8Km5vDXzzB+27kbB/2PHceCqWp
         CaAxBiQT+OanAwIedN9ZHSk947xOwpGUf4MbP2Z20gOlO/PiBXxbHy9/l6x7BnfQIbBP
         ES9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+1o599MOsdgGPxz735IUhrLGRcciYL/zP5/wPAilKU=;
        b=bE7N5+hyvDrd4UVUA2vZw3xhbeZ3ntT7vkQ6qWMRgFfNlOTOS5T/BH9sIXr5u9cqcR
         952pE3VZxGk6pnQ1Uk2wnZLkFWSB+2+FxZz1H9jGXHKdYPiHU1IZfkFcXOmHXSJ/8VY6
         wl8kjLug/EzlRTklbEeeY3BVKATmW7tMvUsTsNfTwEv3oBhncWdwl3pZNjy9sVjQzb90
         crrmDjwzsKWfkR0E1sfPATb+Y2+5pYp/p88mRhr/zP4+hBba82133rlv4qk+/VY4ceQ7
         FjyX0pbMJ/kEFCLiEBvuSlyg53QHHOuRaAhgsLMhxNZiIjfV+WsJouX3eFP3PcZeclsm
         txYQ==
X-Gm-Message-State: AOAM5338gWg39Oa++8yITqDITLkLvG8J49R4xqHvto7leStypk/wuvSQ
        ccqS6VoUemhYrINTwW+A8ZPirkOJ+R9Q/mkYFn4=
X-Google-Smtp-Source: ABdhPJx+vu2Fi7/GA9i1BM3dJ+9ZtKAO9pmQqSqNf07ino4QflPbrzcAHQsZL9lPbNilG2f9d5Z1rIimp7AljDuZwBI=
X-Received: by 2002:a9d:ae9:: with SMTP id 96mr5142856otq.241.1598105028077;
 Sat, 22 Aug 2020 07:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
 <pull.707.v3.git.1598043976.gitgitgadget@gmail.com> <xmqqft8f7jeu.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqft8f7jeu.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sat, 22 Aug 2020 19:33:37 +0530
Message-ID: <CA+CkUQ-+z2e+ni8UQOEtCOS2zEXhSU9HK3D_Dr935AiLj4GGzw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] [GSoC] Fix trailers atom bug and improved tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Aug 22, 2020 at 3:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Currently, there exists a bug in 'contents' atom. It does not show any error
> > if used with modifier 'trailers' and semicolon is missing before trailers
> > arguments. This small patch series is focused on fixing that bug and also
> > unified 'trailers' and 'contents:trailers' tests. Thus, removed duplicate
> > code from t6300 and made tests more compact.
>
> I think we should focus on completing the first two patches and send
> them to 'next' down to 'master', before extending the scope of the
> topic by piling more patches that do not have to be part of the
> topic.  Let's take the other two separately from the first two.

Sure.

Thanks,
Hariom
