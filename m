Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7965A1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 19:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfGATUF (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 15:20:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44197 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGATUF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 15:20:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so7019100pfe.11
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cLHmBHQX4icPHyiFpVOrlxSgzNl5OrkuXzZXh+45vbY=;
        b=skWMyDEz7TRjH38eHyqllVf+sBYS/yuaRqJ96HrQh5Sy1P+fNKK28x0y/SXCEMrmSJ
         kuOby9FNgOi6iu+9Ul2cIxc9bgMDDaAWfttAjOBu9hregIeS7DbBpUeR4ICRvUYHpDtO
         eGYrnyGHTIYFtC99gQFyC9gMJs74Kdfz304pb81IBYHE/MNUTt+JYJHyXJeAfLkFLnPh
         OdYH0yhasYfUY3Ai1zhAtpndd6ZIqBiaOyAZnBNTaeSY/+mNB/7CQgaxuqu84SqIic7X
         8iDOiVeaEwWcyKDKK/yFBqjB3LkS975OYMXzyBqhlTDPzROTXWLcj5+6uOu3m0ssXbdn
         wsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cLHmBHQX4icPHyiFpVOrlxSgzNl5OrkuXzZXh+45vbY=;
        b=WHc45drck8RSG0Sjkjx++vzjVPH7/RlCZG/86cv6m1UhV7kdPIUpx5FjMl2qK3U+Lo
         xl0wtRCRbVjXmXT6I3Da0bKL3Uk4/JESCMo2JaEOyKYPqm5q9GwXMMC0qcl2KdzKebYs
         WUVxZrJhndlA7aCsYbgTcVWys2ZjNXWqFgrGoNFHFCNZkHHrjrD64thcYOrUBtevYGcJ
         NPHAGbKgmAl0en6Zlxd2Ut3zYHb9PU4xZOB13LdnR72YLj3SyUxfMVYOuMqN+fIBFykN
         89gMdPaj/o6FlNVYx6owEXF4bq12cMcCbDUpdW/5Pm2+0aRSRZ8gg0y2nZKhV0kY8gKl
         fgHw==
X-Gm-Message-State: APjAAAVVq2ChSGiARJSP3iXho6e+/Jf4ycGTD7WFxCcbTauawKnJipIH
        x0pryNtTS2KO/NJTtQslUqRktzg5p+s=
X-Google-Smtp-Source: APXvYqzHOksVxx1GSC+aLtrvaNdh6gSWskq2Un0EH8FIMA7FTkj9p4SiFtz5SIFwvE4907FOFChjmw==
X-Received: by 2002:a63:490a:: with SMTP id w10mr25906273pga.6.1562008804049;
        Mon, 01 Jul 2019 12:20:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id k22sm15681744pfk.157.2019.07.01.12.20.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 12:20:03 -0700 (PDT)
Date:   Mon, 1 Jul 2019 12:19:59 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH v2 10/13] walken: add unfiltered object walk from HEAD
Message-ID: <20190701191959.GK245941@google.com>
References: <20190626235032.177551-1-emilyshaffer@google.com>
 <20190626235032.177551-11-emilyshaffer@google.com>
 <CAPig+cR7rHokaTtZcJJg8trJ14xO3hdeWHqLnB4aOnEUak051w@mail.gmail.com>
 <20190627223110.GH245941@google.com>
 <CAPig+cRB2=3j6BfuU00YWj1iSMi0qxE+0P7LCXHMtYpWdgam-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRB2=3j6BfuU00YWj1iSMi0qxE+0P7LCXHMtYpWdgam-A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 08:48:31PM -0400, Eric Sunshine wrote:
> On Thu, Jun 27, 2019 at 6:31 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > On Thu, Jun 27, 2019 at 01:37:58AM -0400, Eric Sunshine wrote:
> > > Don't localize the die() message via _() here or in the preceding
> > > OBJ_COMMIT case.
> >
> > I'm a little surprised by that. Is it because die() is expected to only
> > be seen by the developer?
> 
> Sorry, I was reading those as BUG(), not die(), and we don't localize
> BUG() text. But, why aren't those BUG()? Can those cases arise in
> practice? (Genuine question; I haven't familiarized myself with that
> code yet.)
> 
> If they legitimately should be die(), then ignore my comment about not
> localizing them.

Hmmm. Yeah, I'll switch them to BUG() - I think there are other
instances of die() in the example and it'd be good to describe yet
another way of reporting behavior.

> 
> > > The two die() messages are unnecessarily dissimilar. Try to unify them
> > > so that they read in the same way.
> >
> > I'm a little surprised by this too; it seems to me the root cause of
> > each would be different. In the former case, I'd guess that
> > traverse_commit_list()'s behavior changed, and in the latter case I'd
> > guess that a new object type was recently added to the model. Can you
> > help me understand the motivation for making the messages similar?
> 
> Both causes you describe here sound like BUG() cases, not die(). If
> I'm understanding correctly, they could only trigger if someone made
> some breaking or behavior changing modifications within Git and failed
> to update all the code in the project impacted by the change. In other
> words, these can't be triggered by user input, hence they would be
> BUG()s indicating that a Git developer needs to fix the code.
> 
> As for the messages themselves, I was referring to the grammatical
> dissimilarity of "unexpectedly" and "unexpected", and I also don't
> understand why one messages mentions walken_show_object() explicitly,
> whereas the other does not.

I see - ok, I have reworded.


Thanks!
 - Emily
