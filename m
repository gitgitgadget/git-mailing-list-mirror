Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD4E1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 23:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbdGaXFk (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 19:05:40 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34088 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbdGaXFj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 19:05:39 -0400
Received: by mail-pf0-f180.google.com with SMTP id q85so154418pfq.1
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R/nRGiwNTobcX9b2H4hWgrnXjnvQRm7QhTBnEIKIM2g=;
        b=gIhUGpvw8EA88mMtXaDILVYe2juP6J/FqP9ODoBr5K9O21FQXomRncjywCItMrgW5z
         5K735l/034JMnYQWPCY7k0gjyjktuLI7xZxdk1bsoT3CoELq/fJltmd7RGbvabPjs9Rb
         jQ128uNQx+1s/gQ6N7m73D65W/XUZrgabuHXkN4y2Bk8s0ormv4cKSpyO925loObGXev
         7QL8EUM8Q9OaRAghV5GqQeJN+66uQQp2/C02nCl53kFhz9ATPzQhMdiSnwSnIhNObrmS
         1dn/Xus6VSfJxKUYMhONsD7VYaIbBGD3hPOfBwLNLCCS7ekWMKqSlqCDZ9FK6Uvgs0ay
         sXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/nRGiwNTobcX9b2H4hWgrnXjnvQRm7QhTBnEIKIM2g=;
        b=Zd3/PJu+5YhfxVHRjyWntpzYGbTkiLXJzpUwOrAVKTCHL+DPar4BFu2WrJtX42uHt8
         ro4XLbTAacYqgd/Xo6pIZEb3ehqvrAFlkGZLNHIBhvnIZM4yMLArC+4Mvyb8DspJaXuW
         MOg4rY+mFkp3yCE69tuf783MGLRmDZ57pDTr5absj9roRArzMimc9Kb42mgcT4Qa/aik
         8LIGT0bRh82QXXi8imgZ0VYk7zmRocbfDtUvYBvMUBAfEUFm2WOp8mct7XVMVAChI3Zw
         PgS+O2ALE7bTnN1+Js5TNPDjUWOnTwfahi1owbXrMK3tuv9omfdyS22Mx69Bh4A4qZv/
         Hspw==
X-Gm-Message-State: AIVw112VUnQD4EYdRbr2hxi8Ma1OkXdFSnjEkVTxFxjH9IFyy+NtXw38
        p4FAAlswMKwYaS7A
X-Received: by 10.99.96.193 with SMTP id u184mr16717555pgb.125.1501542338479;
        Mon, 31 Jul 2017 16:05:38 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:441d:c3c0:d5be:d4ff])
        by smtp.gmail.com with ESMTPSA id p27sm33944014pfl.23.2017.07.31.16.05.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 16:05:38 -0700 (PDT)
Date:   Mon, 31 Jul 2017 16:05:33 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2 0/5] Fsck for lazy objects, and (now) actual
 invocation of loader
Message-ID: <20170731160533.0a446244@twelve2.svl.corp.google.com>
In-Reply-To: <xmqq4ltsi9or.fsf@gitster.mtv.corp.google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501532294.git.jonathantanmy@google.com>
        <xmqq4ltsi9or.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 31 Jul 2017 14:21:56 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
>=20
> > Besides review changes, this patch set now includes my rewritten
> > lazy-loading sha1_file patch, so you can now do this (excerpted from one
> > of the tests):
> >
> >     test_create_repo server
> >     test_commit -C server 1 1.t abcdefgh
> >     HASH=3D$(git hash-object server/1.t)
> >    =20
> >     test_create_repo client
> >     test_must_fail git -C client cat-file -p "$HASH"
> >     git -C client config core.repositoryformatversion 1
> >     git -C client config extensions.lazyobject \
> >         "\"$TEST_DIRECTORY/t0410/lazy-object\" \"$(pwd)/server/.git\""
> >     git -C client cat-file -p "$HASH"
> >
> > with fsck still working. Also, there is no need for a list of promised
> > blobs, and the long-running process protocol is being used.
>=20
> I do not think I read your response to my last comment on this
> series, so I could be missing something large, but I am afraid that
> the resulting fsck is only half as useful as the normal fsck.  I do
> not see it any better than a hypothetical castrated version of fsck
> that only checks the integrity of objects that appear in the local
> object store, without doing any connectivity checks.

Sorry, I haven't replied to your last response [1]. That does sound like
a good idea, though, and probably can be extended to trees and blobs in
that we need to make sure that any object referenced from local-only
commits (calculated as you describe in [1]) can be obtained through an
object walk from a remote-tracking branch.

I haven't fully thought of the implications of things like building
commits on top of an arbitrary upstream commit (so since our upstream
commit is not a tip, the object walk from all remote-tracking branches
might not reach our upstream commit).

To try to solve that, we could use an alternate object store to store
remote objects in order to be able to find remote objects quickly
without doing a traversal, but that does not fully solve the problem,
because some information about remote object possession lies only in
their parents (for example, if we don't have a remote blob, sometimes
the only way to know that the remote has it is by having a tree
containing that blob).

In addition, this also couples the lazy object loading with either a
remote ref (or all remote refs, if we decide to consider objects from
all remote refs as potentially loadable).

I'll think about this further.

[1] https://public-inbox.org/git/xmqq379fkz4x.fsf@gitster.mtv.corp.google.c=
om/

> Don't get me wrong.  The integrity check on local objects you still
> do is important---that is what allows us to make sure that the local
> "cache" does not prevent us from going to the real source of the
> remote object store by having a corrupt copy. =20
>=20
> But not being able to tell if a missing object is OK to be missing
> (because we can get them if/as needed from elsewhere) or we lost the
> sole copy of an object that we created and have not pushed out
> (hence we are in deep yogurt) makes it pretty much pointless to run
> "fsck", doesn't it?  It does not give us any guarantee that our
> repository plus perfect network connectivity gives us an environment
> to build further work on.
>=20
> Or am I missing something fundamental?

Well, the fsck can still detect issues like corrupt objects (as you
mention above) and dangling heads, which might be real issues. But it is
true that it does not give you the guarantee you describe.

=46rom a user standpoint, this might be able to be worked around by
providing a network-requiring object connectivity checking tool or by
just having the user running a build to ensure that all necessary files
are present.

Having said that, this feature will be very nice to have.
