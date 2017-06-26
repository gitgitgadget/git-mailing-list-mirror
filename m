Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4EE0207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 18:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbdFZSNN (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 14:13:13 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35443 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbdFZSNM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 14:13:12 -0400
Received: by mail-pf0-f179.google.com with SMTP id c73so3958706pfk.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 11:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U3oKec6nzIKCsS+7mHmQRIuXdvRxgdtqjDSc+fE4Rhg=;
        b=NgrYoAAs9+wF+5xudwa8U7QbeiW/AsR/hqtEMgQOMWStAq558OFerVmbjTrJcMEVgj
         l+wXmXYO9o52N9xTtY/lTEHDEv+kVw7ZMfcWWlt4aKe2P5nmRmWiiY7aA6jUHhd4H6TY
         6JD0E5dATC4QcqzVIybo77nKhfpzNyA3+uBkYrgMlRBbO1lYYHctAXgHtItjVUX/uwvE
         Fs5Kg4GNcRcWAS0Puu/IPflAgv4l2JSqgSjCfvVkPjZv0lD3fGd3kyZVGhrB8EVl0iT+
         pqLS+UxkdeVIA4RMP+8/NOTnj3saQLjOXWZThvHSqAJVNgTaivlVS+jbCPW2ircM3OSh
         df7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U3oKec6nzIKCsS+7mHmQRIuXdvRxgdtqjDSc+fE4Rhg=;
        b=Ai1y9jCbnRHSJTxRv+BQt5HJRYwmxWujJCDOqCH8PDorxLf7WmaZxL3hULbDqh5p29
         PwZ3yEn+ykdzpLrzQMKrGoNWEXub0yVWNwH/bEZwe1WXQEuKgTXXeNk5FuxSbLXF5rT2
         6o0L3xIAjEN7a5OAev2eV5EYcSWCBnEyksYbmg2laSGNe5CxU38BWCDtDlfAKSNOq9xP
         en/Hf6HBmJDjnlgVAyl3Kyxb7IZry3fLRNd4zNd5cdTUDsfryPSypleX5HkkTRgjcbic
         CmJHbQJ+e0UMWeRYpIw8CZXVEVFPB/Jigqlxw/fY/ktOi2Xjx9HDZZ+yR4JJwMtw1Wt1
         vKKA==
X-Gm-Message-State: AKS2vOzwUPKW3888sqPwTdTr447xDwybdm52wJiMAYFYk3mThwLa8tTm
        nPZcf8mbHmmJmpw5
X-Received: by 10.84.216.70 with SMTP id f6mr1440745plj.79.1498500781333;
        Mon, 26 Jun 2017 11:13:01 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:f083:620a:56f6:d4d1])
        by smtp.gmail.com with ESMTPSA id r62sm1381805pfb.39.2017.06.26.11.12.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 11:13:00 -0700 (PDT)
Date:   Mon, 26 Jun 2017 11:12:58 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com
Subject: Re: [PATCH] submodule--helper: teach push-check to handle HEAD
Message-ID: <20170626181258.GA177061@google.com>
References: <20170623200427.26803-1-bmwill@google.com>
 <xmqqk242b9nf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk242b9nf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/23, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > In 06bf4ad1d (push: propagate remote and refspec with
> > --recurse-submodules) push was taught how to propagate a refspec down to
> > submodules when the '--recurse-submodules' flag is given.  The only refspecs
> > that are allowed to be propagated are ones which name a ref which exists
> > in both the superproject and the submodule, with the caveat that 'HEAD'
> > was disallowed.
> >
> > This patch teaches push-check (the submodule helper which determines if
> > a refspec can be propagated to a submodule) to permit propagating 'HEAD'
> > if and only if the superproject and the submodule both have the same
> > named branch checked out and the submodule is not in a detached head
> > state.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/submodule--helper.c    | 57 +++++++++++++++++++++++++++++++-----------
> >  submodule.c                    | 18 ++++++++++---
> >  t/t5531-deep-submodule-push.sh | 25 +++++++++++++++++-
> >  3 files changed, 82 insertions(+), 18 deletions(-)
> >
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index 1b4d2b346..fd5020036 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -1107,24 +1107,41 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
> >  static int push_check(int argc, const char **argv, const char *prefix)
> >  {
> >  	struct remote *remote;
> > +	const char *superproject_head;
> > +	char *head;
> > +	int detached_head = 0;
> > +	struct object_id head_oid;
> >  
> > -	if (argc < 2)
> > -		die("submodule--helper push-check requires at least 1 argument");
> > +	if (argc < 3)
> > +		die("submodule--helper push-check requires at least 2 argument");
> 
> "arguments"?
 
You're right, I'll fix the typo.

> > +
> > +	/*
> > +	 * superproject's resolved head ref.
> > +	 * if HEAD then the superproject is in a detached head state, otherwise
> > +	 * it will be the resolved head ref.
> > +	 */
> > +	superproject_head = argv[1];
> 
> The above makes it sound like the caller gives either "HEAD" (when
> detached) or "refs/heads/branch" (when on 'branch') in argv[1] and
> you are stashing it away, but ...
> 
> > +	/* Get the submodule's head ref and determine if it is detached */
> > +	head = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
> > +	if (!head)
> > +		die(_("Failed to resolve HEAD as a valid ref."));
> > +	if (!strcmp(head, "HEAD"))
> > +		detached_head = 1;
> 
> ... the work to see which branch we are on and if we are detached is
> done by this code without consulting argv[1].  I cannot tell what is
> going on.  Is argv[1] assigned to superproject_head a red herring?

The idea is that 'git submodule--helper push-check' is called by a
superproject on every submodule that may be pushed.  So this command is
invoked on the submodule itself.  This change requires knowing what
'HEAD' refers to in the superproject (either detached or a named branch)
so the superproject passes that information to the submodule via
argv[1].  This snippet of code is responsible for finding what 'HEAD'
refers to in the submodule so that later we can compare the
superproject's and submodule's 'HEAD' ref to see if they match the same
named branch.

> 
> >  	/*
> >  	 * The remote must be configured.
> >  	 * This is to avoid pushing to the exact same URL as the parent.
> >  	 */
> > -	remote = pushremote_get(argv[1]);
> > +	remote = pushremote_get(argv[2]);
> >  	if (!remote || remote->origin == REMOTE_UNCONFIGURED)
> > -		die("remote '%s' not configured", argv[1]);
> > +		die("remote '%s' not configured", argv[2]);
> >  
> >  	/* Check the refspec */
> > -	if (argc > 2) {
> > -		int i, refspec_nr = argc - 2;
> > +	if (argc > 3) {
> > +		int i, refspec_nr = argc - 3;
> >  		struct ref *local_refs = get_local_heads();
> >  		struct refspec *refspec = parse_push_refspec(refspec_nr,
> > -							     argv + 2);
> > +							     argv + 3);
> 
> If you have no need for argv[1] (and you don't, as you have stashed
> it away in superproject_head), it may be less damage to the code if
> you shifted argv upfront after grabbing superproject_head.
> 
> >  		for (i = 0; i < refspec_nr; i++) {
> >  			struct refspec *rs = refspec + i;
> > @@ -1132,18 +1149,30 @@ static int push_check(int argc, const char **argv, const char *prefix)
> >  			if (rs->pattern || rs->matching)
> >  				continue;
> >  
> > -			/*
> > -			 * LHS must match a single ref
> > -			 * NEEDSWORK: add logic to special case 'HEAD' once
> > -			 * working with submodules in a detached head state
> > -			 * ceases to be the norm.
> > -			 */
> > -			if (count_refspec_match(rs->src, local_refs, NULL) != 1)
> > +			/* LHS must match a single ref */
> > +			switch(count_refspec_match(rs->src, local_refs, NULL)) {
> 
> "switch (count..."
> 
> > +			case 1:
> > +				break;
> > +			case 0:
> > +				/*
> > +				 * If LHS matches 'HEAD' then we need to ensure
> > +				 * that it matches the same named branch
> > +				 * checked out in the superproject.
> > +				 */
> > +				if (!strcmp(rs->src, "HEAD")) {
> > +					if (!detached_head &&
> > +					    !strcmp(head, superproject_head))
> > +						break;
> > +					die("HEAD does not match the named branch in the superproject");
> > +				}
> 
> Hmph, so earlier people can "push --recurse-submodules HEAD:$dest"
> and $dest can be anything, but now we are tightening the rule?

I don't believe that anything is changing w.r.t. what $dest can be
(unless I'm missing something).  This is more about enabling 'HEAD' to
be used on the LHS of a refspec as before it wasn't permitted.  With
this change a user can use 'push --recurse-submodules HEAD:$dest' and
the refspec which includes 'HEAD' on the LHS will be propagated to the
submodules if and only if 'HEAD' is not detached in the superproject or
submodule and 'HEAD' refers to the same named branch.

> 
> > +			default:
> >  				die("src refspec '%s' must name a ref",
> >  				    rs->src);
> > +			}
> >  		}
> >  		free_refspec(refspec_nr, refspec);
> >  	}
> > +	free(head);
> >  
> >  	return 0;
> >  }

-- 
Brandon Williams
