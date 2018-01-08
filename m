Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 191DC1F406
	for <e@80x24.org>; Mon,  8 Jan 2018 10:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756486AbeAHKmc (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 05:42:32 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33369 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755823AbeAHKmb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 05:42:31 -0500
Received: by mail-oi0-f68.google.com with SMTP id y141so669024oia.0
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 02:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U5OwR0WbrG/egkNJIig2GcY/9LRj49Kh9iXaJgRl4Dc=;
        b=eaZoNV6fFjLvxDb3xdslE3urx2FV4JSyqGVdm6sQKj4N/4NkU96N6gL/Om/Uwbemtf
         wZ11In9RqxhsCSlvoBftc+KTV3UuKQ4Pi+LuH3DGwycna13RoowqLvaVtvWBib/8uTvK
         a2DDyXcRGLj+S4pjhrCjRzuZnUlfAJDjyUaNhKNXnNxZdc4eAvtzXKRTa2UCUayWZWcd
         HfFvS0JLjn0VTzpSdJbmOhPPzPcPH+7IYr3ceL0NUHpJ4QzXcEV1NtAqNce70Sk9M9T9
         qBM1ruBI8ge0XQ+f2gW1jYO3UaA5Z2TEYgyGFCOToAs/I0rHZiH+TGbz0Z2y2BjJuIiU
         37IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U5OwR0WbrG/egkNJIig2GcY/9LRj49Kh9iXaJgRl4Dc=;
        b=BgWTo/sU7z4cwD5n6Mj2wBQS9xxD3WN9sZuS+6phNGOFrlTnm/aSZg5xR8UDMln6eA
         bUdNSSZ+bJDkq74JJTPXfkKg/xX/6Y9qnJNnZRXQOat/SO7sgmFoNoyd7y5Ob01QD6aL
         AQrz+JO+sWMh0aKo4u6GNUHh5QFJ63PQup7Lmdy0Z/CWFMtTXCMFFoaiaswmKVg5SRwf
         oUfbI6nUds7+NxxSkOkCuC99izGzJtFwhVf4fOwJqvELT1vt5EPx7c/0GxgC7FdCNe96
         Lzbq7f3UA4Xsq8hrEOyEa7KEc7qw2E7+H7cEaFke0LueXCcKQLgPgYiUohwOo41qPor8
         OvBQ==
X-Gm-Message-State: AKwxytdmuwKOFSP3JLFJAbQBCjeFO1ppup+m8BRfVWH9TSuSTV96LAjP
        QLFh1urIEhHOIQZy7G+wuikn1NxdFRDTBoJtrmg=
X-Google-Smtp-Source: ACJfBovk0VIxYsuLuXWKefIdC+LfLSMZ+lAYoKbQpAoSmCv3EOzYmnOUnwh5z2Q8rfgYvQR5gTygnT4aB0ZDZRsvOzs=
X-Received: by 10.202.68.2 with SMTP id r2mr7939oia.351.1515408150289; Mon, 08
 Jan 2018 02:42:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Mon, 8 Jan 2018 02:41:59 -0800 (PST)
In-Reply-To: <20180107223015.17720-2-t.gummerer@gmail.com>
References: <20171217225122.28941-1-t.gummerer@gmail.com> <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180107223015.17720-2-t.gummerer@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 8 Jan 2018 17:41:59 +0700
Message-ID: <CACsJy8DBkAwoNWSma-+WkOUkQrenbkT5c1-Ez2jmmf-+wGRbxQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for other repos
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 8, 2018 at 5:30 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> @@ -1896,16 +1895,17 @@ int read_index_from(struct index_state *istate, const char *path)
>                 split_index->base = xcalloc(1, sizeof(*split_index->base));
>
>         base_sha1_hex = sha1_to_hex(split_index->base_sha1);
> -       base_path = git_path("sharedindex.%s", base_sha1_hex);
> +       base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_sha1_hex);

Personally I prefer the repo_git_path() from v2 (sorry I was away and
could not comment anything). The thing is, git_path() and friends
could do some path translation underneath to support multiple
worktrees. Think of the given path here as a "virtual path" that may
be translated to something else, not exactly <git_dir> + "/" +
"sharedindex.%s". But in practice, we're not breaking the relationship
between $GIT_DIR/index and $GIT_DIR/sharedindex.* any time soon, doing
manual path transformation here is fine.

What about the other git_path() in this file? With patch applied I still get

> ~/w/git/temp $ git grep git_path read-cache.c
read-cache.c:           shared_index_path = git_path("%s", de->d_name);
read-cache.c:   temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
read-cache.c:                         git_path("sharedindex.%s",
sha1_to_hex(si->base->sha1)));
read-cache.c:           const char *shared_index = git_path("sharedindex.%s",

I suppose submodule has not triggered any of these code paths yet. Not
sure if we should deal with them now or wait until later.

Perhaps if we add a "struct repository *" pointer inside index_state,
we could retrieve back the_repository (or others) and call
repo_git_path() everywhere without changing index api too much. I
don't know. I like the  'struct repository' concept but couldn't
follow its development so I don't if this is what it should become.
-- 
Duy
