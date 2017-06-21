Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A228C20282
	for <e@80x24.org>; Wed, 21 Jun 2017 00:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbdFUAjH (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 20:39:07 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35593 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbdFUAjG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 20:39:06 -0400
Received: by mail-pg0-f41.google.com with SMTP id 132so36172153pgb.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 17:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fKVc5FtQb84Z8jZRMVBdOsSkjbe06CmiUKo0w74olRA=;
        b=h2FYkUG/H7rauK8suhMdxeyECWFEtuOmlWqS7yE0k/YtHVxi/Euj0wHVyr+VILs5Ns
         xTu9kECijb71mOKqAb8vKzt7WAqp9fxxuqLIH2BIUYZ1/qWoZz0N3HxanFQKsKQ9eQEn
         WhrTqICoVo8hOe5aeCcpYgwrb+W9eGShs4ZguvK+penH29F2Kw1ZKZSWlt8b5ffP8FBN
         BUPPOd4B9K1F49ENv6p9zCG+KimtHee7oKBso6JDGSOExg117BXMEHUuWj1eE4ssHIQZ
         V7BY9kglqMY/zytmlmIk+keQiPBNvRHQ1ZNhy1yh0K1vOFyjPM+UPVucm8emtft+QBmO
         u8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fKVc5FtQb84Z8jZRMVBdOsSkjbe06CmiUKo0w74olRA=;
        b=p2zZs+qGW7ij3oGWJiQhEDiC/WfiGCLx54Ze/10ARfCIFG3nUF6bho2dCZaBI2PAZK
         Sc/40Wr6PsRp24Ezs49u97E8PJAUiozNV3rHH9PKM9G9YgdxSDomutxv/WF8/6Wue3FW
         hMEg6cmvMP9rRsscRu0Ya6FV/N5NtqEfOM2xj7JgXEpVDr4sX/PhXN6j46NGb1w9HVeh
         1zXx205h+mGUKztGjsEVjh/QQb37BcTpcLzPPdgtJtJneMbUIlcpjQpVKSJEweDSwv+N
         OaBpCYjsdb6Rw9JOm2xd6QQChUuTusK9Hd/ZtMSlLV0CPP7P/6SCezNR2L4TMlQ5OFKH
         0PhQ==
X-Gm-Message-State: AKS2vOyekZ90ZYA49T6/YPAOJiTc0GdCc+fnOFUztUklfBBnEQPgWX3I
        AQFCWFI/WO8NgT6G
X-Received: by 10.99.124.65 with SMTP id l1mr33811211pgn.279.1498005545335;
        Tue, 20 Jun 2017 17:39:05 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:292c:ffc6:f991:bee9])
        by smtp.gmail.com with ESMTPSA id f8sm31152289pfc.14.2017.06.20.17.39.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 17:39:04 -0700 (PDT)
Date:   Tue, 20 Jun 2017 17:39:03 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 11/20] path: construct correct path to a worktree's
 index
Message-ID: <20170621003903.GD60134@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
 <20170620191951.84791-12-bmwill@google.com>
 <20170620230200.GB60603@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620230200.GB60603@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/20, Jonathan Nieder wrote:
> Hi,
> 
> Brandon Williams wrote:
> 
> > When working with worktrees the git directory is split into two part,
> > the per-worktree gitdir and a commondir which contains things which are
> > shared among all worktrees (like the object store).  With this notion of
> > having a split git directory, 557bd833b (git_path(): be aware of file
> > relocation in $GIT_DIR) and c7b3a3d2f ($GIT_COMMON_DIR: a new
> > environment variable) changed the way that 'git_path()' functioned so
> > that paths would be adjusted if they referred to files or directories
> > that are stored in the commondir or have been changed via an environment
> > variable.
> >
> > One interesting problem with this is the index file as it is not shared
> > across worktrees yet when asking for a path to a specific worktree's
> > index it will be replaced with a path to the current worktree's index.
> > In order to prevent this, teach 'adjuct_git_path' to replace the
> > path to the index with the path recorded in a repository (which would be
> > the current, active worktree) only when not asked to construct a path
> > for a specific worktree.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  path.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> Thanks --- this is subtle.  I don't think that what this patch does is
> right.  Commenting below.
> 
> > --- a/path.c
> > +++ b/path.c
> > @@ -372,13 +372,20 @@ void report_linked_checkout_garbage(void)
> >  }
> >  
> >  static void adjust_git_path(const struct repository *repo,
> > +			    const struct worktree *wt,
> >  			    struct strbuf *buf, int git_dir_len)
> >  {
> >  	const char *base = buf->buf + git_dir_len;
> >  	if (is_dir_file(base, "info", "grafts"))
> >  		strbuf_splice(buf, 0, buf->len,
> >  			      repo->graft_file, strlen(repo->graft_file));
> > -	else if (!strcmp(base, "index"))
> > +	/*
> > +	 * Only try to replace the path '$gitdir/index' with the index file
> > +	 * recorded in the repository when not constructing a path for a
> > +	 * worktree.  This way we can retrieve the correct path to a particular
> > +	 * worktree's index file.
> > +	 */
> > +	else if (!wt && !strcmp(base, "index"))
> >  		strbuf_splice(buf, 0, buf->len,
> >  			      repo->index_file, strlen(repo->index_file));
> 
> Some context that may have been missing: GIT_INDEX_FILE is a low-level
> tool to allow script authors to specify an alternate index file to use
> when running commands like "git read-tree" or "git checkout-index".
> 
> The above would make it not take effect for git_path() callers when
> 'wt != NULL'.  As a result, if any caller reaches this code path, then
> scripts specifying GIT_INDEX_FILE would stop working when run from a
> worktree that borrows refs and objects from a separate repository.
> I'm pretty sure that such a subtle flip in behavior based on whether
> they are in "git worktree" created worktree or the main working tree
> is not what the end user would intend, so this looks like a step in
> the wrong direction.
> 
> Fortunately this code path doesn't actually get called.
> 
> In fact, rewriting git_path("index") in this function feels to me like
> a layering violation.  Shouldn't callers be using get_index_file() to
> express their intent more clearly?  That's what all current callers
> do.
> 
> IIUC this came up when a patch from nd/prune-in-worktree (e7a6a3b15,
> revision.c: --indexed-objects add objects from all worktrees), which
> is currently not in pu, introduced a caller that does call
> git_path("index").  The old behavior of replacing git_path("index")
> with $GIT_INDEX_FILE when the latter is set was mostly harmless
> because typically GIT_INDEX_FILE is not set, especially when people
> are running "git prune".  Patch 05/20 (environment: place key
> repository state in the_repository) made the substitution harmful: now
> we would use repo->index_file unconditionally instead of allowing the
> ordinary worktree-relative resolution as a fallback when
> GIT_INDEX_FILE is unset.
> 
> Possible next steps:
> 
>  1. I think we should make git_path less magical and discourage
>     callers from relying on it to handle the GIT_INDEX_FILE envvar.
>     We can do that by removing the !strcmp(base, "index") case
>     completely.

From our conversation off-line it seems like we agree that this is
probably the best course of action.  So I'll plan to drop the case
completely since it isn't even used currently.  I'll also go ahead and
drop the graft_file one as well since it doesn't make much sense to keep
it around when it is only queried for once.

> 
>  2. Optionally, it is possible to be more cautious by keeping the
>     !strcmp(base, "index") case and making it call BUG() to force
>     people not to use it.  This would help steer callers toward
>     get_index_file().  But given that the only caller did not actually
>     want GIT_INDEX_FILE substitution, I don't think that that is
>     necessary or useful.
> 
>  3. A docstring for git_path should explain the substitutions it
>     currently makes and more straightforward alternatives that callers
>     can use.
> 
>  4. Specifying GIT_INDEX_FILE when running "git prune" is a
>     meaningless combination.  It would be nice for "git prune" to
>     error out to save the user from confusion.
> 
>  5. There are likely other commands that don't make sense with
>     GIT_INDEX_FILE.  Tracking them all down to make them print a
>     meaningful error message might be a bit of a slog, though.
> 
> >  	else if (dir_prefix(base, "objects"))
> > @@ -411,7 +418,7 @@ static void do_git_path(const struct repository *repo,
> >  		strbuf_addch(buf, '/');
> >  	gitdir_len = buf->len;
> >  	strbuf_vaddf(buf, fmt, args);
> > -	adjust_git_path(repo, buf, gitdir_len);
> > +	adjust_git_path(repo, wt, buf, gitdir_len);
> >  	strbuf_cleanup_path(buf);
> >  }
> 
> Thanks and hope that helps,
> Jonathan

-- 
Brandon Williams
