Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94AED1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 22:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfF0WbQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 18:31:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33277 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0WbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 18:31:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so1930097pfq.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 15:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fSNDeL//oF7NM/drtnDubQWgiqJOOlGYKqNmkQhQ1sA=;
        b=JKMBI/VnOlVg0/+JSwdgYxV512p9efAhoTb7bH+jrDxIo+YYUoXwg8/8RM8fn5tM2b
         7DXE2VKtK6DaXLcpvxDIihNpErlRiQIQ/DGSEBDVToH7Y6/NnmFgn6du03dHP1InXZxi
         DZ7Nm03NDHVT8j5K462e+z7Z9ltSlVT3aJaDYnJHXMc9bSNEgZxEl9IHis5DYrbUyR0O
         mBqtG26PMGmYGXL/E9bGlCK3MkeSy1rEHpw8N3iUFOuvpITpgBdeY+i1cwla3/DlaQKJ
         gumV3m6piSbVs5/PsypxyciUhmPFHQAfRMKIfl3w+mRN3U53rSefbUJr/5DwP3XibwSq
         6Q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fSNDeL//oF7NM/drtnDubQWgiqJOOlGYKqNmkQhQ1sA=;
        b=j7J/jAwfqmiu2M+rOahsmH99ec5rcx9g24MGU89Ex57u8KFPnpwCpg81nx1BswzB+T
         x5rqj1tepa03+Uht90LovGZrdxTprJrH9kdh60dSCCjEpCR795unXFN98c/BSRe5FRaj
         s9j2S0JP1Hq3a6nas4odJk9ap4ew25jrgXyCHA3b2G+iFtiu7VzLaVKLogNTRl1+Bqh1
         V0E3OfR6EUvj5m1zJyGdkr6Dw+uk17lyRcm8usI5qWUgU4R0idSEFrwiFsvsBmtTZ5sW
         ZVfc0Q6CbisvcJQRHKk8NGiujZ5+Ro4Yo3J3vEk+5+0ZG5T/c+i0sA6X4UJdq/Ic0TqO
         ztZw==
X-Gm-Message-State: APjAAAUn854SQHB35mHiFuDtKoOPC1t+fRefJ6BoVddIsXwjKMjcDpNz
        /CHxEEKS0J7WQZcTXCge2Zy/P7CeyXE=
X-Google-Smtp-Source: APXvYqyAZsa+epIkiQgVy0jCLUS8a2++SK36JVQhynA3c4wNyNi0jp1tlpxEJM45stjxgKExqEJysg==
X-Received: by 2002:a63:fb11:: with SMTP id o17mr6047331pgh.284.1561674675363;
        Thu, 27 Jun 2019 15:31:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id v4sm116939pff.45.2019.06.27.15.31.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 15:31:14 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:31:10 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH v2 10/13] walken: add unfiltered object walk from HEAD
Message-ID: <20190627223110.GH245941@google.com>
References: <20190626235032.177551-1-emilyshaffer@google.com>
 <20190626235032.177551-11-emilyshaffer@google.com>
 <CAPig+cR7rHokaTtZcJJg8trJ14xO3hdeWHqLnB4aOnEUak051w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cR7rHokaTtZcJJg8trJ14xO3hdeWHqLnB4aOnEUak051w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 01:37:58AM -0400, Eric Sunshine wrote:
> On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > Provide a demonstration of a revision walk which traverses all types of
> > object, not just commits. This type of revision walk is used for
> > operations such as creating packfiles and performing fetches or clones,
> > so it's useful to teach new developers how it works. For starters, only
> > demonstrate the unfiltered version, as this will make the tutorial
> > easier to follow.
> > [...]
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > diff --git a/builtin/walken.c b/builtin/walken.c
> > @@ -103,6 +109,65 @@ static int git_walken_config(const char *var, const char *value, void *cb)
> > +static void walken_show_commit(struct commit *cmt, void *buf)
> > +{
> > +       commit_count++;
> > +}
> > +
> > +static void walken_show_object(struct object *obj, const char *str, void *buf)
> > +{
> > +       switch (obj->type) {
> > +       [...]
> > +       case OBJ_TAG:
> > +               tag_count++;
> > +               break;
> > +       case OBJ_COMMIT:
> > +               die(_("unexpectedly encountered a commit in "
> > +                     "walken_show_object\n"));
> > +               commit_count++;
> 
> The "commit_count++" line is not only dead code, but it also confuses
> the reader (or makes the reader think that the author of this code
> doesn't understand C programming). You should drop this line.

Ow, yes. Removed. This is stale (pre-die()).

> 
> > +               break;
> > +       default:
> > +               die(_("unexpected object type %s\n"), type_name(obj->type));
> > +               break;
> 
> Likewise, this "break" (and the one in the OBJ_COMMIT case) are dead
> code which should be dropped to avoid confusing the reader.

Done.

> 
> Don't localize the die() message via _() here or in the preceding
> OBJ_COMMIT case.

I'm a little surprised by that. Is it because die() is expected to only
be seen by the developer? It seems like a poor user experience if
someone in non-English locale encounters a bug that Git team didn't
find, and needed to try to translate the English die() string and figure
out if a workaround is possible.

> 
> The two die() messages are unnecessarily dissimilar. Try to unify them
> so that they read in the same way.

I'm a little surprised by this too; it seems to me the root cause of
each would be different. In the former case, I'd guess that
traverse_commit_list()'s behavior changed, and in the latter case I'd
guess that a new object type was recently added to the model. Can you
help me understand the motivation for making the messages similar?

(I don't think, though, that I did a good job of indicating either root
cause in the die() messages as they are now.)

> 
> > +       }
> > +}> @@ -113,15 +178,15 @@ static void walken_commit_walk(struct rev_info *rev)
> >         /*
> > -         * prepare_revision_walk() gets the final steps ready for a revision
> > +        * prepare_revision_walk() gets the final steps ready for a revision
> >          * walk. We check the return value for errors.
> > -         */
> > +        */
> >         /*
> > -         * Now we can start the real commit walk. get_revision grabs the next
> > +        * Now we can start the real commit walk. get_revision grabs the next
> >          * revision based on the contents of rev.
> >          */
> 
> I think these are just correcting whitespace/indentation errors I
> pointed out in an earlier patch (so they are unnecessary noise in this
> patch).

ACK
