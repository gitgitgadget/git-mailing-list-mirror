Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA7DC76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 15:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjDJPw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 11:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDJPwz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 11:52:55 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F4C4686
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 08:52:54 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id y69so11933699ybe.2
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681141973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbcO69gtu/CEGBvyvoHmyd0dLsv8Su0UGdCtGV6B6Uc=;
        b=ViOC66Nw4NeFXbM26dRykJJKgAzdu3aNFaS/cJEqaokR71z4Cla8uHIbKZ99I2IOgu
         9U8bKQDjtvV1a+aCHrOxAwAhBoo/s3d7FC1PZMyNgXf00ogqwa3cmTSVu7dJbHmJwNKQ
         /Cs9QO59FDxkkvQvnhU6Y6gjYKMBRpSNKkcWosUavdIcx67crQ57++jJ2WaNzARw+Ac3
         To27c0s2GUJMG2Yzz4fbmzdygIU61GaTlTa2B15+WUo1jvf16ocx8HuDrixUGCgmRI8L
         f6+td4hOVhW9Ot8QY9WxKtgF+8Ar/+H4mEBC28b4vuLfjYaopVi60EDgvpNuZHcj8TFb
         l8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681141973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbcO69gtu/CEGBvyvoHmyd0dLsv8Su0UGdCtGV6B6Uc=;
        b=4nNApzMp9wVOkBPrwlx43i8DrLzdfK//oLOJzctXJSa3RYOkZJrzT2MVcFwCladnqa
         ptT7OyqCAtuYJmSvhagIzXbr3g5FV6vc5/KMzJh1FfXLpDKBsHxY/xDOeXCtN+gB2SuL
         E/vtW5N04jUdtdl58JhbIZgsz90z1l6YeRRAmRo8iAj2V1xk0doEc/iG7p4phPM38nq+
         iT3LcOfLP9b+ZnUDxuS2Va8053ALJcXBA8fmuxmGdKcvq7iJDDF2X3apKCGRjbiejpXT
         pOhv9ucr8Hcod4e6X2Szh8SxluzFwpdBIvU834EUvXMrxh6YXXVktTPmmyqcwuA6ZW0y
         GTXg==
X-Gm-Message-State: AAQBX9dxA5YXxgQGxXejRc7a5doZoW70eTqzFBmo+recqFVkbgD8pXPM
        QNeij4r721EJh/xVpKj9FTY4kc3tsdA5m9z2p5utruSRii4DIfw5ZmesDg==
X-Google-Smtp-Source: AKy350aM+gdXKPxAXXEDzf9Eh6NmedCguvhYy5OiIj///QubUHV9akjxZ3J6HYtrBi8yCHUQxFKsOGwAUty0qEqe44Y=
X-Received: by 2002:a25:7612:0:b0:b8e:ec30:853e with SMTP id
 r18-20020a257612000000b00b8eec30853emr2065364ybc.4.1681141973283; Mon, 10 Apr
 2023 08:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <47afc6a6c8757032d9d69a2f9aaaeb427c5a003f.1680571352.git.gitgitgadget@gmail.com>
 <20230405172840.730076-1-calvinwan@google.com> <CABPp-BEurqhk32hC041kcXiVNpVXx3YzJMyzDh4E=ctBLemz8A@mail.gmail.com>
In-Reply-To: <CABPp-BEurqhk32hC041kcXiVNpVXx3YzJMyzDh4E=ctBLemz8A@mail.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 10 Apr 2023 08:52:42 -0700
Message-ID: <CAFySSZD-9Ui8v0Ki1j96zouAB=sCRT0qBWOhb5-A4TfizpOqfw@mail.gmail.com>
Subject: Re: [PATCH v2 21/24] strbuf: move forward declarations to beginning
 of file
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I do have this change in one of my series already, and since I'm
planning on removing the declarations anyways, dropping this patch for
now would be my recommendation.

On Thu, Apr 6, 2023 at 11:08=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Wed, Apr 5, 2023 at 10:28=E2=80=AFAM Calvin Wan <calvinwan@google.com>=
 wrote:
> >
> >  Instead of moving these declarations, can we move
> >  strbuf_repo_add_unique_abbrev() and strbuf_add_unique_abbrev() to
> >  object-name.[ch]? These functions are related to both strbuf and
> >  object-name, but object-name should be a higher level API than strbuf
> >  so it seems more natural to belong in there.
>
> I like that suggestion; that would be better overall.  However, should
> it be in this (already lengthy) series?  I'm guessing you likely
> already have such a change in the series you're including, and if I
> were to add it to mine (and risk doing it slightly differently), that
> might increase the conflicts you need to deal with.  Would it perhaps
> be easier to keep this small change for this series, or even drop this
> particular patch, and then let you address this improved direction
> with your strbuf work?
>
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > > From: Elijah Newren <newren@gmail.com>
> > >
> > > Signed-off-by: Elijah Newren <newren@gmail.com>
> > > ---
> > >  strbuf.h | 9 ++-------
> > >  1 file changed, 2 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/strbuf.h b/strbuf.h
> > > index 3dfeadb44c2..547696fb233 100644
> > > --- a/strbuf.h
> > > +++ b/strbuf.h
> > > @@ -1,6 +1,8 @@
> > >  #ifndef STRBUF_H
> > >  #define STRBUF_H
> > >
> > > +struct object_id;
> > > +struct repository;
> > >  struct string_list;
> > >
> > >  /**
> > > @@ -72,12 +74,6 @@ struct strbuf {
> > >  extern char strbuf_slopbuf[];
> > >  #define STRBUF_INIT  { .buf =3D strbuf_slopbuf }
> > >
> > > -/*
> > > - * Predeclare this here, since cache.h includes this file before it =
defines the
> > > - * struct.
> > > - */
> > > -struct object_id;
> > > -
> > >  /**
> > >   * Life Cycle Functions
> > >   * --------------------
> > > @@ -634,7 +630,6 @@ void strbuf_list_free(struct strbuf **list);
> > >   * Add the abbreviation, as generated by repo_find_unique_abbrev(), =
of `sha1` to
> > >   * the strbuf `sb`.
> > >   */
> > > -struct repository;
> > >  void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct reposit=
ory *repo,
> > >                                  const struct object_id *oid, int abb=
rev_len);
> > >  void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object=
_id *oid,
> > > --
> > > gitgitgadget
