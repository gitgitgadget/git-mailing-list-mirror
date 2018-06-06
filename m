Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54CEE1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 00:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeFFAht (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 20:37:49 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43929 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752741AbeFFAhs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 20:37:48 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so2626278plj.10
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 17:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VXILJRVPJq4R1NWeJyNdzCkmSU8Efqv5RO6tqh0Bm0M=;
        b=EIBA8blpFbaymOaEflzbDfe3SI57owFcdyh0SQi2D290OsdBmqrjag5EzzIxm2kcMt
         fagg126dLUiHeu6zahq7L/ZatqR7n4IsXeo8V8QrhmWw4+8yCO6xO3geNfXjx2cNm+Db
         jWPxiYaCc0h6FdWX2EjxCe5LMl7TeMaH17HbAQZL03tast/TdrtIE+tugrkj9zP3nbK9
         +kFQpneDnQwtph6UfTYKcSUMxdMGRLWN0kBrJE6OOUZiHmOL63V7rT0sLxLpgOlheKXw
         l60LRckzPmprzJFKhIOblDHK40jSCF80PNfqfg/iNhXqnCln4jr8wjvgjJ80P/qLo6uK
         bniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VXILJRVPJq4R1NWeJyNdzCkmSU8Efqv5RO6tqh0Bm0M=;
        b=dp4eAwsKcGqdIFVg5mmlxJNwFyzR01oee29JoIQf5fr6fS1hJC+AFb+J20WJRKAu+3
         1ia60vyD0gOGutZz4GyBGdB1pLWWp4P6YAXUpgOpBPC3uYmFslrOyoIcLdr7L6f5LtRF
         3ZDnSvg37IcSgGR0YisOmGTNDY0XBr8H2YspUTqJWwA+b7n/smpi+jqqQlPCqxrgbsYj
         I94ws8eWaWjM1ui84uz7i4HTlLn3gvbgSNcoyv6bUNZmNnpxHeQV0Zf6ejFZGZw2MjV6
         eKd1Zggl7+xEaBHwu8DdTZ6rbNPw7wsAGQOeas78zVznHtuT7pmWvMhz6A5Z2q9PyWhn
         x13Q==
X-Gm-Message-State: APt69E1UBMS+YXlLtPrPgy1mEhxN2x09QsiPQSAg1QrTsvdyWvvbXo23
        XZTLqaCJLzv958wrunfq5Y6HtIxM
X-Google-Smtp-Source: ADUXVKI75PWx9xQq/d6I1Xdvb+JiktGBFxM248yAHbiBn33TN22loQhJ+12Z007LlA0r9H5XHbzpzA==
X-Received: by 2002:a17:902:8306:: with SMTP id bd6-v6mr875139plb.120.1528245467565;
        Tue, 05 Jun 2018 17:37:47 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t3-v6sm19726644pfk.161.2018.06.05.17.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 17:37:46 -0700 (PDT)
Date:   Tue, 5 Jun 2018 17:37:45 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com
Subject: Re: [PATCH 6/6] fetch-pack: introduce negotiator API
Message-ID: <20180606003745.GI9266@aiede.svl.corp.google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <c7e504a4664bb6008de970671af13eda7d85dc5b.1527894919.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e504a4664bb6008de970671af13eda7d85dc5b.1527894919.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> Introduce the new files fetch-negotiator.{h,c}, which contains an API
> behind which the details of negotiation are abstracted. Currently, only
> one algorithm is available: the existing one.
>
> This patch is written to be more easily reviewed: static functions are
> moved verbatim from fetch-pack.c to negotiator/default.c, and it can be
> seen that the lines replaced by negotiator->X() calls are present in the
> X() functions respectively.

nit: s/more//

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Makefile             |   2 +
>  fetch-negotiator.c   |   7 ++
>  fetch-negotiator.h   |  45 ++++++++++
>  fetch-pack.c         | 207 ++++++++++---------------------------------
>  negotiator/default.c | 173 ++++++++++++++++++++++++++++++++++++
>  negotiator/default.h |   8 ++
>  object.h             |   3 +-
>  7 files changed, 282 insertions(+), 163 deletions(-)
>  create mode 100644 fetch-negotiator.c
>  create mode 100644 fetch-negotiator.h
>  create mode 100644 negotiator/default.c
>  create mode 100644 negotiator/default.h

Looks like a job for --color-moved. :)

[...]
> --- /dev/null
> +++ b/fetch-negotiator.c
> @@ -0,0 +1,7 @@
> +#include "fetch-negotiator.h"

To avoid various standards weirdness, the first #include in all files
should be git-compat-util.h, cache.h, or builtin.h.  I tend to just
use git-compat-util.h.

[...]
> +++ b/fetch-negotiator.h
> @@ -0,0 +1,45 @@
> +#ifndef FETCH_NEGOTIATOR
> +#define FETCH_NEGOTIATOR
> +
> +#include "cache.h"

What does this need from cache.h?

> +#include "commit.h"

optional: could use a forward-declaration "struct commit;" since we
only use pointers instead of the complete type.  Do we document when
to prefer forward-declaration and when to #include complete type
definitions somewhere?

[...]
> +struct fetch_negotiator {

Neat.  Can this file include an overview of the calling sequence / how
I use this API? E.g.

	/*
	 * Standard calling sequence:
	 * 1. Obtain a struct fetch_negotiator * using [...]
	 * 2. For each [etc]
	 * 3. Free resources associated with the negotiator by calling
	 *    release(this).  This frees the pointer; it cannot be
	 *    reused.
	 */

That would be a good complement to the reference documentation in the
struct definition.

[...]
> +++ b/object.h
> @@ -28,7 +28,8 @@ struct object_array {
>  /*
>   * object flag allocation:
>   * revision.h:               0---------10                                26
> - * fetch-pack.c:             0----5
> + * fetch-pack.c:             01
> + * negotiator/default.c:       2--5
>   * walker.c:                 0-2

Nice!

[...]
> +++ b/fetch-pack.c
[...]
> @@ -462,7 +348,7 @@ static int find_common(struct data *data, struct fetch_pack_args *args,
>  	retval = -1;
>  	if (args->no_dependents)
>  		goto done;
> -	while ((oid = get_rev(data))) {
> +	while ((oid = negotiator->next(negotiator))) {
[etc]

I like it. :)

[...]
> @@ -988,7 +870,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  	struct object_id oid;
>  	const char *agent_feature;
>  	int agent_len;
> -	struct data data = { { compare_commits_by_commit_date } };
> +	struct fetch_negotiator negotiator;
> +	fetch_negotiator_init(&negotiator);

Sane.

[...]
> @@ -1061,19 +944,17 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  	if (!server_supports("deepen-relative") && args->deepen_relative)
>  		die(_("Server does not support --deepen"));
>  
> -	if (marked)
> -		for_each_ref(clear_marks, NULL);
> -	marked = 1;
> -	if (everything_local(&data, args, &ref, sought, nr_sought)) {
> +	if (everything_local(&negotiator, args, &ref, sought, nr_sought)) {
>  		packet_flush(fd[1]);
>  		goto all_done;
>  	}
> -	if (find_common(&data, args, fd, &oid, ref) < 0)
> +	if (find_common(&negotiator, args, fd, &oid, ref) < 0)
>  		if (!args->keep_pack)
>  			/* When cloning, it is not unusual to have
>  			 * no common commit.
>  			 */
>  			warning(_("no common commits"));
> +	negotiator.release(&negotiator);

Should this go after the all_done so that it doesn't get bypassed in
the everything_local case?

[...]
> @@ -1434,6 +1316,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  			continue;
>  		}
>  	}
> +	negotiator.release(&negotiator);
>  
>  	oidset_clear(&common);

nit: could put the negotiator.release(&negotiator) after the blank
line, in the same paragraph as the other free calls like
oidset_clear(&common).

[...]
> +++ b/negotiator/default.c
> @@ -0,0 +1,173 @@
> +#include "default.h"

First #include should be "git-compat-util.h".

[...]
> +/*
> +   This function marks a rev and its ancestors as common.
> +   In some cases, it is desirable to mark only the ancestors (for example
> +   when only the server does not yet know that they are common).
> +*/

Not about this change: comments should have ' *' at the start of each
line (could do in a preparatory patch or a followup).

[...]
> --- /dev/null
> +++ b/negotiator/default.h
> @@ -0,0 +1,8 @@
> +#ifndef NEGOTIATOR_DEFAULT_H
> +#define NEGOTIATOR_DEFAULT_H
> +
> +#include "fetch-negotiator.h"
> +
> +void default_negotiator_init(struct fetch_negotiator *negotiator);

optional: same question about whether to use a forward declaration as in
fetch-negotiator.h.

Except where noted above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for a nice cleanup.
