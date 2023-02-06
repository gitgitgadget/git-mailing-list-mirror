Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ACFC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 20:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjBFUaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 15:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBFUaM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 15:30:12 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A8929E2F
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 12:30:10 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p26so37615448ejx.13
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 12:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pYysp2PG4ezhAyoYXiU/oSMs5qlk3buEH8qGm9ssS18=;
        b=Tvll+B/OHBsXgbBVK/7HxqT9WYGkIbaCoGyu2YmKa+KgIYy+O+Nqx+cPQkxqGsqTZD
         i2LcyuL01hMOCEzbmMe4tI4bGkxP1ehlbIQfcM0VOjGw3L8IDtkrplScRxI+TNGGPBwu
         HEjX06ZvYzG65mCI0YrnPlExr4pBaAzdOpginH+0TSB3IBNlfqdG2I5GT5Qcdp28bjWY
         JGBBroROCTSp9w6YNqTQjDWorH3DfkcLgJx1fd9zYrNyNgivAQaxW9dMPwQhkYQNdDSj
         T/1Lg2BO28qs9WaUfPwnwQP7sNMxOwySTGO+qtRy9ReaNY/QXR7tHLX0FVNJv2kxeH4u
         0ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYysp2PG4ezhAyoYXiU/oSMs5qlk3buEH8qGm9ssS18=;
        b=xa2QY9CyJEafY4Xrjt1juGtTV803kywfRGQecErrFAkHxm+1kfnmEO4BPr/zVtnWje
         I/Gv4bx+CC5AtT8x+Ji4jRQub5J1ph15/+5mAm6wWWe5qJ8LJ16n6MTXMceScE3z/fEG
         3jaDzNjdWyhq1Lb45C1EXGzYvymi4F0SGnsroiWMUzVdkLmLfVHfE1mv9+8lSmzGG0o3
         zrB0rqZgxYh4fU2sLUYTGWT2rumuNX+1faa+c9Yfx77qH5LfnvLWuLwkuJUnxkTognSq
         OegsIFW0xwMt2tI5iLATFqblkEDYVnIhQitT70hOrrlEhV3FTjE0os2g++yNpa+v7Dbo
         vEHA==
X-Gm-Message-State: AO0yUKWFb0cPDIqAxxE+PU4RkCtIh3q6CZ8wviGW1F85H2wYF6h8DXQJ
        juqgDDHk03zcWgXe5XyVl8IXeUU7wuptL+O2
X-Google-Smtp-Source: AK7set/m6eZxP636RD2Qq4zCWqrP1VCELKMvSNgXuugNxPPqb8/JozysiFAfzPAiM5f1SWqzveGgIw==
X-Received: by 2002:a17:907:6d29:b0:7c1:6e08:4c20 with SMTP id sa41-20020a1709076d2900b007c16e084c20mr765133ejc.7.1675715409205;
        Mon, 06 Feb 2023 12:30:09 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id gz21-20020a170907a05500b0086a2e31d1c1sm5881210ejc.28.2023.02.06.12.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:30:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP87r-000VK7-1k;
        Mon, 06 Feb 2023 21:30:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: clarify multiple pushurls vs urls
Date:   Mon, 06 Feb 2023 21:11:51 +0100
References: <20230206195503.3113048-1-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230206195503.3113048-1-calvinwan@google.com>
Message-ID: <230206.86k00u5ygg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 06 2023, Calvin Wan wrote:

> While it is possible to define multiple `url` fields in a remote to
> push to multiple remotes at once, it is preferable to achieve this by
> defining multiple `pushurl` fields.

The idea with "url" and "pushurl" surely is to disambiguate whether you
want the url for both push & fetch, or just push.

I don't see why it's a given that it's preferrable to use "pushurl" over
"url" yet, if your setup is e.g. 3 repos you push to, but it won't
matter what you pull from why not use "url"? As opposed to pushing
"pushurl" to push to read-only mirrors you yourself are updating?

But let's read on...

> Defining multiple `url` fields can cause confusion for users since
> running `git config remote.<remote>.url` returns the last defined url
> which doesn't align with the url `git fetch <remote>` uses (the first).

I'm certainly confused, I had no idea it worked this way, I'd have thought it was last-set-wins like most things.

From a glance fb0cc87ec0f (Allow programs to not depend on remotes
having urls, 2009-11-18) mentions it as a known factor, but with:
	
	diff --git a/transport.c b/transport.c
	index 77a61a9d7bb..06159c4184e 100644
	--- a/transport.c
	+++ b/transport.c
	@@ -1115,7 +1115,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
	 	helper = remote->foreign_vcs;
	 
	 	if (!url && remote->url)
	-		url = remote->url[0];
	+		url = remote->url[remote->url_nr - 1];
	 	ret->url = url;
	 
	 	/* maybe it is a foreign URL? */

All tests pass for me, and it's selecting the last URL now. I can't find
any other mention of these semantics in the docs (but maybe I didn't
look in the right places).

So is this just some accident, does anyone rely on it, and would we be
better off just "fixing" this, rather than steering people away from
"url"?

> Add documentation to clarify how fetch interacts with multiple urls
> and the recommended method to push to multiple remotes.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  Documentation/urls-remotes.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
> index 86d0008f94..61aaded645 100644
> --- a/Documentation/urls-remotes.txt
> +++ b/Documentation/urls-remotes.txt
> @@ -33,7 +33,10 @@ config file would appear like this:
>  ------------
>  
>  The `<pushurl>` is used for pushes only. It is optional and defaults
> -to `<URL>`.
> +to `<URL>`. Additional pushurls can be defined to push to multiple
> +remotes. While multiple URLs can be defined to achieve the same
> +outcome, this is not recommended since fetch only uses the first
> +defined URL.

Maybe it's just me, but I feel more confused reading this docs than
before :)

Surely if there's confusion about the priority of the *.url config
variable we should be documenting that explicitly where we discuss "url"
itself (e.g. in Documentation/config/remote.txt). Just mentioning it in
passing as we document "pushUrl" feels like the wrong place.

But I still don't quite see the premise. "git push" has a feature to
push to all N urls, whether that's Url or pushUrl.

When I configure it to have multiple URLs it pushes to the first
configured one first, if the source of the confusion was that it didn't
prefer the last configured one first, shouldn't it be doing them in
reverse order?

I don't think that would make sense, but I also don't see how
recommending "pushurl" over "url" un-confuses things.

So why is it confusing that "fetch" would use the same order, but due to
the semantics of a "fetch" we'd stop after the first one?
