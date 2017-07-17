Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B9E20357
	for <e@80x24.org>; Mon, 17 Jul 2017 21:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbdGQVsV (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 17:48:21 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35466 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbdGQVsT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 17:48:19 -0400
Received: by mail-pg0-f43.google.com with SMTP id v190so1251147pgv.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 14:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rdE1S5UaNMyEgk+rJ0hJAIaj85Y/+44oay9yaWd1BEA=;
        b=eyLNoV8/52/G5J3bDJTwppoIkkGHcynYTKXz8hD5v2CRTrH/Y7y6rOdhifFWYbFuHq
         Mqs5yzoHKWe+H3aAxSs6qnyFCmiIYd54y+da9Y155vKGUrd9pLKPlhRPsHjrKkpYjHS0
         ocrKoJ7un2YN7ghH26vl6lCIENgFypvBhhduw0NuQnuDnqMN+tgX+0tiN9qE9mitP10h
         7iNhF0C8q3VjpJVUDJfC+GopOCCxj7uDozF9QNlxR+tCjwY3ILh+/nv3viGlfXQEsiZj
         k4PMIsyHpFG8lQs0s2GM7a8A8scvG07Y6TumGwZKzCDzw0030EqF4wtz2JBmS7Wj2Xib
         822g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rdE1S5UaNMyEgk+rJ0hJAIaj85Y/+44oay9yaWd1BEA=;
        b=f2xRGkXTA1dk3PJnN4lnWX8fiQh1Srv5KpxHs2ddZWZd9RBWuFOrX1TkfQqCWulzan
         OtYgPwxL3FbgzJI0udKPwBdW5RtgqHmoNbX0LJ1PzHMs88ganiR1aIZdpkrLjsnLmZ+p
         WEkMRLRSkZIsy2ZTk9OD/JkwWmTNL2zpU1i6R42B6kGTsK/qauyx7nySAGoVtoh85E3x
         uZ5yNKxubIW7J6oZO+dgRZ/LK98lhatqTMkB/AyRyI1N40kpVNHUChD1TubyuzgIXZ9k
         KTHJLrc6l4IGBshD8mIVxUw9luBE+1fTgMCJKPtsA/7SJEwaM+ImuuuTrLeUDNLXhi9G
         Qz6A==
X-Gm-Message-State: AIVw110xjO8w2ebkjFOwrkajklwm+M3vGAmlddjEpBYvX/8GwIlEYb9c
        ahSPMO8kTK8sdg==
X-Received: by 10.84.206.37 with SMTP id f34mr32262937ple.262.1500328098888;
        Mon, 17 Jul 2017 14:48:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id q3sm426626pfk.8.2017.07.17.14.48.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 14:48:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RFC: A new type of symbolic refs
References: <20170711010639.31398-1-sbeller@google.com>
Date:   Mon, 17 Jul 2017 14:48:17 -0700
In-Reply-To: <20170711010639.31398-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 10 Jul 2017 18:06:39 -0700")
Message-ID: <xmqqvamqg2fy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +int read_external_symref(struct strbuf *from, struct strbuf *out)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	const char *repo, *gitlink;
> +	int hint, code;
> +	struct strbuf **split = strbuf_split(from, 0);
> +	struct strbuf cmd_out = STRBUF_INIT;
> +
> +	if (!split[0] || !split[1])
> +		return -1;
> +
> +	repo = split[0]->buf + 5; /* skip 'repo:' */
> +	gitlink = split[1]->buf;
> +
> +	argv_array_pushl(&cp.args,
> +			"ignored-first-arg",
> +			"-C", repo,
> +			"ls-tree", "-z", "HEAD", "--", gitlink, NULL);
> +
> +	/*
> +	 * 17 accounts for '160000 commit ',
> +	 * the \t before path and trailing \0.
> +	 */
> +	hint = 17 + GIT_SHA1_HEXSZ + split[1]->len;
> +	code = capture_command(&cp, &cmd_out, hint);
> +
> +	strbuf_release(split[0]);
> +	strbuf_release(split[1]);
> +
> +	if (!code) {
> +		strbuf_reset(out);
> +		strbuf_add(out, cmd_out.buf + strlen("160000 commit "),
> +			   GIT_SHA1_HEXSZ);
> +	} else
> +		return -1;
> +
> +	return 0;
> +}

This may help the initial checkout, but to be useful after that, we
need to define what happens when an equivalent of "git update-ref
HEAD" is done in the submodule repository, when HEAD is pointing
elsewhere.  The above only shows read-only operation, which is not
all that interesting.

I _think_ a symbolic HEAD that points upwards to the gitlink entry in
the superproject's index is the easiest to understand and it is
something we can define a clear and useful semantics for.

When a recursive checkout of a branch 'foo' is made in the
superproject, the index in the superproject would name the commit in
the submodule to be checked out.  We traditionally detech the HEAD
at the submodule to that commit, but instead we could say "check the
index of the superproject to see where the HEAD should be pointing
at" in the submodule.  Either way, immediately after such a
recursive checkout, "git status" inside the submodule would find
that the HEAD points at the commit recorded in the 'foo' branch of
the superproject and things are clean.  

After you work in the submodule and make a commit, an equivalent of
"git update-ref HEAD" is done behind the scene to update HEAD in the
submodule.  In the traditional world, that is done to detached HEAD
and nothing else changes, but if the symref HEAD points upwards into
the index of the superproject, what needs to be done is very obvious;
we do "git add submodule" in the superproject.  And this is not just
limited to creating a commit in the submodule.  "reset --hard HEAD~2"
in the submodule to rewind the HEAD by two commits would also be an
update to HEAD and through the symref-ness of the HEAD should result
in an update to the index of the superproject.

However, I do not think a good explanation of what should mean when
this new-style symbolic HEAD points at a commit in the superproject,
whether its limited to its HEAD or a tip of an arbitrary branch that
may not even be checked out.  These are not something we can easily
change without affecting wider context.  Our submodule, when we make
a new commit, may be ready to advance, but our superproject and
other submodules may not be ready to be included in a new commit in
the superproject.

So I think the idea this patch illustrates is on to something
interesting and potentially useful, but I am not sure if it makes
sense to tie it to anything but the index of the superproject.

Even if we limit ourselves to pointing at the index of the
superproject, there probably are a handful of interesting issues
that need to be clarified (not in the sense of "this and that issues
exist, so this won't be a useful feature", but in the sense of "we'd
be able to do these useful things using this feature, and we need to
fill in more details"), such as:

 - Making new commits in the submodule available to the upstream.
   Just like a detached HEAD in the submodule, this is not tied to
   any concrete branch, and it is unclear how a recursive "push"
   from the superproject should propagate the changes to the
   upstream of the submodule;

 - Switching between branches that bind the same commit for the
   submodule in the superproject would work just like switching
   between branches that record the same blob for a path, i.e. it
   will carry forward a local modification.

 - The index entry in the superproject may now have to get involved
   in fsck and reachability study in the submodule as reachability
   root.  A corollary to this is that submodules behave more
   similarly to regular blobs wrt "git reset --hard" in the
   superproject, which is a good thing.  "git -C submodule commit &&
   git reset --hard" will create a new commit in the submodule, add
   it to the index of the superproject, and then lose that change
   from the index of the superproject, making the commit
   unreachable, just like "edit file && git add file && git reset
   --hard" in the superproject will make the blob that records the
   updated content of the file unreachable.

Thanks.
