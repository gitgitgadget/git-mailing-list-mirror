Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 394221F954
	for <e@80x24.org>; Sun, 19 Aug 2018 08:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbeHSL2d (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 07:28:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34373 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeHSL2d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 07:28:33 -0400
Received: by mail-wm0-f65.google.com with SMTP id l2-v6so4661332wme.1
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 01:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XwUBrgHWxjiVeFJjYwHdNcdE2MGqL9yX9b1i2XkOR/g=;
        b=L1DeMVddkHYQVZ0oBHzRLGf/wBxqW1+myIDlx+/OqeBg7kt7EQjHqUbEkTIDRbzoIb
         BZzVwk4sri22eLEgD5qZBzBV1yJ6sobkex+xv4+iCGHnLze1cZi/DDKqjpNu+h6aLZYr
         MHTw3eQ7JNKxq0MQYOgntVaVqYTnnNDqnHacBk+4XCcVYKSGGVRa9kc1ivOp2qx2mR1Q
         fKyVebNqNH1rKejnrgoAlOyYJ7TOK6Ahip/aIM/CXqj8YTVBFyMfxQ/048ahXI9HNtSQ
         kwUDPojUJ0IYksUeQsPctmf373yxh4ec1XhJ6I+GPDtQ5IIXK38KV6gdOglhUt6Xorj+
         ahGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XwUBrgHWxjiVeFJjYwHdNcdE2MGqL9yX9b1i2XkOR/g=;
        b=eoeA83VqXLFUZkvxw+YORvX9EvPeFByvTtbpsrVU3jWH0Gy5x4wF34I/nLLOYtJtbr
         SA0EZxhIfh7+A5D+jULoZIoxcoYfK0jCDppOJPb14wUDHKHeFCul31MXb4PAGbrW19/e
         7Qbi0F3bkfoQODBRvgH0FddOIgeUtwTXZzR5rURKVrgf29mZZhDhZzBNiN7eq82VDVRx
         yvToaOQpo/6W19kJ9xTelNztytYIwSgxijkHnd4xaia9IEwTxB19XQ6vlj5elQYPeFIN
         bWyS25GnMZIpoMHeB8ko/aaqcVO9jbmG/4hrsY35+85lxFiZ/oMV66er11vn3IBAZo4E
         bwCQ==
X-Gm-Message-State: AOUpUlG2jQbrCharGc5uKqUyMFgLgdR59iU8GXqQkkKPXbpGImHOFGhZ
        v1BYyVYdxaDQnPDBZnD1DhHUyEfr
X-Google-Smtp-Source: AA+uWPzIPCKEbc3pTtMRTtDd+Aq3gAtps1UDrsxe0tqBgfMbF3fxmuJkeQShHhLan9LkSAJ85gj/eA==
X-Received: by 2002:a1c:7e92:: with SMTP id z140-v6mr22012051wmc.48.1534666669820;
        Sun, 19 Aug 2018 01:17:49 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id c12-v6sm6314197wrr.6.2018.08.19.01.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Aug 2018 01:17:48 -0700 (PDT)
Date:   Sun, 19 Aug 2018 09:17:47 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 25/26] stash: replace all `write-tree` child
 processes with API calls
Message-ID: <20180819081747.GE13316@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <3b4a3b766598589df30e16cddf175f039eb4e290.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b4a3b766598589df30e16cddf175f039eb4e290.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> This commit replaces spawning `git write-tree` with API calls.
> ---
>  builtin/stash.c | 40 ++++++++++++----------------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)

Nice reduction in lines here!

> 
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 4d5c0d16e..46e76a34e 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -949,9 +949,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
>  {
>  	int ret = 0;
>  	struct strbuf untracked_msg = STRBUF_INIT;
> -	struct strbuf out2 = STRBUF_INIT;
>  	struct child_process cp = CHILD_PROCESS_INIT;
> -	struct child_process cp2 = CHILD_PROCESS_INIT;
> +	struct index_state state = { NULL };

We often call this 'istate' throughout the codebase.  Would be nice to
call it that here as well, to reduce the cognitive load for people
already familiar with the codebase.

>  
>  	cp.git_cmd = 1;
>  	argv_array_pushl(&cp.args, "update-index", "--add",
> @@ -966,15 +965,11 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
>  		goto done;
>  	}
>  
> -	cp2.git_cmd = 1;
> -	argv_array_push(&cp2.args, "write-tree");
> -	argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s",
> -			 stash_index_path.buf);
> -	if (pipe_command(&cp2, NULL, 0, &out2, 0,NULL, 0)) {
> +	if (write_index_as_tree(&info->u_tree, &state, stash_index_path.buf, 0,
> +				NULL)) {
>  		ret = -1;
>  		goto done;
>  	}
> -	get_oid_hex(out2.buf, &info->u_tree);
>  
>  	if (commit_tree(untracked_msg.buf, untracked_msg.len,
>  			&info->u_tree, NULL, &info->u_commit, NULL, NULL)) {
> @@ -984,7 +979,6 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
>  
>  done:
>  	strbuf_release(&untracked_msg);
> -	strbuf_release(&out2);
>  	remove_path(stash_index_path.buf);
>  	return ret;
>  }
> @@ -994,11 +988,10 @@ static struct strbuf patch = STRBUF_INIT;
>  static int stash_patch(struct stash_info *info, const char **argv)
>  {
>  	int ret = 0;
> -	struct strbuf out2 = STRBUF_INIT;
>  	struct child_process cp0 = CHILD_PROCESS_INIT;
>  	struct child_process cp1 = CHILD_PROCESS_INIT;
> -	struct child_process cp2 = CHILD_PROCESS_INIT;
>  	struct child_process cp3 = CHILD_PROCESS_INIT;
> +	struct index_state state = { NULL };
>  
>  	remove_path(stash_index_path.buf);
>  
> @@ -1023,17 +1016,12 @@ static int stash_patch(struct stash_info *info, const char **argv)
>  		goto done;
>  	}
>  
> -	cp2.git_cmd = 1;
> -	argv_array_push(&cp2.args, "write-tree");
> -	argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s",
> -			 stash_index_path.buf);
> -	if (pipe_command(&cp2, NULL, 0, &out2, 0,NULL, 0)) {
> +	if (write_index_as_tree(&info->w_tree, &state, stash_index_path.buf, 0,
> +				NULL)) {
>  		ret = -1;
>  		goto done;
>  	}
>  
> -	get_oid_hex(out2.buf, &info->w_tree);
> -
>  	cp3.git_cmd = 1;
>  	argv_array_pushl(&cp3.args, "diff-tree", "-p", "HEAD",
>  			 oid_to_hex(&info->w_tree), "--", NULL);
> @@ -1046,7 +1034,6 @@ static int stash_patch(struct stash_info *info, const char **argv)
>  	}
>  
>  done:
> -	strbuf_release(&out2);
>  	remove_path(stash_index_path.buf);
>  	return ret;
>  }
> @@ -1056,11 +1043,10 @@ static int stash_working_tree(struct stash_info *info,
>  {
>  	int ret = 0;
>  	struct child_process cp2 = CHILD_PROCESS_INIT;
> -	struct child_process cp3 = CHILD_PROCESS_INIT;
> -	struct strbuf out3 = STRBUF_INIT;
>  	struct argv_array args = ARGV_ARRAY_INIT;
>  	struct strbuf diff_output = STRBUF_INIT;
>  	struct rev_info rev;
> +	struct index_state state = { NULL };
>  
>  	set_alternate_index_output(stash_index_path.buf);
>  	if (reset_tree(&info->i_tree, 0, 0)) {
> @@ -1103,20 +1089,18 @@ static int stash_working_tree(struct stash_info *info,
>  		goto done;
>  	}
>  
> -	cp3.git_cmd = 1;
> -	argv_array_push(&cp3.args, "write-tree");
> -	argv_array_pushf(&cp3.env_array, "GIT_INDEX_FILE=%s",
> -			 stash_index_path.buf);
> -	if (pipe_command(&cp3, NULL, 0, &out3, 0,NULL, 0)) {
> +	if (write_index_as_tree(&info->w_tree, &state, stash_index_path.buf, 0,
> +				NULL)) {
> +
>  		ret = -1;
>  		goto done;
>  	}
>  
> -	get_oid_hex(out3.buf, &info->w_tree);
> +	discard_cache();
> +	read_cache();

This 'discard_cache()'/'read_cache()' pair surprises me a bit, and I
can't figure out why it's necessary now. 'write_index_as_tree()' reads
and writes from the index file at 'stash_index_path', while
'{discard,read}_cache()' operate on 'the_index', which should always be
distinct from the temporary index we are using here.  So this
shouldn't be needed, at least not because of the changes we are making
in this patch.

>  
>  done:
>  	UNLEAK(rev);
> -	strbuf_release(&out3);
>  	argv_array_clear(&args);
>  	object_array_clear(&rev.pending);
>  	strbuf_release(&diff_output);
> -- 
> 2.18.0.573.g56500d98f
> 
