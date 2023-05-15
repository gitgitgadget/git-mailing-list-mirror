Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB912C77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 07:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbjEOHA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 03:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbjEOG7y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 02:59:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7438F
        for <git@vger.kernel.org>; Sun, 14 May 2023 23:59:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aafa41116fso83723545ad.1
        for <git@vger.kernel.org>; Sun, 14 May 2023 23:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684133993; x=1686725993;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qxjts3TM/FHCvlEWcjFSOKYHxr22fYZxS1euKRoGqMI=;
        b=l4tljwIVV4DQrzXRsokdrS9QyssUmhqYIkKrK5bPziKAeCcoPbqzG6UoebY+eFDnhQ
         PqQLJM8HNloms+8VYuN3wb0EajQjdRE6plogw16gPmZvZe/o0K+9nnzVWbwE3MtemfMW
         78fdS6Mz6g3q/c/nYwD9e8wBucCd1+ZlSEB4CeQRb8igX7XCF4aBeh3J7YtdZpuaSY/h
         oXVYQ6aMZezriZs/sSHSbbyBGp09V9K7oEVqm+weOWCe4bkPfUXSpeQA5qnHoAJHKr6Q
         XPQKQkiZyK4wW0KZEejMoxa5fN4J1Hbx23q+PGdHx4mb4Gw9hyuX6cGRDOVpFwW0Ikmq
         gaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684133993; x=1686725993;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxjts3TM/FHCvlEWcjFSOKYHxr22fYZxS1euKRoGqMI=;
        b=YJj7DInGejuem+ZuK0YdnWJ81EuBfsiKFAtjihNqDdBT/k3XUE8cUo6uAAcKNC8K7P
         Iw/vwBjGuLRAIdFD1+yfBE4rl+XmL+9zykroWoZi50S6VL99flgGc+fEVXUJlSPCA510
         Y7WPeSfEuaSvEvJVOiLzi2hLl3luRo25EhTSsuHs3i8U+CY1jn8nbqgrG+sb5gElrY40
         PaTMMXV5SlfRge8dCtP+2Lq01vpf5/yv3dV8LGYQeqCembNMd3KPVhrcbtRr9I4q42qQ
         kmauHz7eVlTl7oBmnNg5BE7/VXfl7MU9vBJQkyBc0jrwIhKFgGDAk1X5njrdL+xfcOpy
         7RYA==
X-Gm-Message-State: AC+VfDzQiW4A/h2nMNE9lPTdnYAVkhZwSipMra8KM7SngCdH3GJTtHoY
        Fm31gT4rZdPeR+Y+MwzOkvM=
X-Google-Smtp-Source: ACHHUZ5TyViNbMLMmGcu6ckWCcXV1PiQIg9tdJ9qfXGGSov3dyk9OIvBRTphIJQ2pum3pFbaD2B9Zg==
X-Received: by 2002:a17:903:11c3:b0:1ab:160c:526d with SMTP id q3-20020a17090311c300b001ab160c526dmr37563177plh.22.1684133992718;
        Sun, 14 May 2023 23:59:52 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902e88e00b001ac591b0500sm5935912plg.134.2023.05.14.23.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:59:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Johannes.Schindelin@gmx.de, alexhenrie24@gmail.com,
        git@vger.kernel.org, newren@gmail.com, phillip.wood123@gmail.com,
        tao@klerks.biz
Subject: Re: [PATCH 1/1] doc: Glossary, describe Flattening
References: <xmqq5ybug8s8.fsf@gitster.g>
        <20230513165657.812-1-philipoakley@iee.email>
Date:   Sun, 14 May 2023 23:59:51 -0700
Message-ID: <xmqqh6seaxlk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> +[[def_flatten]]flatten::
> +	Flattening is a common term for the 'linearizing' of a
> +	selected portion of the <<def_commit_graph_general,commit graph>>.
> +	Flattening may include excluding commits, or rearranging commits,
> +	for the linearized sequence.

Thanks for writing.  I agree that it is a good idea to define the
verb "flatten".  The above I agree with 100%.

I think I was one of the first ones who used the verb in the context
of Git; what I wanted to convey with the verb was what it happens
when you use "am" to rebuild some history made into a series of
patches using the "format-patch" command on a part of the history.

When you have materials from two or more topic branches merged to
your primary integration branch, you would omit the merge commits on
the integration branch and send patches for commits on these topics
in a linearized way.  Applying these patches one by one will result
in a linearlized history, containing patches from all of these
topics (hopefully this is done in a topological order).

> +	In particular, linkgit:git-log[1] and linkgit:git-show[1] have a
> +	range of "History Simplification" techniques that affect which
> +	commits are included, and how they are linearized.

I didn't think (and I do not yet agree, but I may change my mind
after thinking about it further) that the history simplification had
much to do with flattening.

Even after a history is simplified (in the sense how rev-list family
of commands do so), there will still be merge commits left if both
branches contribute something to the end result.  So unless a merge
is to cauterize the side branch (i.e. in order to record the fact
that we already have everything we may want possibly merge to the
integration branch from the side branch, we create a merge commit
that merges the branch but does not change the tree from the parent
commit on the integration branch), history simplification may not
contribute to "excluding" commits.

> +	The default linkgit:git-rebase[1] will drop merge commits when it
> +	flattens history, which also may be unexpected.

I am tempted to suggest dropping ", which also may be unexpected"
here.  When learning a new system, there may be things a learner may
not expect (that is why we have documents), so it is not all that
useful to say "this may not be expected", expecially if we do not
mention why it behaves that way to clear the "unexpected"-ness.

And in this case, the reason may be obvious and it is OK to be left
unsaid---"git rebase" (without an option to keep merge commits) was
designed to be a way to flatten history, and a flattened history by
definition cannot have any merge commits in it.

> +	The two common linearization types are chronological (date-time), and
> +	topological (shape) based orderings. Generation numbering is topological.

Good.
