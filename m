Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9721F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfIQQCV (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:02:21 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36488 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfIQQCU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:02:20 -0400
Received: by mail-vk1-f196.google.com with SMTP id w3so851305vkm.3
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p3eh85Jj1lEE2N5PrnIW5MxmPXKDkQRDkJ6/jLhWanU=;
        b=R3aeTmWUfUuMtjuRwjONNdRy/qP5xjWC2mzyT1DCcgjy/LGpJALJ7ZvlD9Oi11I96O
         hKGtwiwFudtVBwiJLCNGg1CrXyo67PipHDgbALolnvFoK4VuMtcsk51PzgqNZzvD4uGQ
         3XTpFvS1xGhIu4TD6q7NwSLB8xb9CSatC93TyAvmMjP/9MfqiE+su72QatIbw1+7Kjey
         Rf3rF5BvUb/HfW2uuJ0zPvdvGl5PqA4sCEZimd3se6yAqs7QpFyS3Y/pabg8WMJPUKxX
         qJ0nwLflzXu7gj3ciGIC+cRNlk067KF+YnbU0GiwZwOxTQ1p1NbD4H6F2F9w+10t7fQ3
         br/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p3eh85Jj1lEE2N5PrnIW5MxmPXKDkQRDkJ6/jLhWanU=;
        b=WK/+JnaWYrmTgfM97CNRcLy5Z32n+okq9EydcbR1ACCZaSbrMBb6SGwK50sxYp5RQy
         t41OW8rINBBkOSg25iiH6kL9REoSkqPTbXRhASDBx5p/lGZI+4xicct6VcK3qNdwoc5y
         H9SQpGQdvmVgYHM0Y/rcxQvBawoRChQUtYKpLsTEEaLe5g2HR2PCo2V9Nw0BVnwonK7m
         T3wSi6ayknlhFBOkJHh8EI7jh2juYiJ6KLcqREQzu16PSPwxIYDpjpU3cQtZWbSxERH0
         fyVNtq5SfSQxr9m2IwRW0GArHTi1tniWYgEtyRTtKMhy06tY3l/3oYm6fFJ2V2GVb54Z
         1yZQ==
X-Gm-Message-State: APjAAAXtVOO0+LSSzMQ716XicvSVEE1Ozbu5sADzGTaRLDmtadUm13XM
        zyjSL+TJHRVeJ8pJeSTipz5ji/pBem/q7x+Sq1M=
X-Google-Smtp-Source: APXvYqxasmWXv2HNKnnMQNRNKvJB9aNCd2ARXma1vKuxFm6Ett4shdEDMY70gy0ZDcFHXeXjlmZELRcXVZec3xLboCI=
X-Received: by 2002:a1f:3f10:: with SMTP id m16mr1855273vka.15.1568736139247;
 Tue, 17 Sep 2019 09:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190916214707.190171-1-jonathantanmy@google.com> <20190917000902.GC67467@google.com>
In-Reply-To: <20190917000902.GC67467@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 17 Sep 2019 09:02:07 -0700
Message-ID: <CABPp-BFqZS5WaR1b-MtQ0eMrsDJNSNjSrC0NjPpKk6+5WtNNWw@mail.gmail.com>
Subject: Re: merge-recursive thinks symlink's child dirs are "real"
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 16, 2019 at 5:09 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Jonathan Tan wrote:
>
> > This was raised by a coworker at $DAYJOB. I run the following script:
> [reproduction recipe from (*) snipped]
> > The cherry-pick must be manually resolved, when I would expect it to
> > happen without needing user intervention.
> >
> > You can see that at the point of the cherry-pick, in the working
> > directory, ./foo is a symlink and ./foo/bar is a directory. I traced th=
e
> > code that ran during the cherry-pick to process_entry() in
> > merge-recursive.c. When processing "foo/bar", control flow correctly
> > reaches "Case B: Added in one", but the dir_in_way() invocation returns
> > true, since lstat() indeed reveals that "foo/bar" is a directory.
>
> G=C3=A1bor covered the "what happened", so let me say a little more about
> the motivation.
>
> The "foo" symlink is being replaced by a "foo" directory containing a
> "bar" file.  We're pretty far along now: we want to write actual files
> to disk.  Using the index we know where we were going from and to, but
> not everything in the world is tracked in the index: there could be
> build outputs under "foo/bar" blocking the operation from moving
> forward.
>
> So we check whether there's a directory there.  Once we are writing
> things out, there won't be, but the symlink confuses us.  Nice find.

Yep.

>
> [...]
> > Is this use case something that Git should be able to handle, and if
> > yes, is the correct solution to teach dir_in_way() that dirs reachable
> > from symlinks are not really in the way (presumably the implementation
> > would climb directories until we reach the root or we reach a filesyste=
m
> > boundary, similar to what we do when we search for the .git directory)?
>
> The crucial detail here is that "foo" is going to be removed before we
> write "foo/bar".  We should be able to notice that and skip the
> dir_in_way check.

I know what you're getting at from a high level view, but this view is
incompatible with the machinery's internals.  In particular,
merge-recursive's design provides no way to "notice" that something is
"*going* to be removed" (every path is updated on the fly as it
processes it); the dir_in_way() check is there precisely to determine
if it's safe to write to the given path -- which basically means if
there is no directory in the way (a "foo/bar/" directory, in this
case).  So we definitely do not want to skip the dir_in_way() check,
we want to modify it to be aware that a leading path being a symlink
doesn't count as in the way (much as a the existence of a file on disk
corresponding to one of our leading paths doesn't count as in the way
for our purposes).
