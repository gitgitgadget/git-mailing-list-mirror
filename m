Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48F4C20248
	for <e@80x24.org>; Wed,  6 Mar 2019 04:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfCFEnO (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 23:43:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35961 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfCFEnN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 23:43:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so4575990wmj.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 20:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bRllcS6GgLxS049vrFP5dvn9nJyRj62wUsfB7wn77ME=;
        b=gXIG2zyHZQaTyEfv8lvxqBWMweFYwyKDZ4DWcYwGIlNwxfql8XqHodZPHrRmL6NFQU
         ILXR9KW4Lo7KtEkU8ByQqQZtms8v7jfUwkUVcct1paxbsP0fIEe3KaDsuU9o9L9FvFPy
         pA/N6DCoT64XX0tfknoHFqlLBwK+nk1AZNCjKbHnihLI1OYaU79t6qqPsCva+KBIcUBx
         C6W9AMl0R2PYcXgymGCnB/2rXUeanihl8pcBoyWtOXNbF8748OiJYXru1F5SSy40NnMi
         FryDSjy9+5pg6KiPNBsKJsbhhZkOGFWWX0TCRZoMRUrVjW2BdEt0Pj8kwZNmi5hGJrV3
         dn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bRllcS6GgLxS049vrFP5dvn9nJyRj62wUsfB7wn77ME=;
        b=q66lhcSYWldW3zIXEX2Yst4lvKbqV0fFYop1fvtwXUgmDqjrhQNQm7QKUx3C/gRBJu
         Egugnc0VAiORWPLSdAjEfFAE0WrhKMMpl41NmCZWxgIJL8kzFgixO/A9vY+bqswsTzQ8
         yhFBOdmODrX0xbDRXU0+kfZ3UTl2EChfcrUSGzQQtAciNyBNQQqWAGyjoHuC7+kUXdPU
         dAZe4hQ7+sDulOVSt1m/zOJYfAdni4Ilet779h46khoQ16NqpJ8nEX4DU7xi/aOkHPdd
         M+LKofPji2uCgnDaLZfMK++wATDkq/VibL5TyWDyWxdN6JeHf/bqUsd83LFA4XHhZpuU
         xYZA==
X-Gm-Message-State: APjAAAXFdLUj3ahap6u1HAPcfsBpMlJVkwEd63mm+Mrh0MtVVIeE+a4l
        SvOpGnwWb4rFFpEYAz0Jg9k=
X-Google-Smtp-Source: APXvYqy7zQjfkC6cibW6W0F8JKBv/2yUwKdFXs11xouztna0q4fNeSx8FZrMaHGpfeBipzqn8UmhaA==
X-Received: by 2002:a1c:5f89:: with SMTP id t131mr1095925wmb.46.1551847390176;
        Tue, 05 Mar 2019 20:43:10 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e193sm1462710wmg.18.2019.03.05.20.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 20:43:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>
Subject: Re: [BUG] All files in folder are moved when cherry-picking commit that moves fewer files
References: <xmqqimx03fo6.fsf@gitster-ct.c.googlers.com>
        <20190306002744.14418-1-newren@gmail.com>
Date:   Wed, 06 Mar 2019 13:43:08 +0900
In-Reply-To: <20190306002744.14418-1-newren@gmail.com> (Elijah Newren's
        message of "Tue, 5 Mar 2019 16:27:44 -0800")
Message-ID: <xmqqh8cgr4tf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Note that there is also a third possibility here:
>
>   C) There are different answers depending on the context and content
>      that cannot be determined by git, so this is a conflict.  Use a
>      higher stage in the index to record the conflict and notify the
>      user of the potential issue instead of silently selecting a
>      resolution for them.
>
> Add an option for users to specify their preference for whether to use
> directory rename detection, and default to (C).

Yeah, (c) is the sanest default that can give the best of both
worlds, I would have to say.

Sometimes the heuristics guess that the new one may want to go to
the same place as all the neighbours, and other times the new one
may want to stay.  By using stage #2 and stage #3 appropriately, the
user can see where the final result wants to be in.  Because by
definition there won't be any auto-resolvable content-level merge
for such paths (after all, one side is adding it as a new file), I
think the contents for these two higher-stage entries would actually
be the same?

> +	if (mark_conflicted)
> +		output(o, 1, _("CONFLICT (directory possibly renamed): %s "
> +			       "added in %s, but that directory was renamed "
> +			       "in %s suggesting it should perhaps be moved "
> +			       "to %s."),
> +		       pair->one->path, other_branch, rename_branch,
> +		       dest->path);

What confused the end user is that it is not always the case, and
that is because the only thing we know at this point is that the
other branch moved all the files in that directory in their branch
to the other place, not that they "moved the directory".

In other words, if "that directory was renamed" in this message were
definitive and agreed with end-user perception, we won't be issuing
this conflict with a label that says "possibly" renamed.

Perhaps something along this line?

	%(pair->one->path)s added in %(other_branch)s, but the other
	branch %(rename_branch)s moved all the files in the same
	directory to %(dirname(dest->path))s, so this file may also
	want to move there, too.

>  	if (!o->call_depth && would_lose_untracked(o, dest->path)) {
> -		char *alt_path = unique_path(o, dest->path, rename_branch);
> -
> +		mark_conflicted = 1;
> +		file_path = unique_path(o, dest->path, rename_branch);
>  		output(o, 1, _("Error: Refusing to lose untracked file at %s; "
>  			       "writing to %s instead."),
> -		       dest->path, alt_path);
> +		       dest->path, file_path);
> +	}
> +
> +	if (mark_conflicted) {
>  		/*
> -		 * Write the file in worktree at alt_path, but not in the
> -		 * index.  Instead, write to dest->path for the index but
> -		 * only at the higher appropriate stage.
> +		 * Write the file in worktree at file_path.  In the index,
> +		 * only record the file at dest->path in the appropriate
> +		 * higher stage.
>  		 */
> -		if (update_file(o, 0, &dest->oid, dest->mode, alt_path))
> +		if (update_file(o, 0, &dest->oid, dest->mode, file_path))
>  			return -1;
> +		if (update_stages(o, dest->path, NULL,
> +				  rename_branch == o->branch1 ? dest : NULL,
> +				  rename_branch == o->branch1 ? NULL : dest))
> +			return -1;

This one does not issue "may want to stay here" comment of its own,
so the earlier "CONFLICT (directory possibly renamed)" message would
need to cover both of these two higher-stage entries.  I think the
message mentions the two paths, so it would be good already.

The earlier "CONFLICT (directory possibly renamed)" message may be
sufficient to explain the situation, but I wonder if the user would
need hints in resolving either of the two possible ways.  I do not
know if it should be in the same message, or in the manpage update,
but first let's make sure what we want the end users to understand.
IIUC, the hint for resolving in favor of either would be to do these
two commands?

	git checkout --ours $path_the_user_wants_to_use
	git rm --cached $the_other_path

If the path the user wants to use matches what the branch being
merged has, then replace "--ours" above with "--theirs".

Would that be a good explanation?

Regarding the implementation (not the use of stages, but how
"mark_conflicted" variable gets used), I am not sure if I agree that
only choice (c) should give the hint.  Regardless of the settings,
we know both paths this file may want to end up with, and I suspect
that the alternative a/b/c you gave are how by default the tool
automatically places the result, giving a chance to the end user to
correct mistakes.  I wonder if it is possible to somehow show "the
other possibilty" in the merge log even when choice (a) or (b) are
in effect?  E.g. "path X/B moved to Y/B because the other side moved
X/A to Y/A" when choice (b) is in use, and "path X/B kept there but
the other side moved neighbouring A/X to Y/A" when choice (a) is in
use.

Another thing that makes me wonder is if this should be treated
similar to rerere.autoupdate; even when rerere kicks in to resolve
otherwise conflicting tricky merge, without being explicitly allowed
with the config, it does not register the resolution to the index at
stage #0.  Either choices (a) that ignores neighbouring files'
movement or (b) that follows the movement lets this tricky
heuristics not just suggest the end result, but allows it to
register the result at stage #0, which somehow feels too aggressive
(which was what triggered my suggestion to go with (c)).  With that
attitude, we may be able to get rid of choice (a) altogether, which
may make things a tad simpler.  IOW, we assume the heuristics would
suggest the right solution most of the time, just like we assume
rerere gives a reasonable resolution most of the time, with a knob
to accept the result blindly, together with hints to recover when
heuristics makes mistakes.

