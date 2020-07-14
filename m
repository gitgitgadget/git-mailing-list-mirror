Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B59C433E0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 04:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6711021883
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 04:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgaqxvs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgGNEGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 00:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgGNEGU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 00:06:20 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D49C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 21:06:20 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w17so6457260ply.11
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 21:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NkXPbnQtxobZsce+A2s598DaoGpBvG5pCg2uBPwJChI=;
        b=kgaqxvs3EMzKMCWpADjMyC4VVvpsxQYFcrgpEDu7I0dMPrvIQavJ/suD798w0lsFTw
         fV/2fk/ZzCUrCk22qjk9TsyRSOE1WSljB0TByWyKyq2m0HQsPiB32Olp9+t2wEovXD3g
         dGuMHxaC8sTXnyyHsTbK0yLUjooJlZIPibOV1k4vJsLOW9ou0iqZO2caLBHq957ug9K/
         OcEyYNiTlriSVvSuxxd6Gq4dpFpOsibaZsTjSUg5Z6c3oQaeHNyREytOjrjitZ6UyzM+
         pqv07l7lnr4YswwABqBIuoH9XGgnlp0RgE7R7YSen6jImvGcDZ6S8puyBAlX6YlJAd1H
         fAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NkXPbnQtxobZsce+A2s598DaoGpBvG5pCg2uBPwJChI=;
        b=K2ByzhJ1dmXW/dfjM1YtNTsnBIkv1xqVv2xcY/Dlmo4z3R/GT1rtkqYAcpujGI/Fzr
         QTpSh0x1K1EfMhcQ3m5nRVkGu8UPS5WCmE1NVrI2YN6TMUxeF3tzEfa5ePeLznkD/1ty
         R3lHtE1dIJG/99Lc6E6ATAq4Q7SNGus/J+nuH81+jwCoSFuykjS0z50Mx/uZJ5b3OClr
         tBFViD/Q7LhRZYTl9MWDH9Q7R0irA2GLZMZD6F/SkkYMOx9N5V9Nd6yFsbNeayDV6whC
         YEgy4yFgIN94LzXkilTGrU4xr9ZvrD71KR/mQ5/KUeWAJKj8zAH9SE6nJuTxjcQZMzJf
         ZJNQ==
X-Gm-Message-State: AOAM531W8CqOcFrFjaQ6DNK3suE/J8vrLguF9adGambKD0YKgfbfikK7
        4vQ6ChV014ytT3lSagGKXH4=
X-Google-Smtp-Source: ABdhPJzHWm1ljqtQhYbUzWfPtK+AirX0Vc88M++Om3NyOBnUDdrv3wZSWUrWLWsap/nFDIheOrLMQQ==
X-Received: by 2002:a17:90b:234f:: with SMTP id ms15mr2447643pjb.7.1594699579511;
        Mon, 13 Jul 2020 21:06:19 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id w71sm15576868pfd.6.2020.07.13.21.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 21:06:18 -0700 (PDT)
Date:   Mon, 13 Jul 2020 21:06:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, delphij@google.com,
        peff@peff.net, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] setup: tweak upgrade policy to grandfather worktreeconfig
Message-ID: <20200714040616.GA2208896@google.com>
References: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
 <xmqqblkjnr5m.fsf@gitster.c.googlers.com>
 <xmqqy2nnmbh8.fsf@gitster.c.googlers.com>
 <xmqqpn8zmao1.fsf_-_@gitster.c.googlers.com>
 <b8ae18f7-a0af-bd62-2553-92989e1dbe7e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8ae18f7-a0af-bd62-2553-92989e1dbe7e@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee wrote:
> On 7/13/2020 4:18 PM, Junio C Hamano wrote:

>> The "fail and warn" approach introduced in the previous step may be
>> with smaller impact to the codebase, but
>>
>>  - it requires the end-user to read, understand and execute the
>>    manual upgrade
>>
>>  - it encourages to follow the same procedure blindly, making the
>>    protection even less useful
>>
>> Let's instead keep failing hard without teaching how to bypass the
>> repository protection, but allow upgrading even when only the
>> worktreeconfig extension exists in an old repository, which is
>> likely to be set by a broke version of Git that did not update the
>> repository version when setting the extension.
>
> This is a more subtle way to handle the case. In fact, it
> silently makes extensions.worktreeConfig work as it did in 2.27,
> which means users will not have any troubles after upgrading.

I'd like to propose a different endgame:

Instead of looking at `extensions.*` settings one by one to see how
various implementations handled them with repositoryFormatVersion=0,
what if we treat repositoryFormatVersion=0 as a synonym of version=1?

That is:

1. in new repositories, set repositoryFormatVersion = 1, since (1) Git
   versions in the wild should all already know how to handle it and
   (2) as we've learned, other Git implementations need to understand
   some of extensions.* anyway

2. whenever setting any extensions.*, automatically upgrade to
   repositoryFormatVersion = 1

3. when in an existing repository with extensions.* set and
   repositoryFormatVersion = 0, act as though repositoryFormatVersion = 1

4. document this new behavior with repositoryFormatVersion = 0 in
   Documentation/technical/repository-version.txt

This way, the result is simpler than where we started.

Unfortunately, we are not even that consistent about what to do with
extensions.* settings when repositoryFormatVersion = 0 today.  So
we'll have to exercise some care and analyze them one by one to make
sure this is safe (and if it isn't, at *that* point we'd come up with
a more complex variant on (2) and (3) above).

It's too late to go that far for 2.28.  It would be tempting to try a
simple revert of 14c7fa269e4 (check_repository_format_gently(): refuse
extensions for old repositories, 2020-06-05) to get back to tried and
true behavior but that does not do enough --- it still produces an
error when trying to upgrade repository format when any extensions are
set.  So how about such a revert plus Junio's patch plus the analogous
change to Junio's patch for

  extensions.preciousObjects
  extensions.partialClone

?

Thanks,
Jonathan
