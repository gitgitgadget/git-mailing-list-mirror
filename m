Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF432C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 08:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378929AbhLCIVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 03:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbhLCIVX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 03:21:23 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F40C06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 00:17:59 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so4554253pju.3
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 00:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zn4McF2kmuYO7vWRGAGcJ3bwtBZkXxIdHhkkqYkf9BU=;
        b=jNoAw3b9ikUedB+FH82JkW+yE26oU0M+7eAURn1SIgyVeNC+Mxd/uOtlYVqvMKuGuw
         q0gejrESUJcKTp1DAnvlabox3jxhtCKQtL8+FsKGfBlNMghx8prCpakxskh5/PfjY7um
         wAVA8Ye3ACjYfj0/sZXvi/jfCSJMmet6uKkF/LpX2ZcM74SezoCR2A54VD5pFrDZtovf
         Lj8KnKCfWyvGa07UurAnBJcdIvKMTuEKMZ9IzQFEiMllpMyalsYuQXEuPC9WeAQg/NU5
         MBDMMIqftrDIgJKIILNAw1hAo2h1sX36dYGCIQg09PaOJ//oXbrvwTabqcJZzHM7tuy6
         vJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zn4McF2kmuYO7vWRGAGcJ3bwtBZkXxIdHhkkqYkf9BU=;
        b=2g3JZZGJ3r3lF8G8fpI4VGN0eDNH6RSiIqSnn5NMfn8PXLvaVIjJQ+Q5XXPcsCo2Th
         W38j7sSMDq5GtY6hAm+q36jvxNjcZQhqerzlNjlhD+OqgF9sVe24yU+/Q91xuuzJZrJl
         YZnTxxf7LA/VyIyo5bcfMJOIh/PbaEZUQ+V/NBYyDWLMB9dSW3dQYN2EIF0fGe5/D31O
         80PnFrHBMmU1DM7xMmUskaEpyjA+fL2JrW7pY5Ac6RULMpsu2ltivYxOWwG9F3Dy5Y++
         Uvu7YaSakV3F1ugLxoshtecOrrtwcKpiIUMkNVfxB797ie/K2Ybv4Jl0lxmM7Ky+rx7R
         q1uQ==
X-Gm-Message-State: AOAM5311ZNEfUvI6OHIYjLd7WFHrJZZZ3CKqLU3oji5IKvUfYbQWyeRB
        SXyMEyd3I+EdnuRYFePW/90=
X-Google-Smtp-Source: ABdhPJzd4fW1gOgjF+37bo9saN3OHR6D7ozGEWIzA792WIqjjYFjjZbu+4qQE5+YwHIP7/Nq9TX/jA==
X-Received: by 2002:a17:903:410b:b0:142:497b:7209 with SMTP id r11-20020a170903410b00b00142497b7209mr21514518pld.9.1638519478826;
        Fri, 03 Dec 2021 00:17:58 -0800 (PST)
Received: from LAPTOP-FJDAS7G4.localdomain ([157.40.200.193])
        by smtp.gmail.com with ESMTPSA id m3sm1680806pgj.25.2021.12.03.00.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 00:17:58 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [RFC PATCH 1/1] push: make '-u' have default arguments
Date:   Fri,  3 Dec 2021 13:44:46 +0530
Message-Id: <20211203081446.17596-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <xmqqbl1yvpa0.fsf@gitster.g>
References: <xmqqbl1yvpa0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> Taking all together, something like
>
>    "git push -u" (set-upstream) requires where to push to and what
>    to push.  Often people push only the current branch to update
>    the branch of the same name at the 'origin' repository.  For
>    them, it would be convenient if "git push -u" without repository
>    or refspec defaulted to push to the branch of the same name at
>    the remote repository that is used by default.

Thanks for the guidance. Improving the cover-letter and commit message
now. :)

> Do not invent an undefined word "short name".  The name of the
> 'main' branch is 'main', and it is not a short name.  When people
> encounter multi-level names, like ac/push-u-default, use of an
> undefined word "short name" will mislead readers that you meant
> the leaf level, 'push-u-default', but I do not think that is what
> you meant (this is not the only instance of "short name" in this
> submission; all need to be fixed).

Sorry for that, I was referring 'branch->name' as 'short name' (and
'branch->refname' as the 'long name' :| ). Will fix it.

> One thing that bothers me is that unlike your assumption, not
> everybody uses push.default set to simple or upstream.  I am not
> convinced that the "git push -u" that defaults to do the 'current'
> push with TRANSPORT_PUSH_SET_UPSTREAM for them is an improvement
> for them.

May be you're right. It may not be an improvement for all. But I
think they also would be happy seeing this 'default' case of 
'set-upstream'.

> If the new feature does not kick in for them, that should
> be explained in the proposed log message when you sell the patch to
> reviewers and documented for the users.

Ok.

> This makes it sound as if the push will only affect the current
> branch even for folks who use the matching push.  As I said, I do
> not know if that is desirable.

Yeah, this only affects the current branch. In that case they may
not use 'git push -u'. As you said previously, this would not be
an improvement in this case ( not a deterioration also).

> This does look like it breaks unless the user is a novice without
> custom configuration.  For example, if the current branch has a
> configuration to integrate with a branch at the default remote of a
> different name already, this (1) clobbers the tip of a wrong branch
> by pushing to it, and (2) overrites the upstream configuration.  If
> the user uses push.default set to 'current' or 'simple', this would
> be OK, but for all other users, I doubt this would be an improvement.

I don't think so. When an user use '--set-upstream' in push command,
it means he/she want to set the upstream to a different branch (if
the specified <repository> and <refspec> are not same as the current
one) rather than the current upstream branch (if exists). So, I think
it would be safe for '--set-upstream' to have default values. Isn't it?
If you are fearing for those two points you specified, should we add
a safety permission before proceeding? e.g. like this -
 
     this would change the upstream branch "%s" to "%s" for this local branch
     would you like to continue? [y]es [n]no

> We may want to future-proof by checking the current tracking info
> (or lack of it) before doing "git push -u" here?  You cannot control
> what other developers would do in the future to tests before this
> one.

Oh yeah, you're right. Will surely add it.

> Various settings of push.default is probably a good place to start and
> with or without existing upstream info already set up.

Thanks for the suggestion, I will add more tests to address these things.

> Thanks for working on this topic.  I suspect that the implementation
> and design covers too broadly to hurt some users while helping
> others, and needs tightening up to fix that, but I think the users
> appreciate the part that helps some users ;-)

Thanks.
