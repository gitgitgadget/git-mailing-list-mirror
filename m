Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EBCC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 18:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053E422B42
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 18:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xLlDWw9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbgGaS0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:26:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54069 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387652AbgGaS0t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 14:26:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 82C9CEC694;
        Fri, 31 Jul 2020 14:26:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I8eRJCBmThWRGgZjMA8RFNA2vhk=; b=xLlDWw
        9TKwGKCfLsZcNBS7GgIUUdhWIymaeY/bZlzpdpRlzR6kMyK3vAyR6ajnkZ9QyR/M
        7akNXPaXVq38T9yJjHgsSTJSngYnzwd/tC512ScBZNOF/HAIolXpjqpjbDvIAWOP
        1YnRx/eHOT7vaYe7F6WRxbV+EFQ+HCb9oGQt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s4R89os+hpD5T7ET14yl2M9I3P62UdyS
        QBUQeo5PhELt7Qpl1tw+0yRzN8cww0ZgacFeFd0zvvkABG9sZAFXQbx4N1L/Kpoo
        ErdaCGA4BhhsmdVe5Y4r3RFatW8+kk/aOPgofqKxivWxIIi4aqBz+xy0JnnY6Va4
        OcvX4cv2StU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B5A8EC693;
        Fri, 31 Jul 2020 14:26:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C84FCEC692;
        Fri, 31 Jul 2020 14:26:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH v3 2/6] stash: remove the second index in stash_working_tree()
References: <20200630151558.20975-1-alban.gruin@gmail.com>
        <20200731165140.29197-1-alban.gruin@gmail.com>
        <20200731165140.29197-3-alban.gruin@gmail.com>
Date:   Fri, 31 Jul 2020 11:26:41 -0700
In-Reply-To: <20200731165140.29197-3-alban.gruin@gmail.com> (Alban Gruin's
        message of "Fri, 31 Jul 2020 18:51:36 +0200")
Message-ID: <xmqqy2mz35i6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 629FF4A2-D35B-11EA-BD38-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This removes the second index used in stash_working_tree() to simplify
> the code.

Continuing what I said for [0/6], say "the second index file" to
clarify the distinction between the in-core index and on-disk index
files to avoid confusion.

>  	init_revisions(&rev, NULL);
>  	copy_pathspec(&rev.prune_data, ps);
>  
> -	set_alternate_index_output(stash_index_path.buf);
>  	if (reset_tree(&info->i_tree, 0, 0)) {
>  		ret = -1;
>  		goto done;
>  	}
> -	set_alternate_index_output(NULL);

Hmph.  So at this point i_tree is what is in the index, we reset the
working tree to it with reset_tree(), and instead of writing to
$TMPindex, we let reset_tree() clobber the main on-disk index but we
do not care because the result is supposed to be the same as what
was originally in the index anyway?

> @@ -1091,8 +1088,6 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
>  	argv_array_pushl(&cp_upd_index.args, "update-index",
>  			 "--ignore-skip-worktree-entries",
>  			 "-z", "--add", "--remove", "--stdin", NULL);
> -	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
> -			 stash_index_path.buf);
>  
>  	if (pipe_command(&cp_upd_index, diff_output.buf, diff_output.len,
>  			 NULL, 0, NULL, 0)) {

And then the new code now lets "update-index" work directly on the
main index (which does make an observable difference to the outside
world, but we are not letting any hook to look at this intermediate
state, so it might be OK---I cannot tell at this point in the code).

> @@ -1100,19 +1095,16 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
>  		goto done;
>  	}
>  
> -	if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
> -				NULL)) {
> +	discard_cache();
> +	if (write_cache_as_tree(&info->w_tree, 0, NULL) ||
> +	    reset_tree(&info->i_tree, 0, 1))

We used to read from $TMPindex, which has been updated with the
contents of files modified in the working tree, and write its
content out as a tree object, grabbing its object name into w_tree.

The new code instead writes out the same tree from the main index,
which has been clobbered with the working tree changes that the user
hasn't added to the index.  Because of that, we need to discard
these changes and re-read the in-core index out of i_tree with
reset_tree().

So, this change makes one new call to reset_tree() that scans and
updates working tree files that are modified?  How expensive is
that?  

It's not like this change trades cost to write out a temporary index
file with the cost of having to call reset_tree() one more time---as
far as I can see, the new code writes to on-disk index file the same
time as the original code.

How is the use of second on-disk index hurting us?  I must be
missing something obvious, but at this point, it is not clear what
we are gaining---I only see downsides.

