Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB52A20372
	for <e@80x24.org>; Mon,  9 Oct 2017 22:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755461AbdJIW5f (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 18:57:35 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34699 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754318AbdJIW5d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 18:57:33 -0400
Received: by mail-pf0-f194.google.com with SMTP id b85so10604403pfj.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 15:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=po2RfaE8q+6dzmNEJu7gOd0q9Bbpd61uHLrrLGiH18E=;
        b=n50mpyvGy8JEZw4877mwrbry1iMtWdkC/SkLYu1G8oXzOIVUQRS2seCju/mBhMM575
         le8I1UuwaP4Zh7PoBaWVHddZTCjeUUNXzqq5QSvfFsV++fubK+CCI5EP30dRTjp3obDI
         /DzUSDKBbBHoiEDEY8uhqZp7gxyxLGsgsyWkA6RIfRvQALJgSOlXHkI9ZfuLYsDozvWh
         UIy9cbINVtGQ8m6QiU6EJWme2D4W+9OriAT4d+pdJo+OUcHs/hBSpH7E4ORP0frtDZ8O
         +Tl/boADFjUAq5WdVXFGjnyZbc6oxaODG7LFe3pzD861n0BBGUEukb7bkEz+i5BnWG34
         eWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=po2RfaE8q+6dzmNEJu7gOd0q9Bbpd61uHLrrLGiH18E=;
        b=e9fcVXICnlVpAiOC3Ihp1WCU50P0+EDiKE7382DC5X1nMfbgUpXnQBKYYzZwmRYjPJ
         G6C0nj0Jxjc6vCqDnOCu5zTU+tXewRYBeSWKwoJrONx/4LmbbKB4hbJoHuN+cvOi+IIu
         I1VKoA1TMwP9Ahinxfr4QeYuIoN78Djpt5sYhrwJOfIjcZj6WLI4yqilT7vGv974aa6s
         OPCRqjZhOatp33MfLgnj0dPcxtSPbYPJWNt6fgGFXGy+F95dwTWa6J/Yl6xPFugtTKLU
         37dpQW+jEhGaPu/UdyLC+5F6+uZEtWZEBEROMN+M1iPL6n4o2VV1o/SnUMlDpcKaMYS8
         mtHA==
X-Gm-Message-State: AMCzsaU8TrN8oRJQuO6+NnvRy82BEUYxsE+py0e4q4ZDeH9YUVHB7p5j
        tYBQWV8lFgqFORMafWRqHK8iZRFK
X-Google-Smtp-Source: AOwi7QC4jsNTvu3S6ZqSdN4fpRZrUsasZRJ633VGWEe84fNTGD8NWgdFt95nADyT5hylXk6D9PHexQ==
X-Received: by 10.101.93.136 with SMTP id f8mr10396055pgt.60.1507589852651;
        Mon, 09 Oct 2017 15:57:32 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:14f3:fccd:46cc:9e97])
        by smtp.gmail.com with ESMTPSA id p12sm14394560pgn.90.2017.10.09.15.57.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 15:57:31 -0700 (PDT)
Date:   Mon, 9 Oct 2017 15:57:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 04/24] refs: convert update_ref and refs_update_ref to
 use struct object_id
Message-ID: <20171009225729.GH19555@aiede.mtv.corp.google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-5-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009011132.675341-5-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> Convert update_ref, refs_update_ref, and write_pseudoref to use struct
> object_id.  Update the existing callers as well.  Remove update_ref_oid,
> as it is no longer needed.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

I'm very happy to see this kind of cleanup (removal of update_ref_oid).

>  bisect.c                  |  5 +++--
>  builtin/am.c              | 14 +++++++-------
>  builtin/checkout.c        |  3 +--
>  builtin/clone.c           | 14 +++++++-------
>  builtin/merge.c           | 13 ++++++-------
>  builtin/notes.c           | 10 +++++-----
>  builtin/pull.c            |  2 +-
>  builtin/reset.c           |  4 ++--
>  builtin/update-ref.c      |  2 +-
>  notes-cache.c             |  2 +-
>  notes-utils.c             |  2 +-
>  refs.c                    | 40 ++++++++++++++++------------------------
>  refs.h                    |  5 +----
>  sequencer.c               |  9 +++------
>  t/helper/test-ref-store.c | 10 +++++-----
>  transport-helper.c        |  3 ++-
>  transport.c               |  4 ++--
>  17 files changed, 64 insertions(+), 78 deletions(-)
[...]
> +++ b/builtin/checkout.c
> @@ -664,8 +664,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  	if (!strcmp(new->name, "HEAD") && !new->path && !opts->force_detach) {
>  		/* Nothing to do. */
>  	} else if (opts->force_detach || !new->path) {	/* No longer on any branch. */
> -		update_ref(msg.buf, "HEAD", new->commit->object.oid.hash, NULL,
> -			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
> +		update_ref(msg.buf, "HEAD", &new->commit->object.oid, NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);

Long line.

[...]
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -544,7 +544,7 @@ static int pull_into_void(const struct object_id *merge_head,
>  	if (checkout_fast_forward(&empty_tree_oid, merge_head, 0))
>  		return 1;
>  
> -	if (update_ref("initial pull", "HEAD", merge_head->hash, curr_head->hash, 0, UPDATE_REFS_DIE_ON_ERR))
> +	if (update_ref("initial pull", "HEAD", merge_head, curr_head, 0, UPDATE_REFS_DIE_ON_ERR))
>  		return 1;

nit, not needing a change: Preexisting long line.

I wonder if we can teach "make style" to perform line wrapping
correctly and fix those all at once e.g. in builtin/ at some point.
When reading, a consistent line length is helpful, but reviewing each
patch for it feels like wasted time.

[...]
> --- a/refs.c
> +++ b/refs.c
> @@ -985,17 +985,9 @@ int ref_transaction_verify(struct ref_transaction *transaction,
>  				      flags, NULL, err);
>  }
>  
> -int update_ref_oid(const char *msg, const char *refname,
> -	       const struct object_id *new_oid, const struct object_id *old_oid,
> -	       unsigned int flags, enum action_on_err onerr)
> -{
> -	return update_ref(msg, refname, new_oid ? new_oid->hash : NULL,
> -		old_oid ? old_oid->hash : NULL, flags, onerr);
> -}
> -

Yay!

[...]
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1114,12 +1114,10 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  	 * write it at all.
>  	 */
>  	if (command == TODO_PICK && !opts->no_commit && (res == 0 || res == 1) &&
> -	    update_ref(NULL, "CHERRY_PICK_HEAD", commit->object.oid.hash, NULL,
> -		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
> +	    update_ref(NULL, "CHERRY_PICK_HEAD", &commit->object.oid, NULL, REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
>  		res = -1;
>  	if (command == TODO_REVERT && ((opts->no_commit && res == 0) || res == 1) &&
> -	    update_ref(NULL, "REVERT_HEAD", commit->object.oid.hash, NULL,
> -		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
> +	    update_ref(NULL, "REVERT_HEAD", &commit->object.oid, NULL, REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))

Long lines.

[...]
> @@ -2123,8 +2121,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  			}
>  			msg = reflog_message(opts, "finish", "%s onto %s",
>  				head_ref.buf, buf.buf);
> -			if (update_ref(msg, head_ref.buf, head.hash, orig.hash,
> -					REF_NODEREF, UPDATE_REFS_MSG_ON_ERR)) {
> +			if (update_ref(msg, head_ref.buf, &head, &orig, REF_NODEREF, UPDATE_REFS_MSG_ON_ERR)) {
>  				res = error(_("could not update %s"),
>  					head_ref.buf);

Likewise.

As mentioned above, I am not too worried about the line length issues
(none of these is particularly jarring).  For what it's worth,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
