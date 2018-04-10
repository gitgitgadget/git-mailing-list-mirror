Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A06A1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 01:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeDJBoW (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 21:44:22 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:46881 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDJBoV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 21:44:21 -0400
Received: by mail-wr0-f170.google.com with SMTP id d1so11293698wrj.13
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 18:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bftln3V27Yx9ph1XmkLvnCyg/CMRzF3RrD+P1Cn92oA=;
        b=B1biSey8OG0XljdiD92PhtZHtgU5A2XoJSTgPQJA4UaiRtWoD979dc/KHUN/MARJGm
         uIhgDG/e3LtxA46i6YSmOhqvHzqF/AMHm+PJ+n8qNHCLtLWdYzsVLvATCXXnS7nOcdPR
         cMTJ0m8X6WwPSkNxwdCfuMezq6ikN1bjPvs1FZi6cO0SVayT0tNkZKqUipq75e5Xz0VS
         hl8neEWf/+yCajtcUey3tiiio+D9yaRaeOn48O5IkD//ZTy3Z8UWURcQdLFUrDUGbs+Q
         YCC7BuygUk9SPEteC81tGA8dLUE9xmq/xsw1WDl8ffpaKTRoAIWVsLaBpoAuOQTMJwZu
         L2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bftln3V27Yx9ph1XmkLvnCyg/CMRzF3RrD+P1Cn92oA=;
        b=sWQJE1MFSz41jxpFPqOycEUEkOyl+tjHjxs2k6loGzzf69dDt6yScgkEMsq4nrcZXy
         1QHfkTdq85ePAGP8ltkH533er2g15D9vZlf+0SIBiTQdJeW75BZpGVIgmpWV/Z4bhR2q
         lLnJ6VUKSh2Rbz1gvWYSWjXJ74QjF/oDpFNYP1D8h2YIYJ69yxjxugQxmdsbeG4BLB18
         ntS0ZunjxyK0YIYTRuIaD9s46egp44JK2glfjpvkg2xYJ/52z9ZfN1k9lW2PJFqZ6g2D
         6Tz4YW/r/aF7a/HVxXLEQoerUjASqT3VUkoiXQxVVMkB5uwo2d/M9vDUZW1mcABrTJWu
         O8ZA==
X-Gm-Message-State: AElRT7HghvhlB2cSwGP0TbaLMaAx/0CsFrOWluw3I9c7TSLB3zQbO6fq
        Ep8iY50cAzuhEJvQclMAjzk=
X-Google-Smtp-Source: AIpwx4/mzpXkypTUhwrxlD9j2i7cP3Rzvgnka4d/Mt2yqWfQKLVPHB7InmsMY02p1Ywjs4ht3NPIeg==
X-Received: by 10.223.225.198 with SMTP id l6mr28711461wri.111.1523324660066;
        Mon, 09 Apr 2018 18:44:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l41sm2893516wrl.2.2018.04.09.18.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 18:44:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, ericsunshine@sunshineco.com
Subject: Re: [PATCH v7 2/2] builtin/config.c: support `--type=<type>` as preferred alias for `--type`
References: <20180328234719.595-1-me@ttaylorr.com>
        <cover.1523313730.git.me@ttaylorr.com>
        <20180409224657.GC34547@syl.local>
Date:   Tue, 10 Apr 2018 10:44:18 +0900
In-Reply-To: <20180409224657.GC34547@syl.local> (Taylor Blau's message of
        "Mon, 9 Apr 2018 15:46:57 -0700")
Message-ID: <xmqqsh834yz1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> `git config` has long allowed the ability for callers to provide a 'type
> specifier', which instructs `git config` to (1) ensure that incoming
> values are satisfiable under that type, and (2) that outgoing values are
> canonicalized under that type.

Hmm, "satisfiable" is not the first word that comes to my mind to
describe "when you give me a string 'frotz', we cannot take it as an
integer".  s/are satisfiable under/can be interpreted as/ perhaps?

> In another series, we propose to extend this functionality with
> `--type=color` and `--default` to replace `--get-color`.
>
> However, we traditionally use `--color` to mean "colorize this output",
> instead of "this value should be treated as a color".

Makes sense.

> Currently, `git config` does not support this kind of colorization, but
> we should be careful to avoid inhabiting this option too soon, so that
> `git config` can support `--type=color` (in the traditional sense) in
> the future, if that is desired.

Shouldn't the above `--color` instead?  That is, we avoid squatting
on `--color` because we might later want to use it in the
traditional way.  Also my reading stuttered around "inhabiting".  It
might be just me, but perhaps s/inhabiting/squating on/?

> In this patch, we support `--type=<int|bool|bool-or-int|...>` in
> addition to `--int`, `--bool`, and etc. This allows the aforementioned
> upcoming patch to support querying a color value with a default via
> `--type=color --default=...`, without squandering `--color`.

Good.

> @@ -160,30 +158,39 @@ See also <<FILES>>.
>  --list::
>  	List all variables set in config file, along with their values.
>  
> ---bool::
> -	'git config' will ensure that the output is "true" or "false"
> +--type <type>::
> +  'git config' will ensure that any input or output is valid under the given
> +  type constraint(s), and will canonicalize outgoing values in `<type>`'s
> +  canonical form.
> ++
> +Valid `<type>`'s include:
> ++
> +- 'bool': canonicalize values as either "true" or "false".
> +- 'int': canonicalize values as simple decimal numbers. An optional suffix of
> +  'k', 'm', or 'g' will cause the value to be multiplied by 1024, 1048576, or
> +  1073741824 prior to output.

It is not a new problem introduced by this patch, but these place
too much weight on the output side and may end up giving a flawed
mental model to the readers, I am afraid.

It's not like an 'int' value internally is "2k" and shown it as 2048
when output.  In reality, we internalize it 2048 upon input and we
do not do anything special when showing, no?  A 'bool' value given
with a string 'no' internally becomes 0 upon input and is shown as
'false' upon output.

I suspect s/prior to output/upon input/ may alleviate the issue
quite a bit.
