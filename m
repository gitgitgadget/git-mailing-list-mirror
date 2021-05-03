Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1292BC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 16:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C665861185
	for <git@archiver.kernel.org>; Mon,  3 May 2021 16:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhECQLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 12:11:48 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:62368 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbhECQLq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 12:11:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id BDCA5AFC;
        Mon,  3 May 2021 18:10:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1620058251; x=1621872652; bh=jfF+aMJLW5pyD6OvRN7
        eLvm8qm5OhQVJJKxhvvaVUCU=; b=3WBsprZ9pDTx1AK5sDEcDn40rXpk0XIb6a8
        bhBwnTPYNV0pfMQY0Kle5HBfAcbMNuvak89chlaBwSvlpih2D0laevcyOd7zOeEB
        F+no+gHI5Q9hX6yaMV5/TLCxAzB6LtzqXIygrpbbE0Fcz2E51zFBfgo23DwTlSro
        wsKy/i87ipkzx5BfHeTHBBhTtEZhtXeL3RvyEeFt2xW30e7xQQvESBzVLkPSFboA
        G3yzLIqUIT8WaeZVbWx+iFMS8Q9r8xcNW/JHcHbCXt3qgD0Fn395+1BN/jivOIcp
        0CvRDxIaw04fWL9c+RLJZVjqD6S0BWBSoaeXC1h6ZQ0JilkcoEn39mKombMAJ2Jn
        1FIz8/zT4tWaQ/VCJhJkQZygCnVkmhf3WEU24/1qf3vni0MuoF6YJHsnxiO4axw1
        s9O41q8k/wemxutvc3/OPWvWgxOADCDDHLUyjRcZsuEutFU9qFc5IrDxHIy2D+gv
        gqC+9P2uH9YVZ2zsgXuF3uO7f7N8DRN1GZcdx0+hnM93K7IGu/9jrLyXGhlqr+nM
        i+ab85feS8CBeFv/3MQ1IMsEazesxgZDdHzG/vyAWc+FkYFfi8N57ix77x1kYm/I
        hN8dTSEc7gZPJ9JNcMBeAq9DQFRnc1QPzbl/LYok1uqCvOtA4PQP6S2KIQYnvd4M
        L4IZzEK0=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6WWs5RtXnS0g; Mon,  3 May 2021 18:10:51 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 08A3D628;
        Mon,  3 May 2021 18:10:50 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 7A540312;
        Mon,  3 May 2021 18:10:49 +0200 (CEST)
Subject: Re: [PATCH v4 3/8] for-each-repo: run subcommands on configured repos
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
 <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
 <dd9237927395ef69663ab376a2da74da4654c495.1602782524.git.gitgitgadget@gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <cda4f200-2400-e915-e995-36eea2a27c11@ahunt.org>
Date:   Mon, 3 May 2021 18:10:47 +0200
MIME-Version: 1.0
In-Reply-To: <dd9237927395ef69663ab376a2da74da4654c495.1602782524.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 15/10/2020 19:21, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
[... snip ...]
> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
> new file mode 100644
> index 0000000000..5bba623ff1
> --- /dev/null
> +++ b/builtin/for-each-repo.c
> @@ -0,0 +1,58 @@
> +#include "cache.h"
> +#include "config.h"
> +#include "builtin.h"
> +#include "parse-options.h"
> +#include "run-command.h"
> +#include "string-list.h"
> +
> +static const char * const for_each_repo_usage[] = {
> +	N_("git for-each-repo --config=<config> <command-args>"),
> +	NULL
> +};
> +
> +static int run_command_on_repo(const char *path,
> +			       void *cbdata)
> +{
> +	int i;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	struct strvec *args = (struct strvec *)cbdata;

I was curious there's a strong reason for declaring args as void * 
followed by this cast? The most obvious answer seems to be that this 
probably evolved from a callback - and we could simplify it now?
> +
> +	child.git_cmd = 1;
> +	strvec_pushl(&child.args, "-C", path, NULL);
> +
> +	for (i = 0; i < args->nr; i++)
> +		strvec_push(&child.args, args->v[i]);
So here we're copying all of args - and I don't see any way of avoiding 
it since we're adding it to child's arg list.

> +
> +	return run_command(&child);
> +}
> +
> +int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
> +{
> +	static const char *config_key = NULL;
> +	int i, result = 0;
> +	const struct string_list *values;
> +	struct strvec args = STRVEC_INIT;
> +
> +	const struct option options[] = {
> +		OPT_STRING(0, "config", &config_key, N_("config"),
> +			   N_("config key storing a list of repository paths")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, for_each_repo_usage,
> +			     PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +	if (!config_key)
> +		die(_("missing --config=<config>"));
> +
> +	for (i = 0; i < argc; i++)
> +		strvec_push(&args, argv[i]);

But why do we have to copy all of argv 1:1 into args here, only to later 
pass it to run_command_on_repo() which, as described above, copies the 
entire input again? I suspect this was done to comply with 
run_command_on_repo()'s API (which takes strvec) - does that seem 
plausible, or did I miss something?

Which brings me to the real reason for my questions: I noticed we "leak" 
args (this leak is of no significance since it happens in cmd_*, but 
LSAN still complains, and I'm trying to get tests running leak-free). My 
initial inclination was to strvec_clear() or UNLEAK() args - but if we 
can avoid creating args in the first place we also wouldn't need to 
clear it later.

My current proposal is therefore to completely remove args and pass 
argc+argv into run_command_on_repo() - but I wanted to be sure that I 
didn't miss some important reason to stick with the current approach.

> +
> +	values = repo_config_get_value_multi(the_repository,
> +					     config_key);
> +
> +	for (i = 0; !result && i < values->nr; i++)
> +		result = run_command_on_repo(values->items[i].string, &args);
> +
> +	return result;
> +}
[... snip ...]

(I hope this doesn't come across as useless necroposting - I figured it 
would be easier to clarify these questions on the original thread as 
opposed to potentially discussing it as part of my next leak-fixing 
series :) .)

ATB,

   Andrzej
