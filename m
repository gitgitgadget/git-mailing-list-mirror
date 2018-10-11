Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D1A1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 22:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeJLGKY (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:10:24 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:50786 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJLGKY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:10:24 -0400
Received: by mail-qt1-f202.google.com with SMTP id n1-v6so10188920qtb.17
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nLp7mWlNZN3WbUNvE5PEPR2WPA0StUMpH6fycLvwHlQ=;
        b=Tu5I0bIWmy7xQu5vqHrLWp906U9+dHC+5ic4rj2hKA8HO8BadBlEPwdlWkgHk9SSTf
         TcY5Kgy4GeuDhH/lfWiokLlgR0lr4Omo6NTY+HL+xCVZmVCIsEmoorQ7fbxGsRUMT7iL
         EGeWDrOH/CnRibyigf13HCZtSqHnXda8PWKD2/X6iopDf9Y8eD6KzY4/gvVxKPyCo/jc
         /6u7wRsPbulotZngDlRWVJU06uVLDYoACkA1+z6ZNvq4amQYiycgxuUJWeGe9iiCqeH8
         Io+ECIvOY/S0KIU1r9V4xob7N0BGX237QtR2be6jPhC0VIgw14/migGkQCZrWD8Wu3CM
         qcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nLp7mWlNZN3WbUNvE5PEPR2WPA0StUMpH6fycLvwHlQ=;
        b=FPu6Gyeor/aX88Dfq5rBktjNSO9FmHJpgeKKzc1nepR72oFGGQZMwBYwXzKUloNGW4
         g/vVOGDB1ltfF80o2KWx9/GdsutfOABaGf6j1S4XQpBTYwfW6yAWNVxgGSyraamzd9U4
         nvCELYTafHTAI6X/fbzLj6YjUvJ/2NCABCdoHV1MUuzlcnMzOmwADttmuK7bxLDMJi76
         fiVF7RZneo6rY8O3utsYne7YSpqFUOQWGaZWkUEfouUnk3rgmYTGykfjPoywK66NjpSz
         bIaTfD1dX8nngEv3XqDKjKAK5u2lu0ndNVNQGrkwpYm404RQ/817qDECmg6EK/FYmGb5
         mtJg==
X-Gm-Message-State: ABuFfogeFVMpO04ncF0jzUzF+0v/+TJHl7FpFMGq6hRsbHkgpyYVWy+m
        QBRYYMy0zFsDLDhzqOIHKwuW3ZvjwnuLGJQ9v+jj
X-Google-Smtp-Source: ACcGV62SzUM8VWnNftyRgywAEi+8bpG2gzysNhRMfMUpRsG7ysV+R5OqEeRBjmrkJjkpaB4fPzYjQf9+Hh32wr8LVsCn
X-Received: by 2002:ac8:2ef7:: with SMTP id i52-v6mr3030089qta.34.1539297662598;
 Thu, 11 Oct 2018 15:41:02 -0700 (PDT)
Date:   Thu, 11 Oct 2018 15:40:52 -0700
In-Reply-To: <20181011211754.31369-18-sbeller@google.com>
Message-Id: <20181011224052.191281-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-18-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 17/19] submodule: use submodule repos for object lookup
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +/*
> + * Initialize 'out' based on the provided submodule path.
> + *
> + * Unlike repo_submodule_init, this tolerates submodules not present
> + * in .gitmodules. NEEDSWORK: The repo_submodule_init behavior is
> + * preferrable. This function exists only to preserve historical behavior.

What do you mean by "The repo_submodule_init behavior is preferable"? If
we need to preserve historical behavior, then it seems that the most
preferable one is something that meets our needs (like open_submodule()
in this patch).

> +static int open_submodule(struct repository *out, const char *path)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
> +		strbuf_release(&sb);
> +		return -1;
> +	}
> +
> +	out->submodule_prefix = xstrdup(path);

Do we need to set submodule_prefix?

> @@ -507,7 +533,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
>  	else if (is_null_oid(two))
>  		message = "(submodule deleted)";
>  
> -	if (add_submodule_odb(path)) {
> +	if (open_submodule(sub, path) < 0) {

This function, as a side effect, writes the open repository to "sub" for
its caller to use. I think it's better if its callers open "sub" and
then pass it to show_submodule_header() if successful. If opening the
submodule is expected to fail sometimes (like it seems here), then we
can allow callers to also pass NULL, and document what happens when NULL
is passed.

Also, repositories open in this way should also be freed.
