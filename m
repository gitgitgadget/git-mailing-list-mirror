Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 250F22023D
	for <e@80x24.org>; Tue, 23 May 2017 05:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932567AbdEWF7U (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 01:59:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34747 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753262AbdEWF7T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 01:59:19 -0400
Received: by mail-pf0-f193.google.com with SMTP id w69so25113850pfk.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 22:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FSkYSYbQcbqcpneVwR6onCWPlmwjRrcMRtGYeYP9OEk=;
        b=hhxi1C5JBh/haqWjnEsViPKpKJtriXhsP02l6Du0Gwm84BRLB9DEH8pzaASqda9Mv9
         Dox042aHO0TqM+MMcA5xfghX+JmaXaqzL/0EfM4qx+JnDhW622HM7FSkuIjhHmd79GJQ
         NVY0jYLkSpSSrpQC9GZpugaKPudhm3/Z8el1KPxPUYhExuYw84EVtofPIgmDnpzd6aPI
         3LQ0/HwI9O6pjrc1nEWoDS+iUKkh9YTOm5+MSJncAbltzoHkqXX8c+rKow2A1aXs4hc5
         8P6fSUHb1orDnM7UV3kNruNQVG+0K/zv9gATTEmOGTGCgLFhvgmXKuJ4hGpD/lbui/gO
         YtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FSkYSYbQcbqcpneVwR6onCWPlmwjRrcMRtGYeYP9OEk=;
        b=ll3dFIjsp3GwL366xn7HiVCnz3AFI/zqHBdKGCAKMTtOcVLJFtK3i6tQhzX/Vbh8E8
         I3grdivBDJ3MHSgTI+e9eG7h7h6eDD3GHX97jLgL6rJNFVqths0NFsEeRPrDYj6kxQcA
         UI9sFtSVzYAY8SUHp90LsyQyWQ+5WTEIc5UOg4ANwSehXcjZM0QvJv8b+NPibDYbC1VN
         ZflnxPTjzA1Bgz7oBoEI3V0Wl6lGLgpnzZjAashfuBwdrB73EzRcFDeZMuHGqeFt0GkX
         hyTHYpYF6msptNjPH8WbISC1p7cF6IoNmymMfGpOQPgBa8GsYgGFE77ltPiQA/uZEi5Y
         zABQ==
X-Gm-Message-State: AODbwcDJDPGvSowDszKoH7R/OCsraUx5SrzxU0JPufS8lmcWEXggWQuO
        C4m0jZ+XkPw9o0roy48=
X-Received: by 10.99.23.100 with SMTP id 36mr519109pgx.118.1495519158337;
        Mon, 22 May 2017 22:59:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id t3sm32608211pfl.60.2017.05.22.22.59.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 22:59:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu
Subject: Re: [PATCHv4 09/17] submodule.c: convert show_submodule_summary to use emit_line_fmt
References: <20170518193746.486-1-sbeller@google.com>
        <20170523024048.16879-1-sbeller@google.com>
        <20170523024048.16879-10-sbeller@google.com>
Date:   Tue, 23 May 2017 14:59:16 +0900
In-Reply-To: <20170523024048.16879-10-sbeller@google.com> (Stefan Beller's
        message of "Mon, 22 May 2017 19:40:40 -0700")
Message-ID: <xmqqinksktaj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/submodule.c b/submodule.c
> index d3299e29c0..428c996c97 100644
> --- a/submodule.c
> +++ b/submodule.c
> ...
> @@ -547,15 +543,16 @@ void show_submodule_inline_diff(FILE *f, const char *path,
>  	if (right)
>  		new = two;
>  
> -	fflush(f);
>  	cp.git_cmd = 1;
>  	cp.dir = path;
> -	cp.out = dup(fileno(f));
> +	cp.out = -1;
>  	cp.no_stdin = 1;
>  
>  	/* TODO: other options may need to be passed here. */
>  	argv_array_push(&cp.args, "diff");
> -	argv_array_pushf(&cp.args, "--line-prefix=%s", line_prefix);
> +	if (o->use_color)
> +		argv_array_push(&cp.args, "--color=always");
> +	argv_array_pushf(&cp.args, "--line-prefix=%s", diff_line_prefix(o));

This makes me wonder if we also need to explicitly decline coloring
when o->use_color is not set.  After all, even if configuration in
the submodule's config file says diff.color=never, we will enable
the color with this codepath (because the user explicitly asked to
use the color in the top-level), so we should do the same for the
opposite case where the config says yes/auto if the user said no at
the top-level, no?
