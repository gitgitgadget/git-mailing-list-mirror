Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0913C1F406
	for <e@80x24.org>; Sun, 13 May 2018 02:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeEMCXz (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:23:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36813 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbeEMCXy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 22:23:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id n10-v6so9203842wmc.1
        for <git@vger.kernel.org>; Sat, 12 May 2018 19:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1U9Wa3sJn+AKEtmUnCWkRxUmW78ET8nKt1Tbtkn7TuU=;
        b=vKNbrz2aAtypLTp7E6VEseTY6esvZLZjonWxZ6CO308Ir6X6fRrEDY/Se19mUkYEdt
         27g5MCZk3tYfxvgzyeFYVG3i80maWmWeuuQJdopoEHC7ymdkINvgt3daOh5QtXrjCg5o
         DYoZbZVEiXJcisQ+TRE2aya0PEMo6EJMV94QgpFHMJBIYk3PshCKg1Us9d6Royx7Zlte
         94SOWwjXs2BnZWRwd1hEt6PN4qhyHwseY8oJ4kxsnlWJFUprKO4u5lt5o4Pcvk9burHC
         PLAgzNG/Y4iWQFNtwEdb8eMUAShgRVIKhzglFRSfgJJx/QH8IZ+zd5SjEQNcwfrObSIk
         b7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1U9Wa3sJn+AKEtmUnCWkRxUmW78ET8nKt1Tbtkn7TuU=;
        b=e8Y3RJf3fKh3StcluyoiU97Zwd85KfuDzHuOLRlyq/7S2oN+w3cg0dM1JtSr1m32Jr
         Bn4Yg+pe9HOSj977/OBybqdGSetki2WkiYslS7WGNWa34yalNkpLoGIXoUTa/qnOKm62
         mhPD6x/pufh5hQbLg0da1fDcL/p+IVlYfPZolUPmMI7uIsQaeTRSu0W4HGeWxSEdvC6m
         XPiJfbzVkYgp1fiMh3NBdjVSSFxoOs9L5j5vqFrwD3PMg1rv5kjgj58yfchrUBf4ZVXU
         VPQ2XolyqLkSLRjmQX+ReRz9Rtn41djuM5NlCr6OxwaOLaEnD8GW0t/ZmaYQK/ER/ZtM
         5F3w==
X-Gm-Message-State: ALKqPwf3mInHShkIzwYnEO4J3jQ4XTuFX9lSi6BzR+tnGN5GXAAJ/TJv
        npsCvK3UZQt3cqfWa+/uTXc=
X-Google-Smtp-Source: AB8JxZpn+PDZQEsjbcykIPi4rmVYuy1OTgCZ34t941d4xmLqgynuQuCKsjr/hneWr9yKaDEyKNPrgg==
X-Received: by 2002:a1c:105:: with SMTP id 5-v6mr2020830wmb.145.1526178232118;
        Sat, 12 May 2018 19:23:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l20-v6sm7727660wrf.90.2018.05.12.19.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 May 2018 19:23:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/4] mark_parents_uninteresting(): drop missing object check
References: <20180511180029.GA11290@sigill.intra.peff.net>
        <20180511180158.GB12543@sigill.intra.peff.net>
Date:   Sun, 13 May 2018 11:23:50 +0900
In-Reply-To: <20180511180158.GB12543@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 11 May 2018 14:01:59 -0400")
Message-ID: <xmqqin7se1jd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   2. It "lies" about the commit by setting the parsed flag,
>      even though we didn't load any useful data into the
>      struct. This shouldn't matter for the UNINTERESTING
>      case, but we may later clear our flags and do another
>      traversal in the same process. While pretty unlikely,
>      it's possible that we could then look at the same
>      commit without the UNINTERESTING flag,...

Yeah, if two ranges given to tbdiff to be compared are computed
in-core, uninteresting boundary of one range is likely to be
interesting on the other range.

