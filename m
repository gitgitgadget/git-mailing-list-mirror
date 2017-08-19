Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BF3E20899
	for <e@80x24.org>; Sat, 19 Aug 2017 06:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750854AbdHSGvY (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 02:51:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52956 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750852AbdHSGvX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 02:51:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B864A7878;
        Sat, 19 Aug 2017 02:51:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3AZqq/abLfUawIDiKmmPcZCrms0=; b=mUbF1k
        kCHE6fc182hOdvVmlxBapo0nnFOPW84/9XEn6L5eSn9qjmhUwWUcEeot/l96x0i6
        UhQ6IdKZipZYmp9sCKce7Dmtnfd/pu+GuB8IqSReTisLolP+nVUPXH7S0ZTbSd9G
        l7QsXGpdDAggyqHRP6R8GmhTiREpWt/RR/eBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RUzKbw9rMx8GZ9ZC7r9OAoHgOfmIsm1A
        vSh3F4E/FAaP2sGClbrNH7xhGU+GN8PkAAHZ6K1HPZAQRDY+SnWTZ80e5BQhFhCk
        bO6fvu4pRkQnhQIdgp7HeaKEI9pCq/9bbfHp3zBgRecR/FzsgLxLQ4PVMKEAX38K
        /z4Pl2UljjU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72ABEA7877;
        Sat, 19 Aug 2017 02:51:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C75E7A7875;
        Sat, 19 Aug 2017 02:51:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Submodule regression in 2.14?
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
        <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
        <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com>
        <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
        <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
        <xmqq7ey0ddlk.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kap-4k7n48dvBAv2pJjNy2s_LPHS-NdfQD0A-BbWqh4aQ@mail.gmail.com>
Date:   Fri, 18 Aug 2017 23:51:13 -0700
In-Reply-To: <CAGZ79kap-4k7n48dvBAv2pJjNy2s_LPHS-NdfQD0A-BbWqh4aQ@mail.gmail.com>
        (Stefan Beller's message of "Fri, 18 Aug 2017 12:09:53 -0700")
Message-ID: <xmqqpobs9hjy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB581FCC-84AA-11E7-96E4-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Jonathan brought up the following very long term vision:
> Eventually the everyday git commands do not treat submodules
> any special than trees, even the submodules git directory
> may be non existent (everything is absorbed into the superproject);
> so it really feels like a monorepo.

That may be one valid option to have but I do not see a reason why
it needs to be the only valid option.  So I do not see why you are
bringing it up in this thread.

But that is a good starting point to discuss one possible future.
Let's think aloud how that world would look like.

 * When you "git clone" a superproject (perhaps implicitly with the
   "--recurse-submodules" option), the top-level project and all of
   its submodules will be checked out on the same branch (presumably
   the 'master' branch, which is the default).

 * Your attempt to "git commit", "git branch", "git checkout -b",
   etc. inside a submodule will either fail, or will implicitly
   chdir up to the top-level superproject and turn into the
   corresponding command with "--recurse-submodules".

 * "git commit --recurse-submodules -a" from the top-level will grab
   all the local changes, depth-first and recursively, in
   submodules, makes a commit, binds the new commit to the index of
   the superproject that immediately contains the submodule and
   makes a commit in it, until it percolates all the way up to the
   superproject.  When working in this mode, branches in submodules
   do not really matter; the gitlink in the superproject is the only
   thing that matters.

 * It naturally follows that between two adjacent commits C and C~1
   in the superproject's history, the commit in a submodule bound to
   C and the commit in a submodule bound to C~1 are either the same
   (i.e. superproject made a commit but there was no change in the
   submodule), or they are in direct parent-child relationship
   (i.e. the local changes made to the submodule was recorded as a
   single commit when the superproject made the commit).

 * "git push --recurse-submodules" from the top-level will push the
   history of the superproject out, together with the history of the
   submodules.

I think it is doable, but a mechanism to enumerate all the commits
bound from submodules to a range of superproject's commits needs to
be invented to drive the pack-objects for efficient object transfer.
Having it would also help in fsck and gc---as branches are immaterial
in the submodule repositories, commits in superprojects that are
reachable from refs will have to serve as the connectivity anchors
for commit DAG in the submodule histories.

As long as we are talking about idealized future world (well, at
least an idea of somebody's "ideal", not necessarily shared by
everybody), I wonder if there is even any need to have commits in
submodules in such a world.  To realize such a "monorepo" world, you
might be better off allowing a gitlink in the superproject to
directly point at a tree object in a submodule repository (making
them physically a single repository is an optional implementation
detail I choose to ignore in this discussion).
