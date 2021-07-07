Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9ADC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 18:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D03461CCC
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 18:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhGGSuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 14:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhGGSuY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 14:50:24 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB028C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 11:47:43 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id l26so4536490oic.7
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=GMoBOkVhVnGXFOOCnbN1epXHYvjNp20jyE7ttUTp+X0=;
        b=MxsWhyioExkYnGPyI4UvmBzZsr/pGbcvvb5AWeDnOkc9R9znBvGJeJkIvNLVcYr/X4
         2afl7mkBySqCenXv+kNa7pierG3qaEK19uA6ZNhTOYA82y8781EI8ISDNMQDz41GpG4h
         oojr4zYhiV9gwrGVuf8J5yrkP1EVci87GmRs3eHqq63GZzytJRNtVxmSVvF9LtkwvGZI
         ITkVtgO3Bg2SkviQFHAl2p9utJH3RNxbWcxXqMMT/E+fQ2K0rSwAzx3WZPIZYPvcNuXU
         lbmwvvEWcOqT3jb7DXSoswRoey4NIfA3Y+Bot9KrE2oXgJBPB1GKLNGEy4gd2a+7S4Oc
         pO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=GMoBOkVhVnGXFOOCnbN1epXHYvjNp20jyE7ttUTp+X0=;
        b=UlB7EE7OYMszeKy1xyonRSzOukyfk78EiHJt9NhlnY/9QGEZZETTQmbjlFLyuaijk2
         pHLC3spoDJcv4tIwtQAnRy1G8ltXILhB2RHZcFtHoxJYVWUPm6NIGPFQxJbsecNB79ux
         oSCgk0FO5BndqPRcQkXgTMoc5vgXSZhvw+UpSlUhP6WBD8j4qADWRn60axTD7IMIhLjG
         +2h2yJu+yRlSxLVdnYSNhqvRHGdu2GY9HK4EZYmMcuefwXQ5HkUJ3VncmboHm+GhT9cs
         3khp88Q2wJpvbC61SWBYdip++6EYr8YcL5B297w8ZqVokH1ZvSrOWpY5AbklZMkxFI7A
         wqtg==
X-Gm-Message-State: AOAM532Z37fwbUcNg8MuW2hWy96zup7/i3L3zvtSZIcYtP9Atbw2ToQO
        ML0OWQecYN/cgU/nHhcobPc=
X-Google-Smtp-Source: ABdhPJzElNz+nqutZ/6KQVpAYs2wcZMRdt2DvvJVZCxz+OyeootTKBXMn1gRoAIokdpmB368ZJevqg==
X-Received: by 2002:aca:cf02:: with SMTP id f2mr386783oig.131.1625683663173;
        Wed, 07 Jul 2021 11:47:43 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id a206sm171874oob.31.2021.07.07.11.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:47:42 -0700 (PDT)
Date:   Wed, 07 Jul 2021 13:47:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Martin <git@mfriebe.de>
Cc:     git@vger.kernel.org
Message-ID: <60e5f6cd6afa9_3014372088c@natae.notmuch>
In-Reply-To: <xmqqh7hersgp.fsf@gitster.g>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <xmqqh7hersgp.fsf@gitster.g>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Martin <git@mfriebe.de> writes:
> 
> > Anyway, can we agree, that there are people who (mistakenly)
> > use/understand "branch" as including the objects?
> > Enough people to call it a "common mistake".
> > If so, then we should not ignore this.
> 
> I do not think it is a mistake at all.  In a history where the
> branch B points at commit Z, we do say the branch contains commits Z
> and Y and we do say the branch does not contain commits X or W, for
> example.
> 
>                  W---X
>                 /
>         ---o---V---Y---Z
>                        ^ we're here (branch B)
> 

There's a difference between saying the branch *is* commits A, B, ... Y,
Z, and the branch *contains* commits ...

In Git only the latter is true, because technically the branch is a
pointer. But in Mercurial both are true.

> I think the source of the confusion is the <start point>.  It does
> not change what the explanation wants to say at all if we changed
> it to <end point>.  It is where the branch's tip ends up to be after
> "git branch -f" (or "git switch -C") finishes, so it might even be
> technically more correct.

Indeed.

However, there's a better alternative than "end point": head. Sure, the
unfortunate naming of the current branch as HEAD makes this slightly
confusing, but that's really what it is.

If you change the branch head *everyone* understands the the branch
itself is changed, and the commits that are part of the branch are
different.

-- 
Felipe Contreras
