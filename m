Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49AAC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB222078E
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsUwI3ZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgJEI35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgJEI35 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:29:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A07BC0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 01:29:55 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t23so3492760pji.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 01:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LFcs+k5/QP7r3ieCEVxgxsGD8Rasvdp2ZQpUBeiK+qI=;
        b=YsUwI3ZFW+zVdumlJlqnxANQlIPZTlEo5RkXYCS4rcFLSibiq5rR2uOp+YgStBFFki
         tJAq/gZOnhfWLQYT2CtDDap1TnlGcRQpES8Ge8pqq1ffj+asb4fplVXC+1Hnd20MXxg6
         qgkR8agTJ7K4OFXA+c4vYXO5H1a9OLtlJnsVJAZUI9d9dKX4aoK7R8DBl6qVD+V2XGzf
         hPnVpDXjoI3/xORmSh8FMNiOIBXWurVHVXkzAeyAazclCU6iGMczzbdn9xiNWOT7lDlE
         E+p+JMesgo4iovDrUB2nzC1HJcl0xfYb3iigdCMrtf/RbTefab30N+kvjoaOLCh6qr48
         HVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LFcs+k5/QP7r3ieCEVxgxsGD8Rasvdp2ZQpUBeiK+qI=;
        b=lWzO736nRnHm7+qgIv1F4HtnLo6kDPRKFp6g9vYt6167ew4Xw7QIxAfj25t79m5sCb
         KkuQWhMsa+6KqFzfd8LTuTSECG+5dNJZ+FKfr9OIYBw6nKPxUZf0cIfX1tuVYFTnolrT
         8pW6DiQ8R9pUEfVThczxsnC+ID7PmmEsk5sD4cFvyRK+JMbFUjTz/OhaIshsvKSRtnwx
         MU/gu/4izz0SkGekpCZ3L/F15Z1GQesiWN7xuqppfayC9fNJCvuLedw7p54WXLNUQBG+
         4Jzvhp5Al21OKHqM2nbszXyhYxpS2NDrihsiX6Feg2JDX/93z+Iph3c2ssJ0SskQDk7f
         WDgA==
X-Gm-Message-State: AOAM531jppGUA23Ug+vudZfRB9Q9jWJGq9Kjv9CpxgjuRZZVxpMFXBPA
        +iaoX5nzzlgYrjJ0FjGFbek=
X-Google-Smtp-Source: ABdhPJxFBqFGNBba0/sA/wZW1HZ+oGWtpd1pBAzV9WwMqTOnm3hTLBI91PWdHT6sJwCszpcw3/6hfg==
X-Received: by 2002:a17:90b:118a:: with SMTP id gk10mr14982054pjb.218.1601886595152;
        Mon, 05 Oct 2020 01:29:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id x16sm1268996pff.14.2020.10.05.01.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:29:54 -0700 (PDT)
Date:   Mon, 5 Oct 2020 01:29:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/7] fsck_tree(): fix shadowed variable
Message-ID: <20201005082952.GK1166820@google.com>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005071905.GA2291074@coredump.intra.peff.net>
 <20201005074404.GD1166820@google.com>
 <20201005082023.GA2862927@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005082023.GA2862927@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Oct 05, 2020 at 12:44:04AM -0700, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> -		test_i18ngrep gitmodulesSymlink output
>>> +		test_i18ngrep "tree $tree: gitmodulesSymlink" output
>>
>> Makes sense.
>>
>> By the way, why does GETTEXT_POISON lose the gitmodulesSymlink
>> keyword?  Is this just a limitation of GETTEXT_POISON losing
>> information that's passed in with %s?
>
> Yes, I think so. It comes from 674ba34038 (fsck: mark strings for
> translation, 2018-11-10) which is passing through our string. Arguably
> that commit made the comment lines rather confusing and pointless.
>
> Though hmm. Looks like the "tree %s: %s" part is in the translated
> string. So a translation _could_ change it, though I'd expect it to only
> change the words and not the syntax. Maybe an RTL language would. I
> dunno.

Ah, right.  I can use $n markers in the format string to reorder
parameters, so we don't want scripts to rely on their order.  In
principle one can imagine GETTEXT_POISON printing a random permutation
of its arguments but this kind of nondeterminism in tests would be
harder to debug than the current state where the args aren't passed
through at all.

And after all, the main point of GETTEXT_POISON is to allow us to test
scripted commands to make sure we are not translating any output that
scripts would want to use.  For that purpose, the current poisoning
does what we need.  (In other words, we don't encourage non-test
scripts to rely on these lines at all, even to grep for
gitmodulesSymlink.)

Thanks,
Jonathan
