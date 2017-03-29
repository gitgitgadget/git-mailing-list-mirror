Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53F720958
	for <e@80x24.org>; Wed, 29 Mar 2017 18:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbdC2SpZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 14:45:25 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34247 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbdC2SpW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 14:45:22 -0400
Received: by mail-pg0-f67.google.com with SMTP id o123so3910566pga.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TlvQ84b2ZnNrDYlmznbjxhhZ/rdczH/cx1B1kfANx9w=;
        b=cAlg6nTAm5Hh4t9vuSeay1y9sGHSL0Fzhr/i/nnW75IMBSLpSqbfMOvDO7jgZZZkGC
         OwtGLEyW/JjEFCAE1iC/lFiy2weeias66YrFyb4VDWRbDNF31UOgOAYAdDJMYZnnzoD+
         4Ji5pZ1Y7N5VpACOwBbPuAZ0LVXGESHcXGh1Qjnz0SgcLvEm2vhEXlweH0U9o/ruixK+
         TmXAAetlaadrEz15lBQUR4MlZEeguAbSEBY90oW+PlZi+EQsL8NdNz68LnbXP4UqGvOb
         LVfg21khAsgaE2T5uXm5fNsAaOr6Uub6HUr8Mkk6KPXoUs1l/TK0LLM5BvDMbVeWVzN3
         xZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TlvQ84b2ZnNrDYlmznbjxhhZ/rdczH/cx1B1kfANx9w=;
        b=AvXYYdmT7TTQigYjcpPW62oNupMJBF/Zb6amgAWL9gf/Qh07CqG05yXDULfvyuy4r3
         853630AcQPBa7ufyqklBfEBCU6ujqpqKdmDJYH5qBYG7IJgGf6xjDnkHcleEna3LIHfp
         lDhddmeosxOIK17zRblghpM9l1Vj6tTwQNeDHKrK7iHtcBkYuwGYT7270eULAj9XWdkG
         XKe16EBod4cmn/DXgqaCXvD3K/ycN61HOpTSapQIArl6X+YJMEC4QnaDskDRt7FxPziT
         2CooyUi56hxRUIUbP8bBXlJZnR1IKrK4RwqTzjj2Zic5L5tniWI8DFF81Rb1l6/wGkVx
         fQrQ==
X-Gm-Message-State: AFeK/H3Swrp0K2QADe0w4rQ7BvREixtvGxc6co4yTvQV+8D7VdZUTo2v3BTAFmwKGZeIYg==
X-Received: by 10.84.238.203 with SMTP id l11mr2322430pln.74.1490813121395;
        Wed, 29 Mar 2017 11:45:21 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:1cae:64a4:6d7e:ad6f])
        by smtp.gmail.com with ESMTPSA id z185sm14972632pfb.6.2017.03.29.11.45.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 11:45:20 -0700 (PDT)
Date:   Wed, 29 Mar 2017 11:45:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 1/2] entry.c: submodule recursing: respect force flag
 correctly
Message-ID: <20170329184519.GW31294@aiede.mtv.corp.google.com>
References: <20170329183743.27506-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170329183743.27506-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> In case of a non-forced worktree update, the submodule movement is tested
> in a dry run first, such that it doesn't matter if the actual update is
> done via the force flag. However for correctness, we want to give the
> flag is specified by the user.

"for correctness" means "to avoid races"?

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  entry.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/entry.c b/entry.c
> index d2b512da90..645121f828 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -287,7 +287,7 @@ int checkout_entry(struct cache_entry *ce,
>  			} else
>  				return submodule_move_head(ce->name,
>  					"HEAD", oid_to_hex(&ce->oid),
> -					SUBMODULE_MOVE_HEAD_FORCE);
> +					state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);

Looks like a good change.

This moves past the 80-column margin.  I wish there were a tool like
gofmt or clang-format that would take care of formatting for us.

This isn't the only place SUBMODULE_MOVE_HEAD_FORCE is used in the
file.  Do they need the same treatment?

Thanks,
Jonathan
