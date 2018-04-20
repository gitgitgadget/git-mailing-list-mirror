Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7AAB1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 16:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeDTQ7P (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 12:59:15 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41295 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeDTQ7O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 12:59:14 -0400
Received: by mail-wr0-f193.google.com with SMTP id v24-v6so24676474wra.8
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eQIsrjYZS9aIVAx7o3Mf3XdidtBkqyqZfXJFYrA27oQ=;
        b=atpOd1hRj9nSvQe9I1YQn+nrl73bJcfW/xQYlLmbHw1+0o9AOu7KCXDK+kEgQ/XBGg
         S/JpY+bIahM3YlmWnkRA5dVdQMGBZ1hOxyLX0J4qgH3Qm3M6aejCsnlEBu4SrXUkOoPm
         8XkG/cU8NuUvEyldHuefS0PEu4VXEHnQ85pAKnRwWIE5yZyFGyO/+LHgCZa9/x0FAKcF
         5eiUF3EiwMjKFM/5B4xpHRLIRNlx7ehaAa2p+y0LNqtBBsNfFVq1RRjykV4ziZtYnI6+
         sGdKE9dt7YQ1c10GKAtuNQ6xHT9c1EsGqMXKak2F+KAb4+xy86UPAjHRi2NzxWZlPjD/
         EfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=eQIsrjYZS9aIVAx7o3Mf3XdidtBkqyqZfXJFYrA27oQ=;
        b=QerYzp9tAFkyiczr4hxax0uURLyBt0HaTr82+Qc5B8UcRMrNpekKNPRqnwMEzRQ8/5
         WgY8qBIdR8bToPQ1YqItkGjq1vSDVaibZt+zi280mTEaUtGdWTd8aiwuwJ3U0LAl0rTY
         4xbaXG0DIdlSyz2OQyJWnc2liwuc4WCYud5S5rqn8I9V/HvM+QWPbKjfKRt4bpqMw50D
         P6qOmOkAMZ4sW82orvdMmcYGebsXIh4YH0JUUA55/lpkHZfFPoBw6Yl3Wc2tVCo1wFY0
         uMmGwJyL9J31GBmW34I93Xs+QmfE8TA6BH/8+/HvKQbrq78ctPyoeVRvsd+/WcjQALEN
         Vqrg==
X-Gm-Message-State: ALQs6tBT4+bYwIpg9PK4doTrMv+Y/JKq7du25sxrDInHWvkaKqimVErP
        /GvGxJZmiQGYE2GZ57hqsK8=
X-Google-Smtp-Source: AIpwx49l7eZYKZxnFJ2kiKFHEqAA6jjXYTCvxAPKByJ9kNpJfa2r0mC6K78EZanB+/9ZFpc5vGlRig==
X-Received: by 10.28.235.3 with SMTP id j3mr2592335wmh.146.1524243553502;
        Fri, 20 Apr 2018 09:59:13 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id u187sm1471835wmu.46.2018.04.20.09.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 09:59:12 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 09/12] fsck: check commit-graph
References: <20180417181028.198397-1-dstolee@microsoft.com>
        <20180417181028.198397-10-dstolee@microsoft.com>
Date:   Fri, 20 Apr 2018 18:59:12 +0200
In-Reply-To: <20180417181028.198397-10-dstolee@microsoft.com> (Derrick
        Stolee's message of "Tue, 17 Apr 2018 18:10:44 +0000")
Message-ID: <86bmedervj.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> If a commit-graph file exists, check its contents during 'git fsck'.

Is it "if a commit-graph file exists", or is it core.commitGraph feature
is turned on?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/fsck.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index ef78c6c00c..9712f230ba 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -16,6 +16,7 @@
>  #include "streaming.h"
>  #include "decorate.h"
>  #include "packfile.h"
> +#include "run-command.h"

Couln't this be done internally, without run-command?  Or is it just
preliminary implementation?

>  
>  #define REACHABLE 0x0001
>  #define SEEN      0x0002
> @@ -45,6 +46,7 @@ static int name_objects;
>  #define ERROR_REACHABLE 02
>  #define ERROR_PACK 04
>  #define ERROR_REFS 010
> +#define ERROR_COMMIT_GRAPH 020

I see that these error status codes are not documented anywhere.  Still,
I would expect at least mentioning commit-graph in the git-fsck manpage.

>  
>  static const char *describe_object(struct object *obj)
>  {
> @@ -815,5 +817,16 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	check_connectivity();
> +
> +	if (core_commit_graph) {
> +		struct child_process commit_graph_check = CHILD_PROCESS_INIT;
> +		const char *check_argv[] = { "commit-graph", "check", NULL, NULL };
> +		commit_graph_check.argv = check_argv;
> +		commit_graph_check.git_cmd = 1;
> +
> +		if (run_command(&commit_graph_check))
> +			errors_found |= ERROR_COMMIT_GRAPH;
> +	}
> +
>  	return errors_found;
>  }
