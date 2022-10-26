Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220E3C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 16:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiJZQGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 12:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiJZQGg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 12:06:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFD97E818
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 09:06:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id io19so9603477plb.8
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0+pFEuNNZF5XMOAYOGDtUCwuq9Np4QeUtvkdV2JisU=;
        b=MV12ddcoM9f5OGQ0XsJQjKdi9FAaTE0GBC86oG5ME7ut6SqTtT9lMjGWZIAwqHbesH
         Hactsut5DbCUNvvXoPRUHYwo7o7cct4Vl7j1g4nc5RR2Jz6yp/fF2ihcZeP7r26J0yAb
         q7b+G8OKjPuNqHxCycEJzZxV4Wf9Z/4gwjudiTrX9ANpEpN4xM9kdjjlWqpj2YK3sqFv
         2Sskt84VXomV/VJPZ+2a7BbbP2J7rBLDYGIiXnNcLRHyj0sMdm1oOSNeC7W3sS05yaQ0
         oVL04OGI6NR773gRS0asEJPJZKLgaPvDIT8xbQaFJBFFai9bVVvIR0Ik2bEk3N5eJEG3
         NlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B0+pFEuNNZF5XMOAYOGDtUCwuq9Np4QeUtvkdV2JisU=;
        b=npBVEmdZO+MFDarSquDjOwN2Zo/wmJhfTZu0JNylfR5xtyASIQo7AnjWDMTRW553um
         52R/oSqnJthJOJWtvfrjOncj1qAjto++DF8Y7CJHdNaf/OC+WP8JvUeAFVWGwCrQ+HnL
         qPVK/36ZjrZaj3QSXintVuU3NOpO6us6nmrQXbVRWhTs5SwM3g2G+kgbfqReDmw0zoqC
         wx1tC4WXljJll5JUFRl+/z1X40Xx8GlhWU5g2LEgNPyy6kaLlQGTJnSVX0e4NHYmhSjY
         Oo54kuqHO3NSpwtwqdXf9Zt65C6xtHfs037D66UppEe5pIryZwNY8fJNF9LFPPskxz30
         OEjA==
X-Gm-Message-State: ACrzQf3EcsKxdLDEbTKExtUevjk8Bb0nVTvSGVkk7Cj+t6InpjGEoGzg
        b7NxxZC1kMbKzNRvPEJajwo=
X-Google-Smtp-Source: AMsMyM4jP5dlZGk31ULV2zm0X5cDxMcaUJ4ikUEmNdJJjFkzsN9+4oQhNgkE10q+16m3WtWohuyqBg==
X-Received: by 2002:a17:903:2402:b0:184:29:8ac0 with SMTP id e2-20020a170903240200b0018400298ac0mr43628784plo.174.1666800394685;
        Wed, 26 Oct 2022 09:06:34 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x15-20020a1709027c0f00b00186748fe6ccsm3069854pll.214.2022.10.26.09.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 09:06:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v5 00/12] Bundle URIs III: Parse and download from
 bundle lists
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
        <0267162a-098b-2280-46b6-51932a8df6c3@github.com>
Date:   Wed, 26 Oct 2022 09:06:33 -0700
In-Reply-To: <0267162a-098b-2280-46b6-51932a8df6c3@github.com> (Derrick
        Stolee's message of "Wed, 26 Oct 2022 10:34:41 -0400")
Message-ID: <xmqq4jvqlgc6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> This version has been available for a while now without comment. Could
> we consider it for merging to 'next' soon?

Could somebody who has reviewed it fully give an Ack (or two)?  I
know an earlier rounds had some comments, but after v3 things have
quieted down.

I know the change from v4 to v5 has good improvements, but do not
claim to have read the other parts in detail.

Thanks.
