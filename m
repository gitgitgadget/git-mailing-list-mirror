Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA4FC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 17:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E6461166
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 17:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhIUR7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 13:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhIUR7w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 13:59:52 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F71C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 10:58:23 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s18-20020a05620a255200b00433885d4fa7so721693qko.4
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IcLWVND36dcZ2nA/mXFdjFxHOBp5rhkoEAig2Pfc8iU=;
        b=s9ww4L4dISf3S7QcwVhMEi/kglzas/3XcXZnML6ZHdwEoyUhsthLERXmY5mXFuH1VH
         eniBcJ+nd+0Symnd12ixn5ECXVvxe4xdOgg/kVHq8urbGtEUMm1xZG8+RwtrIMxjGZ/I
         MenygG7AiT/1G77fO/zg6AubcJ+iu2xbWP8q6JyVjdbj+l0nQ3+xVCnH+b4qtggLob1S
         mmbreyDbiSyChyHUHtD/zk8bVAi7blRNdbwPn08wuCy4rbqzyqCluLie0+RIllaUVxU6
         aLegyrjSEZ0rE08UwJhnBgmqDE0UqEvOPN1PPCMjgCohmNgWAD94A7AeimoDhY8ZaGtY
         cKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IcLWVND36dcZ2nA/mXFdjFxHOBp5rhkoEAig2Pfc8iU=;
        b=5YnrYK2LKdKIAS11f8L4MNNgWSk0Et6tJ4Ckpl7j/VvYOFePtc3KCIZ9Z0US6YRNSY
         5J3qQMD+cxWYeLc81wgudlUi1QhSXh28kEk1MaPCxRoCOEcUG6GID4yWLzetBnFZIV8t
         oloB9TEAuBh7k9g9FqLbDraZ9/4Tkehri29X9S2exqeUfVtMCUPQoLA/munT3uTAVUVc
         apcQfhkhjHdKAjlS59ba9iw8I0fRhgWZarekdw/99I7dudOrqrK+0ZhgoPKhhQcfh6Ys
         bJ5KvldaX8vXt/BiepOauLgSrO+5213ZONoN3FR5V9koeU1KpC7A9c4f6rUVWPLhb/8P
         Q7VA==
X-Gm-Message-State: AOAM533kSlRapCP9WU8x0HWGO4e5uizOgRMl+pqkMvBOYxgKbTwQR3TT
        g/YPxChSt2PRa65Skq5t7Lw1WFUWuKWcBA==
X-Google-Smtp-Source: ABdhPJwWxTtV9bus+FjViK0HrEYzGxoQ4jjDoODbhdRjI7Wx7x0qLljtNGJlYiqeB9esemGMwlDJbJWrCxCW1w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:ad4:5629:: with SMTP id
 cb9mr32735413qvb.53.1632247102725; Tue, 21 Sep 2021 10:58:22 -0700 (PDT)
Date:   Tue, 21 Sep 2021 10:58:21 -0700
In-Reply-To: <00f94ddf-7019-a5e0-8fd5-a88a4b1cc5c3@gmail.com>
Message-Id: <kl6ltuidlsjm.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210913194816.51182-1-chooglen@google.com> <20210920223226.25877-1-chooglen@google.com>
 <00f94ddf-7019-a5e0-8fd5-a88a4b1cc5c3@gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: Document --range-diff option when
 writing v2
From:   Glen Choo <chooglen@google.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

>> +We'll reuse our `psuh` topic branch for v2. Before we make any changes, we'll
>> +mark the tip of our v1 branch for easy reference:
>>   
>> -When you're ready with the next iteration of your patch, the process is fairly
>> -similar.
>> +----
>> +$ git checkout psuh
>> +$ git branch psuh-v1
>> +----
>>   
>
> Alternatively we can branch off psuh-v2 from the original psuh:
> ----
> $ git checkout psuh
> $ git checkout -b psuh-v2
> ----
>
> The original psuh thus become v1. To easily identify it, we can run:
> ----
> $ git checkout psuh
> $ git branch -M psuh-v1
> ----
>
I proposed to reuse the topic branch at the suggestion of Junio.

 I do not think it is a good suggestion at all to use a new topic
 branch, especially a one that forked from the tip of the original
 submission, and work on that branch to produce the new round.  It
 would be much better to create a topic branch or a lightweight tag
 "psuh-v1" that points at the old tip and keep working on the same
 branch.  But that is a separate story.

Your suggested workflow is acutally fairly similar to the one I actually
use. To keep this doc clear though, I think that we should probably
propose just one workflow.

> For completeness, we can say "Make your changes with `git rebase -i`. 
> Actions that you have to select in the todo editor of rebase depend on 
> reviewers' comments. For example, if they asked to squash a commit into 
> previous one, say `pick` on the latter and `squash` on the former."
>
I hesitate to add a "rebase -i" tutorial because this document doesn't
contain similar tutorials/explanations for any 'regular' Git workflow
commands; the explanations are generally focused on mailing
list-specific commands like "send-email" and "format-patch".

It seems unlikely to me that an aspiring contributor to Git would be
unfamiliar with "rebase -i". It's not the most simple command, but it is
common. In fact, because it is not so simple, it seems unlikely that we
would do it justice in this document. For those who need it, additional
reading on "rebase -i" can be left as an exercise to the reader.

>> +The `-v2` parameter tells `format-patch` to output "v2" patches. For instance,
>
> More accurately, `-v 2` marks the patchset as second iteration of it.
>
Good point. I was stuggling with how to word this paragraph. I'll work
that wording into this line.
