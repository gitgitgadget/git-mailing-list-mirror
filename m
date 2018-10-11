Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC071F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 23:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbeJLGhU (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:37:20 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:46408 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJLGhU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:37:20 -0400
Received: by mail-yb1-f201.google.com with SMTP id n8-v6so4416864yba.13
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 16:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BRoqiwemwYLLyNF3kugfRI771wcIpw746AK2r2+8I2Q=;
        b=JntLXwprsIZag1dnBywxCi7S3ZPanNxpDDgGp8vAtKJDw7Q4ofVeSLbusAqntww/sB
         NHSJcV1Irybtst7+MHiNfB0ILuzYH893+5Ca0cvqifj/Skf7p1sDChDZQa7oGuOrwWA7
         gjCLALeCNZklGDb1iAmpBLbi4nqSRpDKeG1+St5p3pUQ1J8s59D02Xlka1g1igza9pIv
         EhP8dugTqVLZM+qzbELMbMsQYHzwzH3vNBwNuhzNDjlTtrL1UL4xSgTf9ZqK2D2JHW3O
         OuV9aAyAQtaWn5h7R4p31iT1qeFe6GCwYqHiPKJybdniMpYdti49IPHdQgyAP9vNS7hF
         c5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BRoqiwemwYLLyNF3kugfRI771wcIpw746AK2r2+8I2Q=;
        b=p8Pvmpd7PIczKMGpY2YKMP8M5EMXPDtKHtaDpZvm/RJ68nPhGX7TcgaRH7cJFSgPAu
         8a3tfuON7ct57mkj97GC/ew8tuhKLbA+Es1R2N8WivYjC2M2H/YYV8B+ylg0lpbFhuB6
         daFMoWoZ5XKXK630lGyEpe5piyrib7YXv5h7N/iwgZU00uOWLX/k5t+Q8HeIjQ7MuqFw
         MBSQNmDz803EpFvuH/tO910R3SEB/47D9NF7acJB1u9seucr3pGeJHZZQaSCQLbkSw16
         I/hUyQSkYVGStktILXri7GlvnUD7hl+61Zumv88O+p4Tyb6fuxa9P0Z7t5jxfiZhPvVD
         yo0Q==
X-Gm-Message-State: ABuFfoi6nLcZnR86+G0k7IkJ/ZRoDt6PpdcUo+cYv9iAXUw0UCjbutVz
        M61HPNpQ+VqdIAIH2/fzvos5WQsLA53SIKVgeY5m
X-Google-Smtp-Source: ACcGV62KCqMvlZq0TN5vV7Q7ceUxF3SzAFyqLOTq1v/dw1Ur94QSA09WfdTDzCg0edibvjY98hxO53SNpJlsyoZbSMMm
X-Received: by 2002:a25:b18d:: with SMTP id h13-v6mr2120253ybj.28.1539299272094;
 Thu, 11 Oct 2018 16:07:52 -0700 (PDT)
Date:   Thu, 11 Oct 2018 16:07:48 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011230748.201450-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [RFC PATCH 00/19] Bring more repository handles into our code base
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This series takes another approach as it doesn't change the signature of
> functions, but introduces new functions that can deal with arbitrary 
> repositories, keeping the old function signature around using a shallow wrapper.
> 
> Additionally each patch adds a semantic patch, that would port from the old to
> the new function. These semantic patches are all applied in the very last patch,
> but we could omit applying the last patch if it causes too many merge conflicts
> and trickl in the semantic patches over time when there are no merge conflicts.

Thanks, this looks like a good plan.

One concern is that if we leave 2 versions of functions around, it will
be difficult to look at a function and see if it's truly
multi-repository-compatible (or making a call to a function that
internally uses the_repository, and is thus wrong). But with the plan
Stefan quoted [1], mentioned in commit e675765235 ("diff.c: remove
implicit dependency on the_index", 2018-09-21):

  The plan is these macros will always be defined for all library files
  and the macros are only accessible in builtin/

(The macros include NO_THE_REPOSITORY_COMPATIBILITY_MACROS, which
disables the single-repository function-like macros.) This mitigates the
concern somewhat.

[1] https://public-inbox.org/git/20181011211754.31369-1-sbeller@google.com/
