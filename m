Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A24901F597
	for <e@80x24.org>; Wed, 25 Jul 2018 20:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbeGYWGt (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 18:06:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46474 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730643AbeGYWGt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 18:06:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so8608800wrw.13
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 13:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4jGylAV++GgnAyYLUe52UGwAGgJDFtGzvy3M2DtErcU=;
        b=aRFT3e7WOh3xjQXlj/0OIqiqmTYVOiLENFkUdbivlhKPGZt+cAEh0dVxuI9L0gZ5Zu
         kyZ/IYigh2Z+XU0jtr9kUkBfFcsZATCPd304001nDC8q3qjMD7ClW5R8CVA1OL7F+vLL
         hyAC3S8tA2606wRMi945z+tqyjlQlXZ7WplFpiKp6LfELo+/3kg1EiTKcvEpcX/U3z2i
         fQ0sXauCco0KDXDMEhWNzBhGnIufVaCpUKWVrYSoKA+oPuv/imhT7bpW0CtNAySo+mgF
         I9JX14HCBN03DVlb3LPCGKQIuyr+7xtSh9TWrqGmROQQeqOcDCyuGpQW4fSNHmQb/Kj8
         tAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4jGylAV++GgnAyYLUe52UGwAGgJDFtGzvy3M2DtErcU=;
        b=YkIi+mvESd+khLdUgJ9eZCHzEZlm95PFM6d5cYBkVlFZgAgxSz5mdfWuTGMu8+fr+H
         w+jvs34YcblJf07hKpJWCWFwt9f10Sdezav5Fz5kNCbzkuw0ZrKArq3kY3d/UmLA/3Pi
         dOKPsXM35VhinbcnPPsj4HcvXswszonwvDOpVYeinmPUu6IGpn7hUdDt69TZM1ebYPw5
         RROBh2ifz1EUKJZ4ZwxNjdy1nX7ue0+OLMfy/X7UPVBes3CuYh2ZtKcLExSnNW1jiiBh
         7GhHcvnJsO1ZRHNSF2ja8JV3jnrZh2d5inxYMj5OA0mejsT3iEQtYriWN7pOCKOkK6s/
         Y+PQ==
X-Gm-Message-State: AOUpUlEVVz3Q1zaeJl7EbcSHpKFU2DtucTEbhRlpEq65PUL8c7rEskDa
        h/4UxyuxdJ6y2mQMbJcqFu8=
X-Google-Smtp-Source: AAOMgpflj+Qv80T7U8rj6aUeecxDuwMDwiBcrK0UvMsLq0e3H6D6xDUF+QNU1hODvs41CyEpHTBGvQ==
X-Received: by 2002:adf:be0f:: with SMTP id n15-v6mr16273691wrh.267.1532552002909;
        Wed, 25 Jul 2018 13:53:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w8-v6sm15369337wrp.72.2018.07.25.13.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 13:53:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 11/14] format-patch: extend --range-diff to accept revision range
References: <20180722095717.17912-1-sunshine@sunshineco.com>
        <20180722095717.17912-12-sunshine@sunshineco.com>
Date:   Wed, 25 Jul 2018 13:53:20 -0700
In-Reply-To: <20180722095717.17912-12-sunshine@sunshineco.com> (Eric
        Sunshine's message of "Sun, 22 Jul 2018 05:57:14 -0400")
Message-ID: <xmqqva93t4u7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> When submitting a revised a patch series, the --range-diff option embeds
> a range-diff in the cover letter showing changes since the previous
> version of the patch series. The argument to --range-diff is a simple
> revision naming the tip of the previous series, which works fine if the
> previous and current versions of the patch series share a common base.
>
> However, it fails if the revision ranges of the old and new versions of
> the series are disjoint. To address this shortcoming, extend
> --range-diff to also accept an explicit revision range for the previous
> series. For example:
>
>     git format-patch --cover-letter --range-diff=v1~3..v1 -3 v2
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---

Makes sense.  Even though a single "common rev" would serve as a
feature to discourage rebasing done "just to catch up" without a
good reason, it is a good idea to give an escape hatch like this
to support a case where rebasing is the right thing to do.

>  static void infer_range_diff_ranges(struct strbuf *r1,
>  				    struct strbuf *r2,
>  				    const char *prev,
> +				    struct commit *origin,
>  				    struct commit *head)
>  {
>  	const char *head_oid = oid_to_hex(&head->object.oid);
>  
> -	strbuf_addf(r1, "%s..%s", head_oid, prev);
> -	strbuf_addf(r2, "%s..%s", prev, head_oid);

I thought "git range-diff" also took the three-dot notation as a
short-hand but there is no point using that in this application,
which wants the RHS and the LHS range in separate output variables.

> +	if (!strstr(prev, "..")) {
> +		strbuf_addf(r1, "%s..%s", head_oid, prev);
> +		strbuf_addf(r2, "%s..%s", prev, head_oid);
> +	} else if (!origin) {
> +		die(_("failed to infer range-diff ranges"));
> +	} else {
> +		strbuf_addstr(r1, prev);
> +		strbuf_addf(r2, "%s..%s",
> +			    oid_to_hex(&origin->object.oid), head_oid);

Interesting.

I actually would feel better to see the second range for the normal
case to be computed exactly the same way, i.e.

	int prev_is_range = strstr(prev, "..");

	if (prev_is_range)
		strbuf_addstr(r1, prev);
	else
		strbuf_addf(r1, "%s..%s", head_oid, prev);

	if (origin)
		strbuf_addf(r2, "%s..%s", oid_to_hex(&origin->object.oid, head_oid);
	else if (prev_is_range)
		die("cannot figure out the origin of new series");
	else {
		warning("falling back to use '%s' as the origin of new series",	prev);
		strbuf_addf(r2, "%s..%s", prev, head_oid);
	}

because origin..HEAD is always the set of the "new" series, no
matter what "prev" the user chooses to compare that series against,
when there is a single "origin".
