Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E246C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54822231F
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgLOCzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 21:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgLOCzs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 21:55:48 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6B4C061793
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 18:55:08 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id f132so21714069oib.12
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 18:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=f8I1yfo2KSBBeDdFfjZ6ihlYBs76CdsmwWWwA4Du6jI=;
        b=FNuAt3l6P4o6/+4Zb8MK5mJhD/z5NsnuwGGW3oRMH6Q9oLlwlaMyVThtSmbXNsHAJn
         zHNP8SPcJarkEapPnk0Xw89ihRQ4aK3mWbV+Fs0vQvK1PG9opAF2/f6vZuHl5fKGm+dP
         vL7gqsPhTsm219NRAbUJeFFgRnfD1Qd43NJRUTzpbsUl8YFd3HlXx1FgmNaOhd6lWkTF
         opwPbe1eWvYSji3t9JIixgdCcbI9a7gCnI7doCXAJyIWH3O4hg7mKQ7/oIDfZ60bMkqT
         W91KTaFb+ZS7tOZXiKY4UeaUCSrc2GdUN6hWRXpasd/IG+jCTo+IWQbA4lwKI5vrBnKf
         K4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=f8I1yfo2KSBBeDdFfjZ6ihlYBs76CdsmwWWwA4Du6jI=;
        b=uiPDMs4m/OYTFgnWKKPATYD7jlOT/OAe6iAdPe82F6DlRm0t+9FdisR/BuHnKVXjw2
         I/dqNtucxYXyOiLkX90CF09dELKcEuvesmNqoYDa2MaD048qCZB45vbvxHQuXNdHwxQg
         2qRVNgFC7v8tsBCXsCQW9Ul8o3HiUUsWFkVLMagdXEEaG45boEJ7hO/4tm2NCxzzcpgR
         4qvKz70lJgpMEAArWCV3qkRnAacsx6MlhixWE/KLApADuGqKLtQOcrVBg1Os9SKzXqoH
         4hlY58dPWdHibsoo/SWFJlK/Ckqnx2HaTs4/9LYG+9Vgcg52JRQUVkUGGDTlmbgkVWL1
         k8Cw==
X-Gm-Message-State: AOAM530FLbtB84blBRLqB95M2IrWi/ByAcOkTch5WiF4wyA7gQ3INCcE
        ZCKSl588xxWS+sF0m4TWV+4lcMOVk+P5Rg==
X-Google-Smtp-Source: ABdhPJyelZwpf/sZVrZ3RRs3YRkL7orKM5NOchTop+MC88HGycMmrarNKsrueOXJcOVIcxjNmgsETA==
X-Received: by 2002:a05:6808:28a:: with SMTP id z10mr20984211oic.174.1608000907948;
        Mon, 14 Dec 2020 18:55:07 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id i1sm95696otr.81.2020.12.14.18.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 18:55:07 -0800 (PST)
Date:   Mon, 14 Dec 2020 20:55:05 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <5fd825898271c_d7c482086d@natae.notmuch>
In-Reply-To: <xmqqv9d49dxk.fsf@gitster.c.googlers.com>
References: <20201214202647.3340193-1-gitster@pobox.com>
 <20201214202647.3340193-4-gitster@pobox.com>
 <5fd7d22ceec2b_d4113208c1@natae.notmuch>
 <xmqqv9d49dxk.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v7 3/5] pull: get rid of unnecessary global variable
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Junio C Hamano wrote:
> >> It is easy enough to do,
> >
> > Yes.
> >
> >> gives a more descriptive name to the variable,
> >
> > I disagree.
> >
> >> and there is no reason to make the code deliberately worse by ignoring
> >> improvement offered on the list.
> >
> > I doubt any person contributing to the mailing is making the code
> > deliberately worse.
> 
> Oh, I doubt that you do so with what you send out.  I am saying that
> you do so by not taking improvements.

I do take improvements, when I agree they are improvements. In fact I
did take virtually all of Elijah Newren's improvements.

> It wastes reviewers' time, raises noise ratio in the list traffic, and
> demotivates readers.

Are you saying I must always agree with you, or I waste your time?

In my view no one is infallible, just because X person says Y is an
improvement that doesn't necessarily mean it actually is.

I thought this was a collaborative process where you are supposed to
listen to my feedback to your suggestions too.

But I guess I shall take your "suggestions" as *orders*.

-- 
Felipe Contreras
