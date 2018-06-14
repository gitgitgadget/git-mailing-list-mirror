Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB831F403
	for <e@80x24.org>; Thu, 14 Jun 2018 20:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755072AbeFNUPB (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 16:15:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53723 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754806AbeFNUPA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 16:15:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id x6-v6so37733wmc.3
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fSYcJtLkL4XNl2gjCFOGNh4XavkcLNrXAi+EoC/HCDU=;
        b=daWn1h7iCIAp/apjzaxRfqOmht2UGF/+eAI+RWdKTgf3y7u0IuJ+2pHP3O6gT3tPvT
         H7hciZiRjEPBNa1ZIiNoONdeBR+rw+yjyA+1rg3vudHPhKTVUDwkj5/jJwQQeiVCdx7d
         h+qpt+z0ZV31HYalfk3oylhlWSnK9HN6ZV8/M9pAE+cOUzpKfIy4RiNP5axqq+mxYH/Q
         uTT/jDTorRD+qe+W3et77pP1X+hf0ZtE++ezaRCHsLX2oFJfsoslmZFNq2jCijpa5d+r
         dGhJECUJC5bJ1POcv5Ekw6keltStHKvW+aXV/CSr1fQ/B29wKAqR+25qUUKB36HvhDUb
         519w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fSYcJtLkL4XNl2gjCFOGNh4XavkcLNrXAi+EoC/HCDU=;
        b=JMJLJd8hgyWn7L86FPp5RTCB3nPYI0kV7oe+lmRf5OeYblTohgw8g3ndJC97hqyRv3
         UGe6i9iT7leY3w0D60Y5mK5v0JsGyL+2KQFo/vvucskgIm1t15a2YgvtBajRPli7ukJ7
         D7LdbgF6OYDAb29hxzpk6JbQTf57wjFfbSk/QFvDNb3ah2XNfC5JXyc+/aVJ4GQ2rH0r
         6zAZkr4lZ6kF7JnP1KYKcVb9AjTgeoNAMmwKbPUbnAnYMEDoMfyaMN7kFIV2KdvX5V8K
         ol8LLCmEV7OKArfA2DTOHGNuZI/L7yG4Qx1h3YK5ay+CLTa1Gzk14gjSKf0gO/PLT+rr
         648w==
X-Gm-Message-State: APt69E1RZMK/ZIBxAhwasrJ1ein0WvKV74uzqDRMPmwFTfygSh5Z5JQy
        bS6O0huGwHTPF7SOJuirto0=
X-Google-Smtp-Source: ADUXVKIXU5CC39BagPuSJp2gf5CFSdxIQ46yLiQIqbokGdGo8JElf8Ml0T7hGpEGTkqDJDc2X1SmCA==
X-Received: by 2002:a1c:b801:: with SMTP id i1-v6mr2836511wmf.30.1529007299110;
        Thu, 14 Jun 2018 13:14:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e81-v6sm2950wmi.28.2018.06.14.13.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 13:14:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v2 2/2] rebase--interactive: rewrite the edit-todo functionality in C
References: <20180611135714.29378-1-alban.gruin@gmail.com>
        <20180613152211.12580-1-alban.gruin@gmail.com>
        <20180613152211.12580-3-alban.gruin@gmail.com>
Date:   Thu, 14 Jun 2018 13:14:57 -0700
In-Reply-To: <20180613152211.12580-3-alban.gruin@gmail.com> (Alban Gruin's
        message of "Wed, 13 Jun 2018 17:22:11 +0200")
Message-ID: <xmqqlgbh2khq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index ded5e291d..d2990b210 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -12,12 +12,12 @@ static const char * const builtin_rebase_helper_usage[] = {
>  int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  {
>  	struct replay_opts opts = REPLAY_OPTS_INIT;
> -	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, write_edit_todo = 0;
> +	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;

Sorry, but where does "write_edit_todo = 0" in the preimage come from?
