Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A4B1F461
	for <e@80x24.org>; Fri,  6 Sep 2019 15:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394889AbfIFPmS (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 11:42:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36829 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390317AbfIFPmR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 11:42:17 -0400
Received: by mail-io1-f67.google.com with SMTP id b136so13758552iof.3
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8OHJSpYSOeUqvC/q90T67H081ebZ+zaTq3NJJ9zlAMc=;
        b=pxC4HcsV5hP/fPBqIYed/ZsAeb9DyiLN3nY+g3R0YVnzmbvbk2/kIYzDZToZHVe68m
         JAV3rGPXjREQrGqzImXBj1638EM+FXdla6GpHVvHd/+s29crcs7XdC/FyqHk0fWgn+Ka
         5Am57sUlzPBBppC2PnH+aYLxtWzjlB96FeshXSd2ocut5L8zevYb/Cc72Uu69Bztr0Zb
         B4MtETZYxuLCMgoCYWi+CjQxnw6rxKxuxq9D41nfaJKcZVVEjuTOO53kKK3E9wb5WQrU
         OahFMdUKZ4Nz9SSUCfONzDJOArm7B8nC/7ahdLJ1673JRMm5zbWh53XjUpIVtGkiBlHF
         PDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8OHJSpYSOeUqvC/q90T67H081ebZ+zaTq3NJJ9zlAMc=;
        b=JmhBO39FBbVlBILKhkNpopFi7cthWT6q2+Rxzn+iE7nDG6VFh2m4acInNugsS6rX/s
         0GE4nuxPDtn0C5Kn+JHNX8SosjKa9RF/2HydD0vMJXu+dYUC8kYef/2gq3x4bMyqoMmL
         G3hmCfKB6DKmstHj+OfSEXr3RJLbHuOae1XZjA3csQPb4UCOL57HQyvMe7P4s8e6L0uh
         j9FDaR1iNRYCFLYMu/rWuzff1snjmGmAz8urk9+CwrAL1huAfV9ltyvXTFU384G76Maw
         Aa5wMUpUzOM+hr0syjhUN0jANpZfVtyI9ErCGHSjJs/Q+OumP6Ts/F46ntcmLGqIwM2A
         L3gQ==
X-Gm-Message-State: APjAAAVA3MijR7os3KPRjOOh1wUiqyiFPx/4jEb88ZF6D9X3Zr5uhUIg
        8WcZSI28n+0KyD6Mk02svYyrcjvTSThspA==
X-Google-Smtp-Source: APXvYqzzGSAZoRCaAByj+e4gge4FrLdKR+d2BaqVfrqesZaUxtasK3NFmWWs0aVPxHLcwFK7BT7T2w==
X-Received: by 2002:a6b:f80e:: with SMTP id o14mr959674ioh.139.1567784536199;
        Fri, 06 Sep 2019 08:42:16 -0700 (PDT)
Received: from localhost ([2601:401:c500:7dd8:a07e:ecdb:f0d3:4a87])
        by smtp.gmail.com with ESMTPSA id d20sm5191369ioh.2.2019.09.06.08.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 08:42:15 -0700 (PDT)
Date:   Fri, 6 Sep 2019 11:42:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, stolee@gmail.com
Subject: Re: [PATCH 3/3] commit-graph.c: handle corrupt/missing trees
Message-ID: <20190906154214.GA3657@syl.local>
References: <cover.1567720960.git.me@ttaylorr.com>
 <9fbd965e3892307bb5bb78952f017624fcc0b73a.1567720960.git.me@ttaylorr.com>
 <20190906061919.GA5122@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906061919.GA5122@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 02:19:20AM -0400, Jeff King wrote:
> On Thu, Sep 05, 2019 at 06:04:57PM -0400, Taylor Blau wrote:
>
> > @@ -846,7 +847,11 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
> >  		if (parse_commit_no_graph(*list))
> >  			die(_("unable to parse commit %s"),
> >  				oid_to_hex(&(*list)->object.oid));
> > -		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
> > +		tree = get_commit_tree_oid(*list);
> > +		if (!tree)
> > +			die(_("unable to get tree for %s"),
> > +				oid_to_hex(&(*list)->object.oid));
> > +		hashwrite(f, tree->hash, hash_len);
>
> Yeah, I think this is a good stop-gap to protect ourselves, until a time
> when parse_commit() and friends consistently warn us about the breakage.
>
> > diff --git a/commit.c b/commit.c
> > index a98de16e3d..fab22cb740 100644
> > --- a/commit.c
> > +++ b/commit.c
> > @@ -358,7 +358,8 @@ struct tree *repo_get_commit_tree(struct repository *r,
> >
> >  struct object_id *get_commit_tree_oid(const struct commit *commit)
> >  {
> > -	return &get_commit_tree(commit)->object.oid;
> > +	struct tree *tree = get_commit_tree(commit);
> > +	return tree ? &tree->object.oid : NULL;
> >  }

You mentioned in the version of this series that is rebased on GitHub's
fork that it may be worth putting this hunk in a separate commit
entirely. I don't disagree, so if there are other comments that merit a
reroll of this, I'm happy to pull this change out as 3/4.

> This one in theory benefits lots of other callsites, too, since it means
> we'll actually return NULL instead of nonsense like "8". But grepping
> around for calls to this function, I found literally zero of them
> actually bother checking for a NULL result. So there are probably dozens
> of similar segfaults waiting to happen in other code paths.
> Discouraging.

Discouraging indeed. I think that you suggest it below, but perhaps the
right thing to do here is implement 'get_commit_tree_oid()' as follows:

  struct object_id *get_commit_tree_oid(const struct commit *commit)
  {
    struct tree *tree = get_commit_tree(commit);
    if (!tree)
      die(_("unable to get tree from commit %s"),
          oid_to_hex(&commit->object.oid));
    return &tree->object.oid;
  }

Which then puts the onus on the *caller* to check their commit pointer
to make sure that it has a legit tree in it, unless they're OK with
dying.

In the commit-graph change that this whole thread is in response to,
that's exactly what we want: I don't want to have to check the return
value of two function calls myself. I'm perfectly happy to die() in the
middle of things if there is an object corruption, but the library code
should take care of that for me, and not allow for dozens of checks,
each with their own unique 'die()'-ing message.

All of that said, I don't know if I think it's worth holding this series
up on the above in the meantime. I do think that it (or something like
it) is generally worth doing, but I'm not sure that now is the time to
do it.

> This is sort-of attributable to my 834876630b (get_commit_tree(): return
> NULL for broken tree, 2019-04-09). Before then it was a BUG(). However,
> that state was relatively short-lived. Before 7b8a21dba1 (commit-graph:
> lazy-load trees for commits, 2018-04-06), we'd have similarly returned
> NULL (and anyway, BUG() is clearly wrong since it's a data error).

Ha, I was wondering why that commit message looked familiar... it turns
out that I'm the culprit, too, via the 'Co-authored-by' trailer. Oops.

> None of which argues against your patches, but it's kind of sad that the
> issue is present in so many code paths. I wonder if we could be handling
> this in a more central way, but I don't see how short of dying.
>
> -Peff
Thanks,
Taylor
