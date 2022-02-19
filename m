Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5924CC433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 05:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiBSFmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 00:42:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiBSFme (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 00:42:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8773B02B
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 21:42:15 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lw4so19659399ejb.12
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 21:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=BVmA+PP2JVhZV3UQ3fkuY4upVlZKkr5jLKAXl7il9ng=;
        b=YbGeworHX0TSPaXE595CgJMDdCswU2Z1iEfWmcVrmzFK1fupzSO1A+jkqOYadN8TLH
         NjP/PwOXsMm9OT3WCBT0mC5LUUS+xamHzrk7/e5Bvs84OgiGP0W0u/IBkqa+GV64PTsz
         iYbEo5SQZpH5ntJThzdDbkYm1I2R3JwdzL2LPlHCFHwTWAys3hnWOnkH8TFQbDOV2FS/
         iV79bk8yiBecJyIIu/jQbHD505LYHxq6atWxvvR+aXr6fmxXM4ziTK1YsBaFfVK/JyR4
         ARxVRmLtTRFmcBwT4PO7zQjfLjWiUFBrlQYWw1JrYGiv03zg+2SC1ZbiYV5QfHFwJ8IX
         guYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=BVmA+PP2JVhZV3UQ3fkuY4upVlZKkr5jLKAXl7il9ng=;
        b=DtpGlpZTsdjQY5SzsiiE4xTu6df7l4G8O4AVJgCPj7DJM1OwvP9gzRdU5l1pSJKCgC
         4/qdbSPwDM/0IkBqFS+72YC+GVuWYFbuc3S14wyrJxrsBmkO4t9YZfeB4j3vp/Lv/eDd
         ix3EuWW0C8n4/cfV7x1lWKzavmCoOb6VjxdbgE+MzvdgtBpQxQwyepTcc/G+9HDCceN2
         1eFxgluAlZCY4hPSFV5vRgZnrE/tdeKCr5XOj3Vsn/kCQ0nH0hJzCU1ePaicc5JKZQym
         P4xWcUMjzDe5A3/gnBURuFHZZd860dg5qldahEb95MFykWj5tXatQesBnVP3tul1cuXv
         gjRA==
X-Gm-Message-State: AOAM532aA5gXBO8mVV7J+WPnEXKDi9aM4LwNj4pkvT39yznpTXxCP0Nr
        Zs+rX+PPEtNYJMOT3lkW+R8=
X-Google-Smtp-Source: ABdhPJxwen/T0sV+A+Zb8H8WVCe3SGUSJaGvKiKxlKGnm5kFjbeROaJtlQEv5wMDj0vyufq1Qgge3w==
X-Received: by 2002:a17:906:2bd7:b0:6cd:f89d:c828 with SMTP id n23-20020a1709062bd700b006cdf89dc828mr9155785ejg.232.1645249333502;
        Fri, 18 Feb 2022 21:42:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ha3sm2889532ejb.157.2022.02.18.21.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 21:42:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLIVY-004nOT-4k;
        Sat, 19 Feb 2022 06:42:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v11 12/13] ls-tree: introduce function "fast_path()"
Date:   Sat, 19 Feb 2022 06:32:21 +0100
References: <cover.1644319434.git.dyroneteng@gmail.com>
 <6d264977491b3645292bba5f91479ab1623e8b80.1644319434.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <6d264977491b3645292bba5f91479ab1623e8b80.1644319434.git.dyroneteng@gmail.com>
Message-ID: <220219.86v8xbe7kb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 08 2022, Teng Long wrote:

> The generic "show_tree_fmt()" is slower than "show_tree()", so
> we want to take the fast path if possible.
>
> when "--format=<format>" is passed, "fast_path()" will determine
> whether to use "show_tree()" or insist on using "show_tree_fmt()"
> by a try of finding out if the built-int format is hit.
>
> This commit take out the related codes from "cmd_ls_tree()" and
> package them into a new funtion "fast_path()".
>
> Explain it a little bit further, whether fast_path is hit or not,
> the final correctness should not break. Abstracting a separate method
> helps improve the readability of "cmd_ls_tree()" and the cohesiveness
> and extensibility of fast path logic.

This whole commit message sounds a bit like "we're introducing this fast
path", but really it got added in 11/13, and this is just a refactoring
to split that into a function to slightly reduce the size of
cmd_ls_tree() itself.

Which I really don't mind, but it would be better if the commit message
said so, e.g.:

    In a preceding commit a fast path selection was added to cmd_ls_tree(),
    split it into a utility function because ...

But I got stuck on "..." because I couldn't find a reason :)

I.e. in 13/13 this isn't used at all, except by adding a new brace arm
to it, but then it could still live in cmd_ls_tree().

Personally I think the pre-image is a bit easier to read, but then again
I wrote that so I'm biased. I don't mind changing this, but structurally
for the series it seems better to squash it in if you'd want to keep it.

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/ls-tree.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 1c71e5d543..ba96bcf602 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -58,6 +58,19 @@ enum {
>  
>  static int cmdmode = MODE_UNSPECIFIED;
>  
> +static int fast_path(void){
> +	if (!strcmp(format, default_format)) {
> +		return 1;
> +	} else if (!strcmp(format, long_format)) {
> +		shown_fields = shown_fields | FIELD_SIZE;
> +		return 1;
> +	} else if (!strcmp(format, name_only_format)) {
> +		shown_fields = FIELD_PATH_NAME;
> +		return 1;
> +	}
> +	return 0;
> +}

Just in terms of arranging things if you add a static function and it's
only used in one other function, here in cmd_ls_tree(), it's more
readable to add it immediately before that function.

>  static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
>  			      const enum object_type type, unsigned int padded)
>  {
> @@ -350,15 +363,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>  	 * The generic show_tree_fmt() is slower than show_tree(), so
>  	 * take the fast path if possible.
>  	 */
> -	if (format && (!strcmp(format, default_format))) {
> -		fn = show_tree;
> -	} else if (format && (!strcmp(format, long_format))) {
> -		shown_fields = shown_fields | FIELD_SIZE;
> -		fn = show_tree;
> -	} else if (format && (!strcmp(format, name_only_format))) {
> -		shown_fields = FIELD_PATH_NAME;
> -		fn = show_tree;
> -	} else if (format)
> +	if (format && !fast_path())
>  		fn = show_tree_fmt;
>  
>  	return !!read_tree(the_repository, tree, &pathspec, fn, NULL);

Also in terms of structure wouldn't it be better to end up with this:

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 9819a241869..47f7e2136b0 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -355,8 +355,6 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	if (get_oid(argv[0], &oid))
 		die("Not a valid object name %s", argv[0]);
 
-	parse_shown_fields();
-
 	/*
 	 * show_recursive() rolls its own matching code and is
 	 * generally ignorant of 'struct pathspec'. The magic mask
@@ -373,6 +371,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(&oid);
 	if (!tree)
 		die("not a tree object");
+
+	parse_shown_fields();
 	/*
 	 * The generic show_tree_fmt() is slower than show_tree(), so
 	 * take the fast path if possible.

I.e. have the whole "shown_fields" decisions be near one another.
