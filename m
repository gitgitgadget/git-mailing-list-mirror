Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22C4C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 22:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiI3WCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 18:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiI3WCj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 18:02:39 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D4018F422
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 15:02:38 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 88-20020a17090a09e100b00208c35d9452so2934431pjo.6
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HR51z6CP3+IRQsPHjyKq0/ye5T/awhK4App1R9DJkOw=;
        b=q0F7K2DWnW78541qPW/+h6WSx82z5ksPUNtwjcO25D2Nsj2WC8Hc94yK3cpwsd3+QJ
         Xrgn9ULIdTe1mar+S+0rX+NYPZLW1rbwsLHpShuBFqJZTaBgWmjSoX3GQzV2RjvyCxub
         QFDgddNhF9+AQ8BZl1YXNz9zkW+HgIkcl/9OkLYSSj9sEQbgIfoDsVpmwrrT3KRgRN5u
         Hbini2/DXtzfij6kgPxuiCREwq7ZLeOM3LDB6FsEHU0C2UiKHcjIj6kY2LDsMeq43Xsj
         nYLWjqUl7p4VYkuUf/tyYwYWmaZRUVW2xOM+CmqJ/19HNZ6E75jn0GOYQqrVfn72xqAy
         hY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HR51z6CP3+IRQsPHjyKq0/ye5T/awhK4App1R9DJkOw=;
        b=q9PxR5tHrpvmWwQ+jpdz2Lhal7g8ZrvKMJibATOA3S04JAXy0VHzlO0VJwy8vXyfyZ
         hpls9ZwtIhGJT5YRw2xMzYXILKFpS81Jw7kh6EQWZNSwNID1/dea8GabSD5d+hULw3MT
         K1jDUBucpPqNYldDB/PwbKFd9botgNqJJ+7YWZeGdv33rYZi8JyAkOaY0Ez+jINUPaH+
         Vi0Xy4otVveRU7m7Eb+UlzEcqTX+G037JjxuNRqDWiNazYAQWkS3f5kVgMDZMaK7p0mk
         7JJTt4HzvRaVWin4cSkg6TwTxGiUTqoI47tRKI08DMfyq8Rlc+d4lDOLkyQd5VT+QHNs
         JEDg==
X-Gm-Message-State: ACrzQf3tLGZrCR5Vjjed/5BkscSPmRcDIWD9cq7+HGAvof0wZiiu7RRx
        JH+tC1CzLNngrmcobN7G4nqdfXUNpg6tD09ghZD5
X-Google-Smtp-Source: AMsMyM6uL0SbITi+yS4JAOpKXc3/lOvtViHwWDN0ZSUIVj93I9WtJJzAyk0ePung1RPZBNgq/QWNCIyTAKqv5jeWVdG5
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:eccb:b0:178:1313:afa1 with
 SMTP id a11-20020a170902eccb00b001781313afa1mr11100061plh.97.1664575358150;
 Fri, 30 Sep 2022 15:02:38 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:02:35 -0700
In-Reply-To: <xmqqmtainfw6.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220930220235.2080522-1-jonathantanmy@google.com>
Subject: Re: [PATCH 1/2] promisor-remote: remove a return value
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > No caller of promisor_remote_get_direct() is checking its return value,
> > so remove it.
> 
> The above is a good explanation why this change will not hurt the
> current users, but is it a good thing to do in the first place?
> 
> Isn't it an indication that all the existing callers are sloppy?  Or
> does it mean that the value returned from this function is not a
> useful signal to the caller?
> 
> Looking at the implementation, the function seems to want to
> indicate if the fetching succeeded (with 0) or failed (with -1).
> What is curious is that the function seems to consider it a success
> even if some requested objects were never downloaded after
> consulting all the promisor remotes.  There is no way for the caller
> to obtain the list of objects it wanted to have but the function
> failed to deliver, either (other than obviously redoing what
> promisor-remote.c::remove_fetched_oids() does itself).
> 
> Are these what makes the returned value from the function useless
> and the callers ignore it?  If these are fixed, would it make the
> indication of error more useful?
> 
> Looking at some of the existing callers:
> 
>  * builtin/index-pack.c calls it to fill the "gap" and after giving
>    the function a chance to download "missing" objects, goes on its
>    prosessing as if nothing has happened.  We will properly die if
>    any object we need is still missing, so unless we are interested
>    in failing early, checking the return value of the function does
>    not help all that much.
> 
>  * The caller in builtin/pack-objects.c is similar.  We have a list
>    of bunch of objects we want to pack, some of which may be
>    missing.  We ask all missing ones from the list in bulk before
>    doing anything, but we rely on the regular codepath to notice if
>    the promisor remote did not give us necessary objects.
> 
> I didn't look at others, but the above two are probably OK, unless
> we want to get a signal to be cautious about poorly managed promisor
> remotes.  

True - in all cases, we either fall back to a code path where we try to
read a single object (if promisor_remote_get_direct() was called by a
prefetch) or the same code path that is taken when a non-partial-clone
tries to read a missing object. So it's not fully clear what's going on,
but it is safe. I should have added a note about this in the commit
message and will do so in the next version.

> Not distinguishing the reason why we do not have objects
> between a corrupt repository and a promisor remote that breaks its
> earlier promises makes it impossible to say "hey, that promisor
> remote is failing its expectation, perhaps we should wean us off
> from it".

I'll add a note that in a subsequent patch, we will add a message that
can indeed distinguish this case.
