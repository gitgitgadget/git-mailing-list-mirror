Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39252C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 17:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2361C60E08
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 17:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbhJZRHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 13:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhJZRHG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 13:07:06 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6377FC061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 10:04:42 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x25-20020aa79199000000b0044caf0d1ba8so72793pfa.1
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kWgY88mMsFpyh8VFgTPogE3DmRgo4faAGSMuqnA0ysU=;
        b=E9MddE5QThxE8QLHcYoCqe7AAJeVK1XDZPgUYFHs6nQQnjv5EYD1FTQu21B4A1eavG
         8sOeFhv1OrpfTDQ1+VJcV2khq5ImeDdWv+cNltYRm8ve0QEs1sU5mBPVlsqE4AY9t00r
         BVNLiQbl3+IvBQiSn0neUcGeUflmCRpqpYFnfdKSoaCsHIKKG3U2OZ2TIBsJD8G2tZzc
         dIaDsQ9KhZF2e4rgb/AA/eAROAtAUwQpIBNZUA7oxA+38DZayGQR0ki00IfgNNKxyT3o
         3GHOqeQRDrRertNQYJlCuSI+aW1k6hVabwriI/le9HQo7F5hzaUSlDFW2vmY+b/7h1Bt
         eVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kWgY88mMsFpyh8VFgTPogE3DmRgo4faAGSMuqnA0ysU=;
        b=cxdKEQ4TPQVkVNhVHrWv9gWJlEq+lopX0OYAb/874DqMHUGDNRrXPLpvvbfJqVww/t
         8Shkanl2qqfPb7ou/OQA1qiUDzE6ktXWrsGurrww8ORxbGtsJYzE2/ym+RzaXzDe63aL
         2UloNqSH0uARC3oVRM2vZMzGRWNfmAJeVaF0f0FPFuAKz06sz6HbkTPLDsiw7FA0fjag
         ICIYGCoHlzzM4UHSpo9/gHbdB4lZx9qazqJIPayAiJtnXdspbkLgtufyPXN9+T+UyscG
         HshQ+UnvlJlqiubn5hL/FuJ8lr3sWWTTTiTsbR4GmuGeqM3e3GiXxbUHoQ8YTb09PTdw
         UTYg==
X-Gm-Message-State: AOAM533jv7pJhOjWgcb/WyaMfR2xmBhal6BFQgjcdCbg+YyXX4JzmrJk
        E9wZ3gGl6q5PzX6hWPUe2iU9R0tdJyTqrg==
X-Google-Smtp-Source: ABdhPJxSj8N1TrKh1oq6wjFSQJuyICV41yz9ug07LTVB2p8Tm4IUXS2RZelJl0K4F4z0tunRMo3ou9s27K2/wA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1882:b0:47c:138c:bbf2 with SMTP
 id x2-20020a056a00188200b0047c138cbbf2mr4337887pfh.9.1635267881824; Tue, 26
 Oct 2021 10:04:41 -0700 (PDT)
Date:   Tue, 26 Oct 2021 10:04:39 -0700
In-Reply-To: <xmqqbl3czik5.fsf@gitster.g>
Message-Id: <kl6l7ddz7m54.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lbl3c7lsa.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqfssozk8r.fsf@gitster.g> <xmqqbl3czik5.fsf@gitster.g>
Subject: Re: [PATCH v3 2/4] remote: use remote_state parameter internally
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> c) Replace the backpointer with a remote_state parameter. Expressive and
>>    fits the paradigm of "defaulting to the repo when needed", but
>>    interfaces are repetitive and shifts the responsibility of
>>    correctness to the caller (see v2).
> 
> ... if we want to support the what-if callers, I
> think the best approach would be a slight variant of c) above.
> 
> That is, pass branch and remote_state as two parameters, and when
> branch is not NULL, barf if it is not among remote_state.branches[],
> to protect against nonsense combinations.

Sounds reasonable to me. The resulting interface would look like the v2
one, but internally, this additional safety check will prevent misuse.

>>> a) Represent detached HEAD with a non-NULL "struct branch". This will
>>>    let us continue using the remote_state backpointer, which makes many
>>>    interfaces clean, but is somewhat invasive, error-prone and it uses
>>>    "struct branch" for something that is not a branch, which is itself
>>>    an error-prone interface.
>>
>> I'd rather not to go there.
>
> Actually, I take half of that back, as I think this would be the
> best direction in the longer term, and it conceptually is sound.
> After all, detached HEAD is not all that special--- when we ask for
> the "current branch" and the HEAD happens to be detached, we treat
> it as a perfectly valid state and behave as if we are on that
> unnamed branch.  The state probably deserves to be represented as a
> "struct branch" instance.
> [...] when things have stabilized, we should revisit
> and see if it is feasible to represent a detached HEAD state with an
> instance of "struct branch" and how simpler the interface would become
> when we did so.

This "longer term direction" sounds like what I envisioned with (e). I
agree that detached HEAD is a state that should be expressed with more
than just NULL, though I'm not sure that "struct branch" is the correct
abstraction. No point bikeshedding now of course, we'll cross that
bridge when we get there ;)
