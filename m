Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ECDC433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 13:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B98761244
	for <git@archiver.kernel.org>; Fri, 21 May 2021 13:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhEUNO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 09:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbhEUNOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 09:14:16 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616E2C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 06:12:52 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id s7so3991853iov.2
        for <git@vger.kernel.org>; Fri, 21 May 2021 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lrIS2IYIekilSs2v7e0YC/Y+M3UxlT9mhCGbZuHU4oM=;
        b=uH21fsO4OaBY0uMAYzoeEQ16iNmOWHgF4Xq3wxzSkZCL3luUGaveSdWiy3cQYX9nR8
         uc/Q69Uyv53bMSvgDsnUXALXeoGih8W578ji2GXaS94R4wXEF2xn0x0al6Fhbfc+02zR
         fNvLbn0MKyH7agwL5d2QuJKyNwHZxbKG+FosTgOCeTKRrcovqSucZqSe6zsm0mwThK4S
         mGg8EVB6gkvLLhpSSOvLlloJfpnDdM0YE6zJOio1rEOM3WVn36jPeefap9bpGFxypfX4
         L9+2QuzqjfaM/RqFnae3HJG9zVhZcpFPqqAvVUlXYKUcKlZaoeDtZ+YJqOftB3Eeo6ic
         y2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lrIS2IYIekilSs2v7e0YC/Y+M3UxlT9mhCGbZuHU4oM=;
        b=lg/tEFd/JIuEoSfQW/WgHD5dUG3bXhaNBwwdzeL3wscBesmTns/4hFpFflyT1k1JMu
         l9QHZ5F3tTaqUouWxxU0CYbfd+yZ1bwmcGA6ZiKqlEKenXMthcgiH6bmtCrjj/B35Wfs
         T00+/3YktfReYenMbP+neHuzBqtM3XsCwsaqcR9HQMUblgEIrwXRU4iMvoK6Rst5BX8f
         7gqxK6lACeKC5Hl/M8B2qtqX4Fey9f9znlpp8R9BAYrVbfmAqxQZIogWXN3DocODM3H3
         Jt0JQ0ejcWhAx2vQcb4eA8ADH8QXixGsUWMuKDcXH+tcAfbmE6cY/CXGwsDuzEC1M7pD
         BEzA==
X-Gm-Message-State: AOAM53269BZzSBLgtO6smU9ZGR9wdu9QuMntIYyOpYhQ8IMhNEe/kzhb
        MN2uAKzdjiLpvY/p4n0yN2LyN3YAB/gIn3IWFRE=
X-Google-Smtp-Source: ABdhPJxF6WcyQlCIgURfF76JTfKxENvyvbjTNAu+tdRZyCZab8wBkmc/SFq/26tCrg78uUu+/NmWj/J0NyMGQ2hEPq0=
X-Received: by 2002:a02:5409:: with SMTP id t9mr4460251jaa.50.1621602771603;
 Fri, 21 May 2021 06:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.958.git.1621500593126.gitgitgadget@gmail.com>
 <CAP8UFD0Pzdb_9+VpeLrydu8ROdVi4ygFPk367J+NWGL0P5nXdg@mail.gmail.com>
 <CAOLTT8S_Bu1PG+-gVK_6iUx--YrMx2hxDCTa=5sW6UJv9Oz_0Q@mail.gmail.com> <CAP8UFD1yLS9UBs0r6_GjB-K6prW7GNxR+z445HJe8cR4HYLewA@mail.gmail.com>
In-Reply-To: <CAP8UFD1yLS9UBs0r6_GjB-K6prW7GNxR+z445HJe8cR4HYLewA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 21 May 2021 21:12:35 +0800
Message-ID: <CAOLTT8Q9meKiHG=TvwsW49dwWtzBNnkfT03+dQrvKDLGuLiOFg@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: add contents:raw atom
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=
=8821=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=885:10=E5=86=99=E9=81=93=
=EF=BC=9A
>
> > Okay, some explanations are indeed missing here:
>
> By the way I forgot to say that your patch might want to also properly
> document %(contents:raw). If the doc was updated as part of the patch,
> maybe the whole patch would be easier to understand.
>

Indeed so.

> > %(contents) will discard the metadata part of the object file,
>
> It's not clear what you mean when you talk about metadata in objects.
> Are you taking about only the headers, like the "tree XXX", "parent
> YYY", etc lines in commits, and the "object OOO", "type TTT", etc
> lines in tags? Or does it also includes the lines in tree objects that
> reference other trees or blobs?
>

Well, the metadata here only refers to the header of the commit and
tag objects, "tree XXX", "parent YYY"...  The lines in tree objects that
reference other trees or blobs will not output. What we have to do here
is to simulate the behavior of `git cat-file --batch`. But we encounter a
very serious problem here:

Now we want to use for-each-ref to print a ref point to a tree:

git for-each-ref --format=3D"%(contents:raw)" refs/mytrees/first

will output:

100644 one

but

git cat-file tree refs/mytrees/first

will output:

100644 onem=EF=BF=BDc=D6=88=EF=BF=BD=EF=BF=BDq=EF=BF=BDD=EF=BF=BD=D6=A7hJ)E=
-100644 two.t=EF=BF=BD=EF=BF=BD=EF=BF=BD0=EF=BF=BD+=EF=BF=BD=EF=BF=BDVjC=EF=
=BF=BD=EF=BF=BDeV=EF=BF=BD=D3=88q

which is the compressed data, it may contains '\0'.

Whne we use `append_atom()` to add the contents of the tree object
to the buffer, notice that it uses `strbuf_addstr()`, the underlying call
is `strlen()`, which truncates the data we added. Can we have any good
remedies? For example, record the length of "v->s" by "v->s_size" and
use `strbuf_addstr(&state->stack->output, v->s, v->s_size)`?

> > and only print the data contents part of it. %(contents:raw)
> > can will not discard the metadata part of the object file, this
>
> s/can//
>
> >  means that it can print the "raw" content of an object.
>
> The above seems to be changing the definition of %(contents) (as
> previously it was only the commit message of a commit or the tag
> message a tag) to explain %(contents:raw)...
>
> > In addition, %(contents:raw) can support print commit, blob,
> > tag, tree objects contents which %(contents) can only support
> > commit,tag objects.
>
> ...but this is saying that the definition of %(contents) actually
> doesn't change. This doesn't seem logical to me.
>
> If %(contents:raw) can support any kind of object (commit, blob, tag
> or tree) then it would be logical that %(contents) also support any
> kind of object.
>
> So if you really want to define %(contents:raw) as the raw object
> contents, you might want to consider a preparatory patch that would
> first change the definition of %(contents) to be the object contents
> without the headers. This would keep the same output for any commit or
> tag. But for blobs and trees it would print the whole content of the
> object in the same way as `git cat-file -p` does, instead of nothing.
>

Yes, I agree with you. Another thing worth mentioning is:
%(contents:raw) or %(contents) is not similar to "git cat-file -p foo"
they are more like "git cat-file <type> foo" or
"git rev-parse foo | git cat-file --batch", "git cat-file -p foo" It will
process the original data:
For example, a tree object, with "git cat-file -p",
will use "ls-tree" to output all the sub-trees and blobs it connects.

$ git cat-file -p refs/mytrees/first
100644 blob 6dde63d6888cec71ea82449bd6a7684a29452d7f    one
100644 blob f719efd430d52bcfc8566a43b2eb655688d38871    two.t

but with "git cat-file <type>" will output uncompressed data:

git cat-file tree refs/mytrees/first
100644 onem=EF=BF=BDc=D6=88=EF=BF=BD=EF=BF=BDq=EF=BF=BDD=EF=BF=BD=D6=A7hJ)E=
-100644 two.t=EF=BF=BD=EF=BF=BD=EF=BF=BD0=EF=BF=BD+=EF=BF=BD=EF=BF=BDVjC=EF=
=BF=BD=EF=BF=BDeV=EF=BF=BD=D3=88q%

> I think this acceptable as refs rarely point to something other than
> commits, so people are not likely to rely on the fact that %(contents)
> currently prints nothing for blobs and trees.
>
> > E.g:
> >
> > git for-each-ref --format=3D%(contents:raw) refs/heads/foo
> >
> > will have the same output as:
> >
> > git rev-parse refs/heads/foo | git cat-file --batch
>
> Ok, I think that would indeed be useful.
>
> > > Also is %(contents:raw) supposed to print something for a blob or a
> > > tree, while I guess %(contents) is printing nothing for them?
> >
> > Now my thoughts are:
> > Let %(contents) learn to print four kinds of objects.
> > and then let %(contents:raw) learn to print metadata.
> > I will split it into two patches.
>
> Yeah, great!
>

Thanks!
--
ZheNing Hu
