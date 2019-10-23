Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7836C1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 04:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbfJWEsp (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 00:48:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63009 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731061AbfJWEsp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 00:48:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B67B80DD4;
        Wed, 23 Oct 2019 00:48:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NfN8m4D1XegJLhXmgXr2lvQby14=; b=VqaqKc
        0hK3QLUtgrp1c0YExFw2osT6BMhXvXm+x8g1/2CMwQ6pmThnrpPToRA62j9bttjo
        ZG3m+1AXJq68L/d5/bdyFMZ7m+K76BMlzJCA6+UgRsRbSj4NjBUaPB8uLD91xLay
        /j841yD3ro0z8Tod6B8bIPx+Jrc5TG+zDrd1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SwBe4ni72Z200NNUX53GT/wp2DQYJ/8x
        cB+jJ0P5fXprSi+n7NdKAKLITgePhd5+fiTrzD60pjPobxQJ4Mm1rogwLCJizC2/
        gI2pUQSaBW9FHHp6kGcX2jffL7h7Y0YYPBJh8QgJLE8L2rZtkhEvhJSIFBp9A4nb
        +BNwl79CMdo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 929AE80DD2;
        Wed, 23 Oct 2019 00:48:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B79E280DCF;
        Wed, 23 Oct 2019 00:48:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, pedro rijo <pedrorijo91@gmail.com>,
        James Ramsay <james@jramsay.com.au>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [Git Developer Blog] [PATCH] post: a tour of git's object types
References: <20191019002045.148579-1-emilyshaffer@google.com>
Date:   Wed, 23 Oct 2019 13:48:32 +0900
In-Reply-To: <20191019002045.148579-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Fri, 18 Oct 2019 17:20:45 -0700")
Message-ID: <xmqq1rv4hxsv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EC57E72-F550-11E9-8C52-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +# Commit
> +
> +This is the one we're all familiar with - commits are those things we write at
> +1am, angry at a pesky bug, and label with something like "really fix it this
> +time", right?
> +
> +A commit references exactly one tree. That's the root directory of your project.
> +It also references zero or more other commits - and this is where we diverge
> +from the filesystem parallel, because the other commits it references are its
> +parent(s), each of which has its own copy of the project at that commit's point
> +in time. (Commits with more than one parent are merge commits; otherwise, your
> +commit only has the one parent.)

I do not see a need for (parentheses) around the last sentence, but if
you must, then s/in time. /in time/; and s/one parent.)/one parent)./
would be better.

> +Commits represent a specific state of the repository which someone thought was
> +worth saving - a new feature, or a small step of progress which you don't want
> +to lose as you're hacking your way through that homework assignment. Each commit
> +points to a complete image of the repository - but that's not as bad as it
> +sounds, as we'll see when we try it out.

That's half of a commit (i.e. the tree that represents the specific
state).  

The other half is that a commit (at least in a serious-enough
project) is a statement by its author: I considered all the parent
commits, and declare that the tree this commit records suits my goal
better than any and all of these parents' trees.

That is what makes 3-way merge work correctly at the philosophical
level.  As long as the project participants share the same goal and
trust each other, when one creates a merge, one trusts what the
others built in the side branch (i.e. each of the commits they made
got us closer to our collective goals) and take their changes to
where one did not touch.

Of course, a good description in the log message helps the one
who makes such a merge to see if the workmade on the side branch
moves the tree in the direction that truly fits one's goal.

> +# Tag
> +
> +Tags are a little lackluster after all the exciting types up until now. They are
> +essentially a label; they serve as an entry point into the graph and point to
> +either another tag or a commit.

Either say "generally point to", or "point to another object"
(i.e. a tag that points to a tree or a blob is normal---it is just
they do not so frequently appear).

> They're generally used to mark releases, and you
> +can see them pretty easily with `git log --oneline --decorate=full`.
> +
> +# A quick return to an overloaded word
> +
> +"Tree", "worktree", and "working tree" seem to refer to different concepts.

Not just seem to.  They do refer to different things.  "tree" is a
type of object.  "working tree" is a directory hiearchy where you
did "git checkout" to materialize the contents of a tree object
(recursively) and are using to work towards updating the index to
create the next commit.  "worktree" is a mechanism that allows you
to have multiple "working tree"s that is backed by the same repository.

They may share the same word "tree".  You may want to update this
document to say "tree object" when you mean it---that would help
disambiguating it from other uses of words with "tree" in them.

> ...
> +predictable way. Let's walk through creating a pretty basic repository and
> +examining it with some low-level plumbing commands!
> +
> +# An empty repo
> +
> +For starters, we'll make a new, shiny, totally empty repo.
> +
> +{% highlight shell_session %}
> +$ mkdir demo
> +$ cd demo
> +$ git init
> +{% endhighlight %}
> +
> +We've got nothing. If we try `git log`, we'll be assured that we have no
> +commits, and if we try `git branch -a` we'll see we have no branches, either.
> +So let's make a very simple first commit.
> +
> +# A single commit
> +
> +{% highlight shell_session %}
> +$ echo "abcd" >foo.txt
> +$ git add foo.txt
> +$ git commit -m "first commit"
> +{% endhighlight %}
> +
> +I know this is boring, but bear with me and run `git ls-tree HEAD`.

You may probably want to say that, even though you upfront raised
the expectation of readers that they would hear about plumbing soon,
you haven't so far used any plumbing yet.  And stress that ls-tree
is a plumbing, what the readers have been waiting for!

> +{% highlight shell_session %}
> +$ git ls-tree HEAD
> +100644 blob acbe86c7c89586e0912a0a851bacf309c595c308	foo.txt
> +$ git cat-file -p acbe86c7c89586e0912a0a851bacf309c595c308
> +abcd
> +{% endhighlight %}
> +
> +While we're here, we can also take a look at the commit object. Use `git log`
> +to determine your commit's OID, then use `git cat-file -p` to print the
> +contents:

I doubt that "cat-file -p" is helpful to a reader who is learning
the basic object layer.  For non-tree types, learning "cat-file -t"
followed by "cat-file <type>" would be more useful to gain proper
understanding (and for trees, as you showed above, ls-tree would be
a good tool).  After learning them, "cat-file -p" can be introduced
as a intelligent tool to switch the behaviour depending on the type
of objects, but not before.

