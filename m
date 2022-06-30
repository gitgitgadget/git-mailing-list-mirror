Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC39C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 20:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbiF3Ufv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbiF3Ufu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 16:35:50 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399E4393D5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 13:35:49 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 196-20020a6300cd000000b0040c9c64e7e4so169889pga.9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 13:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qQzzkHGlWRiYrSjP0AKQMjtROQDmJ7B2++R1Fkpz4nM=;
        b=dE34lNKSNPyqHIhXZx7lLJ8qdAUv30xn+TydISPaJa3ydMBRVPsAQI2j1Ym1mGJ5zy
         JT2STmevEC4004V3CUqtmzaMLTPyi+qFLvRr4oDEeIHTSjHIMP7SfNkTP95edGrqY/jY
         yk5g7u2Rd5Vsv/pcivVDF+FP1vdbdTpXCD39cvC0WNaDWx2ezJwn3s5DO4+yZMmGdlk3
         PRp2F+fH+5fp/ff0/aArqyNgE6EkMGfGfSFDkqQd9cWwcZdhVvvVzP3jn1DpJCN1kLpY
         2ofxkNiC60GSjFoOH6kbLZt/GMm7juTu9sL0fIMUfvmTiBpbxnLil/PvwFuEj2NuLteu
         O+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qQzzkHGlWRiYrSjP0AKQMjtROQDmJ7B2++R1Fkpz4nM=;
        b=7rvgbpheixDapxTMpyxL4Wmyaep+uvwOqXXvoGcljzkBHK7/3A0BhX4+9gxZcyzkE6
         s35ZyYa0eG/JhtDy9+s1DIOZYlljW7FGm/q0rNrOHGK3MQr+plxYtIRlarczFqgknITP
         VBc187HtqvsWSY6EbBp+WtjXD+A1Rsf6otvIvNBOqYA7GXdW6rwK/f7aVZrWj7PanRbJ
         05XDVYxRB8+CGh0GHrxJJpI2dgW36f0AIoToejuSF5PEz76qzU8Qb0hsVsVFcLQ2HHUd
         jGbx5FPrtzoG5dERyrwDXqkP6+yOpE9EAaEORAv1dbtkvLj0otWNb745CVWxpiZ/Szmg
         ZEgg==
X-Gm-Message-State: AJIora+burj3jc+P/guy7XMWth8qjy0HN2kLAwEWf+ChD0fVHlAscAGg
        PoqagWNcogqeDKnQZ7sK21Kkyc29Bd+PCw==
X-Google-Smtp-Source: AGRyM1s5wryVVGtpn5RJz+GNnxn8aUNgPc3bNfq1sAy+r3ZLjEGxSk2NsupnkUvSzjIA+CbaOy7nHof/LPu5XA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:1360:0:b0:410:702f:d1d4 with SMTP id
 32-20020a631360000000b00410702fd1d4mr9003686pgt.625.1656621348769; Thu, 30
 Jun 2022 13:35:48 -0700 (PDT)
Date:   Thu, 30 Jun 2022 13:35:47 -0700
In-Reply-To: <20220629224059.1016645-1-calvinwan@google.com>
Message-Id: <kl6l35flubx8.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220629224059.1016645-1-calvinwan@google.com>
Subject: Re: [PATCH v3] submodule merge: update conflict error message
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, levraiphilippeblain@gmail.com,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi! I have a suggestion for the output text; I haven't looked closely at
the code changes.

Calvin Wan <calvinwan@google.com> writes:

>  Changes since v2:
>  [...]
>  Changes since v1:
>  [...]

I notice that this is all above the "---", i.e. this becomes part of the
commit message when "git am"-ed. Intentional?

> If git detects a possible merge resolution, the following is printed:
>
> --------
>
> Failed to merge submodule sub, but a possible merge resolution exists:
>     <commit> Merge branch '<branch1>' into <branch2>
>
>
> If this is correct simply add it to the index for example
> by using:
>
>   git update-index --cacheinfo 160000 <commit> "<submodule>"
>
> which will accept this suggestion.
>
> CONFLICT (submodule): Merge conflict in <submodule>
> Recursive merging with submodules is currently not supported.
> To manually complete the merge:
>  - go to submodule (<submodule>), and either update the submodule to a possible commit above or merge commit <commit>
>  - come back to superproject, and `git add <submodule>` to record the above merge 
>  - resolve any other conflicts in the superproject
>  - commit the resulting index in the superproject
> Automatic merge failed; fix conflicts and then commit the result.
>
> --------

I'm hesitant to recommend a plumbing command like "git update-index" to
the user, especially if the user is one who needs help resolving a
submodule merge conflict. I also believe this would be the first time we
recommend "git update-index".

To do this using only porcelain commands, maybe:

   git -C <submodule> checkout <commit> &&
   git add <submodule>

(Though this might need to be broken up into two commands because I'm
not sure if we ever include "&&" in a help message. I'm guessing we
don't for portability reasons?)

> If git detects multiple possible merge resolutions, the following is printed:
>
> --------
>
> Failed to merge submodule sub, but multiple possible merges exist:
>     <commit> Merge branch '<branch1>' into <branch2>
>     <commit> Merge branch '<branch1>' into <branch3>
>
> CONFLICT (submodule): Merge conflict in <submodule>
> Recursive merging with submodules is currently not supported.
> To manually complete the merge:
>  - go to submodule (<submodule>), and either update the submodule to a possible commit above or merge commit <commit>
>  - come back to superproject, and `git add <submodule>` to record the above merge 
>  - resolve any other conflicts in the superproject
>  - commit the resulting index in the superproject
> Automatic merge failed; fix conflicts and then commit the result.
>
> -------

For consistency, perhaps include the "here's how to use the suggestion"
instructions here as well?
