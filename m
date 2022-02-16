Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94D1C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 07:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiBPHL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:11:29 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiBPHL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 02:11:27 -0500
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBFB1CFCF
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 23:10:58 -0800 (PST)
Received: by mail-pf1-f202.google.com with SMTP id 2-20020aa79202000000b004cef2fc59f0so979478pfo.12
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 23:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uVVP4JkHFZ3hPFUR9AGU8J8n+Y+ur1Wbp3SuHTgoKuo=;
        b=A9TwcnHt2MF9XGi6GxjG01QH9/XuTp1p7JKIk9ps7gZPhSW84g79HEXoMOyFvfsF4N
         uQZO+tpTmqnphtHXfS8bV1DZ8P1o0yVKboDn0KkQjjPAKbDXkwQByxDkamAHS8nPufGL
         hGOA0RUqnGxr/BmXL1SEz57Tqd7JfKyDa3BoOukNeIbeIy3wQy+9ymeVB5OvOsXhyvtT
         AojJWhyjTYNi1Oxa4yegQckrUcYHW1Kedzlx6GxALxoo+0qYgor2RNEj30bPqRF7HVvG
         r+Njw9fzxD3Lexv38l/XNAKH/ZXhLIrMJEvYjKjfFCJEoDTEOgyshj4YYmghsyJskNpI
         5OyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uVVP4JkHFZ3hPFUR9AGU8J8n+Y+ur1Wbp3SuHTgoKuo=;
        b=TCraKeGiPJ9Ciw7/JR0c/kxjrh+l65tmda+2/zHU00lTSufJTjpdvqoug7NZkMga1M
         2/PzuLSfV53L2LaNVDF9UkAY2adXCI8iA8Xk5LqKAo6g3PyHUgw9/+GhumcbmyvE9zXQ
         L+ZIgZCykQu3KfIPH7qRZuc1BuxpZhCNEIDvOoszlbbc5VRH3lSWdaCohwTPmc6GRXAH
         lD+OqUoFaolKRrhLKx9/Ma6CkLjwKuO9yszroOR0QG64WmxB8fxPWJ3RLNji+sy4Qoxi
         nDT1SdHACqDH4eDU//FDFfzZgOw41tQSyYS24Pz6EGByx1E+kZlpNB/FBEdHAVj08pLg
         TFRg==
X-Gm-Message-State: AOAM530Ky2k4F7H26RllTDw59HGcW45UcjkNXztSsXchOeXhh7adTne5
        9W843FMMW106X2QPZ4vhf3+m9maOzwNztw==
X-Google-Smtp-Source: ABdhPJw1t6M03hdsnyiLJ3/ohrUIRdVMXWOyaD4gwLrm2N2boBz+X/gLfHZ5CPKc2DtiTec1PRKb5/IvEW6AbQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:190c:b0:4e1:7fa0:d488 with SMTP
 id y12-20020a056a00190c00b004e17fa0d488mr1561977pfi.52.1644994797551; Tue, 15
 Feb 2022 22:59:57 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:59:42 +0800
In-Reply-To: <20220215211848.1620058-1-jonathantanmy@google.com>
Message-Id: <kl6lk0dv5map.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220215211848.1620058-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 3/9] submodule: make static functions read submodules
 from commits
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> The changed function signatures follow repo_submodule_init()'s argument
>> order, i.e. "path" then "treeish_name". Where needed, reorder the
>> arguments of functions that already take "path" and "treeish_name" to be
>> consistent with this convention.
>
> This paragraph made me nervous, but looking at the diff, you didn't
> actually reorder any arguments. Probably best to delete this paragraph.

Oh you're right. I was sure that this paragraph used to be relevant, but
I guess not. Thanks for the catch.
