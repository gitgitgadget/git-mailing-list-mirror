Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5296DC433E2
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F9FE20672
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyod1SqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgGOSdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgGOSdw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 14:33:52 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D75C061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 11:33:51 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g20so2363455edm.4
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FW+/ZxmYoCvGe5mnuycT/61j0dKxSB92w9KDp8ofCh0=;
        b=eyod1SqSEWq7MWLVgmScTQpZhABn4qycfLmwRQJudRZrdX3oY1k3fsaFy/Rp4vCtyq
         uZn3gW7juihWMThYF0U1glKS3fa6PdpCvBssP9M9jWDtqYf2dPvXRZNIdI3vJGaDvPii
         AhnnjvishrFYfANbNC4HEVR2CDQTcKn8uAL1or//VqgPshtbI1Jeqjaudp75WEv2VHZf
         QOY4BvQtLfPb9pr8FfeGFzK/EbSLf1plU/yldwptOuSCpIYAvxTlJPGDuGkw6kN66c6D
         2FQYkISVSQeG1LpvxUt35HbR04cdV4T1YNxVnl1wjHn+Fg0XONzD5xdltQsEqkPbt1QV
         yh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FW+/ZxmYoCvGe5mnuycT/61j0dKxSB92w9KDp8ofCh0=;
        b=mfLxMMSdHWEwpuoR/wQhc2Vp0KzlcGUuGccWU4n/3v4WnGIEm0PUTngsDxdwkfUp4C
         PufwDyNHnCNeIaiRyVnr4i7Z/lM4HgWPqWVbHN1UlzMQ06j0yx5tpHqE0Ue7FUwdLqmC
         y4VA6yazqOz5MQihXtTfA1qRXvOd+uXB/1mxwPjtfafD0h9S8g9PHiuZA3b/nnLoucmb
         fC9hGDoKbnPfKT1YJ/ni1GEZVfNjc1ly0r4rxllhLGVXsHADzd22RiTh7BvLQInEQH25
         Ak0cE5Z8yUGT5AtQ+vS8OduxG8dVnbIpHTxRe0hfxY3ocQ6BJk95oyDnYUoSgcaYUMYy
         sCaw==
X-Gm-Message-State: AOAM533RM/q0CuAGaA7USxUSqQI38HuVJqTt07eG4aFdOALFxNxNHvpS
        lSIofJWypOPW8/iCSvI6StU=
X-Google-Smtp-Source: ABdhPJxONHz15fAWdzQIbauCMsaeuIPrunuYd8ONMz1n/IkYY8AtpccMukFZPXpAWwu9WcmUQcYQKQ==
X-Received: by 2002:aa7:da8d:: with SMTP id q13mr914485eds.339.1594838030265;
        Wed, 15 Jul 2020 11:33:50 -0700 (PDT)
Received: from szeder.dev (78-131-17-71.pool.digikabel.hu. [78.131.17.71])
        by smtp.gmail.com with ESMTPSA id x19sm2821564eds.43.2020.07.15.11.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 11:33:49 -0700 (PDT)
Date:   Wed, 15 Jul 2020 20:33:47 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, dstolee@microsoft.com,
        peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: fix "Collecting commits from input"
 progress line
Message-ID: <20200715183347.GH11341@szeder.dev>
References: <56403dd377b996d21a4da1e01ffd6e691ac120bd.1589407014.git.me@ttaylorr.com>
 <20200710190238.16376-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200710190238.16376-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

it looks like this patch hasn't been picked up, but it fixes a minor
bug introduced in this release cycle.


On Fri, Jul 10, 2020 at 09:02:38PM +0200, SZEDER Gábor wrote:
> To display a progress line while reading commits from standard input
> and looking them up, 5b6653e523 (builtin/commit-graph.c: dereference
> tags in builtin, 2020-05-13) should have added a pair of
> start_delayed_progress() and stop_progress() calls around the loop
> reading stdin.  Alas, the stop_progress() call ended up at the wrong
> place, after write_commit_graph(), which does all the commit-graph
> computation and writing, and has several progress lines of its own.
> Consequintly, that new
> 
>   Collecting commits from input: 1234
> 
> progress line is overwritten by the first progress line shown by
> write_commit_graph(), and its final "done" line is shown last, after
> everything is finished:
> 
>   $ { sleep 3 ; git rev-list -3 HEAD ; sleep 1 ; } | ~/src/git/git commit-graph write --stdin-commits
>   Expanding reachable commits in commit graph: 873402, done.
>   Writing out commit graph in 4 passes: 100% (3493608/3493608), done.
>   Collecting commits from input: 3, done.
> 
> Furthermore, that stop_progress() call was added after the 'cleanup'
> label, where that loop reading stdin jumps in case of an error.  In
> case of invalid input this then results in the "done" line shown after
> the error message:
> 
>   $ { sleep 3 ; git rev-list -3 HEAD ; echo junk ; } | ~/src/git/git commit-graph write --stdin-commits
>   error: unexpected non-hex object ID: junk
>   Collecting commits from input: 3, done.
> 
> Move that stop_progress() call to the right place.
> 
> While at it, drop the unnecessary 'if (progress)' condition protecting
> the stop_progress() call, because that function is prepared to handle
> a NULL progress struct.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  builtin/commit-graph.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 75455da138..796954da60 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -251,7 +251,7 @@ static int graph_write(int argc, const char **argv)
>  			}
>  		}
>  
> -
> +		stop_progress(&progress);
>  	}
>  
>  	if (write_commit_graph(odb,
> @@ -264,8 +264,6 @@ static int graph_write(int argc, const char **argv)
>  cleanup:
>  	string_list_clear(&pack_indexes, 0);
>  	strbuf_release(&buf);
> -	if (progress)
> -		stop_progress(&progress);
>  	return result;
>  }
>  
> -- 
> 2.27.0.547.g4ba2d26563
> 
