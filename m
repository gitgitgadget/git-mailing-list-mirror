Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50BEA208CD
	for <e@80x24.org>; Thu, 31 Aug 2017 17:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbdHaRkV (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 13:40:21 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36730 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdHaRkU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 13:40:20 -0400
Received: by mail-oi0-f51.google.com with SMTP id t75so2655970oie.3
        for <git@vger.kernel.org>; Thu, 31 Aug 2017 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q1PIqRcIkH2DFSfnKUdnf0tVtCtLvSJ3KGvxTGeqniw=;
        b=vkls1gQD2mVhJ8mANUX4Sr/6mT8j4OUUTxOE6CZmiWVGK6ffLKpItIJJUq0qYexoEd
         P7/14G7RY58dFp/XTw5NigncTP56AdE6fVJmZAQBRnWyI4fbcwD40ovCcHbXqNvRas3i
         XkhZPRZAYQwzOYnVdgtjVbDO5oxS7cmG6PRPzq32IbR3kvkFBiWPRkBO/K5dV7OB2FI7
         6VCNnQOUfRv+VGi+LlgROSi4Oaf+BwoHtyhyKrHlhZ091H14nNXpPZ/t+jdrTSAMaH4s
         qx9+zZQtkgNJPOO8m8duZx2wx13I+biRe3iV/B7jrwngfrULxprkLb9IXHPW9g/yxePR
         w2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q1PIqRcIkH2DFSfnKUdnf0tVtCtLvSJ3KGvxTGeqniw=;
        b=Mp+RfGj/ctcOzIUVG7ww1q4tGOl+1kGkMSmejJm2t1H2kaVtUXzul7z0JmYsrMDA7O
         FDPE22qcqdH5JZSF9UIc2/QNqqP5X5in0ab14xiX8lmo8BI/y8NOlsgACR8/0y3i7SD4
         l8RxZW0Mwh2E1FUu0DssNcKEcUIUsu+MhKSgfmHQoOMJuaS/Sj6pzXN4O8hI7Jai0jMx
         MlFJ9nj3/B8mbrIB/Pi4S0FQHbvcVMEF4GSV14pl4ycpIDV23nvbByW4WI3ITFQXTPqo
         4joUfak27QbVX2+155CDO/Ry/wbphwf97lvfNEN5cFluFqamvYndyVzJj274noh748ws
         F5vA==
X-Gm-Message-State: AHYfb5ji6CvrCg5R/gpXxQpKKQk+T++b55XSeRNlybTZKJg9Q22VJNVl
        JRBBTxzwkqyaZY4f9M20KxiVxQseDjit+jaZPg==
X-Google-Smtp-Source: ADKCNb71qk2J5LQbIuo4Zczhja35oZ2USU9zgdzdVZ3JNjVL1SwpkuSnArqaLXcedTw6x+b4GU3VX2SURNeGrdzDD8s=
X-Received: by 10.202.117.129 with SMTP id q123mr5985189oic.0.1504201219131;
 Thu, 31 Aug 2017 10:40:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.14.141 with HTTP; Thu, 31 Aug 2017 10:40:18 -0700 (PDT)
In-Reply-To: <20170830175005.20756-8-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de> <20170830175005.20756-8-l.s.r@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 Aug 2017 10:40:18 -0700
Message-ID: <CAGZ79kaaYpmq0VRM=wch5TGMLQM8gaCxM-QDtJuXWNhO9R=eSQ@mail.gmail.com>
Subject: Re: [PATCH 07/34] commit: release strbuf on error return in commit_tree_extended()
To:     Rene Scharfe <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 10:49 AM, Rene Scharfe <l.s.r@web.de> wrote:
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  commit.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 8b28415939..51f969fcbc 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1514,60 +1514,63 @@ N_("Warning: commit message did not conform to UTF-8.\n"
>  int commit_tree_extended(const char *msg, size_t msg_len,
>                          const unsigned char *tree,
>                          struct commit_list *parents, unsigned char *ret,
>                          const char *author, const char *sign_commit,
>                          struct commit_extra_header *extra)
>  {
>         int result;
>         int encoding_is_utf8;
>         struct strbuf buffer;
>
>         assert_sha1_type(tree, OBJ_TREE);
>
>         if (memchr(msg, '\0', msg_len))
>                 return error("a NUL byte in commit log message not allowed.");
>
>         /* Not having i18n.commitencoding is the same as having utf-8 */
>         encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
>
>         strbuf_init(&buffer, 8192); /* should avoid reallocs for the headers */
>         strbuf_addf(&buffer, "tree %s\n", sha1_to_hex(tree));
>
>         /*
>          * NOTE! This ordering means that the same exact tree merged with a
>          * different order of parents will be a _different_ changeset even
>          * if everything else stays the same.
>          */
>         while (parents) {
>                 struct commit *parent = pop_commit(&parents);
>                 strbuf_addf(&buffer, "parent %s\n",
>                             oid_to_hex(&parent->object.oid));
>         }
>
>         /* Person/date information */
>         if (!author)
>                 author = git_author_info(IDENT_STRICT);
>         strbuf_addf(&buffer, "author %s\n", author);
>         strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_STRICT));
>         if (!encoding_is_utf8)
>                 strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
>
>         while (extra) {
>                 add_extra_header(&buffer, extra);
>                 extra = extra->next;
>         }
>         strbuf_addch(&buffer, '\n');
>
>         /* And add the comment */
>         strbuf_add(&buffer, msg, msg_len);
>
>         /* And check the encoding */
>         if (encoding_is_utf8 && !verify_utf8(&buffer))
>                 fprintf(stderr, _(commit_utf8_warn));
>
> -       if (sign_commit && do_sign_commit(&buffer, sign_commit))
> -               return -1;
> +       if (sign_commit && do_sign_commit(&buffer, sign_commit)) {
> +               result = -1;
> +               goto out;
> +       }

While this seems obviously correct (following the "goto cleanup" pattern),
I shortly wondered if it can be expressed more concisely, as we really skip
only one call:

    if (!sign_commit || !do_sign_commit(&buffer, sign_commit))
        result = write_sha1_file(...)
    else
        result = -1;

    strbuf_release(&buffer);
    return result;

Instead of an if, we could even inline it as

    result = (!sign_commit || !do_sign_commit(&buffer, sign_commit)) ?
        write_sha1_file(buffer.buf, buffer.len, commit_type, ret) : -1;

     strbuf_release(&buffer);

I am not sure if this is easier to read (maybe that is too dense?)
Just thought for food, the original patch looks good, too.

Thanks,
Stefan
