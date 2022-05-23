Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EB5C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiEWUDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiEWUDj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:03:39 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493C720BD2
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:03:36 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g3so13362181qtb.7
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1vaNfqFlusmwEhS7dAy6RqsYBI7Y7rwpQMYaPjBl+PQ=;
        b=OCxJeHXfjgnKQRvIpHBPGIKfDdVB4fB1O0VCq19wiLSlM+YwYEeL6tsZS5ktBeRa3e
         P2hT7i7W8sbgUgw9A1SO71aw8bm3CVmgUykCU3v2wK95Xr1DhKNFGp0Hu25kUl6v/bpn
         vd2OGVUv6iILgdHmGEfKTRiTGZ62RWdPLfYvbpZbSCfARC21FfIsrnF8fMa6KjBjXz0K
         fKLmmHbCbmFH9eHumKcp0UERyAQyiw9JWWapIMLgqpMr/Bk2WvEueSky5+W6KI4QUwD4
         el0EO5NkzCdc8V7/gscr5LcgVOtpy/oRSK/z+z1e7WpWHVChDxlz3ZhKIuJQrOgzTb5x
         iFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1vaNfqFlusmwEhS7dAy6RqsYBI7Y7rwpQMYaPjBl+PQ=;
        b=PvqJc9HOdLJdJulcLjRD+Uc0JwJDs6YGDFhG4eAe5egJX5rGGK8eo0geLh3NUSLtXX
         9ipe8cLHGcr5X6OGf6KijFNCQFqPeabj6qZPBU8lTddMj8veFUYemKtAxRRX6VGEzm9n
         gnlOvk5yZqXAtd2rOWT4IewhX0mSgXqi2QX9v/tv9syZVomTxAu6RfEGhhBLCQVehzvX
         22mMEeDW457a6YocX8boyyxcThY7pk8yKz6jlYXdWcVVlacU2lYS9692GICoT5JeaO+M
         Q4fhCjfPWxW3k7AH7KzORXBBnY1rkdy+i8BF/hRzwAx0QsBKprVtLvQKJUbkKilD7Z5I
         6DDw==
X-Gm-Message-State: AOAM531QIlC+Ot8ZQD3SKuVGeVfVDFcHGSfaRJtiDXNq8uaI851Tk1zd
        d52oAq4KWpanJAATtIINmBbO
X-Google-Smtp-Source: ABdhPJwY3dmyGSfGocNfBaRYKTARXfhXuiP6cE1u9Jl36yJb3lD+bXQx43X7h3DmO4REMSDkTCZDiQ==
X-Received: by 2002:ac8:5ac3:0:b0:2f7:efab:98ee with SMTP id d3-20020ac85ac3000000b002f7efab98eemr17753697qtd.104.1653336215401;
        Mon, 23 May 2022 13:03:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:71ba:8ad9:40cd:d364? ([2600:1700:e72:80a0:71ba:8ad9:40cd:d364])
        by smtp.gmail.com with ESMTPSA id s16-20020ac87590000000b002f39b99f67fsm4791277qtq.25.2022.05.23.13.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 13:03:35 -0700 (PDT)
Message-ID: <8d483e1d-1865-c475-cbe3-78fa1f7f8bfb@github.com>
Date:   Mon, 23 May 2022 16:03:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] add-menu: added add-menu to lib objects
Content-Language: en-US
To:     Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Nadav Goldstein <nadav.goldstein96@gmail.com>
References: <pull.1232.git.1652649537647.gitgitgadget@gmail.com>
 <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
 <13bc75a2b0510f55e9a73852838b3b11683f13a2.1653286345.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <13bc75a2b0510f55e9a73852838b3b11683f13a2.1653286345.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/23/22 2:12 AM, Nadav Goldstein via GitGitGadget wrote:
> From: Nadav Goldstein <nadav.goldstein96@gmail.com>
> 
> added to the lib objects the add menu module which is
> simply extracted functions from clear.c
> (which in the next commit will be removed and instead
> clear will use the outsourced functions).

Please rewrite according to Git style. (Mentioned in
my reply to patch 2 with more detail.)

> diff --git a/add-menu.c b/add-menu.c

I think I said something in another place that was a
bit incorrect: I think of "git add -p" as interactive
add, but really it's "git add -i" that is the
equivalent. The "git add -i" menu is very similar to
the "git clean -i" menu, as it is said in comments.

Thus, perhaps the best thing to do would be to unify
the two implementations, if at all possible. The one
in builtin/clean.c is from 2013 while the one in
add-interactive.c is much more recent.

The biggest test of your new API is whether it can
support _both_ of these existing interactive menus
before adding one to 'git stash'.

> new file mode 100644
> index 00000000000..6a1c125d113
> --- /dev/null
> +++ b/add-menu.c
> @@ -0,0 +1,339 @@
> +#include <stdio.h>

In the Git project, the first include should either be
"cache.h" or "git-compat-utils.h". For this API,
git-compat-utils.h should suffice, since there should
not be anything from the Git data model that actually
matters here.

> +#include "builtin.h"
> +#include "add-menu.h"
> +#include "cache.h"
> +#include "config.h"
> +#include "dir.h"
> +#include "parse-options.h"
> +#include "string-list.h"
> +#include "quote.h"
> +#include "column.h"
> +#include "color.h"
> +#include "pathspec.h"
> +#include "help.h"
> +#include "prompt.h"

I doubt that these are all required. Please check to
see what you are using from each of these includes and
remove as necessary.

> +static const char *clean_get_color(enum color_clean ix)
> +{
> +	if (want_color(clean_use_color))
> +		return clean_colors[ix];
> +	return "";
> +}

Please update the method names to not care about clean.
This is especially true in the public API in the *.h file.

> +void clean_print_color(enum color_clean ix)
> +{
> +	printf("%s", clean_get_color(ix));
> +}
> \ No newline at end of file

nit: please make sure the file ends with exactly one newline.

One problem with this approach of adding the code to this
new *.c file and then later removing the code from clean is
that we lose 'git blame' or 'git log -L' history across the
move. It's much harder to detect copies than to detect moved
lines of code.

I don't have a good solution in mind right now, but it's
worth thinking about.

> diff --git a/add-menu.h b/add-menu.h
> new file mode 100644
> index 00000000000..52e5ccb1800
> --- /dev/null
> +++ b/add-menu.h
> @@ -0,0 +1,51 @@

Don't forget the #ifndef __ADD_MENU__/#define __ADD_MENU__
trick to avoid multiple declarations of these values.

> +int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff, void (*prompt_help_cmd)(int));
> \ No newline at end of file

nit: newline here, too.

Thanks,
-Stolee
