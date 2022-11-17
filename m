Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E22C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 14:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbiKQOGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 09:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbiKQOGo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 09:06:44 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBD074CEE
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 06:06:42 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gv23so5341181ejb.3
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 06:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tuhf/gzRiy7/Qa+Ls9XGZG0ZonJnJLPLrRIbiZRGQ/A=;
        b=XhObFQB8jGxtUnV1BlC5+u69syB56qYsD2cVoLwkcG7RSRUGO517ZDnBSxPaRBvpih
         D9iUgRN4/yWi1u3zMQen7eqnA9zrb+W3cVCe26fqpDP6AgJgXf9gkRwTdagMKxTPX9ID
         9AamLz58rMPvIi8XRI3zRM3qyhAck0NxOg1OQE9gRo+7E8b59g6LD3KCzFh1voAbtAL0
         9NL56+R/gChnGDX1DiaEeCMzrqy4IFSswDJpjIDT1TDtVp0s13u8y/qGJF5kb/mw7vR+
         RU8OLEVn4OEc4qkpfYD9LsycIjfuostktqFw5PR9UWi8csDvGEeNPr4oCs+cvIfxTjHU
         FDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tuhf/gzRiy7/Qa+Ls9XGZG0ZonJnJLPLrRIbiZRGQ/A=;
        b=6+ZkGwNNbwv88AZJ1XANhDdeOhqKz2zO30IieONAhKEFFMR8Z3sYZNKk6wcbdVuSQ2
         ebR3EaZJyxkOmYiwD27FOwplUvDsy/oCdtZJIVtm6o1U9Lga+tfVpKnVGP6nQ/66vZUh
         12pP0wmJCpg/L0bsJEZ7hVJcMyp/xxfwOzDvmn/H5rRDFj0QZvrug4xk39t4eRbbRiAS
         PfxQjMrvzO2oseoJLgPtEeHOXi21SpkSeONFs7yiJneiFGwq9ojqSEMRpAK81qwJqo+m
         JGnyuG1d579V+MixorRpeyKRIRqJMunIwiivweO2RpnV2/t9OuckK33k/blohBqshsx2
         8ZNw==
X-Gm-Message-State: ANoB5pkbJ5vJFTKVi3+G6ymnSCpbr6SwPK1O0uZz9a0jDoRrJUHRm9Ma
        lDR2sWVeI4pZ2AGi9nU8T58=
X-Google-Smtp-Source: AA0mqf6GR+WYYXWEXuZ9firHA3+CTcPLgnWL/6/F0gfZ7TOy7VKpxlEnn2Hc8O4tGknv5zBScMrmpA==
X-Received: by 2002:a17:906:ef1:b0:78d:260d:a6e4 with SMTP id x17-20020a1709060ef100b0078d260da6e4mr2218717eji.93.1668694000600;
        Thu, 17 Nov 2022 06:06:40 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id kv7-20020a17090778c700b007ad9028d684sm410622ejc.104.2022.11.17.06.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 06:06:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovfXL-004q3j-2h;
        Thu, 17 Nov 2022 15:06:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: [RFC PATCH 6/6] ls-tree: introduce '--pattern' option
Date:   Thu, 17 Nov 2022 15:03:11 +0100
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
 <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
Message-ID: <221117.867cztisk0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 17 2022, Teng Long wrote:

> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 03dd3fbcb26..576fc9ad16f 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -13,6 +13,7 @@
>  #include "builtin.h"
>  #include "parse-options.h"
>  #include "pathspec.h"
> +#include <stdio.h>

Aside from anything else I've mentionded (e.g. overall goals), don't
include "<>" headers in anything except git-compat-util.h and similar.

In this case we don't need this at all, but if we did it should be added
there...

> [...]
>  	}
> -	ret = regexec(&r, line, 1, m, 0);
> +
> +	ret = regexec(regex, line, 1, m, 0);

Some whitespace-churn after the last commit...

>  static void show_tree_common_default_long(struct show_tree_data *data)
>  {
>  	int base_len = data->base->len;
> +	struct strbuf sb = STRBUF_INIT;
> +	int sb_len = 0;

It's size_t, not int, so if you need to keep track of a strbuf's length
use the type of its "len".

This would be better named "oldlen" or something...

> +		printf("%s", sb.buf);

puts(sb.buf) instead;

> +	if (pattern && !strlen(pattern))

pattern && !*pattern is more idiomatic IMO.

> +test_expect_success 'combine with "--object-only"' '
> +	cat > expect <<-EOF &&

Style: No " " after ">"
> +		6da7993

Style: Let's avoid \t\t indenting for here-docs, just use the indenting
of the "cat".
