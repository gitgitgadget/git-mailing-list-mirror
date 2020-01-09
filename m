Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F93C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 23:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D4F2073A
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 23:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvFhcg0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgAIXrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:47:51 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40985 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgAIXru (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 18:47:50 -0500
Received: by mail-vk1-f194.google.com with SMTP id p191so92178vkf.8
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 15:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3T3yrMDWd/f3NkGOQMZAtDGq8Igin5jHRC4KnPZmy00=;
        b=jvFhcg0jyf4nQJPJzJHd4OZ/uUvgV8PPcwkY63jjGlPbIXPch1cDDArlI5+jHdQkHM
         5DNB2wJdkRlcDYAN0ziA1Xnp8ODou83f5W1e5gyh4to1i0mzn1Yqt5624AlviQjciOY0
         sjQQoybQYV46N6BUE+9MIu6+wtuqGLxRciX2uP1mmck9Tgmll+M+Ja2lIMA22zlUdNGO
         J78mnBEkA+9RKGOBhvKsuPVv8H5r8ab9ycV8XH/PRW7/kdUleQrP919loX6309RXkVC6
         IMcO9WxCEH1ENneyxGGc8ROaqBIkb0y8wVQPZpOSVtF1NHtkEsLUm+B1Gr91CMcjebL0
         5Shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3T3yrMDWd/f3NkGOQMZAtDGq8Igin5jHRC4KnPZmy00=;
        b=Sa10TfnMg2fvwLYLp1jvn5no4xCqrrOA2TdYwnYIO5MxRx0v4B5LO6L8jVAsDgKG03
         IaqPN7rp6wJMnvZTWh/ceGjfeom+fSXL7GkvGG0KkYNbAXD+aYnQJDgQB+QDuwfMBeZu
         zP5Tvuu6M/0KStDcPCS/0ToxI0fPhlBPFKnEygcF01uP4E5Bk7n2356FjNQRDkSlmZa2
         0/ODu87OVZI+tOJsz1FOqFGFnQHobzufgseIzu5XV4jEYP+G+RkD8ovET7E1zEciVQf2
         mH18RVux1MmcZXlUfDSZuO9uz9wgMAuwbkCLGfFjH8nGpewmfjNiEr8AJQoqb6YoBEYI
         i6fA==
X-Gm-Message-State: APjAAAUxLjsWTLkm0eYlFQ9pl1CqA75wqyuN2nghXt39VRnsUjbezRcL
        qlBl1jtmZTU84UR4cDJZGSoohogmmdS7JxG8z5Q=
X-Google-Smtp-Source: APXvYqyH6BNdx0d3ZGzVIdHV29hPt5i8Tga6C0efkI+aO8bDV4MXKcj6MoA1XhkaYRi805HqZnDRBnh0JiDhxP8NSTY=
X-Received: by 2002:a1f:94c1:: with SMTP id w184mr136303vkd.40.1578613669686;
 Thu, 09 Jan 2020 15:47:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
 <pull.478.v2.git.1578565001.gitgitgadget@gmail.com> <92ce9b782429248197bb87cfa11c89082304218f.1578565002.git.gitgitgadget@gmail.com>
 <xmqqd0bsz9xm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0bsz9xm.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Thu, 9 Jan 2020 18:47:36 -0500
Message-ID: <CAOjrSZviSf+b6-MMavyAntcp0MfK91N-cZEyJYiwJ8OqEbgXYQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] config: add '--show-scope' to print the scope of a
 config value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +     switch (scope) {
> > +     case CONFIG_SCOPE_LOCAL:
> > +             return "local";
> > +     case CONFIG_SCOPE_GLOBAL:
> > +             return "global";
> > +     case CONFIG_SCOPE_SYSTEM:
> > +             return "system";
> > +     case CONFIG_SCOPE_WORKTREE:
> > +             return "worktree";
> > +     case CONFIG_SCOPE_COMMAND:
> > +             return "command";
> > +     case CONFIG_SCOPE_SUBMODULE:
> > +             return "submodule";
> > +     default:
> > +             return "unknown";
>
> Makes me wonder if this wants to be done via a table, which would
> later allow a parser to map in the other direction, taking a string
> and returning the corresponding enum, more easily (imagine a yet to
> be invented feature to "list config settings for only this scope").

I was thinking the same but then I realized such an option already exists,
--local and company.

>
> > +     }
> > +}
> > +
> > +static void show_config_scope(struct strbuf *buf) {
> > +     const char term = end_nul ? '\0' : '\t';
> > +     const char *scope = scope_to_string(current_config_scope());
> > +
> > +     strbuf_addstr(buf, N_(scope));
> > +     strbuf_addch(buf, term);
> > +}
> > +
> >  static int show_all_config(const char *key_, const char *value_, void *cb)
> >  {
> > -     if (show_origin) {
> > +     if (show_origin || show_scope) {
> >               struct strbuf buf = STRBUF_INIT;
> > -             show_config_origin(&buf);
> > +             if (show_scope)
> > +                     show_config_scope(&buf);
> > +             if (show_origin)
> > +                     show_config_origin(&buf);
> >               /* Use fwrite as "buf" can contain \0's if "end_null" is set. */
> >               fwrite(buf.buf, 1, buf.len, stdout);
> >               strbuf_release(&buf);
> > @@ -213,6 +245,8 @@ struct strbuf_list {
> >
> >  static int format_config(struct strbuf *buf, const char *key_, const char *value_)
> >  {
> > +     if (show_scope)
> > +             show_config_origin(buf);
> >       if (show_origin)
> >               show_config_origin(buf);
>
> Shouldn't one of these show scope instead of origin?  I wonder how
> the tests I see later in the patch could have passed with this.
>

Oof, that was a blunder... I think this passes the tests because none of them
actually hits `format_config()` only `show_all_config()` so I'll definitely add
a test case for this. (and fix it while I'm at it)

> > diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> > index 78bbb9eb98..aae2c6fc9e 100644
> > --- a/t/helper/test-config.c
> > +++ b/t/helper/test-config.c
> > @@ -48,8 +48,10 @@ static const char *scope_name(enum config_scope scope)
> >               return "repo";
> >       case CONFIG_SCOPE_WORKTREE:
> >               return "worktree";
> > +     case CONFIG_SCOPE_SUBMODULE:
> > +             return "submodule";
> >       case CONFIG_SCOPE_COMMAND:
> > -             return "command";
> > +             return "cmdline";
>
> Oh???
>

I definitely got a little too excited to get this patch in, so I
definitely apologize for that,
but thanks for the review.

-- 
Matthew Rogers
