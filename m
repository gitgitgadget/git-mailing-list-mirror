Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A25C47080
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 01:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E08D613B4
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 01:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhFBBjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 21:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhFBBj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 21:39:28 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ADBC06174A
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 18:37:45 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id d21so1198711oic.11
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 18:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5bLxWvhShfGyLU5ileX6hRzqi4S2YVjaZBrUikHpo3w=;
        b=eYvtSaYAkZD/6pPnmGoKm9vRvp7qVW6FNvcLkTkMZjHNSnHkiIGFaQrPkh6mUPrXjx
         WMuzCwXn9ZeqXbC8E60n/Elncsrg62xiTHAv4DhYrOiQgU5Xrn9ZFqq2ZB3NNgDvtSC0
         qAZDCBARCmuUqYsLmp20Y7nJgekl0wobLp5/xpGyrtrvoLCEVMX/rVXIwuW49zxO+0ol
         fOp0l7pBhD02qI5xMSKm0rn1U8u4V5690SisSbW55jXPdHzu2xLjfHIBD8ifBwI5xS7u
         XkNfH2IDlMKScYCKvpw1SujX88I1kBb8GZ2q54iHMGnEl69tt71P2hOwLcJIJZgyDiJ/
         Melg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5bLxWvhShfGyLU5ileX6hRzqi4S2YVjaZBrUikHpo3w=;
        b=pfIPi/p69bJrSfjVcGMmJvsNhp2LqmmaKUvA1HQ6XMJnyICAyGJOVpOca5jTH3VB+L
         gGuRMGeZ6ZJLqPuSjpKFB6zkUFo8iY5jIqm/Aczk6W3EMB/KOVq7R5sDcOQZvRBhF1nl
         xIUvlfo2yqZcF44eYN7uLC3w3w3cFEaDxiM7W2mE40Lm9Dq+KTsuAC4pE8C/U4VR/oRt
         yuT/7Wok0I9N26Hs5K7+feM+7lgx9X3WibLUYMW9f5wTij7mEBRCKJYtdbnApM8sLXpS
         PC4rrJn+uPa6d7ySrYcLNlsw8QX46QfXy96ZmmFEwoOszeGNT/R5Cnad3do06GCC6k5+
         OaJQ==
X-Gm-Message-State: AOAM532MF8Zh2zZI7kIVwvNfKl8jAEkTRX4MMvA+YkzYtwy34AmtZPBk
        ui2D0bsF/bUJGBkDIRI4dhiiqF9N5El81Q==
X-Google-Smtp-Source: ABdhPJyKukYh6olF3AsxE3ZAgQ++mgJaQCZWWitm9IVGvDXMBh3zGZNt9Q/ZBj+Xy02g6mMXlU5mtw==
X-Received: by 2002:a54:4398:: with SMTP id u24mr19940209oiv.81.1622597864372;
        Tue, 01 Jun 2021 18:37:44 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:35fd:75aa:3890:f004? ([2600:1700:e72:80a0:35fd:75aa:3890:f004])
        by smtp.gmail.com with ESMTPSA id l141sm3845339oib.44.2021.06.01.18.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 18:37:44 -0700 (PDT)
Subject: Re: bug report: git checkout deletes worktree file even though it is
 excluded by sparse-checkout
To:     "Tim Renouf (open source)" <tpr.ll@botech.co.uk>,
        git@vger.kernel.org
References: <F58C0A40-A1B4-4B47-A8EA-20FEAB011B0D@botech.co.uk>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <28a211cc-f210-8ce8-e7c2-90e02ff449fd@gmail.com>
Date:   Tue, 1 Jun 2021 21:37:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <F58C0A40-A1B4-4B47-A8EA-20FEAB011B0D@botech.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/28/2021 4:14 PM, Tim Renouf (open source) wrote:
> Hi all
> 
> I have a bug report: git checkout deletes a worktree file even though it is excluded by sparse-checkout, even if it is dirty.

...

> I set up sparse-checkout to include only file1, not file2. file2 is now not in the worktree, even though it is in the commit I am checked out at. Then I create file2 with arbitrary content. Then a git checkout switching to the commit where file2 is removed also deletes it from the worktree.
>
> I assert that file2 should be left untouched by that checkout, because it is excluded by sparse-checkout. I guess file2 had its skip-worktree bit set before the checkout that removed it from the index; that should stop it being deleted in the worktree.

In this case, 'file2' exists in the index at 'master' and
'git checkout master' made the working directory appear as
if it was at that position with the sparse-checkout
patterns applied.

The confusion happens that Git behaves differently when a
file exists outside the sparse-checkout patterns based on
whether the file actually exists in the index or not. Only
an exact path match with a sparse index entry will cause
this deletion.

This is another reason why I prefer the "cone mode" patterns:
it is harder to get this kind of problem. You could easily
make it happen with "folder2/file" where "folder2" is not in
the cone mode sparse-checkout, but it's less likely in some
way.
 
> To be clear, I expect that last “ls” to still show “file1  file2”.

I can understand this expectation. I don't think that if
we changed this behavior that it would cause any confusion.
That is, as long as the file disappears when no longer dirty,
_and_ a command such as "git reset --hard" overwrites the
file. It is important to provide ways for users to remove
the file when they want it gone.

Thanks,
-Stolee
