Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414CEC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 14:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F38206C3
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 14:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jsr6Y0gQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgFKOom (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:44:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56308 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgFKOol (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 10:44:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A886706B8;
        Thu, 11 Jun 2020 10:44:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GCHVbX+S34NDv1WAdhgz79aHG8Q=; b=Jsr6Y0
        gQQR28zU6LJavRJIizir4LkwCPTxrRKPS1l/nUOQOAS7s0uUcQ9JmB0a9xAeT2OJ
        Kkpqf+/mnN4mqpoBB+1Cwcp7CIPancJsBF3+DvVbFVLHzWVJOq+hVwh98sZJ6ybg
        tvI6ZyZClp7Z6LOe9IlN5aM45kzwys1efrAfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CsJIT1Qk0TlcZXGH+nXCGhfTxPb+ZTje
        mzvqtc9V5qwPZ2DGgGkQaKKTCeQK6lBGHTmFPRAGmUVTH6VAfVNnMXDBO0WaHpyZ
        nkWvLPYHJVSXPaVbpuIRvuVzKqzlVggiS2ECTQPDbHo4lKNnKM7LrccEf2NoeGaL
        PJlu4bl/AJo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BA59706B7;
        Thu, 11 Jun 2020 10:44:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D710F706B3;
        Thu, 11 Jun 2020 10:44:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default branch
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <xmqqk10eecsg.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006111533140.56@tvgsbejvaqbjf.bet>
Date:   Thu, 11 Jun 2020 07:44:35 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006111533140.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 11 Jun 2020 15:44:11 +0200 (CEST)")
Message-ID: <xmqqtuzhbr1o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 127F3D2E-ABF2-11EA-9398-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I read this (way too late) last night and slept over it. Together with
> your comment on the `fmt-merge-msg` patch, I think you are really on to
> something: we need _two_ config settings, as there are two distinct
> concepts at play here:
>
> - One setting to specify the default branch name for newly-initialized
>   repositories (such as `git init`, unless it re-initializes, and `git
>   clone` when the cloned repository does not yet contain any branches).
>
>   This should probably be called `init.defaultBranchName` (even if `git
>   clone` picks it up, too), and be overrideable by
>   `GIT_TEST_DEFAULT_BRANCH_NAME`.

Yes.


> - And another one, to define the default branch name for the _current_
>   repository. This setting would be configured implicitly upon `git init`

Nit.  This is not the "default" branch name.  It is "which branch is
the primary one in this repository?"  There is no default.

>   and `git clone`. For repositories where it is not set, we would assume
>   `master` for backwards-compatibility.
>
>   Technically, this should probably not even be a config option because it
>   is _strictly_ per-repo. But maybe it is not _so_ much per-repo: if I
>   want to rename all my main branches in all of my local repositories, I
>   might opt to configure this in `~/.gitconfig`.
>
>   Maybe a good name for this would be `repo.mainBranch` (and it would
>   contain the full ref name, e.g. `refs/heads/main`, not just `main`).

I think core.* namespace originally were supposed to be about "this"
repository, so instead of introducing "repo.*", I'd recommend just
sticking it in "core.*", perhaps "core.primaryBranchName".

And for help the scripts in t/, GIT_TEST_PRIMARY_BRANCH_NAME would
be a handy thing to have.

> And then `git fmt-merge-msg` (and your proposed `git var` addition, which
> I like a lot, maybe `git var mainBranch`?) will pick up the latter.

You may need "git fast-export" to know about it (I do not think you
should special case the primary branch but that is a topic of
another thread).

> That way, existing repositories would not be affected by
> `GIT_TEST_DEFAULT_BRANCH_NAME` or `init.defaultBranchName` at all. Only
> new repositories would pick it up.
>
> Does that sound like a plan?

So the idea is that init.* one affects "init" and "clone" (and any
other operation that creates a new repository and have to pick a
branch to point the HEAD at), lack of which defaults to 'main', and
the other one affects "fmt-merge-msg", "fast-export" (and any other
operation that wants to know which branch is the primary one in the
repository), lack of which defaults to 'master'?  

And an updated version of Git would record the latter in the
repository it just created, based on the former, so that things
won't get broken when the user sets the latter in ~/.gitconfig?

I think such a two-variable configuration would also work.  

I was aiming at not needing any configuration for new people and the
approach I illustrated for you with just a single variable was an
outcome from it.  One possible downside of the one-variable approach
is that existing users with repositories whose primary branch needs
to stay 'master' cannot set the core.defaultBrnachName in
~/.gitconfig until they iterate over all the "sticking to 'master'"
repositories and set the core.defaultBrnachName variable in them,
but with the two variable approach, that particular downside is
eliminated, which I like.  I haven't thought things through to see
if there are downside in the two variable approach, but just like
"If you have some repositories that want to stick to 'master', set
the config in them before you set the config globally to something
different from 'master'" would be a semi-workable workaround for the
downside in the one variable approach, I suspect any downside in the
two variable approach we will identify would have an easy
workaround, too.

Thanks.

