Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D718C636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 17:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBORt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 12:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBORtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 12:49:25 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1FF2FCC7
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 09:49:24 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id o8so18609097pls.11
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 09:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TZR+plle4IfGBpM8Uqlcg5/m/X9qjd37Ijl+1J/wU8=;
        b=fx87yRJ8pfydQLSMDx8KgcdpEWnNIi41XLhfK2kHTOLQlucsFlZDSv3UNPS2oilfzh
         ycwJed3OLNtQWAb8BMYPp/s2SrKHEIjAQ6PafQ2AbF3nt9qtozVhUl1IgRJCjI60gpbj
         CQjfhpxX6dHE/HSznjZMe+c6zN2CPCirm1XB1twpp4CgFGK53deDaPNFxLRjhwRJMAn/
         yqvQw/VoRjhnbdIdFzX2T9fnpM3bnh/drwZE7Qf+rgODhOVLxjUtbEIkJ/omNuj/oLBx
         KDLx/8a0vnooC8HhtzBSJryy5V0UBr6jkFpeXCTTK3u/BK1RG1YcnJPku7q2HUJ5dHFW
         KKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7TZR+plle4IfGBpM8Uqlcg5/m/X9qjd37Ijl+1J/wU8=;
        b=oa3aEKgFxeznEwigYXIMFCEMhA1JooB36M51TOkeFB4w2jRhoWiK88kMJlgQphsrSZ
         5/NqYVFoQhqmilhuZ1/N53Yse4o8qsKmVviSPc+IXQhGNc4+i1yktMYeM9uRRuzgjmyK
         PZLcUpQfGZWAUHcdTkM3L6DoYlAAo71sKWBaa1eJqORzQ7WkyxJPWnxTOMeujvjHusV/
         SWX3fZ9NwxccuJVIXz8k30eKFKcKjdP123jTtGNWEOYNZSo8/4AGxvKYMaJpKfRHLSNb
         3oxCHToUwwNlr5GSuAj+cfaU/Ev5M61ZTg8S4Rc20PpfI7x3sTZs7m1vhHS86sRpUpzi
         8mOQ==
X-Gm-Message-State: AO0yUKXUjH1L2jeYUleF61PUDcnOe+neCgbhe1jQs8m/gljjj7zjwu/w
        L8ND0cJ2Bv0BqbIeRCRgIS0=
X-Google-Smtp-Source: AK7set/U2CJBCJbqI3lSzt2gkZlyz5nfirt6itYcddjTMyYKj1sBzXX4jK/txkaQAyaw2v+V87ljOw==
X-Received: by 2002:a05:6a21:1507:b0:bf:58d1:ce8a with SMTP id nq7-20020a056a21150700b000bf58d1ce8amr4502522pzb.9.1676483364046;
        Wed, 15 Feb 2023 09:49:24 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id a18-20020a637052000000b004fb3e5681cesm4802621pgn.20.2023.02.15.09.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 09:49:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [GSoC][PATCH v3] apply: Change #define to enum and variable
 types from int to enum
References: <20230215091950.2976-1-vinayakdev.sci@gmail.com>
Date:   Wed, 15 Feb 2023 09:49:23 -0800
In-Reply-To: <20230215091950.2976-1-vinayakdev.sci@gmail.com> (Vinayak Dev's
        message of "Wed, 15 Feb 2023 14:49:50 +0530")
Message-ID: <xmqqmt5ezun0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vinayak Dev <vinayakdev.sci@gmail.com> writes:

> diff --git a/apply.c b/apply.c
> index 5cc5479c9c..b2a03d9fc3 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -205,8 +205,10 @@ struct fragment {
>   * or deflated "literal".
>   */
>  #define binary_patch_method leading

Notice and explain what this line is doing, perhaps?

> -#define BINARY_DELTA_DEFLATED	1
> -#define BINARY_LITERAL_DEFLATED 2
> +enum binary_type_deflated {
> +	BINARY_DELTA_DEFLATED = 1,
> +	BINARY_LITERAL_DEFLATED
> +};

These days, we not just allow but encourage enum definitions to have
a trailing comma after the last item, UNLESS we want to signal that
the one at the end right now MUST stay to be the last one (e.g. a
sentinel at the end).

A patch that adds a new item to, removes an existing item from, or
shuffles existing items in the list can be free of unnecessary patch
noise to omit the last comma.

As a faithful rewrite, forcing the same values to be given as before
by saying that "_DEFLATED must be 1" is a good thing to do, but once
the dust settled from the patch, it would be a good idea to go back
to the code and see if the values MUST be these, or if it is fine to
use any value as long as they are distinct.  If it is the latter,
then it would make a good follow-up patch to remove "= 1", with an
explanation why it is a safe thing to do.

>  static void free_fragment_list(struct fragment *list)
>  {
> @@ -918,14 +920,17 @@ static int gitdiff_hdrend(struct gitdiff_data *state UNUSED,
>   * their names against any previous information, just
>   * to make sure..
>   */
> -#define DIFF_OLD_NAME 0
> -#define DIFF_NEW_NAME 1
> +
> +enum diff_name {
> +	DIFF_OLD_NAME = 0,
> +	DIFF_NEW_NAME
> +};

Ditto.

>  static int gitdiff_verify_name(struct gitdiff_data *state,
>  			       const char *line,
>  			       int isnull,
>  			       char **name,
> -			       int side)
> +			       enum diff_name side)
>  {
>  	if (!*name && !isnull) {
>  		*name = find_name(state->root, line, NULL, state->p_value, TERM_TAB);
> @@ -1910,7 +1915,7 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
>  	int llen, used;
>  	unsigned long size = *sz_p;
>  	char *buffer = *buf_p;
> -	int patch_method;
> +	enum binary_type_deflated patch_method;

This is not quite sufficient to achieve the goal of helping "modern
debuggers" that was stated in the proposed log message, is it?
parse_binary_hunk() copies the value from this local variable to a
member in the fragment being parsed, like so:

	frag->binary_patch_method = patch_method;

but the thing is, as we have seen earlier, a compiler macro is used
to (ab)use the "leading" member and call it "binary_patch_method".
The type of that member is "unsigned long".

Now if our ultimate goal were to use enum instead of macro, then an
obvious "solution" would be to stop abusing "leading".  Instead, you
would add "enum binary_type_deflated binary_patch_method" member to
the fragment struct and use the enum throughout.

But is it worth it?

Using enum instead of macro is *NOT* a goal.  If doing so makes our
code better, we may do so---which tells us that use of enum is not a
goal but a means to make our code better.  Is adding an extra member
that is used only for binary patches improve our code?  I dunno.

Thanks.
