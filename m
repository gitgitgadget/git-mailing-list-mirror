Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25E3C2D0C2
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 20:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FD221835
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 20:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N6Az5s+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgABUtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 15:49:21 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33400 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABUtV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 15:49:21 -0500
Received: by mail-pg1-f201.google.com with SMTP id x24so27101439pgl.0
        for <git@vger.kernel.org>; Thu, 02 Jan 2020 12:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=86QNY+0OvONaAJTrQOsKL/Sh+pEXR9DaTvsVAphgA6o=;
        b=N6Az5s+kbHRZQFzZv6/UcZRjSJwfL+KnXHk0XGROw6Eypg4L+9WusBGCU1zBoXy0VU
         ZTMMTrMMe6WTabfTTJ511jJvmqCuNe5i3Vu3ESvP/MxHQh36CQXhQMgVK4AFksOVAC4T
         iXwAbFk01bNF/4M7Vh7vgWBvlFgF8NwuEKLBYb7uesuzT2+yYNoey6xe0mblgo6/Tbqp
         1xkRrhVLE9RWlubpYXfwx4J+zwASaSBfBUEolCeTyLIZ0oNP92ctcSKa1d5zW42da4vs
         0XLZ5guj3Ugv0o9v/sgiVKJcwSCZ5XmrF5LGoYnwXCwKbjRl4+0gcLqSYeVcGg5lVbb8
         BKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=86QNY+0OvONaAJTrQOsKL/Sh+pEXR9DaTvsVAphgA6o=;
        b=mbY3abpN14WIAoVgcVzumAl0CIJJjumq/DBJzhFJIiZSnbck2ko7fTLKLV1ChaXr97
         D2iobbudcVwmzcPiowHEtun/iPOXlf+6dzYwr9g9H2em+RWkZ4Uj/0zxZlkAsi00ZLQe
         kS72LUD6YpFnqB7rN2mb0Ge0vsaQNrCk4tRK3XfbtV2ShaqLR0YIbSfWGB2r2+0zJrXC
         fi2tdY0JVjM0W9qef+N8vLXFLjTkuNC9tTRV9fOgBVnNfkkG5Bg0qPl7GpM5PW+hVnFj
         kSgbdxv0onekx3n7wE/DAbkGvrPbxsRtnK1hvNtcCbbOmtVk2W5wO7ts2T+5mfjmev8A
         Kdkw==
X-Gm-Message-State: APjAAAUL2QefbG5bUqM6sqI/qzCAVLYzMOaBbyaqaNZhOwpnFdVVbIje
        7k1IpPWTUoJhkyHUB5y6UOQrRILJ3UhkXR1WJK4l
X-Google-Smtp-Source: APXvYqwVz001qWo98E0vpEQTX93wbLpbVCySjWdlJz7dq3WlgdRH+Na+48+1je9fSoo+MRVXSvMvCHaulkvhp4I4KEU8
X-Received: by 2002:a63:a34b:: with SMTP id v11mr88846388pgn.229.1577998160651;
 Thu, 02 Jan 2020 12:49:20 -0800 (PST)
Date:   Thu,  2 Jan 2020 12:49:17 -0800
In-Reply-To: <20191231000957.GB13606@google.com>
Message-Id: <20200102204917.188987-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191231000957.GB13606@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: Re: [PATCH v2] revision: allow missing promisor objects on CLI
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jrnieder@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > However, in the case that --ignore-missing is not set but
> > --exclude-promisor-objects is set, there is still no distinction between
> > the case wherein the missing object is a promisor object and the case
> > wherein it is not. This is unnecessarily restrictive, since if a missing
> > promisor object is encountered in traversal, it is ignored; likewise it
> > should be ignored if provided through the CLI. Therefore, distinguish
> > between these 2 cases. (As a bonus, the code is now simpler.)
> 
> nit about tenses, not worth a reroll on its own: "As a bonus, this
> makes the code simpler" (since commit messages describe the status quo
> before the patch in the present tense).

OK.

> > --- a/revision.c
> > +++ b/revision.c
> > @@ -370,8 +370,18 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
> >  		if (!repo_parse_commit(revs->repo, c))
> >  			object = (struct object *) c;
> >  		else
> > +			/*
> > +			 * There is something wrong with the commit.
> > +			 * repo_parse_commit() will have already printed an
> > +			 * error message. For our purposes, treat as missing.
> > +			 */
> >  			object = NULL;
> >  	} else {
> > +		/*
> > +		 * There is something wrong with the object. parse_object()
> 
> If we got here, we are in the !commit case, which is not inherently wrong,
> right?

[snip]

Ah, good catch. It should be "If parse_object() returns NULL, ..."

> By the way, why doesn't parse_object itself check the commit graph for
> commit objects?

Because that's how I coded it in ec0c5798ee ("revision: use commit graph
in get_reference()", 2018-12-28). In the commit message, I said:

> Another way to accomplish this effect would be to modify parse_object()
> to use the commit graph if possible; however, I did not want to change
> parse_object()'s current behavior of always checking the object
> signature of the returned object.

But that doesn't mean that we cannot change it.

> By "and treats it as missing" does this mean "and we should treat it
> as missing"?  (Forgive my ignorance.)

I don't fully know if we should, hence my specific wording :-P but see
my answer to your next question.

> Why do we treat corrupt objects as missing?  Is this for graceful
> degredation when trying to recover data from a corrupt repository?

This (at least, treating wrong-hash objects the same as missing) has
been true since acdeec62cb ("Don't ever return corrupt objects from
"parse_object()"", 2007-03-20) (and that commit message has no
explanation). I think this is best - I consider corrupt objects to be
similar to missing objects with respect to repository corruption, so for
me it is logical to treat them the same way.
