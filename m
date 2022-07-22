Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A929C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 03:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiGVDPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 23:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiGVDPU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 23:15:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8071113E0E
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 20:15:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q43-20020a17090a17ae00b001f1f67e053cso3082658pja.4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 20:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DKct5WpRgQcqWLcrZqgQDiiJ9ors4yxshJNQ8sT4fyE=;
        b=bTba3/nvWvBKOdYxmsgI24UBpSGrUDMYgPmhQ5lG1HdcYk/sp30TPjFSbBIAt7oUeK
         1FPox+RKzpCKcHdbrHbNuW14IeaN3IYk5NJqFe8U8qjUxDBTMd2tRypJu3RwJGg/FmMH
         dQ1ReaceCpdzIFDh/pjKapngR1CdR5m+5/QSvd3Tl20o1+NLj3GKTkGnW9cUW2porvI5
         Q5EgeIyg4XdqJJ6I/huLXcXfQ+wRgqQWFIi9eV6l018lRK8L2bVje9BkLnEK/Aw80AUy
         nO+WdjRqdFGs/veudBbxRLoEWcLMf6FRgDmRnv9+QH7/5eB7s1xcwLDkG7XylgFmlPHL
         4kRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DKct5WpRgQcqWLcrZqgQDiiJ9ors4yxshJNQ8sT4fyE=;
        b=oygajeUa3IcWaYUGZMZGjqaKFIKSkdggUxIEAj5IWhamSNFcj4yW8Dbqi+L/e6HhVd
         w64sw9PNLeoRpkukPpXxJrCM7LM1buWNaKealI3JFb76Vd1gN0MvhXzsHZH1+hr9brGc
         t0zGDNnNALNo+k/tuoGjzzHLAdQw3UohPgStrpo5zmLSnlTSTPR5YWJX9ODBHYIgiZUD
         LKzxC5sX2nQKeRW6Y3C+LQiXHikTABEcKHwjIlGDIbQmmWBAviZBAxD92cs0/KSmOOD2
         hkcNzcU9z3v/nncNrnyPIEZvM2YRhcK66aRctTyiPAbB7C1i0OKvvfo/3EssGpwzLENx
         GhFQ==
X-Gm-Message-State: AJIora85U8t4t4/BeDH/YlHXnRXdApplIVzA5lCV6IVAvK7DNEyIYoof
        lUndZ435bBNl3Bu9WP2wgyuBCPuc5XI=
X-Google-Smtp-Source: AGRyM1sEp0x2EaIlMWMVx5cE9HvEaZg3J6LZTPpS5EhBAUd/cprUU2mgYbCIkZLHWd21IIWV6RBY8A==
X-Received: by 2002:a17:902:cf4b:b0:16c:4634:72 with SMTP id e11-20020a170902cf4b00b0016c46340072mr1354607plg.15.1658459717856;
        Thu, 21 Jul 2022 20:15:17 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-26.three.co.id. [180.214.232.26])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902868d00b0016a17da4ad4sm2416312plo.39.2022.07.21.20.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 20:15:17 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E142A103808; Fri, 22 Jul 2022 10:15:12 +0700 (WIB)
Date:   Fri, 22 Jul 2022 10:15:10 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: On-branch topic description support?
Message-ID: <YtoWPvKVSa++W6NX@debian.me>
References: <xmqqilnr1hff.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilnr1hff.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2022 at 04:40:52PM -0700, Junio C Hamano wrote:
> I've been playing with this idea from time to time, but recently I
> started seeing a related discussion on the b4 front, so I thought I
> would throw it out and how people would think.
> 
> We made "git merge" not to silently commit the result, but open the
> editor to encourage the integrator to describe what the topic is
> about.  We also made "git format-patch" prepare [PATCH 0/n] aka
> "cover letter" so that the author of the patch series can express
> what the overall topic is about.  What the author should say in the
> cover letter very much overlaps what the integrator wants to have in
> the log message of the commit that merges the topic to the
> integration branch.
> 
> But there are two (and half) links from format-patch to that merge
> commit that are missing.  
> 
>  - You cannot prepare the cover letter material while working on the
>    topic---instead, you have to write one by editing the output from
>    "format-patch --cover-letter";
> 
>  - "git am" at the receiving end discards the cover letter when
>    queuing the e-mailed patches to a topic.
> 
>  - "git merge" cannot take advantage of the cover letter that was
>    discarded when the topic was queued.
> 
> So, here is how I would imagine a slightly better world may work.
> 
>  * When you are almost finished with the initial draft of your
>    topic, you'd write a cover letter, and record it as the log
>    message of an empty commit at the tip of the topic.  As you go on
>    polishing the topic with "rebase -i", the empty commit would be
>    kept (if we currently lose an empty commit by default, we may
>    need to teach "rebase -i" to special case an empty commit at the
>    tip of the range to make this convenient to use), and you would
>    keep it up to date as you update the topic.
> 
>  * "git format-patch" would notice that the topic has such an empty
>    commit at the tip, and use the log message from it to
>    pre-populate the cover letter.
> 
>  * "git am" would learn an option to save the cover letter [0/n] and
>    create such an empty commit at the tip of the branch.
> 
>  * "git merge" would learn an option to recognize that the branch
>    being merged has such an empty commit at the tip, and instead
>    merge the parent of the tip of the branch into the integration
>    branch, while using the log message of the discarded tip commit
>    in the log message of the merge itself.
> 
> Yes, there is "git config branch.mytopic.description" that helps
> when pre-populating the cover letter, but that only helps at the
> origin, and it is not shared between your personal repositories.
> If you have the draft of the cover letter as part of the branch,
> you can push/fetch them around just like all the "real" commits
> you are working on.
> 
> Regardless of where the cover letter comes from, the changes to "am"
> and "merge" dreamed above in this message would be useful, and that
> is the primary reason why I am envisioning that right at the origin
> having the topic description as an empty commit at the tip would be
> the most convenient.  It would match the shape of the history at the
> author side and at the side who runs "git am".

Thanks for the idea.

The alternative would be "commit groups", which are named and annotated
range of commits. The group description can contain cover letter
content. This way, integrators can still have a description of merged
commits without having an empty commit. Commit groups are particularly
useful for rebase-then-merge workflow, where topic branches are rebased
first before being merged into trunk.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
