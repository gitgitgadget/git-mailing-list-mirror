Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870BEC77B7A
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 01:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbjFCBB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 21:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbjFCBB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 21:01:57 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98887180
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 18:01:56 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-19a13476ffeso2938182fac.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 18:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685754116; x=1688346116;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UyvV5opNLsnrlR01PKGiY3LZmPl3ylI82cugsiFkFFk=;
        b=mv93VnlFjRcdpKPgpFI9NwuSlTa9feF5LPP3M80cIMuLBXgkBiVTF/cCkkwfUCTQxu
         +qDgHEzjIHRun5wqYGklJEYV/+I0/Ogz1WzLu45YpDXoJU0zpJx0m3Ds3Mvl+/XFT0md
         mfefM/CXC7X799cLRbKfy5v3sWliMToa0f+v/189trE6pP0RKK5UnFCRK+6xUrpdauOW
         H9GiHT+dCLNeU+T0UWWXoya0R8rjPkmKl8Eob54PmzkhioBbY5yzOammznLAPifEUnxq
         5RQGw0SyHeTOQjTLqnahZK+rm6QHq53qMVNsJkocPGJknUfoAm3SzT6sCMFZtXOldH8n
         Z/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685754116; x=1688346116;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UyvV5opNLsnrlR01PKGiY3LZmPl3ylI82cugsiFkFFk=;
        b=Mho64WccUOahuHVZ0RFdN6dEM9szrx6+dJwU5pCCfhdSnc8j2AcOXjt/b1maTU90f3
         dN9QMAHnhfPMmRl55fusXcEERssbovm6xY+2tVN8Yo3r6hEQga8jWj+1xutsAaA6urgE
         cYsv7kOgbv1w3iXMIUtz2LcraG0tx0cLPgO5Axi4RZktOqATcSmk895pIQ7qBM65F8NU
         ExTZpGDklx2pd9dhV2Qfoy10DDUfr1TDXOu2O0bCzsPpeFlyWFnFOSSNSxXcal1Y+/0+
         tuJIQZTRSIDqPnh7YuM2Dy5/7w0CshUgtlkIrx+d9dUCVFvcZGOIclV6PRUJYvRVBG5+
         pVDw==
X-Gm-Message-State: AC+VfDzKR/BdCynVW8q5c7YR3XXcRSL/pjm0HEAtAPC1jxglQ2Gwb/SS
        gEOumcguUK2S7X6wlqbljxU=
X-Google-Smtp-Source: ACHHUZ49MEJ5jIizYaMIm/zsjI0idsIccGpJsZr2lLH6ONYP8PjW1SYw8Ncw0GTvTbdXwIr4GkB87A==
X-Received: by 2002:a05:6808:47:b0:394:ba74:a522 with SMTP id v7-20020a056808004700b00394ba74a522mr1438476oic.57.1685754115780;
        Fri, 02 Jun 2023 18:01:55 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001b03b1bcf6bsm1921604plp.252.2023.06.02.18.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 18:01:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/3] Changed path filter hash fix and version bump
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1685574402.git.jonathantanmy@google.com>
Date:   Sat, 03 Jun 2023 10:01:54 +0900
In-Reply-To: <cover.1685574402.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 31 May 2023 16:12:34 -0700")
Message-ID: <xmqq5y858ikd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Here's a new version. With this, Git can function with both version
> 1 (incorrect murmur3) and version 2 (correct murmur3) changed path
> filters, but not at the same time: the user can set a config variable to
> choose which one, and Git will ignore existing changed path filters of
> the wrong version (and always write the version that the config variable
> says).

Hmph.  On a system with unsigned char, we should be able to keep
using version 1 without losing correctness, I suspect, but probably
they are in the minority we do not have to care about?  I can see
the desire to simplify the migration plan (i.e. essentially have no
migration---this will give us just a flag day per repository), but
I'll let others to comment.

> In patch 1, the test assumes that char is signed. I'm not sure if it's
> worth asserting on the contents of the filter, since it depends on
> whether char is signed, but I've included it anyway (since it's easy
> to remove).

So, on a system with unsigned char, would these tests fail?  Do we
need a prereq to skip them?

Thanks.
