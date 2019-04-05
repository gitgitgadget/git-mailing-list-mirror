Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5F5320248
	for <e@80x24.org>; Fri,  5 Apr 2019 09:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfDEJct (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 05:32:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46449 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbfDEJct (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 05:32:49 -0400
Received: by mail-io1-f67.google.com with SMTP id p23so3841517iol.13
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PEqc+isPFeL/ZKJxiNrVHrVJ6jysGK7Hao7cf06FW5o=;
        b=OP87M54LUveFBV+OI1ZkFFXV8t4lfbQlnpuhDaMdnuwlWyjymjUM4F6p9gCU3UxC7E
         dNOxRm+HOyHKnJvvxGMT2Lw7mcH1tRx1oI4WHjUM+GUVftDO5YzTborB5cq/X8iQlqZO
         zeZ49/e6qL4SDKVYXWyOUCcsZ6C8a6/jfC7LiJlpq7oSr61uEkcRaxLHiMCduwogsP0/
         r1ePIh/KofoTIuvMkaI+0eql5987yHBUp/49OgJnigMNaoCNJNx/P53SstRCkals2eXI
         Bc2mftMnGBF1F8wCXHvjPv75Hb6vkJtMsf5nElJzneX9IhIsnzVuiyNg8f0DqXonMkxy
         A/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PEqc+isPFeL/ZKJxiNrVHrVJ6jysGK7Hao7cf06FW5o=;
        b=HqRB0OmLsQGZD+gTbO4bqAe5JXpRo2Mpgze3HR2ROlqbJm1frgYjyssHaUYv8i4g1c
         HYvCgHyH5sImmGqd9o9CmjTmaRsODmNhbFnEXIS1FHqoGkvmSWhXehjE3LAjdGATstaQ
         xrH+zMSsy0YUmjGyD0etuGVul/KEXTINsjUmorvQyo8FiCrjilQDmiWkVQRE5TLeHuha
         wCUialPmCyPZ7u7ndGBXFuj5K4S1eECeSDu66V3JpbkZJKvVyIjWODVjmIPnXnf7AV7+
         7/de4xg6FHmRr6DcCJtA0NNT1h4tE0/ReDF7VYpEkbxdG2SQyzblG5UscNBmldP173GD
         zPqA==
X-Gm-Message-State: APjAAAVVNz85xyjat4ikORL9Ym8n5yyFq5WTrZazALcaAbOLbh0hjLit
        a7dZxD2ozig1zcHC+VrhqlMYprHkwBeNoC70MgQ=
X-Google-Smtp-Source: APXvYqwCZ219uVPsjFs1JgFDb7ctpvKlcKUh1C9AjrtmFbUsy2wjDJoQzyPB8v+yNZP/KQ6FcUkr/0YFy9fEiqrZfG4=
X-Received: by 2002:a5d:840d:: with SMTP id i13mr136680ion.186.1554456768659;
 Fri, 05 Apr 2019 02:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190330111927.18645-1-pclouds@gmail.com> <20190403113457.20399-1-pclouds@gmail.com>
 <20190403113457.20399-11-pclouds@gmail.com> <20190404170427.GQ32732@szeder.dev>
In-Reply-To: <20190404170427.GQ32732@szeder.dev>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 5 Apr 2019 16:32:22 +0700
Message-ID: <CACsJy8Aa_Zcawoz07FBWjUjYE+RbMpxwrgim-tvQhMZW9+h2gQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/32] commit.c: add repo_get_commit_tree()
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 5, 2019 at 12:04 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> >  struct object_id *get_commit_tree_oid(const struct commit *);
> >
> >  /*
> > diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commi=
t.cocci
> > index c49aa558f0..f5bc639981 100644
> > --- a/contrib/coccinelle/commit.cocci
> > +++ b/contrib/coccinelle/commit.cocci
> > @@ -12,12 +12,12 @@ expression c;
> >
> >  // These excluded functions must access c->maybe_tree direcly.
> >  @@
> > -identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|load_t=
ree_for_commit)$";
> > +identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|l=
oad_tree_for_commit)$";
> >  expression c;
> >  @@
> >    f(...) {<...
> >  - c->maybe_tree
> > -+ get_commit_tree(c)
> > ++ repo_get_commit_tree(the_repository, c)
>
> So, why this change?

Because get_commit_tree() now becomes a compat wrapper (yes I'll fill
in the commit message ;) and should be avoided.

> It would also require furher changes to 'commit.cocci', in particular
> to the last semantic patch, which is supposed to ensure that
> get_commit_tree() doesn't end up on the LHS of an assignment, but with
> this change Coccinelle does suggest transfomations with
> repo_get_commit_tree() on the LHS.

Oooh.. I see now. I actually updated that then dropped, thinking that
a function call cannot be on LHS and that conversion is for
already-long-gone code anyway. But yeah when you stack that conversion
on top of this, it makes sense that we need double conversion to avoid
build error.

Since I will have to update this patch anyway, I'll update the commit
message on the first cocci patch too.

>
> >    ...>}
> >
> >  @@
> > --
> > 2.21.0.479.g47ac719cd3
> >



--=20
Duy
