Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AEE420899
	for <e@80x24.org>; Tue,  8 Aug 2017 17:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbdHHRDl (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 13:03:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37554 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbdHHRDk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 13:03:40 -0400
Received: by mail-pf0-f194.google.com with SMTP id p13so3612594pfd.4
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RG4wSVC2UNr3ppXyCTiHgDIkH0R9FNNLtDiX/HNPW1Q=;
        b=glPPlRehJuTvg6ZlMFx9jipWNqBXQyh99h5FW0pBW0zau8E8DOugeok5MXUGEviakT
         XAKeJ2gTzFYCbga4S/10XP6Hwkeo7ViHWfr5sAp/ClCRSByvXkYKwATipUVitkomSp2z
         Ib3F2job49BX2sBsXJ2kLHHf1dXNmsqKY3JOe71saozk0Qce8x0i65kO1NhsZXhI43xR
         Gk3o7jKERjRL1mZH4n7HDEHZqaJl7bKsIKgzqAHldjpAaAXdj5VBeF+j62JLgk/fOC4U
         iIK8L8Q/aj9Ao8eHejqqHVRiFDp2QFE2OdcKpZHMXpHZRTubNpuiwo03tn4+cpBppwV7
         psEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RG4wSVC2UNr3ppXyCTiHgDIkH0R9FNNLtDiX/HNPW1Q=;
        b=shkzxprpWVQMPQXQlnadrxli6cf7KZjYBUqaMDgvS5EgT/9YlHsYSPVCLoxsW2zWg7
         Fj+SG9dnx/Zc7SaML/rpGkx//ZvSE/3/HPJcHHSCDbAqdUB/F/q+cUelHGha0Y5L0LIy
         EikBEj02lzf7WoMvWdPCdSjmg2T6cApeeRHUWXuaVWk3Dt0EiMwAAJaugVui0l6CL+e/
         swCFt4H83G1lbEmNpVtVqM1IlKMGDLGpbgfNWcHvfVtbBCTjpJS3yLMW3AilSQq2V6tT
         7l3O6KciswMCxkog66X7maMT8xqfP7aCankI4Arw/sh/YG2Ycks3oH0gsdKbH8BXwU1c
         xJmw==
X-Gm-Message-State: AHYfb5ime+86zYVfK99cvxzc99rxD5nNTWIdrr+NGqt7zkY5DrnFNK5u
        M8gcaU0VyZQpZw==
X-Received: by 10.99.114.19 with SMTP id n19mr4713134pgc.436.1502211819446;
        Tue, 08 Aug 2017 10:03:39 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:d173:771d:dd07:d344])
        by smtp.gmail.com with ESMTPSA id z62sm4015041pfz.79.2017.08.08.10.03.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 10:03:38 -0700 (PDT)
Date:   Tue, 8 Aug 2017 10:03:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        christian.couder@gmail.com
Subject: Re: Partial clone design (with connectivity check for
 locally-created objects)
Message-ID: <20170808170311.GA169894@aiede.mtv.corp.google.com>
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
 <xmqqtw1nrlpf.fsf@gitster.mtv.corp.google.com>
 <20170804172137.42f27653@twelve2.svl.corp.google.com>
 <0633771f-ce19-6211-fabe-3f7f676e53ab@gmail.com>
 <xmqqwp6fp3mk.fsf@gitster.mtv.corp.google.com>
 <693596b8-7a84-bcc8-7eef-2d534293e14b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <693596b8-7a84-bcc8-7eef-2d534293e14b@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ben Peart wrote:

> We've discussed a couple of different possible solutions, each of
> which have different tradeoffs.  Let me try to summarize here and
> perhaps suggest some other possibilities:

Thanks for this.  Some comments below.

> Promised list
> -------------
> This provides an external data structure that allowed us to flag
> objects that came from a remote server (vs created locally).
>
> The biggest drawback is that this data structure can get very large
> and become difficult/expensive to generate/transfer/maintain.

Agreed.  Using a single immutable file to maintain this data with
lock-and-rename update means that I/O when updating it can be a
bottleneck and that contention can be a problem.

> It also (at least in one proposal) required protocol and server side
> changes to support it.

I don't think that's a very big problem.  This is the Git project: we
control the protocol and the server.  Partial clone requires changing
the protocol and server already.

> Annotated via filename
> ----------------------
> This idea is to annotate the file names of objects that came from a
> remote server (pack files and loose objects) with a unique file
> extension (.remote) that indicates whether they are locally created
> or not.
>
> To make this work, git must understand about both types of loose
> objects and pack files and search in both locations when looking for
> objects.

I don't understand the drawback you're describing here.  To avoid a
number of serious problems, Git already needs to be aware of partial
clone.  I don't think anyone has been proposing adding partial clone
to upstream Git without a repository format extension (see
Documentation/technical/repository-version.txt) to prevent older
versions of Git from being confused about such repositories.

If you don't do this, some problems include
- confusing messages due to missing objects
- errors over the wire protocol from trying to serve fetches and
  getting confused
- "git gc" running and not knowing which objects are safe to be
  deleted

So the relevant issue couldn't be that Git has to be changed at all:
it would be that a change is excessively invasive.

But it's not clear to me that the change you are describing is very
invasive.

> Another drawback of this is that commands (repack, gc) that optimize
> loose objects and pack files must now be aware of the different
> extensions and handle both while not merging remote and non-remote
> objects.
>
> In short, we're creating separate object stores - one for locally
> created objects and one for everything else.

These also seem like non-issues.

Some examples of problems I could imagine:

- is writing multiple files when writing a loose object a problem for
  your setup?
- is one of the operations described (repack, prune, fsck) too slow?

Do you forsee either of those being an issue?

> Now a couple of different ideas:
>
> Annotated via flags
> ===================
> The fundamental idea here is that we add the ability to flag locally
> created objects on the object itself.

Do you mean changing the underlying object format that produces an
object's object id?  Or do you mean changing the container format?

Changing the container format is exactly what was described in the
previous example ("Annotated via filename").  There are other ways to
change the container format: e.g. if writing multiple files when
writing a loose object is a problem, we could add a field that does
not affect the object id to the loose object format.

[...]
> Local list
> ----------
> Given the number of locally created objects is usually very small in
> comparison to the total number of objects (even just due to
> history), it makes more sense to track locally created objects
> instead of promised/remote objects.
>
> The biggest advantage of this over the "promised list" is that the
> "local list" being maintained is _significantly_ smaller (often
> orders of magnitude smaller).
[...]
> On the surface, this seems like the simplest solution that meets the
> stated requirements.

This has the same problems as the list of promised objects: excessive
I/O and contention when updating the list.

Moreover, it doesn't bring one of the main benefits of the list of
promised objects.  Promised objects are not present in the local
repository, so the list of promises provided a way to maintain some
information about them (e.g., object size).  Locally created objects
are present in the local repository so they don't need such metadata.

> Object DB
> ---------

If I understand correctly, this is pushing the issues described in the
other cases into a hook and making them not upstream Git's problem.

But it is still someone's problem.  It just means upstream Git doesn't
benefit from their solution to it.

I don't see a need to give up in that way just yet.

I'm also available on #git-devel on freenode.net for real-time
conversation.  Logs are at http://bit.ly/aLzrmv.  You can prepend a
message with "[off]" to prevent it from showing up in logs.  I'm also
happy to try to summarize any conversation that happens there here.

Thanks,
Jonathan
